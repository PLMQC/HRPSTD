page 33001461 "Surcharge Tax List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Surcharge Tax List';
    CardPageID = "Surcharge Tax B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Surcharge Tax Header B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Branch Code"; "Branch Code")
                {
                    ToolTip = 'Specifies the Branch code.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the Description.';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specifies the Effective date.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

