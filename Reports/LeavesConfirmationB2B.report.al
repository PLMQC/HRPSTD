report 33001251 "Leaves Confirmation B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leaves Confirmation';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") WHERE(Blocked = CONST(false));

            trigger OnAfterGetRecord();
            var
                RemainingMonths: Decimal;
                TotalMonths: Decimal;
            begin
                if "Employee B2B"."Trainee Number" <> '' then
                    ERROR(Text005Txt, "Employee B2B"."No.");

                OldEmpCodeGVar := "Employee B2B"."No.";
                if OldEmpCodeGVar <> NewEmpCodeGVar then
                    "Employee B2B".RENAME(NewEmpCodeGVar);

                RemainingMonths := DATE2DMY(YearEndDate, 2) - DATE2DMY(ConfirmDateGVar, 2) + 1;
                TotalMonths := DATE2DMY(YearEndDate, 2) - DATE2DMY(YearStartDate, 2) + 1;

                GradeLeaves.RESET();
                GradeLeaves.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                GradeLeaves.SETRANGE("Leave Pay Cadre", NewGradeGVar);
                if GradeLeaves.FINDFIRST() then
                    repeat
                        TotalLeaves := 0;
                        EmpLeaves.SETCURRENTKEY("Leave Code", "Leave Pay Cadre");
                        EmpLeaves.RESET();
                        EmpLeaves.SETRANGE("No.", "Employee B2B"."No.");
                        EmpLeaves.SETRANGE("Leave Code", GradeLeaves."Leave Code");
                        if EmpLeaves.FINDFIRST() then begin
                            TotalLeaves := CalcProvLeaves(EmpLeaves);
                            TotalLeaves := TotalLeaves + ((RemainingMonths * GradeLeaves."No. of Leaves in Year") / TotalMonths);
                            InsertLeaves(TotalLeaves, GradeLeaves."Leave Code");
                        end else begin
                            TotalLeaves := TotalLeaves + ((RemainingMonths * GradeLeaves."No. of Leaves in Year") / TotalMonths);
                            InsertLeaves(TotalLeaves, GradeLeaves."Leave Code");
                            InsertEmpLeaves(GradeLeaves."Leave Code");
                            InsertDetailLeaves(TotalLeaves, GradeLeaves."Leave Code");
                        end;
                    until GradeLeaves.NEXT() = 0;

                "Employee B2B"."Pay Cadre" := NewGradeGVar;
                "Employee B2B"."Trainee Number" := OldEmpCodeGVar;
                "Employee B2B"."Confirmation Date" := ConfirmDateGVar;
                "Employee B2B".MODIFY();
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(OldEmpCode; OldEmpCodeGVar)
                {
                    ToolTip = 'Choose Old Employee code.';
                    Caption = 'Old Employee Code';
                    ApplicationArea = all;
                }
                field(NewEmpCode; NewEmpCodeGVar)
                {
                    ToolTip = 'Choose New Employee code.';
                    Caption = 'New Employee Code';
                    ApplicationArea = all;
                }
                field(ConfirmDate; ConfirmDateGVar)
                {
                    ToolTip = 'Select the Confirmation date of Employee.';
                    Caption = 'Confirmation Date';
                    ApplicationArea = all;
                }
                field(NewGrade; NewGradeGVar)
                {
                    ToolTip = 'Choose Employees New Grade.';
                    Caption = 'New Grade';
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

    trigger OnPostReport();
    begin
        MESSAGE(Text006Txt);
    end;

    trigger OnPreReport();
    begin
        if NewEmpCodeGVar = '' then
            ERROR(Text004Txt);

        if ConfirmDateGVar = 0D then
            ERROR(Text001Txt);

        if NewGradeGVar = '' then
            ERROR(Text002Txt);

        GradeLeaves.RESET();
        GradeLeaves.SETRANGE("Leave Pay Cadre", NewGradeGVar);
        if not GradeLeaves.FINDFIRST() then
            ERROR(Text003Txt, NewGradeGVar);


        GetLeaveYear();
    end;

    var
        PayrollYear: Record "Payroll Year B2B";
        GradeLeaves: Record "Grade Wise Leaves B2B";
        EmpLeaves: Record "Employee Leaves B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text001Txt: Label 'Confirmation date should not be blank.';
        NewGradeGVar: Code[20];
        Text002Txt: Label 'New Grade should not be blank.';
        Text003Txt: Label 'Leaves are not defined for the grade %1.', Comment = '%1 = NewGrade';
        TotalLeaves: Decimal;
        ConfirmDateGVar: Date;
        YearStartDate: Date;
        YearEndDate: Date;
        NewEmpCodeGVar: Code[20];
        OldEmpCodeGVar: Code[20];
        Text004Txt: Label 'New Employee Code should not be blank.';
        Text005Txt: Label 'Employee %1 is already confirmed.', Comment = '%1 = No';
        Text006Txt: Label 'Confirmation process is completed.';
        LEAVEYEARTxt: Label 'LEAVE YEAR';

    procedure GetLeaveYear();
    begin
        PayrollYear.RESET();
        PayrollYear.SETRANGE("Year Type", LEAVEYEARTxt);
        PayrollYear.SETRANGE(Closed, false);
        if PayrollYear.FINDFIRST() then begin
            YearStartDate := PayrollYear."Year Start Date";
            YearEndDate := PayrollYear."Year End Date";
        end;
    end;

    procedure CalcProvLeaves(EmpLeavesRec: Record "Employee Leaves B2B"): Decimal;
    var
        ProvisionalLeaves: Record "Provisional Leaves B2B";
        ProLeaves: Decimal;
    begin
        CLEAR(ProLeaves);
        ProvisionalLeaves.RESET();
        ProvisionalLeaves.SETRANGE("Employee No.", EmpLeavesRec."No.");
        ProvisionalLeaves.SETRANGE("Leave Code", EmpLeavesRec."Leave Code");
        ProvisionalLeaves.SETRANGE(Status, ProvisionalLeaves.Status::Open);
        ProvisionalLeaves.SETFILTER("Remaining Leaves", '<>%1', 0);
        ProvisionalLeaves.SETFILTER(ProvisionalLeaves."Period Start Date", '<=%1', ConfirmDateGVar);
        if ProvisionalLeaves.FINDFIRST() then
            repeat
                ProLeaves := ProLeaves + ProvisionalLeaves."Remaining Leaves";
            until ProvisionalLeaves.NEXT() = 0;
        exit(ProLeaves);
    end;

    procedure InsertLeaves(NoOfLeaves: Decimal; LeaveCode: Code[20]);
    var
        ProvisionalLeaves: Record "Provisional Leaves B2B";
    begin
        ProvisionalLeaves.RESET();
        ProvisionalLeaves.SETRANGE("Employee No.", "Employee B2B"."No.");
        ProvisionalLeaves.SETRANGE("Leave Code", LeaveCode);
        ProvisionalLeaves.SETRANGE(Status, ProvisionalLeaves.Status::Open);
        ProvisionalLeaves.SETFILTER("Remaining Leaves", '<>%1', 0);
        ProvisionalLeaves.SETFILTER(ProvisionalLeaves."Period End Date", '>=%1', ConfirmDateGVar);
        if ProvisionalLeaves.FINDFIRST() then
            repeat
                ProvisionalLeaves.DELETE();
            until ProvisionalLeaves.NEXT() = 0;

        ProvisionalLeaves.INIT();
        ProvisionalLeaves."Employee No." := "Employee B2B"."No.";
        ProvisionalLeaves."Employee Name" := "Employee B2B"."First Name";
        ProvisionalLeaves."Leave Code" := LeaveCode;
        ProvisionalLeaves."Leave Descriptioon" := GradeLeaves."Leave Description";
        ProvisionalLeaves."No.of Leaves" := NoOfLeaves;
        ProvisionalLeaves."Remaining Leaves" := NoOfLeaves;
        ProvisionalLeaves."Leave Year Start Date" := YearStartDate;
        ProvisionalLeaves."Leave Year End Date" := YearEndDate;
        ProvisionalLeaves.Status := ProvisionalLeaves.Status::Open;
        ProvisionalLeaves."Period Start Date" := ConfirmDateGVar;
        ProvisionalLeaves."Period End Date" := YearEndDate;
        ProvisionalLeaves.Month := DATE2DMY(ConfirmDateGVar, 2);
        ProvisionalLeaves.Year := DATE2DMY(ConfirmDateGVar, 3);
        ProvisionalLeaves.INSERT();
    end;

    procedure InsertEmpLeaves(LeaveCode: Code[20]);
    begin
        EmpLeaves.INIT();
        EmpLeaves."No." := "Employee B2B"."No.";
        EmpLeaves."Leave Pay Cadre" := NewGradeGVar;
        EmpLeaves."Leave Code" := LeaveCode;
        EmpLeaves."Leave Description" := GradeLeaves."Leave Description";
        EmpLeaves.INSERT();
    end;

    procedure InsertDetailLeaves(TotalLeaves: Decimal; LeaveCode: Code[20]);
    var
        DetailedLeaves: Record "Detailed Leave Records B2B";
        EmpHistoryLeaves: Record "Detailed Leave Records B2B";
        Num: Integer;
    begin
        if EmpHistoryLeaves.FINDLAST() then
            Num := EmpHistoryLeaves."Entry No." + 1
        else
            Num := 1;

        DetailedLeaves.INIT();
        DetailedLeaves."Entry No." := Num;
        DetailedLeaves."Employee No." := "Employee B2B"."No.";
        DetailedLeaves.VALIDATE("Leave Code", LeaveCode);
        DetailedLeaves."Entry Type" := DetailedLeaves."Entry Type"::Entitlement;
        DetailedLeaves."Entry Date" := ConfirmDateGVar;
        DetailedLeaves."Posting Date" := WORKDATE();
        DetailedLeaves."No. of Leaves" := TotalLeaves;
        DetailedLeaves.Month := DATE2DMY(ConfirmDateGVar, 2);
        DetailedLeaves.Year := DATE2DMY(ConfirmDateGVar, 3);

        EmpHistoryLeaves.RESET();
        EmpHistoryLeaves.SETRANGE("Employee No.", DetailedLeaves."Employee No.");
        EmpHistoryLeaves.SETRANGE("Entry Type", DetailedLeaves."Entry Type");
        EmpHistoryLeaves.SETRANGE("Leave Code", DetailedLeaves."Leave Code");
        EmpHistoryLeaves.SETRANGE(Month, DetailedLeaves.Month);
        EmpHistoryLeaves.SETRANGE(Year, DetailedLeaves.Year);
        if EmpHistoryLeaves.IsEmpty() then begin
            DetailedLeaves.INSERT();
            Num := Num + 1;
        end;
    end;
}

