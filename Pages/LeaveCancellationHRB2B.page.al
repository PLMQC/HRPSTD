page 33001392 "Leave Cancellation HR B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Cancellation HR';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Posted Leave App Line B2B";
    SourceTableView = WHERE("Processed Status" = FILTER(<> Cancelled),
                            "Pending For Cancellation" = FILTER(true));
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
                    ToolTip = 'Specify the leave application no in general';
                }
            }
            repeater(Subform)
            {
                Caption = 'Subform';
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
                    ToolTip = 'Specify the Employee no';
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
                    ToolTip = 'Specify the Employee user id';
                }
                field(Cancel; Cancel)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave cancel details';
                }
                field("Processed Status"; "Processed Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave processed status';
                }
                field("Pending For Cancellation"; "Pending For Cancellation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave pending for cancellation';
                }
                field("Pending for HOD cancelation"; "Pending for HOD cancelation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave pending for HOD cancelation';
                }
                field("Pending for MD cancelation"; "Pending for MD cancelation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave pending for MD cancelation';
                }
                field("Pending for HR cancelation"; "Pending for HR cancelation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave pending for HR cancelation';
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
        area(processing)
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
                    ToolTip = 'Specify the leave application post details';
                    trigger OnAction();
                    begin
                        PostedLeaveAppLine.RESET();
                        PostedLeaveAppLine.SETRANGE(Cancel, true);
                        if not PostedLeaveAppLine.FINDFIRST() then
                            ERROR(Text002Lbl);

                        LeavePlan.RESET();
                        LeavePlan.SETRANGE(LeavePlan."Leave Application No.", "Document No.");
                        LeavePlan.SETRANGE(Cancel, true);
                        if not LeavePlan.FINDFIRST() then
                            ERROR(Text003Lbl);

                        if CONFIRM(Text000Lbl, true) then
                            CancelLeaves();

                    end;
                }
            }
        }
        area(navigation)
        {
            action("Leave &Plan")
            {
                Caption = 'Leave &Plan';
                Image = Planning;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;
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

    trigger OnInit();
    begin
        "Genaral TabVisible" := true;
    end;

    trigger OnOpenPage();
    begin
        PayrollApprovalSetup.RESET();
        PayrollApprovalSetup.SETRANGE("HR Approver", USERID());
        if not PayrollApprovalSetup.FINDFIRST() then
            ERROR(Text001Lbl);

        "Genaral TabVisible" := false;
        UpdateLeaveAppLines();
    end;

    var
        Employee: Record "Employee B2B";
        LeavePlan: Record "Leave Plan B2B";
        ResourceHierarchy: Record "Resource Hierarchy B2B";
        ResourceHierarchy2: Record "Resource Hierarchy B2B";
        PostedLeaveAppLine: Record "Posted Leave App Line B2B";
        PayrollApprovalSetup: Record "Leave  Approval Setup B2B";
        Text000Lbl: Label 'Do you want to cancel leaves?';
        Check: Boolean;
        Index: Integer;
        Position: Integer;
        UserArray: array[100] of Text[50];
        UserNames: Text[1024];
        LeaveApplicationNo: Code[20];

        CancelledLeaves: Decimal;
        [InDataSet]
        "Genaral TabVisible": Boolean;
        Text001Lbl: Label 'You dont have permission to open this form';
        Text002Lbl: Label 'Please Select atlease one leave for Cancellation';
        Text003Lbl: Label 'Please Select atlease one leave for Cancellation in the Leave Plan';
        Text004Lbl: Label 'Cancellation';

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
                if PostedLeaveApp."Pending for HR cancelation" then begin
                    PayrollApprovalSetup.RESET();
                    PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveCancelation);
                    PayrollApprovalSetup.SETRANGE("HR Approver", USERID());
                    if PayrollApprovalSetup.FINDFIRST() then
                        LeavesCancelled(PostedLeaveApp)
                    else
                        LeavesCancelled(PostedLeaveApp);
                end;
            until PostedLeaveApp.NEXT() = 0;

    end;

    procedure LeavesCancelled(PostedLeaveApp: Record "Posted Leave App Line B2B");
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

        PostedLeaveApp.Cancel := false;
        PostedLeaveApp.MODIFY();
    end;

    procedure SentForApproval(PostedLeaveApp: Record "Posted Leave App Line B2B");
    begin
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
                    UserArray[Position] := ResourceNames."To User ID";
                    UserNames := CopyStr(UserNames + ResourceNames."To User ID" + '|', 1, 1024);
                end;
                GetResources(CopyStr(ResourceNames."To User ID", 1, 50));
            until ResourceNames.NEXT() = 0;
    end;

    procedure ResourceValidations();
    begin
        Employee.SETRANGE("User Id", USERID());
        if Employee.FINDFIRST() then;
        ResourceHierarchy.RESET();
        ResourceHierarchy.SETRANGE("To User ID", USERID());
        if ResourceHierarchy.FINDFIRST() then begin
            ResourceHierarchy2.RESET();
            ResourceHierarchy2.SETRANGE("From User ID", USERID());
            if ResourceHierarchy2.FINDFIRST() then begin
                SETFILTER("Employee No.", '<> %1', Employee."No.");
                SETRANGE("Pending For Cancellation", false);
            end else
                SETRANGE("Pending For Cancellation", false);

        end;
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
            PayrollApprovalSetup.SETRANGE("HR Approver", USERID());
            if PayrollApprovalSetup.FINDFIRST() then begin
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
        PostedLeaveApp.RESET();
        PostedLeaveApp.SETRANGE(Cancel, true);
        PostedLeaveApp.SETFILTER("Employee User ID", UserNames);
        if PostedLeaveApp.FINDFIRST() then begin
            LeavePlan.RESET();
            LeavePlan.SETRANGE("Leave Application No.", PostedLeaveApp."Document No.");
            LeavePlan.SETRANGE("Leave Code", PostedLeaveApp."Leave Code");
            LeavePlan.SETRANGE("Employee No", PostedLeaveApp."Employee No.");
            LeavePlan.SETRANGE(Cancel, true);
            if LeavePlan.FINDFIRST() then
                repeat
                    DailyAttendance.RESET();
                    DailyAttendance.SETRANGE("Leave Application No.", LeavePlan."Leave Application No.");
                    DailyAttendance.SETRANGE("Employee No.", LeavePlan."Employee No");
                    DailyAttendance.SETRANGE("Leave Code", LeavePlan."Leave Code");
                    DailyAttendance.SETRANGE(Date, LeavePlan."Leave Date");
                    if DailyAttendance.FINDFIRST() then
                        repeat
                            DailyAttendance."Leave Application No." := '';
                            DailyAttendance."Leave Code" := '';
                            DailyAttendance.Leave := 0;
                            DailyAttendance.Present := 1;
                            DailyAttendance.Absent := 0;
                            DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Present;
                            if LeavePlan."Session Time" = 0 then
                                DailyAttendance."Halfday Status" := DailyAttendance."Halfday Status"::" "
                            else
                                DailyAttendance."Halfday Status" := 1;
                            DailyAttendance.MODIFY();
                        until DailyAttendance.NEXT() = 0;
                until LeavePlan.NEXT() = 0;

        end;
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
        LeavePlan.SETRANGE("Leave Application No.", "Document No.");
        LeavePlan.SETRANGE(Cancel, true);
        if LeavePlan.FINDFIRST() then
            repeat
                DetailLeaves.INIT();
                DetailLeaves."Entry No." := LineNum;
                DetailLeaves."Employee No." := PostedLeaveAppRec."Employee No.";
                DetailLeaves."Leave Code" := PostedLeaveAppRec."Leave Code";
                DetailLeaves."Leave Description" := Text004Lbl;
                DetailLeaves."Entry Type" := DetailLeaves."Entry Type"::Correction;
                DetailLeaves."Entry Date" := LeavePlan."Leave Date";
                DetailLeaves."Leave Pay Cadre" := Employee."Pay Cadre";
                DetailLeaves."Leave Application No." := PostedLeaveAppLine."Document No.";
                DetailLeaves."No. of Leaves" := CancelledLeavesPar;
                DetailLeaves."Posting Date" := LeavePlan."Leave Date";
                DetailLeaves.Month := PostedLeaveAppRec.Month;
                DetailLeaves.Year := PostedLeaveAppRec.Year;
                Evaluate(DetailLeaves."Approved By", USERID());
                DetailLeaves.INSERT();
                LineNum += 1;
            until LeavePlan.NEXT() = 0;
    end;
}

