report 33001206 "PF FORM 3-A B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PF FORM 3-A.rdl';
    Caption = 'FORM 3-A (Revised)';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(EM_5_; EM[5])
            {
            }
            column(EPF_5_; EPF[5])
            {
            }
            column(PF_5_; PF[5])
            {
            }
            column(EM_6_; EM[6])
            {
            }
            column(EPF_6_; EPF[6])
            {
            }
            column(PF_6_; PF[6])
            {
            }
            column(PF_7_; PF[7])
            {
            }
            column(EPF_7_; EPF[7])
            {
            }
            column(EM_7_; EM[7])
            {
            }
            column(PF_8_; PF[8])
            {
            }
            column(EPF_8_; EPF[8])
            {
            }
            column(EM_8_; EM[8])
            {
            }
            column(PF_9_; PF[9])
            {
            }
            column(EPF_9_; EPF[9])
            {
            }
            column(EM_9_; EM[9])
            {
            }
            column(PF_10_; PF[10])
            {
            }
            column(EPF_10_; EPF[10])
            {
            }
            column(EM_10_; EM[10])
            {
            }
            column(PF_11_; PF[11])
            {
            }
            column(EPF_11_; EPF[11])
            {
            }
            column(EM_11_; EM[11])
            {
            }
            column(PF_12_; PF[12])
            {
            }
            column(EPF_12_; EPF[12])
            {
            }
            column(EM_12_; EM[12])
            {
            }
            column(PF_1_; PF[1])
            {
            }
            column(EPF_1_; EPF[1])
            {
            }
            column(EM_1_; EM[1])
            {
            }
            column(PF_2_; PF[2])
            {
            }
            column(EPF_2_; EPF[2])
            {
            }
            column(EM_2_; EM[2])
            {
            }
            column(PF_3_; PF[3])
            {
            }
            column(EPF_3_; EPF[3])
            {
            }
            column(EM_3_; EM[3])
            {
            }
            column(Employee_B2B__PF_No_; "PF No")
            {
            }
            column(Employee_B2B__Father_Husband_; "Father/Husband")
            {
            }
            column(UPPERCASE_Employee_B2B__First_Name__Employee_B2B__Last_Name__;
            UPPERCASE("Employee B2B"."First Name" + "Employee B2B"."Last Name"))
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(Salary_3_; Salary[3])
            {
            }
            column(Salary_4_; Salary[4])
            {
            }
            column(Salary_5_; Salary[5])
            {
            }
            column(Salary_6_; Salary[6])
            {
            }
            column(Salary_7_; Salary[7])
            {
            }
            column(Salary_8_; Salary[8])
            {
            }
            column(Salary_9_; Salary[9])
            {
            }
            column(Salary_10_; Salary[10])
            {
            }
            column(Salary_11_; Salary[11])
            {
            }
            column(Salary_12_; Salary[12])
            {
            }
            column(Salary_1_; Salary[1])
            {
            }
            column(Salary_2_; Salary[2])
            {
            }
            column(PF_4_; PF[4])
            {
            }
            column(EPF_4_; EPF[4])
            {
            }
            column(EM_4_; EM[4])
            {
            }
            column(EM_1__EM_2__EM_3__EM_4__EM_5__EM_6__EM_7__EM_8__EM_9__EM_10__EM_11__EM_12_; EM[1] + EM[2] + EM[3] + EM[4] + EM[5] + EM[6] + EM[7] + EM[8] + EM[9] + EM[10] + EM[11] + EM[12])
            {
            }
            column(DataItem1102152078; Salary[1] + Salary[2] + Salary[3] + Salary[4] + Salary[5] + Salary[6] + Salary[7] + Salary[8] + Salary[9] + Salary[10] + Salary[11] + Salary[12])
            {
            }
            column(EPF_1__EPF_2__EPF_3__EPF_4__EPF_5__EPF_6__EPF_7__EPF_8__EPF_9__EPF_10__EPF_11__EPF_12_; EPF[1] + EPF[2] + EPF[3] + EPF[4] + EPF[5] + EPF[6] + EPF[7] + EPF[8] + EPF[9] + EPF[10] + EPF[11] + EPF[12])
            {
            }
            column(PF_1__PF_2__PF_3__PF_4__PF_5__PF_6__PF_7__PF_8__PF_9__PF_10__PF_11__PF_12_; PF[1] + PF[2] + PF[3] + PF[4] + PF[5] + PF[6] + PF[7] + PF[8] + PF[9] + PF[10] + PF[11] + PF[12])
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
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
            column(V1_Caption; V1_CaptionLbl)
            {
            }
            column(V2_Caption; V2_CaptionLbl)
            {
            }
            column(V3_Caption; V3_CaptionLbl)
            {
            }
            column(V4_Caption; V4_CaptionLbl)
            {
            }
            column(V5_Caption; V5_CaptionLbl)
            {
            }
            column(V6_Caption; V6_CaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Father_s_Name__Husband_s_NameCaption; Father_s_Name__Husband_s_NameCaptionLbl)
            {
            }
            column(Name_and_Addressof_the_Factory_EstablishmentCaption; Name_and_Addressof_the_Factory_EstablishmentCaptionLbl)
            {
            }
            column(Statutory_rate_of_the_ContributionCaption; Statutory_rate_of_the_ContributionCaptionLbl)
            {
            }
            column(Voluntary_higher_rate_of_employee_s_contribution__if_any_Caption; Voluntary_higher_rate_of_employee_s_contribution__if_any_CaptionLbl)
            {
            }
            column(For_Unexempted_Establishments_onlyCaption; For_Unexempted_Establishments_onlyCaptionLbl)
            {
            }
            column(FORM3_A__Revised_Caption; FORM3_A__Revised_CaptionLbl)
            {
            }
            column(Paras_35___42_of_the_Employees__Provident_FundsScheme_1952Caption; Paras_35___42_of_the_Employees__Provident_FundsScheme_1952CaptionLbl)
            {
            }
            column(and_Para_19_of_The_Employees_Pension_Scheme_1995_Caption; and_Para_19_of_The_Employees_Pension_Scheme_1995_CaptionLbl)
            {
            }
            column(MonthCaption; MonthCaptionLbl)
            {
            }
            column(Worker_s_shareCaption; Worker_s_shareCaptionLbl)
            {
            }
            column(Employer_s_shareCaption; Employer_s_shareCaptionLbl)
            {
            }
            column(ContributionsCaption; ContributionsCaptionLbl)
            {
            }
            column(Refund_of_advancesCaption; Refund_of_advancesCaptionLbl)
            {
            }
            column(Amount_of_WagesCaption; Amount_of_WagesCaptionLbl)
            {
            }
            column(E_P_FCaption; E_P_FCaptionLbl)
            {
            }
            column(E_P_F_dDifference_between_13____8_13___if_any_Caption; E_P_F_dDifference_between_13____8_13___if_any_CaptionLbl)
            {
            }
            column(P_F_contribution_8_13_Caption; P_F_contribution_8_13_CaptionLbl)
            {
            }
            column(No__of_days_period_of_service_non_contributing__if_any_Caption; No__of_days_period_of_service_non_contributing__if_any_CaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
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
            column(V4_a_Caption; V4_a_CaptionLbl)
            {
            }
            column(V4_b_Caption; V4_b_CaptionLbl)
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
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Contribution_Card_for_the_currency_of_period_fromCaption; Contribution_Card_for_the_currency_of_period_fromCaptionLbl)
            {
            }
            column("to"; toLbl)
            {
            }
            column(Date_of_leavingCaption; Date_of_leavingCaptionLbl)
            {
            }
            column(Reason_of_leavingCaption; Reason_of_leavingCaptionLbl)
            {
            }
            column(Certified_that_the_total_amount_of_contribution_both_shares__indicated_in_this_card_i_e__RsCaption; Certified_that_the_total_amount_of_contribution_both_shares__indicated_in_this_card_i_e__RsCaptionLbl)
            {
            }
            column(EPF_Account_No__1Caption; EPF_Account_No__1CaptionLbl)
            {
            }
            column(and_Pension_Fund_A_c_No__10Caption; and_Pension_Fund_A_c_No__10CaptionLbl)
            {
            }
            column(vide_note_below_Caption; vide_note_below_CaptionLbl)
            {
            }
            column(DataItem1102152031; Certified_that_the_difference_Lbl)
            {
            }
            column(DataItem1102152032; shown_in_column_2_at_the_prescribed_Lbl)
            {
            }
            column(DatedCaption; DatedCaptionLbl)
            {
            }
            column(has_already_been_remited_in_full_Caption; has_already_been_remited_in_full_CaptionLbl)
            {
            }
            column(Signature_of_the_employer_with_office_sealCaption; Signature_of_the_employer_with_office_sealCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(EM);
                CLEAR(EPF);
                CLEAR(PF);
                CLEAR(Line);
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
                    ProcessedSalary.SETRANGE("Add/Deduct Code", PFTextTxt);
                    ProcessedSalary.SETRANGE("Pay Slip Month", Mon);
                    ProcessedSalary.SETRANGE(Year, YR);
                    if ProcessedSalary.FINDFIRST() then
                        PFCalc(Mon, ProcessedSalary);
                    Date := CALCDATE('<' + MonthTextTxt, Date + '>');
                    if (Date > EndDate) then
                        exit;
                    Mon := DATE2DMY(Date, 2);
                    YR := DATE2DMY(Date, 3);
                end;
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
                        ToolTip = 'Select the PF year for which 3A Form to be generated';
                        Caption = 'PF YEAR';
                        ApplicationArea = all;

                        trigger OnLookup(var Text: Text): Boolean;
                        begin
                            PayrollYears.SETRANGE(PayrollYears."Year Type", 'PF YEAR');
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

        PayrollYears: Record "Payroll Year B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        EM: array[12] of Decimal;
        EPF: array[12] of Decimal;
        PF: array[12] of Decimal;
        Salary: array[12] of Decimal;
        Mon: Integer;
        MS: Integer;
        ME: Integer;
        YS: Integer;
        YE: Integer;
        YR: Integer;
        j: Integer;
        Line: Integer;
        PfYearGVar: Code[50];
        StartDate: Date;
        EndDate: Date;
        Date: Date;
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
        V1_CaptionLbl: Label '1.';
        V2_CaptionLbl: Label '2.';
        V3_CaptionLbl: Label '3.';
        V4_CaptionLbl: Label '4.';
        V5_CaptionLbl: Label '5.';
        V6_CaptionLbl: Label '6.';
        Account_No_CaptionLbl: Label 'Account No.';
        NameCaptionLbl: Label 'Name';
        Father_s_Name__Husband_s_NameCaptionLbl: Label 'Father''s Name/ Husband''s Name';
        Name_and_Addressof_the_Factory_EstablishmentCaptionLbl: Label 'Name and Address of the Factory/Establishment';
        Statutory_rate_of_the_ContributionCaptionLbl: Label 'Statutory rate of the Contribution';
        Voluntary_higher_rate_of_employee_s_contribution__if_any_CaptionLbl: Label '"Voluntary higher rate of employee''s contribution, if any "';
        For_Unexempted_Establishments_onlyCaptionLbl: Label 'For Unexempted Establishments only';
        FORM3_A__Revised_CaptionLbl: Label 'FORM3-A (Revised)';
        Paras_35___42_of_the_Employees__Provident_FundsScheme_1952CaptionLbl: Label '(Paras 35 & 42 of the Employees'' Provident FundsScheme 1952';
        and_Para_19_of_The_Employees_Pension_Scheme_1995_CaptionLbl: Label 'and Para 19 of The Employees Pension Scheme 1995)';
        MonthCaptionLbl: Label 'Month';
        Worker_s_shareCaptionLbl: Label 'Worker''s share';
        Employer_s_shareCaptionLbl: Label 'Employer''s share';
        ContributionsCaptionLbl: Label 'Contributions';
        Refund_of_advancesCaptionLbl: Label 'Refund of advances';
        Amount_of_WagesCaptionLbl: Label 'Amount of Wages';
        E_P_FCaptionLbl: Label 'E.P.F';
        E_P_F_dDifference_between_13____8_13___if_any_CaptionLbl: Label 'E.P.F dDifference between 13% & 8.13% (if any)';
        P_F_contribution_8_13_CaptionLbl: Label 'P.F contribution 8.13%';
        No__of_days_period_of_service_non_contributing__if_any_CaptionLbl: Label 'No. of days/period of service non-contributing (if any)';
        RemarksCaptionLbl: Label 'Remarks';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        V4_a_CaptionLbl: Label '4(a)';
        V4_b_CaptionLbl: Label '4(b)';
        V5CaptionLbl: Label '5';
        V6CaptionLbl: Label '6';
        V7CaptionLbl: Label '7';
        TotalCaptionLbl: Label 'Total';
        Contribution_Card_for_the_currency_of_period_fromCaptionLbl: Label 'Contribution Card for the currency of period from';
        toLbl: Label 'to';
        Date_of_leavingCaptionLbl: Label 'Date of leaving';
        Reason_of_leavingCaptionLbl: Label 'Reason of leaving';
        Certified_that_the_total_amount_of_contribution_both_shares__indicated_in_this_card_i_e__RsCaptionLbl: Label 'Certified that the total amount of contribution(both shares) indicated in this card i,e. Rs';
        EPF_Account_No__1CaptionLbl: Label 'EPF Account No. 1';
        and_Pension_Fund_A_c_No__10CaptionLbl: Label 'and Pension Fund A/c No. 10';
        vide_note_below_CaptionLbl: Label '(vide note below)';
        Certified_that_the_difference_Lbl: Label 'Certified that the difference between the total of the contribution shown under cols. 3 & 4(a) & 4(b) of the above table and that arrived at on the total wages';
        shown_in_column_2_at_the_prescribed_Lbl: Label 'shown in column 2 at the prescribed rate is solely due to rounding off of contributions to the nearest rupee under the rules.';
        DatedCaptionLbl: Label 'Dated';
        has_already_been_remited_in_full_CaptionLbl: Label '"has already been remited in full "';
        Signature_of_the_employer_with_office_sealCaptionLbl: Label 'Signature of the employer with office seal';
        PFTextTxt: Label 'PF';
        MonthTextTxt: Label '+1M';

    procedure PFCalc(Mon: Integer; ProcessedSalary2: Record "Processed Salary B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
    begin
        PayRevisionLine.SETRANGE(Month, ProcessedSalary2."Pay Slip Month");
        PayRevisionLine.SETRANGE(Year, ProcessedSalary2.Year);
        PayRevisionLine.SETRANGE("No.", ProcessedSalary2."Employee Code");
        PayRevisionLine.SETRANGE("Pay Element", PFTextTxt);
        if PayRevisionLine.FINDFIRST() then;
        if Mon = 1 then begin
            EM[1] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[1] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[1] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[1] := ProcessedSalary2.Salary;
        end;
        if Mon = 2 then begin
            EM[2] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[2] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[2] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[2] := ProcessedSalary2.Salary;
        end;
        if Mon = 3 then begin
            EM[3] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[3] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[3] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[3] := ProcessedSalary2.Salary;
        end;
        if Mon = 4 then begin
            EM[4] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[4] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[4] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[4] := ProcessedSalary2.Salary;
        end;
        if Mon = 5 then begin
            EM[5] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[5] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[5] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[5] := ProcessedSalary2.Salary;
        end;
        if Mon = 6 then begin
            EM[6] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[6] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[6] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[6] := ProcessedSalary2.Salary;
        end;
        if Mon = 7 then begin
            EM[7] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[7] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[7] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[7] := ProcessedSalary2.Salary;
        end;
        if Mon = 8 then begin
            EM[8] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[8] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[8] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[8] := ProcessedSalary2.Salary;
        end;
        if Mon = 9 then begin
            EM[9] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[9] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[9] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[9] := ProcessedSalary2.Salary;
        end;
        if Mon = 10 then begin
            EM[10] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[10] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[10] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[10] := ProcessedSalary2.Salary;
        end;
        if Mon = 11 then begin
            EM[11] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[11] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[11] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[11] := ProcessedSalary2.Salary;
        end;
        if Mon = 12 then begin
            EM[12] := ProcessedSalary2."Earned Amount" + PayRevisionLine."Arrear Amount";
            EPF[12] := ProcessedSalary2."Co. Contributions" + PayRevisionLine."Arrear Co. Contribution";
            PF[12] := ProcessedSalary2."Co. Contribution2" + PayRevisionLine."Arrear Co. Contribution2";
            Salary[12] := ProcessedSalary2.Salary;
        end;
    end;
}

