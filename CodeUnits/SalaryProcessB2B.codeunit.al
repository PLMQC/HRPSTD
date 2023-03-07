codeunit 33001197 "Salary Process B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        Employee: Record "Employee B2B";
        TempProcessedSalary: Record "Temp Processed Salary B2B";
        RevisiedPayElements: Record "Pay Elements B2B";
        TempPayElements: Record "Pay Elements B2B" temporary;
        PayElements: Record "Pay Elements B2B" temporary;
        Lookup: Record Lookup_b2b;
        Text003Txt: Label 'Please define payelements for the Employee %1', Comment = '%1 =Employee Code ';
        AddDeduct: Option " ",Addition,Deduction,Benifits;
        ShortcutDimCode: array[8] of Code[20];
        Text33001Txt: Label 'BASIC';
        Text33002Txt: Label 'ON ATTENDANCE';
        Text33003Txt: Label 'NON ATTENDANCE';
        Text33004Txt: Label 'AFTER BASIC';
        Text33005Txt: Label 'AFTER BASIC AND DA';
        Text33006Txt: Label 'DA';
        Text33007Txt: Label 'ADDITIONS AND DEDUCTIONS';
        Text33008Txt: Label 'FINANCIAL YEAR';
        Text33009Txt: Label '<-1M>';
        Text33010Txt: Label 'TDS';
        Text33011Txt: Label 'OT';
        Text33012Txt: Label 'PT';
        Text33013Txt: Label 'ESI';
        Text33014Txt: Label 'ESI YEAR';
        Text33015Txt: Label 'VPF';
        Text33016Txt: Label 'LOAN';
        Text33017Txt: Label 'PF';
        Text33018Txt: Label 'C OFF';
        Text33019Txt: Label 'PAY CADRE';
        Text33020Txt: Label '<1M>';
        Text33021Txt: Label 'No ESI year is defined.';

    procedure ProcessSalary(MonAttendance: Record "Monthly Attendance B2B");
    var
        DailyAttendance: Record "Daily Attendance B2B";
        VAD: Record "Pay Elements B2B";
        VAD2: Record "Pay Elements B2B";
        VAD3DA: Record "Pay Elements B2B";
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        BasicOld: Decimal;
        DAOld: Decimal;
        NoofDays: Decimal;
        NoofDays2: Decimal;
        "Sum": Decimal;
        Sum2: Decimal;
        Lop: Decimal;
        NotJoined: Decimal;
        StartDate: Date;
        EndDate: Date;
        StartDate2: Date;
        CheckDate: Date;
        DAProcessed: Boolean;
        DATempAmt: Decimal;
        DAProcessedOld: Boolean;
        DATempAmtOld: Decimal;
        ProcDate: Date;
    begin
        DAOld := 0;
        DA := 0;
        ReprocessCheck(MonAttendance);

        PayElements.DELETEALL();
        TempPayElements.DELETEALL();

        RevisiedPayElements.RESET();
        RevisiedPayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        if RevisiedPayElements.FINDFIRST() then
            repeat
                TempPayElements.INIT();
                TempPayElements.TRANSFERFIELDS(RevisiedPayElements);
                TempPayElements.INSERT();
            until RevisiedPayElements.NEXT() = 0;

        PayElements.DELETEALL();

        RevisiedPayElements.RESET();
        RevisiedPayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        RevisiedPayElements.SETFILTER("Effective Start Date", '<=%1', MonAttendance."Period End Date");
        if RevisiedPayElements.FINDLAST() then
            ProcDate := RevisiedPayElements."Effective Start Date";

        Lookup.RESET();
        Lookup.SETRANGE("Lookup Type", 16);
        if Lookup.FINDFIRST() then
            repeat
                RevisiedPayElements.RESET();
                RevisiedPayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
                RevisiedPayElements.SETRANGE("Pay Element Code", Lookup."Lookup Name");
                RevisiedPayElements.SETFILTER("Effective Start Date", '%1', ProcDate);
                if RevisiedPayElements.FINDLAST() then
                    repeat
                        PayElements.INIT();
                        PayElements.TRANSFERFIELDS(RevisiedPayElements);
                        PayElements.Processed := false;
                        PayElements.INSERT();
                    until RevisiedPayElements.NEXT() = 0;
            until Lookup.NEXT() = 0;


        MonAttendance.CALCFIELDS(Days);
        MonAttendance.CALCFIELDS(Attendance);
        MonAttendance.CALCFIELDS("Loss Of Pay");
        StartDate := MonAttendance."Period Start Date";
        EndDate := MonAttendance."Period End Date";
        DAProcessed := false;
        DAProcessedOld := false;
        PayElements.RESET();
        PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
        PayElements.SETRANGE(Processed, false);
        PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        if PayElements.FINDFIRST() then begin
            repeat
                Total := 0;
                Sum := 0;
                StartDate := MonAttendance."Period Start Date";
                EndDate := MonAttendance."Period End Date";
                VAD.RESET();
                VAD.SETRANGE("Employee Code", PayElements."Employee Code");
                VAD.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                if VAD.FINDFIRST() then
                    repeat
                        NoofDays2 := 0;
                        NoofDays := 0;
                        Lop := 0;
                        NotJoined := 0;
                        if (VAD."Effective Start Date" > StartDate) and (VAD."Effective Start Date" <= EndDate) then begin
                            NoofDays2 := VAD."Effective Start Date" - StartDate;

                            DailyAttendance.RESET();
                            DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, VAD."Effective Start Date");
                            DailyAttendance.SETRANGE("Employee No.", VAD."Employee Code");
                            if DailyAttendance.FINDFIRST() then
                                repeat
                                    if DailyAttendance.Absent <> 0 then
                                        Lop := Lop + DailyAttendance.Absent;
                                    if DailyAttendance."Not Joined" <> 0 then
                                        NotJoined := NotJoined + DailyAttendance."Not Joined";
                                until DailyAttendance.NEXT() = 0;

                            NoofDays := NoofDays2 - (Lop + NotJoined);

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
                                        if VAD2."Pay Element Code" = Text33001Txt then begin
                                            if (VAD2."Computation Type" = Text33002Txt) then begin
                                                if MonAttendance.Days <> 0 then
                                                    Total := ((NoofDays) / MonAttendance.Days) * VAD2."Amount / Percent";
                                                BasicOld := Total;
                                            end else
                                                if (VAD2."Computation Type" = Text33003Txt) then begin
                                                    Total := (NoofDays2 / MonAttendance.Days) * VAD2."Amount / Percent";
                                                    BasicOld := Total;
                                                end;
                                        end else
                                            if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) then begin
                                                if (VAD2."Computation Type" = Text33002Txt) then
                                                    Total := ((NoofDays) / MonAttendance.Days) * VAD2."Amount / Percent"
                                                else
                                                    Total := (NoofDays2 / MonAttendance.Days) * VAD2."Amount / Percent";
                                            end else
                                                if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                                   (VAD2."Computation Type" = Text33004Txt)
                                       then
                                                    Total := (VAD2."Amount / Percent" * BasicOld) / 100
                                                else
                                                    if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                                       (VAD2."Computation Type" = Text33005Txt)
                                               then
                                                        if not DAProcessedOld then begin
                                                            CLEAR(DATempAmtOld);
                                                            VAD3DA.RESET();
                                                            VAD3DA.SETRANGE("Employee Code", VAD."Employee Code");
                                                            VAD3DA.SETRANGE("Pay Element Code", Text33006Txt);
                                                            if VAD3DA.FINDFIRST() then
                                                                repeat
                                                                    if (VAD3DA."Effective Start Date" >= CheckDate) and
                                                                       (VAD3DA."Effective Start Date" <= StartDate2) then
                                                                        if (VAD3DA."Fixed/Percent" = VAD3DA."Fixed/Percent"::Fixed) then begin
                                                                            if (VAD3DA."Computation Type" = Text33002Txt) then
                                                                                DATempAmtOld := ((NoofDays) / MonAttendance.Days) * VAD3DA."Amount / Percent"
                                                                            else
                                                                                DATempAmtOld := (NoofDays2 / MonAttendance.Days) * VAD3DA."Amount / Percent";
                                                                        end else
                                                                            if (VAD3DA."Fixed/Percent" = VAD3DA."Fixed/Percent"::Percent) and
                                                                               (VAD3DA."Computation Type" = Text33004Txt)
                                                                   then
                                                                                DATempAmtOld := (VAD3DA."Amount / Percent" * BasicOld) / 100

                                                                until VAD3DA.NEXT() = 0;

                                                            Total := (VAD2."Amount / Percent" * (BasicOld + DATempAmtOld)) / 100;
                                                        end else
                                                            if DAProcessed then
                                                                Total := (VAD2."Amount / Percent" * (BasicOld + DAOld)) / 100;

                                        if VAD2."Pay Element Code" = Text33006Txt then begin
                                            DAOld := Total;
                                            DAProcessedOld := true;
                                        end;
                                    end;
                                until VAD2.NEXT() = 0;
                            end;
                            Sum := Sum + Total;
                        end;
                    until VAD.NEXT() = 0;
                VAD2.RESET();
                VAD2.SETRANGE("Employee Code", PayElements."Employee Code");
                VAD2.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                if VAD2.FINDFIRST() then begin
                    Lop := 0;
                    NotJoined := 0;
                    CheckDate := VAD2."Effective Start Date";
                    NoofDays2 := EndDate - StartDate + 1;

                    DailyAttendance.RESET();
                    DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, EndDate);
                    DailyAttendance.SETRANGE("Employee No.", VAD2."Employee Code");
                    if DailyAttendance.FINDFIRST() then
                        repeat
                            if DailyAttendance.Absent <> 0 then
                                Lop := Lop + DailyAttendance.Absent;
                            if DailyAttendance."Not Joined" <> 0 then
                                NotJoined := NotJoined + DailyAttendance."Not Joined";
                        until DailyAttendance.NEXT() = 0;

                    NoofDays := NoofDays2 - (Lop + NotJoined);

                    repeat
                        VAD2.Processed := true;
                        VAD2.MODIFY();
                        if (VAD2."Effective Start Date" >= CheckDate) and (VAD2."Effective Start Date" <= StartDate) then begin
                            if VAD2."Pay Element Code" = Text33001Txt then begin
                                if (VAD2."Computation Type" = Text33002Txt) then begin
                                    if MonAttendance.Days <> 0 then
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                    Basic := Total;
                                end else
                                    if (VAD2."Computation Type" = Text33003Txt) then begin
                                        Total := (NoofDays2 / MonAttendance.Days) * VAD2."Amount / Percent";
                                        Basic := Total;
                                    end;
                            end else
                                if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) then begin
                                    if (VAD2."Computation Type" = Text33002Txt) then
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"
                                    else
                                        Total := (NoofDays2 / MonAttendance.Days) * VAD2."Amount / Percent";
                                end else
                                    if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                       (VAD2."Computation Type" = Text33004Txt)
                           then
                                        Total := (VAD2."Amount / Percent" * Basic) / 100
                                    else
                                        if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                           (VAD2."Computation Type" = Text33005Txt)
                                     then
                                            if not DAProcessed then begin
                                                CLEAR(DATempAmt);
                                                VAD3DA.RESET();
                                                VAD3DA.SETRANGE("Employee Code", VAD."Employee Code");
                                                VAD3DA.SETRANGE("Pay Element Code", Text33006Txt);
                                                if VAD3DA.FINDFIRST() then
                                                    repeat
                                                        if (VAD3DA."Effective Start Date" >= CheckDate) and
                                                           (VAD3DA."Effective Start Date" <= StartDate) then
                                                            if (VAD3DA."Fixed/Percent" = VAD3DA."Fixed/Percent"::Fixed) then begin
                                                                if (VAD3DA."Computation Type" = Text33002Txt) then
                                                                    DATempAmt := ((NoofDays) / MonAttendance.Days) * VAD3DA."Amount / Percent"
                                                                else
                                                                    DATempAmt := (NoofDays2 / MonAttendance.Days) * VAD3DA."Amount / Percent";
                                                            end else
                                                                if (VAD3DA."Fixed/Percent" = VAD3DA."Fixed/Percent"::Percent) and
                                                                   (VAD3DA."Computation Type" = Text33004Txt)
                                                       then
                                                                    DATempAmt := (VAD3DA."Amount / Percent" * Basic) / 100

                                                    until VAD3DA.NEXT() = 0;

                                                Total := (VAD2."Amount / Percent" * (Basic + DATempAmt)) / 100;
                                            end else
                                                if DAProcessed then
                                                    Total := (VAD2."Amount / Percent" * (Basic + DA)) / 100;


                            if VAD2."Pay Element Code" = Text33006Txt then begin
                                DA := Total;
                                DAProcessed := true;
                            end;
                        end;
                    until VAD2.NEXT() = 0;
                end;
                Sum2 := Sum + Total;
                InsertTempProcRecords(MonAttendance, PayElements, Sum2);

            until PayElements.NEXT() = 0;

            TDSRemainingMonths(MonAttendance);
            Employee.RESET();
            Employee.SETRANGE("No.", MonAttendance."Employee Code");
            if Employee.FINDFIRST() then
                if (Employee."OT Applicable" = true) and (Employee."OT Calculation Rate" <> 0) then
                    OTCalculations(MonAttendance, Employee."OT Calculation Rate");


            PayElements.RESET();
            PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            if PayElements.FINDFIRST() then
                repeat
                    PayElements.Processed := false;
                    PayElements.MODIFY();
                until PayElements.NEXT() = 0;

            PayElements.RESET();
            if PayElements.FINDFIRST() then
                repeat
                    PayElements.Processed := false;
                    PayElements.MODIFY();
                until PayElements.NEXT() = 0;

            Employee.RESET();
            Employee.SETRANGE("No.", MonAttendance."Employee Code");
            if Employee.FINDFIRST() then
                if (Employee."PT Applicable" = true) then
                    CalcPTGrossSalary(MonAttendance);


            Employee.RESET();
            Employee.SETRANGE("No.", MonAttendance."Employee Code");
            if Employee.FINDFIRST() then
                if (Employee."ESI Applicable" = true) then
                    CalcESITaxAmt(MonAttendance);


            Employee.RESET();
            Employee.SETRANGE("No.", MonAttendance."Employee Code");
            if Employee.FINDFIRST() then
                if (Employee."PF Applicable" = true) then
                    CalcPFTaxAmt(MonAttendance);


            Employee.RESET();
            Employee.SETRANGE("No.", VAD."Employee Code");
            if Employee.FINDFIRST() then
                CalcOtherPayElementsAmt(MonAttendance);


            Employee.RESET();
            Employee.SETRANGE("No.", MonAttendance."Employee Code");
            Employee.SETRANGE("LWF Applicable", true);
            if Employee.FINDFIRST() then
                LWFEmpAmount(MonAttendance);

            LoanDeductions(MonAttendance);

            InsertTDSRecords(MonAttendance);

            OnProcessSalary(MonAttendance);

            PayElements.RESET();
            PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            if PayElements.FINDFIRST() then
                repeat
                    PayElements.DELETE();
                until PayElements.NEXT() = 0;

            TempPayElements.RESET();
            TempPayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            if TempPayElements.FINDFIRST() then
                repeat
                    PayElements := TempPayElements;
                    PayElements.INSERT();
                until TempPayElements.NEXT() = 0;

        end else
            ERROR(Text003Txt, MonAttendance."Employee Code");
    end;

    procedure InsertTempProcRecords(MonAttendance: Record "Monthly Attendance B2B"; PayElement: Record "Pay Elements B2B"; Total: Decimal);
    var
        TempProcSalary: Record "Temp Processed Salary B2B";
        LookupLRec: Record Lookup_b2b;
        DimensionManagement: Codeunit DimensionManagement;

    begin
        if Total <> 0 then begin
            TempProcSalary.INIT();
            TempProcSalary."Employee Code" := PayElement."Employee Code";
            TempProcSalary."Add/Deduct Code" := PayElement."Pay Element Code";
            TempProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcSalary.Year := MonAttendance.Year;
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

            TempProcSalary."Fixed/Percent" := PayElement."Fixed/Percent";
            TempProcSalary."Computation Type" := PayElement."Computation Type";
            TempProcSalary."Earned Amount" := Rounding(Total);
            TempProcSalary."Add/Deduct" := PayElement."Add/Deduct";
            TempProcSalary.Attendance := MonAttendance.Attendance;
            TempProcSalary.Days := MonAttendance.Days;

            LookupLRec.SETRANGE("LookupType Name", Text33007Txt);
            LookupLRec.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
            if LookupLRec.FINDFIRST() then
                TempProcSalary.Priority := LookupLRec.Priority;
            TempProcSalary."Location Code" := MonAttendance."Location Code";
            TempProcSalary."Dimension Set ID" := MonAttendance."Dimension Set ID";
            DimensionManagement.UpdateGlobalDimFromDimSetID(
              TempProcSalary."Dimension Set ID", TempProcSalary."Shortcut Dimension 1 Code", TempProcSalary."Shortcut Dimension 1 Code");
            DimensionManagement.GetShortcutDimensions(TempProcSalary."Dimension Set ID", ShortcutDimCode);
            TempProcSalary."Shortcut Dim 4 Code" := ShortcutDimCode[4];
            TempProcSalary.INSERT();
        end;
    end;

    procedure TDSRemainingMonths(MonthlyAttendance: Record "Monthly Attendance B2B");
    var
        TDSDeduction: Record "Emp TDS Deduction B2B";
        PayYear: Record "Payroll Year B2B";
        StartDate: Date;
        EndDate: Date;
        TotalMonths: Integer;
    begin
        PayYear.FINDFIRST();
        PayYear.SETRANGE("Year Type", Text33008Txt);
        PayYear.SETRANGE(Closed, false);
        if PayYear.FINDFIRST() then begin
            StartDate := PayYear."Year Start Date";
            EndDate := PayYear."Year End Date";
        end;

        if DMY2DATE(1, MonthlyAttendance."Pay Slip Month", MonthlyAttendance.Year) < EndDate then
            repeat
                TotalMonths += 1;
                if TotalMonths > 1 then
                    EndDate := CALCDATE(Text33009Txt, EndDate);
            until (MonthlyAttendance."Pay Slip Month" = DATE2DMY(EndDate, 2)) and (MonthlyAttendance.Year = DATE2DMY(EndDate, 3));
        TDSDeduction.SETRANGE("Employee No.", MonthlyAttendance."Employee Code");
        TDSDeduction.SETRANGE("Year Starting Date", StartDate);
        TDSDeduction.SETRANGE("Year Ending Date", PayYear."Year End Date");
        if TDSDeduction.FINDFIRST() then begin
            TDSDeduction."Remaining Months" := TotalMonths;
            TDSDeduction.MODIFY();
        end;
    end;

    procedure TDSDeductionAmt(EmployeeCode: Code[20]);
    var
        TDSDeduction: Record "Emp TDS Deduction B2B";
        TDSSchedule: Record "EMP TDS Monthly Schedule B2B";
        Payyear: Record "Payroll Year B2B";
        StartDate: Date;
        EndDate: Date;
        TotAmt: Decimal;
    begin
        Payyear.FINDFIRST();
        Payyear.SETRANGE("Year Type", Text33008Txt);
        Payyear.SETRANGE(Closed, false);
        if Payyear.FINDFIRST() then begin
            StartDate := Payyear."Year Start Date";
            EndDate := Payyear."Year End Date";
        end;

        TDSDeduction.SETRANGE("Employee No.", EmployeeCode);
        TDSDeduction.SETRANGE("Year Starting Date", StartDate);
        TDSDeduction.SETRANGE("Year Ending Date", EndDate);
        if TDSDeduction.FINDFIRST() then begin
            TotAmt := 0;
            TDSSchedule.RESET();
            TDSSchedule.SETRANGE(TDSSchedule."Emp ID", TDSDeduction."Employee No.");
            TDSSchedule.SETRANGE(TDSSchedule."Financial Year Start Date", TDSDeduction."Year Starting Date");
            TDSSchedule.SETRANGE(TDSSchedule."Financial Year End Date", TDSDeduction."Year Ending Date");
            if TDSSchedule.FINDFIRST() then
                repeat
                    TotAmt += TDSSchedule."TDS Amount Deducted";
                until TDSSchedule.NEXT() = 0;
            TDSDeduction."Tax Already Deducted" := TotAmt;
            TDSDeduction.MODIFY();
        end;
    end;

    procedure InsertTDSRecords(MonAttendance: Record "Monthly Attendance B2B");
    var
        TDSSchedule: Record "EMP TDS Monthly Schedule B2B";
    begin
        TDSSchedule.SETRANGE("Emp ID", MonAttendance."Employee Code");
        TDSSchedule.SETRANGE("Payslip Month", MonAttendance."Pay Slip Month");
        TDSSchedule.SETRANGE("Payslip Year", MonAttendance.Year);
        if TDSSchedule.FINDFIRST() then begin
            AddDeduct := AddDeduct::Deduction;
            InsertTempProcRecordsVAD(MonAttendance, Text33010Txt, AddDeduct, TDSSchedule."TDS Amount");
            TDSSchedule.Processes := true;
            TDSSchedule.MODIFY();
        end;
    end;

    procedure OTCalculations(MonAttendance: Record "Monthly Attendance B2B"; OTRate: Decimal);
    var
        VAD: Record "Pay Elements B2B";
        VAD2: Record "Pay Elements B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        Basic: Decimal;
        DA: Decimal;
        DayAmount: Decimal;
        OTAmount: Decimal;
        FinalTotal: Decimal;
        OTTotal: Decimal;
        Total: Decimal;
    begin
        DA := 0;
        MonAttendance.CALCFIELDS(MonAttendance.Days);

        DailyAttendance.SETRANGE("Employee No.", MonAttendance."Employee Code");
        DailyAttendance.SETFILTER(Date, '%1..%2', MonAttendance."Period Start Date", MonAttendance."Period End Date");
        DailyAttendance.SETFILTER(DailyAttendance."OT Approved Hrs", '<> 0');
        if DailyAttendance.FINDFIRST() then begin
            repeat
                VAD.SETRANGE("Employee Code", DailyAttendance."Employee No.");
                if VAD.FINDFIRST() then
                    repeat
                        VAD.Processed := false;
                        VAD.MODIFY();
                    until VAD.NEXT() = 0;
                VAD.RESET();

                PayElements.SETRANGE(PayElements.Processed, false);
                PayElements.SETRANGE("Employee Code", DailyAttendance."Employee No.");
                PayElements.SETRANGE("Applicable for OT", true);
                if PayElements.FINDFIRST() then
                    repeat
                        Total := 0;
                        VAD2.SETFILTER(VAD2."Effective Start Date", '<= %1', DailyAttendance.Date);
                        VAD2.SETRANGE("Employee Code", PayElements."Employee Code");
                        VAD2.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                        VAD2.SETRANGE("Applicable for OT", true);
                        if VAD2.FINDFIRST() then
                            repeat
                                OTTotal := 0;
                                VAD2.Processed := true;
                                VAD2.MODIFY();
                                if VAD2."Pay Element Code" = Text33001Txt then begin
                                    Total := VAD2."Amount / Percent";
                                    Basic := Total;
                                    DayAmount := (Total * 1) / MonAttendance.Days;
                                    OTAmount := (DayAmount * DailyAttendance."OT Approved Hrs") / DailyAttendance."Actual Hrs";
                                    OTAmount := OTAmount * OTRate;
                                end else
                                    if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) then begin
                                        Total := VAD2."Amount / Percent";
                                        DayAmount := (Total * 1) / MonAttendance.Days;
                                        OTAmount := (DayAmount * DailyAttendance."OT Approved Hrs") / DailyAttendance."Actual Hrs";
                                        OTAmount := OTAmount * OTRate;
                                    end else
                                        if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                           (VAD2."Computation Type" = Text33004Txt)
                               then begin
                                            Total := (VAD2."Amount / Percent" * Basic) / 100;
                                            DayAmount := (Total * 1) / MonAttendance.Days;
                                            OTAmount := (DayAmount * DailyAttendance."OT Approved Hrs") / DailyAttendance."Actual Hrs";
                                            OTAmount := OTAmount * OTRate;
                                        end else
                                            if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                               (VAD2."Computation Type" = Text33005Txt)
                                   then begin
                                                Total := (VAD2."Amount / Percent" * (Basic + DA)) / 100;
                                                DayAmount := (Total * 1) / MonAttendance.Days;
                                                OTAmount := (DayAmount * DailyAttendance."OT Approved Hrs") / DailyAttendance."Actual Hrs";
                                                OTAmount := OTAmount * OTRate;
                                            end;
                                if VAD2."Pay Element Code" = Text33006Txt then
                                    DA := Total;
                                if VAD2."Add/Deduct" = VAD2."Add/Deduct"::Addition then
                                    OTTotal := OTTotal + OTAmount
                                else
                                    if VAD2."Add/Deduct" = VAD2."Add/Deduct"::Deduction then
                                        OTTotal := OTTotal - OTAmount;
                            until VAD2.NEXT() = 0;
                        FinalTotal := FinalTotal + OTTotal;
                    until PayElements.NEXT() = 0;
            until DailyAttendance.NEXT() = 0;

            AddDeduct := AddDeduct::Addition;
            InsertTempProcRecordsVAD(MonAttendance, Text33011Txt, AddDeduct, FinalTotal);
        end;
    end;

    procedure InsertTempProcRecordsVAD(MonAttendance: Record "Monthly Attendance B2B"; PayElementCode: Code[20]; "Add/DeductCode": Option " ",Addition,Deduction,Benifits; Amount: Decimal);
    var
        TempProcSalary: Record "Temp Processed Salary B2B";
        LookupLRec: Record Lookup_b2b;
        DimensionManagement: Codeunit DimensionManagement;

    begin
        if Amount <> 0 then begin
            TempProcSalary.INIT();
            TempProcSalary."Employee Code" := MonAttendance."Employee Code";
            TempProcSalary."Add/Deduct Code" := PayElementCode;
            TempProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcSalary.Year := MonAttendance.Year;
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

            TempProcSalary."Earned Amount" := Rounding(Amount);
            TempProcSalary."Add/Deduct" := "Add/DeductCode";
            TempProcSalary.Attendance := MonAttendance.Attendance;
            TempProcSalary.Days := MonAttendance.Days;

            LookupLRec.SETRANGE("LookupType Name", Text33007Txt);
            LookupLRec.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
            if Lookup.FINDFIRST() then
                TempProcSalary.Priority := LookupLRec.Priority;

            TempProcSalary."Location Code" := MonAttendance."Location Code";
            TempProcSalary."Dimension Set ID" := MonAttendance."Dimension Set ID";
            DimensionManagement.UpdateGlobalDimFromDimSetID(
              TempProcSalary."Dimension Set ID", TempProcSalary."Shortcut Dimension 1 Code", TempProcSalary."Shortcut Dimension 1 Code");
            DimensionManagement.GetShortcutDimensions(TempProcSalary."Dimension Set ID", ShortcutDimCode);
            TempProcSalary."Shortcut Dim 4 Code" := ShortcutDimCode[4];
            TempProcSalary.INSERT();
        end;
    end;

    procedure PTAmount(MonAttendance: Record "Monthly Attendance B2B"; GrossAmount: Decimal);
    var
        PT: Record "Professional Tax Line B2B";
        TaxAmount: Decimal;
        BranchCode: Code[20];
    begin
        BranchCode := '';
        Employee.RESET();
        Employee.SETRANGE(Employee."No.", MonAttendance."Employee Code");
        if Employee.FINDFIRST() then
            BranchCode := Employee."PT Branch Code";


        PT.RESET();
        PT.SETRANGE(PT."Branch Code", BranchCode);
        if PT.FINDFIRST() then begin
            repeat
                PT.TESTFIELD("Income From");
                PT.TESTFIELD("Income To");
                if (PT."Income From" <= GrossAmount) and (PT."Income To" >= GrossAmount) then
                    if MonAttendance."Pay Slip Month" <> PT."Spl. Month" then begin
                        if PT."Effective Date" <= MonAttendance."Period End Date" then
                            TaxAmount := PT."Tax Amount";
                    end else
                        if MonAttendance."Pay Slip Month" = PT."Spl. Month" then
                            if PT."Effective Date" <= MonAttendance."Period End Date" then
                                TaxAmount := PT."Spl. Value";


            until PT.NEXT() = 0;
            AddDeduct := AddDeduct::Deduction;
            InsertTempProcRecordsVAD(MonAttendance, Text33012Txt, AddDeduct, TaxAmount);
        end;
    end;

    procedure ESIAmount(MonAttendance: Record "Monthly Attendance B2B"; PayElement: Record "Pay Elements B2B"; GrossAmount: Decimal);
    var
        ESI: Record ESI_B2B;
        LookupLRec: Record Lookup_b2b;
        PayYear: Record "Payroll Year B2B";
        TempProcSalary: Record "Temp Processed Salary B2B";
        ProcSalary: Record "Processed Salary B2B";
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        GrossSalary: Decimal;
        ESIStartDate: Date;
        ESIEndDate: Date;
        CheckDate: Date;
        Flag: Boolean;
    begin
        TempProcSalary.RESET();
        TempProcSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Addition);
        if TempProcSalary.FINDFIRST() then
            repeat
                LookupLRec.SETRANGE("LookupType Name", Text33007Txt);
                LookupLRec.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
                LookupLRec.SETFILTER(ESI, '<>%1', LookupLRec.ESI::" ");
                if not LookupLRec.IsEmpty() then
                    GrossSalary := GrossSalary + TempProcSalary."Earned Amount";
            until TempProcSalary.NEXT() = 0;
        ESI.RESET();
        ESI.SETFILTER("Effective Date", '<=%1', MonAttendance."Period End Date");
        if ESI.FINDLAST() then begin
            ESI.TESTFIELD("Rounding Amount");
            if GrossAmount < ESI."ESI Salary Amount" then begin
                Flag := true;

                case ESI."Rounding Method" of
                    ESI."Rounding Method"::Nearest:
                        begin
                            EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '=');
                            EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '=');
                        end;
                    ESI."Rounding Method"::Up:
                        begin
                            EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '>');
                            EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '>');
                        end;
                    else begin
                            EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '<');
                            EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '<');
                        end;
                end;
            end;
            AddDeduct := AddDeduct::Deduction;
            InsertESIPFRecords(MonAttendance, EmployeeContribution, EmployerContribution, 0, GrossSalary, 0, 0, 0, Text33013Txt, AddDeduct);
        end else
            ERROR(Text33021Txt);

        IF NOT Flag THEN BEGIN
            PayYear.SETRANGE("Year Type", Text33014Txt);
            PayYear.SETRANGE(Closed, FALSE);
            IF PayYear.FINDFIRST() THEN
                REPEAT
                    IF (MonAttendance."Period End Date" >= PayYear."Year Start Date") AND
                        (MonAttendance."Period End Date" <= PayYear."Year End Date")
                    THEN BEGIN
                        ESIStartDate := PayYear."Year Start Date";
                        ESIEndDate := PayYear."Year End Date";
                    END;
                UNTIL PayYear.NEXT() = 0;

            ProcSalary.RESET();
            ProcSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
            ProcSalary.SETRANGE(Year, MonAttendance.Year);
            ProcSalary.SETRANGE("Add/Deduct Code", Text33013Txt);
            IF ProcSalary.FINDLAST() THEN BEGIN
                CheckDate := DMY2DATE(1, ProcSalary."Pay Slip Month", ProcSalary.Year);
                IF (CheckDate >= ESIStartDate) AND (CheckDate <= ESIEndDate) THEN
                    case ESI."Rounding Method" of
                        ESI."Rounding Method"::Nearest:
                            begin
                                EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '=');
                                EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '=');
                            end;
                        ESI."Rounding Method"::Up:
                            begin
                                EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '>');
                                EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '>');
                            end;
                        else begin
                                EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '<');
                                EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '<');
                            end;
                    end;
            END;
            AddDeduct := AddDeduct::Deduction;
            InsertESIPFRecords(MonAttendance, EmployeeContribution, EmployerContribution, 0, GrossSalary, 0, 0, 0, Text33013Txt, AddDeduct);
        END;
    end;

    procedure InsertESIPFRecords(MonAttendance: Record "Monthly Attendance B2B"; EmployeeContribution: Decimal; EmployerContribution: Decimal; EPFAmt: Decimal; GrossAmount: Decimal; PFAdminCharges: Decimal; EDLICharges: Decimal; RIFACharges: Decimal; PayElementCode: Code[20]; "Add/DeductCode": Option " ",Addition,Deduction,Benifits);
    var
        TempProcSalary: Record "Temp Processed Salary B2B";
        LookupLRec: Record Lookup_b2b;
        DimensionManagement: Codeunit DimensionManagement;

    begin
        if EmployeeContribution <> 0 then begin
            TempProcSalary.INIT();
            TempProcSalary."Employee Code" := MonAttendance."Employee Code";
            TempProcSalary."Add/Deduct Code" := PayElementCode;
            TempProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcSalary.Year := MonAttendance.Year;
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

            TempProcSalary."Earned Amount" := EmployeeContribution;
            TempProcSalary."Co. Contributions" := EmployerContribution;
            TempProcSalary."Co. Contribution2" := EPFAmt;
            TempProcSalary."PF Admin Charges" := PFAdminCharges;
            TempProcSalary."EDLI Charges" := EDLICharges;
            TempProcSalary."RIFA Charges" := RIFACharges;
            TempProcSalary."Add/Deduct" := "Add/DeductCode";
            TempProcSalary.Attendance := MonAttendance.Attendance;
            TempProcSalary.Days := MonAttendance.Days;
            TempProcSalary.Salary := GrossAmount;

            LookupLRec.SETRANGE("LookupType Name", Text33007Txt);
            LookupLRec.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
            if LookupLRec.FINDFIRST() then
                TempProcSalary.Priority := LookupLRec.Priority;

            TempProcSalary."Location Code" := MonAttendance."Location Code";
            TempProcSalary."Location Code" := MonAttendance."Location Code";
            TempProcSalary."Dimension Set ID" := MonAttendance."Dimension Set ID";
            DimensionManagement.UpdateGlobalDimFromDimSetID(
              TempProcSalary."Dimension Set ID", TempProcSalary."Shortcut Dimension 1 Code", TempProcSalary."Shortcut Dimension 1 Code");
            DimensionManagement.GetShortcutDimensions(TempProcSalary."Dimension Set ID", ShortcutDimCode);
            TempProcSalary."Shortcut Dim 4 Code" := ShortcutDimCode[4];
            TempProcSalary.INSERT();
        end;
    end;

    procedure CalcPTGrossSalary(MonAttendance: Record "Monthly Attendance B2B");
    var
        GrossSalary: Decimal;
    begin
        GrossSalary := 0;
        PayElements.RESET();
        PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
        PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        PayElements.SETRANGE(PT, true);
        if PayElements.FINDFIRST() then
            repeat
                TempProcessedSalary.RESET();
                TempProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
                TempProcessedSalary.SETRANGE("Add/Deduct Code", PayElements."Pay Element Code");
                if TempProcessedSalary.FINDFIRST() then
                    repeat
                        GrossSalary += TempProcessedSalary."Earned Amount";
                    until TempProcessedSalary.NEXT() = 0;
            until PayElements.NEXT() = 0;

        PTAmount(MonAttendance, GrossSalary);
    end;

    procedure CalcESITaxAmt(MonAttendance: Record "Monthly Attendance B2B");
    var
        GrossSalary: Decimal;
    begin
        GrossSalary := 0;
        PayElements.RESET();
        PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
        PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        PayElements.SETRANGE(Processed, false);
        PayElements.SETRANGE(ESI, PayElements.ESI::"Regular Element");
        if PayElements.FINDFIRST() then
            repeat
                TempProcessedSalary.RESET();
                TempProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
                TempProcessedSalary.SETRANGE("Add/Deduct Code", PayElements."Pay Element Code");
                if TempProcessedSalary.FINDFIRST() then
                    repeat
                        if TempProcessedSalary.Attendance <> 0 then
                            GrossSalary += TempProcessedSalary.Days * TempProcessedSalary."Earned Amount" / TempProcessedSalary.Attendance;
                    until TempProcessedSalary.NEXT() = 0;
            until PayElements.NEXT() = 0;

        ESIAmount(MonAttendance, PayElements, GrossSalary);
    end;

    procedure CalcPFTaxAmt(MonAttendance: Record "Monthly Attendance B2B");
    var
        EmployeeLRec: Record "Employee B2B";
        VAD2: Record "Pay Elements B2B";
        GrossSalary: Decimal;
        EDLIGross: Decimal;
        VPFAmount: Decimal;
    begin
        GrossSalary := 0;
        EDLIGross := 0;
        PayElements.RESET();
        PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
        PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        PayElements.SETRANGE(PF, true);
        if PayElements.FINDFIRST() then
            repeat
                TempProcessedSalary.RESET();
                TempProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
                TempProcessedSalary.SETRANGE("Add/Deduct Code", PayElements."Pay Element Code");
                if TempProcessedSalary.FINDFIRST() then
                    repeat
                        GrossSalary += TempProcessedSalary."Earned Amount";
                    until TempProcessedSalary.NEXT() = 0;
            until PayElements.NEXT() = 0;
        PFAmount(MonAttendance, VAD2, GrossSalary, EDLIGross);
        if EmployeeLRec.GET(MonAttendance."Employee Code") then
            if EmployeeLRec."VPF Applicable" then begin
                CLEAR(VPFAmount);
                if EmployeeLRec."VPF Per/Amount" = EmployeeLRec."VPF Per/Amount"::Percentage then begin
                    EmployeeLRec.TESTFIELD("VPF %");
                    VPFAmount := (GrossSalary / 100) * EmployeeLRec."VPF %";
                    VPFAmount := Rounding(VPFAmount);
                end else
                    if EmployeeLRec."VPF Per/Amount" = EmployeeLRec."VPF Per/Amount"::Amount then begin
                        EmployeeLRec.TESTFIELD("VPF Amount");
                        VPFAmount := EmployeeLRec."VPF Amount";
                    end;
                if VPFAmount <> 0 then
                    InsertVPFRecords(MonAttendance, VPFAmount, Text33015Txt, 2, GrossSalary);
            end;
    end;

    procedure LoanDeductions(MonAttendance: Record "Monthly Attendance B2B");
    var
        Loan: Record Loan_B2B;
        LoanStartMonth: Integer;
        LoanStartYear: Integer;
    begin
        Loan.SETRANGE("Employee Code", MonAttendance."Employee Code");
        Loan.SETRANGE("No Deduction Request", false);
        Loan.SETFILTER("Loan Balance", '<>0');
        if Loan.FINDFIRST() then
            repeat
                LoanStartMonth := DATE2DMY(Loan."Loan Start Date", 2);
                LoanStartYear := DATE2DMY(Loan."Loan Start Date", 3);
                if ((MonAttendance."Pay Slip Month" >= LoanStartMonth) and (MonAttendance.Year = LoanStartYear)) or
                    (MonAttendance.Year > LoanStartYear) then
                    LoanRecords(MonAttendance, Loan);
            until Loan.NEXT() = 0;
    end;

    procedure LoanRecords(MonAttendance: Record "Monthly Attendance B2B"; Loan: Record Loan_B2B);
    var
        TempProcsalary: Record "Temp Processed Salary B2B";
        DimensionManagement: Codeunit DimensionManagement;
    begin
        if Loan."Effective Amount" > 1 then begin
            TempProcsalary.INIT();
            TempProcsalary."Employee Code" := Loan."Employee Code";
            TempProcsalary."Add/Deduct Code" := Loan."Loan Type";
            TempProcsalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcsalary.Year := MonAttendance.Year;
            TempProcsalary."Document Type" := TempProcsalary."Document Type"::Payroll;

            TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
            TempProcessedSalary.SETRANGE("Employee Code", TempProcsalary."Employee Code");
            TempProcessedSalary.SETRANGE("Pay Slip Month", TempProcsalary."Pay Slip Month");
            TempProcessedSalary.SETRANGE(Year, TempProcsalary.Year);
            if TempProcessedSalary.FINDLAST() then
                TempProcsalary."Line No." := TempProcessedSalary."Line No." + 10000
            else
                TempProcsalary."Line No." := 10000;

            TempProcsalary."Computation Type" := Text33016Txt;
            TempProcsalary."Loan Priority No" := Loan."Loan Priority No";
            TempProcsalary."Earned Amount" := Loan."Effective Amount";
            TempProcessedSalary."Loan Id" := Loan.Id;
            TempProcsalary."Partial Deduction" := Loan."Partial Deduction";
            TempProcsalary."Add/Deduct" := TempProcsalary."Add/Deduct"::Deduction;
            TempProcsalary.Attendance := MonAttendance.Attendance;
            TempProcsalary.Days := MonAttendance.Days;

            Lookup.SETRANGE("LookupType Name", Text33007Txt);
            Lookup.SETRANGE("Lookup Name", Text33016Txt);
            if Lookup.FINDFIRST() then
                TempProcsalary.Priority := Lookup.Priority;

            TempProcsalary."Loan Id" := Loan.Id;
            TempProcsalary."Location Code" := MonAttendance."Location Code";
            TempProcsalary."Dimension Set ID" := MonAttendance."Dimension Set ID";
            DimensionManagement.UpdateGlobalDimFromDimSetID(
              TempProcsalary."Dimension Set ID", TempProcsalary."Shortcut Dimension 1 Code", TempProcsalary."Shortcut Dimension 1 Code");
            DimensionManagement.GetShortcutDimensions(TempProcsalary."Dimension Set ID", ShortcutDimCode);
            TempProcsalary."Shortcut Dim 4 Code" := ShortcutDimCode[4];
            TempProcsalary.INSERT();
        end;
    end;

    procedure DeductionPriority(MonthlyAttendance: Record "Monthly Attendance B2B");
    var
        EmployeeLRec: Record "Employee B2B";
        TempProcSalaryAdd: Record "Temp Processed Salary B2B";
        TempProcSalary: Record "Temp Processed Salary B2B";
        ProcessedSalaryAdd: Record "Processed Salary B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        ProcSalary: Record "Processed Salary B2B";
        HRsetup: Record "HR Setup B2B";
        LookupLRec: Record Lookup_b2b;
        SalaryAdjustProcess: Codeunit "Salary Adjust Process B2B";
        SalAdjDed: Codeunit "Salary Adj. Process-Ded B2B";
        TotalSalary: Decimal;
        MinimumSalary: Decimal;
        Additions: Decimal;
        Deductions: Decimal;

    begin
        TempProcSalaryAdd.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalaryAdd.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalaryAdd.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalaryAdd.SETRANGE("Add/Deduct", TempProcSalaryAdd."Add/Deduct"::Addition);
        if TempProcSalaryAdd.FindFirst() then//B@B
            repeat
                TotalSalary := TotalSalary + TempProcSalaryAdd."Earned Amount";
                ProcessedSalaryAdd.INIT();
                ProcessedSalaryAdd.TRANSFERFIELDS(TempProcSalaryAdd);
                ProcessedSalaryAdd."Document Type" := ProcessedSalaryAdd."Document Type"::Payroll;
                ProcessedSalaryAdd."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET();
                ProcSalary.SETRANGE("Document Type", ProcessedSalaryAdd."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalaryAdd."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalaryAdd."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalaryAdd.Year);
                if ProcSalary.FINDLAST() then
                    ProcessedSalaryAdd."Line No." := ProcSalary."Line No." + 10000
                else
                    ProcessedSalaryAdd."Line No." := 10000;
                ProcessedSalaryAdd.INSERT();
            until TempProcSalaryAdd.NEXT() = 0;

        EmployeeLRec.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if EmployeeLRec.FINDFIRST() then begin
            LookupLRec.SETRANGE("Lookup Name", Text33019Txt);
            LookupLRec.SETRANGE("Lookup Name", Employee."Pay Cadre");
            if LookupLRec.FINDFIRST() then
                MinimumSalary := LookupLRec."Min Salary";
        end;

        TotalSalary := TotalSalary - MinimumSalary;
        TempProcSalary.RESET();
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETFILTER(Priority, '<>0');
        TempProcSalary.SETRANGE(Deducted, false);
        if TempProcSalary.FINDFIRST() then
            repeat
                if TempProcSalary."Computation Type" = Text33016Txt then
                    if TempProcSalary."Partial Deduction" then
                        TotalSalary := LoanPriority(MonthlyAttendance, TempProcSalary, TotalSalary)
                    else
                        if (TotalSalary > TempProcSalary."Earned Amount") then
                            TotalSalary := LoanPriority(MonthlyAttendance, TempProcSalary, TotalSalary)
                        else
                            if (TotalSalary >= TempProcSalary."Earned Amount") then begin
                                ProcessedSalary.INIT();
                                ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                                ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                                ProcSalary.RESET();
                                ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                                ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                                if ProcSalary.FINDLAST() then
                                    ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                                else
                                    ProcessedSalary."Line No." := 10000;

                                ProcessedSalary.INSERT();
                                TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                                TempProcSalary.Deducted := true;
                                TempProcSalary.MODIFY();
                            end;
            until TempProcSalary.NEXT() = 0;


        TempProcSalary.RESET();
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct Code", Text33013Txt);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, false);
        if TempProcSalary.FINDFIRST() then
            if (TotalSalary >= TempProcSalary."Earned Amount") then begin
                ProcessedSalary.INIT();
                ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET();
                ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                if ProcSalary.FINDLAST() then
                    ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                else
                    ProcessedSalary."Line No." := 10000;

                ProcessedSalary.INSERT();

                TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                TempProcSalary.Deducted := true;
                TempProcSalary.MODIFY();
            end;


        TempProcSalary.RESET();
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, false);
        TempProcSalary.SETRANGE("Add/Deduct Code", Text33017Txt);
        if TempProcSalary.FINDFIRST() then
            if (TotalSalary >= TempProcSalary."Earned Amount") then begin
                ProcessedSalary.INIT();
                ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET();
                ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                if ProcSalary.FINDLAST() then
                    ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                else
                    ProcessedSalary."Line No." := 10000;

                ProcessedSalary.INSERT();
                TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                TempProcSalary.Deducted := true;
                TempProcSalary.MODIFY();
            end;


        TempProcSalary.RESET();
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, false);
        TempProcSalary.SETRANGE("Add/Deduct Code", Text33012Txt);
        if TempProcSalary.FINDFIRST() then
            if (TotalSalary >= TempProcSalary."Earned Amount") then begin
                ProcessedSalary.INIT();
                ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET();
                ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                if ProcSalary.FINDLAST() then
                    ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                else
                    ProcessedSalary."Line No." := 10000;

                ProcessedSalary.INSERT();
                TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                TempProcSalary.Deducted := true;
                TempProcSalary.MODIFY();
            end;


        TempProcSalary.RESET();
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, false);
        TempProcSalary.SETRANGE("Add/Deduct Code", Text33010Txt);
        if TempProcSalary.FINDFIRST() then
            if (TotalSalary >= TempProcSalary."Earned Amount") then begin
                ProcessedSalary.INIT();
                ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET();
                ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                if ProcSalary.FINDLAST() then
                    ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                else
                    ProcessedSalary."Line No." := 10000;

                ProcessedSalary.INSERT();
                TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                TempProcSalary.Deducted := true;
                TempProcSalary.MODIFY();
            end;


        TempProcSalary.RESET();
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, false);
        TempProcSalary.SETRANGE(TempProcSalary."Computation Type", Text33016Txt);
        if TempProcSalary.FINDFIRST() then
            if TempProcSalary."Partial Deduction" then
                TotalSalary := LoanPriority(MonthlyAttendance, TempProcSalary, TotalSalary)
            else
                if (TotalSalary > TempProcSalary."Earned Amount") then
                    TotalSalary := LoanPriority(MonthlyAttendance, TempProcSalary, TotalSalary);




        TempProcSalary.RESET();
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, false);
        if TempProcSalary.FINDFIRST() then
            repeat
                if (TotalSalary >= TempProcSalary."Earned Amount") then begin
                    ProcessedSalary.INIT();
                    ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                    ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                    ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                    ProcSalary.RESET();
                    ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                    ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                    ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                    ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                    if ProcSalary.FINDLAST() then
                        ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                    else
                        ProcessedSalary."Line No." := 10000;

                    ProcessedSalary.INSERT();
                    TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                    TempProcSalary.Deducted := true;
                    TempProcSalary.MODIFY();
                end;
            until TempProcSalary.NEXT() = 0;


        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        if ProcessedSalary.FINDFIRST() then
            repeat
                if ProcessedSalary."Add/Deduct" = ProcessedSalary."Add/Deduct"::Addition then
                    Additions := Additions + ProcessedSalary."Earned Amount"
                else
                    if ProcessedSalary."Add/Deduct" = ProcessedSalary."Add/Deduct"::Deduction then
                        Deductions := Deductions + ProcessedSalary."Earned Amount";
            until ProcessedSalary.NEXT() = 0;
        MonthlyAttendance.Processed := true;
        MonthlyAttendance."Processing Date" := TODAY();
        MonthlyAttendance."Net Salary" := Additions - Deductions;
        MonthlyAttendance."Remaining Amount" := Additions - Deductions;

        EmployeeLRec.RESET();
        EmployeeLRec.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if EmployeeLRec.FINDFIRST() then begin
            MonthlyAttendance."Pay Method" := EmployeeLRec."Payment Method";
            if MonthlyAttendance."Pay Method" = MonthlyAttendance."Pay Method"::Cash then begin
                HRsetup.GET();
                MonthlyAttendance."Account No." := EmployeeLRec."Bank/Cash Account";
                MonthlyAttendance."Account Type" := MonthlyAttendance."Account Type"::"G/L Account";
            end else
                if MonthlyAttendance."Pay Method" = MonthlyAttendance."Pay Method"::"Bank Transfer" then begin
                    MonthlyAttendance."Account No." := EmployeeLRec."Bank/Cash Account";
                    MonthlyAttendance."Account Type" := MonthlyAttendance."Account Type"::"Bank Account";
                end;
        end;

        OnBeforeUpdateMonthlyAttendance(MonthlyAttendance);
        MonthlyAttendance.MODIFY();
        OnAfterUpdateMonthlyAttendance(MonthlyAttendance);

        TempProcSalary.RESET();
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        if TempProcSalary.FINDFIRST() then
            TempProcSalary.DELETEALL();


        TDSDeductionAmt(MonthlyAttendance."Employee Code");
        SalaryAdjustProcess.ProcessSalary(MonthlyAttendance."Pay Slip Month", MonthlyAttendance.Year, MonthlyAttendance);
        SalAdjDed.ProcessSalary(MonthlyAttendance."Pay Slip Month", MonthlyAttendance.Year, MonthlyAttendance);
    end;

    procedure LoanPriority(MonthlyAttendance: Record "Monthly Attendance B2B"; TempProcSalary: Record "Temp Processed Salary B2B"; TotalSalary: Decimal): Decimal;
    var
        ProcessedSalary: Record "Processed Salary B2B";
        ProcSalary: Record "Processed Salary B2B";
        Loan: Record Loan_B2B;
    begin
        TempProcSalary.RESET();
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority, "Loan Priority No");
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETFILTER(TempProcSalary."Loan Priority No", '<>0');
        TempProcSalary.SETRANGE(Deducted, false);
        TempProcSalary.SETRANGE(TempProcSalary."Computation Type", Text33016Txt);
        if TempProcSalary.FINDFIRST() then
            repeat
                Loan.RESET();
                Loan.SETRANGE(Loan.Id, TempProcSalary."Loan Id");
                Loan.SETRANGE("Employee Code", TempProcSalary."Employee Code");
                if Loan.FINDFIRST() then
                    if not Loan."Partial Deduction" then begin
                        if TotalSalary >= TempProcSalary."Earned Amount" then begin
                            ProcessedSalary.INIT();
                            ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                            ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                            ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                            ProcSalary.RESET();
                            ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                            ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                            ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                            ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                            if ProcSalary.FINDLAST() then
                                ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                            else
                                ProcessedSalary."Line No." := 10000;

                            ProcessedSalary.INSERT();

                            LoanDetailRecords(ProcessedSalary);
                            TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                            TempProcSalary.Deducted := true;
                            TempProcSalary.MODIFY();
                        end
                    end else
                        if Loan."Partial Deduction" = true then begin
                            ProcessedSalary.INIT();
                            ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                            ProcessedSalary."Earned Amount" := Loan."Partial Dedecting Amount";
                            ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                            ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                            ProcSalary.RESET();
                            ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                            ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                            ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                            ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                            if ProcSalary.FINDLAST() then
                                ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                            else
                                ProcessedSalary."Line No." := 10000;

                            ProcessedSalary.INSERT();

                            LoanDetailRecords(ProcessedSalary);
                            TotalSalary := TotalSalary - Loan."Partial Dedecting Amount";
                            TempProcSalary.Deducted := true;
                            TempProcSalary.MODIFY();
                        end;

            until TempProcSalary.NEXT() = 0;


        TempProcSalary.RESET();
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority, "Loan Priority No");
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, false);
        TempProcSalary.SETRANGE("Computation Type", Text33016Txt);
        if TempProcSalary.FINDFIRST() then
            repeat
                Loan.RESET();
                Loan.SETRANGE(Loan.Id, TempProcSalary."Loan Id");
                Loan.SETRANGE("Employee Code", TempProcSalary."Employee Code");
                if Loan.FINDFIRST() then
                    if not Loan."Partial Deduction" then begin
                        if TotalSalary >= TempProcSalary."Earned Amount" then begin
                            ProcessedSalary.INIT();
                            ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                            ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                            ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                            ProcSalary.RESET();
                            ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                            ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                            ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                            ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                            if ProcSalary.FINDLAST() then
                                ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                            else
                                ProcessedSalary."Line No." := 10000;

                            ProcessedSalary.INSERT();

                            LoanDetailRecords(ProcessedSalary);
                            TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                            TempProcSalary.Deducted := true;
                            TempProcSalary.MODIFY();
                        end;
                    end else
                        if Loan."Partial Deduction" = true then begin
                            ProcessedSalary.INIT();
                            ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                            ProcessedSalary."Earned Amount" := Loan."Partial Dedecting Amount";
                            ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                            ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                            ProcSalary.RESET();
                            ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                            ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                            ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                            ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                            if ProcSalary.FINDLAST() then
                                ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                            else
                                ProcessedSalary."Line No." := 10000;

                            ProcessedSalary.INSERT();

                            LoanDetailRecords(ProcessedSalary);
                            TotalSalary := TotalSalary - Loan."Partial Dedecting Amount";
                            TempProcSalary.Deducted := true;
                            TempProcSalary.MODIFY();
                        end;

            until TempProcSalary.NEXT() = 0;

        exit(TotalSalary);
    end;

    procedure LoanDetailRecords(ProcessedSalary: Record "Processed Salary B2B");
    var
        Loan: Record Loan_B2B;
        LoanDetails: Record "Loan Details B2B";
        LoanDetails2: Record "Loan Details B2B";
        LoanLast: Record "Loan Details B2B";
        NextNo: Integer;
    begin
        Loan.RESET();
        Loan.SETRANGE(Id, ProcessedSalary."Loan Id");
        if not Loan.Closed then begin
            LoanDetails.SETRANGE("Employee No.", ProcessedSalary."Employee Code");
            LoanDetails.SETRANGE(Month, ProcessedSalary."Pay Slip Month");
            LoanDetails.SETRANGE(Year, ProcessedSalary.Year);
            LoanDetails.SETRANGE("Loan Code", ProcessedSalary."Add/Deduct Code");
            LoanDetails.SETRANGE("Loan Id", ProcessedSalary."Loan Id");
            if LoanDetails.FINDFIRST() then begin
                LoanDetails."EMI Deducted" := ProcessedSalary."Earned Amount";
                LoanDetails."Paid Month" := ProcessedSalary."Pay Slip Month";
                LoanDetails."Paid Year" := ProcessedSalary.Year;

                LoanDetails2.RESET();
                LoanDetails2.SETRANGE("Employee No.", LoanDetails."Employee No.");
                LoanDetails2.SETRANGE("Loan Id", LoanDetails."Loan Id");
                LoanDetails2.SETFILTER("Paid Month", '<>0');
                LoanDetails2.SETFILTER("Paid Year", '<>0');
                if LoanDetails2.FINDLAST() then begin
                    Loan.RESET();
                    Loan.SETRANGE(Id, LoanDetails."Loan Id");
                    if Loan.FINDFIRST() then
                        if (Loan."Interest Method" = Loan."Interest Method"::"Dimnishing Rate") then
                            LoanDetails.Balance := LoanDetails."Balance (Base)" - LoanDetails."EMI Deducted"
                        else
                            LoanDetails.Balance := Loan."Loan Balance" - LoanDetails."EMI Deducted"
                end else begin
                    Loan.RESET();
                    Loan.SETRANGE(Id, LoanDetails."Loan Id");
                    if Loan.FINDFIRST() then
                        if (Loan."Interest Method" = Loan."Interest Method"::"Dimnishing Rate") then
                            LoanDetails.Balance := LoanDetails."Balance (Base)" - LoanDetails."EMI Deducted"
                        else
                            LoanDetails.Balance := LoanDetails."Loan Amount" - LoanDetails."EMI Deducted";
                end;

                if LoanDetails.Balance = 0 then
                    LoanDetails."Loan Closed" := true;
                LoanDetails.MODIFY();

                LoanDetails2.RESET();
                LoanDetails2.SETRANGE("Employee No.", LoanDetails."Employee No.");
                LoanDetails2.SETRANGE("Loan Id", LoanDetails."Loan Id");
                LoanDetails2.SETFILTER("EMI Deducted", '=0');
                LoanDetails2.SETFILTER("Paid Month", '=0');
                LoanDetails2.SETFILTER("Paid Year", '=0');
                if LoanDetails2.FINDFIRST() then begin
                    Loan.RESET();
                    Loan.SETRANGE(Id, LoanDetails."Loan Id");
                    Loan.SETRANGE("Employee Code", LoanDetails."Employee No.");
                    if Loan.FINDFIRST() then begin
                        Loan."Effective Amount" := LoanDetails2."EMI Amount";
                        Loan."Loan Balance" := LoanDetails.Balance;
                        if Loan."Loan Balance" <= 0 then
                            Loan.Closed := true;
                        //if Loan."Partial Deduction" then
                        //Loan."Partial Deduction" := false;
                        Loan.MODIFY();
                    end;
                end else begin
                    Loan.RESET();
                    Loan.SETRANGE(Id, LoanDetails."Loan Id");
                    Loan.SETRANGE("Employee Code", LoanDetails."Employee No.");
                    if Loan.FINDFIRST() then begin
                        Loan."Effective Amount" := LoanDetails.Balance;
                        Loan."Loan Balance" := LoanDetails.Balance;
                        if Loan."Loan Balance" <= 0 then
                            Loan.Closed := true;
                        //if Loan."Partial Deduction" then
                        //Loan."Partial Deduction" := false;
                        Loan.MODIFY();
                    end;
                end;
            end else begin
                LoanLast.RESET();
                LoanLast.SETRANGE("Loan Id", ProcessedSalary."Loan Id");
                LoanLast.SETRANGE("Employee No.", ProcessedSalary."Employee Code");
                if LoanLast.FINDLAST() then
                    NextNo := LoanLast."Line No"
                else
                    NextNo := 0;
                Loan.RESET();
                Loan.SETRANGE(Id, ProcessedSalary."Loan Id");
                Loan.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                Loan.SETRANGE("Continuous Deduction", false);
                if Loan.FINDFIRST() then begin
                    LoanDetails.INIT();
                    LoanDetails."Employee No." := Loan."Employee Code";
                    LoanDetails."Loan Code" := Loan."Loan Type";
                    LoanDetails."Line No" := NextNo + 1;
                    LoanDetails."Loan Id" := Loan.Id;
                    LoanDetails."Loan Amount" := Loan."Loan Amount";
                    LoanDetails."EMI Deducted" := ProcessedSalary."Earned Amount";
                    LoanDetails."Paid Month" := ProcessedSalary."Pay Slip Month";
                    LoanDetails."Paid Year" := ProcessedSalary.Year;

                    LoanDetails2.RESET();
                    LoanDetails2.SETRANGE("Employee No.", LoanDetails."Employee No.");
                    LoanDetails2.SETRANGE("Loan Id", LoanDetails."Loan Id");
                    LoanDetails2.SETFILTER("EMI Deducted", '<>0');
                    LoanDetails2.SETFILTER("Paid Month", '<>0');
                    LoanDetails2.SETFILTER("Paid Year", '<>0');
                    if LoanDetails2.FINDLAST() then
                        LoanDetails.Balance := LoanDetails2.Balance - LoanDetails."EMI Deducted";
                    if LoanDetails.Balance = 0 then
                        LoanDetails."Loan Closed" := true;

                    LoanDetails.INSERT();
                    Loan.RESET();
                    Loan.SETRANGE(Id, LoanDetails."Loan Id");
                    Loan.SETRANGE("Employee Code", LoanDetails."Employee No.");
                    if Loan.FINDFIRST() then begin
                        Loan."Effective Amount" := LoanDetails.Balance;
                        Loan."Loan Balance" := LoanDetails.Balance;
                        if Loan."Loan Balance" <= 0 then
                            Loan.Closed := true;
                        //if Loan."Partial Deduction" then
                        //Loan."Partial Deduction" := false;
                        Loan.MODIFY();
                    end;
                end;
            end;
        end;
    end;

    procedure InsertArrearRecords(MonAttendance: Record "Monthly Attendance B2B"; PayElementCode: Code[20]; "Add/Deduct": Option " ",Addition,Deduction,Benifits; Amount: Decimal; CoCon: Decimal; CoCon2: Decimal);
    var
        ArrearSalary: Record "Arrear Salary B2B";
        ArrearSalary2: Record "Arrear Salary B2B";
    begin
        ArrearSalary.INIT();
        ArrearSalary."Employee Code" := MonAttendance."Employee Code";
        ArrearSalary."Add/Deduct Code" := PayElementCode;
        ArrearSalary.Month := MonAttendance."Pay Slip Month";
        ArrearSalary.Year := MonAttendance.Year;

        ArrearSalary2.SETRANGE("Employee Code", ArrearSalary."Employee Code");
        ArrearSalary2.SETRANGE(Month, ArrearSalary.Month);
        ArrearSalary2.SETRANGE(Year, ArrearSalary.Year);
        if ArrearSalary2.FINDLAST() then
            ArrearSalary."Line No." := ArrearSalary2."Line No." + 10000
        else
            ArrearSalary."Line No." := 10000;

        if PayElementCode = Text33017Txt then
            Amount := CoCon + CoCon2;

        ArrearSalary."Earned Amount" := ROUND(Amount, 1, '=');
        ArrearSalary."Add/Deduct" := "Add/Deduct";
        ArrearSalary."Co Contributions" := CoCon;
        ArrearSalary."Co Contributions2" := CoCon2;
        ArrearSalary.INSERT(true);
    end;

    procedure CalcOtherPayElementsAmt(MonAttendance: Record "Monthly Attendance B2B");
    var
        TempProcSalary: Record "Temp Processed Salary B2B";
        TempProcessedSalaryLRec: Record "Temp Processed Salary B2B";
        OtherDeduct: Record "Posted Other PayElements B2B";
    begin
        OtherDeduct.RESET();
        OtherDeduct.SETRANGE("Employee No.", MonAttendance."Employee Code");
        OtherDeduct.SETRANGE(Month, MonAttendance."Pay Slip Month");
        OtherDeduct.SETRANGE(Year, MonAttendance.Year);
        if OtherDeduct.FINDFIRST() then
            repeat
                TempProcSalary.INIT();
                TempProcSalary."Document Type" := TempProcSalary."Document Type"::Payroll;
                TempProcSalary."Employee Code" := OtherDeduct."Employee No.";
                TempProcSalary."Pay Slip Month" := OtherDeduct.Month;
                TempProcSalary.Year := OtherDeduct.Year;
                TempProcessedSalaryLRec.SETRANGE("Document Type", TempProcessedSalaryLRec."Document Type"::Payroll);
                TempProcessedSalaryLRec.SETRANGE("Employee Code", TempProcSalary."Employee Code");
                TempProcessedSalaryLRec.SETRANGE("Pay Slip Month", TempProcSalary."Pay Slip Month");
                TempProcessedSalaryLRec.SETRANGE(Year, TempProcSalary.Year);
                if TempProcessedSalaryLRec.FINDLAST() then
                    TempProcSalary."Line No." := TempProcessedSalaryLRec."Line No." + 10000
                else
                    TempProcSalary."Line No." := 10000;

                TempProcSalary."Fixed/Percent" := TempProcSalary."Fixed/Percent"::Fixed;
                TempProcSalary."Add/Deduct Code" := OtherDeduct."Pay Element Code";
                TempProcSalary."Earned Amount" := OtherDeduct.Amount;
                TempProcSalary."Add/Deduct" := OtherDeduct."Add/Deduct";
                TempProcSalary."Employee Name" := OtherDeduct."Employee Name";
                TempProcSalary.Priority := OtherDeduct.Priority;
                TempProcSalary.Attendance := MonAttendance.Attendance;
                TempProcSalary.Days := MonAttendance.Days;
                TempProcSalary."Location Code" := MonAttendance."Location Code";
                TempProcSalary.INSERT();
            until OtherDeduct.NEXT() = 0;

    end;

    procedure ReprocessCheck(LocalMonthlyAtt: Record "Monthly Attendance B2B");
    var
        ProcessedSalary: Record "Processed Salary B2B";
        NextDate: Date;
        Text111Txt: Label '''You can not process salary, Already Salary Processed for the month %1 and year %2''', Comment = '%1 = Month ; %2 = Year';
    begin
        NextDate := CALCDATE(Text33020Txt, LocalMonthlyAtt."Period Start Date");
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", LocalMonthlyAtt."Employee Code");
        ProcessedSalary.SETRANGE("Pay Slip Month", DATE2DMY(NextDate, 2));
        ProcessedSalary.SETRANGE(Year, DATE2DMY(NextDate, 3));
        if not ProcessedSalary.IsEmpty() then
            ERROR(Text111Txt, DATE2DMY(NextDate, 2), DATE2DMY(NextDate, 3));
    end;

    procedure Rounding(Amount: Decimal) "Final Amount": Decimal;
    var
        HRSetup: Record "HR Setup B2B";
        "Rounding Precision": Decimal;
        "Rounding Direction": Text[30];
    begin
        if HRSetup.FINDLAST() then begin
            "Rounding Precision" := HRSetup."Rounding Precision";
            case HRSetup."Rounding Type" of
                0:
                    "Rounding Direction" := '=';
                1:
                    "Rounding Direction" := '>';
                2:
                    "Rounding Direction" := '<';
            end;
            "Final Amount" := ROUND(Amount, "Rounding Precision", "Rounding Direction");
        end;
    end;

    procedure PFAmount(MonAttendance: Record "Monthly Attendance B2B"; PayElement: Record "Pay Elements B2B"; GrossAmount: Decimal; EDLIGross: Decimal);
    var
        PF: Record PF_B2B;
        EmployeeLocal: Record "Employee B2B";
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        EPSAmount: Decimal;
        PFAdminCharges: Decimal;
        EDLICharges: Decimal;
        RIFACharges: Decimal;
        NewGrossAmount: Decimal;
        EPSMax: Decimal;
    begin
        if PF.FINDFIRST() then begin
            repeat
                if GrossAmount < PF."PF Amount" then
                    NewGrossAmount := GrossAmount
                else
                    NewGrossAmount := PF."PF Amount";
                if EmployeeLocal.GET(MonAttendance."Employee Code") then
                    if EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::"Actual Salary" then
                        if GrossAmount > PF."PF Amount" then
                            NewGrossAmount := GrossAmount;
                if PF."Effective Date" <= MonAttendance."Period End Date" then
                    case PF."Rounding Method" of
                        PF."Rounding Method"::Nearest:
                            begin
                                PF.TESTFIELD("Rounding Amount");
                                EPSAmount := ROUND((NewGrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                EPSMax := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                if EPSAmount > EPSMax then
                                    EPSAmount := EPSMax;
                                EmployerContribution := ROUND((NewGrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '=')
                                                          - EPSAmount;
                                EmployeeContribution := ROUND((NewGrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                            end;
                        PF."Rounding Method"::Up:
                            begin
                                PF.TESTFIELD("Rounding Amount");
                                EPSAmount := ROUND((NewGrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                EPSMax := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                if EPSAmount > EPSMax then
                                    EPSAmount := EPSMax;
                                EmployerContribution := ROUND((NewGrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '>')
                                                          - EPSAmount;
                                EmployeeContribution := ROUND((NewGrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                            end;
                        else begin
                                PF.TESTFIELD("Rounding Amount");
                                EPSAmount := ROUND((NewGrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                EPSMax := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                if EPSAmount > EPSMax then
                                    EPSAmount := EPSMax;
                                EmployerContribution := ROUND((NewGrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '<')
                                                          - EPSAmount;
                                EmployeeContribution := ROUND((NewGrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                            end;
                    end;

                if EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::"Employee Specific" then
                    EmployeeContribution := EmployeeLocal."PF Amount";


                PFAdminCharges := (NewGrossAmount * PF."Admin Charges %") / 100;

                EDLICharges := (NewGrossAmount * PF."EDLI %") / 100;

                RIFACharges := (NewGrossAmount * PF."RIFA %") / 100;


            until PF.NEXT() = 0;

            AddDeduct := AddDeduct::Deduction;
            InsertESIPFRecords(MonAttendance, EmployeeContribution, EmployerContribution, EPSAmount, GrossAmount,
                                 PFAdminCharges, EDLICharges, RIFACharges, Text33017Txt, AddDeduct);
        end;
    end;

    procedure COffCalculations(MonAttendance: Record "Monthly Attendance B2B"; COffRate: Decimal);
    var
        PayElementsLRec: Record "Pay Elements B2B";
        PayElementsLRec2: Record "Pay Elements B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        Basic: Decimal;
        DA: Decimal;
        DayAmount: Decimal;
        COffAmount: Decimal;
        FinalTotal: Decimal;
        COffTotal: Decimal;
        Total: Decimal;
    begin
        DA := 0;
        MonAttendance.CALCFIELDS(MonAttendance.Days);
        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", MonAttendance."Employee Code");
        DailyAttendance.SETFILTER(Date, '%1..%2', MonAttendance."Period Start Date", MonAttendance."Period End Date");
        DailyAttendance.SETFILTER("C Off Hours", '<> 0');
        DailyAttendance.SETFILTER("C Off Hours", '>=4');
        if DailyAttendance.FINDFIRST() then begin
            repeat
                DailyAttendance."C Off Hours" := DailyAttendance."Actual Hrs";
                PayElementsLRec.SETRANGE("Employee Code", DailyAttendance."Employee No.");
                if PayElementsLRec.FINDFIRST() then
                    repeat
                        PayElementsLRec.Processed := false;
                        PayElementsLRec.MODIFY();
                    until PayElementsLRec.NEXT() = 0;
                PayElementsLRec.RESET();

                PayElements.SETRANGE(PayElements.Processed, false);
                PayElements.SETRANGE("Employee Code", DailyAttendance."Employee No.");
                PayElements.SETRANGE("Applicable for C Off", true);
                if PayElements.FINDFIRST() then
                    repeat
                        Total := 0;
                        PayElementsLRec2.SETFILTER("Effective Start Date", '<= %1', DailyAttendance.Date);
                        PayElementsLRec2.SETRANGE("Employee Code", PayElements."Employee Code");
                        PayElementsLRec2.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                        PayElementsLRec2.SETRANGE("Applicable for C Off", true);
                        if PayElementsLRec2.FINDFIRST() then
                            repeat
                                COffTotal := 0;
                                PayElementsLRec2.Processed := true;
                                PayElementsLRec2.MODIFY();
                                if PayElementsLRec2."Pay Element Code" = Text33001Txt then begin
                                    Total := PayElementsLRec2."Amount / Percent";
                                    Basic := Total;
                                    DayAmount := (Total * 1) / MonAttendance.Days;
                                    COffAmount := (DayAmount * DailyAttendance."C Off Hours") / DailyAttendance."Actual Hrs";
                                    COffAmount := COffAmount * COffRate;
                                end else
                                    if (PayElementsLRec2."Fixed/Percent" = PayElementsLRec2."Fixed/Percent"::Fixed) then begin
                                        Total := PayElementsLRec2."Amount / Percent";
                                        DayAmount := (Total * 1) / MonAttendance.Days;
                                        COffAmount := (DayAmount * DailyAttendance."C Off Hours") / DailyAttendance."Actual Hrs";
                                        COffAmount := COffAmount * COffRate;
                                    end else
                                        if (PayElementsLRec2."Fixed/Percent" = PayElementsLRec2."Fixed/Percent"::Percent) and
                                           (PayElementsLRec2."Computation Type" = Text33004Txt)
                               then begin
                                            Total := (PayElementsLRec2."Amount / Percent" * Basic) / 100;
                                            DayAmount := (Total * 1) / MonAttendance.Days;
                                            COffAmount := (DayAmount * DailyAttendance."C Off Hours") / DailyAttendance."Actual Hrs";
                                            COffAmount := COffAmount * COffRate;
                                        end else
                                            if (PayElementsLRec2."Fixed/Percent" = PayElementsLRec2."Fixed/Percent"::Percent) and
                                               (PayElementsLRec2."Computation Type" = Text33005Txt)
                                   then begin
                                                Total := (PayElementsLRec2."Amount / Percent" * (Basic + DA)) / 100;
                                                DayAmount := (Total * 1) / MonAttendance.Days;
                                                COffAmount := (DayAmount * DailyAttendance."C Off Hours") / DailyAttendance."Actual Hrs";
                                                COffAmount := COffAmount * COffRate;
                                            end;

                                if PayElementsLRec2."Pay Element Code" = Text33006Txt then
                                    DA := Total;
                                if PayElementsLRec2."Add/Deduct" = PayElementsLRec2."Add/Deduct"::Addition then
                                    COffTotal := COffTotal + COffAmount
                                else
                                    if PayElementsLRec2."Add/Deduct" = PayElementsLRec2."Add/Deduct"::Deduction then
                                        COffTotal := COffTotal - COffAmount;
                            until PayElementsLRec2.NEXT() = 0;
                        FinalTotal := FinalTotal + COffTotal;
                    until PayElements.NEXT() = 0;
            until DailyAttendance.NEXT() = 0;

            AddDeduct := AddDeduct::Addition;
            InsertTempProcRecordsVAD(MonAttendance, Text33018Txt, AddDeduct, FinalTotal);
        end;
    end;

    procedure InsertVPFRecords(MonAttendance: Record "Monthly Attendance B2B"; EmployeeContribution: Decimal; PayElementCode: Code[20]; "Add/DeductCode": Option " ",Addition,Deduction,Benifits; GrossAmount: Decimal);
    var
        TempProcSalary: Record "Temp Processed Salary B2B";
        LookupLRec: Record Lookup_b2b;
    begin
        if EmployeeContribution <> 0 then begin
            TempProcSalary.INIT();
            TempProcSalary."Employee Code" := MonAttendance."Employee Code";
            TempProcSalary."Add/Deduct Code" := PayElementCode;
            TempProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcSalary.Year := MonAttendance.Year;
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

            TempProcSalary."Earned Amount" := EmployeeContribution;
            TempProcSalary."Add/Deduct" := "Add/DeductCode";
            TempProcSalary.Attendance := MonAttendance.Attendance;
            TempProcSalary.Days := MonAttendance.Days;
            TempProcSalary.Salary := GrossAmount;

            LookupLRec.SETRANGE("LookupType Name", Text33007Txt);
            LookupLRec.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
            if LookupLRec.FINDFIRST() then
                TempProcSalary.Priority := LookupLRec.Priority;

            TempProcSalary."Location Code" := MonAttendance."Location Code";
            TempProcSalary.INSERT();
        end;
    end;

    procedure LWFEmpAmount(MonAttendance: Record "Monthly Attendance B2B");
    var
        LWFSetupLRec: Record "LWF Setup B2B";
        LWFEmpAmountLVar: Decimal;
        LWFEmployeerCnLVar: Decimal;
        PayElementCodeLVar: Code[30];
    begin
        CLEAR(LWFEmpAmountLVar);
        LWFSetupLRec.RESET();
        LWFSetupLRec.SETRANGE(Type, LWFSetupLRec.Type::Employee);
        LWFSetupLRec.SETFILTER("Effective Date", '<=%1', MonAttendance."Period End Date");
        if LWFSetupLRec.FINDLAST() then begin
            LWFSetupLRec.TESTFIELD(LWFSetupLRec."Pay Element Code");
            LWFEmpAmountLVar := LWFSetupLRec.Amount;
            PayElementCodeLVar := LWFSetupLRec."Pay Element Code";
        end;

        CLEAR(LWFEmployeerCnLVar);
        LWFSetupLRec.RESET();
        LWFSetupLRec.SETRANGE(Type, LWFSetupLRec.Type::Employer);
        LWFSetupLRec.SETFILTER("Effective Date", '<=%1', MonAttendance."Period End Date");
        if LWFSetupLRec.FINDLAST() then
            LWFEmployeerCnLVar := LWFSetupLRec.Amount;

        AddDeduct := AddDeduct::Deduction;
        InsertLWFecords(MonAttendance, PayElementCodeLVar, LWFEmpAmountLVar, AddDeduct, LWFEmployeerCnLVar);
    end;

    procedure InsertLWFecords(MonAttendance: Record "Monthly Attendance B2B"; PayElementCode: Code[30]; LWFAmount: Decimal; "Add/DeductCode": Option " ",Addition,Deduction,Benifits; EmployerContribution: Decimal);
    var
        TempProcSalary: Record "Temp Processed Salary B2B";
        LookupLRec: Record Lookup_b2b;
        HRSetupGRec: Record "HR Setup B2B";
    begin
        HRSetupGRec.GET();
        if HRSetupGRec.Database = HRSetupGRec.Database::IND then
            if LWFAmount <> 0 then begin
                TempProcSalary.INIT();
                TempProcSalary."Employee Code" := MonAttendance."Employee Code";
                TempProcSalary."Add/Deduct Code" := PayElementCode;
                TempProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
                TempProcSalary.Year := MonAttendance.Year;
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

                TempProcSalary."Earned Amount" := LWFAmount;
                TempProcSalary."Co. Contributions" := EmployerContribution;
                TempProcSalary."Add/Deduct" := "Add/DeductCode";
                TempProcSalary.Attendance := MonAttendance.Attendance;
                TempProcSalary.Days := MonAttendance.Days;
                LookupLRec.SETRANGE("LookupType Name", Text33007Txt);
                LookupLRec.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
                if LookupLRec.FINDFIRST() then
                    TempProcSalary.Priority := LookupLRec.Priority;

                TempProcSalary."Location Code" := MonAttendance."Location Code";
                TempProcSalary.INSERT();
            end;
    end;

    local procedure UpdateDefaultDim();
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeUpdateMonthlyAttendance(var MonthlyAttedance: Record "Monthly Attendance B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnProcessSalary(var MonthlyAttedance: Record "Monthly Attendance B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterUpdateMonthlyAttendance(var MonthlyAttedance: Record "Monthly Attendance B2B")
    begin

    end;


}

