page 33001267 "Payroll Bus. Posting Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Business Posting Group';
    PageType = Worksheet;
    SourceTable = "Payroll Bus. Post Group B2B";
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
                    ToolTip = 'Define the Applicable code e.g. Staff, Workmen etc';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the applicable Names to the define Codes e.g. Staff, Workmen';

                }
            }
        }
    }

    actions
    {
    }
}

