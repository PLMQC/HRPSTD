report 33001219 Bonus_B2B
{
    // version B2BHR1.00.00

    Caption = 'Bonus';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                MonAttendance: Record "Monthly Attendance B2B";
            begin
                Window.UPDATE(1, "Employee B2B"."No.");
                StartMonth := DATE2DMY(FromDateGVar, 2);
                StartYear := DATE2DMY(FromDateGVar, 3);
                CheckMonth := DATE2DMY(ToDateGVar, 2);
                CheckYear := DATE2DMY(ToDateGVar, 3);
                if CheckMonth = 12 then
                    repeat
                        MonAttendance.RESET();
                        MonAttendance.SETRANGE("Employee Code", "Employee B2B"."No.");
                        MonAttendance.SETRANGE("Pay Slip Month", StartMonth);
                        MonAttendance.SETRANGE(Year, StartYear);
                        if MonAttendance.FINDFIRST() then
                            CalcBonusAmt(MonAttendance);
                        StartMonth := StartMonth + 1;
                        if StartMonth > 12 then begin
                            StartYear := StartYear + 1;
                            StartMonth := 1;
                        end;
                    until (StartMonth = 1) and (StartYear = CheckYear + 1)
                else
                    repeat
                        MonAttendance.RESET();
                        MonAttendance.SETRANGE("Employee Code", "Employee B2B"."No.");
                        MonAttendance.SETRANGE("Pay Slip Month", StartMonth);
                        MonAttendance.SETRANGE(Year, StartYear);
                        if MonAttendance.FINDFIRST() then
                            CalcBonusAmt(MonAttendance);
                        StartMonth := StartMonth + 1;
                        if StartMonth > 12 then begin
                            StartYear := StartYear + 1;
                            StartMonth := 1;
                        end;
                    until (StartMonth > CheckMonth) and (StartYear = CheckYear);

                PayBonus();
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                Window.OPEN(Text005Txt + Text006Txt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102152001)
                {
                    field(FromDate; FromDateGVar)
                    {
                        ToolTip = 'Choose the From date from which bonus calculates starts.';
                        Caption = 'From Date';
                        ApplicationArea = all;
                    }
                    field(ToDate; ToDateGVar)
                    {
                        ToolTip = 'Choose the To date bonus calcultaes up to that date.';
                        Caption = 'To Date';
                        ApplicationArea = all;
                    }
                    field(PayMonth; PayMonthGVar)
                    {
                        ToolTip = 'Choose the Pay month.';
                        Caption = 'Pay Month';
                        OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
                        ApplicationArea = all;
                    }
                    field(PayYear; PayYearGVar)
                    {
                        ToolTip = 'Choose the Pay Year of the bonus.';
                        Caption = 'Pay Year';
                        ApplicationArea = all;
                    }
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
        Window.CLOSE();
    end;

    trigger OnPreReport();
    begin
        if FromDateGVar = 0D then
            ERROR(Text003Txt);
        if ToDateGVar = 0D then
            ERROR(Text004Txt);

        if (PayMonthGVar = 0) then
            ERROR(Text001Txt);
        if PayYearGVar = 0 then
            ERROR(Text002Txt);

        case PayMonthGVar of
            1:
                MonthNo := 1;
            2:
                MonthNo := 2;
            3:
                MonthNo := 3;
            4:
                MonthNo := 4;
            5:
                MonthNo := 5;
            6:
                MonthNo := 6;
            7:
                MonthNo := 7;
            8:
                MonthNo := 8;
            9:
                MonthNo := 9;
            10:
                MonthNo := 10;
            11:
                MonthNo := 11;
            12:
                MonthNo := 12;
        end;
    end;

    var
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        FromDateGVar: Date;
        ToDateGVar: Date;
        StartMonth: Integer;
        StartYear: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        PayYearGVar: Integer;
        Text001Txt: Label 'The month value cannot be left blank please choose a month.';
        Text002Txt: Label 'The year value cannot be left blank please choose a year.';
        MonthNo: Integer;
        PayMonthGVar: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        Text003Txt: Label 'Fromdate should not be empty.';
        Text004Txt: Label 'Todate should not be empty.';
        Text005Txt: Label 'Bonus Calculation for\';
        Text006Txt: Label 'Employee       #1#################\', Comment = '%1 = No';
        Window: Dialog;

        BONUSTxt: Label 'BONUS';
        ExGratiaTxt: Label 'Ex-Gratia';
        PAYCADRETxt: Label 'PAY CADRE';

    procedure CalcBonusAmt(MonAttendance: Record "Monthly Attendance B2B");
    var
        Lookup_B2B: Record Lookup_B2B;
        ProcSalary: Record "Processed Salary B2B";
        PayElements: Record "Pay Elements B2B";
        Bonus: Record Bonus_B2B;
        BonussableAmt: Decimal;
        BonusOnAttendance: Decimal;
        BonusAmount: Decimal;
        TotalBonus: Decimal;
        TotalExgratia: Decimal;
        TotalExgratiaBonus: Decimal;
        ExgratiaAmount: Decimal;
        BonusCalculation: Boolean;
        ExgratiaCalculation: Boolean;
        BonusorExgratia: Code[20];
    begin
        Lookup_B2B.RESET();
        Lookup_B2B.SETRANGE("LookupType Name", PAYCADRETxt);
        Lookup_B2B.SETRANGE("Lookup Name", "Employee B2B"."Pay Cadre");
        if Lookup_B2B.FINDFIRST() then
            if Lookup_B2B."Incentive Applicable" = Lookup_B2B."Incentive Applicable"::Bonus then
                BonusCalculation := true
            else
                if Lookup_B2B."Incentive Applicable" = Lookup_B2B."Incentive Applicable"::"Ex-gratia" then
                    ExgratiaCalculation := true;

        if BonusCalculation then begin
            BonusAmount := 0;
            PayElements.RESET();
            PayElements.SETRANGE("Employee Code", "Employee B2B"."No.");
            if PayElements.FINDFIRST() then
                repeat
                    if (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::" ") and
                       (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::"Ex-gratia")
                    then begin
                        ProcSalary.SETRANGE("Employee Code", PayElements."Employee Code");
                        ProcSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
                        ProcSalary.SETRANGE(Year, MonAttendance.Year);
                        ProcSalary.SETRANGE("Add/Deduct Code", PayElements."Pay Element Code");
                        if ProcSalary.FINDFIRST() then
                            if ProcSalary."Add/Deduct" = ProcSalary."Add/Deduct"::Addition then
                                BonusAmount := BonusAmount + ProcSalary."Earned Amount"
                            else
                                if ProcSalary."Add/Deduct" = ProcSalary."Add/Deduct"::Deduction then
                                    BonusAmount := BonusAmount - ProcSalary."Earned Amount"
                    end;
                until PayElements.NEXT() = 0;
            Bonus.RESET();
            if Bonus.FINDFIRST() then
                repeat
                    if Bonus."Effective Date" <= MonAttendance."Period End Date" then
                        BonussableAmt := Bonus."Min.Bonusable Salary";
                until Bonus.NEXT() = 0;

            MonAttendance.CALCFIELDS(Days);
            MonAttendance.CALCFIELDS(Attendance);
            BonusOnAttendance := (BonussableAmt * MonAttendance.Attendance) / MonAttendance.Days;
            if BonusOnAttendance < BonusAmount then
                TotalBonus := BonusOnAttendance
            else
                TotalBonus := BonusAmount;
            BonusorExgratia := BONUSTxt;
            InsertBonusRecords(MonAttendance, TotalBonus, BonusorExgratia);
        end;

        if ExgratiaCalculation then begin
            ExgratiaAmount := 0;
            PayElements.RESET();
            PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            if PayElements.FINDFIRST() then
                repeat
                    if (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::" ") and
                       (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::Bonus)
                    then begin
                        ProcSalary.SETRANGE("Employee Code", PayElements."Employee Code");
                        ProcSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
                        ProcSalary.SETRANGE(Year, MonAttendance.Year);
                        ProcSalary.SETRANGE("Add/Deduct Code", PayElements."Pay Element Code");
                        if ProcSalary.FINDFIRST() then
                            if ProcSalary."Add/Deduct" = ProcSalary."Add/Deduct"::Addition then
                                ExgratiaAmount := ExgratiaAmount + ProcSalary."Earned Amount"
                            else
                                if ProcSalary."Add/Deduct" = ProcSalary."Add/Deduct"::Deduction then
                                    ExgratiaAmount := ExgratiaAmount - ProcSalary."Earned Amount"
                    end;
                until PayElements.NEXT() = 0;

            Bonus.RESET();
            if Bonus.FINDFIRST() then
                repeat
                    if Bonus."Effective Date" <= MonAttendance."Period End Date" then
                        BonussableAmt := Bonus."Bonus Amount";
                    ;
                    TotalExgratiaBonus := Bonus."Min.Bonusable Salary";
                until Bonus.NEXT() = 0;


            if ExgratiaAmount < BonussableAmt then begin
                TotalExgratiaBonus := TotalExgratiaBonus;
                TotalExgratia := BonussableAmt - TotalExgratiaBonus;
                BonusorExgratia := BONUSTxt;
                InsertBonusRecords(MonAttendance, TotalExgratiaBonus, BonusorExgratia);
                BonusorExgratia := ExGratiaTxt;
                InsertBonusRecords(MonAttendance, TotalExgratia, BonusorExgratia);
            end else begin
                TotalExgratia := ExgratiaAmount;
                BonusorExgratia := ExGratiaTxt;
                InsertBonusRecords(MonAttendance, TotalExgratia, BonusorExgratia);
            end;
        end;
    end;

    procedure InsertBonusRecords(MonAttendance: Record "Monthly Attendance B2B"; Total: Decimal; bonusorexgratia: Code[20]);
    var
        ProcessedSalary: Record "Processed Salary B2B";
        ProcSalary: Record "Processed Salary B2B";
        Bonus: Record Bonus_B2B;
        Amount: Decimal;
    begin
        MonAttendance.CALCFIELDS(Attendance);
        MonAttendance.CALCFIELDS(Days);

        ProcSalary.SETRANGE("Document Type", ProcSalary."Document Type"::Payroll);
        ProcSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
        ProcSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
        ProcSalary.SETRANGE(Year, MonAttendance.Year);
        if ProcSalary.FINDFIRST() then begin
            ProcSalary.INIT();
            ProcSalary."Employee Code" := MonAttendance."Employee Code";
            ProcSalary."Add/Deduct Code" := bonusorexgratia;
            ProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            ProcSalary.Year := MonAttendance.Year;
            ProcSalary."Document Type" := ProcSalary."Document Type"::Payroll;
            ProcSalary.Attendance := MonAttendance.Attendance;
            ProcSalary.Days := MonAttendance.Days;
            ProcSalary."Pay Cadre" := MonAttendance.PayCadre;
            ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
            ProcessedSalary.SETRANGE("Employee Code", ProcSalary."Employee Code");
            ProcessedSalary.SETRANGE("Pay Slip Month", ProcSalary."Pay Slip Month");
            ProcessedSalary.SETRANGE(Year, ProcSalary.Year);
            if ProcessedSalary.FINDLAST() then
                ProcSalary."Line No." := ProcessedSalary."Line No." + 10000
            else
                ProcSalary."Line No." := 10000;
            ProcSalary."Fixed/Percent" := ProcSalary."Fixed/Percent"::Fixed;
            ProcSalary."Earned Amount" := 0;
            ProcSalary.Salary := Total;
            ProcSalary."Add/Deduct" := ProcSalary."Add/Deduct"::Addition;
            ProcSalary.Attendance := MonAttendance.Attendance;
            ProcSalary.Days := MonAttendance.Days;
            if bonusorexgratia = BONUSTxt then begin
                Bonus.RESET();
                if Bonus.FINDFIRST() then
                    repeat
                        if Bonus."Effective Date" <= MonAttendance."Period End Date" then
                            Amount := (Total * Bonus."Bonus%") / 100;
                    until Bonus.NEXT() = 0;
            end;
            if bonusorexgratia = ExGratiaTxt then begin
                Bonus.RESET();
                if Bonus.FINDFIRST() then
                    repeat
                        if Bonus."Effective Date" <= MonAttendance."Period End Date" then
                            Amount := (Total * Bonus."Ex-gratia%") / 100;
                    until Bonus.NEXT() = 0;
            end;
            ProcSalary."Bonus/Exgratia" := Amount;
            ProcSalary.INSERT();
        end;
    end;

    procedure PayBonus();
    var
        ProcSalary: Record "Processed Salary B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        TempProcSalary: Record "Temp Processed Salary B2B";
        TempProcessedSalary: Record "Temp Processed Salary B2B";
        BonusAmount: Decimal;
        ExgratiaAmount: Decimal;
        Flag: Boolean;
    begin
        StartMonth := DATE2DMY(FromDateGVar, 2);
        StartYear := DATE2DMY(FromDateGVar, 3);
        CheckMonth := DATE2DMY(ToDateGVar, 2);
        CheckYear := DATE2DMY(ToDateGVar, 3);
        if CheckMonth = 12 then
            repeat
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", "Employee B2B"."No.");
                ProcessedSalary.SETRANGE("Pay Slip Month", StartMonth);
                ProcessedSalary.SETRANGE(Year, StartYear);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        if ProcessedSalary."Add/Deduct Code" = BONUSTxt then
                            BonusAmount := BonusAmount + ProcessedSalary."Bonus/Exgratia"
                        else
                            if ProcessedSalary."Add/Deduct Code" = ExGratiaTxt then
                                ExgratiaAmount := ExgratiaAmount + ProcessedSalary."Bonus/Exgratia";
                    until ProcessedSalary.NEXT() = 0;

                StartMonth := StartMonth + 1;
                if StartMonth > 12 then begin
                    StartYear := StartYear + 1;
                    StartMonth := 1;
                end;
            until (StartMonth = 1) and (StartYear = CheckYear + 1)
        else
            repeat
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", "Employee B2B"."No.");
                ProcessedSalary.SETRANGE("Pay Slip Month", StartMonth);
                ProcessedSalary.SETRANGE(Year, StartYear);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        if ProcessedSalary."Add/Deduct Code" = BONUSTxt then
                            BonusAmount := BonusAmount + ProcessedSalary."Bonus/Exgratia"
                        else
                            if ProcessedSalary."Add/Deduct Code" = ExGratiaTxt then
                                ExgratiaAmount := ExgratiaAmount + ProcessedSalary."Bonus/Exgratia";
                    until ProcessedSalary.NEXT() = 0;

                StartMonth := StartMonth + 1;
                if StartMonth > 12 then begin
                    StartYear := StartYear + 1;
                    StartMonth := 1;
                end;
            until (StartMonth > CheckMonth) and (StartYear = CheckYear);

        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", "Employee B2B"."No.");
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthNo);
        ProcessedSalary.SETRANGE(Year, PayYearGVar);
        if ProcessedSalary.FINDFIRST() then begin
            repeat
                if ProcessedSalary."Add/Deduct Code" = BONUSTxt then begin
                    ProcessedSalary."Earned Amount" := BonusAmount;
                    ProcessedSalary.MODIFY();
                    Flag := true;
                end else
                    if ProcessedSalary."Add/Deduct Code" = ExGratiaTxt then begin
                        ProcessedSalary."Earned Amount" := ExgratiaAmount;
                        ProcessedSalary.MODIFY();
                        Flag := true;
                    end
            until ProcessedSalary.NEXT() = 0;

            if not Flag then begin
                if BonusAmount <> 0 then begin
                    ProcSalary.INIT();
                    ProcSalary."Employee Code" := "Employee B2B"."No.";
                    ProcSalary."Add/Deduct Code" := BONUSTxt;
                    ProcSalary."Pay Slip Month" := MonthNo;
                    ProcSalary.Year := PayYearGVar;
                    ProcSalary."Document Type" := ProcSalary."Document Type"::Payroll;
                    ProcSalary."Pay Cadre" := "Employee B2B"."Pay Cadre";
                    ProcessedSalary.RESET();
                    ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                    ProcessedSalary.SETRANGE("Employee Code", ProcSalary."Employee Code");
                    ProcessedSalary.SETRANGE("Pay Slip Month", ProcSalary."Pay Slip Month");
                    ProcessedSalary.SETRANGE(Year, ProcSalary.Year);
                    if ProcessedSalary.FINDLAST() then
                        ProcSalary."Line No." := ProcessedSalary."Line No." + 10000
                    else
                        ProcSalary."Line No." := 10000;
                    ProcSalary."Fixed/Percent" := ProcSalary."Fixed/Percent"::Fixed;
                    ProcSalary."Earned Amount" := BonusAmount;
                    ProcSalary."Add/Deduct" := ProcSalary."Add/Deduct"::Addition;
                    ProcSalary.INSERT();
                end;
                if ExgratiaAmount <> 0 then begin
                    ProcSalary.INIT();
                    ProcSalary."Employee Code" := "Employee B2B"."No.";
                    ProcSalary."Add/Deduct Code" := ExGratiaTxt;
                    ProcSalary."Pay Slip Month" := MonthNo;
                    ProcSalary.Year := PayYearGVar;
                    ProcSalary."Document Type" := ProcSalary."Document Type"::Payroll;
                    ProcSalary."Pay Cadre" := "Employee B2B"."Pay Cadre";
                    ProcessedSalary.RESET();
                    ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                    ProcessedSalary.SETRANGE("Employee Code", ProcSalary."Employee Code");
                    ProcessedSalary.SETRANGE("Pay Slip Month", ProcSalary."Pay Slip Month");
                    ProcessedSalary.SETRANGE(Year, ProcSalary.Year);
                    if ProcessedSalary.FINDLAST() then
                        ProcSalary."Line No." := ProcessedSalary."Line No." + 10000
                    else
                        ProcSalary."Line No." := 10000;
                    ProcSalary."Fixed/Percent" := ProcSalary."Fixed/Percent"::Fixed;
                    ProcSalary."Earned Amount" := ExgratiaAmount;
                    ProcSalary."Add/Deduct" := ProcSalary."Add/Deduct"::Addition;
                    ProcSalary.INSERT()
                end;
            end;
        end else begin
            if ExgratiaAmount <> 0 then begin
                TempProcSalary.INIT();
                TempProcSalary."Employee Code" := "Employee B2B"."No.";
                TempProcSalary."Add/Deduct Code" := ExGratiaTxt;
                TempProcSalary."Pay Slip Month" := MonthNo;
                TempProcSalary.Year := PayYearGVar;
                TempProcSalary."Document Type" := TempProcSalary."Document Type"::Payroll;
                TempProcessedSalary.RESET();
                TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
                TempProcessedSalary.SETRANGE("Employee Code", TempProcSalary."Employee Code");
                TempProcessedSalary.SETRANGE("Pay Slip Month", TempProcSalary."Pay Slip Month");
                TempProcessedSalary.SETRANGE(Year, TempProcSalary.Year);
                if TempProcessedSalary.FINDLAST() then
                    TempProcSalary."Line No." := TempProcessedSalary."Line No." + 10000
                else
                    TempProcSalary."Line No." := 10000;
                TempProcSalary."Fixed/Percent" := TempProcSalary."Fixed/Percent"::Fixed;
                TempProcSalary."Earned Amount" := ExgratiaAmount;
                TempProcSalary."Add/Deduct" := TempProcSalary."Add/Deduct"::Addition;
                TempProcSalary.INSERT()
            end;
            if BonusAmount <> 0 then begin
                TempProcSalary.INIT();
                TempProcSalary."Employee Code" := "Employee B2B"."No.";
                TempProcSalary."Add/Deduct Code" := BONUSTxt;
                TempProcSalary."Pay Slip Month" := MonthNo;
                TempProcSalary.Year := PayYearGVar;
                TempProcSalary."Document Type" := TempProcSalary."Document Type"::Payroll;
                TempProcessedSalary.RESET();
                TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
                TempProcessedSalary.SETRANGE("Employee Code", TempProcSalary."Employee Code");
                TempProcessedSalary.SETRANGE("Pay Slip Month", TempProcSalary."Pay Slip Month");
                TempProcessedSalary.SETRANGE(Year, TempProcSalary.Year);
                if TempProcessedSalary.FINDLAST() then
                    TempProcSalary."Line No." := TempProcessedSalary."Line No." + 10000
                else
                    TempProcSalary."Line No." := 10000;
                TempProcSalary."Fixed/Percent" := TempProcSalary."Fixed/Percent"::Fixed;
                TempProcSalary."Earned Amount" := BonusAmount;
                TempProcSalary."Add/Deduct" := TempProcSalary."Add/Deduct"::Addition;
                TempProcSalary.INSERT()
            end;
        end;
    end;
}

