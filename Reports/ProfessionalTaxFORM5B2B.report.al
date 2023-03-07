report 33001212 "Professional Tax FORM 5 B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Professional Tax FORM 5.rdlc';
    Caption = 'Professional Tax FORM 5';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Professional Tax Line"; "Professional Tax Line B2B")
        {
            DataItemTableView = SORTING("Branch Code", "Effective Date", "Line No.");
            column(Branch; BranchGVar)
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(CompanyAdd1; CompanyAdd1)
            {
            }
            column(CompanyAdd2; CompanyAdd2)
            {
            }
            column(MonthName; MonthNameGVar)
            {
            }
            column(Professional_Tax_Line_Year; Year)
            {
            }
            column(SLNO; SLNO)
            {
            }
            column(Professional_Tax_Line__Income_From_; "Income From")
            {
            }
            column(Professional_Tax_Line__Income_To_; "Income To")
            {
            }
            column(NoOfEmp; NoOfEmp)
            {
            }
            column(TaxPaid; TaxPaid)
            {
            }
            column(Professional_Tax_Line__Tax_Amount_; "Tax Amount")
            {
            }
            column(TotalTaxPaid; TotalTaxPaid)
            {
            }
            column(InterestPaid; InterestPaid)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(ChequeDate; ChequeDate)
            {
            }
            column(BankName; BankName)
            {
            }
            column(FORM_5Caption; FORM_5CaptionLbl)
            {
            }
            column(See_Rule_11_A_Caption; See_Rule_11_A_CaptionLbl)
            {
            }
            column(RETURN_OF_TAX_PAYABLE_BY_EMPLOYER_UNDER_SUB_SECTION_1__OF_SECTION_6A_OFCaption; RETURN_OF_TAX_PAYABLE_BY_EMPLOYER_UNDER_SUB_SECTION_1__OF_SECTION_6A_OFCaptionLbl)
            {
            }
            column(TRADE__CALLINGS_AND_EMPLOYEMENTCaption; TRADE__CALLINGS_AND_EMPLOYEMENTCaptionLbl)
            {
            }
            column(TAX_ON_PROFFESSIONALSCaption; TAX_ON_PROFFESSIONALSCaptionLbl)
            {
            }
            column(Amount_of_tax_deductedCaption; Amount_of_tax_deductedCaptionLbl)
            {
            }
            column(No__of_employees_during_the_month_in_respect_of_whom_the_tax_is_payable_is_as_underCaption; No__of_employees_during_the_month_in_respect_of_whom_the_tax_is_payable_is_as_underCaptionLbl)
            {
            }
            column(P_T_O_Circle_No_Caption; P_T_O_Circle_No_CaptionLbl)
            {
            }
            column(Rate_of_tax_per_monthCaption; Rate_of_tax_per_monthCaptionLbl)
            {
            }
            column(Certificate_No_Caption; Certificate_No_CaptionLbl)
            {
            }
            column(Return_on_tax_payable_for_the_month_endingCaption; Return_on_tax_payable_for_the_month_endingCaptionLbl)
            {
            }
            column(No__of_employeesCaption; No__of_employeesCaptionLbl)
            {
            }
            column(Employees_whose_monthly_salaries_or_wages_or_both_areCaption; Employees_whose_monthly_salaries_or_wages_or_both_areCaptionLbl)
            {
            }
            column(Name_of_the_employerCaption; Name_of_the_employerCaptionLbl)
            {
            }
            column(AddressCaption; AddressCaptionLbl)
            {
            }
            column(SL_o_Caption; SL_o_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            column(DataItem1102152040; Add_simple_interestLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Amount_paid_under_challan_No___Cheque_No_Caption; Amount_paid_under_challan_No___Cheque_No_CaptionLbl)
            {
            }
            column(DatedCaption; DatedCaptionLbl)
            {
            }
            column(Name_of_the_BankCaption; Name_of_the_BankCaptionLbl)
            {
            }
            column(DataItem1102152047; I_certify_thatLbl)
            {
            }
            column(DataItem1102152048; I_also_certify_thatLbl)
            {
            }
            column(I__ShriCaption; I__ShriCaptionLbl)
            {
            }
            column(solemnly_declare_that_the_above_statements_are_true_to_the_best_of_my_knowledge_and_belief_Caption; solemnly_declare_that_the_above_statements_are_true_to_the_best_of_my_knowledge_and_belief_CaptionLbl)
            {
            }
            column(Place__Caption; Place__CaptionLbl)
            {
            }
            column(Dated__Caption; Dated__CaptionLbl)
            {
            }
            column(SignatureCaption; SignatureCaptionLbl)
            {
            }
            column(FOR_OFFICIAL_USE__Caption; FOR_OFFICIAL_USE__CaptionLbl)
            {
            }
            column(The_return_is_accepted_on_verificationCaption; The_return_is_accepted_on_verificationCaptionLbl)
            {
            }
            column(Tax_assessedCaption; Tax_assessedCaptionLbl)
            {
            }
            column(Tax_PaidCaption; Tax_PaidCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(Rs__________________Caption; Rs__________________CaptionLbl)
            {
            }
            column(Rs__________________Caption_Control1000000007; Rs__________________Caption_Control1000000007Lbl)
            {
            }
            column(Rs__________________Caption_Control1000000008; Rs__________________Caption_Control1000000008Lbl)
            {
            }
            column(Assessing_AuthorityCaption; Assessing_AuthorityCaptionLbl)
            {
            }
            column(Professional_Tax_Line_Branch_Code; "Branch Code")
            {
            }
            column(Professional_Tax_Line_Effective_Date; "Effective Date")
            {
            }
            column(Professional_Tax_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                NoOfEmp := 0;
                MonthlyAttend.RESET();
                MonthlyAttend.SETRANGE("Pay Slip Month", MonthNo);
                MonthlyAttend.SETRANGE(Year, FyearGVar);
                if MonthlyAttend.FINDFIRST() then
                    repeat
                        MonthlyAttend.CALCFIELDS("Gross Salary");
                        employee.GET(MonthlyAttend."Employee Code");
                        if (employee."PT Branch Code" = BranchGVar) and (employee."PT Applicable") then
                            if (MonthlyAttend."Gross Salary" >= "Professional Tax Line"."Income From") and (MonthlyAttend."Gross Salary" <= "Professional Tax Line"."Income To") then
                                NoOfEmp := NoOfEmp + 1;
                    until MonthlyAttend.NEXT() = 0;

                SLNO := SLNO + 1;
                TaxPaid := NoOfEmp * "Tax Amount";
                TotalTaxPaid := TotalTaxPaid + TaxPaid;
                GrandTotal := GrandTotal + TotalTaxPaid;
            end;

            trigger OnPreDataItem();
            begin
                "Professional Tax Line".SETRANGE("Branch Code", BranchGVar);
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
                    field(Branch; BranchGVar)
                    {
                        ToolTip = 'Choose the Branch code for which report need to generate.';
                        Caption = 'Branch Code';
                        ApplicationArea = all;

                        trigger OnLookup(Var Text: Text): Boolean;
                        begin
                            if PAGE.RUNMODAL(33001255, PTH) = ACTION::LookupOK then
                                BranchGVar := PTH."Branch Code";
                        end;
                    }
                    field(MonthName; MonthNameGVar)
                    {
                        ToolTip = 'Choose the month from the drop down';
                        Caption = 'Month';
                        OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
                        ApplicationArea = all;
                    }
                    field(Fyear; FyearGVar)
                    {
                        ToolTip = 'Enter the Year for report is generate';
                        Caption = 'Year';
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

    trigger OnPreReport();
    begin
        CompanyInfo.RESET();
        CompanyInfo.FINDFIRST();
        CompanyAdd1 := CompanyInfo.Address + CompanyInfo."Address 2";
        CompanyAdd2 := CompanyInfo.City + CompanyInfo."Post Code";

        case MonthNameGVar of
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
        CompanyInfo: Record "Company Information";
        PTH: Record "Professional Tax Header B2B";
        MonthlyAttend: Record "Monthly Attendance B2B";
        employee: Record "Employee B2B";
        SLNO: Integer;
        TotalTaxPaid: Decimal;
        TaxPaid: Decimal;
        NoOfEmp: Integer;
        InterestPaid: Decimal;
        GrandTotal: Decimal;
        ChequeNo: Text[30];
        ChequeDate: Date;
        BankName: Text[30];
        BranchGVar: Code[20];
        MonthNameGVar: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        MonthNo: Integer;
        FyearGVar: Integer;
        CompanyAdd1: Text[250];
        CompanyAdd2: Text[250];
        FORM_5CaptionLbl: Label 'FORM 5';
        See_Rule_11_A_CaptionLbl: Label '[See Rule 11 A]';
        RETURN_OF_TAX_PAYABLE_BY_EMPLOYER_UNDER_SUB_SECTION_1__OF_SECTION_6A_OFCaptionLbl: Label 'RETURN OF TAX PAYABLE BY EMPLOYER UNDER SUB-SECTION(1) OF SECTION 6A OF';
        TRADE__CALLINGS_AND_EMPLOYEMENTCaptionLbl: Label 'TRADE, CALLINGS AND EMPLOYEMENT';
        TAX_ON_PROFFESSIONALSCaptionLbl: Label 'TAX ON PROFFESSIONALS';
        Amount_of_tax_deductedCaptionLbl: Label 'Amount of tax deducted';
        No__of_employees_during_the_month_in_respect_of_whom_the_tax_is_payable_is_as_underCaptionLbl: Label 'No. of employees during the month in respect of whom the tax is payable is as under';
        P_T_O_Circle_No_CaptionLbl: Label 'P.T.O Circle No.';
        Rate_of_tax_per_monthCaptionLbl: Label 'Rate of tax per month';
        Certificate_No_CaptionLbl: Label 'Certificate No.';
        Return_on_tax_payable_for_the_month_endingCaptionLbl: Label 'Return on tax payable for the month ending';
        No__of_employeesCaptionLbl: Label 'No. of employees';
        Employees_whose_monthly_salaries_or_wages_or_both_areCaptionLbl: Label 'Employees whose monthly salaries or wages or both are';
        Name_of_the_employerCaptionLbl: Label 'Name of the employer';
        AddressCaptionLbl: Label 'Address';
        SL_o_CaptionLbl: Label 'SL No.';
        TotalCaptionLbl: Label 'Total';
        Add_simple_interestLbl: Label 'Add simple interest payable ( if any ) on the above amount at two percent per month or part thereof ( vide section II [2] of the Act)';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        Amount_paid_under_challan_No___Cheque_No_CaptionLbl: Label 'Amount paid under challan No./ Cheque No.';
        DatedCaptionLbl: Label 'Dated';
        Name_of_the_BankCaptionLbl: Label 'Name of the Bank';
        I_certify_thatLbl: Label 'I certify that all the employees who are laible to pay tax in my employment during the period of return have been covered in the foregoing particulars.';
        I_also_certify_thatLbl: Label '" I also certify that the necessary revision in the amount of tax deductabule from the salary or wages of the employees on account of variation in the salary or wages earned by them has been made where necessary."';
        I__ShriCaptionLbl: Label 'I, Shri';
        solemnly_declare_that_the_above_statements_are_true_to_the_best_of_my_knowledge_and_belief_CaptionLbl: Label 'solemnly declare that the above statements are true to the best of my knowledge and belief.';
        Place__CaptionLbl: Label 'Place :';
        Dated__CaptionLbl: Label 'Dated :';
        SignatureCaptionLbl: Label 'Signature';
        FOR_OFFICIAL_USE__CaptionLbl: Label '( FOR OFFICIAL USE )';
        The_return_is_accepted_on_verificationCaptionLbl: Label 'The return is accepted on verification';
        Tax_assessedCaptionLbl: Label 'Tax assessed';
        Tax_PaidCaptionLbl: Label 'Tax Paid';
        BalanceCaptionLbl: Label 'Balance';
        Rs__________________CaptionLbl: Label 'Rs..................';
        Rs__________________Caption_Control1000000007Lbl: Label 'Rs..................';
        Rs__________________Caption_Control1000000008Lbl: Label 'Rs..................';
        Assessing_AuthorityCaptionLbl: Label 'Assessing Authority';
}

