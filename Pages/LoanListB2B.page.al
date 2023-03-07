page 33001246 "Loan List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Loan List';
    CardPageID = "Loan Card B2B";
    Editable = false;
    PageType = List;
    SourceTable = Loan_B2B;
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Id; Id)
                {
                    ToolTip = 'Specifies the ID numabers of the loan opted in the loan list';
                    ApplicationArea = all;
                }
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = '"Specifies the Employee code in the loan list "';
                    ApplicationArea = all;
                }
                field("Loan Type"; "Loan Type")
                {
                    ToolTip = 'Specifies the loan type from the advance look up in th eloan list';
                    ApplicationArea = all;
                }
                field("Loan Amount"; "Loan Amount")
                {
                    ToolTip = '"Specifies the loan amount in the loan list "';
                    ApplicationArea = all;
                }
                field("Effective Amount"; "Effective Amount")
                {
                    ToolTip = '"Specifies the effective amount in the loan list "';
                    ApplicationArea = all;
                }
                field("Premium Paid"; "Premium Paid")
                {
                    ToolTip = 'Specifies the premium paid in the loan card';
                    ApplicationArea = all;
                }
                field("Loan Status"; "Loan Status")
                {
                    ToolTip = 'Specifies the loan status lile "Outstanding" " close" etc on loan list';
                    ApplicationArea = all;
                }
                field("Loan Balance"; "Loan Balance")
                {
                    ToolTip = 'Specifies the loan balance in the loan list';
                    ApplicationArea = all;
                }
                field("No of Installments"; "No of Installments")
                {
                    ToolTip = 'specifies the no of installemnts in the loan list';
                    ApplicationArea = all;
                }
                field("Installment Amount"; "Installment Amount")
                {
                    ToolTip = 'Specifies the installement amount aganingst loan in the loan list';
                    ApplicationArea = all;
                }
                field(Closed; Closed)
                {
                    ToolTip = 'Specifes if the loan amount is totally paid as closed in the loan list';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Loan")
            {
                Caption = '&Loan';
                action("<Action1102152043>")
                {
                    Caption = 'Card';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    RunObject = Page "Loan Card B2B";
                    ApplicationArea = all;
                    ToolTip = 'Specify the Loan';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Create &Installments")
                {
                    Caption = 'Create &Installments';
                    Image = Installments;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Installments';
                    trigger OnAction();
                    begin
                        LoanCalculation.LoanInstallments(Rec);
                    end;
                }
                action("Loan &Repayment")
                {
                    Caption = 'Loan &Repayment';
                    Image = Prepayment;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Loan Repayment B2B";
                    RunPageLink = "Loan Id" = FIELD(Id),
                                  "Employee No." = FIELD("Employee Code"),
                                  Paid = CONST(false);
                    RunPageMode = Create;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Loan Repayment';
                }
            }
        }
    }

    var
        LoanCalculation: Codeunit "Loan Calculations B2B";
}

