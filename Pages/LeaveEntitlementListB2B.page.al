page 33001236 "Leave Entitlement List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Entitlement List';
    CardPageID = "Leave Entitlement B2B";
    Editable = true;
    PageType = List;
    SourceTable = "Leave Entitlement B2B";
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave code';
                }
                field("No.of Leaves"; "No.of Leaves")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The no of leaves';
                }
                field(Month; Month)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The month';
                }
                field(Year; Year)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The year';
                }
                field("Leaves Carried"; "Leaves Carried")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave carried';
                }
                field("Total Leaves"; "Total Leaves")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The total leaves';
                }
                field("Leaves taken during Month"; "Leaves taken during Month")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leaves taken during month';
                }
                field("Leave Bal. at the Month End"; "Leave Bal. at the Month End")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave bal at the end of the month';
                }
                field("Leaves Expired"; "Leaves Expired")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leaves expired';
                }
                field("Opening Balance"; "Opening Balance")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The opening balance';
                }
            }
        }
    }

    actions
    {
    }
}

