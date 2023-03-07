page 33001371 "Emp Leave List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Leaves List';
    Editable = false;
    PageType = List;
    SourceTable = "Employee Leaves B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee NO';
                }
                field("Employee Name"; "Employee Name")
                {
                    DrillDown = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee name';
                }
                field("Leave Pay Cadre"; "Leave Pay Cadre")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave pay cadre details';
                }
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave code';
                }
                field("No. of Available Leaves"; "No. of Available Leaves")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the no of available leave details';
                }
            }
        }
    }

    actions
    {
    }
}

