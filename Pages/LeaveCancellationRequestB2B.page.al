page 33001391 "Leave Cancellation Request B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Cancellation Request';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Posted Leave App Line B2B";
    SourceTableView = WHERE(Approve = CONST(true));
    UsageCategory = Tasks;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group("Genaral Tab")
            {
                Caption = 'General';
                field("Leave Application No"; LeaveApplicationNo)
                {
                    Caption = 'Leave Application No.';
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave application no in general';
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
                                        ERROR(Text002Lbl);
                                    LeaveApplicationNo := PostedLeaveAppHeader."Document No.";
                                end;
                            end;
                            UpdateLeaveAppLines();
                        end;
                    end;
                }
            }
            repeater(Control1102154000)
            {
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the document no details';
                }
                field("Employee No."; "Employee No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee No';
                }
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave code details';
                }
                field("Leave Duration"; "Leave Duration")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave duration details';
                }
                field("From Date"; "From Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave from date details';
                }
                field("To Date"; "To Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave to date details';
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the reason for leave details';
                }
                field("Employee User ID"; "Employee User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee user id details';
                }
                field(Cancel; Cancel)
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave cancel details';
                }
                field(Approve; Approve)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave approval details';
                }
                field("Processed Status"; "Processed Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the processed status details';
                }
                field("Pending For Cancellation"; "Pending For Cancellation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave pending for cancellation';
                }
            }
            part(Control1102152000; "Posted Leave Plan2 B2B")
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
        area(processing)
        {
            group("P&ost")
            {
                Caption = 'P&ost';
                Image = Post;
                action("<Action1102154021>")
                {
                    Caption = 'Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave post details';
                    trigger OnAction();
                    begin
                        if not Approve then
                            ERROR(Text003Lbl, "Document No.")
                        else
                            if CONFIRM(Text000Lbl, true) then begin
                                HRSetupGRec.GET();
                                if not (HRSetupGRec."Activate Leave Approvals") then
                                    AutoCanceLeaves()
                                else
                                    CancelLeaves();
                            end;

                    end;
                }
            }
            action("Leave &Plan")
            {
                Caption = 'Leave &Plan';
                Image = Planning;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = all;
                ToolTip = 'Specify the leave and plan details';
                trigger OnAction();
                begin
                    LeavePlan.RESET();
                    LeavePlan.SETRANGE("Leave Application No.", "Document No.");
                    LeavePlan.SETRANGE("Employee No", "Employee No.");
                    LeavePlan.SETFILTER("Approved Status", '<>%1', LeavePlan."Approved Status"::" ");
                    if LeavePlan.FINDFIRST() then
                        PAGE.RUN(33001317, LeavePlan)
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        PayrollApprovalSetup.RESET();
        PayrollApprovalSetup.SETRANGE(User, USERID());
        if not PayrollApprovalSetup.FINDFIRST() then
            ERROR(Text001Lbl);


        UpdateLeaveAppLines();
    end;

    var

        Employee: Record "Employee B2B";
        LeavePlan: Record "Leave Plan B2B";
        PostedLeaveAppHeader: Record "Posted Leave App Header B2B";
        LookUpGRec: Record Lookup_B2B;
        PostedLeaveAppLine: Record "Posted Leave App Line B2B";
        PayrollApprovalSetup: Record "Leave  Approval Setup B2B";
        PayrollLoc: Record "Payroll Locations B2B";
        HRSetupGRec: Record "HR Setup B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Check: Boolean;
        Index: Integer;
        Position: Integer;
        UserArray: array[100] of Text[50];
        Text000Lbl: Label 'Do you want to cancel leaves?';
        UserNames: Text[1024];
        LeaveApplicationNo: Code[20];
        CancelledLeaves: Decimal;
        Text001Lbl: Label 'You dont have permission to open this form';
        Text002Lbl: Label 'There are No Leave Application Lines to cancel';
        Text003Lbl: Label 'The leave application %1 is not yet approved, you can Cancel only Approved Leaves', Comment = '%1 = Doc No';
        Text004Lbl: Label 'Sent for approval';
        Text005Lbl: Label 'Cancellation';

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
                PayrollApprovalSetup.RESET();
                PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
                PayrollApprovalSetup.SETRANGE(Department, Employee."Department Code");
                PayrollApprovalSetup.SETRANGE(User, USERID());
                if PayrollApprovalSetup.FINDFIRST() then
                    SentForApproval(PostedLeaveApp);

            until PostedLeaveApp.NEXT() = 0;

        PostedLeaveApp.RESET();
        PostedLeaveApp.SETRANGE(Cancel, true);
        PostedLeaveApp.SETRANGE("Processed Status", PostedLeaveApp."Processed Status"::" ");
        if PostedLeaveApp.FINDFIRST() then
            repeat
                LeavesCancelled(PostedLeaveApp);
            until PostedLeaveApp.NEXT() = 0;
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

    procedure SentForApproval(PostedLeaveApp: Record "Posted Leave App Line B2B");
    begin
        PostedLeaveApp."Pending For Cancellation" := true;
        PostedLeaveApp.Cancel := false;
        PostedLeaveApp."Set For Approval" := false;
        PayrollApprovalSetup.RESET();
        PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
        PayrollApprovalSetup.SETRANGE(Department, Employee."Department Code");
        PayrollApprovalSetup.SETRANGE(User, USERID());
        if PayrollApprovalSetup.FINDFIRST() then
            if PayrollApprovalSetup.HOD <> '' then begin
                PostedLeaveApp."Pending for HOD cancelation" := true;
                PostedLeaveApp.Approver := PayrollApprovalSetup.HOD;
                MESSAGE(Text004Lbl);
            end else
                if PayrollApprovalSetup."Additional Approver" <> '' then begin
                    PostedLeaveApp."Pending for MD cancelation" := true;
                    PostedLeaveApp.Approver := PayrollApprovalSetup."Additional Approver";
                    MESSAGE(Text004Lbl);
                end else
                    if PayrollApprovalSetup."HR Approver" <> '' then begin
                        PostedLeaveApp."Pending for HR cancelation" := true;
                        PostedLeaveApp.Approver := PayrollApprovalSetup."HR Approver";
                        MESSAGE(Text004Lbl);
                    end else
                        LeavesCancelled(PostedLeaveApp);


        PostedLeaveApp.MODIFY();
        CurrPage.UPDATE();
        exit;
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
            if ModifiedLeaves <> 0 then
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
                end
            else
                if ModifiedLeaves = 0 then
                    exit;

    end;

    procedure GetResources(FromUserID: Code[50]);
    var
        ResourceNames: Record "Resource Hierarchy B2B";
    begin
        Check := true;
        ResourceNames.RESET();
        ResourceNames.SETRANGE("From User ID", FromUserID);
        ResourceNames.SETFILTER("To User ID", '<>%1', FromUserID);
        if ResourceNames.FINDFIRST() then
            repeat
                Check := true;
                for Index := 1 to Position do
                    if (UserArray[Index] = ResourceNames."To User ID") then
                        Check := false;

                if Check then begin
                    Position += 1;
                    UserArray[Position] := CopyStr(ResourceNames."To User ID", 1, 50);
                    UserNames := CopyStr(UserNames + ResourceNames."To User ID" + '|', 1, 1024);
                end;
                GetResources(CopyStr(ResourceNames."To User ID", 1, 50));
            until ResourceNames.NEXT() = 0;
    end;

    procedure UpdateLeaveAppLines();
    begin
        if LeaveApplicationNo <> '' then begin
            RESET();
            SETFILTER("Processed Status", '<>%1', 2);
            SETRANGE("Document No.", LeaveApplicationNo);
            SETRANGE("Pending for HOD cancelation", false);
            SETRANGE("Pending for MD cancelation", false);
            SETRANGE("Pending for HR cancelation", false);
            //SETRANGE(Status, Status::Approved);
            CurrPage.UPDATE();
        end else begin
            if PayrollLoc.FINDFIRST() then;
            if USERID() = PayrollLoc."Location Incharge" then begin
                Employee.RESET();
                Employee.SETRANGE("User Id", USERID());
                if Employee.FINDFIRST() then begin
                    RESET();
                    SETFILTER("Processed Status", '<>%1', "Processed Status"::Cancelled);
                    SETRANGE("Document No.");
                    SETRANGE("Pending for HOD cancelation", false);
                    SETRANGE("Pending for MD cancelation", false);
                    SETRANGE("Pending for HR cancelation", false);
                    SETRANGE(Status, Status::Approved);
                end;
            end else begin
                Employee.RESET();
                Employee.SETRANGE("User Id", USERID());
                if Employee.FINDFIRST() then begin
                    RESET();
                    SETFILTER("Processed Status", '<>%1', "Processed Status"::Cancelled);
                    SETRANGE("Department Code", Employee."Department Code");
                    SETRANGE("Document No.");
                    SETRANGE("Pending for HOD cancelation", false);
                    SETRANGE("Pending for MD cancelation", false);
                    SETRANGE("Pending for HR cancelation", false);
                    SETRANGE(Status, Status::Approved);
                end;
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
        DetailLeaves."Leave Description" := Text005Lbl;
        DetailLeaves."Entry Type" := DetailLeaves."Entry Type"::Entitlement;
        DetailLeaves."Entry Date" := workdate();
        DetailLeaves."Leave Pay Cadre" := Employee."Leave Pay Cadre";
        DetailLeaves."No. of Leaves" := CancelledLeavesPar;
        DetailLeaves."Posting Date" := workdate();
        DetailLeaves.Month := HRSetup."Salary Processing month";
        DetailLeaves.Year := HRSetup."Salary Processing Year";
        Evaluate(DetailLeaves."Approved By", USERID());
        DetailLeaves.INSERT();
    end;

    procedure AutoCanceLeaves();
    var
        PostedLeaveApp: Record "Posted Leave App Line B2B";
    begin
        PostedLeaveApp.RESET();
        PostedLeaveApp.SETRANGE(Cancel, true);
        PostedLeaveApp.SETRANGE("Employee User ID", USERID());
        PostedLeaveApp.SETRANGE("Processed Status", PostedLeaveApp."Processed Status"::Posted);
        PostedLeaveApp.SETRANGE("Document No.", LeaveApplicationNo);
        if PostedLeaveApp.FINDFIRST() then
            repeat
                LeavesCancelled(PostedLeaveApp);
            until PostedLeaveApp.NEXT() = 0;

        PostedLeaveApp.RESET();
        PostedLeaveApp.SETRANGE(Cancel, true);
        PostedLeaveApp.SETRANGE("Employee User ID", USERID());
        PostedLeaveApp.SETRANGE("Processed Status", PostedLeaveApp."Processed Status"::" ");
        if PostedLeaveApp.FINDFIRST() then
            repeat
                LeavesCancelled(PostedLeaveApp);
            until PostedLeaveApp.NEXT() = 0;
    end;
}

