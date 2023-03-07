page 33001232 "Monthly Attendance List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Monthly Attendance List';
    CardPageID = "Monthly Attendance B2B";
    DelayedInsert = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Monthly Attendance B2B";
    UsageCategory = Lists;
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
                    ToolTip = 'Specicfies the Employee Code ';
                }
                field(Year; Year)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Payroll Year';
                }
                field("Pay Slip Month"; "Pay Slip Month")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Payslip Month';
                }
                field(Days; Days)
                {
                    Caption = 'No.of Days';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the No.Of Days in Monthly Attendance list';
                }
                field("Weekly Off"; "Weekly Off")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Weekly Off Details in Monthly Attendance';
                }
                field("Gross Salary"; "Gross Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Gross Salary in Monthly Attendance';
                }
                field(Deductions; Deductions)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Salary Deduction Details';
                }
                field("Net Salary"; "Net Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Net Salary Details in Monthly Attendance';
                }
                field(Attendance; Attendance)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Attendance Details in Month';
                }
                field("Over Time Hrs"; "Over Time Hrs")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Over Time Hrs';
                }
                field(Holidays; Holidays)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Holidays in Monthly Attendance';
                }
                field("Loss Of Pay"; "Loss Of Pay")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Loss Of Pay in Monthly Attendance';
                }
                field(Process; Process)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Salary Process Details in Monthly Attendance';
                }
                field(Processed; Processed)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Processed Salary in Monthly Attendance';
                }
                field("Processing Date"; "Processing Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Salary Processing Date in Monthly Attendance';
                }
                field(Posted; Posted)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Posted details in Monthly Attendance';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Posting Date in Monthly Attendance';
                }
                field("No G/L Posting"; "No G/L Posting")
                {
                    Caption = 'Outsourced Employee';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Outsourced Employee in Monthly Attendance';

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
    end;

    var

        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
}

