page 33001544 "Shift Schedule Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shift Schedule Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Shift Schedule Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Choose the Dcoument No.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field("Current Shift"; "Current Shift")
                {
                    ToolTip = 'Choose the Current shift of employee.';
                    ApplicationArea = all;
                }
                field("Revised Shift"; "Revised Shift")
                {
                    ToolTip = 'Choose the Revised shift of the Employee';
                    ApplicationArea = all;
                }
                field("Token No."; "Token No.")
                {
                    ToolTip = 'Specifies the token No.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Write any remarks need to be entered.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

