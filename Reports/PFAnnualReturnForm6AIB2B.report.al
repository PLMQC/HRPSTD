report 33001207 "PF-Annual Return Form 6A-I B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PF-Annual Return Form 6A-I.rdl';
    Caption = 'PF-Annual Return Form 6A-I';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(CompanyAdd; CompanyAdd)
            {
            }
            column(UPPERCASE__First_Name_____Last_Name__; UPPERCASE("First Name" + "Last Name"))
            {
            }
            column(Sal; Sal)
            {
            }
            column(PF; PF)
            {
            }
            column(PF2; PF2)
            {
            }
            column(PF3; PF3)
            {
            }
            column(Employee_B2B_Employee_B2B__PF_No_;
            "Employee B2B"."PF No")
            {
            }
            column(SN; SN)
            {
            }
            column(Name___Address_of_the_Factory_EstablishmentCaption; Name___Address_of_the_Factory_EstablishmentCaptionLbl)
            {
            }
            column(DataItem1102152037; Paragraph_43_of_the_Employee_CaptionLbl)
            {
            }
            column(Statutory_rate_of_contributionCaption; Statutory_rate_of_contributionCaptionLbl)
            {
            }
            column(No__of_Members_voluntarily___Caption; No__of_Members_voluntarily___CaptionLbl)
            {
            }
            column(Contributing_at_a_higher_rate________________________Caption; Contributing_at_a_higher_rate________________________CaptionLbl)
            {
            }
            column(FORM_6_ACaption; FORM_6_ACaptionLbl)
            {
            }
            column(Code_No__of_the_Establishment____________________________Caption; Code_No__of_the_Establishment____________________________CaptionLbl)
            {
            }
            column(SI_No_Caption; SI_No_CaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Name_of_the_Memeber___in_block_letters_Caption; Name_of_the_Memeber___in_block_letters_CaptionLbl)
            {
            }
            column(DataItem1102152046; Wages__Retaining_allowance_CaptionLbl)
            {
            }
            column(Amount_of_Worker_s_Contributions_deducted_from_the_wagesCaption; Amount_of_Worker_s_Contributions_deducted_from_the_wagesCaptionLbl)
            {
            }
            column(Employer_s_ContributionCaption; Employer_s_ContributionCaptionLbl)
            {
            }
            column(Refund_of_AdvancesCaption; Refund_of_AdvancesCaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(E_P_F_differences_between_10___8_13_Caption; E_P_F_differences_between_10___8_13_CaptionLbl)
            {
            }
            column(Pension_Fund_8_13_Caption; Pension_Fund_8_13_CaptionLbl)
            {
            }
            column(Rate_of_higher_voluntary_contribution__if_any_Caption; Rate_of_higher_voluntary_contribution__if_any_CaptionLbl)
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
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(V6Caption; V6CaptionLbl)
            {
            }
            column(V7Caption; V7CaptionLbl)
            {
            }
            column(V8Caption; V8CaptionLbl)
            {
            }
            column(V9Caption; V9CaptionLbl)
            {
            }
            column(V10Caption; V10CaptionLbl)
            {
            }
            column(toCaption; toCaptionLbl)
            {
            }
            column(Annual_statement_of_contribution_for_the_currency_period_from_Caption; Annual_statement_of_contribution_for_the_currency_period_from_CaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(PF);
                CLEAR(PF2);
                CLEAR(PF3);
                CLEAR(Sal);
                ProcessedSalary.SETRANGE("Employee Code", "No.");
                ProcessedSalary.SETRANGE(ProcessedSalary."Add/Deduct Code", PFTxt);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        if (ProcessedSalary."Pay Slip Month" >= DATE2DMY(StartDate, 2)) and (ProcessedSalary.Year = DATE2DMY(StartDate, 3)) or
                           (ProcessedSalary."Pay Slip Month" <= DATE2DMY(EndDate, 2)) and (ProcessedSalary.Year = DATE2DMY(EndDate, 3)) then begin
                            Sal += ProcessedSalary.Salary;
                            PF += ProcessedSalary."Earned Amount";
                            PF2 += ProcessedSalary."Co. Contributions";
                            PF3 += ProcessedSalary."Co. Contribution2";
                        end;
                    until ProcessedSalary.NEXT() = 0;
                CompanyAdd := Company.Name + ' ' + Company."Name 2" + ' ' + Company.Address + ' ' + Company."Address 2";
                PayRevisionLine.SETRANGE("No.", "No.");
                PayRevisionLine.SETRANGE("Pay Element", PFTxt);
                if PayRevisionLine.FINDFIRST() then
                    repeat
                        if (PayRevisionLine.Month >= DATE2DMY(StartDate, 2)) and (PayRevisionLine.Year = DATE2DMY(StartDate, 3)) or
                           (PayRevisionLine.Month <= DATE2DMY(EndDate, 2)) and (PayRevisionLine.Year = DATE2DMY(EndDate, 3)) then begin
                            PF += PayRevisionLine."Arrear Amount";
                            PF2 += PayRevisionLine."Arrear Co. Contribution";
                            PF3 += PayRevisionLine."Arrear Co. Contribution2";
                        end;
                    until PayRevisionLine.NEXT() = 0;

                SN += 1;
            end;

            trigger OnPreDataItem();
            begin
                Company.GET();
                month := DATE2DMY(StartDate, 2);
                year := DATE2DMY(StartDate, 3);
                case month of
                    1:
                        start := JanuaryTxt;
                    2:
                        start := FeburaryTxt;
                    3:
                        start := MarchTxt;
                    4:
                        start := AprilTxt;
                    5:
                        start := MayTxt;
                    6:
                        start := JuneTxt;
                    7:
                        start := JulyTxt;
                    8:
                        start := AugustTxt;
                    9:
                        start := SeptemberTxt;
                    10:
                        start := OctoberTxt;
                    11:
                        start := NovemberTxt;
                    12:
                        start := DecemberTxt;
                end;
                month := DATE2DMY(EndDate, 2);
                year1 := DATE2DMY(EndDate, 3);
                case month of
                    1:
                        enddt := JanuaryTxt;
                    2:
                        enddt := FeburaryTxt;
                    3:
                        enddt := MarchTxt;
                    4:
                        enddt := AprilTxt;
                    5:
                        enddt := MayTxt;
                    6:
                        enddt := JuneTxt;
                    7:
                        enddt := JulyTxt;
                    8:
                        enddt := AugustTxt;
                    9:
                        enddt := SeptemberTxt;
                    10:
                        enddt := OctoberTxt;
                    11:
                        enddt := NovemberTxt;
                    12:
                        enddt := DecemberTxt;
                end;
            end;
        }
        dataitem(employee; "Employee B2B")
        {
            column(EPF_5_; EPF[5])
            {
            }
            column(Admin_5_; Admin[5])
            {
            }
            column(PF1_5_; PF1[5])
            {
            }
            column(EPF_6_; EPF[6])
            {
            }
            column(Admin_6_; Admin[6])
            {
            }
            column(PF1_6_; PF1[6])
            {
            }
            column(PF1_7_; PF1[7])
            {
            }
            column(Admin_7_; Admin[7])
            {
            }
            column(EPF_7_; EPF[7])
            {
            }
            column(PF1_8_; PF1[8])
            {
            }
            column(Admin_8_; Admin[8])
            {
            }
            column(EPF_8_; EPF[8])
            {
            }
            column(PF1_9_; PF1[9])
            {
            }
            column(Admin_9_; Admin[9])
            {
            }
            column(EPF_9_; EPF[9])
            {
            }
            column(PF1_10_; PF1[10])
            {
            }
            column(Admin_10_; Admin[10])
            {
            }
            column(EPF_10_; EPF[10])
            {
            }
            column(PF1_11_; PF1[11])
            {
            }
            column(Admin_11_; Admin[11])
            {
            }
            column(EPF_11_; EPF[11])
            {
            }
            column(PF1_12_; PF1[12])
            {
            }
            column(Admin_12_; Admin[12])
            {
            }
            column(EPF_12_; EPF[12])
            {
            }
            column(PF1_1_; PF1[1])
            {
            }
            column(Admin_1_; Admin[1])
            {
            }
            column(EPF_1_; EPF[1])
            {
            }
            column(PF1_2_; PF1[2])
            {
            }
            column(Admin_2_; Admin[2])
            {
            }
            column(EPF_2_; EPF[2])
            {
            }
            column(PF1_3_; PF1[3])
            {
            }
            column(Admin_3_; Admin[3])
            {
            }
            column(EPF_3_; EPF[3])
            {
            }
            column(PF1_4_; PF1[4])
            {
            }
            column(Admin_4_; Admin[4])
            {
            }
            column(EPF_4_; EPF[4])
            {
            }
            column(Admin_1__Admin_2__Admin_3__Admin_4__Admin_5__Admin_6__Admin_7__Admin_8__Admin_9__Admin_10__Admin_11__Admin_12_; Admin[1] + Admin[2] + Admin[3] + Admin[4] + Admin[5] + Admin[6] + Admin[7] + Admin[8] + Admin[9] + Admin[10] + Admin[11] + Admin[12])
            {
            }
            column(PF1_1__PF1_2__PF1_3__PF1_4__PF1_5__PF1_6__PF1_7__PF1_8__PF1_9__PF1_10__PF1_11__PF1_12_; PF1[1] + PF1[2] + PF1[3] + PF1[4] + PF1[5] + PF1[6] + PF1[7] + PF1[8] + PF1[9] + PF1[10] + PF1[11] + PF1[12])
            {
            }
            column(EPF_1__EPF_2__EPF_3__EPF_4__EPF_5__EPF_6__EPF_7__EPF_8__EPF_9__EPF_10__EPF_11__EPF_12_; EPF[1] + EPF[2] + EPF[3] + EPF[4] + EPF[5] + EPF[6] + EPF[7] + EPF[8] + EPF[9] + EPF[10] + EPF[11] + EPF[12])
            {
            }
            column(RIFA_3_; RIFA[3])
            {
            }
            column(EDLI_3_; EDLI[3])
            {
            }
            column(RIFA_4_; RIFA[4])
            {
            }
            column(EDLI_4_; EDLI[4])
            {
            }
            column(RIFA_5_; RIFA[5])
            {
            }
            column(EDLI_5_; EDLI[5])
            {
            }
            column(EDLI_6_; EDLI[6])
            {
            }
            column(RIFA_6_; RIFA[6])
            {
            }
            column(RIFA_7_; RIFA[7])
            {
            }
            column(EDLI_7_; EDLI[7])
            {
            }
            column(RIFA_8_; RIFA[8])
            {
            }
            column(EDLI_8_; EDLI[8])
            {
            }
            column(RIFA_9_; RIFA[9])
            {
            }
            column(EDLI_9_; EDLI[9])
            {
            }
            column(RIFA_10_; RIFA[10])
            {
            }
            column(EDLI_10_; EDLI[10])
            {
            }
            column(RIFA_11_; RIFA[11])
            {
            }
            column(EDLI_11_; EDLI[11])
            {
            }
            column(RIFA_12_; RIFA[12])
            {
            }
            column(EDLI_12_; EDLI[12])
            {
            }
            column(RIFA_1_; RIFA[1])
            {
            }
            column(EDLI_1_; EDLI[1])
            {
            }
            column(RIFA_2_; RIFA[2])
            {
            }
            column(EDLI_2_; EDLI[2])
            {
            }
            column(RIFA_1__RIFA_2__RIFA_3__RIFA_4__RIFA_5__RIFA_6__RIFA_7__RIFA_8__RIFA_9__RIFA_10__RIFA_11__RIFA_12_; RIFA[1] + RIFA[2] + RIFA[3] + RIFA[4] + RIFA[5] + RIFA[6] + RIFA[7] + RIFA[8] + RIFA[9] + RIFA[10] + RIFA[11] + RIFA[12])
            {
            }
            column(EDLI_1__EDLI_2__EDLI_3__EDLI_4__EDLI_5__EDLI_6__EDLI_7__EDLI_8__EDLI_9__EDLI_10__EDLI_11__EDLI_12_; EDLI[1] + EDLI[2] + EDLI[3] + EDLI[4] + EDLI[5] + EDLI[6] + EDLI[7] + EDLI[8] + EDLI[9] + EDLI[10] + EDLI[11] + EDLI[12])
            {
            }
            column(Clos__5_6_7_Rs_Caption; Clos__5_6_7_Rs_CaptionLbl)
            {
            }
            column(Aggregate________Contributions_____Caption; Aggregate________Contributions_____CaptionLbl)
            {
            }
            column(Adim__Charges_Rs__at_1_1___of_Wages_Caption; Adim__Charges_Rs__at_1_1___of_Wages_CaptionLbl)
            {
            }
            column(Amount_remittedCaption; Amount_remittedCaptionLbl)
            {
            }
            column(Reconcilation_of_RemittancesCaption; Reconcilation_of_RemittancesCaptionLbl)
            {
            }
            column(March_Paid_in_AprilCaption; March_Paid_in_AprilCaptionLbl)
            {
            }
            column(MayCaption; MayCaptionLbl)
            {
            }
            column(JuneCaption; JuneCaptionLbl)
            {
            }
            column(JulyCaption; JulyCaptionLbl)
            {
            }
            column(AugustCaption; AugustCaptionLbl)
            {
            }
            column(SeptemberCaption; SeptemberCaptionLbl)
            {
            }
            column(OctoberCaption; OctoberCaptionLbl)
            {
            }
            column(NovemberCaption; NovemberCaptionLbl)
            {
            }
            column(DecemberCaption; DecemberCaptionLbl)
            {
            }
            column(JanuaryCaption; JanuaryCaptionLbl)
            {
            }
            column(FebruaryCaption; FebruaryCaptionLbl)
            {
            }
            column(Feb__Paid_in_MarchCaption; Feb__Paid_in_MarchCaptionLbl)
            {
            }
            column(MonthCaption; MonthCaptionLbl)
            {
            }
            column(EDLI_Contribution_A_c__21_Caption; EDLI_Contribution_A_c__21_CaptionLbl)
            {
            }
            column(E_P_FCaption; E_P_FCaptionLbl)
            {
            }
            column(Adm__Charges_A_C_No_2Caption; Adm__Charges_A_C_No_2CaptionLbl)
            {
            }
            column(Pension_Fund__Contributions_A_c_No__10Caption; Pension_Fund__Contributions_A_c_No__10CaptionLbl)
            {
            }
            column(EDLI_Admin__Charges_0_01__A_c__No__22Caption; EDLI_Admin__Charges_0_01__A_c__No__22CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(i__Total_Number_of_contribution_cards_enclosed____Form_3A__Revised__Caption; i__Total_Number_of_contribution_cards_enclosed____Form_3A__Revised__CaptionLbl)
            {
            }
            column(DataItem1102152119; ii__Certified_that_Form_3A_pLbl)
            {
            }
            column(Date_of_RemittancesCaption; Date_of_RemittancesCaptionLbl)
            {
            }
            column(Sl__No_Caption; Sl__No_CaptionLbl)
            {
            }
            column(V1Caption_Control1102152150; V1Caption_Control1102152150Lbl)
            {
            }
            column(V2Caption_Control1102152151; V2Caption_Control1102152151Lbl)
            {
            }
            column(V3Caption_Control1102152152; V3Caption_Control1102152152Lbl)
            {
            }
            column(V4Caption_Control1102152153; V4Caption_Control1102152153Lbl)
            {
            }
            column(V5Caption_Control1102152154; V5Caption_Control1102152154Lbl)
            {
            }
            column(V6Caption_Control1102152155; V6Caption_Control1102152155Lbl)
            {
            }
            column(V7Caption_Control1102152156; V7Caption_Control1102152156Lbl)
            {
            }
            column(V8Caption_Control1102152157; V8Caption_Control1102152157Lbl)
            {
            }
            column(V9Caption_Control1102152158; V9Caption_Control1102152158Lbl)
            {
            }
            column(V10Caption_Control1102152159; V10Caption_Control1102152159Lbl)
            {
            }
            column(V11Caption; V11CaptionLbl)
            {
            }
            column(V12Caption; V12CaptionLbl)
            {
            }
            column(Signature_of_the_EmployerCaption; Signature_of_the_EmployerCaptionLbl)
            {
            }
            column(With_official_Seal_Caption; With_official_Seal_CaptionLbl)
            {
            }
            column(DataItem1102152164; V1__The_Names_of_all_members_thisLbl)
            {
            }
            column(V2__In_case_of_substantial; V2__In_case_of_substantialLbl)
            {
            }
            column(V3__In_respect_of_those; V3__In_respect_of_thoseLbl)
            {
            }
            column(sent_to_the_Regional; sent_to_the_RegionalLbl)
            {
            }
            column(V200________Caption; V200________CaptionLbl)
            {
            }
            column(employee_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                MS := DATE2DMY(StartDate, 2);
                ME := DATE2DMY(EndDate, 2);
                YS := DATE2DMY(StartDate, 3);
                YE := DATE2DMY(EndDate, 3);
                Date := StartDate;
                Mon := MS - 1;
                YR := YS;
                Date := DMY2DATE(DATE2DMY(Date, 1), Mon, YS);
                for j := 1 to 12 do begin
                    ProcessedSalary.SETRANGE("Employee Code", "No.");
                    ProcessedSalary.SETRANGE("Add/Deduct Code", PFTxt);
                    ProcessedSalary.SETRANGE("Pay Slip Month", Mon);
                    ProcessedSalary.SETRANGE(Year, YR);
                    if ProcessedSalary.FINDFIRST() then
                        PFCalc(Mon, ProcessedSalary);
                    Date := CALCDATE(MonthTxt, Date);
                    if (Date > EndDate) then
                        exit;
                    Mon := DATE2DMY(Date, 2);
                    YR := DATE2DMY(Date, 3);
                end;
            end;

            trigger OnPreDataItem();
            begin
                CLEAR(EM);
                CLEAR(EPF);
                CLEAR(PF1);
                CLEAR(Line);
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
                    field(PfYear; PfYearGVar)
                    {
                        ToolTip = 'Select the PF year.';
                        Caption = 'PF YEAR';
                        ApplicationArea = all;

                        trigger OnLookup(var Text: Text): Boolean;
                        begin
                            PayrollYears.SETRANGE(PayrollYears."Year Type", PFYearTxt);
                            if PAGE.RUNMODAL(0, PayrollYears) = ACTION::LookupOK then begin
                                PfYearGVar := PayrollYears."Year Type";
                                StartDate := PayrollYears."Year Start Date";
                                EndDate := PayrollYears."Year End Date";
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

    var
        Company: Record "Company Information";
        ProcessedSalary: Record "Processed Salary B2B";
        PayRevisionLine: Record "Pay Revision Line B2B";
        PayrollYears: Record "Payroll Year B2B";
        PF: Decimal;
        PF2: Decimal;
        PF3: Decimal;
        Sal: Decimal;
        PfYearGVar: Code[50];
        StartDate: Date;
        EndDate: Date;
        start: Code[10];
        enddt: Code[10];
        month: Integer;
        year: Integer;
        year1: Integer;
        PF1: array[12] of Decimal;
        EM: array[12] of Decimal;
        EPF: array[12] of Decimal;
        Mon: Integer;
        MS: Integer;
        ME: Integer;
        YS: Integer;
        YE: Integer;
        YR: Integer;
        j: Integer;
        Line: Integer;
        Date: Date;
        Admin: array[12] of Decimal;
        RIFA: array[12] of Decimal;
        EDLI: array[12] of Decimal;
        SN: Integer;
        CompanyAdd: Text;
        Name___Address_of_the_Factory_EstablishmentCaptionLbl: Label 'Name & Address of the Factory/Establishment';
        Paragraph_43_of_the_Employee_CaptionLbl: Label '[Paragraph 43 of the Employee''s Provident Funds Scheme, 1952 and Paragraph 20(4) of the Employee''s Pension Scheme 1995]';
        Statutory_rate_of_contributionCaptionLbl: Label 'Statutory rate of contribution';
        No__of_Members_voluntarily___CaptionLbl: Label 'No. of Members voluntarily...';
        Contributing_at_a_higher_rate________________________CaptionLbl: Label 'Contributing at a higher rate........................';
        FORM_6_ACaptionLbl: Label 'FORM 6-A';
        Code_No__of_the_Establishment____________________________CaptionLbl: Label 'Code No. of the Establishment............................';
        SI_No_CaptionLbl: Label 'SI.No.';
        Account_No_CaptionLbl: Label 'Account No.';
        Name_of_the_Memeber___in_block_letters_CaptionLbl: Label 'Name of the Memeber ( in block letters)';
        Wages__Retaining_allowance_CaptionLbl: Label 'Wages. Retaining allowance (if any) and D.A. including cash value of food concession paid during the currency period';
        Amount_of_Worker_s_Contributions_deducted_from_the_wagesCaptionLbl: Label 'Amount of Worker''s Contributions deducted from the wages';
        Employer_s_ContributionCaptionLbl: Label 'Employer''s Contribution';
        Refund_of_AdvancesCaptionLbl: Label 'Refund of Advances';
        RemarksCaptionLbl: Label 'Remarks';
        E_P_F_differences_between_10___8_13_CaptionLbl: Label 'E.P.F differences between 10 % 8-13%';
        Pension_Fund_8_13_CaptionLbl: Label 'Pension Fund 8-13%';
        Rate_of_higher_voluntary_contribution__if_any_CaptionLbl: Label 'Rate of higher voluntary contribution (if any)';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        V4CaptionLbl: Label '4';
        V5CaptionLbl: Label '5';
        V6CaptionLbl: Label '6';
        V7CaptionLbl: Label '7';
        V8CaptionLbl: Label '8';
        V9CaptionLbl: Label '9';
        V10CaptionLbl: Label '10';
        toCaptionLbl: Label 'to';
        Annual_statement_of_contribution_for_the_currency_period_from_CaptionLbl: Label '"Annual statement of contribution for the currency period from "';
        Clos__5_6_7_Rs_CaptionLbl: Label 'Clos. 5,6,7 Rs.';
        Aggregate________Contributions_____CaptionLbl: Label 'Aggregate (  )   Contributions (  )';
        Adim__Charges_Rs__at_1_1___of_Wages_CaptionLbl: Label '(Adim. Charges Rs. at 1.1 % of Wages)';
        Amount_remittedCaptionLbl: Label 'Amount remitted';
        Reconcilation_of_RemittancesCaptionLbl: Label 'Reconcilation of Remittances';
        March_Paid_in_AprilCaptionLbl: Label 'March Paid in April';
        MayCaptionLbl: Label 'May';
        JuneCaptionLbl: Label 'June';
        JulyCaptionLbl: Label 'July';
        AugustCaptionLbl: Label 'August';
        SeptemberCaptionLbl: Label 'September';
        OctoberCaptionLbl: Label 'October';
        NovemberCaptionLbl: Label 'November';
        DecemberCaptionLbl: Label 'December';
        JanuaryCaptionLbl: Label 'January';
        FebruaryCaptionLbl: Label 'February';
        Feb__Paid_in_MarchCaptionLbl: Label 'Feb. Paid in March';
        MonthCaptionLbl: Label 'Month';
        EDLI_Contribution_A_c__21_CaptionLbl: Label '"EDLI Contribution A/c. 21 "';
        E_P_FCaptionLbl: Label 'E.P.F';
        Adm__Charges_A_C_No_2CaptionLbl: Label 'Adm. Charges A/C No.2';
        Pension_Fund__Contributions_A_c_No__10CaptionLbl: Label 'Pension Fund  Contributions A/c No. 10';
        EDLI_Admin__Charges_0_01__A_c__No__22CaptionLbl: Label 'EDLI Admin. Charges 0.01% A/c. No. 22';
        TotalCaptionLbl: Label 'Total';
        i__Total_Number_of_contribution_cards_enclosed____Form_3A__Revised__CaptionLbl: Label 'i) Total Number of contribution cards enclosed [ (Form 3A (Revised)]';
        ii__Certified_that_Form_3A_pLbl: Label 'ii) Certified that Form 3A duly completed, of all the members listed in this already sent during the course of  the currency period for the final settlement of the concerned members account vide "Remarks" Furnished against the names of the respective members above.';
        Date_of_RemittancesCaptionLbl: Label 'Date of Remittances';
        Sl__No_CaptionLbl: Label 'Sl. No.';
        V1Caption_Control1102152150Lbl: Label '1';
        V2Caption_Control1102152151Lbl: Label '2';
        V3Caption_Control1102152152Lbl: Label '3';
        V4Caption_Control1102152153Lbl: Label '4';
        V5Caption_Control1102152154Lbl: Label '5';
        V6Caption_Control1102152155Lbl: Label '6';
        V7Caption_Control1102152156Lbl: Label '7';
        V8Caption_Control1102152157Lbl: Label '8';
        V9Caption_Control1102152158Lbl: Label '9';
        V10Caption_Control1102152159Lbl: Label '10';
        V11CaptionLbl: Label '11';
        V12CaptionLbl: Label '12';
        Signature_of_the_EmployerCaptionLbl: Label 'Signature of the Employer';
        With_official_Seal_CaptionLbl: Label '(With official Seal)';
        V1__The_Names_of_all_members_thisLbl: Label '"1) The Names of all members, including those who had left the service during the currency period, should be included in this statement. Where the form 3A in respect of such members had left service were already "';
        V2__In_case_of_substantialLbl: Label '2) In case of substantial variation in the wages/Contributions of any members as compared to those shown in previous months statement, the reasons should be explained adequately in the "Remarks" column';
        V3__In_respect_of_thoseLbl: Label '3) In respect of those members who have not opted for Pension Fund their entire employers contribution @ 8 1/3 % or 10 % as the case may be should be shown under column No. 6';
        sent_to_the_RegionalLbl: Label 'sent to the Regional Office for the purpose of final settlement of their accounts, the fact should be stated against the members in the "Remarks" column above thus "Form 3A already sent in the month of';
        V200________CaptionLbl: Label '........................200......."';
        JanuaryTxt: Label 'January';
        FeburaryTxt: Label 'Feburary';
        MarchTxt: Label 'March';
        AprilTxt: Label 'April';
        MayTxt: Label 'May';
        JuneTxt: Label 'June';
        JulyTxt: Label 'July';
        AugustTxt: Label 'August';
        SeptemberTxt: Label 'September';
        OctoberTxt: Label 'October';
        NovemberTxt: Label 'November';
        DecemberTxt: Label 'December';
        PFTxt: Label 'PF';
        MonthTxt: Label '<+1M>';
        PFYearTxt: Label 'PF YEAR';

    procedure PFCalc(Mon: Integer; ProcessedSalary2: Record "Processed Salary B2B");
    begin
        if Mon = 1 then begin
            EM[1] += ProcessedSalary2."Earned Amount";
            EPF[1] += ProcessedSalary2."Co. Contributions";
            PF1[1] += ProcessedSalary2."Co. Contribution2";
            Admin[1] += ProcessedSalary."PF Admin Charges";
            RIFA[1] += ProcessedSalary."RIFA Charges";
            EDLI[1] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 2 then begin
            EM[2] += ProcessedSalary2."Earned Amount";
            EPF[2] += ProcessedSalary2."Co. Contributions";
            PF1[2] += ProcessedSalary2."Co. Contribution2";
            Admin[2] += ProcessedSalary."PF Admin Charges";
            RIFA[2] += ProcessedSalary."RIFA Charges";
            EDLI[2] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 3 then begin
            EM[3] += ProcessedSalary2."Earned Amount";
            EPF[3] += ProcessedSalary2."Co. Contributions";
            PF1[3] += ProcessedSalary2."Co. Contribution2";
            Admin[3] += ProcessedSalary."PF Admin Charges";
            RIFA[3] += ProcessedSalary."RIFA Charges";
            EDLI[3] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 4 then begin
            EM[4] += ProcessedSalary2."Earned Amount";
            EPF[4] += ProcessedSalary2."Co. Contributions";
            PF1[4] += ProcessedSalary2."Co. Contribution2";
            Admin[4] += ProcessedSalary."PF Admin Charges";
            RIFA[4] += ProcessedSalary."RIFA Charges";
            EDLI[4] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 5 then begin
            EM[5] += ProcessedSalary2."Earned Amount";
            EPF[5] += ProcessedSalary2."Co. Contributions";
            PF1[5] += ProcessedSalary2."Co. Contribution2";
            Admin[5] += ProcessedSalary."PF Admin Charges";
            RIFA[5] += ProcessedSalary."RIFA Charges";
            EDLI[5] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 6 then begin
            EM[6] += ProcessedSalary2."Earned Amount";
            EPF[6] += ProcessedSalary2."Co. Contributions";
            PF1[6] += ProcessedSalary2."Co. Contribution2";
            Admin[6] += ProcessedSalary."PF Admin Charges";
            RIFA[6] += ProcessedSalary."RIFA Charges";
            EDLI[6] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 7 then begin
            EM[7] += ProcessedSalary2."Earned Amount";
            EPF[7] += ProcessedSalary2."Co. Contributions";
            PF1[7] += ProcessedSalary2."Co. Contribution2";
            Admin[7] += ProcessedSalary."PF Admin Charges";
            RIFA[7] += ProcessedSalary."RIFA Charges";
            EDLI[7] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 8 then begin
            EM[8] += ProcessedSalary2."Earned Amount";
            EPF[8] += ProcessedSalary2."Co. Contributions";
            PF1[8] += ProcessedSalary2."Co. Contribution2";
            Admin[8] += ProcessedSalary."PF Admin Charges";
            RIFA[8] += ProcessedSalary."RIFA Charges";
            EDLI[8] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 9 then begin
            EM[9] += ProcessedSalary2."Earned Amount";
            EPF[9] += ProcessedSalary2."Co. Contributions";
            PF1[9] += ProcessedSalary2."Co. Contribution2";
            Admin[9] += ProcessedSalary."PF Admin Charges";
            RIFA[9] += ProcessedSalary."RIFA Charges";
            EDLI[9] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 10 then begin
            EM[10] += ProcessedSalary2."Earned Amount";
            EPF[10] += ProcessedSalary2."Co. Contributions";
            PF1[10] += ProcessedSalary2."Co. Contribution2";
            Admin[10] += ProcessedSalary."PF Admin Charges";
            RIFA[10] += ProcessedSalary."RIFA Charges";
            EDLI[10] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 11 then begin
            EM[11] += ProcessedSalary2."Earned Amount";
            EPF[11] += ProcessedSalary2."Co. Contributions";
            PF1[11] += ProcessedSalary2."Co. Contribution2";
            Admin[11] += ProcessedSalary."PF Admin Charges";
            RIFA[11] += ProcessedSalary."RIFA Charges";
            EDLI[11] += ProcessedSalary."EDLI Charges";
        end;
        if Mon = 12 then begin
            EM[12] += ProcessedSalary2."Earned Amount";
            EPF[12] += ProcessedSalary2."Co. Contributions";
            PF1[12] += ProcessedSalary2."Co. Contribution2";
            Admin[12] += ProcessedSalary."PF Admin Charges";
            RIFA[12] += ProcessedSalary."RIFA Charges";
            EDLI[12] += ProcessedSalary."EDLI Charges";
        end;
    end;
}

