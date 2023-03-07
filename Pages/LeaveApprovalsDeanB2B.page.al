page 33001513 "Leave Approvals Dean B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Leave Approvals Dean';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Posted Leave App Line B2B";
    SourceTableView = WHERE("Processed Status" = FILTER(<> Cancelled),
                            Cancel = CONST(false),
                            "Pending For Cancellation" = CONST(false),
                            Status = CONST("Pending for Additional Approval"),
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
                    Caption = 'Employee No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee no';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        CLEAR(EmpDept);
                        Employee.RESET();
                        Employee.SETRANGE("User Id", USERID());
                        if Employee.FINDFIRST() then
                            EmpDept := Employee."Department Code";

                        PostLeaveAppGRec.RESET();
                        PostLeaveAppGRec.SETRANGE("Department Code", EmpDept);
                        if PAGE.RUNMODAL(0, PostLeaveAppGRec) = ACTION::LookupOK then begin
                            CurrentEmpNo := Employee."No.";
                            EmployeeName := Employee."First Name";
                        end;
                    end;

                    trigger OnValidate();
                    begin
                        CurrentEmpNoOnAfterValidate();
                    end;
                }
                field(EmployeeName1; EmployeeName)
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee name';
                }
                field(CurrentLeaveAppNo1; CurrentLeaveAppNo)
                {
                    Caption = 'Leave Application No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave application no';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PostLeaveApp.RESET();
                        PostLeaveApp.SETRANGE("Employee No.", "Employee No.");
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
                    Caption = 'From Date';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The from date';

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
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Employee no';
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Emplyee name';
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
                    ToolTip = 'Specifies The to date';
                }
                field("No.of Days"; "No.of Days")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The no of days';
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Reaso for leave';
                }
                field("Carry out Action"; "Carry out Action")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Carry out action';
                }
                field("Approved Leaves"; "Approved Leaves")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Approved leave';
                }
                field("Rejected Leaves"; "Rejected Leaves")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Rejected leaves';
                }
                field(Approve; Approve)
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies The approves';
                }

            }
            part(LeaveplanSubfrm; "Posted Leave Plan B2B")
            {
                Caption = 'LeaveplanSubfrm';
                SubPageLink = "Employee No" = FIELD("Employee No."),
                              "Leave Code" = FIELD("Leave Code"),
                              "Approved Status" = FILTER(<> " "),
                              "Leave Application No." = FIELD("Document No."),
                              "Posted Status" = FILTER(" ");
                ApplicationArea = all;
            }
            field(ItemPeriodLength1; ItemPeriodLength)
            {
                OptionCaption = 'Day,Week,Month,Quarter,Year,Period';
                ToolTip = 'Day';
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
        area(navigation)
        {
            action("Leave &Plan")
            {
                Caption = 'Leave &Plan';
                Image = Planning;
                ApplicationArea = all;
                ToolTip = 'Specifies The leave plan';
                trigger OnAction();
                begin
                    LeavePlanning(Rec);
                end;
            }
            group("P&ost")
            {
                Caption = 'P&ost';
                    
            }
            action(ApproveCust)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Approve';
                trigger OnAction();
                begin
                    TESTFIELD("Carry out Action");
                    TESTFIELD(Approve);
                    PostedLeavePlan.RESET();
                    PostedLeavePlan.SETRANGE("Leave Application No.", "Document No.");
                    PostedLeavePlan.SETRANGE("Leave Code", "Leave Code");
                    if PostedLeavePlan.FINDFIRST() then
                        if PostedLeavePlan."Approved Status" = PostedLeavePlan."Approved Status"::Applied then
                            ERROR(Text003Lbl);



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
                                    LeaveApp.Status := LeaveApp.Status::"Pending for HR Approval";
                                    LeaveApp.MODIFY();
                                end;
                            end;
                        until LeaveApp.NEXT() = 0;

                    MESSAGE(Text004Lbl);
                end;
            }
            action("&Reject")
            {
                Caption = '&Reject';
                Image = Reject;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Reject';
                trigger OnAction();
                begin
                    Status := Status::"Leave Application Rejected";
                    MODIFY();
                    MESSAGE(Text005Lbl, "Document No.");
                end;
            }
        }
        area(processing)
        {
        }
    }

    var
        Employee: Record "Employee B2B";
        PayApprovalSetup: Record "Leave  Approval Setup B2B";
        PayApprovalSetup1: Record "Leave  Approval Setup B2B";
        LeaveApp: Record "Posted Leave App Line B2B";
        PostLeaveAppGRec: Record "Posted Leave App Header B2B";
        PostLeaveApp: Record "Posted Leave App Header B2B";
        PostedLeavePlan: Record "Leave Plan B2B";
        CurrentEmpNo: Code[20];
        UserNames: Text[1024];
        EmployeeName: Text[50];
        CurrentDate: Date;
        //Calendar: Record Date;
        ItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;
        CurrentLeaveAppNo: Code[20];

        EmpDept: Code[50];
        Text000Lbl: Label 'Do you want to post the leaves?';
        Text002Lbl: Label 'There are no leaves with approval.';
        Text003Lbl: Label 'Please select Approval before posting';
        Text004Lbl: Label 'Leave Applicatyion %1 was sent to HR for final Posting', Comment = '%1 = No';
        Text005Lbl: Label 'Leave Application %1 Rejected', Comment = '%1 = No';
        Text33001Lbl: Label 'LEAVE YEAR';
        Text33002Lbl: Label 'Comp';
        Text33003Lbl: Label 'Compensatory Leave';

    procedure ApproveLeaves();
    begin
        if UserNames = '' then
            ERROR('');

        LeaveApp.RESET();
        LeaveApp.SETRANGE("Carry out Action", true);
        LeaveApp.SETFILTER("Employee User ID", UserNames);
        LeaveApp.SETRANGE("Processed Status", "Processed Status"::" ");
        LeaveApp.SETRANGE("Employee No.", "Employee No.");
        if LeaveApp.FINDFIRST() then begin
            if CONFIRM(Text000Lbl) then
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
        end else
            ERROR(Text002Lbl);

    end;

    procedure UpdateLeavePlan(PostedLeaveApp: Record "Posted Leave App Line B2B");
    var
        LeavePlan: Record "Leave Plan B2B";
    begin
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", PostedLeaveApp."Document No.");
        LeavePlan.SETRANGE("Employee No", PostedLeaveApp."Employee No.");
        LeavePlan.SETRANGE("Leave Code", PostedLeaveApp."Leave Code");
        if LeavePlan.FINDFIRST() then
            repeat
                LeavePlan."Posted Status" := LeavePlan."Posted Status"::Post;
                LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0;
    end;

    procedure GetResources(FromUSERID: Code[20]);
    begin
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
        Text012Lbl: Label '%1 have %2 availabe leaves, including %3 provisional leaves.', Comment = '%1 = Employe No ; %2 = TotalLeaves;%3 = Creditinng Interval';
        Text001Lbl: Label '%1 have %2 availabe leaves.', Comment = '%1 = Employe No ; %2 = Total leaves';
    begin
        CountCrIntervals := 0;
        TotalLeaves := 0;

        EmployeeLeaves.SETRANGE("No.", LeaveApplication."Employee No.");
        EmployeeLeaves.SETRANGE("Leave Code", LeaveApplication."Leave Code");
        if EmployeeLeaves.FINDFIRST() then
            EmployeeLeaves.CALCFIELDS("No. of Available Leaves");
        if LeaveApplication."Approved Leaves" > EmployeeLeaves."No. of Available Leaves" then begin
            PayYear.RESET();
            PayYear.SETRANGE("Year Type", Text33001Lbl);
            PayYear.SETRANGE(Closed, false);
            if PayYear.FINDLAST() then begin
                EndDate := PayYear."Year End Date";
                StartDate := PayYear."Year Start Date";
            end;
            Employee.GET(LeaveApplication."Employee No.");

            GradeWiseLeaves.RESET();
            GradeWiseLeaves.SETRANGE(GradeWiseLeaves."Leave Code", LeaveApplication."Leave Code");
            GradeWiseLeaves.SETRANGE(GradeWiseLeaves."Leave Pay Cadre", Employee."Pay Cadre");
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
                MESSAGE(Text012Lbl, LeaveApplication."Employee No.", TotalLeaves, (GradeWiseLeaves."Leaves in Crediting Interval" * CountCrIntervals)
             );
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
          Calendar.SETFILTER("Period Start",GETFILTER("Date Filter"));
          if not PeriodFormMgt.FindDate('+',Calendar,ItemPeriodLength) then
            PeriodFormMgt.FindDate('+',Calendar,ItemPeriodLength::Day);
          Calendar.SETRANGE("Period Start");
        end;
        PeriodFormMgt.FindDate(SearchText,Calendar,ItemPeriodLength);
        if AmountType = AmountType::"Net Change" then begin
          SETRANGE("Date Filter",Calendar."Period Start",Calendar."Period End");
          if GETRANGEMIN("Date Filter") = GETRANGEMAX("Date Filter") then
            SETRANGE("Date Filter",GETRANGEMIN("Date Filter"));
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
            DetailsLeaveRec."Entry Type" := DetailsLeaveRec."Entry Type"::Utilization;
            DetailsLeaveRec."Entry Date" := workdate();
            DetailsLeaveRec."Posting Date" := workdate();
            DetailsLeaveRec."Leave Pay Cadre" := Employee."Pay Cadre";
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
            EmpLeavesRec.SETRANGE("Leave Code", Text33002Lbl);
            if EmpLeavesRec.IsEmpty() then begin
                EmpLeaves.INIT();
                EmpLeaves."No." := LeaveApp."Employee No.";
                EmpLeaves."Leave Pay Cadre" := Employee."Pay Cadre";
                EmpLeaves."Leave Code" := HRSetup."Compensatory Leave Code";
                EmpLeaves."Leave Description" := Text33003Lbl;
                EmpLeaves.INSERT();
            end;

            DetailsLeaveRec.INIT();
            DetailsLeaveRec."Entry No." := Num;
            DetailsLeaveRec."Employee No." := LeaveApp."Employee No.";
            DetailsLeaveRec."Leave Code" := HRSetup."Compensatory Leave Code";
            DetailsLeaveRec."Leave Description" := Text33003Lbl;
            DetailsLeaveRec."Entry Type" := DetailsLeaveRec."Entry Type"::Entitlement;
            DetailsLeaveRec."Entry Date" := workdate();
            DetailsLeaveRec."Posting Date" := workdate();
            DetailsLeaveRec."Leave Pay Cadre" := Employee."Pay Cadre";
            DetailsLeaveRec."No. of Leaves" := LeaveApp."Comp Leaves";
            DetailsLeaveRec.Month := LeaveApp.Month;
            DetailsLeaveRec.Year := LeaveApp.Year;
            DetailsLeaveRec.INSERT();
            Num := Num + 1;

            DetailsLeaveRec.INIT();
            DetailsLeaveRec."Entry No." := Num;
            DetailsLeaveRec."Employee No." := LeaveApp."Employee No.";
            DetailsLeaveRec."Leave Code" := HRSetup."Compensatory Leave Code";
            DetailsLeaveRec."Leave Description" := Text33003Lbl;
            DetailsLeaveRec."Entry Type" := DetailsLeaveRec."Entry Type"::Utilization;
            DetailsLeaveRec."Entry Date" := workdate();
            DetailsLeaveRec."Posting Date" := workdate();
            DetailsLeaveRec."Leave Pay Cadre" := Employee."Pay Cadre";
            DetailsLeaveRec."No. of Leaves" := -LeaveApp."Comp Leaves";
            DetailsLeaveRec.Month := LeaveApp.Month;
            DetailsLeaveRec.Year := LeaveApp.Year;
            evaluate(DetailsLeaveRec."Approved By", USERID());
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
}

