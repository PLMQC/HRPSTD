page 33001268 "Payroll Product Post Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Product Posting Group';
    PageType = Worksheet;
    SourceTable = "Payroll Prod. Post. Group B2B";
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip='Define the pay elements codes which are created as Pay elements';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip='Define the Description is picked from the Pay element Code';
                }
            }
        }
    }

    actions
    {
    }
}

