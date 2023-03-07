codeunit 33001196 "TDS Calculations B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
        UpdateTDSRecords();
        Window.CLOSE();
    end;

    var
        Text002Txt: Label 'Employee       #1#################\', Comment = '%1 = No';
        Window: Dialog;
        Text33001Txt: Label 'FINANCIAL YEAR';
        Text33003Txt: Label '<1M>';
        Text33004Txt: Label 'BASIC';
        Text33005Txt: Label 'ON ATTENDANCE';
        Text33006Txt: Label 'NON ATTENDANCE';
        Text33007Txt: Label 'AFTER BASIC';
        Text33008Txt: Label 'AFTER BASIC AND DA';
        Text33009Txt: Label 'DA';

    procedure InsertRecords(TDSDeduction: Record "Emp TDS Deduction B2B"; Total: Decimal; Month: Integer; Year: Integer);
    var
        ExpSalComp: Record "Expected Sal Computation B2B";
        ExpSalComputation: Record "Expected Sal Computation B2B";
    begin
        ExpSalComp.INIT();
        ExpSalComp."Employee Code" := TDSDeduction."Employee No.";
        ExpSalComp.Month := Month;
        ExpSalComp.Year := Year;
        ExpSalComp."Expected Salary" := Total;

        ExpSalComputation.SETRANGE("Employee Code", ExpSalComp."Employee Code");
        ExpSalComputation.SETRANGE(Month, ExpSalComp.Month);
        ExpSalComputation.SETRANGE(Year, ExpSalComp.Year);
        if ExpSalComputation.IsEmpty() then
            ExpSalComp.INSERT();
    end;

    procedure InsertTDS(Employee: Record "Employee B2B"; StartingDate: Date; EndingDate: Date; Days: Decimal);
    var
        TDSDeduction: Record "Emp TDS Deduction B2B";
        TDSDeduction2: Record "Emp TDS Deduction B2B";
    begin
        if not Employee.Blocked then begin
            TDSDeduction.INIT();
            TDSDeduction."Employee No." := Employee."No.";
            TDSDeduction."Year Starting Date" := StartingDate;
            TDSDeduction."Year Ending Date" := EndingDate;
            TDSDeduction."Remaining Months" := Days div 30;

            TDSDeduction2.SETRANGE("Employee No.", TDSDeduction."Employee No.");
            if TDSDeduction2.IsEmpty() then
                TDSDeduction.INSERT();
        end;
    end;

    procedure TDSScheduleCalc(TDSDeduction: Record "Emp TDS Deduction B2B");
    var
        TDSSchedule: Record "Emp TDS Schedule B2B";
        Months: Integer;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        i: Integer;
    begin
        Months := (TDSDeduction."Year Ending Date" - TDSDeduction."Year Starting Date") div 30;
        CurrentMonth := DATE2DMY(TDSDeduction."Year Starting Date", 2);
        CurrentYear := DATE2DMY(TDSDeduction."Year Starting Date", 3);

        for i := 1 to Months do begin
            TDSSchedule.INIT();
            TDSSchedule."Employee No." := TDSDeduction."Employee No.";
            TDSSchedule."Year Starting Date" := TDSDeduction."Year Starting Date";
            TDSSchedule."Year Ending Date" := TDSDeduction."Year Ending Date";
            TDSSchedule.Month := CurrentMonth;
            TDSSchedule."TDS Amount" := TDSDeduction."Tax Per Month";
            TDSSchedule.Year := CurrentYear;
            TDSSchedule.INSERT();
            CurrentMonth := CurrentMonth + 1;
            if CurrentMonth > 12 then begin
                CurrentMonth := 1;
                CurrentYear := CurrentYear + 1;
            end;
        end;
    end;

    procedure UpdateTDSRecords();
    var
        Employee: Record "Employee B2B";
        TDSDeduction: Record "Emp TDS Deduction B2B";
        PayYear: Record "Payroll Year B2B";
        Days: Decimal;
        StartingDate: Date;
        EndingDate: Date;
    begin
        Window.OPEN(Text002Txt);

        PayYear.FINDFIRST();
        PayYear.SETRANGE("Year Type", Text33001Txt);
        PayYear.SETRANGE(Closed, false);
        if PayYear.FINDFIRST() then begin
            StartingDate := PayYear."Year Start Date";
            EndingDate := PayYear."Year End Date";
            Days := EndingDate - StartingDate;
        end;


        Employee.SETRANGE(Blocked, false);
        if Employee.FINDFIRST() then
            repeat
                InsertTDS(Employee, StartingDate, EndingDate, Days);
            until Employee.NEXT() = 0;

        if TDSDeduction.FINDFIRST() then
            repeat
                Window.UPDATE(1, TDSDeduction."Employee No.");
                VADProcess(TDSDeduction);
            until TDSDeduction.NEXT() = 0;
    end;

    procedure VADProcess(TDSDeduction: Record "Emp TDS Deduction B2B");
    var
        ProcessedSalary: Record "Processed Salary B2B";
        PayElement: Record "Pay Elements B2B";
        Total: Decimal;
        Amount: Decimal;
        StartMonth: Integer;
        StartYear: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := TDSDeduction."Year Starting Date";
        EndDate := TDSDeduction."Year Ending Date";
        StartMonth := DATE2DMY(StartDate, 2);
        StartYear := DATE2DMY(StartDate, 3);
        CheckMonth := DATE2DMY(EndDate, 2);
        CheckYear := DATE2DMY(EndDate, 3);
        if CheckMonth = 12 then begin
            Amount := 0;
            repeat
                Total := 0;
                ProcessedSalary.SETRANGE("Employee Code", TDSDeduction."Employee No.");
                ProcessedSalary.SETFILTER(Year, '=%1', StartYear);
                ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', StartMonth);
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        Total := Total + ProcessedSalary."Earned Amount";
                    until ProcessedSalary.NEXT() = 0
                else begin
                    EndDate := CALCDATE(Text33003Txt, StartDate) - 1;
                    Total := GrossSalaryCalc(TDSDeduction, StartDate, EndDate);
                end;

                Amount := Amount + Total;

                InsertRecords(TDSDeduction, Total, StartMonth, StartYear);

                PayElement.RESET();
                PayElement.SETRANGE("Employee Code", TDSDeduction."Employee No.");
                if PayElement.FINDFIRST() then
                    repeat
                        PayElement.Processed := false;
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                StartDate := CALCDATE(Text33003Txt, StartDate);
                StartMonth := StartMonth + 1;
                if StartMonth > 12 then begin
                    StartYear := StartYear + 1;
                    StartMonth := 1;
                end;

                TDSDeduction."Gross Salary" := Amount;
                TDSDeduction.MODIFY();

            until (StartMonth = 1) and (StartYear = CheckYear + 1);
        end else begin
            Amount := 0;
            repeat
                Total := 0;

                ProcessedSalary.SETRANGE("Employee Code", TDSDeduction."Employee No.");
                ProcessedSalary.SETFILTER(Year, '=%1', StartYear);
                ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', StartMonth);
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        Total := Total + ProcessedSalary."Earned Amount";
                    until ProcessedSalary.NEXT() = 0
                else begin
                    EndDate := CALCDATE(Text33003Txt, StartDate) - 1;
                    Total := GrossSalaryCalc(TDSDeduction, StartDate, EndDate);
                end;

                Amount := Amount + Total;
                InsertRecords(TDSDeduction, Total, StartMonth, StartYear);

                PayElement.RESET();
                PayElement.SETRANGE("Employee Code", TDSDeduction."Employee No.");
                if PayElement.FINDFIRST() then
                    repeat
                        PayElement.Processed := false;
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                StartDate := CALCDATE(Text33003Txt, StartDate);
                StartMonth := StartMonth + 1;
                if StartMonth > 12 then begin
                    StartYear := StartYear + 1;
                    StartMonth := 1;
                end;

                TDSDeduction."Gross Salary" := Amount;
                TDSDeduction.MODIFY();

            until (StartMonth > CheckMonth) and (StartYear = CheckYear);
        end;
    end;

    procedure GrossSalaryCalc(TDSDeduction: Record "Emp TDS Deduction B2B"; StartDatesrc: Date; Enddatesrc: Date): Decimal;
    var
        PayElement: Record "Pay Elements B2B";
        VAD: Record "Pay Elements B2B";
        VAD2: Record "Pay Elements B2B";
        Basic: Decimal;
        DA: Decimal;
        Total: Decimal;
        "Sum": Decimal;
        Sum2: Decimal;
        Amount: Decimal;
        NoofDays: Decimal;
        Days: Decimal;
        Month: Integer;
        Year: Integer;
        StartDate: Date;
        EndDate: Date;
        StartDate2: Date;
        CheckDate: Date;
    begin
        DA := 0;
        Month := DATE2DMY(TDSDeduction."Year Starting Date", 2);
        Year := DATE2DMY(TDSDeduction."Year Starting Date", 3);
        Days := Enddatesrc - StartDatesrc + 1;
        PayElement.SETRANGE(Processed, false);
        PayElement.SETRANGE("Employee Code", TDSDeduction."Employee No.");
        PayElement.SETRANGE("Add/Deduct", PayElement."Add/Deduct"::Addition);
        if PayElement.FINDFIRST() then begin
            repeat
                Total := 0;
                Sum := 0;
                StartDate := StartDatesrc;
                EndDate := Enddatesrc;
                VAD.RESET();
                VAD.SETRANGE("Employee Code", PayElement."Employee Code");
                VAD.SETRANGE("Pay Element Code", PayElement."Pay Element Code");
                if VAD.FINDFIRST() then
                    repeat
                        NoofDays := 0;
                        if (VAD."Effective Start Date" > StartDate) and (VAD."Effective Start Date" <= EndDate) then begin
                            NoofDays := VAD."Effective Start Date" - StartDate;
                            StartDate2 := StartDate;
                            StartDate := VAD."Effective Start Date";
                            VAD2.RESET();
                            VAD2.SETRANGE("Employee Code", VAD."Employee Code");
                            VAD2.SETRANGE("Pay Element Code", VAD."Pay Element Code");
                            if VAD2.FINDFIRST() then begin
                                CheckDate := VAD2."Effective Start Date";
                                repeat
                                    VAD2.Processed := true;
                                    VAD2.MODIFY();
                                    if (VAD2."Effective Start Date" >= CheckDate) and (VAD2."Effective Start Date" <= StartDate2) then begin
                                        if VAD2."Pay Element Code" = Text33004Txt then begin
                                            if (VAD2."Computation Type" = Text33005Txt) then begin
                                                Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                                Basic := Total;
                                            end else
                                                if (VAD2."Computation Type" = Text33006Txt) then begin
                                                    Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                                    Basic := Total;
                                                end;
                                        end else
                                            if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) then begin
                                                if (VAD2."Computation Type" = Text33005Txt) then
                                                    Total := (NoofDays / Days) * VAD2."Amount / Percent"
                                                else
                                                    Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                            end else
                                                if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                                   (VAD2."Computation Type" = Text33007Txt)
                                       then
                                                    Total := (VAD2."Amount / Percent" * Basic) / 100
                                                else
                                                    if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                                       (VAD2."Computation Type" = Text33008Txt)
                                               then
                                                        Total := (VAD2."Amount / Percent" * (Basic + DA)) / 100;
                                        if VAD2."Pay Element Code" = Text33009Txt then
                                            DA := Total;
                                    end;
                                until VAD2.NEXT() = 0;
                            end;
                            Sum := Sum + Total;
                        end;
                    until VAD.NEXT() = 0;

                VAD2.RESET();
                VAD2.SETRANGE("Employee Code", VAD."Employee Code");
                VAD2.SETRANGE("Pay Element Code", VAD."Pay Element Code");
                if VAD2.FINDFIRST() then begin
                    CheckDate := VAD2."Effective Start Date";
                    NoofDays := EndDate - StartDate + 1;
                    repeat
                        VAD2.Processed := true;
                        VAD2.MODIFY();
                        if (VAD2."Effective Start Date" >= CheckDate) and (VAD2."Effective Start Date" <= StartDate) then begin
                            if VAD2."Pay Element Code" = Text33004Txt then begin
                                if (VAD2."Computation Type" = Text33005Txt) then begin
                                    Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                    Basic := Total;
                                end else
                                    if (VAD2."Computation Type" = Text33006Txt) then begin
                                        Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                        Basic := Total;
                                    end;
                            end else
                                if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) then begin
                                    if (VAD2."Computation Type" = Text33005Txt) then
                                        Total := (NoofDays / Days) * VAD2."Amount / Percent"
                                    else
                                        Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                end else
                                    if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                       (VAD2."Computation Type" = Text33007Txt)
                           then
                                        Total := (VAD2."Amount / Percent" * Basic) / 100
                                    else
                                        if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                           (VAD2."Computation Type" = Text33008Txt)
                                   then
                                            Total := (VAD2."Amount / Percent" * (Basic + DA)) / 100;

                            if VAD2."Pay Element Code" = Text33009Txt then
                                DA := Total;
                        end;
                    until VAD2.NEXT() = 0;
                end;
                Sum2 := Sum + Total;
                Amount := Amount + Sum2;
            until PayElement.NEXT() = 0;
            exit(Amount);
        end;
    end;

    procedure TDSReSchedule();
    var
        TDSDeduction: Record "Emp TDS Deduction B2B";
    begin
        Window.OPEN(Text002Txt);
        if TDSDeduction.FINDFIRST() then
            repeat
                Window.UPDATE(1, TDSDeduction."Employee No.");
                VADProcess(TDSDeduction);
                TDSReScheduleCalc(TDSDeduction);
            until TDSDeduction.NEXT() = 0;
        Window.CLOSE();
    end;

    procedure TDSReScheduleCalc(TDSDeduction: Record "Emp TDS Deduction B2B");
    var
        TDSSchedule: Record "Emp TDS Schedule B2B";
        Months: Integer;
        DeductedAmount: Decimal;
        TotalAmount: Decimal;
        TaxAmount: Decimal;
    begin
        Months := TDSDeduction."Remaining Months";

        TDSSchedule.CALCFIELDS("TDS Amount Deducted");
        TDSSchedule.SETRANGE("Employee No.", TDSDeduction."Employee No.");
        TDSSchedule.SETRANGE("Year Starting Date", TDSDeduction."Year Starting Date");
        TDSSchedule.SETRANGE("Year Ending Date", TDSDeduction."Year Ending Date");
        TDSSchedule.SETFILTER("TDS Amount Deducted", '<>0');
        if TDSSchedule.FINDFIRST() then
            repeat
                TDSSchedule.CALCFIELDS("TDS Amount Deducted");
                DeductedAmount := DeductedAmount + TDSSchedule."TDS Amount Deducted";
            until TDSSchedule.NEXT() = 0;

        TotalAmount := TDSDeduction."Tax Liability after savings" - DeductedAmount;
        TaxAmount := TotalAmount / Months;

        TDSSchedule.RESET();
        TDSSchedule.CALCFIELDS("TDS Amount Deducted");
        TDSSchedule.SETRANGE("Employee No.", TDSDeduction."Employee No.");
        TDSSchedule.SETRANGE("Year Starting Date", TDSDeduction."Year Starting Date");
        TDSSchedule.SETRANGE("Year Ending Date", TDSDeduction."Year Ending Date");
        TDSSchedule.SETFILTER("TDS Amount Deducted", '=0');
        if TDSSchedule.FINDFIRST() then
            repeat
                TDSSchedule."TDS Amount" := TaxAmount;
                TDSSchedule.MODIFY();
            until TDSSchedule.NEXT() = 0;
    end;

    procedure UpdateTDSRecordsNew(StartDate: Date; EndDate: Date);
    var
        Employee: Record "Employee B2B";
        TDSDeduction: Record "Emp TDS Deduction B2B";
        Days: Decimal;
        StartingDate: Date;
        EndingDate: Date;
    begin
        Window.OPEN(Text002Txt);
        StartingDate := StartDate;
        EndingDate := EndDate;
        Days := EndingDate - StartingDate;
        Employee.SETRANGE(Blocked, false);
        if Employee.FINDFIRST() then
            repeat
                InsertTDS(Employee, StartingDate, EndingDate, Days);
            until Employee.NEXT() = 0;

        if TDSDeduction.FINDFIRST() then
            repeat
                Window.UPDATE(1, TDSDeduction."Employee No.");
                VADProcess(TDSDeduction);
            until TDSDeduction.NEXT() = 0;
        Window.CLOSE();
    end;
}

