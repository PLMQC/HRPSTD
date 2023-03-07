report 33001240 "Bonus Slip B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Bonus Slip.rdl';
    Caption = 'Bonus Slip';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Bonus Adjust"; "Bonus Adjust B2B")
        {
            RequestFilterFields = Month, Year;
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(Bonus_Statement_for_the_Financial_year_ended_; 'Bonus Statement for the Financial year ended')
            {
            }
            column(Bonus_Adjust__Employee_Code_; "Employee Code")
            {
            }
            column(Bonus_Adjust__Employee_Name_; "Employee Name")
            {
            }
            column(Bonus_Adjust__Bonus_Exgratia_Amt_; "Bonus/Exgratia Amt")
            {
            }
            column(Bonus_Adjust__Net_Payable_; "Net Payable")
            {
            }
            column(Bonus_Adjust__Additional_Bonus_; "Additional Bonus")
            {
            }
            column(FORMAT__Income_Tax________; FORMAT('Income Tax ' + '%'))
            {
            }
            column(FORMAT__Net_Payable_____net_towards_bonus_and__has_been_credited_to_my_bank_account__; FORMAT("Net Payable") + ' net towards bonus and  has been credited to my bank account.')
            {
            }
            column(Bonus_Adjust__Employee_Code_Caption; FIELDCAPTION("Employee Code"))
            {
            }
            column(Bonus_Adjust__Employee_Name_Caption; FIELDCAPTION("Employee Name"))
            {
            }
            column(Amount_of_BonusCaption; Amount_of_BonusCaptionLbl)
            {
            }
            column(Deductions_Adjustment__Caption; Deductions_Adjustment__CaptionLbl)
            {
            }
            column(Interim_Advance_paymentCaption; Interim_Advance_paymentCaptionLbl)
            {
            }
            column(Loan_RecoveryCaption; Loan_RecoveryCaptionLbl)
            {
            }
            column(OthersCaption; OthersCaptionLbl)
            {
            }
            column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
            {
            }
            column(Net_BonusCaption; Net_BonusCaptionLbl)
            {
            }
            column(Additional_BonusCaption; Additional_BonusCaptionLbl)
            {
            }
            column(Rs_Caption; Rs_CaptionLbl)
            {
            }
            column(Rs_Caption_Control1102152027; Rs_Caption_Control1102152027Lbl)
            {
            }
            column(Received_from_Voith_Turbo_Private_Limited_Rs_Caption; Received_from_Voith_Turbo_Private_Limited_Rs_CaptionLbl)
            {
            }
            column(Employee_SignatureCaption; Employee_SignatureCaptionLbl)
            {
            }
            column(Note__applicable_for_members_who_are_entitled_to_exgratia_Caption; Note__applicable_for_members_who_are_entitled_to_exgratia_CaptionLbl)
            {
            }
            column(DataItem1102152036; The_bonus_mentionedLbl)
            {
            }
            column(DataItem1102152037; stands__If_due_toLbl)
            {
            }
            column(this_letter_should_be_considered_as_having_been_paid_in_full_or_in_part__against_such_liability_Caption; this_letter_should_be_considered_as_having_been_paid_in_full_or_in_part__against_such_liability_CaptionLbl)
            {
            }
            column(Bonus_Adjust_Month; Month)
            {
            }
            column(Bonus_Adjust_Year; Year)
            {
            }
            column(Bonus_Adjust_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                B2BEmpGRec.RESET();
                B2BEmpGRec.SETRANGE("No.", "Bonus Adjust"."Employee Code");
                if not B2BEmpGRec.FINDFIRST() then
                    CurrReport.SKIP();
            end;
        }
    }

    requestpage
    {
        Caption = 'Bonus Slip';

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
        B2BEmpGRec: Record "Employee B2B";

        Amount_of_BonusCaptionLbl: Label 'Amount of Bonus';
        Deductions_Adjustment__CaptionLbl: Label 'Deductions/Adjustment :';
        Interim_Advance_paymentCaptionLbl: Label 'Interim/Advance payment';
        Loan_RecoveryCaptionLbl: Label 'Loan Recovery';
        OthersCaptionLbl: Label 'Others';
        Total_DeductionsCaptionLbl: Label 'Total Deductions';
        Net_BonusCaptionLbl: Label 'Net Bonus';
        Additional_BonusCaptionLbl: Label 'Additional Bonus';
        Rs_CaptionLbl: Label 'Rs.';
        Rs_Caption_Control1102152027Lbl: Label 'Rs.';
        Received_from_Voith_Turbo_Private_Limited_Rs_CaptionLbl: Label 'Received from Voith Turbo Private Limited Rs.';
        Employee_SignatureCaptionLbl: Label 'Employee Signature';
        Note__applicable_for_members_who_are_entitled_to_exgratia_CaptionLbl: Label 'Note: applicable for members who are entitled to exgratia:';
        The_bonus_mentionedLbl: Label 'The bonus mentioned above includes, where and to the extent applicable, statutory bonus under the payment of Bonus act based on the Law as it presently';
        stands__If_due_toLbl: Label '"stands. If due to any changes in law, court judgement, becomes liable to pay any further amount as statutory bonus then the contractual bonus stated in "';
        this_letter_should_be_considered_as_having_been_paid_in_full_or_in_part__against_such_liability_CaptionLbl: Label 'this letter should be considered as having been paid in full or in part, against such liability.';
}

