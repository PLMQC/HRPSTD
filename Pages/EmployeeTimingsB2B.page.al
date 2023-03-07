page 33001279 "Employee Timings B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Timings';
    PageType = Worksheet;
    SourceTable = "Employee Timings B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Date; Date)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the date as per the attendance calender';
                }
                field("Time In"; "Time In")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / Specify the Employee Time IN and Out';
                }
                field("Time Out"; "Time Out")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / Speify the Employee Time In and Out';
                }
                field("No.of Hours"; "No.of Hours")
                {
                    ApplicationArea = all;
                    ToolTip = 'Based on the In time and Out Time the Number of Hours are computed';
                }
            }
        }
    }

    actions
    {
    }
}

