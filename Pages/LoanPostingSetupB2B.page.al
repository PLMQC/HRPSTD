page 33001271 "Loan Posting Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Loan Posting Setup';
    Editable = true;
    PageType = Worksheet;
    SourceTable = "Loan Posting Groups B2B";
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Loan Code';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Loan code Description';
                }
                field("Loan Refundable Acc."; "Loan Refundable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
            }
        }
    }

    actions
    {
    }
}

