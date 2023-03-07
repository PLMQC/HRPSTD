page 33001386 "Provisional Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Provisional Leaves';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "Provisional Leaves B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee Number.';
                    ApplicationArea = all;
                }
                field("Leave Code"; "Leave Code")
                {
                    ToolTip = 'Specifies the Leave code.';
                    ApplicationArea = all;
                }
                field("Remaining Leaves"; "Remaining Leaves")
                {
                    ToolTip = 'Specfies the Remaning leaves of the employee.';
                    Caption = '" Leaves"';
                    ApplicationArea = all;
                }
                field("Period Start Date"; "Period Start Date")
                {
                    ToolTip = 'Specifies the period start date.';
                    ApplicationArea = all;
                }
                field("Period End Date"; "Period End Date")
                {
                    ToolTip = 'Specifies the period End date.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

