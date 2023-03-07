page 33001477 "Emp Training Need Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp Training Need Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Emp. Train Need Iden. Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Choose the Employee Number.';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Type of Training"; "Type of Training")
                {
                    ToolTip = 'Specifies the Type of Training to be given.';
                    ApplicationArea = all;
                }
                field("Training Topic"; "Training Topic")
                {
                    ToolTip = 'Choose the Employee Training Topic to given.';
                    ApplicationArea = all;
                }
                field(Impact; Impact)
                {
                    ToolTip = 'Specifies the Impact of Training.';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Enter the Remarks if any for Training need list.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

