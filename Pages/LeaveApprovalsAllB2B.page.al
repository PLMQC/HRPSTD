page 33001381 "Leave Approvals All B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Leave Approvals';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Posted Leave App Line B2B";
    SourceTableView = WHERE("Processed Status" = FILTER(<> Cancelled),
                            Cancel = CONST(false),
                            "Pending For Cancellation" = CONST(false),
                            Status = CONST("Pending for HR Approval"),
                            Status = FILTER(<> "Leave Application Rejected"));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentEmpNo1; CurrentEmpNo)
                {
                    ToolTip = 'Choose the Employee number.';
                    Caption = 'Employee No.';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        GetResources(Copystr(USERID(), 1, 50));
                        EmployeeGrec.RESET();
                        EmployeeGrec.SETRANGE("User Id", USERID());
                        if EmployeeGrec.FINDFIRST() then begin
                            LookUpGRec.RESET();
                            LookUpGRec.SETFILTER("Lookup Type", '%1', 4);
                            LookUpGRec.SETRANGE("Lookup Name", EmployeeGrec."Department Code");
                            if LookUpGRec.FINDFIRST() then begin
                                EmployeeGrec2.RESET();
                                EmployeeGrec2.SETRANGE("Department Code", LookUpGRec."Lookup Name");
                                if PAGE.RUNMODAL(33001195, EmployeeGrec2) = ACTION::LookupOK then begin
                                    CurrentEmpNo := EmployeeGrec2."No.";
                                    EmployeeName := EmployeeGrec2."First Name";
                                end;
                            end;
                        end;
                        SelectEmployee();
                        SelectLeaveApplication();
                    end;

                    trigger OnValidate();
                    begin
                        CurrentEmpNoOnAfterValidate();
                    end;
                }
                field(EmployeeName1; EmployeeName)
                {
                    ToolTip = 'Specifies the employee name.';
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(CurrentLeaveAppNo1; CurrentLeaveAppNo)
                {
                    ToolTip = 'Choose unquie leave application number.';
                    Caption = 'Leave Application No.';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PostLeaveApp.RESET();
                        PostLeaveApp.SETRANGE("Employee No.", CurrentEmpNo);
                        if PAGE.RUNMODAL(0, PostLeaveApp) = ACTION::LookupOK then
                            CurrentLeaveAppNo := PostLeaveApp."Document No.";


                        SelectLeaveApplication();
                    end;

                    trigger OnValidate();
                    begin
                        CurrentLeaveAppNoOnAfterValida();
                    end;
                }
                field(CurrentDate1; CurrentDate)
                {
                    ToolTip = 'Specifies the Start date.';
                    Caption = 'From Date';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentDateOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102152014)
            {
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Specifies the Employee number.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Specifies the Employee name.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave Code"; "Leave Code")
                {
                    ToolTip = 'Choose the leave code.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave Duration"; "Leave Duration")
                {
                    ToolTip = 'Specifies the Leave Duration.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Specifies from start date.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Specifies the End date.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("No.of Days"; "No.of Days")
                {
                    ToolTip = 'Specifies the no. of days.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    ToolTip = 'Specifies from Reason for leave.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Carry out Action"; "Carry out Action")
                {
                    ToolTip = 'Choose the Carry out Action';
                    ApplicationArea = all;
                }
                field("Approved Leaves"; "Approved Leaves")
                {
                    ToolTip = 'Shows the Approved Leaves.';
                    ApplicationArea = all;
                }
                field("Rejected Leaves"; "Rejected Leaves")
                {
                    ToolTip = 'Shows the Rejected leaves.';
                    ApplicationArea = all;
                }
                field(Approve; Approve)
                {
                    ToolTip = 'Shows the Leave Approve.';
                    ApplicationArea = all;
                }
            }
            part(LeaveplanSubfrm; "Posted Leave Plan B2B")
            {

                Caption = 'LeaveplanSubfrm';
                SubPageLink = "Employee No" = FIELD("Employee No."),
                              "Leave Code" = FIELD("Leave Code"),
                              "Approved Status" = FILTER(<> " "),
                              "Leave Application No." = FIELD("Document No.");
                ApplicationArea = all;
            }
            field(ItemPeriodLength1; ItemPeriodLength)
            {
                ToolTip = 'Specifes the Period lenght of leave.';
                OptionCaption = 'Day,Week,Month,Quarter,Year,Period';
                Visible = false;
                ApplicationArea = all;

                trigger OnValidate();
                begin
                    if ItemPeriodLength = ItemPeriodLength::Period then
                        PeriodItemPeriodLengthOnValida();
                    if ItemPeriodLength = ItemPeriodLength::Year then
                        YearItemPeriodLengthOnValidate();
                    if ItemPeriodLength = ItemPeriodLength::Quarter then
                        QuarterItemPeriodLengthOnValid();
                    if ItemPeriodLength = ItemPeriodLength::Month then
                        MonthItemPeriodLengthOnValidat();
                    if ItemPeriodLength = ItemPeriodLength::Week then
                        WeekItemPeriodLengthOnValidate();
                    if ItemPeriodLength = ItemPeriodLength::Day then
                        DayItemPeriodLengthOnValidate();
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Leave &Plan")
            {
                ToolTip = 'Specifies the creation of leave plan.';
                Caption = 'Leave &Plan';
                Image = Planning;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    LeavePlanning(Rec);
                end;
            }
            group("P&ost")
            {
                ToolTip = 'Post the Leave Approvals.';
                Caption = 'P&ost';
                Image = Post;
            }
            action(Action1102154014)
            {
                ToolTip = 'Post the Leave Approvals.';
                Caption = 'P&ost';
                Image = PostOrder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ApplicationArea = all;

                trigger OnAction();
                begin
                    LeavePlanGRec.RESET();
                    LeavePlanGRec.SETRANGE("Leave Application No.", "Document No.");
                    LeavePlanGRec.SETRANGE("Approved Status", LeavePlanGRec."Approved Status"::Applied);
                    if LeavePlanGRec.FINDFIRST() then
                        ERROR(Text010Lbl);

                    ApprovedFound := false;
                    LeavePlanGRec.RESET();
                    LeavePlanGRec.SETRANGE("Leave Application No.", "Document No.");
                    if LeavePlanGRec.FINDSET() then
                        repeat
                            if LeavePlanGRec."Approved Status" = LeavePlanGRec."Approved Status"::Approved then
                                ApprovedFound := true;
                        until (LeavePlanGRec.NEXT() = 0) or (ApprovedFound = true);


                    if not ApprovedFound then
                        ApproveRejectedleaves()
                    else
                        ApproveLeaves();
                end;
            }
        }
        area(navigation)
        {
            action("Previous Period")
            {
                ToolTip = 'Specifies the previous period.';
                Caption = 'Previous Period';
                Image = PreviousSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = true;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    FindPeriod('<=');
                end;
            }
            action("Next Period")
            {
                ToolTip = 'Specifies the Next period.';
                Caption = 'Next Period';
                Image = NextSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = true;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    FindPeriod('>=');
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        CurrPage.LeaveplanSubfrm.PAGE.IntiateValues();
    end;

    trigger OnOpenPage();
    var
        PayrollUsers: Record "Payroll Location Users B2B";
    begin
        IsAnApprover := false;

        PayrollApprovalSetup.RESET();
        PayrollApprovalSetup.SETRANGE("Document Type", PayrollApprovalSetup."Document Type"::LeaveApplication);
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
                ERROR(Text004Lbl);
        end;

        SETRANGE(Approver, USERID());
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
    end;

    var
        TempUser: Record User temporary;
        Employee: Record "Employee B2B";
        LeaveApp: Record "Posted Leave App Line B2B";
        EmployeeGrec: Record "Employee B2B";
        LookUpGRec: Record Lookup_B2B;
        EmployeeGrec2: Record "Employee B2B";
        PayApprovalSetup: Record "Leave  Approval Setup B2B";
        PayApprovalSetup1: Record "Leave  Approval Setup B2B";
        PostedLeavePlan: Record "Leave Plan B2B";
        PayrollApprovalSetup: Record "Leave  Approval Setup B2B";
        PostLeaveApp: Record "Posted Leave App Header B2B";
        LeavePlanGRec: Record "Leave Plan B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        PostedLeavePlanFormGvar: Page "Posted Leave Plan B2B";
        CurrentEmpNo: Code[20];
        UserNames: Text[1024];
        EmployeeName: Text[50];
        CurrentDate: Date;
        //Calendar: Record Date;
        ItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;
        CurrentLeaveAppNo: Code[20];
        IsAnApprover: Boolean;
        ApprovedFound: Boolean;

        Text000Lbl: Label 'Do you want to post the leaves?';
        Text002Lbl: Label 'There are no leaves with approval.';
        Text004Lbl: Label 'You dont have permission to open this form';
        Text005Lbl: Label 'Please select the Approval before posting';
        Text006Lbl: Label 'Leave Application %1 was approved and sent for further approval', Comment = '%1 = No';
        Text007Lbl: Label 'Please select Approveall before posting';
        Text008Lbl: Label 'Leave Application Approved Successfully';
        Text009Lbl: Label 'Leave Applicatyion %1 was sent to HR for final Posting', Comment = '%1 = No';
        Text010Lbl: Label 'Either Approved or Rejected should be selected';
        Text011Lbl: Label 'LEAVE YEAR';
        Text012Lbl: Label 'Comp';
        Text013Lbl: Label 'Compensatory Leave';

    procedure ApproveLeaves();
    begin
        PayApprovalSetup.RESET();
        PayApprovalSetup.SETRANGE("Document Type", PayApprovalSetup."Document Type"::LeaveApplication);
        PayApprovalSetup.SETRANGE(Department, "Department Code");
        if PayApprovalSetup.FINDFIRST() then
            if PayApprovalSetup.HOD = UPPERCASE(USERID()) then
                ApproveLeaveHOD()
            else
                if PayApprovalSetup."Additional Approver" = UPPERCASE(USERID()) then
                    ApprovalLeaveAdditionalApprove()
                else
                    if PayApprovalSetup."HR Approver" = UPPERCASE(USERID()) then
                        ApproveleaveFinal();

    end;

    procedure UpdateLeavePlan();
    var
        LeavePlan: Record "Leave Plan B2B";
    begin
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", "Document No.");
        LeavePlan.SETRANGE("Employee No", "Employee No.");
        LeavePlan.SETRANGE("Leave Code", "Leave Code");
        if LeavePlan.FINDFIRST() then
            repeat
                LeavePlan."Posted Status" := LeavePlan."Posted Status"::Post;
                LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0;
    end;

    procedure GetResources(FromUserID: Code[50]);
    var
        ResourceNames: Record "Resource Hierarchy B2B";
    begin
        ResourceNames.RESET();
        ResourceNames.SETRANGE("From User ID", FromUserID);
        ResourceNames.SETFILTER("To User ID", '<>%1', FromUserID);
        if ResourceNames.FINDFIRST() then
            repeat
                if not TempUser.GET(ResourceNames."To User ID") then begin
                    TempUser.INIT();
                    TempUser."User Name" := ResourceNames."To User ID";
                    TempUser.INSERT();
                    UserNames := Copystr(UserNames + ResourceNames."To User ID" + '|', 1, 1024);
                end;
                GetResources(ResourceNames."To User ID");
            until ResourceNames.NEXT() = 0;
    end;

    procedure ProvisionalLeaves(LeaveApplication: Record "Posted Leave App Line B2B");
    var
        PayYear: Record "Payroll Year B2B";
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        EmployeeLeaves: Record "Employee Leaves B2B";
        TotalLeaves: Decimal;
        CountCrIntervals: Decimal;
        StartDate: Date;
        EndDate: Date;
        TempDate: Date;
        Text0002Lbl: Label '%1 have %2 availabe leaves, including %3 provisional leaves.', Comment = '%1 = Emp No  ; %2 =TottalLeave ;%3 = Crediting Intervals';
        Text001Lbl: Label '%1 have %2 availabe leaves.', Comment = '%1 = EmpNo ; %2 = Total Leaves';
    begin
        CountCrIntervals := 0;
        TotalLeaves := 0;

        EmployeeLeaves.SETRANGE("No.", LeaveApplication."Employee No.");
        EmployeeLeaves.SETRANGE("Leave Code", LeaveApplication."Leave Code");
        if EmployeeLeaves.FINDFIRST() then
            EmployeeLeaves.CALCFIELDS("No. of Available Leaves");
        if LeaveApplication."Approved Leaves" > EmployeeLeaves."No. of Available Leaves" then begin

            PayYear.RESET();
            PayYear.SETRANGE("Year Type", Text011Lbl);
            PayYear.SETRANGE(Closed, false);
            if PayYear.FINDLAST() then begin
                EndDate := PayYear."Year End Date";
                StartDate := PayYear."Year Start Date";
            end;

            Employee.GET(LeaveApplication."Employee No.");

            GradeWiseLeaves.RESET();
            GradeWiseLeaves.SETRANGE(GradeWiseLeaves."Leave Code", LeaveApplication."Leave Code");
            GradeWiseLeaves.SETRANGE(GradeWiseLeaves."Leave Pay Cadre", Employee."Leave Pay Cadre");
            GradeWiseLeaves.SETRANGE("Location Code", Employee."Location Code");
            if GradeWiseLeaves.FINDFIRST() then;

            TempDate := StartDate;
            repeat
                TempDate := CALCDATE(GradeWiseLeaves."Crediting Interval", TempDate);
                if ((DATE2DMY(TempDate, 2)) > (DATE2DMY(LeaveApplication."From Date", 2))) and
                   ((DATE2DMY(TempDate, 3)) >= (DATE2DMY(LeaveApplication."From Date", 3))) and
                   ((DATE2DMY(TempDate, 2)) <= (DATE2DMY(LeaveApplication."To Date", 2))) and
                   ((DATE2DMY(TempDate, 3)) <= (DATE2DMY(LeaveApplication."To Date", 3)))
                then
                    CountCrIntervals += 1;
            until (TempDate >= EndDate) or
                  ((DATE2DMY(TempDate, 2) >= DATE2DMY(LeaveApplication."To Date", 2)) and
                   (DATE2DMY(TempDate, 3) >= DATE2DMY(LeaveApplication."To Date", 3)));

            if TempDate <= EndDate then begin
                TotalLeaves := EmployeeLeaves."No. of Available Leaves" + (GradeWiseLeaves."Leaves in Crediting Interval" * CountCrIntervals);
                MESSAGE(Text0002Lbl, LeaveApplication."Employee No.", TotalLeaves, (GradeWiseLeaves."Leaves in Crediting Interval" * CountCrIntervals));
            end else begin
                TotalLeaves := EmployeeLeaves."No. of Available Leaves";
                MESSAGE(Text001Lbl, LeaveApplication."Employee No.", TotalLeaves);
            end;
        end;
    end;

    procedure SelectEmployee();
    begin
        if CurrentEmpNo <> '' then
            SETRANGE("Employee No.", CurrentEmpNo)
        else
            SETRANGE("Employee No.");

        CurrentLeaveAppNo := '';
        CurrPage.UPDATE(false);
    end;

    procedure SelectDate();
    begin
        SETRANGE("From Date", CurrentDate);
        CurrPage.UPDATE(false);
    end;

    local procedure FindPeriod(SearchText: Code[10]);

    begin
        SearchText := '';
        /*
        if GETFILTER("Date Filter") <> '' then begin
            Calendar.SETFILTER("Period Start", GETFILTER("Date Filter"));
            if not PeriodFormMgt.FindDate('+', Calendar, ItemPeriodLength) then
                PeriodFormMgt.FindDate('+', Calendar, ItemPeriodLength::Day);
            Calendar.SETRANGE("Period Start");
        end;
        PeriodFormMgt.FindDate(SearchText, Calendar, ItemPeriodLength);
        if AmountType = AmountType::"Net Change" then begin
            SETRANGE("Date Filter", Calendar."Period Start", Calendar."Period End");
            if GETRANGEMIN("Date Filter") = GETRANGEMAX("Date Filter") then
                SETRANGE("Date Filter", GETRANGEMIN("Date Filter"));
        end else
            SETRANGE("Date Filter",DMY2Date(0,0,0), Calendar."Period End");*/
    end;

    procedure SelectLeaveApplication();
    begin
        SETFILTER("Document No.", CurrentLeaveAppNo);
        CurrPage.UPDATE(false);
    end;

    procedure InsertDetailLeaves(LeaveApp: Record "Posted Leave App Line B2B");
    var
        EmpLeaves: Record "Employee Leaves B2B";
        EmpLeavesRec: Record "Employee Leaves B2B";
        DetailsLeaveRec: Record "Detailed Leave Records B2B";
        DetailsLeaveRecNum: Record "Detailed Leave Records B2B";
        HRSetup: Record "HR Setup B2B";
        Num: Integer;
    begin
        CLEAR(Num);
        HRSetup.GET();
        DetailsLeaveRecNum.RESET();
        if DetailsLeaveRecNum.FINDLAST() then
            Num := DetailsLeaveRecNum."Entry No." + 1
        else
            Num := 1;

        if LeaveApp."Approved Leaves" <> 0 then begin
            Employee.GET(LeaveApp."Employee No.");
            DetailsLeaveRec.INIT();
            DetailsLeaveRec."Entry No." := Num;
            DetailsLeaveRec."Employee No." := LeaveApp."Employee No.";
            DetailsLeaveRec.VALIDATE("Leave Code", LeaveApp."Leave Code");
            DetailsLeaveRec."Leave Description" := LeaveApp."Reason for Leave";
            DetailsLeaveRec."Entry Type" := DetailsLeaveRec."Entry Type"::Utilization;
            DetailsLeaveRec."Entry Date" := workdate();
            DetailsLeaveRec."Posting Date" := workdate();
            DetailsLeaveRec."Leave Pay Cadre" := Employee."Leave Pay Cadre";
            DetailsLeaveRec."No. of Leaves" := -LeaveApp."Approved Leaves";
            DetailsLeaveRec.Month := LeaveApp.Month;
            DetailsLeaveRec.Year := LeaveApp.Year;
            Evaluate(DetailsLeaveRec."Approved By", USERID());
            DetailsLeaveRec."Reason For Leave" := LeaveApp."Reason for Leave";
            DetailsLeaveRec.INSERT();
            Num := Num + 1;
        end;
        if LeaveApp."Comp Leaves" <> 0 then begin
            HRSetup.TESTFIELD("Compensatory Leave Code");
            Employee.GET(LeaveApp."Employee No.");
            EmpLeavesRec.RESET();
            EmpLeavesRec.SETRANGE("No.", LeaveApp."Employee No.");
            EmpLeavesRec.SETRANGE("Leave Code", Text012Lbl);
            if EmpLeavesRec.IsEmpty() then begin
                EmpLeaves.INIT();
                EmpLeaves."No." := LeaveApp."Employee No.";
                EmpLeaves."Leave Pay Cadre" := Employee."Leave Pay Cadre";
                EmpLeaves."Leave Code" := HRSetup."Compensatory Leave Code";
                EmpLeaves."Leave Description" := Text013Lbl;
                EmpLeaves.INSERT();
            end;

            DetailsLeaveRec.INIT();
            DetailsLeaveRec."Entry No." := Num;
            DetailsLeaveRec."Employee No." := LeaveApp."Employee No.";
            DetailsLeaveRec."Leave Code" := HRSetup."Compensatory Leave Code";
            DetailsLeaveRec."Leave Description" := Text013Lbl;
            DetailsLeaveRec."Entry Type" := DetailsLeaveRec."Entry Type"::Entitlement;
            DetailsLeaveRec."Entry Date" := workdate();
            DetailsLeaveRec."Posting Date" := workdate();
            DetailsLeaveRec."Leave Pay Cadre" := Employee."Leave Pay Cadre";
            DetailsLeaveRec."No. of Leaves" := LeaveApp."Comp Leaves";
            DetailsLeaveRec.Month := LeaveApp.Month;
            DetailsLeaveRec.Year := LeaveApp.Year;
            DetailsLeaveRec.INSERT();
            Num := Num + 1;

            DetailsLeaveRec.INIT();
            DetailsLeaveRec."Entry No." := Num;
            DetailsLeaveRec."Employee No." := LeaveApp."Employee No.";
            DetailsLeaveRec."Leave Code" := HRSetup."Compensatory Leave Code";
            DetailsLeaveRec."Leave Description" := Text013Lbl;
            DetailsLeaveRec."Entry Type" := DetailsLeaveRec."Entry Type"::Utilization;
            DetailsLeaveRec."Entry Date" := workdate();
            DetailsLeaveRec."Posting Date" := workdate();
            DetailsLeaveRec."Leave Pay Cadre" := Employee."Leave Pay Cadre";
            DetailsLeaveRec."No. of Leaves" := -LeaveApp."Comp Leaves";
            DetailsLeaveRec.Month := LeaveApp.Month;
            DetailsLeaveRec.Year := LeaveApp.Year;
            Evaluate(DetailsLeaveRec."Approved By", USERID());
            DetailsLeaveRec."Reason For Leave" := LeaveApp."Reason for Leave";
            DetailsLeaveRec.INSERT();
        end;
    end;

    procedure UpdateAttendance(PostedLeaveApp: Record "Posted Leave App Line B2B");
    var
        LeavePlan: Record "Leave Plan B2B";
    begin
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", PostedLeaveApp."Document No.");
        LeavePlan.SETRANGE("Employee No", PostedLeaveApp."Employee No.");
        LeavePlan.SETRANGE("Leave Code", PostedLeaveApp."Leave Code");
        if LeavePlan.FINDFIRST() then
            REPORT.RUN(33001253, false, false, LeavePlan);

    end;

    procedure AutomaticApproveLeaves(EmployeeNoLPar: Code[20]);
    begin
        LeaveApp.RESET();
        LeaveApp.SETRANGE("Processed Status", "Processed Status"::" ");
        LeaveApp.SETRANGE("Employee No.", EmployeeNoLPar);
        if LeaveApp.FINDFIRST() then
            repeat
                CLEAR(PostedLeavePlanFormGvar);
                LeaveApp."Carry out Action" := true;
                PostedLeavePlanFormGvar.AutomaticApprove(true, LeaveApp);
                LeaveApp.MODIFY();
            until LeaveApp.NEXT() = 0;

        LeaveApp.RESET();
        LeaveApp.SETRANGE("Carry out Action", true);
        LeaveApp.SETRANGE("Processed Status", "Processed Status"::" ");
        LeaveApp.SETRANGE("Employee No.", EmployeeNoLPar);
        if LeaveApp.FINDFIRST() then
            repeat
                LeaveApp.CheckLeavePlan(LeaveApp);
                Evaluate(LeaveApp."Processed By", USERID());
                LeaveApp."Processed Date" := workdate();
                LeaveApp."Processed Status" := LeaveApp."Processed Status"::Posted;
                LeaveApp."Set For Approval" := false;
                LeaveApp.MODIFY();
                LeaveApp.UpdateProLeaves(LeaveApp);
                UpdateAttendance(LeaveApp);
            until LeaveApp.NEXT() = 0
        else
            ERROR(Text002Lbl);

    end;

    procedure ApproveLeaveHOD();
    var
        PostedLeave: Record "Leave Plan B2B";
        Dept: Code[50];
    begin
        TESTFIELD("Carry out Action");
        TESTFIELD(Approve);
        PostedLeave.RESET();
        PostedLeave.SETRANGE("Leave Application No.", "Document No.");
        PostedLeave.SETRANGE("Leave Code", "Leave Code");
        PostedLeave.SETRANGE("Approved Status", PostedLeave."Approved Status"::Applied);
        if not PostedLeave.IsEmpty() then
            ERROR(Text005Lbl);


        CLEAR(Dept);
        Employee.RESET();
        Employee.SETRANGE("No.", "Employee No.");
        if Employee.FINDFIRST() then
            Dept := Employee."Department Code";
        PayApprovalSetup.RESET();
        PayApprovalSetup.SETRANGE("Document Type", PayApprovalSetup."Document Type"::LeaveApplication);
        PayApprovalSetup.SETRANGE(Department, Dept);
        PayApprovalSetup.SETRANGE(HOD, USERID());
        if PayApprovalSetup.FINDFIRST() then begin
            PayApprovalSetup1.RESET();
            PayApprovalSetup1.SETRANGE("Document Type", PayApprovalSetup."Document Type");
            PayApprovalSetup1.SETRANGE(Department, PayApprovalSetup.Department);
            PayApprovalSetup1.SETRANGE("Line No.", PayApprovalSetup."Line No.");
            if PayApprovalSetup1.FINDFIRST() then
                if PayApprovalSetup1."Additional Approver" <> '' then begin
                    LeaveApp.RESET();
                    LeaveApp.SETRANGE("Document No.", "Document No.");
                    LeaveApp.SETRANGE(Approve, true);
                    if LeaveApp.FINDFIRST() then
                        repeat
                            LeaveApp.Approver := PayApprovalSetup1."Additional Approver";
                            LeaveApp."Carry out Action" := false;
                            LeaveApp.Approve := false;
                            LeaveApp.MODIFY();
                        until LeaveApp.NEXT() = 0;

                end else begin
                    LeaveApp.RESET();
                    LeaveApp.SETRANGE("Document No.", "Document No.");
                    LeaveApp.SETRANGE(Approve, true);
                    if LeaveApp.FINDFIRST() then
                        repeat
                            LeaveApp.Approver := PayApprovalSetup1."HR Approver";
                            LeaveApp."Carry out Action" := false;
                            LeaveApp.Approve := false;
                            LeaveApp.MODIFY();
                        until LeaveApp.NEXT() = 0;
                end;
        end;

        MESSAGE(Text006Lbl);
    end;

    procedure ApprovalLeaveAdditionalApprove();
    begin
        TESTFIELD("Carry out Action");
        TESTFIELD(Approve);
        PostedLeavePlan.RESET();
        PostedLeavePlan.SETRANGE("Leave Application No.", "Document No.");
        PostedLeavePlan.SETRANGE("Leave Code", "Leave Code");
        if PostedLeavePlan.FINDFIRST() then
            if PostedLeavePlan."Approved Status" = PostedLeavePlan."Approved Status"::Applied then
                ERROR(Text007Lbl);


        LeaveApp.RESET();
        LeaveApp.SETRANGE("Document No.", "Document No.");
        LeaveApp.SETRANGE(Approve, true);
        if LeaveApp.FINDFIRST() then
            repeat
                PayApprovalSetup.RESET();
                PayApprovalSetup.SETRANGE("Document Type", PayApprovalSetup."Document Type"::LeaveApplication);
                PayApprovalSetup.SETRANGE(Department, LeaveApp."Department Code");
                PayApprovalSetup.SETRANGE("Additional Approver", USERID());
                if PayApprovalSetup.FINDFIRST() then begin
                    PayApprovalSetup1.RESET();
                    PayApprovalSetup1.SETRANGE("Document Type", PayApprovalSetup."Document Type");
                    PayApprovalSetup1.SETRANGE(Department, PayApprovalSetup.Department);
                    PayApprovalSetup1.SETRANGE("Line No.", PayApprovalSetup."Line No.");
                    if PayApprovalSetup1.FINDFIRST() then begin
                        LeaveApp.Approver := PayApprovalSetup1."HR Approver";
                        LeaveApp."Carry out Action" := false;
                        LeaveApp.Approve := false;
                        LeaveApp.MODIFY();
                    end;
                end;
            until LeaveApp.NEXT() = 0;

        MESSAGE(Text009Lbl);
    end;

    procedure ApproveleaveFinal();
    begin
        LeaveApp.RESET();
        LeaveApp.SETRANGE("Carry out Action", true);
        LeaveApp.SETRANGE("Employee No.", "Employee No.");
        if LeaveApp.FINDFIRST() then begin
            if CONFIRM(Text000Lbl) then begin
                repeat
                    LeaveApp.CheckLeavePlan(LeaveApp);
                    Evaluate(LeaveApp."Processed By", USERID());
                    LeaveApp."Processed Date" := workdate();
                    LeaveApp."Processed Status" := LeaveApp."Processed Status"::Posted;
                    LeaveApp."Set For Approval" := false;
                    LeaveApp.Approver := '';
                    LeaveApp.MODIFY();
                    LeaveApp.UpdateProLeaves(LeaveApp);
                    UpdateAttendance(LeaveApp);
                until LeaveApp.NEXT() = 0;
                MESSAGE(Text008Lbl);
            end;
        end else
            ERROR(Text002Lbl);

    end;

    local procedure CurrentEmpNoOnAfterValidate();
    begin
        if Employee.GET(CurrentEmpNo) then
            EmployeeName := Employee."First Name"
        else
            EmployeeName := '';

        if CurrentEmpNo = '' then
            EmployeeName := '';

        SelectEmployee();
    end;

    local procedure CurrentDateOnAfterValidate();
    begin
        SelectDate();
    end;

    local procedure CurrentLeaveAppNoOnAfterValida();
    begin
        SelectLeaveApplication();
    end;

    local procedure DayItemPeriodLengthOnPush();
    begin
        FindPeriod('');
    end;

    local procedure WeekItemPeriodLengthOnPush();
    begin
        FindPeriod('');
    end;

    local procedure MonthItemPeriodLengthOnPush();
    begin
        FindPeriod('');
    end;

    local procedure QuarterItemPeriodLengthOnPush();
    begin
        FindPeriod('');
    end;

    local procedure YearItemPeriodLengthOnPush();
    begin
        FindPeriod('');
    end;

    local procedure PeriodItemPeriodLengthOnPush();
    begin
        FindPeriod('');
    end;

    local procedure DayItemPeriodLengthOnValidate();
    begin
        DayItemPeriodLengthOnPush();
    end;

    local procedure WeekItemPeriodLengthOnValidate();
    begin
        WeekItemPeriodLengthOnPush();
    end;

    local procedure MonthItemPeriodLengthOnValidat();
    begin
        MonthItemPeriodLengthOnPush();
    end;

    local procedure QuarterItemPeriodLengthOnValid();
    begin
        QuarterItemPeriodLengthOnPush();
    end;

    local procedure YearItemPeriodLengthOnValidate();
    begin
        YearItemPeriodLengthOnPush();
    end;

    local procedure PeriodItemPeriodLengthOnValida();
    begin
        PeriodItemPeriodLengthOnPush();
    end;

    procedure ApproveRejectedleaves();
    begin
        if CONFIRM(Text000Lbl) then begin
            LeaveApp.RESET();
            LeaveApp.SETRANGE("Document No.", "Document No.");
            LeaveApp.SETFILTER(LeaveApp."Rejected Leaves", '<>%1', 0);
            LeaveApp.SETRANGE("Carry out Action", true);
            if LeaveApp.FINDFIRST() then begin
                repeat
                    LeaveApp.CheckLeavePlan(LeaveApp);
                    Evaluate(LeaveApp."Processed By", USERID());
                    LeaveApp."Processed Date" := workdate();
                    LeaveApp."Processed Status" := LeaveApp."Processed Status"::Posted;
                    LeaveApp."Set For Approval" := false;
                    LeaveApp.Approver := '';
                    LeaveApp.MODIFY();
                    LeaveApp.UpdateProLeaves(LeaveApp);
                until LeaveApp.NEXT() = 0;
                MESSAGE(Text008Lbl);
            end else
                ERROR(Text002Lbl);

        end;
    end;
}

