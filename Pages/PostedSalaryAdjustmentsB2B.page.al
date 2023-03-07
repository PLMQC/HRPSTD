page 33001368 "Posted Salary Adjustments B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Salary Adjustments';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "Posted Salary Adjustments B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee No';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifi the Employee Name';
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Month';
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the year';
                }
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the account type';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Amount';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Posting Date';
                }
 
           }
        }
    }

    actions
    {
    }
}

