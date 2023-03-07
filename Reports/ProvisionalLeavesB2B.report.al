report 33001252 "Provisional Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Provisional Leaves';
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING ("No.") ORDER(Ascending) WHERE (Blocked = CONST (false));

            trigger OnPostDataItem();
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem();
            begin
                "Employee B2B".SETRANGE("No.", EmployeeNo);
                "Employee B2B".SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                "Employee B2B".SETRANGE(Blocked, false);
                Window.OPEN(Text000Txt);
            end;
        }
    }

    requestpage
    {
        Caption = 'Provisional Leaves';

        layout
        {
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
        ProvLeavesInsert: Record "Provisional Leaves B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text000Txt: Label 'Employee No #1##################', Comment = '%1 = No';
        YearStartDate: Date;
        YearEndDate: Date;
        Window: Dialog;
        EmployeeNo: Code[20];
        LeaveCodeGlobal: Code[20];
        Text330001Txt: Label '<1Y>';

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
        StartDate := YearStartDate;
        EndDate := YearEndDate;

        GradeWiseLeaves.RESET();
        GradeWiseLeaves.SETRANGE("Leave Pay Cadre", Employee."Pay Cadre");
        GradeWiseLeaves.SETRANGE("Leave Code", LeaveCodeGlobal);
        GradeWiseLeaves.SETRANGE("Location Code", Employee."Location Code");
        if GradeWiseLeaves.FINDFIRST() then
            repeat
                if GradeWiseLeaves."Carry Forward" then
                    OBLeaves := CarryForward(GradeWiseLeaves."Leave Code", Employee."No.", StartDate, GradeWiseLeaves."Max.Leaves to Carry Forward");
                ProvLeavesRec.RESET();
                ProvLeavesRec.SETRANGE("Employee No.", Employee."No.");
                ProvLeavesRec.SETRANGE("Leave Code", GradeWiseLeaves."Leave Code");
                if ProvLeavesRec.FINDLAST() then
                    CheckDate := ProvLeavesRec."Period End Date"
                else
                    Clear(CheckDate);

                if GradeWiseLeaves."Crediting Type" = GradeWiseLeaves."Crediting Type"::"Before the Period" then
                    TempDate := StartDate
                else
                    if CheckDate = 0D then
                        TempDate := CALCDATE(GradeWiseLeaves."Crediting Interval", StartDate)
                    else
                        TempDate := CheckDate + 2;

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
                    ProvLeavesInsert.SETRANGE("Employee No.", ProvLeaves."Employee No.");
                    ProvLeavesInsert.SETRANGE("Leave Code", ProvLeaves."Leave Code");
                    ProvLeavesInsert.SETRANGE(Month, ProvLeaves.Month);
                    ProvLeavesInsert.SETRANGE(Year, ProvLeaves.Year);
                    if not ProvLeavesInsert.FINDFIRST() then
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
            if OpeningBalance > MaxCFLeaves then
                OpeningBalance := MaxCFLeaves;
            exit(OpeningBalance);
        end else
            exit(0);
    end;

    procedure SetPayrollYear(PrvYearEndDate: Date);
    begin
        YearStartDate := PrvYearEndDate + 1;
        YearEndDate := CALCDATE(Text330001Txt, YearStartDate) - 1;
    end;

    procedure SetRecord(EmpNo: Code[20]; LeaveCode: Code[20]);
    begin
        EmployeeNo := EmpNo;
        LeaveCodeGlobal := LeaveCode;
    end;
}

