page 33001551 "Cities Types B2B"
{
    // version B2BHR1.00.00

    Caption = 'Cities Types';
    PageType = List;
    SourceTable = "Cities Type B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Type; Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the group details';
                }
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the code details';
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

