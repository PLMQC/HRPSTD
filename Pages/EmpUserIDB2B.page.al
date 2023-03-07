page 33001289 "Emp User ID B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp User ID';
    Editable = false;
    PageType = Worksheet;
    SourceTable = User;
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("User Name"; "User Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee user id in employee master';
                }
                field("Full Name"; "Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the full name';
                }
            }
        }
    }

    actions
    {
    }
}

