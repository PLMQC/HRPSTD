page 33001376 "User List B2B"
{
    // version B2BHR1.00.00

    Caption = 'User List';
    //CardPageID = 59;
    Editable = false;
    PageType = List;
    SourceTable = User;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152002)
            {
                field("User Name"; "User Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the user name';
                }
                field("Full Name"; "Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the full name';
                }
            }
        }
    }

    actions
    {
    }
}

