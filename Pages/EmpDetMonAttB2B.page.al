page 33001292 "EmpDet MonAtt B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Details_Mon. Attend.';
    DelayedInsert = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Monthly Attendance B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Days; Days)
                {
                    Caption = 'No.of Days';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the No. of days in a processed month';
                }
                field("Weekly Off"; "Weekly Off")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Weekly off details';
                }
                field("Gross Salary"; "Gross Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Gross Salary (Add/Deduct Payelement) value computed to a employee';
                }
                field(Deductions; Deductions)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Deducttion value computed towards a employee';
                }
                field("Net Salary"; "Net Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Net Salary computed after (Add/Deduct) towards a employee';
                }
                field(Attendance; Attendance)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the attendance';
                }
                field("Over Time Hrs"; "Over Time Hrs")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Overtime Hours computed towards a employee';
                }
                field(Holidays; Holidays)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Holidays available towards a employee';
                }
                field("Loss Of Pay"; "Loss Of Pay")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Loss of Pays days towards a employee';
                }
            }
        }
    }

    actions
    {
    }

    var

    procedure GetEmp(Month: Integer; Year: Integer; EmpCode: Code[20]);
    begin
        RESET();
        SETRANGE("Employee Code", EmpCode);
        SETRANGE("Pay Slip Month", Month);
        SETRANGE(Year, Year);
        CurrPage.UPDATE(false);
    end;
}

