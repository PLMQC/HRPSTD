page 33001269 "Payroll General Post Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll General Posting Group';
    PageType = Worksheet;
    SourceTable = "Payroll Gen. Posting Group B2B";
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Payroll Bus. Posting Group"; "Payroll Bus. Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Applicable Payroll Business Posting group';
                }
                field("Payroll Prod. Posting Group"; "Payroll Prod. Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Applicable Payroll Product Posting group defined towards the pay element';
                }
                field("G/L Code"; "G/L Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the applicable General Ledger from Chart of Accounts and map the same to Payroll prod. posting group';
                }
            }
        }
    }

    actions
    {
    }
}

