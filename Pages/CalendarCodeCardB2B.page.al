page 33001354 "Calendar Code Card B2B"
{
    // version B2BHR1.00.00

    Caption = 'Calendar Code Card';
    PageType = List;
    SourceTable = "Calendar Code B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the calendar details';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the calendar description';
                }
            }
        }
    }

    actions
    {
    }
}

