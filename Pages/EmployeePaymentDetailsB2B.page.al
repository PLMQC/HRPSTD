page 33001275 "Employee Payment Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Payment Details';
    DelayedInsert = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = Worksheet;
    RefreshOnActivate = true;
    SourceTable = "Monthly Attendance B2B";
    UsageCategory = Tasks;
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
                    ToolTip = 'Define / map  the applicable Employee code to whom the payment needs to be initiated';
                }
                field(Year; Year)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Define the payroll processed year for payment to be made.';
                }
                field("Pay Slip Month"; "Pay Slip Month")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Define payroll processed month for which the payment needs to be posted.';
                }
                field("Gross Salary"; "Gross Salary")
                {
                    ApplicationArea = all;
                    ToolTip = ' The field dispalys the gross salary computed for the processed month and Year';
                }
                field(Deductions; Deductions)
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displays the total sum of Payroll components with Type Deduction';
                }
                field("Net Salary"; "Net Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'The field discplays the Net Salary to be paid';
                }
                field("Paid Amount"; "Paid Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'The field  displays the Amount to be paid';
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Remaining amount if any which needs to be paid is shown. If Paid the value would be zero';
                }
            }
        }
    }

    actions
    {
    }

    var

}

