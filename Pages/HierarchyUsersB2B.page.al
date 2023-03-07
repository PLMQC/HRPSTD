page 33001398 "Hierarchy Users B2B"
{
    // version B2BHR1.00.00

    Caption = 'Hierarchy Users';
    Editable = false;
    PageType = List;
    SourceTable = User;
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("User Name"; "User Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the hierarchy user name';
                }
            }
        }
    }

    actions
    {
    }
}

