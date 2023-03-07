page 33001338 "Payroll Location User List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Location User List';
    CardPageID = "Payroll Location Users B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Location Users B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the User ID as per list displayed';
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the User Name as per User ID refer to user list displayed';
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Location Code applicable';
                }
                field("Multiple Locations"; "Multiple Locations")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the User ID if authorized for More Location';
                }
            }
        }
    }

    actions
    {
    }
}

