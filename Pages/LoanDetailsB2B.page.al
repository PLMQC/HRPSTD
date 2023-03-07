page 33001247 "Loan Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Loan Details';
    Editable = false;
    PageType = List;
    SourceTable = "Loan Details B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Pay Date"; "Pay Date")
                {
                    ToolTip = 'Specifies th epay date in th eloand detaisl';
                    ApplicationArea = all;
                }
                field("Loan Amount"; "Loan Amount")
                {
                    ToolTip = 'Specifies the laon amount in the loan details';
                    ApplicationArea = all;
                }
                field(Interest; Interest)
                {
                    ToolTip = 'Specicies the interest on the loan in th eloan details';
                    ApplicationArea = all;
                }
                field(Principal; Principal)
                {
                    ToolTip = 'Specifies the principla amount of the loan in th eloan details';
                    ApplicationArea = all;
                }
                field("EMI Amount"; "EMI Amount")
                {
                    ToolTip = '"Specifies equall monthly installments in the loan details "';
                    ApplicationArea = all;
                }
                field("EMI Deducted"; "EMI Deducted")
                {
                    ToolTip = 'Specifies the equal montly installemnt dedcuted in the loan details';
                    ApplicationArea = all;
                }
                field("Lump Sum Payment"; "Lump Sum Payment")
                {
                    ToolTip = 'Specifies the lump sum paymnet made against the loan in th eloan details';
                    ApplicationArea = all;
                }
                field(Balance; Balance)
                {
                    ToolTip = 'Specifies the balnce loan amount in th eloan details';
                    ApplicationArea = all;
                }
                field("Balance (Base)"; "Balance (Base)")
                {
                    ToolTip = 'specifies the balance base amount in the loan details';
                    ApplicationArea = all;
                }
                field("Paid Month"; "Paid Month")
                {
                    ToolTip = '"specifes the loan month in the loan details "';
                    ApplicationArea = all;
                }
                field("Paid Year"; "Paid Year")
                {
                    ToolTip = 'Specifies the loan paid year in th eloan details';
                    ApplicationArea = all;
                }
                field("Repayment Month"; "Repayment Month")
                {
                    ToolTip = 'specifies the loan repayment month in the loan details';
                    ApplicationArea = all;
                }
                field("Repayment Year"; "Repayment Year")
                {
                    ToolTip = 'Specifies the loan repayment year in the loan details';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

