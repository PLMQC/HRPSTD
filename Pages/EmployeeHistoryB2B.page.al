page 33001491 "Employee History B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee History';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "Emp History B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specify the effictive date from which it applicable';
                    ApplicationArea = all;
                }
                field("Emp No."; "Emp No.")
                {
                    ToolTip = 'Specifies the employee number of the involved entry or record, according to the specified number series';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Specify Employee''s Department Code';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ToolTip = 'Specify Designation of the Employee';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Print)
            {
                ToolTip = 'Print the employee details.';
                Caption = 'Print';
                Image = PrintReport;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortCutKey = 'Ctrl+P';
                ApplicationArea = all;

                trigger OnAction();
                begin
                    ChangeInCadre.RESET();
                    ChangeInCadre.SETRANGE("Emp No.", "Emp No.");
                    REPORT.RUN(33001261, true, false, ChangeInCadre);
                end;
            }
        }
    }

    var
        ChangeInCadre: Record "Change in Cadre B2B";
}

