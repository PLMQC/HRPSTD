page 33001355 "Calendar Code List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Calendar Code List';
    CardPageID = "Calendar Code Card B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Calendar Code B2B";
    UsageCategory = Lists;
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
                    ToolTip = 'Specifies the payroll calendar details';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payroll calendar description';
                }
            }
        }
    }

    actions
    {
    }
}

