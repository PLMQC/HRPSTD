report 33001238 "Bonus Calculation B2B"
{
    // version B2BHR1.00.00

    Caption = 'Bonus Calculation';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                NewStatus.UPDATE(1, "No.");
                BonusRec.SETRANGE("Employee Code", "No.");
                if BonusRec.FINDLAST() then
                    LineNo := BonusRec."Line No." + 10000
                else
                    LineNo := 10000;

                BasicAndDA := 0;
                TempDateGVar := FromDateGVar;
                BonusCalculation := false;
                ExgratiaCalculation := false;
                TotalBonusAmt := 0;
                TotalExAmt := 0;
                TotalArrBonusAmt := 0;
                TotalArrExmAmt := 0;

                repeat
                    BasicAndDA := 0;
                    BonusAmount := 0;
                    ExAmt := 0;
                    ProcessedSalary.SETRANGE("Employee Code", "No.");
                    ProcessedSalary.SETRANGE("Pay Slip Month", DATE2DMY(TempDateGVar, 2));
                    ProcessedSalary.SETRANGE(Year, DATE2DMY(TempDateGVar, 3));
                    ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                    if ProcessedSalary.FINDFIRST() then
                        repeat
                            if (ProcessedSalary."Add/Deduct Code" = BASICTxt) or (ProcessedSalary."Add/Deduct Code" = FDATxt) or
                               (ProcessedSalary."Add/Deduct Code" = VDATxt) then
                                BasicAndDA += ProcessedSalary."Earned Amount" + ProcessedSalary."Arrear Amount";

                        until ProcessedSalary.NEXT() = 0;
                    MonAttendance.SETRANGE("Employee Code", "No.");
                    MonAttendance.SETRANGE("Pay Slip Month", DATE2DMY(TempDateGVar, 2));
                    MonAttendance.SETRANGE(Year, DATE2DMY(TempDateGVar, 3));
                    if MonAttendance.FINDFIRST() then begin
                        MonAttendance.CALCFIELDS(Days, Attendance);
                        BonusCalculation := false;
                        ExgratiaCalculation := false;
                        Bonus.RESET();
                        Bonus.SETFILTER("Effective Date", '<=%1', TODAY());
                        if Bonus.FINDLAST() then;
                        Lookup_B2B.RESET();
                        Lookup_B2B.SETRANGE("LookupType Name", PAYCADRETxt);
                        Lookup_B2B.SETRANGE("Lookup Name", MonAttendance.PayCadre);
                        if Lookup_B2B.FINDFIRST() then
                            if Lookup_B2B."Incentive Applicable" = Lookup_B2B."Incentive Applicable"::Bonus then
                                BonusCalculation := true
                            else
                                if Lookup_B2B."Incentive Applicable" = Lookup_B2B."Incentive Applicable"::"Ex-gratia" then
                                    ExgratiaCalculation := true;
                        if BonusCalculation then begin
                            BonusAmount := Bonus."Bonus Amount" * Bonus."Bonus%" / 100;
                            if MonAttendance.Attendance = 0 then
                                MESSAGE(FORMAT(MonAttendance));
                            BonusAmount := BonusAmount * MonAttendance.Attendance / MonAttendance.Days;
                            PayelementCode := BONUSTxt;
                        end else
                            if ExgratiaCalculation then begin
                                if NewOrResignedEmp(TempDateGVar) then begin
                                    if BasicAndDA1 < Bonus."Min.Bonusable Salary" then begin
                                        if BasicAndDA1 < Bonus."Bonus Amount" then
                                            BonusAmount := BasicAndDA1
                                        else
                                            BonusAmount := Bonus."Bonus Amount" * MonAttendance.Attendance / MonAttendance.Days;
                                        ExAmt := BasicAndDA - BonusAmount;
                                    end else begin
                                        BonusAmount := 0;
                                        ExAmt := BasicAndDA;
                                    end;
                                end else begin
                                    CalcBasicandda(CALCDATE(Text330001Txt, TempDateGVar));
                                    if BasicAndDA1 < Bonus."Min.Bonusable Salary" then begin
                                        if BasicAndDA1 < Bonus."Bonus Amount" then
                                            BonusAmount := BasicAndDA1
                                        else
                                            BonusAmount := Bonus."Bonus Amount" * MonAttendance.Attendance / MonAttendance.Days;
                                        ExAmt := BasicAndDA - BonusAmount;
                                    end else begin
                                        BonusAmount := 0;
                                        ExAmt := BasicAndDA;
                                    end;
                                end;
                                BonusAmount := BonusAmount * Bonus."Bonus%" / 100;
                                ExAmt := ExAmt * "Exgratia %" / 100;
                                PayelementCode := EXGRATIATxt;
                            end;
                    end;
                    TotalBonusAmt += BonusAmount;
                    TotalExAmt += ExAmt;
                    TempDateGVar := CALCDATE(MonthTxt, TempDateGVar);
                until TempDateGVar >= ToDateGVar;

                if BonusCalculation or ExgratiaCalculation then begin
                    BonusRec.INIT();
                    BonusRec."Employee Code" := "Employee B2B"."No.";
                    BonusRec.Month := MonthVal;
                    BonusRec.Year := YearVal;
                    BonusRec."Line No." := LineNo;
                    BonusRec."Employee Name" := "Employee B2B"."First Name";
                    BonusRec."Pay Element Code" := PayelementCode;
                    BonusRec."Bonus/Exgratia Amt" := TotalBonusAmt;
                    BonusRec."Exgratia Amt" := TotalExAmt;
                    BonusRec."Start Date" := FromDateGVar;
                    BonusRec."End Date" := ToDateGVar;
                    BonusRec."Arrear Bonus" := TotalArrBonusAmt;
                    BonusRec."Arrear Exgratia" := TotalArrExmAmt;
                    BonusRec.INSERT();
                    InsertDimensions(BonusRec);
                    LineNo += 10000;
                end;
            end;

            trigger OnPostDataItem();
            begin
                NewStatus.CLOSE();
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                TempDateGVar := FromDateGVar;

                BonusRec.RESET();
                BonusRec.SETFILTER("End Date", '>=%1', FromDateGVar);
                if BonusRec.FINDFIRST() then
                    ERROR(Text001Txt, BonusRec."Start Date", BonusRec."End Date");
                NewStatus.OPEN(Text002Txt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(FromDate; FromDateGVar)
                {
                    ToolTip = 'Choose the From date from which bonus calculates starts.';
                    Caption = 'From Date';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if (FromDateGVar > ToDateGVar) and (ToDateGVar <> 0D) then
                            ERROR(Text330002Txt);

                        if (ToDateGVar <> 0D) and (FromDateGVar <> 0D) then
                            if ToDateGVar - FromDateGVar >= 367 then
                                ERROR(Text330003Txt);
                    end;
                }
                field(ToDate; ToDateGVar)
                {
                    ToolTip = 'Choose the To date bonus calcultaes up to that date.';
                    Caption = 'To Date';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if (FromDateGVar > ToDateGVar) and (ToDateGVar <> 0D) then
                            ERROR(Text330002Txt);

                        if (ToDateGVar <> 0D) and (FromDateGVar <> 0D) then
                            if ToDateGVar - FromDateGVar >= 367 then
                                ERROR(Text330003Txt);
                    end;
                }
            }
        }

        actions
        {
        }
    }

    var
        ProcessedSalary: Record "Processed Salary B2B";
        MonAttendance: Record "Monthly Attendance B2B";
        PayElements: Record "Pay Elements B2B";
        BonusRec: Record "Bonus Adjust B2B";
        ArearSalary: Record "Arrear Salary B2B";
        LookUp_B2B: Record Lookup_B2B;
        Bonus: Record Bonus_B2B;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        BasicAndDA: Decimal;
        ExAmt: Decimal;
        FromDateGVar: Date;
        TempDateGVar: Date;
        ToDateGVar: Date;
        PayelementCode: Code[10];
        BonusAmount: Decimal;

        BonusCalculation: Boolean;
        ExgratiaCalculation: Boolean;

        LineNo: Integer;
        NewStatus: Dialog;
        TotalBonusAmt: Decimal;
        TotalExAmt: Decimal;
        MonthVal: Integer;
        YearVal: Integer;
        TotalArrBonusAmt: Decimal;
        TotalArrExmAmt: Decimal;
        BasicAndDA1: Decimal;
        Text001Txt: Label 'Bonus is already calculated for the period %1 to %2', Comment = '%1 = StartDate ; %2 = EndDate';
        Text002Txt: Label 'Pleasewait,Calculating for the employee \##1#################', Comment = '%1 = No';
        BASICTxt: Label 'BASIC';
        VDATxt: Label 'VDA';
        FDATxt: Label 'FDA';
        PAYCADRETxt: Label 'PAY CADRE';
        BONUSTxt: Label 'BONUS';
        Text330001Txt: Label '<+1M-2D>';
        EXGRATIATxt: Label 'EX-GRATIA';
        MonthTxt: Label '<+1M>';
        Text330002Txt: Label 'To date must be greater then from date';
        Text330003Txt: Label 'You cant get records more than one year';

    procedure GetMonthAndYear(Month: Integer; Year: Integer);
    begin
        MonthVal := Month;
        YearVal := Year;
    end;

    procedure InsertDimensions(BonusRecLocal: Record "Bonus Adjust B2B");
    var

    begin
    end;

    procedure NewOrResignedEmp(TestDate: Date): Boolean;
    var
        NewOrResEmpLocal: Boolean;
    begin
        NewOrResEmpLocal := false;
        CLEAR(BasicAndDA1);
        if (DATE2DMY("Employee B2B"."Employment Date", 2) = DATE2DMY(TestDate, 2)) and
            (DATE2DMY("Employee B2B"."Employment Date", 3) = DATE2DMY(TestDate, 3)) then
            NewOrResEmpLocal := true;
        if "Employee B2B"."Resignation Date" <> 0D then
            if (DATE2DMY("Employee B2B"."Resignation Date", 2) = DATE2DMY(TestDate, 2)) and
              (DATE2DMY("Employee B2B"."Resignation Date", 3) = DATE2DMY(TestDate, 3)) then
                NewOrResEmpLocal := true;
        if NewOrResEmpLocal then begin
            CalcBasicandda(CALCDATE(Text330001Txt, TestDate));
            exit(true);
        end;
        exit(false);
    end;

    procedure ArrearCalculation(Employee: Record "Employee B2B"; LTempDate: Date);
    var
        TempMonAttendance: Record "Monthly Attendance B2B";
        MonAttendance1: Record "Monthly Attendance B2B";
        PrevMonth: Integer;
        PrevYear: Integer;
        PrevDays: Integer;
        ArrearBonusAmount: Decimal;
        ArrearExmAmt: Decimal;

    begin
        PrevMonth := 0;
        PrevYear := 0;
        PrevDays := 0;
        ArrearBonusAmount := 0;
        ArrearExmAmt := 0;
        ArearSalary.RESET();
        ArearSalary.SETRANGE("Employee Code", Employee."No.");
        ArearSalary.SETRANGE(Month, DATE2DMY(LTempDate, 2));
        ArearSalary.SETRANGE(Year, DATE2DMY(LTempDate, 3));
        ArearSalary.SETRANGE("Add/Deduct", ArearSalary."Add/Deduct"::Addition);
        if ArearSalary.FINDFIRST() then
            repeat
                if (ArearSalary."Add/Deduct Code" = BASICTxt) or (ArearSalary."Add/Deduct Code" = FDATxt) or
                   (ArearSalary."Add/Deduct Code" = VDATxt) then
                    BasicAndDA += ArearSalary."Earned Amount";
            until ArearSalary.NEXT() = 0;
        PrevMonth := DATE2DMY(LTempDate, 2);
        PrevYear := DATE2DMY(LTempDate, 3);
        if PrevMonth = 1 then begin
            PrevMonth := 12;
            PrevYear := PrevYear - 1;
        end else
            PrevMonth := PrevMonth - 1;
        MonAttendance1.RESET();
        MonAttendance1.SETRANGE("Employee Code", Employee."No.");
        MonAttendance1.SETRANGE("Pay Slip Month", DATE2DMY(TempDateGVar, 2));
        MonAttendance1.SETRANGE(Year, DATE2DMY(TempDateGVar, 3));
        if MonAttendance1.FINDFIRST() then begin
            if MonAttendance1."Pay Slip Month" = 1 then begin
                PrevMonth := 12;
                PrevYear := MonAttendance1.Year - 1;
            end else begin
                PrevMonth := MonAttendance1."Pay Slip Month" - 1;
                PrevYear := MonAttendance1.Year;
            end;
            TempMonAttendance.RESET();
            TempMonAttendance.SETRANGE("Employee Code", Employee."No.");
            TempMonAttendance.SETRANGE("Pay Slip Month", PrevMonth);
            TempMonAttendance.SETRANGE(Year, PrevYear);
            if TempMonAttendance.FINDFIRST() then
                PrevDays := TempMonAttendance.Days;
            Bonus.RESET();
            Bonus.SETFILTER("Effective Date", '<=%1', TODAY());
            if Bonus.FINDLAST() then;
            Lookup_B2B.RESET();
            Lookup_B2B.SETRANGE("LookupType Name", PAYCADRETxt);
            Lookup_B2B.SETRANGE("Lookup Name", MonAttendance.PayCadre);
            if Lookup_B2B.FINDFIRST() then
                if Lookup_B2B."Incentive Applicable" = Lookup_B2B."Incentive Applicable"::Bonus then
                    BonusCalculation := true
                else
                    if Lookup_B2B."Incentive Applicable" = Lookup_B2B."Incentive Applicable"::"Ex-gratia" then
                        ExgratiaCalculation := true;
            if PrevDays <> 0 then
                if BonusCalculation then begin
                    if BasicAndDA <= 0 then begin
                        ArrearBonusAmount := 0;
                        ArrearExmAmt := 0;
                    end;
                    ArrearBonusAmount := ArrearBonusAmount * Bonus."Bonus%" / 100;
                    PayelementCode := BONUSTxt;
                end else
                    if ExgratiaCalculation then begin
                        CalcBasicandda(CALCDATE(Text330001Txt, LTempDate));
                        if BasicAndDA1 < Bonus."Min.Bonusable Salary" then begin
                            if BasicAndDA1 < Bonus."Bonus Amount" then
                                ArrearBonusAmount := BasicAndDA
                            else
                                ArrearBonusAmount := Bonus."Bonus Amount";
                        end else
                            ArrearBonusAmount := 0;

                        ArrearBonusAmount := ArrearBonusAmount * Bonus."Bonus%" / 100;
                        ArrearExmAmt := ArrearExmAmt * Employee."Exgratia %" / 100;
                    end;
        end;
        TotalArrBonusAmt += ArrearBonusAmount;
        TotalArrExmAmt += ArrearExmAmt;
    end;

    procedure CalcBasicandda(TestDate1: Date);
    begin
        BasicAndDA1 := 0;
        PayElements.RESET();
        PayElements.SETRANGE("Employee Code", "Employee B2B"."No.");
        PayElements.SETRANGE("Pay Element Code", BASICTxt);
        PayElements.SETFILTER("Effective Start Date", '<=%1', TestDate1);
        if PayElements.FINDLAST() then
            BasicAndDA1 += PayElements."Amount / Percent";

        PayElements.RESET();
        PayElements.SETRANGE("Employee Code", "Employee B2B"."No.");
        PayElements.SETRANGE("Pay Element Code", VDATxt);
        PayElements.SETFILTER("Effective Start Date", '<=%1', TestDate1);
        if PayElements.FINDLAST() then
            BasicAndDA1 += PayElements."Amount / Percent";

        PayElements.RESET();
        PayElements.SETRANGE("Employee Code", "Employee B2B"."No.");
        PayElements.SETRANGE("Pay Element Code", FDATxt);
        PayElements.SETFILTER("Effective Start Date", '<=%1', TestDate1);
        if PayElements.FINDLAST() then
            BasicAndDA1 += PayElements."Amount / Percent";

    end;
}

