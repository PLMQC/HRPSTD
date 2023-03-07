page 33001336 "Bonus Dimensions B2B"
{
    // version B2BHR1.00.00

    Caption = 'Bonus Dimensions';
    PageType = Worksheet;
    SourceTable = "Bonus Dimensions B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Dimension Code"; "Dimension Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Dimension Code Applicable';
                }
                field("Dimension Value Code"; "Dimension Value Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Dimension Code Applicable';
                }
            }
        }
    }

    actions
    {
    }
}

