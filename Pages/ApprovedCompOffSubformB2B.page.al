page 33001547 "Approved CompOff Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'Approved CompOff Subform';
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
                field("Document Type"; "Document Type")
                {
                    ToolTip = 'Choose the Document type.';
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Choose the Document No.';
                    ApplicationArea = all;
                }
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Displays the Employee name of selected Employee no.';
                    ApplicationArea = all;
                }
                field("Worked Shift"; "Worked Shift")
                {
                    ToolTip = 'Shift worked by the Employee.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Select the Date worked on non working date.';
                    Caption = 'Date Worked';
                    ApplicationArea = all;
                }
                field("Comp Off Date"; "Comp Off Date")
                {
                    ToolTip = 'Choose the Comp off date on which Comp off is utilized.';
                    ApplicationArea = all;
                }
                field("Start Time"; "Start Time")
                {
                    ToolTip = 'Choose the start time of employee worked.';
                    ApplicationArea = all;
                }
                field("End Time"; "End Time")
                {
                    ToolTip = 'Choose the End time of employee worked.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

