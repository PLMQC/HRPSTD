page 33001545 "Shift Schedule List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shift Schedule List';
    CardPageID = "Shift Shedule B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Shift Schedule Header B2B";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater("<Control1900000001>")
            {
                field("No."; "No.")
                {
                    ToolTip = 'Choose the Shift Code.';
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ToolTip = 'Choose the Department of the Shift.';
                    ApplicationArea = all;
                }
                field("Current Shift"; "Current Shift")
                {
                    ToolTip = 'Current shift of the Employee.';
                    ApplicationArea = all;
                }
                field("Revised Shift"; "Revised Shift")
                {
                    ToolTip = 'Revised Shift of the employee';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Revised shift starts from';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

