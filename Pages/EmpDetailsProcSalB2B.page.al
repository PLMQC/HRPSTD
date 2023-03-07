page 33001291 "EmpDetails ProcSal B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Details_Proc. Salary';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Processed Salary B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Add/Deduct Code"; "Add/Deduct Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Add/Deduct Payelement code assigned to the employee';
                }
                field(Attendance; Attendance)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Attendance number of days towards the employee';
                }
                field("Add/Deduct"; "Add/Deduct")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Addition / Deduction Payelement code assigned to the employee';
                }
                field("Computation Type"; "Computation Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Computation Type e.g.On Attendance, Non Attendance, Afer Basic and After Basic & DA';
                }
                field("Earned Amount"; "Earned Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Earner amount with type of Add/Deduct Payelement net value assigned to the employee';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetEmp(month: Integer; year: Integer; "code": Code[20]);
    begin
        RESET();
        SETRANGE("Employee Code", code);
        SETRANGE("Pay Slip Month", month);
        SETRANGE(Year, year);
        CurrPage.UPDATE(false);
    end;
}

