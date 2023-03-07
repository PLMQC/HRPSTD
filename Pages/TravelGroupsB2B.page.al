page 33001553 "Travel Groups B2B"
{
    // version B2BHR1.00.00

    Caption = 'Travel Groups';
    PageType = List;
    SourceTable = "Travel Groups B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Category; Category)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the category in group';
                }
                field("City Type"; "City Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the city type details';
                }
                field(Component; Component)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the component details';
                }
                field("Mode of Transport"; "Mode of Transport")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the mode of transport details';
                }
                field(Limits; Limits)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the budget limits';
                }
                field(UOM; UOM)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the UOM details';
                }
                field(Actuals; Actuals)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the actuals details';
                }
            }
        }
    }

    actions
    {
    }
}

