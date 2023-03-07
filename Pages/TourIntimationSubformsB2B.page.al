page 33001516 "Tour Intimation Subforms B2B"
{
    // version B2BHR1.00.00

    Caption = 'Tour Intimation Subform Show';
    DelayedInsert = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Attendance Lines B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {

                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee code';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee name';
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Starting Date';
                }
                field("Worked Shift"; "Worked Shift")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Worked Shift';
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Start Time';
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the End time';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetEmployeeOnDuty();
    begin
        InsertEmployeeOnDuty1();
    end;
}

