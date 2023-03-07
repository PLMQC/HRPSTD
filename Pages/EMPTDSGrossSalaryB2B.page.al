page 33001435 "EMP TDS Gross Salary B2B"
{
    // version B2BHR1.00.00

    Caption = 'EMP TDS Gross Salary';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "EMP TDS Gross Salary B2B";
    SourceTableView = SORTING("Emp ID", "Payslip Year", "Payslip Month", "Pay Element Code", "Financial Year Start Date")
                      ORDER(Ascending);
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Emp ID"; "Emp ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the EMP ID details';
                }
                field("Payslip Month"; "Payslip Month")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Payslip month details';
                }
                field("Payslip Year"; "Payslip Year")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Payslip year details';
                }
                field("Pay Element Code"; "Pay Element Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the payelement code details';
                }
                field("Add/Deduct"; "Add/Deduct")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Payelement add/deduct details';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the amount details';
                }
            }
        }
    }

    actions
    {
    }
}

