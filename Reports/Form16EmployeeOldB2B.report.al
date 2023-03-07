report 33001228 "Form 16 - Employee _ Old B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Form 16 - Employee _ Old.rdlc';
    Caption = 'Form 16 - Employee _ Old';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
            column(Employee_B2B__No__; "No.")
            {
            }
            column(Employee_B2B__First_Name_; "First Name")
            {
            }
            column(Employee_B2B_Address; Address)
            {
            }
            column(Employee_B2B__Address_2_; "Address 2")
            {
            }
            column(Employee_B2B_City; City)
            {
            }
            column(Employee_B2B__Post_Code_; "Post Code")
            {
            }
            column(Employee_B2B__PAN_No_; "PAN No")
            {
            }
            column(Companyinform_Name; Companyinform.Name)
            {
            }
            column(Companyinform_Address; Companyinform.Address)
            {
            }
            column(Companyinform__Address_2_; Companyinform."Address 2")
            {
            }
            column(Companyinform_City; Companyinform.City)
            {
            }
            column(Companyinform__Post_Code_; Companyinform."Post Code")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            /*
             column(CurrReport_PAGENO; CurrReport.PAGENO)
             {
             }*///B2BBP

            column(Companyinform__T_A_N__No__; Companyinform."T.A.N. No. B2B")
            {
            }
            column(Companyinform__P_A_N__No__; Companyinform."P.A.N. No. B2B")
            {
            }
            column(EmpTDSDedGRec__PT_Amount_; EmpTDSDedGRec."PT Amount")
            {
            }
            column(EmpTDSDedGRec__PT_Amount__Control1102154081; EmpTDSDedGRec."PT Amount")
            {
            }
            column(EmpTDSDedGRec__Gross_Salary__EmpTDSDedGRec__Profit_Lieu_of_Salary____EmpTDSDedGRec__Exem_Under_10_and_17__; (EmpTDSDedGRec."Gross Salary" + EmpTDSDedGRec."Profit Lieu of Salary") - (EmpTDSDedGRec."Exem Under 10 and 17"))
            {
            }
            column(EmpTDSDedGRec__Exem_Under_10_and_17_; EmpTDSDedGRec."Exem Under 10 and 17")
            {
            }
            column(EmpTDSDedGRec__Gross_Salary__EmpTDSDedGRec__Profit_Lieu_of_Salary_; EmpTDSDedGRec."Gross Salary" + EmpTDSDedGRec."Profit Lieu of Salary")
            {
            }
            column(EmpTDSDedGRec__Gross_Salary_; EmpTDSDedGRec."Gross Salary")
            {
            }
            column(EmpTDSDedGRec__Income_Charged_Under_Salary_; EmpTDSDedGRec."Income Charged Under Salary")
            {
            }
            column(EmpTDSDedGRec__Other_Income_; EmpTDSDedGRec."Other Income")
            {
            }
            column(EmpTDSDedGRec__Gross_Total_Income_; EmpTDSDedGRec."Gross Total Income")
            {
            }
            column(EmpTDSDedGRec__Profit_Lieu_of_Salary_; EmpTDSDedGRec."Profit Lieu of Salary")
            {
            }
            column(V0_; '0')
            {
            }
            column(V0__Control1102154006; '0')
            {
            }
            column(o_; 'o')
            {
            }
            column(o__Control1102154020; 'o')
            {
            }
            column(TotGroupLimit; TotGroupLimit)
            {
            }
            column(EmpTDSDedGRec__Total_Tax_Liability_; EmpTDSDedGRec."Total Tax Liability")
            {
            }
            column(EmpTDSDedGRec_Surcharge; EmpTDSDedGRec.Surcharge)
            {
            }
            column(EmpTDSDedGRec_eCess; EmpTDSDedGRec.eCess)
            {
            }
            column(EmpTDSDedGRec__Total_Tax_Liability__EmpTDSDedGRec_Surcharge_EmpTDSDedGRec_eCess; EmpTDSDedGRec."Total Tax Liability" + EmpTDSDedGRec.Surcharge + EmpTDSDedGRec.eCess)
            {
            }
            column(EmpTDSDedGRec__Relief_US89_; EmpTDSDedGRec."Relief US89")
            {
            }
            column(EmpTDSDedGRec__Total_Tax_Liability__EmpTDSDedGRec_Surcharge_EmpTDSDedGRec_eCess__EmpTDSDedGRec__Relief_US89_; (EmpTDSDedGRec."Total Tax Liability" + EmpTDSDedGRec.Surcharge + EmpTDSDedGRec.eCess) - EmpTDSDedGRec."Relief US89")
            {
            }
            column(o__Control1102154031; 'o')
            {
            }
            column(o__Control1102154033; 'o')
            {
            }
            column(EmpTDSDedGRec__Gross_Total_Income_____TotGroupLimit_; (EmpTDSDedGRec."Gross Total Income" - TotGroupLimit))
            {
            }
            column(EmpTDSDedGRec__Total_Tax_Liability__EmpTDSDedGRec_Surcharge_EmpTDSDedGRec_eCess__EmpTDSDedGRec__Relief_US89____TotalTDS; (EmpTDSDedGRec."Total Tax Liability" + EmpTDSDedGRec.Surcharge + EmpTDSDedGRec.eCess) - EmpTDSDedGRec."Relief US89" - TotalTDS)
            {
            }
            column(Name; Name)
            {
            }
            column(FatherName; FatherName)
            {
            }
            column(TextVar_1__TextVar_2_; TextVar[1] + TextVar[2])
            {
            }
            column(Name_Control1102154110; Name)
            {
            }
            column(Employee_B2B_Designation; Designation)
            {
            }
            column(Employee_B2B_Designation_Control1102154114; Designation)
            {
            }
            column(April; April)
            {
            }
            column(June; June)
            {
            }
            column(July; July)
            {
            }
            column(August; August)
            {
            }
            column(September; September)
            {
            }
            column(October; October)
            {
            }
            column(May; May)
            {
            }
            column(Feb; Feb)
            {
            }
            column(Jan; Jan)
            {
            }
            column(December; December)
            {
            }
            column(Navomber; Navomber)
            {
            }
            column(march; march)
            {
            }
            column(DOPApril; DOPApril)
            {
            }
            column(DOPMay; DOPMay)
            {
            }
            column(DOPJune; DOPJune)
            {
            }
            column(DOPJuly; DOPJuly)
            {
            }
            column(DOPAugust; DOPAugust)
            {
            }
            column(DOPSeptember; DOPSeptember)
            {
            }
            column(DOPOctober; DOPOctober)
            {
            }
            column(DOPNavomber; DOPNavomber)
            {
            }
            column(DOPDecember; DOPDecember)
            {
            }
            column(DOPJan; DOPJan)
            {
            }
            column(DOPFeb; DOPFeb)
            {
            }
            column(DOPmarch; DOPmarch)
            {
            }
            column(AprilBank; AprilBank)
            {
            }
            column(MayBank; MayBank)
            {
            }
            column(JuneBank; JuneBank)
            {
            }
            column(JulyBank; JulyBank)
            {
            }
            column(AugustBank; AugustBank)
            {
            }
            column(SeptemberBank; SeptemberBank)
            {
            }
            column(OctoberBank; OctoberBank)
            {
            }
            column(NavomberBank; NavomberBank)
            {
            }
            column(DecemberBank; DecemberBank)
            {
            }
            column(JanBank; JanBank)
            {
            }
            column(FebBank; FebBank)
            {
            }
            column(marchBank; marchBank)
            {
            }
            column(DOI; DOI)
            {
            }
            column(Place; Place)
            {
            }
            column(Form_16Caption; Form_16CaptionLbl)
            {
            }
            column(Vide_rule_31_1__a__of_Income_Tax_Rules__1962_Caption; Vide_rule_31_1__a__of_Income_Tax_Rules__1962_CaptionLbl)
            {
            }
            column(Certificate_under_section_203_of_the_Income_tax_Act__1961_for_tax_deductedCaption; Certificate_under_section_203_of_the_Income_tax_Act__1961_for_tax_deductedCaptionLbl)
            {
            }
            column(at_source_from_income_chargeable_under_the_head__Salaries__Caption; at_source_from_income_chargeable_under_the_head__Salaries__CaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(AddressCaption; AddressCaptionLbl)
            {
            }
            column(Address_2Caption; Address_2CaptionLbl)
            {
            }
            column(CityCaption; CityCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(PAN_NoCaption; PAN_NoCaptionLbl)
            {
            }
            column(Name___Designation_of_the_EmployeeCaption; Name___Designation_of_the_EmployeeCaptionLbl)
            {
            }
            column(Name___Address_of_the_EmployeeCaption; Name___Address_of_the_EmployeeCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(AddressCaption_Control1102152023; AddressCaption_Control1102152023Lbl)
            {
            }
            column(Address_2Caption_Control1102152025; Address_2Caption_Control1102152025Lbl)
            {
            }
            column(CityCaption_Control1102152026; CityCaption_Control1102152026Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152029; EmptyStringCaption_Control1102152029Lbl)
            {
            }
            column(PAN_NoCaption_Control1102152031; PAN_NoCaption_Control1102152031Lbl)
            {
            }
            column(TA_N__No_Caption; TA_N__No_CaptionLbl)
            {
            }
            column(TDS_Circle_where_Annual_Return_Statement_under_Caption; TDS_Circle_where_Annual_Return_Statement_under_CaptionLbl)
            {
            }
            column(Section_206_is_to_be_filedCaption; Section_206_is_to_be_filedCaptionLbl)
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
            column(Assessment_YearCaption; Assessment_YearCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152051; EmptyStringCaption_Control1102152051Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152053; EmptyStringCaption_Control1102152053Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152054; EmptyStringCaption_Control1102152054Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152055; EmptyStringCaption_Control1102152055Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152056; EmptyStringCaption_Control1102152056Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152057; EmptyStringCaption_Control1102152057Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152058; EmptyStringCaption_Control1102152058Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152059; EmptyStringCaption_Control1102152059Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152060; EmptyStringCaption_Control1102152060Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152061; EmptyStringCaption_Control1102152061Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152062; EmptyStringCaption_Control1102152062Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152063; EmptyStringCaption_Control1102152063Lbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(V5__Aggregate_of_4__a__and__b_Caption; V5__Aggregate_of_4__a__and__b_CaptionLbl)
            {
            }
            column(a__Entertainment_allowanceCaption; a__Entertainment_allowanceCaptionLbl)
            {
            }
            column(b__Tax_on_EmploymentCaption; b__Tax_on_EmploymentCaptionLbl)
            {
            }
            column(V4__DEDUCTIONS__Caption; V4__DEDUCTIONS__CaptionLbl)
            {
            }
            column(V3__BALANCE_Caption; V3__BALANCE_CaptionLbl)
            {
            }
            column(V2__Less___Allowance_to_the_extent_exempt_under_Section_10Caption; V2__Less___Allowance_to_the_extent_exempt_under_Section_10CaptionLbl)
            {
            }
            column(d__TotalCaption; d__TotalCaptionLbl)
            {
            }
            column(as_per_Form_No_12BA_Caption; as_per_Form_No_12BA_CaptionLbl)
            {
            }
            column(c__Profits_in_lieu_of_salary_under_section_17_3___Caption; c__Profits_in_lieu_of_salary_under_section_17_3___CaptionLbl)
            {
            }
            column(b__Value_of_prequisites_u_s_17_2__as_per_Form_No_12BA__where_applicable_Caption; b__Value_of_prequisites_u_s_17_2__as_per_Form_No_12BA__where_applicable_CaptionLbl)
            {
            }
            column(a__Salary_as_per_provisions_contained_in_Sec_17_1_Caption; a__Salary_as_per_provisions_contained_in_Sec_17_1_CaptionLbl)
            {
            }
            column(V1__Gross_SalaryCaption; V1__Gross_SalaryCaptionLbl)
            {
            }
            column(V6__INCOME_CHARGEABLE_UNDER_THE_HEAD_SALARIESCaption; V6__INCOME_CHARGEABLE_UNDER_THE_HEAD_SALARIESCaptionLbl)
            {
            }
            column(V7__Add___Any_other_income_reported_by_the_employeeCaption; V7__Add___Any_other_income_reported_by_the_employeeCaptionLbl)
            {
            }
            column(V8__GROSS_TOTAL_INCOMECaption; V8__GROSS_TOTAL_INCOMECaptionLbl)
            {
            }
            column(DETAILS_OF_SALARY_PAID_AND_ANY_OTHER_INCOME_AND_TAX_DEDUCTEDCaption; DETAILS_OF_SALARY_PAID_AND_ANY_OTHER_INCOME_AND_TAX_DEDUCTEDCaptionLbl)
            {
            }
            column(V10__Aggregate_of_deductible_amount_under_Chapter_VIACaption; V10__Aggregate_of_deductible_amount_under_Chapter_VIACaptionLbl)
            {
            }
            column(V11__TOTAL_INCOMECaption; V11__TOTAL_INCOMECaptionLbl)
            {
            }
            column(V12__TAX_ON_TOTAL_INCOME_Caption; V12__TAX_ON_TOTAL_INCOME_CaptionLbl)
            {
            }
            column(V13__SURCHARGE__ON_TAX_COMPUTED_AT_S_NO_12_Caption; V13__SURCHARGE__ON_TAX_COMPUTED_AT_S_NO_12_CaptionLbl)
            {
            }
            column(V14__EDUCATION_CESS__on_tax_at_S_NO_12___surcharge_at_S_NO_13_Caption; V14__EDUCATION_CESS__on_tax_at_S_NO_12___surcharge_at_S_NO_13_CaptionLbl)
            {
            }
            column(V15__TAX_PAYABLECaption; V15__TAX_PAYABLECaptionLbl)
            {
            }
            column(V16__RELIEF_UNDER_Sec_89__attach_details_Caption; V16__RELIEF_UNDER_Sec_89__attach_details_CaptionLbl)
            {
            }
            column(V17__TAX_PAYABLECaption; V17__TAX_PAYABLECaptionLbl)
            {
            }
            column(V18__Less___a__Tax_deducted_at_source_under_section_192__1_Caption; V18__Less___a__Tax_deducted_at_source_under_section_192__1_CaptionLbl)
            {
            }
            column(b__Tax_paid_by_the_Employer_on_behalf_of_the_EmployeeCaption; b__Tax_paid_by_the_Employer_on_behalf_of_the_EmployeeCaptionLbl)
            {
            }
            column(Under_section_192___1A_on_perquisitesCaption; Under_section_192___1A_on_perquisitesCaptionLbl)
            {
            }
            column(Under_Section_17__2_Caption; Under_Section_17__2_CaptionLbl)
            {
            }
            column(V19__TAX_PAYABLE_REFUNDABLECaption; V19__TAX_PAYABLE_REFUNDABLECaptionLbl)
            {
            }
            column(I_Caption; I_CaptionLbl)
            {
            }
            column(do_here_by_certified_that_a_sum_of_Caption; do_here_by_certified_that_a_sum_of_CaptionLbl)
            {
            }
            column(DataItem1102154067; has_been_deductedLbl)
            {
            }
            column(given_above_is_true_and_correct_based_on_the_book_of_Accounts___Documents_and_other_Available_records_Caption; given_above_is_true_and_correct_based_on_the_book_of_Accounts___Documents_and_other_Available_records_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(PlaceCaption; PlaceCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154072; EmptyStringCaption_Control1102154072Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154073; EmptyStringCaption_Control1102154073Lbl)
            {
            }
            column(Son_of_Do_ofCaption; Son_of_Do_ofCaptionLbl)
            {
            }
            column(Signature_of_the_person_responsible_for_deduction_of_taxCaption; Signature_of_the_person_responsible_for_deduction_of_taxCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154095; EmptyStringCaption_Control1102154095Lbl)
            {
            }
            column(working_in_capacity_ofCaption; working_in_capacity_ofCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154108; EmptyStringCaption_Control1102154108Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154109; EmptyStringCaption_Control1102154109Lbl)
            {
            }
            column(Full_NameCaption; Full_NameCaptionLbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(NAME_OF_BANK_AND_BRANCH_WHERE_TAX_DEPOSITEDCaption; NAME_OF_BANK_AND_BRANCH_WHERE_TAX_DEPOSITEDCaptionLbl)
            {
            }
            column(Date_of_PaymentsCaption; Date_of_PaymentsCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(MonthCaption; MonthCaptionLbl)
            {
            }
            column(AprilCaption; AprilCaptionLbl)
            {
            }
            column(JuneCaption; JuneCaptionLbl)
            {
            }
            column(AugustCaption; AugustCaptionLbl)
            {
            }
            column(OctoberCaption; OctoberCaptionLbl)
            {
            }
            column(DecemberCaption; DecemberCaptionLbl)
            {
            }
            column(FebravaryCaption; FebravaryCaptionLbl)
            {
            }
            column(MarchCaption; MarchCaptionLbl)
            {
            }
            column(MayCaption; MayCaptionLbl)
            {
            }
            column(JulyCaption; JulyCaptionLbl)
            {
            }
            column(SepetemberCaption; SepetemberCaptionLbl)
            {
            }
            column(NovamberCaption; NovamberCaptionLbl)
            {
            }
            column(JanuavaryCaption; JanuavaryCaptionLbl)
            {
            }
            column(DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_INTO_CENTRAL_GOVERNMENT_ACCOUNTCaption; DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_INTO_CENTRAL_GOVERNMENT_ACCOUNTCaptionLbl)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 .. 2));
                dataitem("IT Chapters"; "IT Chapters B2B")
                {
                    DataItemTableView = SORTING("Chapter ID") ORDER(Ascending);
                    column(B__Other_Sections_under_Chapter_VI____SectionHeadings; '   (B) Other Sections under Chapter VI  ' + SectionHeadings)
                    {
                    }
                    column(Deductable_AmountCaption; Deductable_AmountCaptionLbl)
                    {
                    }
                    column(Gross_AmountCaption; Gross_AmountCaptionLbl)
                    {
                    }
                    column(V9__DEDUCTIONS_UNDER_CHAPTER_VIACaption; V9__DEDUCTIONS_UNDER_CHAPTER_VIACaptionLbl)
                    {
                    }
                    column(IT_Chapters_Chapter_ID; "Chapter ID")
                    {
                    }
                    dataitem("Excemption Sections"; "Excemption Sections B2B")
                    {
                        DataItemLink = "Chapter ID" = FIELD("Chapter ID");
                        DataItemTableView = SORTING("Section ID") ORDER(Ascending);
                        column(A__Sections____SectionHeadings; '   (A) Sections ' + SectionHeadings)
                        {
                        }
                        column(A__Sections____SectionHeadings_Control1102154039; '   (A) Sections ' + SectionHeadings)
                        {
                        }
                        column(Excemption_Sections_Section_ID; "Section ID")
                        {
                        }
                        column(Excemption_Sections_Chapter_ID; "Chapter ID")
                        {
                        }
                        dataitem("Exep/Ded Groups"; "Exep/Ded Groups B2B")
                        {
                            DataItemLink = "Section ID" = FIELD("Section ID");
                            DataItemTableView = SORTING("Exemp / Ded Group Id") ORDER(Ascending);
                            column(GroupLimit; GroupLimit)
                            {
                            }
                            column(GroupPaid; GroupPaid)
                            {
                            }
                            column(GroupNumberSeries________Exep_Ded_Groups___Exemp___Ded_Group_Id_; '       (' + GroupNumberSeries + ')  ' + "Exep/Ded Groups"."Exemp / Ded Group Id")
                            {
                            }
                            column(Exep_Ded_Groups_Exemp___Ded_Group_Id; "Exemp / Ded Group Id")
                            {
                            }
                            column(Exep_Ded_Groups_Section_ID; "Section ID")
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                GroupCounter += 1;
                                if GroupCounter = 1 then
                                    GroupNumberSeries := 'i';
                                if GroupCounter = 2 then
                                    GroupNumberSeries := 'ii';
                                if GroupCounter = 3 then
                                    GroupNumberSeries := 'iii';
                                if GroupCounter = 4 then
                                    GroupNumberSeries := 'iV';
                                if GroupCounter = 5 then
                                    GroupNumberSeries := 'V';
                                if GroupCounter = 6 then
                                    GroupNumberSeries := 'Vi';
                                if GroupCounter = 7 then
                                    GroupNumberSeries := 'Vii';
                                if GroupCounter = 8 then
                                    GroupNumberSeries := 'Viii';
                                if GroupCounter = 9 then
                                    GroupNumberSeries := 'ix';
                                if GroupCounter = 10 then
                                    GroupNumberSeries := 'x';

                                TDSSavingsGRec.RESET();
                                TDSSavingsGRec.SETRANGE("Emp ID", "Employee B2B"."No.");
                                TDSSavingsGRec.SETRANGE("Financial Year Start Date", PayrollYearStDate);
                                TDSSavingsGRec.SETRANGE("Financial Year End Date", PayrollYearEndDate);
                                TDSSavingsGRec.SETRANGE("Exemption Group Id", "Exep/Ded Groups"."Exemp / Ded Group Id");
                                if TDSSavingsGRec.FINDFIRST() then begin
                                    GroupPaid := TDSSavingsGRec."Actual Paid";
                                    GroupLimit := TDSSavingsGRec.Limit;
                                end else begin
                                    GroupPaid := 0;
                                    GroupLimit := 0;
                                end;
                                TotGroupPaid += GroupPaid;
                                TotGroupLimit += GroupLimit;
                            end;

                            trigger OnPreDataItem();
                            begin
                                CLEAR(GroupCounter);
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            SectionCounter += 1;
                            if SectionCounter = 1 then
                                SectionNumberSeries := 'a';
                            if SectionCounter = 2 then
                                SectionNumberSeries := 'b';
                            if SectionCounter = 3 then
                                SectionNumberSeries := 'c';
                            if SectionCounter = 4 then
                                SectionNumberSeries := 'd';
                            if SectionCounter = 5 then
                                SectionNumberSeries := 'e';
                            if SectionCounter = 6 then
                                SectionNumberSeries := 'f';
                            if SectionCounter = 7 then
                                SectionNumberSeries := 'g';
                            if SectionCounter = 8 then
                                SectionNumberSeries := 'h';
                            if SectionCounter = 9 then
                                SectionNumberSeries := 'i';
                            if SectionCounter = 10 then
                                SectionNumberSeries := 'j';
                        end;

                        trigger OnPreDataItem();
                        begin
                            CLEAR(SectionCounter);
                        end;
                    }

                    trigger OnPreDataItem();
                    begin
                        if Integer.Number = 1 then
                            SETRANGE("Chapter ID", VIATxt);
                        if Integer.Number = 2 then
                            SETRANGE("Chapter ID", VITxt);
                    end;
                }
            }

            trigger OnAfterGetRecord();
            begin
                if "Employee B2B"."PAN No" = '' then
                    ERROR(Text003Txt, "Employee B2B"."No.");

                EmpTDSDedGRec.RESET();
                EmpTDSDedGRec.SETRANGE("Emp ID", "Employee B2B"."No.");
                EmpTDSDedGRec.SETRANGE("Financial Year Start Date", PayrollYearStDate);
                EmpTDSDedGRec.SETRANGE("Financial Year End Date", PayrollYearEndDate);
                if EmpTDSDedGRec.FINDFIRST() then
                    EmpTDSDedGRec.CALCFIELDS("Gross Salary");

                CLEAR(TotalTDS);
                ProcessedSalary.SETRANGE("Employee Code", "Employee B2B"."No.");
                ProcessedSalary.SETRANGE("Add/Deduct Code", 'TDS');
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        Month := ProcessedSalary."Pay Slip Month";
                        case Month of
                            1:
                                Jan := ProcessedSalary."Earned Amount";
                            2:
                                Feb := ProcessedSalary."Earned Amount";
                            3:
                                march := ProcessedSalary."Earned Amount";
                            4:
                                April := ProcessedSalary."Earned Amount";
                            5:
                                May := ProcessedSalary."Earned Amount";
                            6:
                                June := ProcessedSalary."Earned Amount";
                            7:
                                July := ProcessedSalary."Earned Amount";
                            8:
                                August := ProcessedSalary."Earned Amount";
                            9:
                                September := ProcessedSalary."Earned Amount";
                            10:
                                October := ProcessedSalary."Earned Amount";
                            11:
                                Navomber := ProcessedSalary."Earned Amount";
                            12:
                                December := ProcessedSalary."Earned Amount";
                        end;
                        TotalTDS += ProcessedSalary."Earned Amount";
                    until ProcessedSalary.NEXT() = 0;
            end;

            trigger OnPreDataItem();
            var
                Text33001Lbl: Label 'FINANCIAL YEAR';
            begin

                Companyinform.GET();
                PayRollYear.RESET();
                PayRollYear.SETRANGE("Year Type", Text33001Lbl);
                PayrollYear.SetRange(Closed, false);
                if PayRollYear.FINDFIRST() then begin
                    PayrollYearStDate := PayrollYear."Year Start Date";
                    PayrollYearEndDate := PayRollYear."Year End Date";
                end;
                if Companyinform."P.A.N. No. B2B" = '' then
                    ERROR(Text001Txt, Companyinform.Name);

                if Companyinform."T.A.N. No. B2B" = '' then
                    ERROR(Text002Txt, Companyinform.Name);
            end;
        }
    }

    requestpage
    {
        Caption = 'Form 16 - Employee _ Old';

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Companyinform: Record "Company Information";
        ProcessedSalary: Record "Processed Salary B2B";
        EmpTDSDedGRec: Record "TDS Deductions B2B";
        TDSSavingsGRec: Record "TDS Savings B2B";
        PayrollYear: Record "Payroll Year B2B";
        Month: Integer;

        StartDate: Date;
        EndDate: Date;
        TextVar: array[2] of Text[80];
        Jan: Decimal;
        Feb: Decimal;
        march: Decimal;
        April: Decimal;
        May: Decimal;
        June: Decimal;
        July: Decimal;
        August: Decimal;
        September: Decimal;
        October: Decimal;
        Navomber: Decimal;
        December: Decimal;
        DOPJan: Date;
        DOPFeb: Date;
        DOPmarch: Date;
        DOPApril: Date;
        DOPMay: Date;
        DOPJune: Date;
        DOPJuly: Date;
        DOPAugust: Date;
        DOPSeptember: Date;
        DOPOctober: Date;
        DOPNavomber: Date;
        DOPDecember: Date;
        JanBank: Text[30];
        FebBank: Text[30];
        marchBank: Text[30];
        AprilBank: Text[30];
        MayBank: Text[30];
        JuneBank: Text[30];
        JulyBank: Text[30];
        AugustBank: Text[30];
        SeptemberBank: Text[30];
        OctoberBank: Text[30];
        NavomberBank: Text[30];
        DecemberBank: Text[30];
        DOI: Date;
        Name: Text[30];
        Place: Text[30];
        PayrollYearStDate: Date;
        PayrollYearEndDate: Date;
        SectionHeadings: Text[90];
        SectionCounter: Integer;
        SectionNumberSeries: Text[30];
        GroupCounter: Integer;
        GroupNumberSeries: Text[30];
        GroupPaid: Decimal;
        GroupLimit: Decimal;
        TotGroupPaid: Decimal;
        TotGroupLimit: Decimal;
        FatherName: Text[50];
        TotalTDS: Decimal;
        Form_16CaptionLbl: Label 'Form 16';
        Vide_rule_31_1__a__of_Income_Tax_Rules__1962_CaptionLbl: Label '(Vide rule 31(1)(a) of Income Tax Rules, 1962)';
        Certificate_under_section_203_of_the_Income_tax_Act__1961_for_tax_deductedCaptionLbl: Label 'Certificate under section 203 of the Income-tax Act, 1961 for tax deducted';
        at_source_from_income_chargeable_under_the_head__Salaries__CaptionLbl: Label '"          at source from income chargeable under the head ""Salaries""."';
        Employee_No_CaptionLbl: Label '"  Employee No."';
        Employee_NameCaptionLbl: Label '"  Employee Name"';
        AddressCaptionLbl: Label '"  Address"';
        Address_2CaptionLbl: Label '"  Address 2"';
        CityCaptionLbl: Label '"  City"';
        EmptyStringCaptionLbl: Label '-';
        PAN_NoCaptionLbl: Label '"  PAN No"';
        Name___Designation_of_the_EmployeeCaptionLbl: Label 'Name & Designation of the Employee';
        Name___Address_of_the_EmployeeCaptionLbl: Label 'Name & Address of the Employee';
        NameCaptionLbl: Label '"  Name"';
        AddressCaption_Control1102152023Lbl: Label '"  Address"';
        Address_2Caption_Control1102152025Lbl: Label '"  Address 2"';
        CityCaption_Control1102152026Lbl: Label '"  City"';
        EmptyStringCaption_Control1102152029Lbl: Label '-';
        PAN_NoCaption_Control1102152031Lbl: Label '"  PAN No"';
        TA_N__No_CaptionLbl: Label '"  TA.N. No."';
        TDS_Circle_where_Annual_Return_Statement_under_CaptionLbl: Label '"  TDS Circle where Annual Return/Statement under "';
        Section_206_is_to_be_filedCaptionLbl: Label '"  Section 206 is to be filed"';
        PeriodCaptionLbl: Label 'Period';
        FromCaptionLbl: Label 'From';
        ToCaptionLbl: Label 'To';
        Assessment_YearCaptionLbl: Label 'Assessment Year';
        EmptyStringCaption_Control1102152051Lbl: Label ':';
        EmptyStringCaption_Control1102152053Lbl: Label ':';
        EmptyStringCaption_Control1102152054Lbl: Label ':';
        EmptyStringCaption_Control1102152055Lbl: Label ':';
        EmptyStringCaption_Control1102152056Lbl: Label ':';
        EmptyStringCaption_Control1102152057Lbl: Label ':';
        EmptyStringCaption_Control1102152058Lbl: Label ':';
        EmptyStringCaption_Control1102152059Lbl: Label ':';
        EmptyStringCaption_Control1102152060Lbl: Label ':';
        EmptyStringCaption_Control1102152061Lbl: Label ':';
        EmptyStringCaption_Control1102152062Lbl: Label ':';
        EmptyStringCaption_Control1102152063Lbl: Label ':';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        V5__Aggregate_of_4__a__and__b_CaptionLbl: Label '"  5. Aggregate of 4 (a) and (b)"';
        a__Entertainment_allowanceCaptionLbl: Label '"      (a) Entertainment allowance"';
        b__Tax_on_EmploymentCaptionLbl: Label '"      (b) Tax on Employment"';
        V4__DEDUCTIONS__CaptionLbl: Label '"  4. DEDUCTIONS :"';
        V3__BALANCE_CaptionLbl: Label '"  3. BALANCE "';
        V2__Less___Allowance_to_the_extent_exempt_under_Section_10CaptionLbl: Label '"  2. Less : Allowance to the extent exempt under Section 10"';
        d__TotalCaptionLbl: Label '"   d) Total"';
        as_per_Form_No_12BA_CaptionLbl: Label '"      (as per Form No.12BA)"';
        c__Profits_in_lieu_of_salary_under_section_17_3___CaptionLbl: Label '"   c) Profits in lieu of salary under section 17(3)  "';
        b__Value_of_prequisites_u_s_17_2__as_per_Form_No_12BA__where_applicable_CaptionLbl: Label '"   b) Value of prequisites u/s 17(2)(as per Form No.12BA, where applicable)"';
        a__Salary_as_per_provisions_contained_in_Sec_17_1_CaptionLbl: Label '"   a) Salary as per provisions contained in Sec.17(1)"';
        V1__Gross_SalaryCaptionLbl: Label '"  1. Gross Salary"';
        V6__INCOME_CHARGEABLE_UNDER_THE_HEAD_SALARIESCaptionLbl: Label '"  6. INCOME CHARGEABLE UNDER THE HEAD SALARIES"';
        V7__Add___Any_other_income_reported_by_the_employeeCaptionLbl: Label '"  7. Add : Any other income reported by the employee"';
        V8__GROSS_TOTAL_INCOMECaptionLbl: Label '"  8. GROSS TOTAL INCOME"';
        DETAILS_OF_SALARY_PAID_AND_ANY_OTHER_INCOME_AND_TAX_DEDUCTEDCaptionLbl: Label '" DETAILS OF SALARY PAID AND ANY OTHER INCOME AND TAX DEDUCTED"';
        V10__Aggregate_of_deductible_amount_under_Chapter_VIACaptionLbl: Label '"  10. Aggregate of deductible amount under Chapter VIA"';
        V11__TOTAL_INCOMECaptionLbl: Label '"  11. TOTAL INCOME"';
        V12__TAX_ON_TOTAL_INCOME_CaptionLbl: Label '"  12. TAX ON TOTAL INCOME "';
        V13__SURCHARGE__ON_TAX_COMPUTED_AT_S_NO_12_CaptionLbl: Label '"  13. SURCHARGE (ON TAX COMPUTED AT S.NO.12)"';
        V14__EDUCATION_CESS__on_tax_at_S_NO_12___surcharge_at_S_NO_13_CaptionLbl: Label '"  14. EDUCATION CESS (on tax at S.NO.12 & surcharge at S.NO.13)"';
        V15__TAX_PAYABLECaptionLbl: Label '"  15. TAX PAYABLE"';
        V16__RELIEF_UNDER_Sec_89__attach_details_CaptionLbl: Label '"  16. RELIEF UNDER Sec 89 (attach details)"';
        V17__TAX_PAYABLECaptionLbl: Label '"  17. TAX PAYABLE"';
        V18__Less___a__Tax_deducted_at_source_under_section_192__1_CaptionLbl: Label '"  18. Less: (a) Tax deducted at source under section 192 (1)"';
        b__Tax_paid_by_the_Employer_on_behalf_of_the_EmployeeCaptionLbl: Label '"                  (b) Tax paid by the Employer on behalf of the Employee"';
        Under_section_192___1A_on_perquisitesCaptionLbl: Label '"  - Under section 192 ( 1A)on perquisites"';
        Under_Section_17__2_CaptionLbl: Label '"  - Under Section 17 (2)"';
        V19__TAX_PAYABLE_REFUNDABLECaptionLbl: Label '"  19. TAX PAYABLE/REFUNDABLE"';
        I_CaptionLbl: Label '"  I,"';
        do_here_by_certified_that_a_sum_of_CaptionLbl: Label '"  do here by certified that a sum of "';
        has_been_deductedLbl: Label '"  has been deducted at source and paid to the credit of the Central Government. I further certified that the information"';
        given_above_is_true_and_correct_based_on_the_book_of_Accounts___Documents_and_other_Available_records_CaptionLbl: Label '"  given above is true and correct based on the book of Accounts , Documents and other Available records."';
        DateCaptionLbl: Label '"  Date"';
        PlaceCaptionLbl: Label '"  Place"';
        EmptyStringCaption_Control1102154072Lbl: Label ':';
        EmptyStringCaption_Control1102154073Lbl: Label ':';
        Son_of_Do_ofCaptionLbl: Label 'Son of/Do of';
        Signature_of_the_person_responsible_for_deduction_of_taxCaptionLbl: Label 'Signature of the person responsible for deduction of tax';
        EmptyStringCaption_Control1102154095Lbl: Label '/-';
        working_in_capacity_ofCaptionLbl: Label 'working in capacity of';
        EmptyStringCaption_Control1102154108Lbl: Label ':';
        EmptyStringCaption_Control1102154109Lbl: Label ':';
        Full_NameCaptionLbl: Label '"  Full Name"';
        DesignationCaptionLbl: Label '"  Designation"';
        NAME_OF_BANK_AND_BRANCH_WHERE_TAX_DEPOSITEDCaptionLbl: Label '"  NAME OF BANK AND BRANCH WHERE TAX DEPOSITED"';
        Date_of_PaymentsCaptionLbl: Label 'Date of Payments';
        AmountCaptionLbl: Label 'Amount';
        MonthCaptionLbl: Label 'Month';
        AprilCaptionLbl: Label 'April';
        JuneCaptionLbl: Label 'June';
        AugustCaptionLbl: Label 'August';
        OctoberCaptionLbl: Label 'October';
        DecemberCaptionLbl: Label 'December';
        FebravaryCaptionLbl: Label 'Febravary';
        MarchCaptionLbl: Label 'March';
        MayCaptionLbl: Label 'May';
        JulyCaptionLbl: Label 'July';
        SepetemberCaptionLbl: Label 'Sepetember';
        NovamberCaptionLbl: Label 'Novamber';
        JanuavaryCaptionLbl: Label 'Januavary';
        DETAILS_OF_TAX_DEDUCTED_AND_DEPOSITED_INTO_CENTRAL_GOVERNMENT_ACCOUNTCaptionLbl: Label 'DETAILS OF TAX DEDUCTED AND DEPOSITED INTO CENTRAL GOVERNMENT ACCOUNT';
        Deductable_AmountCaptionLbl: Label 'Deductable Amount';
        Gross_AmountCaptionLbl: Label 'Gross Amount';
        V9__DEDUCTIONS_UNDER_CHAPTER_VIACaptionLbl: Label '"  9. DEDUCTIONS UNDER CHAPTER VIA"';
        Text001Txt: Label 'Company %1 dont have P.A.N No', Comment = '%1 = Name';
        Text002Txt: Label 'Company %1 dont have T.A.N No', Comment = '%1 = Name';
        Text003Txt: Label 'Employee %1 dont have P.A.N No.', Comment = '%1 = Name';
        VIATxt: Label 'VI-A';
        VITxt: Label 'VI';
}

