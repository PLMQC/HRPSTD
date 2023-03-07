page 33001343 "Tour Intimation Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'Tour Intimation Subform';
    DelayedInsert = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Attendance Lines B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Document Type"; "Document Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee document type degtails in Tour intimation';

                }
                field("Document No."; "Document No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee document no degtails in Tour intimation';
                }
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee code in Tour intimation';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee name in Tour intimation';
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee start date in Tour intimation';
                }
                field("Worked Shift"; "Worked Shift")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee worked shift details  in Tour intimation';
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee start btime  in Tour intimation';
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee end time in Tour intimation';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        if Status = Status::" " then
            CurrPage.EDITABLE := true
        else
            CurrPage.EDITABLE := false;
    end;

    procedure GetEmployeeOnDuty();
    begin
        InsertEmployeeOnDuty1();
    end;
}

