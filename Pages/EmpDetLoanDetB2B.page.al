page 33001295 "EmpDet LoanDet B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Details_Loan Details';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Loan Details B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Loan Code"; "Loan Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Loan Code assigned to a employee';
                }
                field("Pay Date"; "Pay Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Pay date of Loan amount to a employee';
                }
                field("Loan Amount"; "Loan Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Total Loan Amount discursed to a employee';
                }
                field("EMI Deducted"; "EMI Deducted")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Loan EMI Deducted towards a employee';
                }
                field("EMI Amount"; "EMI Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the EMI Amount of a employee';
                }
                field("Lump Sum Payment"; "Lump Sum Payment")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Lumsum Amount deducted if any towards a employee';
                }
                field(Principal; Principal)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Principal Loan amount towards a employee';
                }
                field(Balance; Balance)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Loan Balance Amount of a employee';
                }
                field("Paid Month"; "Paid Month")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Loan paid or recovered month';
                }
                field("Paid Year"; "Paid Year")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Paid Year of Loan';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetEmp(LoanId: Code[20]);
    begin
        SETRANGE("Loan Id", LoanId);
        CurrPage.UPDATE(false);
    end;
}

