page 33001522 "Approved TourInt Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'Appr. Tour Intimation Subform';
    DelayedInsert = true;
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
                    ToolTip = 'Select the Document Type.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Select the Document No.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Shows the Employee No.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Shows the Employee Name.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Enter the Tour Start date.';
                    ApplicationArea = all;
                }
                field("Worked Shift"; "Worked Shift")
                {
                    ToolTip = 'Shows the Employee Worked Shift during the Tour.';
                    ApplicationArea = all;
                }
                field("Start Time"; "Start Time")
                {
                    ToolTip = 'Shows the work Start Time of the Employee.';
                    ApplicationArea = all;
                }
                field("End Time"; "End Time")
                {
                    ToolTip = 'Shows the End time of Work done by employee.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

