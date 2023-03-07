report 33001220 "Bonus Adjust B2B"
{
    // version B2BHR1.00.00

    Caption = 'Bonus Adjust';
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
                        ToolTip = 'Choose the To date for bonus Adjust calcultaes up to that date. ';
                        Caption = 'To Date';
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

        case PayMonth of
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
        PayYear: Integer;
        MonthNo: Integer;
        PayMonth: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
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
            TotalBonus := 0;
            BonussableAmt := 0;
            BonusOnAttendance := 0;
            PayElements.RESET();
            PayElements.SETRANGE("Employee Code", "Employee B2B"."No.");
            if PayElements.FINDFIRST() then
                repeat
                    if (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::" ") and
                       (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::"Ex-gratia")
                    then begin
                        BonusAmount := 0;
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
            TotalExgratia := 0;
            TotalExgratiaBonus := 0;
            BonussableAmt := 0;
            TotalExgratiaBonus := 0;
            PayElements.RESET();
            PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            if PayElements.FINDFIRST() then
                repeat
                    if (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::" ") and
                       (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::Bonus)
                    then begin
                        ExgratiaAmount := 0;
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
        BonusAdj: Record "Bonus Adjust B2B";
        BonusAdjust: Record "Bonus Adjust B2B";
        Bonus: Record Bonus_B2B;
        Amount: Decimal;
    begin
        MonAttendance.CALCFIELDS(Attendance);
        MonAttendance.CALCFIELDS(Days);
        BonusAdjust.INIT();
        BonusAdjust."Employee Code" := MonAttendance."Employee Code";
        BonusAdjust."Employee Name" := CopyStr(MonAttendance."Employee Name", 1, 50);
        BonusAdjust."Pay Element Code" := bonusorexgratia;
        BonusAdjust.Month := MonAttendance."Pay Slip Month";
        BonusAdjust.Year := MonAttendance.Year;
        BonusAdj.SETRANGE("Employee Code", BonusAdjust."Employee Code");
        BonusAdj.SETRANGE(Month, BonusAdjust.Month);
        BonusAdj.SETRANGE(Year, BonusAdjust.Year);
        if BonusAdj.FINDLAST() then
            BonusAdjust."Line No." := BonusAdj."Line No." + 10000
        else
            BonusAdjust."Line No." := 10000;
        BonusAdjust."Bonus/Exgratia Amt" := 0;
        BonusAdjust.Salary := Total;
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
        BonusAdjust."Bonus/Exgratia Amt" := Amount;
        BonusAdjust.INSERT();
    end;

    procedure PayBonus();
    var
        BonusAdjust: Record "Bonus Adjust B2B";
        BonusAdj: Record "Bonus Adjust B2B";
        BonusAmount: Decimal;
        ExgratiaAmount: Decimal;
        Flag: Boolean;
    begin
        StartMonth := DATE2DMY(FromDateGVar, 2);
        StartYear := DATE2DMY(FromDateGVar, 3);
        CheckMonth := DATE2DMY(ToDateGVar, 2);
        CheckYear := DATE2DMY(ToDateGVar, 3);
        PayYear := CheckYear;
        if CheckMonth = 12 then
            repeat
                BonusAdj.RESET();
                BonusAdj.SETRANGE("Employee Code", "Employee B2B"."No.");
                BonusAdj.SETRANGE(Month, StartMonth);
                BonusAdj.SETRANGE(Year, StartYear);
                if BonusAdj.FINDFIRST() then
                    repeat
                        if BonusAdj."Pay Element Code" = BONUSTxt then
                            BonusAmount := BonusAmount + BonusAdj."Bonus/Exgratia Amt"
                        else
                            if BonusAdj."Pay Element Code" = ExGratiaTxt then
                                ExgratiaAmount := ExgratiaAmount + BonusAdj."Bonus/Exgratia Amt";
                    until BonusAdj.NEXT() = 0;
                StartMonth := StartMonth + 1;

                if StartMonth > 12 then begin
                    StartYear := StartYear + 1;
                    StartMonth := 1;
                end;
            until (StartMonth = 1) and (StartYear = CheckYear + 1)
        else
            repeat
                BonusAdj.RESET();
                BonusAdj.SETRANGE("Employee Code", "Employee B2B"."No.");
                BonusAdj.SETRANGE(Month, StartMonth);
                BonusAdj.SETRANGE(Year, StartYear);
                if BonusAdj.FINDFIRST() then
                    repeat
                        if BonusAdj."Pay Element Code" = BONUSTxt then
                            BonusAmount := BonusAmount + BonusAdj."Bonus/Exgratia Amt"
                        else
                            if BonusAdj."Pay Element Code" = ExGratiaTxt then
                                ExgratiaAmount := ExgratiaAmount + BonusAdj."Bonus/Exgratia Amt";
                    until BonusAdj.NEXT() = 0;


                StartMonth := StartMonth + 1;
                if StartMonth > 12 then begin
                    StartYear := StartYear + 1;
                    StartMonth := 1;
                end;

            until (StartMonth > CheckMonth) and (StartYear = CheckYear);

        BonusAdj.RESET();
        BonusAdj.SETRANGE("Employee Code", "Employee B2B"."No.");
        BonusAdj.SETRANGE(Month, MonthNo);
        BonusAdj.SETRANGE(Year, PayYear);
        if BonusAdj.FINDFIRST() then begin
            repeat
                if BonusAdj."Pay Element Code" = BONUSTxt then begin
                    BonusAdj."Bonus/Exgratia Amt" := BonusAmount;
                    BonusAdj.MODIFY();
                    Flag := true;
                end else
                    if BonusAdj."Pay Element Code" = ExGratiaTxt then begin
                        BonusAdj.MODIFY();
                        Flag := true;
                    end
            until BonusAdj.NEXT() = 0;

            if not Flag then
                if BonusAmount <> 0 then begin
                    BonusAdjust.INIT();
                    BonusAdjust."Employee Code" := "Employee B2B"."No.";
                    BonusAdjust."Pay Element Code" := BONUSTxt;
                    BonusAdjust.Month := MonthNo;
                    BonusAdjust.Year := PayYear;
                    BonusAdj.RESET();
                    BonusAdj.SETRANGE("Employee Code", BonusAdjust."Employee Code");
                    BonusAdj.SETRANGE(Month, BonusAdjust.Month);
                    BonusAdj.SETRANGE(Year, BonusAdjust.Year);
                    BonusAdjust.INSERT();
                end;

            if ExgratiaAmount <> 0 then begin
                BonusAdjust.INIT();
                BonusAdjust."Employee Code" := "Employee B2B"."No.";
                BonusAdjust."Pay Element Code" := ExGratiaTxt;
                BonusAdjust.Month := MonthNo;
                BonusAdjust.Year := PayYear;
                BonusAdj.RESET();
                BonusAdj.SETRANGE("Employee Code", BonusAdjust."Employee Code");
                BonusAdj.SETRANGE(Month, BonusAdjust.Month);
                BonusAdj.SETRANGE(Year, BonusAdjust.Year);
                BonusAdjust.INSERT()
            end;
        end;
    end;
}

