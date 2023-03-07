page 33001397 "Shiftwise Offdays B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shiftwise Offdays';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Shiftwise Offday B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field(Day; Day)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the day details';

                }
                field("Weekly Off"; "Weekly Off")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the weekly off details';
                }
                field("Week No."; "Week No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the week no details';
                }
            }
        }
    }

    actions
    {
    }
}

