page 33001555 "Travel Posting Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Travel Posting Setup';
    PageType = List;
    SourceTable = "Travel Posting Setup B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Components; Components)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the components in group';
                }
                field("Posting Account"; "Posting Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the posting account details';
                }
            }
        }
    }

    actions
    {
    }
}

