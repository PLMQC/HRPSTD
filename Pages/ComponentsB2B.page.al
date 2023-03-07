page 33001552 "Components B2B"
{
    // version B2BHR1.00.00

    Caption = 'Components';
    PageType = List;
    SourceTable = "Components B2B";
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
                    ToolTip = 'Specify the code in group';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the description';
                }
                field(Transport; Transport)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the transport details';
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the active status';
                }
            }
        }
    }

    actions
    {
    }
}

