
page 33001378 "Leave Application B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Application';
    PageType = Document;
    SourceTable = "Leave Application Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the document no details';

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee No';

                    trigger OnValidate();
                    begin
                        EmployeeNoOnAfterValidate();
                    end;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the application date';
                }
            }
            part(LeaveAppLin1e; "Leave Application subform B2B")
            {
                Caption = 'LeaveAppLine';
                SubPageLink = "Document No." = FIELD("Document No.");
                ApplicationArea = all;

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Leave Application")
            {
                Caption = '&Leave Application';
                Image = ApplicationWorksheet;
                action("Leave &Plan")
                {
                    Caption = 'Leave &Plan';
                    Image = Planning;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave plan details';

                    trigger OnAction();
                    begin
                        OpenLeavePlan();
                    end;
                }
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';
                    Image = Approvals;
                    ApplicationArea = all;
                    ToolTip = 'Specify the approvals detail';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Leave Application Header B2B", 0, "Document No.");
                        ApprovalEntries.RUN();
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Create Leave &Plan")
                {
                    Caption = 'Create Leave &Plan';
                    Image = CalculatePlan;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the create leave plan details';

                    trigger OnAction();
                    begin
                        CreateLeavePlan();
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                action("Leave Application")
                {
                    Caption = 'Leave Application';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave application details';

                    trigger OnAction();
                    begin
                        LAHeaderRec.RESET();
                        LAHeaderRec.SETRANGE("Document No.", "Document No.");
                        REPORT.RUNMODAL(REPORT::"Leave Application B2B", true, false, LAHeaderRec);
                    end;
                }
            }
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
                    ToolTip = 'Specify the post';

                    trigger OnAction();
                    var
                        HRSetup: Record "HR Setup B2B";
                        LeaveApprovalSetup: Record 33001299;
                        LeaveApprSetupErr: Label 'Leave Approval Setup not found as Approval are in Active';
                    begin
                        if Employee.GET("Employee No.") then;
                        HRSetup.GET();
                        if HRSetup."Activate Leave Approvals" then begin
                            LeaveApprovalSetup.RESET();
                            LeaveApprovalSetup.SETRANGE("Document Type", LeaveApprovalSetup."Document Type"::"LeaveApplication");
                            LeaveApprovalSetup.SETRANGE(Department, Employee."Department Code");
                            LeaveApprovalSetup.SETRANGE(User, USERID());
                            if LeaveApprovalSetup.isempty() then
                                ERROR(LeaveApprSetupErr);
                        end;
                        LeaveAppLine.RESET();
                        LeaveAppLine.SETRANGE("Document No.", "Document No.");
                        if LeaveAppLine.FINDFIRST() then begin
                            PayAppSetup.RESET();
                            PayAppSetup.SETRANGE("Document Type", PayAppSetup."Document Type"::LeaveApplication);
                            PayAppSetup.SETRANGE(User, USERID());
                            PayAppSetup.SETRANGE(Department, Employee."Department Code");
                            if PayAppSetup.FINDFIRST() then
                                PayAppSetup2.RESET();
                            PayAppSetup2.SETRANGE("Document Type", PayAppSetup."Document Type");
                            PayAppSetup2.SETRANGE(Department, PayAppSetup.Department);
                            PayAppSetup2.SETRANGE("Line No.", PayAppSetup."Line No.");
                            if PayAppSetup2.FINDFIRST() then begin
                                if PayAppSetup2.HOD <> '' then
                                    LeaveAppLine.Approver := PayAppSetup2.HOD
                                else
                                    LeaveAppLine.Approver := PayAppSetup2."Additional Approver";
                                LeaveAppLine.MODIFY();
                            end;
                        end;
                        PostLeaves();
                    end;
                }
            }
            // group("Request Approval")
            // {
            //     CaptionML = ENU = 'Request Approval',
            //                 ENN = 'Request Approval';
            //     Image = SendApprovalRequest;
            //     action(SendApprovalRequest)
            //     {
            //         CaptionML = ENU = 'Send A&pproval Request',
            //                     ENN = 'Send A&pproval Request';
            //         Enabled = NOT OpenApprovalEntriesExist;
            //         Image = SendApprovalRequest;
            //         Promoted = true;

            //         PromotedCategory = Process;
            //         ApplicationArea = all;
            //         ToolTip = 'Specify the send approval request details';

            //         trigger OnAction();
            //         begin
            //             /*if ApprovalsMgmt.CheckLeaveApprovalsWorkflowEnabled(Rec) then
            //                 ApprovalsMgmt.OnSendLeaveDocForApproval(Rec);*/
            //         end;
            //     }
            //     action(CancelApprovalRequest)
            //     {
            //         CaptionML = ENU = 'Cancel Approval Re&quest',
            //                     ENN = 'Cancel Approval Re&quest';
            //         Enabled = OpenApprovalEntriesExist;
            //         Image = Cancel;
            //         Promoted = true;

            //         PromotedCategory = Process;
            //         ApplicationArea = all;
            //         ToolTip = 'Specify the cancel approval request details';

            //         trigger OnAction();
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             /*ApprovalsMgmt.OnCancelLeaveApprovalRequest(Rec);*/
            //         end;
            //     }
            // }
            group(Approval)
            {
                Caption = 'Approval';
                // action(Approve)
                // {
                //     CaptionML = ENU = 'Approve',
                //                 ENN = 'Approve';
                //     Image = Approve;
                //     Promoted = true;

                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                //     Visible = OpenApprovalEntriesExistForCurrUser;
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the approval details';

                //     trigger OnAction();
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                //     end;
                // }
                // action(Reject)
                // {
                //     CaptionML = ENU = 'Reject',
                //                 ENN = 'Reject';
                //     Image = Reject;
                //     Promoted = true;                
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                //     Visible = OpenApprovalEntriesExistForCurrUser;
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the reject details';

                //     trigger OnAction();
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                //     end;
                // }
                // action(Delegate)
                // {
                //     CaptionML = ENU = 'Delegate',
                //                 ENN = 'Delegate';
                //     Image = Delegate;
                //     Promoted = true;

                //     PromotedCategory = Category4;
                //     Visible = OpenApprovalEntriesExistForCurrUser;
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the delegate details';

                //     trigger OnAction();
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                //     end;
                // }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = CONST(33001305),
                                  "Document No." = FIELD("Document No.");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = all;
                    ToolTip = 'Specify the comments detail';
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //SetControlsVisibility;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Application Date" := workdate();
    end;

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);

        UserNames := UserNames + USERID() + Text007Lbl;

        if UserNames <> '' then
            UserNames := Copystr(COPYSTR(UserNames, 1, STRLEN(UserNames) - 1), 1, 1024)
        else
            UserNames := Text006Lbl;

        FILTERGROUP(0);
    end;

    var
        TempUser: Record User temporary;
        ProcessedSalGRec: Record "Processed Salary B2B";
        Employee: Record "Employee B2B";
        PayAppSetup2: Record "Leave  Approval Setup B2B";
        LeaveAppLine: Record "Leave Application Line B2B";
        PayAppSetup: Record "Leave  Approval Setup B2B";
        LAHeaderRec: Record "Leave Application Header B2B";
        LeaveApprFormGVar: Page "Leave Approvals All B2B";
        UserNames: Text[1024];
        Text001Lbl: Label 'Session time should not be blank for the line %1.', Comment = '%1 = Line No';
        Dept: Code[30];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        Text004Lbl: Label 'Salary already posted for this employee';
        Text005Lbl: Label 'Do you want to post the leaves?';
        Text006Lbl: Label '$$$$$';
        Text007Lbl: Label '|';

    procedure PostLeaves();
    var
        LeaveApplicationLine: Record "Leave Application Line B2B";
        PostLeaveAppHeader: Record "Posted Leave App Header B2B";
        PostLeaveAppLine: Record "Posted Leave App Line B2B";
        HRSetupLrec: Record "HR Setup B2B";
        PrevLeaveCode: Code[20];
    begin
        CLEAR(UserNames);
        if UserNames <> '' then
            UserNames := CopyStr(COPYSTR(UserNames, 1, STRLEN(UserNames) - 1), 1, 1024);

        CLEAR(Dept);
        Employee.RESET();
        Employee.SETRANGE("No.", "Employee No.");
        if Employee.FINDFIRST() then
            Dept := Employee."Department Code";

        LeaveApplicationLine.RESET();
        LeaveApplicationLine.SETCURRENTKEY("Document No.", "Leave Code");
        LeaveApplicationLine.SETRANGE("Document No.", "Document No.");
        LeaveApplicationLine.SETFILTER("Employee User ID", UserNames);
        if LeaveApplicationLine.FINDFIRST() then
            repeat
                LeaveApplicationLine.Month := DATE2DMY(LeaveApplicationLine."From Date", 2);
                LeaveApplicationLine.Year := DATE2DMY(LeaveApplicationLine."From Date", 3);

                ProcessedSalGRec.RESET();
                ProcessedSalGRec.SETRANGE("Employee Code", LeaveApplicationLine."Employee No.");
                ProcessedSalGRec.SETRANGE("Pay Slip Month", LeaveApplicationLine.Month);
                ProcessedSalGRec.SETRANGE(Year, LeaveApplicationLine.Year);
                ProcessedSalGRec.SETRANGE(Posted, true);
                if ProcessedSalGRec.FINDFIRST() then
                    ERROR(Text004Lbl);
            until LeaveApplicationLine.NEXT() = 0;

        LeaveApplicationLine.RESET();
        LeaveApplicationLine.SETCURRENTKEY("Document No.", "Leave Code");
        LeaveApplicationLine.SETRANGE("Document No.", "Document No.");
        LeaveApplicationLine.SETFILTER("Employee User ID", UserNames);
        if LeaveApplicationLine.FINDFIRST() then
            if CONFIRM(Text005Lbl) then begin
                PostLeaveAppHeader.INIT();
                PostLeaveAppHeader.TRANSFERFIELDS(Rec);
                Evaluate(PostLeaveAppHeader."Posted By", USERID());
                repeat
                    LeaveApplicationLine.TESTFIELD("Reason for Leave");
                    LeaveApplicationLine.CheckPlanning(LeaveApplicationLine);
                    if PrevLeaveCode <> LeaveApplicationLine."Leave Code" then
                        LeaveApplicationLine.CheckLeavePlan(LeaveApplicationLine);

                    PostLeaveAppLine.INIT();
                    PostLeaveAppLine.TRANSFERFIELDS(LeaveApplicationLine);
                    PostLeaveAppLine."Set For Approval" := true;
                    PostLeaveAppLine.Month := DATE2DMY(LeaveApplicationLine."From Date", 2);
                    PostLeaveAppLine.Year := DATE2DMY(LeaveApplicationLine."From Date", 3);
                    PayAppSetup.RESET();
                    PayAppSetup.SETRANGE("Document Type", PayAppSetup."Document Type"::LeaveApplication);
                    PayAppSetup.SETRANGE(Department, Dept);
                    PayAppSetup.SETRANGE(User, USERID());
                    if PayAppSetup.FINDFIRST() then begin
                        PayAppSetup.RESET();
                        PayAppSetup2.SETRANGE("Document Type", PayAppSetup."Document Type");
                        PayAppSetup2.SETRANGE(Department, Dept);
                        PayAppSetup2.SETRANGE(PayAppSetup2.User, USERID());
                        PayAppSetup2.SETRANGE("Line No.", PayAppSetup."Line No.");
                        if PayAppSetup2.FINDFIRST() then
                            if PayAppSetup2.HOD <> '' then begin
                                PostLeaveAppLine.Status := PostLeaveAppLine.Status::"Pending for HOD Approval";
                                PostLeaveAppLine."HOD user" := PayAppSetup2.HOD;
                                PostLeaveAppLine.Approver := PayAppSetup2.HOD;
                            end else
                                if PayAppSetup2."Additional Approver" <> '' then begin
                                    PostLeaveAppLine.Status := PostLeaveAppLine.Status::"Pending for Additional Approval";
                                    PostLeaveAppLine.Approver := PayAppSetup2."Additional Approver";
                                end else begin
                                    PostLeaveAppLine.Status := PostLeaveAppLine.Status::"Pending for HR Approval";
                                    PostLeaveAppLine.Approver := PayAppSetup2."HR Approver";
                                end;

                    end;
                    PostLeaveAppLine.INSERT();
                    if PrevLeaveCode <> LeaveApplicationLine."Leave Code" then
                        LeaveApplicationLine.UpdateProLeaves(LeaveApplicationLine);

                    PrevLeaveCode := LeaveApplicationLine."Leave Code";
                    LeaveApplicationLine.Delete();
                until LeaveApplicationLine.NEXT() = 0;
                PostLeaveAppHeader.INSERT();
                HRSetupLrec.GET();
                if not HRSetupLrec."Activate Leave Approvals" then
                    LeaveApprFormGVar.AutomaticApproveLeaves("Employee No.");
                Rec.Delete();
            end;

        CurrPage.UPDATE();
    end;

    procedure GetResources(FromUSERID: Code[20]);
    var
        ResourceNames: Record "Resource Hierarchy B2B";
    begin
        ResourceNames.RESET();
        ResourceNames.SETRANGE("From User ID", FromUSERID);
        ResourceNames.SETRANGE("To User ID", FromUSERID);
        ResourceNames.SETFILTER("To User ID", '<>%1', FromUSERID);
        if ResourceNames.FINDFIRST() then
            repeat
                if not TempUser.GET(ResourceNames."To User ID") then begin
                    TempUser.INIT();
                    TempUser."User Name" := ResourceNames."To User ID";
                    TempUser.INSERT();
                    UserNames := CopyStr(UserNames + ResourceNames."To User ID" + '|', 1, 1024);
                end;
                GetResources1(ResourceNames."To User ID");
            until ResourceNames.NEXT() = 0;
    end;

    procedure OpenLeavePlan();
    var
        LeavePlan: Record "Leave Plan B2B";
        Text0001Lbl: Label 'Leave plan not exist.';
    begin
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", "Document No.");
        LeavePlan.SETRANGE("Employee No", "Employee No.");
        if LeavePlan.FINDFIRST() then
            PAGE.RUN(33001384, LeavePlan)
        else
            ERROR(Text0001Lbl);
    end;

    procedure CreateLeavePlan();
    var
        DailyAttendance: Record "Daily Attendance B2B";
        LeaveApplicationLine: Record "Leave Application Line B2B";
        Text002Lbl: Label 'Leave Plan created.';
        Text003Lbl: Label '%1 is Halfday, so leave duration should be "Half day".', Comment = '%1 = From Date';
    begin
        LeaveApplicationLine.RESET();
        LeaveApplicationLine.SETCURRENTKEY("Document No.", "Leave Code");
        LeaveApplicationLine.SETRANGE("Document No.", "Document No.");
        LeaveApplicationLine.SETRANGE("Employee No.", "Employee No.");
        if LeaveApplicationLine.FINDFIRST() then
            repeat
                LeaveApplicationLine.Month := DATE2DMY(LeaveApplicationLine."From Date", 2);
                LeaveApplicationLine.Year := DATE2DMY(LeaveApplicationLine."From Date", 3);
                ProcessedSalGRec.RESET();
                ProcessedSalGRec.SETRANGE("Employee Code", LeaveApplicationLine."Employee No.");
                ProcessedSalGRec.SETRANGE("Pay Slip Month", LeaveApplicationLine.Month);
                ProcessedSalGRec.SETRANGE(Year, LeaveApplicationLine.Year);
                ProcessedSalGRec.SETRANGE(Posted, true);
                if ProcessedSalGRec.FINDFIRST() then
                    ERROR(Text004Lbl);
            until LeaveApplicationLine.NEXT() = 0;
        LeaveAppLine.Reset();
        LeaveAppLine.SETRANGE("Document No.", "Document No.");
        LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
        LeaveAppLine.FINDFIRST();
        repeat
            if (LeaveAppLine."Leave Duration" = LeaveAppLine."Leave Duration"::Leave) and
               (LeaveAppLine."From Date" = LeaveAppLine."To Date")
            then begin
                DailyAttendance.RESET();
                DailyAttendance.SETRANGE("Employee No.", LeaveAppLine."Employee No.");
                DailyAttendance.SETRANGE(DailyAttendance.Date, LeaveAppLine."From Date");
                DailyAttendance.SETRANGE(WeeklyOff, 0.5);
                if not DailyAttendance.IsEmpty() then
                    ERROR(Text003Lbl, LeaveAppLine."From Date");
            end;

            if (LeaveAppLine."Leave Duration" = LeaveAppLine."Leave Duration"::"Half Day") and
               (LeaveAppLine."Session Time" = LeaveAppLine."Session Time"::" ")
            then
                ERROR(Text001Lbl, LeaveAppLine."Line No.");

            LeaveAppLine.TESTFIELD("Leave Duration");
            LeaveAppLine.TESTFIELD("From Date");
            LeaveAppLine.TESTFIELD("To Date");
            LeaveAppLine.LeavePlanning(LeaveAppLine);
        until LeaveAppLine.NEXT() = 0;
        MESSAGE(Text002Lbl);
    end;

    local procedure EmployeeNoOnAfterValidate();
    begin
        if "Employee No." = '' then
            "Employee Name" := '';
    end;

    // local procedure SetControlsVisibility();
    // var
    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    // begin
    //     OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    // end;
}

