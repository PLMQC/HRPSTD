report 33001239 "Bonus Statement B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Bonus Statement.rdlc';
    Caption = 'Bonus Statement';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            RequestFilterFields = "No.";
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(Bonus_calculation_from___FORMAT_FromDate_____To____FORMAT_ToDate_; 'Bonus calculation from ' + FORMAT(FromDateGVar) + '  To  ' + FORMAT(ToDateGVar))
            {
            }
            column(Individual_Earnings_Worksheet_; 'Individual Earnings Worksheet')
            {
            }
            column(Employee_B2B__No__; "No.")
            {
            }
            column(First_Name___Middle_Name___Last_Name_; "First Name" + "Middle Name" + "Last Name")
            {
            }
            column(MonthDim_1_; MonthDim[1])
            {
            }
            column(DaysDim_1_; DaysDim[1])
            {
            }
            column(FDADim_1_; FDADim[1])
            {
            }
            column(BasicDim_1_; BasicDim[1])
            {
            }
            column(BonusAmtDim_1_; BonusAmtDim[1])
            {
            }
            column(BasicDim_1__VDADim_1__FDADim_1_; BasicDim[1] + VDADim[1] + FDADim[1])
            {
            }
            column(ExAmtDim_1_; ExAmtDim[1])
            {
            }
            column(VDADim_1_; VDADim[1])
            {
            }
            column(VDADim_2_; VDADim[2])
            {
            }
            column(ExAmtDim_2_; ExAmtDim[2])
            {
            }
            column(BonusAmtDim_2_; BonusAmtDim[2])
            {
            }
            column(BasicDim_2__VDADim_2__FDADim_2_; BasicDim[2] + VDADim[2] + FDADim[2])
            {
            }
            column(FDADim_2_; FDADim[2])
            {
            }
            column(BasicDim_2_; BasicDim[2])
            {
            }
            column(DaysDim_2_; DaysDim[2])
            {
            }
            column(MonthDim_2_; MonthDim[2])
            {
            }
            column(VDADim_3_; VDADim[3])
            {
            }
            column(ExAmtDim_3_; ExAmtDim[3])
            {
            }
            column(BonusAmtDim_3_; BonusAmtDim[3])
            {
            }
            column(BasicDim_3__VDADim_3__FDADim_3_; BasicDim[3] + VDADim[3] + FDADim[3])
            {
            }
            column(FDADim_3_; FDADim[3])
            {
            }
            column(BasicDim_3_; BasicDim[3])
            {
            }
            column(DaysDim_3_; DaysDim[3])
            {
            }
            column(MonthDim_3_; MonthDim[3])
            {
            }
            column(VDADim_4_; VDADim[4])
            {
            }
            column(ExAmtDim_4_; ExAmtDim[4])
            {
            }
            column(BonusAmtDim_4_; BonusAmtDim[4])
            {
            }
            column(BasicDim_4__VDADim_4__FDADim_4_; BasicDim[4] + VDADim[4] + FDADim[4])
            {
            }
            column(FDADim_4_; FDADim[4])
            {
            }
            column(BasicDim_4_; BasicDim[4])
            {
            }
            column(DaysDim_4_; DaysDim[4])
            {
            }
            column(MonthDim_4_; MonthDim[4])
            {
            }
            column(VDADim_5_; VDADim[5])
            {
            }
            column(ExAmtDim_5_; ExAmtDim[5])
            {
            }
            column(BonusAmtDim_5_; BonusAmtDim[5])
            {
            }
            column(BasicDim_5__VDADim_5__FDADim_5_; BasicDim[5] + VDADim[5] + FDADim[5])
            {
            }
            column(FDADim_5_; FDADim[5])
            {
            }
            column(BasicDim_5_; BasicDim[5])
            {
            }
            column(DaysDim_5_; DaysDim[5])
            {
            }
            column(MonthDim_5_; MonthDim[5])
            {
            }
            column(VDADim_6_; VDADim[6])
            {
            }
            column(ExAmtDim_6_; ExAmtDim[6])
            {
            }
            column(BonusAmtDim_6_; BonusAmtDim[6])
            {
            }
            column(BasicDim_6__VDADim_6__FDADim_6_; BasicDim[6] + VDADim[6] + FDADim[6])
            {
            }
            column(FDADim_6_; FDADim[6])
            {
            }
            column(BasicDim_6_; BasicDim[6])
            {
            }
            column(DaysDim_6_; DaysDim[6])
            {
            }
            column(MonthDim_6_; MonthDim[6])
            {
            }
            column(VDADim_7_; VDADim[7])
            {
            }
            column(ExAmtDim_7_; ExAmtDim[7])
            {
            }
            column(BasicDim_7__VDADim_7__FDADim_7_; BasicDim[7] + VDADim[7] + FDADim[7])
            {
            }
            column(FDADim_7_; FDADim[7])
            {
            }
            column(DaysDim_7_; DaysDim[7])
            {
            }
            column(MonthDim_7_; MonthDim[7])
            {
            }
            column(VDADim_8_; VDADim[8])
            {
            }
            column(ExAmtDim_8_; ExAmtDim[8])
            {
            }
            column(BonusAmtDim_8_; BonusAmtDim[8])
            {
            }
            column(BasicDim_8__VDADim_8__FDADim_8_; BasicDim[8] + VDADim[8] + FDADim[8])
            {
            }
            column(FDADim_8_; FDADim[8])
            {
            }
            column(BasicDim_8_; BasicDim[8])
            {
            }
            column(DaysDim_8_; DaysDim[8])
            {
            }
            column(MonthDim_8_; MonthDim[8])
            {
            }
            column(VDADim_9_; VDADim[9])
            {
            }
            column(ExAmtDim_9_; ExAmtDim[9])
            {
            }
            column(BasicDim_9__VDADim_9__FDADim_9_; BasicDim[9] + VDADim[9] + FDADim[9])
            {
            }
            column(FDADim_9_; FDADim[9])
            {
            }
            column(BasicDim_9_; BasicDim[9])
            {
            }
            column(MonthDim_9_; MonthDim[9])
            {
            }
            column(VDADim_10_; VDADim[10])
            {
            }
            column(ExAmtDim_10_; ExAmtDim[10])
            {
            }
            column(BonusAmtDim_10_; BonusAmtDim[10])
            {
            }
            column(BasicDim_10__VDADim_10__FDADim_10_; BasicDim[10] + VDADim[10] + FDADim[10])
            {
            }
            column(FDADim_10_; FDADim[10])
            {
            }
            column(BasicDim_10_; BasicDim[10])
            {
            }
            column(DaysDim_10_; DaysDim[10])
            {
            }
            column(MonthDim_10_; MonthDim[10])
            {
            }
            column(VDADim_11_; VDADim[11])
            {
            }
            column(ExAmtDim_11_; ExAmtDim[11])
            {
            }
            column(BonusAmtDim_11_; BonusAmtDim[11])
            {
            }
            column(BasicDim_11__VDADim_11__FDADim_11_; BasicDim[11] + VDADim[11] + FDADim[11])
            {
            }
            column(FDADim_11_; FDADim[11])
            {
            }
            column(BasicDim_11_; BasicDim[11])
            {
            }
            column(DaysDim_11_; DaysDim[11])
            {
            }
            column(MonthDim_11_; MonthDim[11])
            {
            }
            column(VDADim_12_; VDADim[12])
            {
            }
            column(ExAmtDim_12_; ExAmtDim[12])
            {
            }
            column(BonusAmtDim_12_; BonusAmtDim[12])
            {
            }
            column(BasicDim_12__VDADim_12__FDADim_12_; BasicDim[12] + VDADim[12] + FDADim[12])
            {
            }
            column(FDADim_12_; FDADim[12])
            {
            }
            column(BasicDim_12_; BasicDim[12])
            {
            }
            column(DaysDim_12_; DaysDim[12])
            {
            }
            column(MonthDim_12_; MonthDim[12])
            {
            }
            column(BonusAmtDim_7_; BonusAmtDim[7])
            {
            }
            column(BasicDim_7_; BasicDim[7])
            {
            }
            column(BonusAmtDim_9_; BonusAmtDim[9])
            {
            }
            column(DaysDim_9_; DaysDim[9])
            {
            }
            column(TotalDays; TotalDays)
            {
            }
            column(TotalBasic; TotalBasic)
            {
            }
            column(TotalVDA; TotalVDA)
            {
            }
            column(TotalFDA; TotalFDA)
            {
            }
            column(TotalSalAndDA; TotalSalAndDA)
            {
            }
            column(TotalBonusAmt; TotalBonusAmt)
            {
            }
            column(TotalExamt; TotalExamt)
            {
            }
            column(Employee_B2B__No__Caption; Employee_B2B__No__CaptionLbl)
            {
            }
            column(First_Name___Middle_Name___Last_Name_Caption; First_Name___Middle_Name___Last_Name_CaptionLbl)
            {
            }
            column(DaysCaption; DaysCaptionLbl)
            {
            }
            column(BasicCaption; BasicCaptionLbl)
            {
            }
            column(FDACaption; FDACaptionLbl)
            {
            }
            column(VDACaption; VDACaptionLbl)
            {
            }
            column(Salary_plus_DACaption; Salary_plus_DACaptionLbl)
            {
            }
            column(Bonussable_SalaryCaption; Bonussable_SalaryCaptionLbl)
            {
            }
            column(ExcludedCaption; ExcludedCaptionLbl)
            {
            }
            column(MonthCaption; MonthCaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                BasicAndDA := 0;
                TempDate := FromDateGVar;
                BonusCalculation := false;
                ExgratiaCalculation := false;
                DimIndex := 0;
                CLEAR(DaysDim);
                CLEAR(MonthDim);
                CLEAR(BasicDim);
                CLEAR(FDADim);
                CLEAR(VDADim);
                CLEAR(BonusAmtDim);
                CLEAR(ExAmtDim);

                repeat
                    BasicAndDA := 0;
                    BonusAmount := 0;
                    ExAmt := 0;
                    BonusCalculation := false;
                    ExgratiaCalculation := false;
                    DimIndex += 1;
                    ProcessedSalary.RESET();
                    ProcessedSalary.SETRANGE("Employee Code", "No.");
                    ProcessedSalary.SETRANGE("Pay Slip Month", DATE2DMY(TempDate, 2));
                    ProcessedSalary.SETRANGE(Year, DATE2DMY(TempDate, 3));
                    ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                    if ProcessedSalary.FINDFIRST() then
                        repeat
                            case ProcessedSalary."Add/Deduct Code" of
                                BASICTxt:
                                    begin
                                        BasicAndDA += ProcessedSalary."Earned Amount" + ProcessedSalary."Arrear Amount";
                                        BasicDim[DimIndex] := ProcessedSalary."Earned Amount" + ProcessedSalary."Arrear Amount";
                                    end;
                                FDATxt:
                                    begin
                                        BasicAndDA += ProcessedSalary."Earned Amount" + ProcessedSalary."Arrear Amount";
                                        FDADim[DimIndex] := ProcessedSalary."Earned Amount" + ProcessedSalary."Arrear Amount";
                                    end;
                                VDATxt:
                                    begin
                                        BasicAndDA += ProcessedSalary."Earned Amount" + ProcessedSalary."Arrear Amount";
                                        VDADim[DimIndex] := ProcessedSalary."Earned Amount" + ProcessedSalary."Arrear Amount";
                                    end;
                            end;
                        until ProcessedSalary.NEXT() = 0;

                    MonAttendance.RESET();
                    MonAttendance.SETRANGE("Employee Code", "No.");
                    MonAttendance.SETRANGE("Pay Slip Month", DATE2DMY(TempDate, 2));
                    MonAttendance.SETRANGE(Year, DATE2DMY(TempDate, 3));
                    if MonAttendance.FINDFIRST() then begin
                        MonAttendance.CALCFIELDS(Days, Attendance);
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
                            if MonAttendance.Days <> 0 then
                                BonusAmount := Bonus."Bonus Amount" * MonAttendance.Attendance / MonAttendance.Days;
                            if BasicDim[DimIndex] <> 0 then
                                BonusAmtDim[DimIndex] := BonusAmount
                            else
                                BonusAmtDim[DimIndex] := 0;
                            BonusAmount := BonusAmount * Bonus."Bonus%" * 12 / 100;
                            PayelementCode := BONUSTxt;
                        end else
                            if ExgratiaCalculation then begin
                                if NewOrResignedEmp(TempDate) then begin
                                    if BasicAndDA1 < Bonus."Min.Bonusable Salary" then begin
                                        if BasicAndDA1 < Bonus."Bonus Amount" then
                                            BonusAmount := BasicAndDA
                                        else
                                            BonusAmount := Bonus."Bonus Amount" * MonAttendance.Attendance / MonAttendance.Days;
                                        ExAmt := BasicAndDA - BonusAmount;
                                    end else begin
                                        BonusAmount := 0;
                                        ExAmt := BasicAndDA;
                                    end;
                                end else begin
                                    CalcBasicandda(CALCDATE(Text330001Txt, TempDate));
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
                                if ExAmt < 0 then
                                    ExAmt := 0;
                                if BasicDim[DimIndex] <> 0 then begin
                                    BonusAmtDim[DimIndex] := BonusAmount;
                                    ExAmtDim[DimIndex] := ExAmt;
                                end else begin
                                    BonusAmtDim[DimIndex] := 0;
                                    ExAmtDim[DimIndex] := 0;
                                end;
                                BonusAmount := BonusAmount * Bonus."Bonus%" * 12 / 100;
                                ExAmt := ExAmt * "Exgratia %" * 12 / 100;
                                PayelementCode := EXGRATIATxt;
                            end;
                    end;
                    if BasicDim[DimIndex] <> 0 then
                        DaysDim[DimIndex] := MonAttendance.Attendance
                    else
                        DaysDim[DimIndex] := 0;
                    MonthDim[DimIndex] := FORMAT(DATE2DMY(TempDate, 2)) + '/' + FORMAT(DATE2DMY(TempDate, 3));
                    TempDate := CALCDATE(MonthTxt, TempDate);
                until TempDate >= ToDateGVar;
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
                field(FromDate; FromDateGVar)
                {
                    ToolTip = 'Choose the From date from which bonus statement starts.';
                    Caption = 'From Date';
                    ApplicationArea = all;
                }
                field(ToDate; ToDateGVar)
                {
                    ToolTip = 'Choose the To date bonus statement up to that date. ';
                    Caption = 'To Date';
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

    trigger OnPreReport();
    begin
        if (FromDateGVar <> 0D) and (ToDateGVar <> 0D) then begin
            if (ToDateGVar - FromDateGVar) > 366 then
                ERROR(Text001Txt);
        end else
            ERROR(Text002Txt);
    end;

    var
        ProcessedSalary: Record "Processed Salary B2B";
        MonAttendance: Record "Monthly Attendance B2B";
        PayElements: Record "Pay Elements B2B";
        LookUp_B2B: Record Lookup_B2B;
        Bonus: Record Bonus_B2B;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        BasicAndDA: Decimal;
        ExAmt: Decimal;
        FromDateGVar: Date;
        TempDate: Date;
        ToDateGVar: Date;

        PayelementCode: Code[10];
        BonusAmount: Decimal;

        BonusCalculation: Boolean;
        ExgratiaCalculation: Boolean;

        DaysDim: array[12] of Decimal;
        MonthDim: array[12] of Text[30];
        BasicDim: array[12] of Decimal;
        FDADim: array[12] of Decimal;
        VDADim: array[12] of Decimal;
        BonusAmtDim: array[12] of Decimal;
        ExAmtDim: array[12] of Decimal;
        DimIndex: Integer;
        TotalDays: Decimal;
        TotalBasic: Decimal;
        TotalFDA: Decimal;
        TotalVDA: Decimal;
        TotalSalAndDA: Decimal;
        TotalBonusAmt: Decimal;
        TotalExamt: Decimal;
        BasicAndDA1: Decimal;
        Employee_B2B__No__CaptionLbl: Label 'Emp. No.';
        First_Name___Middle_Name___Last_Name_CaptionLbl: Label 'Name';
        DaysCaptionLbl: Label 'Days';
        BasicCaptionLbl: Label 'Basic';
        FDACaptionLbl: Label 'FDA';
        VDACaptionLbl: Label 'VDA';
        Salary_plus_DACaptionLbl: Label 'Salary plus DA';
        Bonussable_SalaryCaptionLbl: Label 'Bonussable Salary';
        ExcludedCaptionLbl: Label 'Excluded';
        MonthCaptionLbl: Label 'Month';
        Text001Txt: Label 'The date difference must be 12 Months';
        Text002Txt: Label 'Enter Valid Dates';
        Text330001Txt: Label '<+1M-2D>';
        BASICTxt: Label 'BASIC';
        VDATxt: Label 'VDA';
        FDATxt: Label 'FDA';
        PAYCADRETxt: Label 'PAY CADRE';
        BONUSTxt: Label 'BONUS';
        MonthTxt: Label '<+1M>';
        EXGRATIATxt: Label 'EX-GRATIA';

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

    procedure CalcBasicandda(TestDate1: Date);
    begin
        BasicAndDA1 := 0;
        PayElements.RESET();
        PayElements.SETRANGE("Employee Code", "Employee B2B"."No.");
        PayElements.SETRANGE("Pay Element Code", BASICTxt);
        PayElements.SETFILTER("Effective Start Date", '<=%1', TestDate1);
        if PayElements.FINDLAST() then
            BasicAndDA1 += PayElements."Amount / Percent";

        PayElements.SETRANGE("Pay Element Code", VDATxt);
        if PayElements.FINDLAST() then
            BasicAndDA1 += PayElements."Amount / Percent";

        PayElements.SETRANGE("Pay Element Code", FDATxt);
        if PayElements.FINDLAST() then
            BasicAndDA1 += PayElements."Amount / Percent";

    end;
}

