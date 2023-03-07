report 33001210 "ESI Form7 B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\ESI Form7.rdlc';
    Caption = 'ESI Form7';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            RequestFilterFields = "No.";
            column(PayMontext_1_; PayMontext[1])
            {
            }
            column(PayMontext_2_; PayMontext[2])
            {
            }
            column(PayMontext_3_; PayMontext[3])
            {
            }
            column(PayMontext_4_; PayMontext[4])
            {
            }
            column(PayMontext_5_; PayMontext[5])
            {
            }
            column(PayMontext_6_; PayMontext[6])
            {
            }
            column(StartingDate; StartingDate)
            {
            }
            column(EndingDate; EndingDate)
            {
            }
            column(Employee_B2B__ESI_No_; "ESI No")
            {
            }
            column(Name; Name)
            {
            }
            column(Employee_B2B__ESI_Dispensary_; "ESI Dispensary")
            {
            }
            column(Employee_B2B__Department_Code_; "Department Code")
            {
            }
            column(DateOfAppointment; DateOfAppointment)
            {
            }
            column(PaidDays_1_; PaidDays[1])
            {
            }
            column(Wages_1_; Wages[1])
            {
            }
            column(EmployeeContribution_1_; EmployeeContribution[1])
            {
            }
            column(PaidDays_2_; PaidDays[2])
            {
            }
            column(Wages_2_; Wages[2])
            {
            }
            column(EmployeeContribution_2_; EmployeeContribution[2])
            {
            }
            column(PaidDays_3_; PaidDays[3])
            {
            }
            column(Wages_3_; Wages[3])
            {
            }
            column(EmployeeContribution_3_; EmployeeContribution[3])
            {
            }
            column(PaidDays_4_; PaidDays[4])
            {
            }
            column(Wages_4_; Wages[4])
            {
            }
            column(EmployeeContribution_4_; EmployeeContribution[4])
            {
            }
            column(PaidDays_5_; PaidDays[5])
            {
            }
            column(Wages_5_; Wages[5])
            {
            }
            column(EmployeeContribution_5_; EmployeeContribution[5])
            {
            }
            column(PaidDays_6_; PaidDays[6])
            {
            }
            column(Wages_6_; Wages[6])
            {
            }
            column(EmployeeContribution_6_; EmployeeContribution[6])
            {
            }
            column(check; check)
            {
            }
            column(FORM_7Caption; FORM_7CaptionLbl)
            {
            }
            column(Sl_Caption; Sl_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Insur_Caption; Insur_CaptionLbl)
            {
            }
            column(No_Caption_Control1102152006; No_Caption_Control1102152006Lbl)
            {
            }
            column(anceCaption; anceCaptionLbl)
            {
            }
            column(Name_of_theCaption; Name_of_theCaptionLbl)
            {
            }
            column(Insured_PersonCaption; Insured_PersonCaptionLbl)
            {
            }
            column(in_block_letters_Caption; in_block_letters_CaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column(V3Caption; V3CaptionLbl)
            {
            }
            column(Name_of_the__DispensaryCaption; Name_of_the__DispensaryCaptionLbl)
            {
            }
            column(Register_of_EmployeeesCaption; Register_of_EmployeeesCaptionLbl)
            {
            }
            column(Regulation_32_Caption; Regulation_32_CaptionLbl)
            {
            }
            column(V3_ACaption; V3_ACaptionLbl)
            {
            }
            column(OccupationCaption; OccupationCaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(and_shiftCaption; and_shiftCaptionLbl)
            {
            }
            column(if_anyCaption; if_anyCaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(If_appointedCaption; If_appointedCaptionLbl)
            {
            }
            column(ContributionCaption; ContributionCaptionLbl)
            {
            }
            column(during_the_Caption; during_the_CaptionLbl)
            {
            }
            column(Period__Caption; Period__CaptionLbl)
            {
            }
            column(appointmentCaption; appointmentCaptionLbl)
            {
            }
            column(Date_ofCaption; Date_ofCaptionLbl)
            {
            }
            column(FromCaption; FromCaptionLbl)
            {
            }
            column(Contribution_PeriodCaption; Contribution_PeriodCaptionLbl)
            {
            }
            column(V6Caption; V6CaptionLbl)
            {
            }
            column(toCaption; toCaptionLbl)
            {
            }
            column(No__ofCaption; No__ofCaptionLbl)
            {
            }
            column(days_forCaption; days_forCaptionLbl)
            {
            }
            column(which_Caption; which_CaptionLbl)
            {
            }
            column(wagesCaption; wagesCaptionLbl)
            {
            }
            column(paid__Caption; paid__CaptionLbl)
            {
            }
            column(payableCaption; payableCaptionLbl)
            {
            }
            column(V7Caption; V7CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(amount_ofCaption; amount_ofCaptionLbl)
            {
            }
            column(wagesCaption_Control1102152052; wagesCaption_Control1102152052Lbl)
            {
            }
            column(paid__Caption_Control1102152053; paid__Caption_Control1102152053Lbl)
            {
            }
            column(payableCaption_Control1102152055; payableCaption_Control1102152055Lbl)
            {
            }
            column(V8Caption; V8CaptionLbl)
            {
            }
            column(Employee_sCaption; Employee_sCaptionLbl)
            {
            }
            column(share_ofCaption; share_ofCaptionLbl)
            {
            }
            column(contributionCaption_Control1102152060; contributionCaption_Control1102152060Lbl)
            {
            }
            column(V9Caption; V9CaptionLbl)
            {
            }
            column(No__ofCaption_Control1102152062; No__ofCaption_Control1102152062Lbl)
            {
            }
            column(days_forCaption_Control1102152063; days_forCaption_Control1102152063Lbl)
            {
            }
            column(which_Caption_Control1102152064; which_Caption_Control1102152064Lbl)
            {
            }
            column(wagesCaption_Control1102152065; wagesCaption_Control1102152065Lbl)
            {
            }
            column(paid__Caption_Control1102152067; paid__Caption_Control1102152067Lbl)
            {
            }
            column(payableCaption_Control1102152068; payableCaption_Control1102152068Lbl)
            {
            }
            column(V10Caption; V10CaptionLbl)
            {
            }
            column(paid__Caption_Control1102152071; paid__Caption_Control1102152071Lbl)
            {
            }
            column(wagesCaption_Control1102152072; wagesCaption_Control1102152072Lbl)
            {
            }
            column(amount_ofCaption_Control1102152073; amount_ofCaption_Control1102152073Lbl)
            {
            }
            column(TotalCaption_Control1102152074; TotalCaption_Control1102152074Lbl)
            {
            }
            column(payableCaption_Control1102152076; payableCaption_Control1102152076Lbl)
            {
            }
            column(V11Caption; V11CaptionLbl)
            {
            }
            column(contributionCaption_Control1102152079; contributionCaption_Control1102152079Lbl)
            {
            }
            column(share_ofCaption_Control1102152080; share_ofCaption_Control1102152080Lbl)
            {
            }
            column(Employee_sCaption_Control1102152081; Employee_sCaption_Control1102152081Lbl)
            {
            }
            column(V12Caption; V12CaptionLbl)
            {
            }
            column(No__ofCaption_Control1102152083; No__ofCaption_Control1102152083Lbl)
            {
            }
            column(days_forCaption_Control1102152084; days_forCaption_Control1102152084Lbl)
            {
            }
            column(which_Caption_Control1102152085; which_Caption_Control1102152085Lbl)
            {
            }
            column(wagesCaption_Control1102152086; wagesCaption_Control1102152086Lbl)
            {
            }
            column(paid__Caption_Control1102152088; paid__Caption_Control1102152088Lbl)
            {
            }
            column(payableCaption_Control1102152089; payableCaption_Control1102152089Lbl)
            {
            }
            column(V13Caption; V13CaptionLbl)
            {
            }
            column(paid__Caption_Control1102152093; paid__Caption_Control1102152093Lbl)
            {
            }
            column(wagesCaption_Control1102152094; wagesCaption_Control1102152094Lbl)
            {
            }
            column(amount_ofCaption_Control1102152095; amount_ofCaption_Control1102152095Lbl)
            {
            }
            column(TotalCaption_Control1102152096; TotalCaption_Control1102152096Lbl)
            {
            }
            column(payableCaption_Control1102152097; payableCaption_Control1102152097Lbl)
            {
            }
            column(V14Caption; V14CaptionLbl)
            {
            }
            column(contributionCaption_Control1102152100; contributionCaption_Control1102152100Lbl)
            {
            }
            column(share_ofCaption_Control1102152101; share_ofCaption_Control1102152101Lbl)
            {
            }
            column(Employee_sCaption_Control1102152102; Employee_sCaption_Control1102152102Lbl)
            {
            }
            column(V15Caption; V15CaptionLbl)
            {
            }
            column(No__ofCaption_Control1102152105; No__ofCaption_Control1102152105Lbl)
            {
            }
            column(days_forCaption_Control1102152106; days_forCaption_Control1102152106Lbl)
            {
            }
            column(which_Caption_Control1102152107; which_Caption_Control1102152107Lbl)
            {
            }
            column(wagesCaption_Control1102152108; wagesCaption_Control1102152108Lbl)
            {
            }
            column(paid__Caption_Control1102152109; paid__Caption_Control1102152109Lbl)
            {
            }
            column(payableCaption_Control1102152110; payableCaption_Control1102152110Lbl)
            {
            }
            column(V16Caption; V16CaptionLbl)
            {
            }
            column(payableCaption_Control1102152113; payableCaption_Control1102152113Lbl)
            {
            }
            column(paid__Caption_Control1102152114; paid__Caption_Control1102152114Lbl)
            {
            }
            column(wagesCaption_Control1102152115; wagesCaption_Control1102152115Lbl)
            {
            }
            column(amount_ofCaption_Control1102152116; amount_ofCaption_Control1102152116Lbl)
            {
            }
            column(TotalCaption_Control1102152117; TotalCaption_Control1102152117Lbl)
            {
            }
            column(V17Caption; V17CaptionLbl)
            {
            }
            column(contributionCaption_Control1102152121; contributionCaption_Control1102152121Lbl)
            {
            }
            column(share_ofCaption_Control1102152122; share_ofCaption_Control1102152122Lbl)
            {
            }
            column(Employee_sCaption_Control1102152123; Employee_sCaption_Control1102152123Lbl)
            {
            }
            column(V18Caption; V18CaptionLbl)
            {
            }
            column(No__ofCaption_Control1102152126; No__ofCaption_Control1102152126Lbl)
            {
            }
            column(days_forCaption_Control1102152127; days_forCaption_Control1102152127Lbl)
            {
            }
            column(which_Caption_Control1102152128; which_Caption_Control1102152128Lbl)
            {
            }
            column(wagesCaption_Control1102152129; wagesCaption_Control1102152129Lbl)
            {
            }
            column(paid__Caption_Control1102152130; paid__Caption_Control1102152130Lbl)
            {
            }
            column(payableCaption_Control1102152131; payableCaption_Control1102152131Lbl)
            {
            }
            column(V19Caption; V19CaptionLbl)
            {
            }
            column(payableCaption_Control1102152135; payableCaption_Control1102152135Lbl)
            {
            }
            column(paid__Caption_Control1102152136; paid__Caption_Control1102152136Lbl)
            {
            }
            column(wagesCaption_Control1102152137; wagesCaption_Control1102152137Lbl)
            {
            }
            column(amount_ofCaption_Control1102152138; amount_ofCaption_Control1102152138Lbl)
            {
            }
            column(TotalCaption_Control1102152139; TotalCaption_Control1102152139Lbl)
            {
            }
            column(V20Caption; V20CaptionLbl)
            {
            }
            column(contributionCaption_Control1102152142; contributionCaption_Control1102152142Lbl)
            {
            }
            column(share_ofCaption_Control1102152143; share_ofCaption_Control1102152143Lbl)
            {
            }
            column(Employee_sCaption_Control1102152144; Employee_sCaption_Control1102152144Lbl)
            {
            }
            column(V21Caption; V21CaptionLbl)
            {
            }
            column(No__ofCaption_Control1102152147; No__ofCaption_Control1102152147Lbl)
            {
            }
            column(days_forCaption_Control1102152148; days_forCaption_Control1102152148Lbl)
            {
            }
            column(which_Caption_Control1102152149; which_Caption_Control1102152149Lbl)
            {
            }
            column(wagesCaption_Control1102152150; wagesCaption_Control1102152150Lbl)
            {
            }
            column(paid__Caption_Control1102152151; paid__Caption_Control1102152151Lbl)
            {
            }
            column(payableCaption_Control1102152152; payableCaption_Control1102152152Lbl)
            {
            }
            column(V22Caption; V22CaptionLbl)
            {
            }
            column(payableCaption_Control1102152156; payableCaption_Control1102152156Lbl)
            {
            }
            column(paid__Caption_Control1102152157; paid__Caption_Control1102152157Lbl)
            {
            }
            column(wagesCaption_Control1102152158; wagesCaption_Control1102152158Lbl)
            {
            }
            column(amount_ofCaption_Control1102152159; amount_ofCaption_Control1102152159Lbl)
            {
            }
            column(TotalCaption_Control1102152160; TotalCaption_Control1102152160Lbl)
            {
            }
            column(V23Caption; V23CaptionLbl)
            {
            }
            column(contributionCaption_Control1102152163; contributionCaption_Control1102152163Lbl)
            {
            }
            column(share_ofCaption_Control1102152164; share_ofCaption_Control1102152164Lbl)
            {
            }
            column(Employee_sCaption_Control1102152165; Employee_sCaption_Control1102152165Lbl)
            {
            }
            column(V24Caption; V24CaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                check := false;
                CLEAR(PaidDays);
                CLEAR(Wages);
                CLEAR(EmployeeContribution);
                CLEAR(Name);
                Dt := StartingDate;
                PayMon := DATE2DMY(StartingDate, 2);
                PYear := DATE2DMY(StartingDate, 3);
                Name := "Employee B2B".Title + ' ' + "Employee B2B"."First Name" + ' ' + "Employee B2B"."Last Name";

                ProcessedSalary.SETRANGE("Employee Code", "No.");
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        for j := 1 to 12 do begin
                            ProcessedSalary2.SETRANGE("Employee Code", "No.");
                            ProcessedSalary2.SETRANGE("Add/Deduct Code", ESITxt);
                            ProcessedSalary2.SETRANGE("Pay Slip Month", PayMon);
                            ProcessedSalary2.SETRANGE(Year, PYear);
                            ProcessedSalary2.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
                            if ProcessedSalary2.FINDFIRST() then
                                ESICalc(PayMon, ProcessedSalary2, j);
                            Dt := CALCDATE(MonthTxt, Dt);
                            if (Dt > EndingDate) then
                                exit;
                            PayMon := DATE2DMY(Dt, 2);
                            PYear := DATE2DMY(Dt, 3);
                        end;
                    until ProcessedSalary.NEXT() = 0;
                CLEAR(PayMontext);
                Dt := StartingDate;
                PayMon := DATE2DMY(StartingDate, 2);
                PYear := DATE2DMY(StartingDate, 3);
                for j := 1 to 12 do begin
                    if Dt > EndingDate then
                        exit;
                    PayMontext[j] := FORMAT(Dt, 0, Text330001Txt);
                    Dt := CALCDATE(MonthTxt, Dt);
                end;
                PayEmployee.RESET();
                PayEmployee.SETRANGE(PayEmployee."No.", "Employee B2B"."No.");
                Clear(DateOfAppointment);
                if (PayEmployee."Employment Date" >= StartingDate) and (PayEmployee."Employment Date" <= EndingDate) then
                    DateOfAppointment := PayEmployee."Employment Date";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ESIYear; ESIYearGVar)
                    {
                        ToolTip = 'Choose the ESI Year from the drop down.';
                        Caption = 'ESI Year';
                        ApplicationArea = all;

                        trigger OnLookup(Var Text: Text): Boolean;
                        begin
                            PayrollYear.SETRANGE("Year Type", ESIYEARTxt);
                            if PAGE.RUNMODAL(33001218, PayrollYear) = ACTION::LookupOK then begin
                                ESIYearGVar := PayrollYear."Year Type";
                                StartingDate := PayrollYear."Year Start Date";
                                EndingDate := PayrollYear."Year End Date";
                            end;
                        end;
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

    trigger OnInitReport();
    begin
        Slno := 0;
    end;

    var
        PayEmployee: Record "Employee B2B";
        PayrollYear: Record "Payroll Year B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        ProcessedSalary2: Record "Processed Salary B2B";
        StartingDate: Date;
        EndingDate: Date;
        Dt: Date;
        DateOfAppointment: Date;
        ESIYearGVar: Code[50];
        Slno: Integer;
        PayMon: Integer;
        PYear: Integer;
        j: Integer;
        PaidDays: array[12] of Decimal;
        Wages: array[12] of Decimal;
        EmployeeContribution: array[12] of Decimal;
        PayMontext: array[12] of Text[30];
        Name: Text;
        check: Boolean;
        FORM_7CaptionLbl: Label 'FORM 7';
        Sl_CaptionLbl: Label 'Sl.';
        No_CaptionLbl: Label 'No.';
        Insur_CaptionLbl: Label 'Insur-';
        No_Caption_Control1102152006Lbl: Label 'No.';
        anceCaptionLbl: Label 'ance';
        Name_of_theCaptionLbl: Label 'Name of the';
        Insured_PersonCaptionLbl: Label 'Insured Person';
        in_block_letters_CaptionLbl: Label '(in block letters)';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        Name_of_the__DispensaryCaptionLbl: Label 'Name of the  Dispensary';
        Register_of_EmployeeesCaptionLbl: Label 'Register of Employeees';
        Regulation_32_CaptionLbl: Label '(Regulation 32)';
        V3_ACaptionLbl: Label '3-A';
        OccupationCaptionLbl: Label 'Occupation';
        V4CaptionLbl: Label '4';
        DepartmentCaptionLbl: Label 'Department';
        and_shiftCaptionLbl: Label 'and shift';
        if_anyCaptionLbl: Label 'if any';
        V5CaptionLbl: Label '5';
        If_appointedCaptionLbl: Label 'If appointed';
        ContributionCaptionLbl: Label 'Contribution';
        during_the_CaptionLbl: Label '"during the "';
        Period__CaptionLbl: Label '"Period, "';
        appointmentCaptionLbl: Label 'appointment';
        Date_ofCaptionLbl: Label 'Date of';
        FromCaptionLbl: Label 'From';
        Contribution_PeriodCaptionLbl: Label 'Contribution Period';
        V6CaptionLbl: Label '6';
        toCaptionLbl: Label 'to';
        No__ofCaptionLbl: Label 'No. of';
        days_forCaptionLbl: Label 'days for';
        which_CaptionLbl: Label '"which "';
        wagesCaptionLbl: Label 'wages';
        paid__CaptionLbl: Label 'paid /';
        payableCaptionLbl: Label 'payable';
        V7CaptionLbl: Label '7';
        TotalCaptionLbl: Label 'Total';
        amount_ofCaptionLbl: Label 'amount of';
        wagesCaption_Control1102152052Lbl: Label 'wages';
        paid__Caption_Control1102152053Lbl: Label 'paid /';
        payableCaption_Control1102152055Lbl: Label 'payable';
        V8CaptionLbl: Label '8';
        Employee_sCaptionLbl: Label 'Employee''s';
        share_ofCaptionLbl: Label 'share of';
        contributionCaption_Control1102152060Lbl: Label 'contribution';
        V9CaptionLbl: Label '9';
        No__ofCaption_Control1102152062Lbl: Label 'No. of';
        days_forCaption_Control1102152063Lbl: Label 'days for';
        which_Caption_Control1102152064Lbl: Label '"which "';
        wagesCaption_Control1102152065Lbl: Label 'wages';
        paid__Caption_Control1102152067Lbl: Label 'paid /';
        payableCaption_Control1102152068Lbl: Label 'payable';
        V10CaptionLbl: Label '10';
        paid__Caption_Control1102152071Lbl: Label 'paid /';
        wagesCaption_Control1102152072Lbl: Label 'wages';
        amount_ofCaption_Control1102152073Lbl: Label 'amount of';
        TotalCaption_Control1102152074Lbl: Label 'Total';
        payableCaption_Control1102152076Lbl: Label 'payable';
        V11CaptionLbl: Label '11';
        contributionCaption_Control1102152079Lbl: Label 'contribution';
        share_ofCaption_Control1102152080Lbl: Label 'share of';
        Employee_sCaption_Control1102152081Lbl: Label 'Employee''s';
        V12CaptionLbl: Label '12';
        No__ofCaption_Control1102152083Lbl: Label 'No. of';
        days_forCaption_Control1102152084Lbl: Label 'days for';
        which_Caption_Control1102152085Lbl: Label '"which "';
        wagesCaption_Control1102152086Lbl: Label 'wages';
        paid__Caption_Control1102152088Lbl: Label 'paid /';
        payableCaption_Control1102152089Lbl: Label 'payable';
        V13CaptionLbl: Label '13';
        paid__Caption_Control1102152093Lbl: Label 'paid /';
        wagesCaption_Control1102152094Lbl: Label 'wages';
        amount_ofCaption_Control1102152095Lbl: Label 'amount of';
        TotalCaption_Control1102152096Lbl: Label 'Total';
        payableCaption_Control1102152097Lbl: Label 'payable';
        V14CaptionLbl: Label '14';
        contributionCaption_Control1102152100Lbl: Label 'contribution';
        share_ofCaption_Control1102152101Lbl: Label 'share of';
        Employee_sCaption_Control1102152102Lbl: Label 'Employee''s';
        V15CaptionLbl: Label '15';
        No__ofCaption_Control1102152105Lbl: Label 'No. of';
        days_forCaption_Control1102152106Lbl: Label 'days for';
        which_Caption_Control1102152107Lbl: Label '"which "';
        wagesCaption_Control1102152108Lbl: Label 'wages';
        paid__Caption_Control1102152109Lbl: Label 'paid /';
        payableCaption_Control1102152110Lbl: Label 'payable';
        V16CaptionLbl: Label '16';
        payableCaption_Control1102152113Lbl: Label 'payable';
        paid__Caption_Control1102152114Lbl: Label 'paid /';
        wagesCaption_Control1102152115Lbl: Label 'wages';
        amount_ofCaption_Control1102152116Lbl: Label 'amount of';
        TotalCaption_Control1102152117Lbl: Label 'Total';
        V17CaptionLbl: Label '17';
        contributionCaption_Control1102152121Lbl: Label 'contribution';
        share_ofCaption_Control1102152122Lbl: Label 'share of';
        Employee_sCaption_Control1102152123Lbl: Label 'Employee''s';
        V18CaptionLbl: Label '18';
        No__ofCaption_Control1102152126Lbl: Label 'No. of';
        days_forCaption_Control1102152127Lbl: Label 'days for';
        which_Caption_Control1102152128Lbl: Label '"which "';
        wagesCaption_Control1102152129Lbl: Label 'wages';
        paid__Caption_Control1102152130Lbl: Label 'paid /';
        payableCaption_Control1102152131Lbl: Label 'payable';
        V19CaptionLbl: Label '19';
        payableCaption_Control1102152135Lbl: Label 'payable';
        paid__Caption_Control1102152136Lbl: Label 'paid /';
        wagesCaption_Control1102152137Lbl: Label 'wages';
        amount_ofCaption_Control1102152138Lbl: Label 'amount of';
        TotalCaption_Control1102152139Lbl: Label 'Total';
        V20CaptionLbl: Label '20';
        contributionCaption_Control1102152142Lbl: Label 'contribution';
        share_ofCaption_Control1102152143Lbl: Label 'share of';
        Employee_sCaption_Control1102152144Lbl: Label 'Employee''s';
        V21CaptionLbl: Label '21';
        No__ofCaption_Control1102152147Lbl: Label 'No. of';
        days_forCaption_Control1102152148Lbl: Label 'days for';
        which_Caption_Control1102152149Lbl: Label '"which "';
        wagesCaption_Control1102152150Lbl: Label 'wages';
        paid__Caption_Control1102152151Lbl: Label 'paid /';
        payableCaption_Control1102152152Lbl: Label 'payable';
        V22CaptionLbl: Label '22';
        payableCaption_Control1102152156Lbl: Label 'payable';
        paid__Caption_Control1102152157Lbl: Label 'paid /';
        wagesCaption_Control1102152158Lbl: Label 'wages';
        amount_ofCaption_Control1102152159Lbl: Label 'amount of';
        TotalCaption_Control1102152160Lbl: Label 'Total';
        V23CaptionLbl: Label '23';
        contributionCaption_Control1102152163Lbl: Label 'contribution';
        share_ofCaption_Control1102152164Lbl: Label 'share of';
        Employee_sCaption_Control1102152165Lbl: Label 'Employee''s';
        V24CaptionLbl: Label '24';
        ESITxt: Label 'ESI';
        MonthTxt: Label '<+1M>';
        Text330001Txt: Label '<Month Text>';
        ESIYEARTxt: Label 'ESI YEAR';

    procedure ESICalc(Mon: Integer; Procsal: Record "Processed Salary B2B"; x: Integer);
    begin
        check := true;
        case Mon of
            1:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            2:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            3:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            4:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            5:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            6:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            7:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            8:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            9:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            10:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            11:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            12:
                begin
                    PaidDays[x] := ProcessedSalary.Attendance;
                    Wages[x] := ProcessedSalary.Salary;
                    EmployeeContribution[x] := ProcessedSalary."Co. Contributions";
                end;
            else
        end;
    end;
}

