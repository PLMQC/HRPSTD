report 33001313 "Form 16 - Employee B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Form 16 - Employee.rdl';
    Caption = 'Form 16 - Employee';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            PrintOnlyIfDetail = false;
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(Name; NameGVar)
            {
            }
            column(FatherName; FatherNameGVar)
            {
            }
            column(Place; PlaceGVar)
            {
            }
            column(DOI; TODAY())
            {
            }
            column(Designation1; Designation1GVar)
            {
            }
            column(Employee_B2B_Employee_B2B__PAN_No_; "Employee B2B"."PAN No")
            {
            }
            column(QuarterlyAmounts_1_; QuarterlyAmounts[1])
            {
            }
            column(QuarterlyAmounts_3_; QuarterlyAmounts[3])
            {
            }
            column(QuarterlyAmounts_2_; QuarterlyAmounts[2])
            {
            }
            column(QuarterlyAmounts_4_; QuarterlyAmounts[4])
            {
            }
            column(QuarterlyAmounts_5_; QuarterlyAmounts[5])
            {
            }
            column(QuarterlyAmounts_5__Control1102152067; QuarterlyAmounts[5])
            {
            }
            column(QuarterlyAmounts_4__Control1102152068; QuarterlyAmounts[4])
            {
            }
            column(QuarterlyAmounts_3__Control1102152069; QuarterlyAmounts[3])
            {
            }
            column(QuarterlyAmounts_2__Control1102152070; QuarterlyAmounts[2])
            {
            }
            column(QuarterlyAmounts_1__Control1102152071; QuarterlyAmounts[1])
            {
            }
            column(TDSDeductions__Gross_Salary__TDSDeductions_Perks; TDSDeductions."Gross Salary" + TDSDeductions.Perks)
            {
            }
            column(TDSDeductions__Profit_Lieu_of_Salary_; TDSDeductions."Profit Lieu of Salary")
            {
            }
            column(TDSDeductions__Value_of_prequisites_; TDSDeductions."Value of prequisites")
            {
            }
            column(DataItem1102152065; TDSDeductions."Gross Salary" + TDSDeductions."Value of prequisites" + TDSDeductions."Profit Lieu of Salary" + TDSDeductions.Perks)
            {
            }
            column(TDSDeductions__PT_Amount_; TDSDeductions."PT Amount")
            {
            }
            column(TDSDeductions__Entertainment_Allowance__TDSDeductions__PT_Amount_; TDSDeductions."Entertainment Allowance" + TDSDeductions."PT Amount")
            {
            }
            column(TDSDeductions__Exem_Under_10_and_17_; TDSDeductions."Exem Under 10 and 17")
            {
            }
            column(DataItem1102152076; (TDSDeductions."Gross Salary" + TDSDeductions."Value of prequisites" + TDSDeductions."Profit Lieu of Salary" + TDSDeductions.Perks) - TDSDeductions."Exem Under 10 and 17")
            {
            }
            column(DataItem1102152080; ((TDSDeductions."Gross Salary" + TDSDeductions."Value of prequisites" + TDSDeductions."Profit Lieu of Salary" + TDSDeductions.Perks) - TDSDeductions."Exem Under 10 and 17") - (TDSDeductions."Entertainment Allowance" + TDSDeductions."PT Amount"))
            {
            }
            column(StYear; StYear)
            {
            }
            column(EndYear; EndYear)
            {
            }
            column(Q_1_; Q[1])
            {
            }
            column(Q_2_; Q[2])
            {
            }
            column(Q_4_; Q[4])
            {
            }
            column(Q_3_; Q[3])
            {
            }
            column(Allowance_1_; Allowance[1])
            {
            }
            column(Allowance_2_; Allowance[2])
            {
            }
            column(Allowance_3_; Allowance[3])
            {
            }
            column(Allowance_4_; Allowance[4])
            {
            }
            column(Allowance_5_; Allowance[5])
            {
            }
            column(Allowance_6_; Allowance[6])
            {
            }
            column(Allowance_7_; Allowance[7])
            {
            }
            column(Allowance_3__Control1102152140; Allowance[3])
            {
            }
            column(HousePrpty; HousePrpty)
            {
            }
            column(HousePrpty___HBLInt__Allowance_3_; HousePrpty + HBLInt + Allowance[3])
            {
            }
            column(Companyinform_Name_________Companyinform_Address; UPPERCASE(Companyinform.Name))
            {
            }
            column(Companyinform_Address; Companyinform.Address)
            {
            }
            column(Companyinform__Address_2________Companyinform_City_____Companyinform__Post_Code_; Companyinform."Address 2" + ',' + Companyinform.City + '-' + Companyinform."Post Code")
            {
            }
            column(HBLInt; HBLInt)
            {
            }
            column(SectionAmt_5_; SectionAmt[5])
            {
            }
            column(SectionAmt_6_; SectionAmt[6])
            {
            }
            column(SectionAmt_7_; SectionAmt[7])
            {
            }
            column(SectionAmt_8_; SectionAmt[8])
            {
            }
            column(SectionAmt_9_; SectionAmt[9])
            {
            }
            column(SectionAmt_10_; SectionAmt[10])
            {
            }
            column(SectionAmt_11_; SectionAmt[11])
            {
            }
            column(SectionAmt_12_; SectionAmt[12])
            {
            }
            column(SectionAmt_13_; SectionAmt[13])
            {
            }
            column(SectionAmt_13__Control1102152556; SectionAmt[13])
            {
            }
            column(SectionAmt_12__Control1102152557; SectionAmt[12])
            {
            }
            column(SectionAmt_11__Control1102152558; SectionAmt[11])
            {
            }
            column(SectionAmt_10__Control1102152559; SectionAmt[10])
            {
            }
            column(SectionAmt_9__Control1102152560; SectionAmt[9])
            {
            }
            column(SectionAmt_8__Control1102152561; SectionAmt[8])
            {
            }
            column(SectionAmt_7__Control1102152562; SectionAmt[7])
            {
            }
            column(SectionAmt_6__Control1102152563; SectionAmt[6])
            {
            }
            column(SectionAmt_5__Control1102152564; SectionAmt[5])
            {
            }
            column(SectionAmt_15_; SectionAmt[15])
            {
            }
            column(SectionAmt_14_; SectionAmt[14])
            {
            }
            column(SectionAmt_15__Control1102152543; SectionAmt[15])
            {
            }
            column(SectionAmt_14__Control1102152545; SectionAmt[14])
            {
            }
            column(CCFAmt; CCFAmt)
            {
            }
            column(CCFAmt_Control1102152549; CCFAmt)
            {
            }
            column(TotalSecAmt; TotalSecAmt)
            {
            }
            column(Sec80Amt_1_; Sec80Amt[1])
            {
            }
            column(Sec80Amt_2_; Sec80Amt[2])
            {
            }
            column(Sec80Amt_3_; Sec80Amt[3])
            {
            }
            column(Sec80Amt_4_; Sec80Amt[4])
            {
            }
            column(Sec80Amt_5_; Sec80Amt[5])
            {
            }
            column(Sec80Amt_6_; Sec80Amt[6])
            {
            }
            column(Sec80Amt_7_; Sec80Amt[7])
            {
            }
            column(Sec80Amt_8_; Sec80Amt[8])
            {
            }
            column(Sec80Amt_9_; Sec80Amt[9])
            {
            }
            column(Sec80Amt_9__Control1102152602; Sec80Amt[9])
            {
            }
            column(Sec80Amt_1__Control1102152603; Sec80Amt[1])
            {
            }
            column(Sec80Amt_2__Control1102152604; Sec80Amt[2])
            {
            }
            column(Sec80Amt_3__Control1102152605; Sec80Amt[3])
            {
            }
            column(Sec80Amt_4__Control1102152606; Sec80Amt[4])
            {
            }
            column(Sec80Amt_5__Control1102152607; Sec80Amt[5])
            {
            }
            column(Sec80Amt_6__Control1102152608; Sec80Amt[6])
            {
            }
            column(Sec80Amt_7__Control1102152609; Sec80Amt[7])
            {
            }
            column(Sec80Amt_8__Control1102152610; Sec80Amt[8])
            {
            }
            column(TotSec80Amt___TotalSecAmt; TotSec80Amt + TotalSecAmt)
            {
            }
            column(GrossAmt__TotSec80Amt___TotalSecAmt_; GrossAmt - (TotSec80Amt + TotalSecAmt))
            {
            }
            column(ROUND_TA_1_____; ROUND(TA, 1, '='))
            {
            }
            column(TACess; TACess)
            {
            }
            column(TDSDeductions__Total_Tax_Liability_; ROUND(TA, 0.5, '>') - TDSDeductions."Rebate U/S 87 A")
            {
            }
            column(TDSDeductions__Total_Tax_Liability__Control1102152574; TDSDeductions."Total Tax Liability")
            {
            }
            column(TODAY; TODAY())
            {
            }
            column(TotalTDSNew; TotalTDSNew)
            {
            }
            column(FORMAT_DELSTR_LOWERCASE_NoText_1____NoText_2___1_4__; FORMAT(LOWERCASE(NoText[1] + NoText[2])))
            {
            }
            column(MonthlyTDS_4_; MonthlyTDS[4])
            {
            }
            column(MonthlyTDS_6_; MonthlyTDS[6])
            {
            }
            column(MonthlyTDS_8_; MonthlyTDS[8])
            {
            }
            column(MonthlyTDS_10_; MonthlyTDS[10])
            {
            }
            column(MonthlyTDS_12_; MonthlyTDS[12])
            {
            }
            column(MonthlyTDS_2_; MonthlyTDS[2])
            {
            }
            column(MonthlyTDS_3_; MonthlyTDS[3])
            {
            }
            column(MonthlyTDS_5_; MonthlyTDS[5])
            {
            }
            column(MonthlyTDS_7_; MonthlyTDS[7])
            {
            }
            column(MonthlyTDS_9_; MonthlyTDS[9])
            {
            }
            column(MonthlyTDS_11_; MonthlyTDS[11])
            {
            }
            column(MonthlyTDS_1_; MonthlyTDS[1])
            {
            }
            column(TotalTDS; TotalTDS)
            {
            }
            column(MonthlyTDS_1__Control1102152194; MonthlyTDS[1])
            {
            }
            column(MonthlyTDS_3__Control1102152195; MonthlyTDS[3])
            {
            }
            column(MonthlyTDS_5__Control1102152196; MonthlyTDS[5])
            {
            }
            column(MonthlyTDS_7__Control1102152197; MonthlyTDS[7])
            {
            }
            column(MonthlyTDS_9__Control1102152198; MonthlyTDS[9])
            {
            }
            column(MonthlyTDS_11__Control1102152199; MonthlyTDS[11])
            {
            }
            column(MonthlyTDS_12__Control1102152200; MonthlyTDS[12])
            {
            }
            column(MonthlyTDS_2__Control1102152201; MonthlyTDS[2])
            {
            }
            column(MonthlyTDS_4__Control1102152202; MonthlyTDS[4])
            {
            }
            column(MonthlyTDS_6__Control1102152203; MonthlyTDS[6])
            {
            }
            column(MonthlyTDS_8__Control1102152204; MonthlyTDS[8])
            {
            }
            column(MonthlyTDS_10__Control1102152205; MonthlyTDS[10])
            {
            }
            column(TotalTDSNew_Control1102152206; TotalTDSNew)
            {
            }
            column(TDAPaidDate_1_; TDAPaidDate[1])
            {
            }
            column(TDAPaidDate_2_; TDAPaidDate[2])
            {
            }
            column(TDAPaidDate_3_; TDAPaidDate[3])
            {
            }
            column(TDAPaidDate_4_; TDAPaidDate[4])
            {
            }
            column(TDAPaidDate_5_; TDAPaidDate[5])
            {
            }
            column(TDAPaidDate_6_; TDAPaidDate[6])
            {
            }
            column(TDAPaidDate_7_; TDAPaidDate[7])
            {
            }
            column(TDAPaidDate_8_; TDAPaidDate[8])
            {
            }
            column(TDAPaidDate_9_; TDAPaidDate[9])
            {
            }
            column(TDAPaidDate_10_; TDAPaidDate[10])
            {
            }
            column(TDAPaidDate_11_; TDAPaidDate[11])
            {
            }
            column(TDAPaidDate_12_; TDAPaidDate[12])
            {
            }
            column(TDSChallanNo_1_; TDSChallanNo[1])
            {
            }
            column(TDSChallanNo_2_; TDSChallanNo[2])
            {
            }
            column(TDSChallanNo_3_; TDSChallanNo[3])
            {
            }
            column(TDSChallanNo_4_; TDSChallanNo[4])
            {
            }
            column(TDSChallanNo_5_; TDSChallanNo[5])
            {
            }
            column(TDSChallanNo_6_; TDSChallanNo[6])
            {
            }
            column(TDSChallanNo_7_; TDSChallanNo[7])
            {
            }
            column(TDSChallanNo_8_; TDSChallanNo[8])
            {
            }
            column(TDSChallanNo_9_; TDSChallanNo[9])
            {
            }
            column(TDSChallanNo_10_; TDSChallanNo[10])
            {
            }
            column(TDSChallanNo_11_; TDSChallanNo[11])
            {
            }
            column(TDSChallanNo_12_; TDSChallanNo[12])
            {
            }
            column(Salary_as_per_provisions_contained_in_Sec_17_1_Caption; Salary_as_per_provisions_contained_in_Sec_17_1_CaptionLbl)
            {
            }
            column(Gross_SalaryCaption; Gross_SalaryCaptionLbl)
            {
            }
            column(PART_B__Refer_Note_1_Caption; PART_B__Refer_Note_1_CaptionLbl)
            {
            }
            column(Details_of_Salary_paid_and_any_other_income_and_tax_deductedCaption; Details_of_Salary_paid_and_any_other_income_and_tax_deductedCaptionLbl)
            {
            }
            column(V1_Caption; V1_CaptionLbl)
            {
            }
            column(a_Caption; a_CaptionLbl)
            {
            }
            column(b_Caption; b_CaptionLbl)
            {
            }
            column(c_Caption; c_CaptionLbl)
            {
            }
            column(d_Caption; d_CaptionLbl)
            {
            }
            column(Value_of_prequisites_u_s_17_2__as_per_Form_No_12BA__whereverCaption; Value_of_prequisites_u_s_17_2__as_per_Form_No_12BA__whereverCaptionLbl)
            {
            }
            column(Profits_in_lieu_of_salary_under_section_17_3___as_per_Form_No__12BB_Caption; Profits_in_lieu_of_salary_under_section_17_3___as_per_Form_No__12BB_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(applicable_Caption; applicable_CaptionLbl)
            {
            }
            column(wherever_applicable_Caption; wherever_applicable_CaptionLbl)
            {
            }
            column(Less__Allowance_to_the_extent_exempt_u_s_10Caption; Less__Allowance_to_the_extent_exempt_u_s_10CaptionLbl)
            {
            }
            column(V2_Caption; V2_CaptionLbl)
            {
            }
            column(AllowanceCaption; AllowanceCaptionLbl)
            {
            }
            column(Rs_Caption; Rs_CaptionLbl)
            {
            }
            column(Balance__1_2_Caption; Balance__1_2_CaptionLbl)
            {
            }
            column(V3_Caption; V3_CaptionLbl)
            {
            }
            column(Deductions__Caption; Deductions__CaptionLbl)
            {
            }
            column(V4_Caption; V4_CaptionLbl)
            {
            }
            column(Tax_on_employmentCaption; Tax_on_employmentCaptionLbl)
            {
            }
            column(a_Caption_Control1102152150; a_Caption_Control1102152150Lbl)
            {
            }
            column(Aggregate_of_4_a_Caption; Aggregate_of_4_a_CaptionLbl)
            {
            }
            column(V5_Caption; V5_CaptionLbl)
            {
            }
            column(Income_chargeable_under_the_head__salaries___3_5_Caption; Income_chargeable_under_the_head__salaries___3_5_CaptionLbl)
            {
            }
            column(V6_Caption; V6_CaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152169; Rs_Caption_Control1102152169Lbl)
            {
            }
            column(IncomeCaption; IncomeCaptionLbl)
            {
            }
            column(Add__Any_other_income_reported_by_the_employeeCaption; Add__Any_other_income_reported_by_the_employeeCaptionLbl)
            {
            }
            column(V7_Caption; V7_CaptionLbl)
            {
            }
            column(Gross_total_income__6_7_Caption; Gross_total_income__6_7_CaptionLbl)
            {
            }
            column(V8_Caption; V8_CaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152002; Rs_Caption_Control1102152002Lbl)
            {
            }
            column(Rs_Caption_Control1102152003; Rs_Caption_Control1102152003Lbl)
            {
            }
            column(Rs_Caption_Control1102152004; Rs_Caption_Control1102152004Lbl)
            {
            }
            column(Rs_Caption_Control1102152005; Rs_Caption_Control1102152005Lbl)
            {
            }
            column(Rs_Caption_Control1102152007; Rs_Caption_Control1102152007Lbl)
            {
            }
            column(Rs_Caption_Control1102152009; Rs_Caption_Control1102152009Lbl)
            {
            }
            column(Rs_Caption_Control1102152011; Rs_Caption_Control1102152011Lbl)
            {
            }
            column(Rs_Caption_Control1102152012; Rs_Caption_Control1102152012Lbl)
            {
            }
            column(Rs_Caption_Control1102152013; Rs_Caption_Control1102152013Lbl)
            {
            }
            column(Rs_Caption_Control1102152017; Rs_Caption_Control1102152017Lbl)
            {
            }
            column(Form_16Caption; Form_16CaptionLbl)
            {
            }
            column(See_rule_31_1__a__Caption; See_rule_31_1__a__CaptionLbl)
            {
            }
            column(PART_ACaption; PART_ACaptionLbl)
            {
            }
            column(Name_and_address_of_the_EmployerCaption; Name_and_address_of_the_EmployerCaptionLbl)
            {
            }
            column(Certificate_under_section_203_of_the_Income_tax_Act__1961_for_tax_deducted_at_source_on_SalaryCaption; Certificate_under_section_203_of_the_Income_tax_Act__1961_for_tax_deducted_at_source_on_SalaryCaptionLbl)
            {
            }
            column(Name_and_Designation_of_the_EmployeeCaption; Name_and_Designation_of_the_EmployeeCaptionLbl)
            {
            }
            column(PAN_of_the_DeductorCaption; PAN_of_the_DeductorCaptionLbl)
            {
            }
            column(TAN_of_the_DeductorCaption; TAN_of_the_DeductorCaptionLbl)
            {
            }
            column(PAN_of_the_EmployeeCaption; PAN_of_the_EmployeeCaptionLbl)
            {
            }
            column(CIT__TDS_Caption; CIT__TDS_CaptionLbl)
            {
            }
            column(The_Commissioner_of_Income_Tax__TDS_Caption; The_Commissioner_of_Income_Tax__TDS_CaptionLbl)
            {
            }
            column(Room_No__411_Income_Tax_Towers_Caption; Room_No__411_Income_Tax_Towers_CaptionLbl)
            {
            }
            column(A_C__Guard_HyderabadCaption; A_C__Guard_HyderabadCaptionLbl)
            {
            }
            column(Pin_Code_500004Caption; Pin_Code_500004CaptionLbl)
            {
            }
            column(Assessment_YearCaption; Assessment_YearCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(FromCaption; FromCaptionLbl)
            {
            }
            column(ToCaption; ToCaptionLbl)
            {
            }
            column(Summary_of_tax_deducted_at_sourceCaption; Summary_of_tax_deducted_at_sourceCaptionLbl)
            {
            }
            column(QuarterCaption; QuarterCaptionLbl)
            {
            }
            column(Receipt_Numbers_of_original_statements_of_TDS_under_sub_section__3__of_section_200Caption; Receipt_Numbers_of_original_statements_of_TDS_under_sub_section__3__of_section_200CaptionLbl)
            {
            }
            column(Amount_of_tax_deducted_in_respect_of_the_employeeCaption; Amount_of_tax_deducted_in_respect_of_the_employeeCaptionLbl)
            {
            }
            column(Amount_of_tax_deposited__remitted_in_respect_of_the_employeeCaption; Amount_of_tax_deposited__remitted_in_respect_of_the_employeeCaptionLbl)
            {
            }
            column(Quarter_2Caption; Quarter_2CaptionLbl)
            {
            }
            column(Quarter_3Caption; Quarter_3CaptionLbl)
            {
            }
            column(Quarter_4Caption; Quarter_4CaptionLbl)
            {
            }
            column(Quarter_1Caption; Quarter_1CaptionLbl)
            {
            }
            column(TotalCaption_Control1102152310; TotalCaption_Control1102152310Lbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(HRA__Sec_10__13A__Caption; HRA__Sec_10__13A__CaptionLbl)
            {
            }
            column(Transport__Sec_10_14__Caption; Transport__Sec_10_14__CaptionLbl)
            {
            }
            column(Gratuity_exemptions_under_Sec_10__10_Caption; Gratuity_exemptions_under_Sec_10__10_CaptionLbl)
            {
            }
            column(Medical_Reimbursement_Sec_17_2__Caption; Medical_Reimbursement_Sec_17_2__CaptionLbl)
            {
            }
            column(Children_s_Education_Allowance_sec_10__14__Caption; Children_s_Education_Allowance_sec_10__14__CaptionLbl)
            {
            }
            column(Leave_Travel_Concession__L_T_C_Caption; Leave_Travel_Concession__L_T_C_CaptionLbl)
            {
            }
            column(Uniform_expenses__Sec_10_14__Caption; Uniform_expenses__Sec_10_14__CaptionLbl)
            {
            }
            column(Other_Source_of_IncomeCaption; Other_Source_of_IncomeCaptionLbl)
            {
            }
            column(Income_Loss__From_House_PropertyCaption; Income_Loss__From_House_PropertyCaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152010; Rs_Caption_Control1102152010Lbl)
            {
            }
            column(Intrest_on_House_Building_LoanCaption; Intrest_on_House_Building_LoanCaptionLbl)
            {
            }
            column(Tution_FeesCaption; Tution_FeesCaptionLbl)
            {
            }
            column(V1_Caption_Control1102152355; V1_Caption_Control1102152355Lbl)
            {
            }
            column(N_S_CCaption; N_S_CCaptionLbl)
            {
            }
            column(V2_Caption_Control1102152360; V2_Caption_Control1102152360Lbl)
            {
            }
            column(L_I_CCaption; L_I_CCaptionLbl)
            {
            }
            column(V3_Caption_Control1102152364; V3_Caption_Control1102152364Lbl)
            {
            }
            column(Section_80CCCCaption; Section_80CCCCaptionLbl)
            {
            }
            column(b_Caption_Control1102152367; b_Caption_Control1102152367Lbl)
            {
            }
            column(Section_80CCDCaption; Section_80CCDCaptionLbl)
            {
            }
            column(c_Caption_Control1102152369; c_Caption_Control1102152369Lbl)
            {
            }
            column(Other_sections__e_g__80E__80G_etc___under_Chapter_VI_ACaption; Other_sections__e_g__80E__80G_etc___under_Chapter_VI_ACaptionLbl)
            {
            }
            column(B_Caption_Control1102152376; B_Caption_Control1102152376Lbl)
            {
            }
            column(DeductibleCaption; DeductibleCaptionLbl)
            {
            }
            column(GrossCaption; GrossCaptionLbl)
            {
            }
            column(QualifyingCaption; QualifyingCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(AmountCaption_Control1102152381; AmountCaption_Control1102152381Lbl)
            {
            }
            column(AmountCaption_Control1102152382; AmountCaption_Control1102152382Lbl)
            {
            }
            column(i_Caption; i_CaptionLbl)
            {
            }
            column(Section80ECaption; Section80ECaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152385; Rs_Caption_Control1102152385Lbl)
            {
            }
            column(Rs_Caption_Control1102152386; Rs_Caption_Control1102152386Lbl)
            {
            }
            column(Rs_Caption_Control1102152387; Rs_Caption_Control1102152387Lbl)
            {
            }
            column(ii_Caption; ii_CaptionLbl)
            {
            }
            column(Section80GCaption; Section80GCaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152390; Rs_Caption_Control1102152390Lbl)
            {
            }
            column(Rs_Caption_Control1102152391; Rs_Caption_Control1102152391Lbl)
            {
            }
            column(Rs_Caption_Control1102152392; Rs_Caption_Control1102152392Lbl)
            {
            }
            column(Section80GGCaption; Section80GGCaptionLbl)
            {
            }
            column(iii_Caption; iii_CaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152395; Rs_Caption_Control1102152395Lbl)
            {
            }
            column(Rs_Caption_Control1102152396; Rs_Caption_Control1102152396Lbl)
            {
            }
            column(Rs_Caption_Control1102152397; Rs_Caption_Control1102152397Lbl)
            {
            }
            column(Section80GGACaption; Section80GGACaptionLbl)
            {
            }
            column(iv_Caption; iv_CaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152400; Rs_Caption_Control1102152400Lbl)
            {
            }
            column(Rs_Caption_Control1102152401; Rs_Caption_Control1102152401Lbl)
            {
            }
            column(Rs_Caption_Control1102152402; Rs_Caption_Control1102152402Lbl)
            {
            }
            column(Section80GGCCaption; Section80GGCCaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152404; Rs_Caption_Control1102152404Lbl)
            {
            }
            column(v_Caption; v_CaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152407; Rs_Caption_Control1102152407Lbl)
            {
            }
            column(Aggregate_of_deductible_amount_under_Chapter_VIACaption; Aggregate_of_deductible_amount_under_Chapter_VIACaptionLbl)
            {
            }
            column(V10_Caption; V10_CaptionLbl)
            {
            }
            column(Total_Income__8_10_Caption; Total_Income__8_10_CaptionLbl)
            {
            }
            column(V11_Caption; V11_CaptionLbl)
            {
            }
            column(Tax_on_total_incomeCaption; Tax_on_total_incomeCaptionLbl)
            {
            }
            column(V12_Caption; V12_CaptionLbl)
            {
            }
            column(Education_cess___3___on_tax_computed_at_S__No__12_Caption; Education_cess___3___on_tax_computed_at_S__No__12_CaptionLbl)
            {
            }
            column(V13_Caption; V13_CaptionLbl)
            {
            }
            column(Tax_Payable__12_13__Caption; Tax_Payable__12_13__CaptionLbl)
            {
            }
            column(V14_Caption; V14_CaptionLbl)
            {
            }
            column(Less__Relief_under_section_89___attach_details_Caption; Less__Relief_under_section_89___attach_details_CaptionLbl)
            {
            }
            column(V15_Caption; V15_CaptionLbl)
            {
            }
            column(Tax_payable___14_15__Caption; Tax_payable___14_15__CaptionLbl)
            {
            }
            column(V16_Caption; V16_CaptionLbl)
            {
            }
            column(Deductions_under_Chapter_VIACaption; Deductions_under_Chapter_VIACaptionLbl)
            {
            }
            column(V9_Caption; V9_CaptionLbl)
            {
            }
            column(Sections_80C__80CCC_and_80CCDCaption; Sections_80C__80CCC_and_80CCDCaptionLbl)
            {
            }
            column(A_Caption_Control1102152180; A_Caption_Control1102152180Lbl)
            {
            }
            column(a_Caption_Control1102152183; a_Caption_Control1102152183Lbl)
            {
            }
            column(Section_80CCaption; Section_80CCaptionLbl)
            {
            }
            column(Gross_AmountCaption; Gross_AmountCaptionLbl)
            {
            }
            column(DeductibleCaption_Control1102152015; DeductibleCaption_Control1102152015Lbl)
            {
            }
            column(AmountCaption_Control1102152016; AmountCaption_Control1102152016Lbl)
            {
            }
            column(VPFCaption; VPFCaptionLbl)
            {
            }
            column(V9_Caption_Control1102152120; V9_Caption_Control1102152120Lbl)
            {
            }
            column(Mutual_FundsCaption; Mutual_FundsCaptionLbl)
            {
            }
            column(V8_Caption_Control1102152122; V8_Caption_Control1102152122Lbl)
            {
            }
            column(Term___Fixed_Deposits_above_5_yearsCaption; Term___Fixed_Deposits_above_5_yearsCaptionLbl)
            {
            }
            column(V7_Caption_Control1102152497; V7_Caption_Control1102152497Lbl)
            {
            }
            column(H_B__Loan_PrincipalCaption; H_B__Loan_PrincipalCaptionLbl)
            {
            }
            column(V6_Caption_Control1102152499; V6_Caption_Control1102152499Lbl)
            {
            }
            column(V5_Caption_Control1102152500; V5_Caption_Control1102152500Lbl)
            {
            }
            column(Stamp_Duty___Registration_FeesCaption; Stamp_Duty___Registration_FeesCaptionLbl)
            {
            }
            column(V4_Caption_Control1102152502; V4_Caption_Control1102152502Lbl)
            {
            }
            column(P_P_FCaption; P_P_FCaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152504; Rs_Caption_Control1102152504Lbl)
            {
            }
            column(Rs_Caption_Control1102152505; Rs_Caption_Control1102152505Lbl)
            {
            }
            column(Rs_Caption_Control1102152508; Rs_Caption_Control1102152508Lbl)
            {
            }
            column(Rs_Caption_Control1102152509; Rs_Caption_Control1102152509Lbl)
            {
            }
            column(Rs_Caption_Control1102152510; Rs_Caption_Control1102152510Lbl)
            {
            }
            column(Rs_Caption_Control1102152511; Rs_Caption_Control1102152511Lbl)
            {
            }
            column(Rs_Caption_Control1102152512; Rs_Caption_Control1102152512Lbl)
            {
            }
            column(Rs_Caption_Control1102152513; Rs_Caption_Control1102152513Lbl)
            {
            }
            column(Rs_Caption_Control1102152514; Rs_Caption_Control1102152514Lbl)
            {
            }
            column(Rs_Caption_Control1102152520; Rs_Caption_Control1102152520Lbl)
            {
            }
            column(Rs_Caption_Control1102152521; Rs_Caption_Control1102152521Lbl)
            {
            }
            column(Rs_Caption_Control1102152522; Rs_Caption_Control1102152522Lbl)
            {
            }
            column(Rs_Caption_Control1102152523; Rs_Caption_Control1102152523Lbl)
            {
            }
            column(Rs_Caption_Control1102152524; Rs_Caption_Control1102152524Lbl)
            {
            }
            column(Rs_Caption_Control1102152525; Rs_Caption_Control1102152525Lbl)
            {
            }
            column(Rs_Caption_Control1102152526; Rs_Caption_Control1102152526Lbl)
            {
            }
            column(Rs_Caption_Control1102152527; Rs_Caption_Control1102152527Lbl)
            {
            }
            column(Rs_Caption_Control1102152528; Rs_Caption_Control1102152528Lbl)
            {
            }
            column(d_Caption_Control1102152569; d_Caption_Control1102152569Lbl)
            {
            }
            column(Section_80CCF__Infra_Structure_Bond_Caption; Section_80CCF__Infra_Structure_Bond_CaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152361; Rs_Caption_Control1102152361Lbl)
            {
            }
            column(Rs_Caption_Control1102152365; Rs_Caption_Control1102152365Lbl)
            {
            }
            column(Rs_Caption_Control1102152544; Rs_Caption_Control1102152544Lbl)
            {
            }
            column(Rs_Caption_Control1102152546; Rs_Caption_Control1102152546Lbl)
            {
            }
            column(Rs_Caption_Control1102152548; Rs_Caption_Control1102152548Lbl)
            {
            }
            column(Rs_Caption_Control1102152550; Rs_Caption_Control1102152550Lbl)
            {
            }
            column(Rs_Caption_Control1102152551; Rs_Caption_Control1102152551Lbl)
            {
            }
            column(Section80DDBCaption; Section80DDBCaptionLbl)
            {
            }
            column(ix_Caption; ix_CaptionLbl)
            {
            }
            column(Section80DCaption; Section80DCaptionLbl)
            {
            }
            column(viii_Caption; viii_CaptionLbl)
            {
            }
            column(Section80DDCaption; Section80DDCaptionLbl)
            {
            }
            column(vii_Caption; vii_CaptionLbl)
            {
            }
            column(vi_Caption; vi_CaptionLbl)
            {
            }
            column(Section80UCaption; Section80UCaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152584; Rs_Caption_Control1102152584Lbl)
            {
            }
            column(Rs_Caption_Control1102152585; Rs_Caption_Control1102152585Lbl)
            {
            }
            column(Rs_Caption_Control1102152586; Rs_Caption_Control1102152586Lbl)
            {
            }
            column(Rs_Caption_Control1102152587; Rs_Caption_Control1102152587Lbl)
            {
            }
            column(Rs_Caption_Control1102152588; Rs_Caption_Control1102152588Lbl)
            {
            }
            column(Rs_Caption_Control1102152589; Rs_Caption_Control1102152589Lbl)
            {
            }
            column(Rs_Caption_Control1102152590; Rs_Caption_Control1102152590Lbl)
            {
            }
            column(Rs_Caption_Control1102152591; Rs_Caption_Control1102152591Lbl)
            {
            }
            column(Rs_Caption_Control1102152592; Rs_Caption_Control1102152592Lbl)
            {
            }
            column(Rs_Caption_Control1102152405; Rs_Caption_Control1102152405Lbl)
            {
            }
            column(Rs_Caption_Control1102152553; Rs_Caption_Control1102152553Lbl)
            {
            }
            column(V0Caption; ROUND(TACess, 0.5, '>'))
            {
            }
            column(VerificationCaption; VerificationCaptionLbl)
            {
            }
            column(Ij_Caption; Ij_CaptionLbl)
            {
            }
            column(workinginthecapacityCaption; workinginthecapacityCaptionLbl)
            {
            }
            column(I____SonDaughter___Caption; I____SonDaughter___CaptionLbl)
            {
            }
            column(DataItem1102152222; has_been__deducted___andLbl)
            {
            }
            column(DataItem1102152223; above__is_true___completeLbl)
            {
            }
            column(and___other_available_records_Caption; and___other_available_records_CaptionLbl)
            {
            }
            column(PlaceCaption; PlaceCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(Signature_of_person_responsible_for_deduction_of_taxCaption; Signature_of_person_responsible_for_deduction_of_taxCaptionLbl)
            {
            }
            column(Full_Name_Caption; Full_Name_CaptionLbl)
            {
            }
            column(V_V_NAGENDRACaption; V_V_NAGENDRACaptionLbl)
            {
            }
            column(MANAGING_DIRECTORCaption; MANAGING_DIRECTORCaptionLbl)
            {
            }
            column(HYDERABAD_500016Caption; HYDERABAD_500016CaptionLbl)
            {
            }
            column(MANAGING_DIRECTORCaption_Control1102152612; MANAGING_DIRECTORCaption_Control1102152612Lbl)
            {
            }
            column(V_V__NAGENDRACaption; V_V__NAGENDRACaptionLbl)
            {
            }
            column(V_S_V_BHASKAR_RAOCaption; V_S_V_BHASKAR_RAOCaptionLbl)
            {
            }
            column(DataItem1102152053; do_hereby_certify_Lbl)
            {
            }
            column(Textbox_Caption; Textbox_CaptionLbl)
            {
            }
            column(Textbox1_Caption; Textbox1_CaptionLbl)
            {
            }
            column(Notes_Caption; Notes_CaptionLbl)
            {
            }
            column(V1_Caption_Control1102152238; V1_Caption_Control1102152238Lbl)
            {
            }
            column(If_an_assessee_is_employed_under_more_than_one_employer_during_the_year_each_of_the_employers_shall_issue_Part_ACaption; If_an_assessee_is_employed_ACaptionLbl)
            {
            }
            column(DataItem1102152240; of_the__certificate_in__Form_No_16CaptionLbl)
            {
            }
            column(employers__Part_B_may_be_issued_by_each_of_the_employers_or_the_last_employer_at_the_option_of_the_assessee_Caption; employers__Part_B_may_be_issued_by_each_of_the_employers_or_the_last_employer_at_the_option_of_the_assessee_CaptionLbl)
            {
            }
            column(V2_Caption_Control1102152242; V2_Caption_Control1102152242Lbl)
            {
            }
            column(DataItem1102152243; Government__deductors_CaptionLbl)
            {
            }
            column(Annexure_B_if_tax_is_paid_accompanied_by_income_tax_challan_Caption; Annexure_B_if_tax_is_paid_accompanied_by_income_tax_challan_CaptionLbl)
            {
            }
            column(V3_Caption_Control1102152245; V3_Caption_Control1102152245Lbl)
            {
            }
            column(Non_Government_deductors_to_enclose_Annexure_BCaption; Non_Government_deductors_to_enclose_Annexure_BCaptionLbl)
            {
            }
            column(V4_Caption_Control1102152247; V4_Caption_Control1102152247Lbl)
            {
            }
            column(DataItem1102152248; The__deductor__shall_furnish_CaptionLbl)
            {
            }
            column(TDS_statements_of_the_assessee_Caption; TDS_statements_of_the_assessee_CaptionLbl)
            {
            }
            column(V5_Caption_Control1102152250; V5_Caption_Control1102152250Lbl)
            {
            }
            column(This_Form_shall_be_applicable_only_in_respect_of_tax_deducted_on_or_after_1st_day_of_April_2010_Caption; This_Form_shall_be_applicable_only_in_respect_of_tax_deducted_on_or_after_1st_day_of_April_2010_CaptionLbl)
            {
            }
            column(ANNEXURE_BCaption; ANNEXURE_BCaptionLbl)
            {
            }
            column(DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_IN_THE_CENTRAL_GOVERNMENT_ACCOUNT_THROUGHCaption; DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_IN_THE_CENTRAL_GOVERNMENT_ACCOUNT_THROUGHCaptionLbl)
            {
            }
            column(CHALLANCaption; CHALLANCaptionLbl)
            {
            }
            column(The_Employer_to_provide_payment_wise_details_of_tax_deducted_and_deposited_with_respect_to_the_employee_Caption; The_Employer_to_provide_payment_wise_details_of_tax_deducted_and_deposited_with_respect_to_the_employee_CaptionLbl)
            {
            }
            column(S__No_Caption; S__No_CaptionLbl)
            {
            }
            column(Tax_Deposited_in_respect_of_the_employee__Rs__Caption; Tax_Deposited_in_respect_of_the_employee__Rs__CaptionLbl)
            {
            }
            column(Challan_identification_number__CIN_Caption; Challan_identification_number__CIN_CaptionLbl)
            {
            }
            column(BSR_Code_of_the_Bank_BranchCaption; BSR_Code_of_the_Bank_BranchCaptionLbl)
            {
            }
            column(Date_on_which_tax_deposited__dd_mm_yyyy_Caption; Date_on_which_tax_deposited__dd_mm_yyyy_CaptionLbl)
            {
            }
            column(Challan_identification_number__CIN_Caption_Control1102152325; Challan_identification_number__CIN_Caption_Control1102152325Lbl)
            {
            }
            column(Note_Caption; Note_CaptionLbl)
            {
            }
            column(V1_Caption_Control1102152348; V1_Caption_Control1102152348Lbl)
            {
            }
            column(In_the_column_for_TDS__give_total_amount_for_TDS__Surcharge__if_applicable__and_education_cess_Caption; In_the_column_for_TDS__give_total_amount_for_TDS__Surcharge__if_applicable__and_education_cess_CaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(V3Caption; V3CaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(V7Caption; V7CaptionLbl)
            {
            }
            column(V9Caption; V9CaptionLbl)
            {
            }
            column(V11Caption; V11CaptionLbl)
            {
            }
            column(TotalCaption_Control1102152036; TotalCaption_Control1102152036Lbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(V6Caption; V6CaptionLbl)
            {
            }
            column(V8Caption; V8CaptionLbl)
            {
            }
            column(V10Caption; V10CaptionLbl)
            {
            }
            column(V12Caption; V12CaptionLbl)
            {
            }
            column(ANNEXURE_BCaption_Control1102152077; ANNEXURE_BCaption_Control1102152077Lbl)
            {
            }
            column(DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_IN_THE_CENTRAL_GOVERNMENT_ACCOUNT_THROUGHCaption_Control1102152081; DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_IN_THE_CENTRAL_GOVERNMENT_ACCOUNT_THROUGHCaption_Control1102152081Lbl)
            {
            }
            column(CHALLANCaption_Control1102152082; CHALLANCaption_Control1102152082Lbl)
            {
            }
            column(DataItem1102152083; The_Employer_to_provide_payment_wise_Control110215Lbl)
            {
            }
            column(S__No_Caption_Control1102152086; S__No_Caption_Control1102152086Lbl)
            {
            }
            column(Tax_Deposited_in_respect_of_the_employee__Rs__Caption_Control1102152087; Tax_Deposited_in_respect_of_the_employee__Rs__Caption_Control1102152087Lbl)
            {
            }
            column(Challan_identification_number__CIN_Caption_Control1102152088; Challan_identification_number__CIN_Caption_Control1102152088Lbl)
            {
            }
            column(BSR_Code_of_the_Bank_BranchCaption_Control1102152089; BSR_Code_of_the_Bank_BranchCaption_Control1102152089Lbl)
            {
            }
            column(Date_on_which_tax_deposited__dd_mm_yyyy_Caption_Control1102152091; Date_on_which_tax_deposited__dd_mm_yyyy_Caption_Control1102152091Lbl)
            {
            }
            column(Challan_identification_number__CIN_Caption_Control1102152092; Challan_identification_number__CIN_Caption_Control1102152092Lbl)
            {
            }
            column(Note_Caption_Control1102152112; Note_Caption_Control1102152112Lbl)
            {
            }
            column(V1_Caption_Control1102152113; V1_Caption_Control1102152113Lbl)
            {
            }
            column(In_the_column_for_TDS__give_total_amount_for_TDS__Surcharge__if_applicable__and_education_cess_Caption_Control1102152156; In_the_column_for_TDS__give_total_Control1102152156Lbl)
            {
            }
            column(V3Caption_Control1102152158; V3Caption_Control1102152158Lbl)
            {
            }
            column(V5Caption_Control1102152159; V5Caption_Control1102152159Lbl)
            {
            }
            column(V7Caption_Control1102152160; V7Caption_Control1102152160Lbl)
            {
            }
            column(V9Caption_Control1102152161; V9Caption_Control1102152161Lbl)
            {
            }
            column(V11Caption_Control1102152162; V11Caption_Control1102152162Lbl)
            {
            }
            column(TotalCaption_Control1102152163; TotalCaption_Control1102152163Lbl)
            {
            }
            column(V4Caption_Control1102152165; V4Caption_Control1102152165Lbl)
            {
            }
            column(V6Caption_Control1102152168; V6Caption_Control1102152168Lbl)
            {
            }
            column(V8Caption_Control1102152186; V8Caption_Control1102152186Lbl)
            {
            }
            column(V10Caption_Control1102152189; V10Caption_Control1102152189Lbl)
            {
            }
            column(V12Caption_Control1102152193; V12Caption_Control1102152193Lbl)
            {
            }
            column(V6390340Caption; V6390340CaptionLbl)
            {
            }
            column(V6390340Caption_Control1102152164; V6390340Caption_Control1102152164Lbl)
            {
            }
            column(V6390340Caption_Control1102152209; V6390340Caption_Control1102152209Lbl)
            {
            }
            column(V6390340Caption_Control1102152210; V6390340Caption_Control1102152210Lbl)
            {
            }
            column(V6390340Caption_Control1102152211; V6390340Caption_Control1102152211Lbl)
            {
            }
            column(V6390340Caption_Control1102152213; V6390340Caption_Control1102152213Lbl)
            {
            }
            column(V6390340Caption_Control1102152214; V6390340Caption_Control1102152214Lbl)
            {
            }
            column(V6390340Caption_Control1102152215; V6390340Caption_Control1102152215Lbl)
            {
            }
            column(V6390340Caption_Control1102152258; V6390340Caption_Control1102152258Lbl)
            {
            }
            column(V6390340Caption_Control1102152259; V6390340Caption_Control1102152259Lbl)
            {
            }
            column(V6390340Caption_Control1102152321; V6390340Caption_Control1102152321Lbl)
            {
            }
            column(V6390340Caption_Control1102152322; V6390340Caption_Control1102152322Lbl)
            {
            }
            column(V1Caption_Control1102152207; V1Caption_Control1102152207Lbl)
            {
            }
            column(V2Caption_Control1102152208; V2Caption_Control1102152208Lbl)
            {
            }
            column(V17_Caption; V17_CaptionLbl)
            {
            }
            column(ReliefUnder_Caption; ReliefUnder_CaptionLbl)
            {
            }
            column(V18_Caption; V18_CaptionLbl)
            {
            }
            column(TaxPay_Caption; TaxPay_CaptionLbl)
            {
            }
            column(V19_Caption; V19_CaptionLbl)
            {
            }
            column(Less_Caption; Less_CaptionLbl)
            {
            }
            column(V20_Caption; V20_CaptionLbl)
            {
            }
            column(TaxPayble_Caption; TaxPayble_CaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
            column(TotalCaption_Control1102152455; TotalCaption_Control1102152455Lbl)
            {
            }
            column(MMYYY_Caption; MMYYY_CaptionLbl)
            {
            }
            column(ANNEXURE_BIntCaption; ANNEXURE_BCaptionLbl)
            {
            }
            column(Challan_Identification_Number__CIN_Caption_Control1102152448; Challan_Identification_Number__CIN_Caption_Control1102152448Lbl)
            {
            }
            column(Date_on_which_tax_deposited__dd_mm_yyyy_Caption_Control1102152449; Date_on_which_tax_deposited__dd_mm_yyyy_Caption_Control1102152449Lbl)
            {
            }
            column(Challan_Identification_Number__CIN_Caption_Control1102152451; Challan_Identification_Number__CIN_Caption_Control1102152451Lbl)
            {
            }
            column(BSR_Code_of_the_Bank_BranchCaption_Control1102152452; BSR_Code_of_the_Bank_BranchCaption_Control1102152452Lbl)
            {
            }
            column(Tax_Deposited_in_respect_of_the_employee__Rs__Caption_Control1102152453; Tax_Deposited_in_respect_of_the_employee__Rs__Caption_Control1102152453Lbl)
            {
            }
            column(DataItem1102152458; The_Employer_to_provide_payment_wise_Control110000Lbl)
            {
            }
            column(CHALLANCaption_Control1102152459; CHALLANCaption_Control1102152459Lbl)
            {
            }
            column(DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_IN_THE_CENTRAL_GOVERNMENT_ACCOUNT_THROUGHCaption_Control1102152460; DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_IN_THE_CENTRAL_GOVERNMENT_ACCOUNT_THROUGHCaption_Control1102152460Lbl)
            {
            }
            column(GrossTotalIncomecha; GrossTotalIncomecha)
            {
            }
            column(Text001; Text001Txt)
            {
            }
            column(Text000; Text000Txt)
            {
            }
            column(NoteAgg_Caption; NoteAgg_CaptionLbl)
            {
            }
            column(AggAmount_Caption; AggAmount_CaptionLbl)
            {
            }
            column(Companyinform_PANNo; Companyinform."P.A.N. No. B2B")
            {
            }
            column(Companyinform_TANNo; Companyinform."T.A.N. No. B2B")
            {
            }
            column(MDName; MDName)
            {
            }
            column(MDFatherName; MDFatherName)
            {
            }
            column(MDDesignation; MDDesignation)
            {
            }
            column(Zero_Caption; Zero_CaptionLbl)
            {
            }
            column(TDSDeductions_RebateUS87A; TDSDeductions."Rebate U/S 87 A")
            {
            }
            column(TDSDeductions_TotalTaxLiability; TDSDeductions."Total Tax Liability")
            {
            }
            column(TaxPayableOrRefundableTxt; TaxPayableOrRefundableTxt)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if "Employee B2B"."PAN No" = '' then
                    ERROR(Text004Txt, "Employee B2B"."No.");

                CLEAR(StYear);
                CLEAR(EndYear);
                CLEAR(TotalTDS);
                StartDate := PayrollYearStDateGVar;
                EndDate := PayrollYearEndDateGVar;
                //Message('%1 -- %2', StartDate, EndDate);
                StYear := (DATE2DMY(StartDate, 3)) + 1;
                EndYear := (DATE2DMY(EndDate, 3)) + 1;

                ProcessedSalary.SETRANGE("Employee Code", "Employee B2B"."No.");
                ProcessedSalary.SETRANGE("Add/Deduct Code", Text005Txt);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        CLEAR(VerifyDate);
                        VerifyDate := DMY2DATE(1, ProcessedSalary."Pay Slip Month", ProcessedSalary.Year);
                        if (VerifyDate >= StartDate) and (VerifyDate <= EndDate) then begin
                            Month := ProcessedSalary."Pay Slip Month";
                            case Month of
                                1:

                                    QuarterlyAmounts[4] += ProcessedSalary."Earned Amount";

                                2:

                                    QuarterlyAmounts[4] += ProcessedSalary."Earned Amount";

                                3:

                                    QuarterlyAmounts[4] += ProcessedSalary."Earned Amount";

                                4:

                                    QuarterlyAmounts[1] += ProcessedSalary."Earned Amount";

                                5:

                                    QuarterlyAmounts[1] += ProcessedSalary."Earned Amount";

                                6:

                                    QuarterlyAmounts[1] += ProcessedSalary."Earned Amount";

                                7:

                                    QuarterlyAmounts[2] += ProcessedSalary."Earned Amount";

                                8:

                                    QuarterlyAmounts[2] += ProcessedSalary."Earned Amount";

                                9:

                                    QuarterlyAmounts[2] += ProcessedSalary."Earned Amount";

                                10:

                                    QuarterlyAmounts[3] += ProcessedSalary."Earned Amount";

                                11:

                                    QuarterlyAmounts[3] += ProcessedSalary."Earned Amount";

                                12:

                                    QuarterlyAmounts[3] += ProcessedSalary."Earned Amount";

                            end;
                            QuarterlyAmounts[5] += ProcessedSalary."Earned Amount";
                        end;
                    until ProcessedSalary.NEXT() = 0;

                TDSDate := PayrollYearStDateGVar;
                repeat
                    TDSSalaryDetails.RESET();
                    TDSSalaryDetails.SETRANGE("Employee Code", "No.");
                    TDSSalaryDetails.SETRANGE(Month, DATE2DMY(TDSDate, 2));
                    TDSSalaryDetails.SETRANGE(Year, DATE2DMY(TDSDate, 3));
                    if TDSSalaryDetails.FINDFIRST() then
                        repeat
                            Month := TDSSalaryDetails.Month;
                            case Month of
                                1:

                                    QuarterlyAmounts[4] += TDSSalaryDetails."TDS Amount";

                                2:

                                    QuarterlyAmounts[4] += TDSSalaryDetails."TDS Amount";

                                3:

                                    QuarterlyAmounts[4] += TDSSalaryDetails."TDS Amount";

                                4:

                                    QuarterlyAmounts[1] += TDSSalaryDetails."TDS Amount";

                                5:

                                    QuarterlyAmounts[1] += TDSSalaryDetails."TDS Amount";

                                6:

                                    QuarterlyAmounts[1] += TDSSalaryDetails."TDS Amount";

                                7:

                                    QuarterlyAmounts[2] += TDSSalaryDetails."TDS Amount";

                                8:

                                    QuarterlyAmounts[2] += TDSSalaryDetails."TDS Amount";

                                9:

                                    QuarterlyAmounts[2] += TDSSalaryDetails."TDS Amount";

                                10:

                                    QuarterlyAmounts[3] += TDSSalaryDetails."TDS Amount";

                                11:

                                    QuarterlyAmounts[3] += TDSSalaryDetails."TDS Amount";

                                12:

                                    QuarterlyAmounts[3] += TDSSalaryDetails."TDS Amount";

                            end;
                            QuarterlyAmounts[5] += TDSSalaryDetails."TDS Amount";
                        until TDSSalaryDetails.NEXT() = 0;
                    TDSDate := CALCDATE(Text006Txt, TDSDate);
                until TDSDate > PayrollYearEndDateGVar;

                CLEAR(TotalTDSNew);

                CountArr := 1;
                i := 1;

                TDSDate := PayrollYearStDateGVar;
                repeat
                    TDSSalaryDetails.RESET();
                    TDSSalaryDetails.SETRANGE("Employee Code", "Employee B2B"."No.");
                    TDSSalaryDetails.SETRANGE(Month, DATE2DMY(TDSDate, 2));
                    TDSSalaryDetails.SETRANGE(Year, DATE2DMY(TDSDate, 3));
                    if TDSSalaryDetails.FINDFIRST() then
                        repeat
                            MonthlyTDS[i] += TDSSalaryDetails."TDS Amount";
                            MonthYear[i] := FORMAT(TDSSalaryDetails.Month) + '-' + FORMAT(TDSSalaryDetails.Year);
                            BSRCode[i] := TDSSalaryDetails."BSR Code";
                            TDAPaidDate[i] := TDSSalaryDetails."Challan Date";
                            TDSChallanNo[i] := TDSSalaryDetails."Challan No.";
                            TotalTDSNew += TDSSalaryDetails."TDS Amount";
                        until TDSSalaryDetails.NEXT() = 0;
                    i += 1;
                    TDSDate := CALCDATE(Text006Txt, TDSDate);
                until TDSDate > PayrollYearEndDateGVar;

                TDSDeductions.RESET();
                TDSDeductions.SETRANGE("Emp ID", "Employee B2B"."No.");
                TDSDeductions.SETRANGE("Financial Year Start Date", PayrollYearStDateGVar);
                TDSDeductions.SETRANGE("Financial Year End Date", PayrollYearEndDateGVar);
                if TDSDeductions.FINDFIRST() then
                    TDSDeductions.CALCFIELDS("Gross Salary");


                TDSSavings.RESET();
                TDSSavings.SETRANGE("Emp ID", "Employee B2B"."No.");
                TDSSavings.SETRANGE("Financial Year Start Date", PayrollYearStDateGVar);
                if TDSSavings.FINDFIRST() then
                    repeat
                        ExcempGroups.GET(TDSSavings."Exemption Group Id");
                        ExcempSections.GET(ExcempGroups."Section ID");
                        if ExcempSections."Chapter ID" = Text007Txt then
                            "ExeUnder10&17Produced" += TDSSavings.Limit;
                    until TDSSavings.NEXT() = 0;


                CLEAR(CheckRep);
                CLEAR(NoText);
                CheckRep.InitTextVariable();
                CheckRep.FormatNoText(NoText, ABS(TotalTDSNew), '');

                if TDSAck.FINDFIRST() then
                    repeat
                        if TDSAck.Quarter = TDSAck.Quarter::Q1 then
                            Q[1] := TDSAck."TDS Acknowledgement No.";
                        if TDSAck.Quarter = TDSAck.Quarter::Q2 then
                            Q[2] := TDSAck."TDS Acknowledgement No.";
                        if TDSAck.Quarter = TDSAck.Quarter::Q3 then
                            Q[3] := TDSAck."TDS Acknowledgement No.";
                        if TDSAck.Quarter = TDSAck.Quarter::Q4 then
                            Q[4] := TDSAck."TDS Acknowledgement No.";
                    until TDSAck.NEXT() = 0;


                TDSSavingsGRec.RESET();
                TDSSavingsGRec.SETRANGE("Emp ID", EmpNoGVar);
                TDSSavingsGRec.SETRANGE("Financial Year Start Date", StartDate);
                TDSSavingsGRec.SETRANGE("Financial Year End Date", EndDate);
                if TDSSavingsGRec.FINDFIRST() then
                    CLEAR(Allowance[1]);
                CLEAR(Allowance[2]);
                CLEAR(Allowance[4]);
                CLEAR(Allowance[5]);
                CLEAR(HBLInt);
                CLEAR(HousePrpty);
                repeat
                    if TDSSavingsGRec."Exemption Group Id" = Text008Txt then
                        Allowance[1] := TDSSavingsGRec.Limit;
                    if TDSSavingsGRec."Exemption Group Id" = Text009Txt then
                        Allowance[2] := TDSSavingsGRec.Limit;
                    if TDSSavingsGRec."Exemption Group Id" = Text0010Txt then
                        Allowance[3] := TDSSavingsGRec.Limit;
                    if TDSSavingsGRec."Exemption Group Id" = Text0011Txt then
                        Allowance[4] := TDSSavingsGRec.Limit;
                    if TDSSavingsGRec."Exemption Group Id" = Text0012Txt then
                        Allowance[5] := TDSSavingsGRec.Limit;
                    if TDSSavingsGRec."Exemption Group Id" = Text0013Txt then
                        Allowance[6] := TDSSavingsGRec.Limit;
                    if TDSSavingsGRec."Exemption Group Id" = Text0014Txt then
                        HBLInt := TDSSavingsGRec.Limit;
                    if (TDSSavingsGRec."Exemption Group Id" = Text0015Txt) then begin
                        HousePrpty := TDSSavingsGRec.Limit;
                        if HousePrpty < 0 then
                            HousePrptyTxt := '(' + FORMAT(HousePrpty, 0, Text0016Txt) + ')'
                        else
                            HousePrptyTxt := FORMAT(HousePrpty, 0, Text0016Txt);
                    end;
                until TDSSavingsGRec.NEXT() = 0;

                TDSSavingsGRec.RESET();
                TDSSavingsGRec.SETRANGE("Emp ID", EmpNoGVar);
                TDSSavingsGRec.SETRANGE("Financial Year Start Date", StartDate);
                TDSSavingsGRec.SETRANGE("Financial Year End Date", EndDate);
                if TDSSavingsGRec.FINDFIRST() then
                    CLEAR(SectionAmt);
                CLEAR(CCFAmt);
                CLEAR(TotalSecAmt);
                CLEAR(Sec80Amt);
                CLEAR(TotSec80Amt);
                repeat
                    ExcempGroups.RESET();
                    ExcempGroups.SETRANGE("Exemp / Ded Group Id", TDSSavingsGRec."Exemption Group Id");
                    if ExcempGroups.FINDFIRST() then
                        repeat
                            if ExcempGroups."Section ID" = Text0017Txt then
                                CCFAmt := TDSSavingsGRec.Limit;
                            if ExcempGroups."Section ID" = Text0018Txt then
                                Sec80Amt[8] += TDSSavingsGRec.Limit;
                            if ExcempGroups."Section ID" = Text0019Txt then
                                Sec80Amt[1] += TDSSavingsGRec.Limit;
                            if ExcempGroups."Section ID" = Text0020Txt then
                                Sec80Amt[6] += TDSSavingsGRec.Limit;
                            if ExcempGroups."Section ID" = Text0021Txt then
                                Sec80Amt[7] += TDSSavingsGRec.Limit;
                            if ExcempGroups."Section ID" = Text0022Txt then
                                Sec80Amt[9] += TDSSavingsGRec.Limit;
                        until ExcempGroups.NEXT() = 0;

                    if TDSSavingsGRec."Exemption Group Id" = Text0023Txt then
                        SectionAmt[5] := TDSSavingsGRec.Limit;

                    if TDSSavingsGRec."Exemption Group Id" = Text0024Txt then
                        SectionAmt[6] := TDSSavingsGRec.Limit;

                    if TDSSavingsGRec."Exemption Group Id" = Text0025Txt then
                        SectionAmt[7] := TDSSavingsGRec.Limit;

                    if TDSSavingsGRec."Exemption Group Id" = Text0026Txt then
                        SectionAmt[8] := TDSSavingsGRec.Limit;

                    if TDSSavingsGRec."Exemption Group Id" = Text0027Txt then
                        SectionAmt[10] := TDSSavingsGRec.Limit;

                    if TDSSavingsGRec."Exemption Group Id" = Text0028Txt then
                        SectionAmt[13] := TDSSavingsGRec.Limit;

                    if (TDSSavingsGRec."Exemption Group Id" = Text0029Txt) or (TDSSavingsGRec."Exemption Group Id" = 'NPS') then
                        SectionAmt[15] := TDSSavingsGRec.Limit;

                until TDSSavingsGRec.NEXT() = 0;
                TotalSecAmt := SectionAmt[1] + SectionAmt[2] + SectionAmt[3] + SectionAmt[4] + SectionAmt[5] + SectionAmt[6] +
                              SectionAmt[7] + SectionAmt[8] + SectionAmt[9] + SectionAmt[10] + SectionAmt[11] + SectionAmt[12] +
                              SectionAmt[13] + SectionAmt[14] + SectionAmt[15];
                if TotalSecAmt > 150000 then
                    TotalSecAmt := 150000 + SectionAmt[15];
                ;
                if CCFAmt > 20000 then
                    CCFAmt := 20000;
                TotalSecAmt := TotalSecAmt + CCFAmt;
                TotSec80Amt := Sec80Amt[1] + Sec80Amt[2] + Sec80Amt[3] + Sec80Amt[4] + Sec80Amt[5] +
                              Sec80Amt[6] + Sec80Amt[7] + Sec80Amt[8] + Sec80Amt[9];

                CLEAR(GrossAmt);
                GrossAmt := (((TDSDeductions."Gross Salary" + TDSDeductions."Value of prequisites" +
                TDSDeductions."Profit Lieu of Salary" + TDSDeductions.Perks) -
                TDSDeductions."Exem Under 10 and 17") - (TDSDeductions."Entertainment Allowance" + TDSDeductions."PT Amount" + HBLInt)) - HousePrpty;

                CLEAR(TD);
                CLEAR(TA);
                CLEAR(TASurcharge);
                CLEAR(TACess);
                TD := GrossAmt - (TotSec80Amt + TotalSecAmt);
                ITSlabLine.RESET();
                ITSlabLine.SETRANGE(SlabType, "Employee B2B"."IT Slab Type");
                ITSlabLine.SETRANGE("Financial Year Start Date", StartDate);
                if ITSlabLine.FINDFIRST() then
                    repeat
                        if TD > ITSlabLine."Total Income" then begin
                            TD := TD - ITSlabLine."Total Income";
                            TA := TA + (ITSlabLine."Total Income" * ITSlabLine."Tax Rate %" / 100);
                        end else begin
                            TA := TA + (TD * ITSlabLine."Tax Rate %" / 100);
                            ExitFlag := true;
                        end;
                    until ((ITSlabLine.NEXT() = 0) or (ExitFlag = true));

                HRSetup.GET();
                if TA <> 0 then begin
                    TASurcharge := (TA * HRSetup.Surcharge) / 100;
                    TACess := (TA * HRSetup."Educational Cess") / 100;
                    TACess := ((TA - TDSDeductions."Rebate U/S 87 A") * HRSetup."Educational Cess") / 100;
                    TACess := ROUND(TACess, 1, '=');
                end;



                TaxPayableOrRefundable := TDSDeductions."Total Tax Liability" - TotalTDSNew;

                if TaxPayableOrRefundable < 0 then
                    TaxPayableOrRefundableTxt := '(' + FORMAT(TaxPayableOrRefundable, 0, Text0016Txt) + ')'
                else
                    TaxPayableOrRefundableTxt := FORMAT(TaxPayableOrRefundable, 0, Text0016Txt);


                CLEAR(GrossTotalIncomecha);
                GrossTotalIncomecha :=
                  ((TDSDeductions."Gross Salary" + TDSDeductions."Value of prequisites" + TDSDeductions."Profit Lieu of Salary"
                  + TDSDeductions.Perks) - TDSDeductions."Exem Under 10 and 17") - (TDSDeductions."Entertainment Allowance"
                  + TDSDeductions."PT Amount") - (HousePrpty + HBLInt + Allowance[3]);
            end;

            trigger OnPreDataItem();
            begin
                Companyinform.GET();

                if EmpNoGVar <> '' then
                    "Employee B2B".SETRANGE("No.", EmpNoGVar);


            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);
            column(MonthYear_Number; MonthYear[Number])
            {
            }
            column(MonthlyTDS_Integer_Number_; MonthlyTDS[Integer.Number])
            {
            }
            column(TDAPaidDate_Number_; TDAPaidDate[Number])
            {
            }
            column(TDSChallanNo_Number_; TDSChallanNo[Number])
            {
            }
            column(BSRCodeIntegerNumber; BSRCode[Integer.Number])
            {
            }
            column(Integer_Number; Number)
            {
            }
            column(TotalTDSNew_Control1102152466; TotalTDSNew)
            {
            }
            column(S__No_Caption_Control1102152454; S__No_Caption_Control1102152454Lbl)
            {
            }
            column(ANNEXURE_BCaption_Control1102152461; ANNEXURE_BCaption_Control1102152461Lbl)
            {
            }
            column(V6390340Caption_Control1102152506; V6390340Caption_Control1102152506Lbl)
            {
            }

            trigger OnPreDataItem();
            begin
                SETRANGE(Number, 1, i - 1);
                if Number = i then
                    CurrReport.SKIP();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(EmpNoGVar1; EmpNoGVar)
                {
                    Caption = 'Employee No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Employee name';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Employee.RESET();
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            EmpNoGVar := Employee."No.";
                            NameGVar := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee.Initials;
                            FatherNameGVar := Employee."Father/Husband";
                            LookupRec.RESET();
                            LookupRec.SETRANGE("Lookup Type", 5);
                            LookupRec.SETRANGE("Lookup Name", Employee.Designation);
                            if LookupRec.FINDSET() then
                                Designation1GVar := LookupRec.Description;

                            StartDate := PayrollYearStDateGVar;
                            EndDate := PayrollYearEndDateGVar;
                        end;
                    end;

                    trigger OnValidate();
                    begin
                        if Employee.GET(EmpNoGVar) then begin
                            NameGVar := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee.Initials;
                            FatherNameGVar := Employee.County;
                            LookupRec.RESET();
                            LookupRec.SETRANGE("Lookup Type", 5);
                            LookupRec.SETRANGE("Lookup Name", Employee.Designation);
                            if LookupRec.FINDSET() then
                                Designation1GVar := LookupRec.Description;
                            StartDate := PayrollYearStDateGVar;
                            EndDate := PayrollYearEndDateGVar;
                        end;
                    end;
                }
                field(PayrollYearType; PayrollYearTypeGVar)
                {
                    Caption = 'Financial Year';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The financial year';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        PayrollYear.RESET();
                        PayrollYear.SETRANGE("Year Type", Text0030Txt);
                        if PAGE.RUNMODAL(0, PayrollYear) = ACTION::LookupOK then begin

                            PayrollYearTypeGVar := PayrollYear."Year Type";
                            PayrollYearStDateGVar := PayrollYear."Year Start Date";
                            PayrollYearEndDateGVar := PayrollYear."Year End Date";
                            FinancialYear := PayrollYear."Year Type";
                            StartDate := PayrollYear."Year Start Date";
                            EndDate := PayrollYear."Year End Date";

                        end;
                    end;
                }
                field(PayrollYearStDate; PayrollYearStDateGVar)
                {
                    Caption = 'Start Date';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The start date';
                }
                field(PayrollYearEndDate; PayrollYearEndDateGVar)
                {
                    Caption = 'End Date';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The end date';
                }
                field(Name; NameGVar)
                {
                    Caption = 'Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The name';
                }
                field(FatherName; FatherNameGVar)
                {
                    Caption = 'Father Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The father name';
                }
                field(Designation1; Designation1GVar)
                {
                    Caption = 'Designation';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The designation';
                }
                field(DOI; DOIGVar)
                {
                    Caption = 'Date of Issue';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Date of issue';
                }
                field(Place; PlaceGVar)
                {
                    Caption = 'Place';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Place';
                }
                field("MD No :"; MDEmpno)
                {
                    Caption = 'MD No :';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The MD No';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Employee.RESET();
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            MDEmpno := Employee."No.";
                            MDName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee.Initials;
                            MDFatherName := Employee."Father/Husband";
                        end;
                    end;

                    trigger OnValidate();
                    begin
                        if Employee.GET(MDEmpno) then begin
                            MDName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee.Initials;
                            MDFatherName := Employee."Father/Husband";
                        end;
                    end;
                }
                field("MD Name"; MDName)
                {
                    Caption = 'Authorised Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The MD Name';
                }
                field("MD FatherName"; MDFatherName)
                {
                    Caption = 'Authorised Father Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Authorised father name';
                }
                field("MD Designation :"; MDDesignation)
                {
                    Caption = 'MD Designation :';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The MD designation';
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
        if EmpNoGVar = '' then
            ERROR(Text003Txt);
    end;

    var
        Companyinform: Record "Company Information";
        TDSSavingsGRec: Record "TDS Savings B2B";
        PayrollYear: Record "Payroll Year B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        Employee: Record "Employee B2B";
        TDSDeductions: Record "TDS Deductions B2B";
        TDSSavings: Record "TDS Savings B2B";
        HRSetup: Record "HR Setup B2B";
        ExcempGroups: Record "Exep/Ded Groups B2B";
        LookupRec: Record Lookup_B2B;
        ExcempSections: Record "Excemption Sections B2B";
        TDSSalaryDetails: Record "TDS Salary Details B2B";
        ITSlabLine: Record "IT Slab Line B2B";
        TDSAck: Record "TDS Acknowledgment B2B";
        CheckRep: Report "Check Report B2B";
        FinancialYear: Code[50];
        PayrollYearTypeGVar: Code[50];
        FatherNameGVar: Text[50];
        TotalTDS: Decimal;
        PlaceGVar: Text[50];
        DOIGVar: Date;
        NameGVar: Text;
        StartDate: Date;
        EndDate: Date;
        MonthlyTDS: array[24] of Decimal;
        Month: Integer;
        VerifyDate: Date;
        QuarterlyAmounts: array[6] of Decimal;
        Designation1GVar: Text[250];
        MDName: Text;
        MDFatherName: Text[70];
        MDEmpno: Code[20];
        MDDesignation: Text[70];
        PayrollYearStDateGVar: Date;
        PayrollYearEndDateGVar: Date;
        NoText: array[2] of Text[80];
        EmpNoGVar: Code[20];
        "ExeUnder10&17Produced": Decimal;
        TDAPaidDate: array[24] of Date;
        TDSChallanNo: array[24] of Code[20];
        i: Integer;
        TotalTDSNew: Decimal;
        CountArr: Integer;
        StYear: Integer;
        EndYear: Integer;
        Q: array[4] of Code[20];
        Allowance: array[7] of Decimal;
        HBLInt: Decimal;
        HousePrpty: Decimal;
        SectionAmt: array[15] of Decimal;
        CCFAmt: Decimal;
        TotalSecAmt: Decimal;
        Sec80Amt: array[9] of Decimal;
        TotSec80Amt: Decimal;
        GrossAmt: Decimal;
        TD: Decimal;
        TA: Decimal;
        TASurcharge: Decimal;
        TACess: Decimal;
        ExitFlag: Boolean;
        Text000Txt: Label 'In the column for TDS, give total amount for TDS, Surcharge (if applicable) and education cess.';
        Text001Txt: Label 'Note:';
        TDSDate: Date;
        Salary_as_per_provisions_contained_in_Sec_17_1_CaptionLbl: Label '"Salary as per provisions contained in Sec.17(1)"';
        Gross_SalaryCaptionLbl: Label 'Gross Salary';
        PART_B__Refer_Note_1_CaptionLbl: Label 'PART B (Refer Note 1)';
        Details_of_Salary_paid_and_any_other_income_and_tax_deductedCaptionLbl: Label 'Details of Salary paid and any other income and tax deducted';
        V1_CaptionLbl: Label '" 1."';
        a_CaptionLbl: Label '(a)';
        b_CaptionLbl: Label '(b)';
        c_CaptionLbl: Label '(c)';
        d_CaptionLbl: Label '(d)';
        Value_of_prequisites_u_s_17_2__as_per_Form_No_12BA__whereverCaptionLbl: Label '"    Value of prequisites u/s 17(2)(as per Form No.12BA, wherever"';
        Profits_in_lieu_of_salary_under_section_17_3___as_per_Form_No__12BB_CaptionLbl: Label '"    Profits in lieu of salary under section 17(3) (as per Form No. 12BB,"';
        TotalCaptionLbl: Label '"    Total"';
        applicable_CaptionLbl: Label '"    applicable)"';
        wherever_applicable_CaptionLbl: Label '"    wherever applicable)"';
        Less__Allowance_to_the_extent_exempt_u_s_10CaptionLbl: Label 'Less: Allowance to the extent exempt u/s 10';
        V2_CaptionLbl: Label '" 2."';
        AllowanceCaptionLbl: Label 'Allowance';
        Rs_CaptionLbl: Label '"Rs. "';
        Balance__1_2_CaptionLbl: Label 'Balance (1-2)';
        V3_CaptionLbl: Label '" 3."';
        Deductions__CaptionLbl: Label 'Deductions :';
        V4_CaptionLbl: Label '" 4."';
        Tax_on_employmentCaptionLbl: Label '"    Tax on employment"';
        a_Caption_Control1102152150Lbl: Label '(a)';
        Aggregate_of_4_a_CaptionLbl: Label 'Aggregate of 4(a)';
        V5_CaptionLbl: Label '" 5."';
        Income_chargeable_under_the_head__salaries___3_5_CaptionLbl: Label 'Income chargeable under the head ''salaries'' (3-5)';
        V6_CaptionLbl: Label '" 6."';
        Rs_Caption_Control1102152169Lbl: Label 'Rs.';
        IncomeCaptionLbl: Label 'Income';
        Add__Any_other_income_reported_by_the_employeeCaptionLbl: Label 'Add: Any other income reported by the employee';
        V7_CaptionLbl: Label '" 7."';
        Gross_total_income__6_7_CaptionLbl: Label 'Gross total income (6+7)';
        V8_CaptionLbl: Label '" 8."';
        Rs_Caption_Control1102152002Lbl: Label 'Rs.';
        Rs_Caption_Control1102152003Lbl: Label 'Rs.';
        Rs_Caption_Control1102152004Lbl: Label 'Rs.';
        Rs_Caption_Control1102152005Lbl: Label 'Rs.';
        Rs_Caption_Control1102152007Lbl: Label 'Rs.';
        Rs_Caption_Control1102152009Lbl: Label 'Rs.';
        Rs_Caption_Control1102152011Lbl: Label 'Rs.';
        Rs_Caption_Control1102152012Lbl: Label 'Rs.';
        Rs_Caption_Control1102152013Lbl: Label 'Rs.';
        Rs_Caption_Control1102152017Lbl: Label 'Rs.';
        Form_16CaptionLbl: Label 'Form 16';
        See_rule_31_1__a__CaptionLbl: Label '[See rule 31(1)(a)]';
        PART_ACaptionLbl: Label 'PART A';
        Name_and_address_of_the_EmployerCaptionLbl: Label 'Name and address of the Employer';
        Certificate_under_section_203_of_the_Income_tax_Act__1961_for_tax_deducted_at_source_on_SalaryCaptionLbl: Label 'Certificate under section 203 of the Income-tax Act, 1961 for tax deducted at source on Salary';
        Name_and_Designation_of_the_EmployeeCaptionLbl: Label 'Name and Designation of the Employee';
        PAN_of_the_DeductorCaptionLbl: Label 'PAN of the Deductor';
        TAN_of_the_DeductorCaptionLbl: Label 'TAN of the Deductor';
        PAN_of_the_EmployeeCaptionLbl: Label 'PAN of the Employee';
        CIT__TDS_CaptionLbl: Label 'CIT (TDS)';
        The_Commissioner_of_Income_Tax__TDS_CaptionLbl: Label 'The Commissioner of Income Tax (TDS)';
        Room_No__411_Income_Tax_Towers_CaptionLbl: Label 'Room No. 411 Income Tax Towers,';
        A_C__Guard_HyderabadCaptionLbl: Label 'A.C. Guards, Hyderabad';
        Pin_Code_500004CaptionLbl: Label 'Pin - 500004';
        Assessment_YearCaptionLbl: Label 'Assessment Year';
        PeriodCaptionLbl: Label 'Period';
        FromCaptionLbl: Label 'From';
        ToCaptionLbl: Label 'To';
        Summary_of_tax_deducted_at_sourceCaptionLbl: Label 'Summary of tax deducted at source';
        QuarterCaptionLbl: Label 'Quarter';
        Receipt_Numbers_of_original_statements_of_TDS_under_sub_section__3__of_section_200CaptionLbl: Label 'Receipt Numbers of original statements of TDS under sub-section (3) of section 200';
        Amount_of_tax_deducted_in_respect_of_the_employeeCaptionLbl: Label 'Amount of tax deducted in respect of the employee';
        Amount_of_tax_deposited__remitted_in_respect_of_the_employeeCaptionLbl: Label 'Amount of tax deposited/ remitted in respect of the employee';
        Quarter_2CaptionLbl: Label 'Quarter 2';
        Quarter_3CaptionLbl: Label 'Quarter 3';
        Quarter_4CaptionLbl: Label 'Quarter 4';
        Quarter_1CaptionLbl: Label 'Quarter 1';
        TotalCaption_Control1102152310Lbl: Label 'Total';
        EmptyStringCaptionLbl: Label '-';
        HRA__Sec_10__13A__CaptionLbl: Label 'HRA (Sec 10 (13A))';
        Transport__Sec_10_14__CaptionLbl: Label 'Transport (Sec 10(14))';
        Gratuity_exemptions_under_Sec_10__10_CaptionLbl: Label 'Gratuity exemptions under Sec 10 (10)';
        Medical_Reimbursement_Sec_17_2__CaptionLbl: Label 'Medical Reimbursement(Sec 17(2))';
        Children_s_Education_Allowance_sec_10__14__CaptionLbl: Label 'Children''s Education Allowance(sec 10 (14))';
        Leave_Travel_Concession__L_T_C_CaptionLbl: Label 'Leave Travel Concession (L.T.C)';
        Uniform_expenses__Sec_10_14__CaptionLbl: Label 'Uniform expenses (Sec 10(14))';
        Other_Source_of_IncomeCaptionLbl: Label '"  Other Source of Income"';
        Income_Loss__From_House_PropertyCaptionLbl: Label '"  Income(Loss) From House Property"';
        Rs_Caption_Control1102152010Lbl: Label 'Rs.';
        Intrest_on_House_Building_LoanCaptionLbl: Label '"  Intrest on House Building Loan"';
        Tution_FeesCaptionLbl: Label '"  Tution Fees"';
        V1_Caption_Control1102152355Lbl: Label '(1)';
        N_S_CCaptionLbl: Label '"   N.S.C"';
        V2_Caption_Control1102152360Lbl: Label '(2)';
        L_I_CCaptionLbl: Label '"   L.I.C"';
        V3_Caption_Control1102152364Lbl: Label '(3)';
        Section_80CCCCaptionLbl: Label '" Section 80CCC"';
        b_Caption_Control1102152367Lbl: Label '(b)';
        Section_80CCDCaptionLbl: Label '" Section 80CCD"';
        c_Caption_Control1102152369Lbl: Label '(c)';
        Other_sections__e_g__80E__80G_etc___under_Chapter_VI_ACaptionLbl: Label 'Other sections (e.g. 80E, 80G etc.) under Chapter VI-A';
        B_Caption_Control1102152376Lbl: Label '(B)';
        DeductibleCaptionLbl: Label 'Deductible';
        GrossCaptionLbl: Label 'Gross';
        QualifyingCaptionLbl: Label 'Qualifying';
        AmountCaptionLbl: Label 'Amount';
        AmountCaption_Control1102152381Lbl: Label 'Amount';
        AmountCaption_Control1102152382Lbl: Label 'Amount';
        i_CaptionLbl: Label '(i)';
        Section80ECaptionLbl: Label '"   Section80E"';
        Rs_Caption_Control1102152385Lbl: Label 'Rs.';
        Rs_Caption_Control1102152386Lbl: Label 'Rs.';
        Rs_Caption_Control1102152387Lbl: Label 'Rs.';
        ii_CaptionLbl: Label '(ii)';
        Section80GCaptionLbl: Label '"   Section80G"';
        Rs_Caption_Control1102152390Lbl: Label 'Rs.';
        Rs_Caption_Control1102152391Lbl: Label 'Rs.';
        Rs_Caption_Control1102152392Lbl: Label 'Rs.';
        Section80GGCaptionLbl: Label '"   Section80GG"';
        iii_CaptionLbl: Label '(iii)';
        Rs_Caption_Control1102152395Lbl: Label 'Rs.';
        Rs_Caption_Control1102152396Lbl: Label 'Rs.';
        Rs_Caption_Control1102152397Lbl: Label 'Rs.';
        Section80GGACaptionLbl: Label '"   Section80GGA"';
        iv_CaptionLbl: Label '(iv)';
        Rs_Caption_Control1102152400Lbl: Label 'Rs.';
        Rs_Caption_Control1102152401Lbl: Label 'Rs.';
        Rs_Caption_Control1102152402Lbl: Label 'Rs.';
        Section80GGCCaptionLbl: Label '"   Section80GGC"';
        Rs_Caption_Control1102152404Lbl: Label 'Rs.';
        v_CaptionLbl: Label '(v)';
        Rs_Caption_Control1102152407Lbl: Label 'Rs.';
        Aggregate_of_deductible_amount_under_Chapter_VIACaptionLbl: Label 'Aggregate of deductible amount under Chapter VIA';
        V10_CaptionLbl: Label '10.';
        Total_Income__8_10_CaptionLbl: Label 'Total Income (8-10)';
        V11_CaptionLbl: Label '11.';
        Tax_on_total_incomeCaptionLbl: Label 'Tax on total income';
        V12_CaptionLbl: Label '12.';
        Education_cess___3___on_tax_computed_at_S__No__12_CaptionLbl: Label 'Rebate u/s 87A (For Income upto Rs. 5,00,000/-)';
        V13_CaptionLbl: Label '13.';
        Tax_Payable__12_13__CaptionLbl: Label 'Tax Payable after reabate u/s 87A';
        V14_CaptionLbl: Label '14.';
        Less__Relief_under_section_89___attach_details_CaptionLbl: Label 'Education cess @ 3% (on tax computed at S. No. 14)';
        V15_CaptionLbl: Label '15.';
        Tax_payable___14_15__CaptionLbl: Label 'Tax payable ( 14-15 )';
        V16_CaptionLbl: Label '16.';
        Deductions_under_Chapter_VIACaptionLbl: Label 'Deductions under Chapter VIA';
        V9_CaptionLbl: Label '" 9."';
        Sections_80C__80CCC_and_80CCDCaptionLbl: Label '" Sections 80C, 80CCC and 80CCD"';
        A_Caption_Control1102152180Lbl: Label '(A)';
        a_Caption_Control1102152183Lbl: Label '(a)';
        Section_80CCaptionLbl: Label '" Section 80C"';
        Gross_AmountCaptionLbl: Label 'Gross Amount';
        DeductibleCaption_Control1102152015Lbl: Label 'Deductible Amount';
        AmountCaption_Control1102152016Lbl: Label 'Amount';
        VPFCaptionLbl: Label '"   VPF"';
        V9_Caption_Control1102152120Lbl: Label '(9)';
        Mutual_FundsCaptionLbl: Label '"   Mutual Funds"';
        V8_Caption_Control1102152122Lbl: Label '(8)';
        Term___Fixed_Deposits_above_5_yearsCaptionLbl: Label '"  Term / Fixed Deposits above 5 years"';
        V7_Caption_Control1102152497Lbl: Label '(7)';
        H_B__Loan_PrincipalCaptionLbl: Label '"   H.B  Loan Principal"';
        V6_Caption_Control1102152499Lbl: Label '(6)';
        V5_Caption_Control1102152500Lbl: Label '(5)';
        Stamp_Duty___Registration_FeesCaptionLbl: Label '"   Stamp Duty & Registration Fees"';
        V4_Caption_Control1102152502Lbl: Label '(4)';
        P_P_FCaptionLbl: Label '"   P.P.F"';
        Rs_Caption_Control1102152504Lbl: Label 'Rs.';
        Rs_Caption_Control1102152505Lbl: Label 'Rs.';
        Rs_Caption_Control1102152508Lbl: Label 'Rs.';
        Rs_Caption_Control1102152509Lbl: Label 'Rs.';
        Rs_Caption_Control1102152510Lbl: Label 'Rs.';
        Rs_Caption_Control1102152511Lbl: Label 'Rs.';
        Rs_Caption_Control1102152512Lbl: Label 'Rs.';
        Rs_Caption_Control1102152513Lbl: Label 'Rs.';
        Rs_Caption_Control1102152514Lbl: Label 'Rs.';
        Rs_Caption_Control1102152520Lbl: Label 'Rs.';
        Rs_Caption_Control1102152521Lbl: Label 'Rs.';
        Rs_Caption_Control1102152522Lbl: Label 'Rs.';
        Rs_Caption_Control1102152523Lbl: Label 'Rs.';
        Rs_Caption_Control1102152524Lbl: Label 'Rs.';
        Rs_Caption_Control1102152525Lbl: Label 'Rs.';
        Rs_Caption_Control1102152526Lbl: Label 'Rs.';
        Rs_Caption_Control1102152527Lbl: Label 'Rs.';
        Rs_Caption_Control1102152528Lbl: Label 'Rs.';
        d_Caption_Control1102152569Lbl: Label '(d)';
        Section_80CCF__Infra_Structure_Bond_CaptionLbl: Label '" Section 80CCF (Infra Structure Bond)"';
        Rs_Caption_Control1102152361Lbl: Label 'Rs.';
        Rs_Caption_Control1102152365Lbl: Label 'Rs.';
        Rs_Caption_Control1102152544Lbl: Label 'Rs.';
        Rs_Caption_Control1102152546Lbl: Label 'Rs.';
        Rs_Caption_Control1102152548Lbl: Label 'Rs.';
        Rs_Caption_Control1102152550Lbl: Label 'Rs.';
        Rs_Caption_Control1102152551Lbl: Label 'Rs.';
        Section80DDBCaptionLbl: Label '"   Section80DDB"';
        ix_CaptionLbl: Label '(ix)';
        Section80DCaptionLbl: Label '"   Section80D"';
        viii_CaptionLbl: Label '(viii)';
        Section80DDCaptionLbl: Label '"   Section80DD"';
        vii_CaptionLbl: Label '(vii)';
        vi_CaptionLbl: Label '(vi)';
        Section80UCaptionLbl: Label '"   Section80U"';
        Rs_Caption_Control1102152584Lbl: Label 'Rs.';
        Rs_Caption_Control1102152585Lbl: Label 'Rs.';
        Rs_Caption_Control1102152586Lbl: Label 'Rs.';
        Rs_Caption_Control1102152587Lbl: Label 'Rs.';
        Rs_Caption_Control1102152588Lbl: Label 'Rs.';
        Rs_Caption_Control1102152589Lbl: Label 'Rs.';
        Rs_Caption_Control1102152590Lbl: Label 'Rs.';
        Rs_Caption_Control1102152591Lbl: Label 'Rs.';
        Rs_Caption_Control1102152592Lbl: Label 'Rs.';
        Rs_Caption_Control1102152405Lbl: Label 'Rs.';
        Rs_Caption_Control1102152553Lbl: Label 'Rs.';
        VerificationCaptionLbl: Label 'Verification';
        Ij_CaptionLbl: Label 'I';
        workinginthecapacityCaptionLbl: Label 'working in the capacity of';
        I____SonDaughter___CaptionLbl: Label '"son/daughter of "';
        has_been__deducted___andLbl: Label '"has been  deducted   and  deposited  to   the   credit  of   the  Central   Government.  I  further   certify   that   the   information  given "';
        above__is_true___completeLbl: Label '"above  is true,  complete  and  correct  and   is  based  on  the   books   of   account,   documents,  TDS  statement,   TDS  deposited "';
        and___other_available_records_CaptionLbl: Label 'and   other available records.';
        PlaceCaptionLbl: Label 'Place';
        DateCaptionLbl: Label 'Date';
        DesignationCaptionLbl: Label 'Designation';
        Signature_of_person_responsible_for_deduction_of_taxCaptionLbl: Label 'Signature of person responsible for deduction of tax';
        Full_Name_CaptionLbl: Label 'Full Name:';
        V_V_NAGENDRACaptionLbl: Label '"       V.V.NAGENDRA"';
        MANAGING_DIRECTORCaptionLbl: Label 'MANAGING DIRECTOR';
        HYDERABAD_500016CaptionLbl: Label 'HYDERABAD-500016';
        MANAGING_DIRECTORCaption_Control1102152612Lbl: Label '"  MANAGING DIRECTOR"';
        V_V__NAGENDRACaptionLbl: Label '"  V.V. NAGENDRA"';
        V_S_V_BHASKAR_RAOCaptionLbl: Label 'V.S.V BHASKAR RAO';
        do_hereby_certify_Lbl: Label 'do hereby certify that a sum of Rs. ...........................[Rs. ........................................................................................................';
        Textbox_CaptionLbl: Label 'do hereby certify that a sum of Rs.';
        Textbox1_CaptionLbl: Label '[Rs';
        Notes_CaptionLbl: Label 'Notes:';
        V1_Caption_Control1102152238Lbl: Label '1.';
        If_an_assessee_is_employed_ACaptionLbl: Label 'If an assessee is employed under more than one employer during the year,each of the employers shall issue Part A';
        of_the__certificate_in__Form_No_16CaptionLbl: Label 'of the  certificate in  Form No. 16  pertaining to the period  for which  such  assessee was employed with each of the';
        employers__Part_B_may_be_issued_by_each_of_the_employers_or_the_last_employer_at_the_option_of_the_assessee_CaptionLbl: Label 'employers. Part B may be issued by each of the employers or the last employer at the option of the assessee.';
        V2_Caption_Control1102152242Lbl: Label '2.';
        Government__deductors_CaptionLbl: Label 'Government  deductors  to  enclose  Annexure-A  if  tax  is  paid  without  production of  an  income-tax  challan  and';
        Annexure_B_if_tax_is_paid_accompanied_by_income_tax_challan_CaptionLbl: Label 'Annexure-B if tax is paid accompanied by income-tax challan.';
        V3_Caption_Control1102152245Lbl: Label '3.';
        Non_Government_deductors_to_enclose_Annexure_BCaptionLbl: Label 'Non-Government deductors to enclose Annexure-B';
        V4_Caption_Control1102152247Lbl: Label '4.';
        The__deductor__shall_furnish_CaptionLbl: Label 'The  deductor  shall furnish  the  address  of  the  Commissioner of  Income-tax (TDS)  having jurisdiction as regards';
        TDS_statements_of_the_assessee_CaptionLbl: Label 'TDS statements of the assessee.';
        V5_Caption_Control1102152250Lbl: Label '5.';
        This_Form_shall_be_applicable_only_in_respect_of_tax_deducted_on_or_after_1st_day_of_April_2010_CaptionLbl: Label 'This Form shall be applicable only in respect of tax deducted on or after 1st day of April,2010.';
        ANNEXURE_BCaptionLbl: Label 'ANNEXURE-B';
        DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_IN_THE_CENTRAL_GOVERNMENT_ACCOUNT_THROUGHCaptionLbl: Label 'DETAILS OF TAX DEDUCTED AND DEPOSITED IN THE CENTRAL GOVERNMENT ACCOUNT THROUGH';
        CHALLANCaptionLbl: Label 'CHALLAN';
        The_Employer_to_provide_payment_wise_details_of_tax_deducted_and_deposited_with_respect_to_the_employee_CaptionLbl: Label '(The Employer to provide payment wise details of tax deducted and deposited with respect to the employee)';
        S__No_CaptionLbl: Label 'S. No.';
        Tax_Deposited_in_respect_of_the_employee__Rs__CaptionLbl: Label 'Tax Deposited in respect of the employee (Rs.)';
        Challan_identification_number__CIN_CaptionLbl: Label 'Challan identification number (CIN)';
        BSR_Code_of_the_Bank_BranchCaptionLbl: Label 'BSR Code of the Bank Branch';
        Date_on_which_tax_deposited__dd_mm_yyyy_CaptionLbl: Label 'Date on which tax deposited (dd/mm/yyyy)';
        Challan_identification_number__CIN_Caption_Control1102152325Lbl: Label 'Challan identification number (CIN)';
        Note_CaptionLbl: Label 'Note:';
        V1_Caption_Control1102152348Lbl: Label '1.';
        In_the_column_for_TDS__give_total_amount_for_TDS__Surcharge__if_applicable__and_education_cess_CaptionLbl: Label 'In the column for TDS, give total amount for TDS, Surcharge (if applicable) and education cess.';
        V1CaptionLbl: Label '1';
        V3CaptionLbl: Label '3';
        V5CaptionLbl: Label '5';
        V7CaptionLbl: Label '7';
        V9CaptionLbl: Label '9';
        V11CaptionLbl: Label '11';
        TotalCaption_Control1102152036Lbl: Label 'Total';
        V2CaptionLbl: Label '2';
        V4CaptionLbl: Label '4';
        V6CaptionLbl: Label '6';
        V8CaptionLbl: Label '8';
        V10CaptionLbl: Label '10';
        V12CaptionLbl: Label '12';
        ANNEXURE_BCaption_Control1102152077Lbl: Label 'ANNEXURE-B';
        DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_IN_THE_CENTRAL_GOVERNMENT_ACCOUNT_THROUGHCaption_Control1102152081Lbl: Label 'DETAILS OF TAX DEDUCTED AND DEPOSITED IN THE CENTRAL GOVERNMENT ACCOUNT THROUGH';
        CHALLANCaption_Control1102152082Lbl: Label 'CHALLAN';
        The_Employer_to_provide_payment_wise_Control110215Lbl: Label '(The Employer to provide payment wise details of tax deducted and deposited with respect to the employee)';
        S__No_Caption_Control1102152086Lbl: Label 'S. No.';
        Tax_Deposited_in_respect_of_the_employee__Rs__Caption_Control1102152087Lbl: Label 'Tax Deposited in respect of the employee (Rs.)';
        Challan_identification_number__CIN_Caption_Control1102152088Lbl: Label 'Challan identification number (CIN)';
        BSR_Code_of_the_Bank_BranchCaption_Control1102152089Lbl: Label 'BSR Code of the Bank Branch';
        Date_on_which_tax_deposited__dd_mm_yyyy_Caption_Control1102152091Lbl: Label 'Date on which tax deposited (dd/mm/yyyy)';
        Challan_identification_number__CIN_Caption_Control1102152092Lbl: Label 'Challan identification number (CIN)';
        Note_Caption_Control1102152112Lbl: Label 'Note:';
        V1_Caption_Control1102152113Lbl: Label '1.';
        In_the_column_for_TDS__give_total_Control1102152156Lbl: Label 'In the column for TDS, give total amount for TDS, Surcharge (if applicable) and education cess.';
        V3Caption_Control1102152158Lbl: Label '3';
        V5Caption_Control1102152159Lbl: Label '5';
        V7Caption_Control1102152160Lbl: Label '7';
        V9Caption_Control1102152161Lbl: Label '9';
        V11Caption_Control1102152162Lbl: Label '11';
        TotalCaption_Control1102152163Lbl: Label 'Total';
        V4Caption_Control1102152165Lbl: Label '4';
        V6Caption_Control1102152168Lbl: Label '6';
        V8Caption_Control1102152186Lbl: Label '8';
        V10Caption_Control1102152189Lbl: Label '10';
        V12Caption_Control1102152193Lbl: Label '12';
        V6390340CaptionLbl: Label '6390340';
        V6390340Caption_Control1102152164Lbl: Label '6390340';
        V6390340Caption_Control1102152209Lbl: Label '6390340';
        V6390340Caption_Control1102152210Lbl: Label '6390340';
        V6390340Caption_Control1102152211Lbl: Label '6390340';
        V6390340Caption_Control1102152213Lbl: Label '6390340';
        V6390340Caption_Control1102152214Lbl: Label '6390340';
        V6390340Caption_Control1102152215Lbl: Label '6390340';
        V6390340Caption_Control1102152258Lbl: Label '6390340';
        V6390340Caption_Control1102152259Lbl: Label '6390340';
        V6390340Caption_Control1102152321Lbl: Label '6390340';
        V6390340Caption_Control1102152322Lbl: Label '6390340';
        V1Caption_Control1102152207Lbl: Label '1';
        V2Caption_Control1102152208Lbl: Label '2';
        Challan_Identification_Number__CIN_Caption_Control1102152448Lbl: Label 'Challan Identification Number (CIN)';
        Date_on_which_tax_deposited__dd_mm_yyyy_Caption_Control1102152449Lbl: Label 'Date on which tax deposited (dd/mm/yyyy)';
        Challan_Identification_Number__CIN_Caption_Control1102152451Lbl: Label 'Challan Identification Number (CIN)';
        BSR_Code_of_the_Bank_BranchCaption_Control1102152452Lbl: Label 'BSR Code of the Bank Branch';
        Tax_Deposited_in_respect_of_the_employee__Rs__Caption_Control1102152453Lbl: Label 'Tax Deposited in respect of the employee (Rs.)';
        S__No_Caption_Control1102152454Lbl: Label 'S. No.';
        The_Employer_to_provide_payment_wise_Control110000Lbl: Label '(The Employer to provide payment wise details of tax deducted and deposited with respect to the employee)';
        CHALLANCaption_Control1102152459Lbl: Label 'CHALLAN';
        DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_IN_THE_CENTRAL_GOVERNMENT_ACCOUNT_THROUGHCaption_Control1102152460Lbl: Label 'DETAILS OF TAX DEDUCTED AND DEPOSITED IN THE CENTRAL GOVERNMENT ACCOUNT THROUGH';
        ANNEXURE_BCaption_Control1102152461Lbl: Label 'ANNEXURE-B';
        V6390340Caption_Control1102152506Lbl: Label '6390340';
        TotalCaption_Control1102152455Lbl: Label 'Total';
        NoteAgg_CaptionLbl: Label 'Notes : 1. Aggregate amount deductible under section 80C shall not exceed one lakh rupes.';
        AggAmount_CaptionLbl: Label '" 2. Aggregate amount deductible under the three sections, i.e., 80C, 80CCC and 80CCD, shall not exceed one lakh rupees."';
        V17_CaptionLbl: Label '17.';
        ReliefUnder_CaptionLbl: Label 'Relief under section 89 ( attach details)';
        V18_CaptionLbl: Label '18.';
        TaxPay_CaptionLbl: Label 'Tax payable ( 16-17 )';
        V19_CaptionLbl: Label '19.';
        Less_CaptionLbl: Label 'Less : (a) Tax deducted at source u/s 192(1)';
        V20_CaptionLbl: Label '20.';
        TaxPayble_CaptionLbl: Label 'Tax payable/(refundable) ( 18-19 )';
        MMYYY_CaptionLbl: Label 'MM-YYY';
        MonthYear: array[24] of Text[30];
        BSRCode: array[24] of Code[20];
        GrossTotalIncomecha: Decimal;
        TaxPayableOrRefundable: Decimal;
        TaxPayableOrRefundableTxt: Text;
        Zero_CaptionLbl: Label '0.00';
        HousePrptyTxt: Text;
        Text003Txt: Label 'Employee No. Must be specified';
        Text004Txt: Label 'Employee %1 dont have P.A.N No.', Comment = '%1 = No';
        Text005Txt: Label 'TDS';
        Text006Txt: Label '<1M>';
        Text007Txt: Label 'U/S 10&17';
        Text008Txt: Label 'HRA EXEMPTION';
        Text009Txt: Label 'TRANSPORT EXEMP';
        Text0010Txt: Label 'OTHER EXPEMTION';
        Text0011Txt: Label 'MEDICAL BILL EXEMP';
        Text0012Txt: Label 'CEA EXEMPTION';
        Text0013Txt: Label 'LTA EXEMPTION';
        Text0014Txt: Label 'INT ON HBL';
        Text0015Txt: Label 'H/P - P&L';
        Text0016Txt: Label '<Sign><Integer><Decimals,3>';
        Text0017Txt: Label 'SEC 80 CCF';
        Text0018Txt: Label 'SEC 80D';
        Text0019Txt: Label 'SEC 80E';
        Text0020Txt: Label 'SEC 80U';
        Text0021Txt: Label 'SEC 80DD';
        Text0022Txt: Label 'SEC 80DDB';
        Text0023Txt: Label 'CEA FEES';
        Text0024Txt: Label 'NSC';
        Text0025Txt: Label 'IP & OTHERS';
        Text0026Txt: Label 'PPF';
        Text0027Txt: Label 'HLPR';
        Text0028Txt: Label 'EPF & VPF';
        Text0029Txt: Label 'NPS1';
        Text0030Txt: Label 'FINANCIAL YEAR';

    procedure Setvalues(StartDateLPar: Date; EndDateLPar: Date; EmpLpar: Code[20]; EmpName: Text[70]; EmpDesiganation: Text[50]);
    begin
        StartDate := StartDateLPar;
        EndDate := EndDateLPar;
        EmpNoGVar := EmpLpar;
        PayrollYearStDateGVar := StartDateLPar;
        PayrollYearEndDateGVar := EndDateLPar;
        NameGVar := EmpName;
        Designation1GVar := EmpDesiganation;
    end;
}

