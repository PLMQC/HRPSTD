page 33001284 "Saction Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Saction Details';
    PageType = Worksheet;
    SourceTable = "Leave Sanction Details B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Employee Code"; "Employee Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee code details  in leave sanction application';
                }
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave code  details  in leave sanction application';
                }
                field("From Date"; "From Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave sanction from date  details  in leave sanction  application';
                }
                field("To Date"; "To Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave sanctiondetails  in leave sanction application';
                }
                field("Sanctioned By"; "Sanctioned By")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave sanctioned  hierarchy details  in leave sanction application';
                }
                field("Date of Sanction"; "Date of Sanction")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave date of sanction details  in leave sanction application';
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave remarks details  in leave sanction application';
                }
            }
        }
    }

    actions
    {
    }
}

