page 33001504 "Loan Log Entry List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Loan Log Entry List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Log Entry B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Loan ID"; "Loan ID")
                {
                    ToolTip = 'Show the Loan Id No. Series';
                    ApplicationArea = all;
                }
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field("Date Initiated"; "Date Initiated")
                {
                    ToolTip = 'Shows the Loan Date Initiated.';
                    ApplicationArea = all;
                }
                field("Loan Type"; "Loan Type")
                {
                    ToolTip = 'Shows the Loan Type.';
                    ApplicationArea = all;
                }
                field("Loan Status"; "Loan Status")
                {
                    ToolTip = 'Shows the status of the Loan.';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Shows the Remarks entered for the loan.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    local procedure RemarksOnDeactivate();
    begin
        CurrPage.EDITABLE(false);
    end;

    local procedure RemarksOnActivate();
    begin
        CurrPage.EDITABLE(true);
    end;
}

