report 33001250 "Generate Prov. Leaves OB B2B"
{
    // version B2BHR1.00.00

    Caption = 'Generate Provisional Leaves OB';
    ProcessingOnly = true;
    UseRequestPage = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Blocked = CONST(false));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                InsertProvLeaves("Employee B2B");
                InsertEmpLeaves("Employee B2B");

            end;

            trigger OnPostDataItem();
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem();
            begin
                if YearStartDateGVar = 0D then
                    ERROR(Text002Txt);

                PayrollYear.RESET();
                PayrollYear.SETRANGE("Year Type", LEAVEYEARTxt);
                PayrollYear.SETRANGE(Closed, false);
                if PayrollYear.FINDFIRST() then
                    YearEndDate := PayrollYear."Year End Date"
                else
                    ERROR(Text003Txt);

                if YearStartDateGVar >= YearEndDate then
                    ERROR(Text004Txt, YearEndDate);
                Window.OPEN(Text000Txt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(YearStartDate; YearStartDateGVar)
                {
                    ToolTip = 'Choose the start date from which leaves generate.';
                    Caption = 'Generate Leaves From';
                    ApplicationArea = all;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        EmployeeLeaves: Record "Employee Leaves B2B";
        EmpLeavesInsert: Record "Employee Leaves B2B";
        EmpLeaveHistory: Record "Detailed Leave Records B2B";
        EmpLeaveHistoryNum: Record "Detailed Leave Records B2B";
        PayrollYear: Record "Payroll Year B2B";
        ProvLeavesInsertion: Record "Provisional Leaves B2B";
        HRSetup: Record "HR Setup B2B";
        Text000Txt: Label 'Employee No #1##################', Comment = '%1 = No';
        YearStartDateGVar: Date;
        YearEndDate: Date;
        Window: Dialog;
        Num: Integer;
        Text002Txt: Label 'Leaves generated starting period should not be blank.';
        Text003Txt: Label 'Please create payroll year.';
        Text004Txt: Label 'Leaves generated starting period should be less than %1.', Comment = '%1 = ';
        LEAVEYEARTxt: Label 'LEAVE YEAR';

    procedure InsertEmpLeaves(EmployeeRec: Record "Employee B2B");
    begin
        Window.UPDATE(1, "Employee B2B"."No.");
        HRSetup.GET();
        GradeWiseLeaves.RESET();
        GradeWiseLeaves.SETRANGE("Leave Pay Cadre", EmployeeRec."Leave Pay Cadre");
        GradeWiseLeaves.SETRANGE("Location Code", EmployeeRec."Location Code");


        if GradeWiseLeaves.FINDFIRST() then begin
            repeat
                EmpLeaveHistoryNum.Reset();
                if EmpLeaveHistoryNum.FINDLAST() then
                    Num := EmpLeaveHistoryNum."Entry No." + 1
                else
                    Num := 1;
                EmployeeLeaves.INIT();
                EmployeeLeaves."No." := EmployeeRec."No.";
                EmployeeLeaves."Leave Pay Cadre" := EmployeeRec."Leave Pay Cadre";
                EmployeeLeaves."Leave Code" := GradeWiseLeaves."Leave Code";
                EmployeeLeaves."Leave Description" := GradeWiseLeaves."Leave Description";
                EmpLeavesInsert.RESET();
                EmpLeavesInsert.SETRANGE("No.", EmployeeLeaves."No.");
                EmpLeavesInsert.SETRANGE("Leave Pay Cadre", EmployeeLeaves."Leave Pay Cadre");
                EmpLeavesInsert.SETRANGE("Leave Code", EmployeeLeaves."Leave Code");
                if not EmpLeavesInsert.FINDFIRST() then
                    EmployeeLeaves.INSERT();
                GradeWiseLeaves.TESTFIELD("Crediting Interval");
                if GradeWiseLeaves."Crediting Type" = GradeWiseLeaves."Crediting Type"::"Before the Period" then begin
                    EmpLeaveHistory.INIT();
                    EmpLeaveHistory."Entry No." := Num;
                    EmpLeaveHistory."Employee No." := EmployeeRec."No.";
                    EmpLeaveHistory."Entry Type" := EmpLeaveHistory."Entry Type"::Entitlement;
                    EmpLeaveHistory."Entry Date" := YearStartDateGVar;
                    EmpLeaveHistory."Leave Code" := GradeWiseLeaves."Leave Code";
                    EmpLeaveHistory."Posting Date" := WORKDATE();
                    EmpLeaveHistory."Leave Pay Cadre" := EmployeeRec."Leave Pay Cadre";
                    EmpLeaveHistory."No. of Leaves" := GradeWiseLeaves."Leaves in Crediting Interval";

                    EmpLeaveHistory."Leave Description" := GradeWiseLeaves."Leave Description";
                    //EmpLeaveHistory.Month := HRSetup."Salary Processing month";
                    //EmpLeaveHistory.Year := HRSetup."Salary Processing Year";
                    EmpLeaveHistoryNum.RESET();
                    EmpLeaveHistoryNum.SETRANGE("Employee No.", EmpLeaveHistory."Employee No.");
                    EmpLeaveHistoryNum.SETRANGE("Leave Code", EmpLeaveHistory."Leave Code");
                    EmpLeaveHistoryNum.SETRANGE(Month, EmpLeaveHistory.Month);
                    EmpLeaveHistoryNum.SETRANGE(Year, EmpLeaveHistory.Year);
                    EmpLeaveHistoryNum.SETRANGE("Entry Type", EmpLeaveHistory."Entry Type"::Entitlement);
                    if not EmpLeaveHistoryNum.FINDFIRST() then
                        EmpLeaveHistory.INSERT();
                    Num += 1;
                end;
            until GradeWiseLeaves.NEXT() = 0;
            "Employee B2B"."Leaves Not Generated" := false;
            "Employee B2B".MODIFY();
        end;
    end;

    procedure InsertProvLeaves(Employee: Record "Employee B2B");
    var
        ProvLeaves: Record "Provisional Leaves B2B";
        ProvLeavesRec: Record "Provisional Leaves B2B";
        StartDate: Date;
        EndDate: Date;
        TempDate: Date;
        CheckDate: Date;
        OBLeaves: Decimal;
    begin
        StartDate := YearStartDateGVar;
        EndDate := YearEndDate;

        GradeWiseLeaves.RESET();
        GradeWiseLeaves.SETRANGE("Leave Pay Cadre", Employee."Leave Pay Cadre");
        GradeWiseLeaves.SETRANGE("Location Code", Employee."Location Code");
        if GradeWiseLeaves.FINDFIRST() then
            repeat
                if GradeWiseLeaves."Carry Forward" then
                    OBLeaves := CarryForward(GradeWiseLeaves."Leave Code", Employee."No.", StartDate, GradeWiseLeaves."Max.Leaves to Carry Forward");
                GradeWiseLeaves.TESTFIELD("Crediting Interval");
                ProvLeavesRec.RESET();
                ProvLeavesRec.SETRANGE("Employee No.", Employee."No.");
                ProvLeavesRec.SETRANGE("Leave Code", GradeWiseLeaves."Leave Code");
                if ProvLeavesRec.FINDLAST() then
                    CheckDate := ProvLeavesRec."Period End Date"
                else
                    CheckDate := 0D;

                if GradeWiseLeaves."Crediting Type" = GradeWiseLeaves."Crediting Type"::"Before the Period" then
                    TempDate := StartDate
                else
                    if CheckDate = 0D then
                        TempDate := CALCDATE(GradeWiseLeaves."Crediting Interval", StartDate)
                    else
                        TempDate := CheckDate + 1;

                repeat
                    ProvLeaves.INIT();
                    ProvLeaves."Employee No." := Employee."No.";
                    ProvLeaves."Employee Name" := Employee."First Name";
                    ProvLeaves."Leave Code" := GradeWiseLeaves."Leave Code";
                    ProvLeaves.Month := DATE2DMY(TempDate, 2);
                    ProvLeaves.Year := DATE2DMY(TempDate, 3);
                    ProvLeaves."Leave Descriptioon" := GradeWiseLeaves."Leave Description";
                    if TempDate = StartDate then
                        ProvLeaves."Prev. Month  Balance" := OBLeaves;
                    ProvLeaves."No.of Leaves" := GradeWiseLeaves."Leaves in Crediting Interval";
                    ProvLeaves."Remaining Leaves" := ProvLeaves."No.of Leaves" + ProvLeaves."Prev. Month  Balance";
                    ProvLeaves."Leave Year Start Date" := StartDate;
                    ProvLeaves."Leave Year End Date" := EndDate;
                    ProvLeaves."Period Start Date" := TempDate;
                    ProvLeaves."Period End Date" := (CALCDATE(GradeWiseLeaves."Crediting Interval", TempDate) - 1);
                    ProvLeavesInsertion.RESET();
                    ProvLeavesInsertion.SETRANGE("Employee No.", ProvLeaves."Employee No.");
                    ProvLeavesInsertion.SETRANGE("Leave Code", ProvLeaves."Leave Code");
                    ProvLeavesInsertion.SETRANGE(Month, ProvLeaves.Month);
                    ProvLeavesInsertion.SETRANGE(Year, ProvLeaves.Year);
                    if not ProvLeavesInsertion.FINDFIRST() then
                        ProvLeaves.INSERT();
                    TempDate := CALCDATE(GradeWiseLeaves."Crediting Interval", TempDate);
                until TempDate > EndDate;
            until GradeWiseLeaves.NEXT() = 0;

    end;

    procedure CarryForward(LeaveCode: Code[20]; EmpNo: Code[20]; StDate: Date; MaxCFLeaves: Decimal): Decimal;
    var
        ProvisionalLeaves: Record "Provisional Leaves B2B";
        OpeningBalance: Decimal;
    begin
        OpeningBalance := 0;
        ProvisionalLeaves.RESET();
        ProvisionalLeaves.SETRANGE("Employee No.", EmpNo);
        ProvisionalLeaves.SETRANGE("Leave Code", LeaveCode);
        ProvisionalLeaves.SETRANGE("Period End Date", (StDate - 1));
        if ProvisionalLeaves.FINDFIRST() then begin
            OpeningBalance := OpeningBalance + ProvisionalLeaves."Remaining Leaves";
            ProvisionalLeaves.Status := ProvisionalLeaves.Status::Closed;
            ProvisionalLeaves."Remaining Leaves" := 0;
            ProvisionalLeaves.MODIFY();
            if OpeningBalance > MaxCFLeaves then
                OpeningBalance := MaxCFLeaves;
            exit(OpeningBalance);
        end else
            exit(0);
    end;

    procedure UpdateDate();
    begin
        HRSetup.GET();
        YearStartDateGVar := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
    end;

}

