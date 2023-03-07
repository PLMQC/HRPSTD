page 33001514 "Leave Cancellation All B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Cancellations';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Posted Leave App Line B2B";
    SourceTableView = WHERE("Processed Status" = FILTER(<> Cancelled));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group("Genaral Tab")
            {
                Caption = 'General';
                Visible = "Genaral TabVisible";

                field("Leave Application No"; LeaveApplicationNo)
                {
                    Caption = 'Leave Application No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave application no';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Employee.RESET();
                        Employee.SETRANGE("User Id", USERID());
                        if Employee.FINDFIRST() then begin
                            LookUpGRec.RESET();
                            LookUpGRec.SETFILTER("Lookup Type", '%1', 4);
                            LookUpGRec.SETRANGE("Lookup Name", Employee."Department Code");
                            if LookUpGRec.FINDFIRST() then begin
                                PostedLeaveAppHeader.RESET();
                                PostedLeaveAppHeader.SETRANGE("Department Code", Employee."Department Code");
                                FILTERGROUP(2);
                                PostedLeaveAppHeader.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                                FILTERGROUP(0);
                                if PAGE.RUNMODAL(0, PostedLeaveAppHeader) = ACTION::LookupOK then begin
                                    PostedLeaveAppLine.SETRANGE("Document No.", PostedLeaveAppHeader."Document No.");
                                    PostedLeaveAppLine.SETFILTER("Processed Status", '<>%1', PostedLeaveAppLine."Processed Status"::Cancelled);
                                    if not PostedLeaveAppLine.FINDFIRST() then
                                        ERROR(Text001Lbl);
                                    LeaveApplicationNo := PostedLeaveAppHeader."Document No.";
                                end;
                            end;
                            UpdateLeaveAppLines();
                        end;
                    end;
                }
            }
            repeater(Subform)
            {
                Caption = 'Subform';
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The document no';
                }
                field("Employee No."; "Employee No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee no';
                }
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave code';
                }
                field("Leave Duration"; "Leave Duration")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave duration';
                }
                field("From Date"; "From Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The from date';
                }
                field("To Date"; "To Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The To date';
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Reason for leave';
                }
                field("Employee User ID"; "Employee User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Employee user id';
                }
                field(Cancel; Cancel)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The cancel';
                }
                field("Processed Status"; "Processed Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Processed status';
                }
                field("Pending For Cancellation"; "Pending For Cancellation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The pending for cancellation';
                }
                field("Pending for HOD cancelation"; "Pending for HOD cancelation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Pending for hod cancellation';
                }
                field("Pending for MD cancelation"; "Pending for MD cancelation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The pending for md cancellation';
                }
                field("Pending for HR cancelation"; "Pending for HR cancelation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The pending for hr cancellation';
                }
            }
            part(Control1102152006; "Posted Leave Plan2 B2B")
            {
                SubPageLink = "Employee No" = FIELD("Employee No."),
                              "Leave Code" = FIELD("Leave Code"),
                              "Leave Application No." = FIELD("Document No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("P&ost")
            {
                Caption = 'P&ost';
                Image = Post;
                action(Post)
                {
                    Caption = 'Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Post';
                    trigger OnAction();
                    begin
                        if CONFIRM(Text000Lbl, true) then
                            CancelLeaves();

                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        IsAnApprover := false;

        PayrollApprovalSetup.RESET();
        PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
        if PayrollApprovalSetup.FINDFIRST() then begin
            repeat
                if ((PayrollApprovalSetup."Additional Approver" = UPPERCASE(USERID())) or
                        (PayrollApprovalSetup.HOD = UPPERCASE(USERID())) or
                        (PayrollApprovalSetup."HR Approver" = UPPERCASE(USERID()))) then
                    IsAnApprover := true
                else
                    IsAnApprover := false;
            until (PayrollApprovalSetup.NEXT() = 0) or (IsAnApprover);
            if not IsAnApprover then
                ERROR(Text002Lbl);
        end;

        "Genaral TabVisible" := false;
        SETRANGE("Pending For Cancellation", true);
        SETRANGE(Approver, UPPERCASE(USERID()));
    end;

    var

        Employee: Record "Employee B2B";
        LookUpGRec: Record Lookup_B2B;
        PostedLeaveAppLine: Record "Posted Leave App Line B2B";
        PayrollApprovalSetup: Record "Leave  Approval Setup B2B";
        PostedLeaveAppHeader: Record "Posted Leave App Header B2B";
        LeavePlan: Record "Leave Plan B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text000Lbl: Label 'Do you want to cancel leaves?';
        LeaveApplicationNo: Code[20];

        CancelledLeaves: Decimal;

        [InDataSet]
        "Genaral TabVisible": Boolean;
        IsAnApprover: Boolean;
        Text001Lbl: Label 'There are No Leave Application Lines to cancel';
        Text002Lbl: Label 'You dont have permission to open this form';
        Text003Lbl: Label 'Please Select atlease one leave for Cancellation';
        Text004Lbl: Label 'Please Select atlease one leave for Cancellation in the Leave Plan';
        Text005Lbl: Label 'HOD User ID required';
        Text006Lbl: Label 'MD User ID required''';
        Text33001Lbl: Label 'Cancellation';

    procedure CancelLeaves();
    var
        PostedLeaveApp: Record "Posted Leave App Line B2B";
    begin
        Employee.RESET();
        Employee.SETRANGE("User Id", USERID());
        if Employee.FINDFIRST() then;
        PostedLeaveApp.RESET();
        PostedLeaveApp.SETRANGE(Cancel, true);
        PostedLeaveApp.SETRANGE("Processed Status", PostedLeaveApp."Processed Status"::Posted);
        if PostedLeaveApp.FINDFIRST() then
            repeat
                if PostedLeaveApp."Pending for HOD cancelation" then begin
                    PayrollApprovalSetup.RESET();
                    PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
                    PayrollApprovalSetup.SETRANGE(Department, PostedLeaveApp."Department Code");
                    PayrollApprovalSetup.SETRANGE(HOD, USERID());
                    if PayrollApprovalSetup.FINDFIRST() then
                        SentForApproval(PostedLeaveApp)
                    else begin
                        MESSAGE(Text005Lbl);
                        LeavesCancelled(PostedLeaveApp);
                    end;
                end else
                    if PostedLeaveApp."Pending for MD cancelation" then begin
                        PayrollApprovalSetup.RESET();
                        PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
                        PayrollApprovalSetup.SETRANGE(Department, PostedLeaveApp."Department Code");
                        PayrollApprovalSetup.SETRANGE("Additional Approver", USERID());
                        if PayrollApprovalSetup.FINDFIRST() then
                            SentForApproval(PostedLeaveApp)
                        else
                            MESSAGE(Text006Lbl);

                    end else
                        if PostedLeaveApp."Pending for HR cancelation" then
                            CancelLeaveFinalApprover();

            until PostedLeaveApp.NEXT() = 0;

    end;

    procedure SentForApproval(PostedLeaveApp: Record "Posted Leave App Line B2B");
    begin
        PostedLeaveApp."Pending For Cancellation" := true;
        PostedLeaveApp.Cancel := false;
        PostedLeaveApp."Set For Approval" := false;
        if PostedLeaveApp."Pending for HOD cancelation" then begin
            PayrollApprovalSetup.RESET();
            PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
            PayrollApprovalSetup.SETRANGE(Department, PostedLeaveApp."Department Code");
            PayrollApprovalSetup.SETRANGE(HOD, USERID());
            if PayrollApprovalSetup.FINDFIRST() then
                if PayrollApprovalSetup."Additional Approver" = '' then begin
                    PostedLeaveApp."Pending for HR cancelation" := true;
                    PostedLeaveApp."Pending for HOD cancelation" := false;
                    PostedLeaveApp.Approver := PayrollApprovalSetup."HR Approver";
                end else begin
                    PostedLeaveApp."Pending for MD cancelation" := true;
                    PostedLeaveApp."Pending for HOD cancelation" := false;
                    PostedLeaveApp.Approver := PayrollApprovalSetup."Additional Approver";
                end;


            PostedLeaveApp.MODIFY();
            CurrPage.UPDATE();
            exit;
        end else
            if PostedLeaveApp."Pending for MD cancelation" then begin
                PayrollApprovalSetup.RESET();
                PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
                PayrollApprovalSetup.SETRANGE(Department, PostedLeaveApp."Department Code");
                PayrollApprovalSetup.SETRANGE("Additional Approver", USERID());
                if PayrollApprovalSetup.FINDFIRST() then begin
                    PostedLeaveApp."Pending for HR cancelation" := true;
                    PostedLeaveApp."Pending for MD cancelation" := false;
                    PostedLeaveApp.Approver := PayrollApprovalSetup."HR Approver";
                end;
                PostedLeaveApp.MODIFY();
                CurrPage.UPDATE();
                exit;
            end;
    end;

    procedure LeavesCancelled(PostedLeaveApp: Record "Posted Leave App Line B2B");
    begin
        Evaluate(PostedLeaveApp."Processed By", USERID());
        PostedLeaveApp."Processed Date" := workdate();
        PostedLeaveApp."Processed Status" := PostedLeaveApp."Processed Status"::Cancelled;
        PostedLeaveApp."Pending for HR cancelation" := false;
        PostedLeaveApp."Set For Approval" := false;
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", PostedLeaveApp."Document No.");
        LeavePlan.SETRANGE("Leave Code", PostedLeaveApp."Leave Code");
        LeavePlan.SETRANGE("Employee No", PostedLeaveApp."Employee No.");
        if LeavePlan.FINDFIRST() then
            repeat
                if LeavePlan."Leave Type" = LeavePlan."Leave Type"::Leave then
                    CancelledLeaves += 1;
                LeavePlan."Posted Status" := LeavePlan."Posted Status"::Cancelled;
                LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0;
        UpdateProLeaves1(PostedLeaveApp);
        UdpateDailyAttendance(PostedLeaveApp);
        UpdateDetailedLeaves(PostedLeaveApp, CancelledLeaves);
        PostedLeaveApp.Cancel := false;
        PostedLeaveApp.MODIFY();
    end;

    procedure UpdateProLeaves1(PostedLeaveAppRec: Record "Posted Leave App Line B2B");
    var
        ProvLeaves: Record "Provisional Leaves B2B";
        ModifiedLeaves: Decimal;
    begin
        ModifiedLeaves := PostedLeaveAppRec."No.of Days";
        ProvLeaves.RESET();
        ProvLeaves.SETRANGE("Employee No.", PostedLeaveAppRec."Employee No.");
        ProvLeaves.SETRANGE("Leave Code", PostedLeaveAppRec."Leave Code");
        ProvLeaves.SETFILTER(ProvLeaves."Applied Leaves", '<>%1', 0);
        ProvLeaves.SETFILTER("Leave Year Start Date", '<=%1', PostedLeaveAppRec."From Date");
        ProvLeaves.SETFILTER("Leave Year End Date", '>=%1', PostedLeaveAppRec."To Date");
        if ProvLeaves.FINDLAST() then
            if ModifiedLeaves <> 0 then begin
                if ProvLeaves."Applied Leaves" <= ModifiedLeaves then begin
                    ProvLeaves."Remaining Leaves" := ProvLeaves."Remaining Leaves" + ProvLeaves."Applied Leaves";
                    ModifiedLeaves := ModifiedLeaves - ProvLeaves."Applied Leaves";
                    ProvLeaves."Applied Leaves" := 0;
                    ProvLeaves.MODIFY();
                end else begin
                    ProvLeaves."Applied Leaves" := ProvLeaves."Applied Leaves" - ModifiedLeaves;
                    ProvLeaves."Remaining Leaves" := ProvLeaves."No.of Leaves" - ProvLeaves."Applied Leaves";
                    ModifiedLeaves := 0;
                    ProvLeaves.MODIFY();
                end;
            end else
                if ModifiedLeaves = 0 then
                    exit;

    end;

    procedure GetResources(FromUserID: Code[20]);
    var
    begin
    end;

    procedure UpdateLeaveAppLines();
    begin
        if LeaveApplicationNo <> '' then begin
            RESET();
            SETFILTER("Processed Status", '<>%1', 2);
            SETRANGE("Document No.", LeaveApplicationNo);
            CurrPage.UPDATE();
        end else begin
            PayrollApprovalSetup.RESET();
            PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
            if PayrollApprovalSetup.FINDFIRST() then
                if PayrollApprovalSetup.HOD = USERID() then begin
                    RESET();
                    SETFILTER("Processed Status", '<>%1', "Processed Status"::Cancelled);
                    SETRANGE("Pending for HOD cancelation", true);
                end else
                    if PayrollApprovalSetup."Additional Approver" = USERID() then begin
                        RESET();
                        SETFILTER("Processed Status", '<>%1', "Processed Status"::Cancelled);
                        SETRANGE("Pending for MD cancelation", false);
                    end else
                        if PayrollApprovalSetup."HR Approver" = USERID() then begin
                            RESET();
                            SETFILTER("Processed Status", '<>%1', "Processed Status"::Cancelled);
                            SETRANGE("Pending for HR cancelation", true);
                        end;

        end;
    end;

    procedure UdpateDailyAttendance(PostedLeaveApp: Record "Posted Leave App Line B2B");
    var
        DailyAttendance: Record "Daily Attendance B2B";
    begin
        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Leave Application No.", PostedLeaveApp."Document No.");
        DailyAttendance.SETRANGE("Employee No.", PostedLeaveApp."Employee No.");
        DailyAttendance.SETRANGE("Leave Code", PostedLeaveApp."Leave Code");
        if DailyAttendance.FINDFIRST() then
            repeat
                DailyAttendance."Leave Application No." := '';
                DailyAttendance."Leave Code" := '';
                DailyAttendance.Leave := 0;
                DailyAttendance.Present := 1;
                DailyAttendance.Absent := 0;
                DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Present;
                DailyAttendance."Halfday Status" := DailyAttendance."Halfday Status"::" ";
                DailyAttendance.MODIFY();
            until DailyAttendance.NEXT() = 0;
    end;

    procedure UpdateDetailedLeaves(PostedLeaveAppRec: Record "Posted Leave App Line B2B"; CancelledLeavesPar: Decimal);
    var
        TempDetailLeaves: Record "Detailed Leave Records B2B";
        DetailLeaves: Record "Detailed Leave Records B2B";
        HRSetup: Record "HR Setup B2B";
        LineNum: Integer;
    begin
        TempDetailLeaves.RESET();
        if TempDetailLeaves.FINDLAST() then
            LineNum := TempDetailLeaves."Entry No." + 1
        else
            LineNum := 1;


        Employee.GET(PostedLeaveAppRec."Employee No.");
        HRSetup.GET();

        DetailLeaves.INIT();
        DetailLeaves."Entry No." := LineNum;
        DetailLeaves."Employee No." := PostedLeaveAppRec."Employee No.";
        DetailLeaves."Leave Code" := PostedLeaveAppRec."Leave Code";
        DetailLeaves."Leave Description" := Text33001Lbl;
        DetailLeaves."Entry Type" := DetailLeaves."Entry Type"::Entitlement;
        DetailLeaves."Entry Date" := workdate();
        DetailLeaves."Leave Pay Cadre" := Employee."Pay Cadre";
        DetailLeaves."No. of Leaves" := CancelledLeavesPar;
        DetailLeaves."Posting Date" := workdate();
        DetailLeaves.Month := HRSetup."Salary Processing month";
        DetailLeaves.Year := HRSetup."Salary Processing Year";
        Evaluate(DetailLeaves."Approved By", USERID());
        DetailLeaves.INSERT();
    end;

    procedure CancelLeaveFinalApprover();
    begin
        PostedLeaveAppLine.RESET();
        PostedLeaveAppLine.SETRANGE(Cancel, true);
        if not PostedLeaveAppLine.FINDFIRST() then
            ERROR(Text003Lbl);

        LeavePlan.RESET();
        LeavePlan.SETRANGE(LeavePlan."Leave Application No.", "Document No.");
        LeavePlan.SETRANGE(Cancel, true);
        if LeavePlan.IsEmpty() then
            ERROR(Text004Lbl);
        CancelLeavesFinalIN();
    end;

    procedure CancelLeavesFinalIN();
    var
        PostedLeaveApp: Record "Posted Leave App Line B2B";
    begin
        Employee.RESET();
        Employee.SETRANGE("User Id", USERID());
        if Employee.FINDFIRST() then;
        PostedLeaveApp.RESET();
        PostedLeaveApp.SETRANGE(Cancel, true);
        PostedLeaveApp.SETRANGE("Processed Status", PostedLeaveApp."Processed Status"::Posted);
        if PostedLeaveApp.FINDFIRST() then
            repeat
                if PostedLeaveApp."Pending for HR cancelation" then begin
                    PayrollApprovalSetup.RESET();
                    PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
                    PayrollApprovalSetup.SETRANGE("HR Approver", USERID());
                    if PayrollApprovalSetup.FINDFIRST() then
                        LeavesCancelledHR(PostedLeaveApp)
                    else
                        LeavesCancelledHR(PostedLeaveApp);

                end;
            until PostedLeaveApp.NEXT() = 0;

    end;

    procedure LeavesCancelledHR(PostedLeaveApp: Record "Posted Leave App Line B2B");
    begin
        Evaluate(PostedLeaveApp."Processed By", USERID());
        PostedLeaveApp."Processed Date" := workdate();
        PostedLeaveApp."Processed Status" := PostedLeaveApp."Processed Status"::Cancelled;
        PostedLeaveApp."Pending for HR cancelation" := false;
        PostedLeaveApp."Set For Approval" := false;
        CancelledLeaves := 0;
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", PostedLeaveApp."Document No.");
        LeavePlan.SETRANGE("Leave Code", PostedLeaveApp."Leave Code");
        LeavePlan.SETRANGE("Employee No", PostedLeaveApp."Employee No.");
        LeavePlan.SETRANGE(Cancel, true);
        if LeavePlan.FINDFIRST() then
            repeat
                if LeavePlan."Leave Type" = LeavePlan."Leave Type"::Leave then
                    if LeavePlan."Leave Duration" = LeavePlan."Leave Duration"::"Half Day" then
                        CancelledLeaves += 0.5
                    else
                        CancelledLeaves := 1;
                LeavePlan."Posted Status" := LeavePlan."Posted Status"::Cancelled;
                LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0;


        UpdateProLeaves1(PostedLeaveApp);
        UdpateDailyAttendance(PostedLeaveApp);
        UpdateDetailedLeaves(PostedLeaveApp, CancelledLeaves);
        PostedLeaveApp.Approver := '';
        PostedLeaveApp.Cancel := false;
        PostedLeaveApp.MODIFY();
    end;
}

