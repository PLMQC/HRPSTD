page 33001505 "Attendance Lines List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Attendance Lines List';
    Editable = false;
    PageType = List;
    SourceTable = "Attendance Lines B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Employee code';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Employee Name';
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Month';
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Year';
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Starting Date';
                }

                field("Worked Shift"; "Worked Shift")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Worked shift';
                }
                field("LOP Period"; "LOP Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Lop Period';
                }
            }
        }
    }

    actions
    {
    }
}

