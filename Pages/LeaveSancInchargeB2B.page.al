page 33001283 "Leave Sanc. Incharge B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Sanction Incharge';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Leave Sanc. Incharge B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Sanctioning Incharge"; "Sanctioning Incharge")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee leave sanctioning user details  in leave application';
                }
                field(Hierarchy; Hierarchy)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave sanction hierarchy details  in leave application';
                }
            }
        }
    }

    actions
    {
    }
}

