page 33001550 "Categories B2B"
{
    // version B2BHR1.00.00

    Caption = 'Categories';
    PageType = List;
    SourceTable = Category_B2B;
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the group details';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the description';
                }
            }
        }
    }

    actions
    {
    }
}

