page 33001472 "Training Schedule Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Training Schedule Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Training Schedule Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Choose the Employee Number form drop down.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Shows the Employee Name.';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Choose the Department Code.';
                    ApplicationArea = all;
                }
                field("Division Code"; "Division Code")
                {
                    ToolTip = 'Select the Division Code.';
                    ApplicationArea = all;
                }
                
            }
        }
    }

    actions
    {
    }
}

