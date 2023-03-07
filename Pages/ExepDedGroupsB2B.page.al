page 33001353 "Exep/Ded Groups B2B"
{
    // version B2BHR1.00.00

    Caption = 'Exemption/Deduction Groups';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Exep/Ded Groups B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Exemp / Ded Group Id"; "Exemp / Ded Group Id")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax exemp/ded group id details';
                }
                field("Section ID"; "Section ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax section id details';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax description ';
                }
                field("Pay Element Code"; "Pay Element Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the pay element code details';
                }
            }
        }
    }

    actions
    {
    }
}

