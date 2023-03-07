page 33001337 "Payroll Location Users B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Location Users';
    DelayedInsert = true;
    Editable = true;
    PageType = Card;
    SourceTable = "Payroll Location Users B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(DailyAttendance)
            {
                Caption = 'Location Users';
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the User ID as per list displayed';
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the User ID and Name as per list displayed';
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Loction code';
                }
                field("Multiple Locations"; "Multiple Locations")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the User Location Code ID as per list displayed';
                }
            }
        }
    }

    actions
    {
    }
}

