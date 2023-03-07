page 33001281 "Loan Repayment List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Loan Repayment List';
    CardPageID = "Loan Repayment B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Loan Repayments B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Loan Id"; "Loan Id")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies employee loan id  in loan master';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee loan amount  in loan master';
                }
                field("Payment Date"; "Payment Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee loan repayemnt date details';
                }
                field("Loan Repayment Type"; "Loan Repayment Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee loan repayment type details  in loan master';
                }
                field(Paid; Paid)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies employee loan piad details  in loan master';
                }
            }
        }
    }

    actions
    {
    }
}

