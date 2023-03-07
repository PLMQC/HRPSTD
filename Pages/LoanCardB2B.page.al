page 33001245 "Loan Card B2B"
{
    // version B2BHR1.00.00

    Caption = 'Loan Card';
    PageType = Card;
    SourceTable = Loan_B2B;
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Id; Id)
                {
                    ToolTip = 'Specify the Loan Id number form lookup';
                    ApplicationArea = all;
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Specify the employee code on Loan card';
                    ApplicationArea = all;
                }
                field("Loan Type"; "Loan Type")
                {
                    ToolTip = 'Specify the loan type of the loan card';
                    ApplicationArea = all;
                }
                field("Interest Method"; "Interest Method")
                {
                    ToolTip = 'specifies the method of intrest applicable on loan card like "Intrest Free" , "Dimnishing Value" etc';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        if "Interest Method" = "Interest Method"::"Interest Free" then
                            "Interest RateEditable" := false
                        else
                            "Interest RateEditable" := true;
                    end;
                }
                field("Interest Rate"; "Interest Rate")
                {
                    Editable = "Interest RateEditable";
                    ToolTip = 'Specifies the rate of intrest if intratest is applicable';
                    ApplicationArea = all;
                }
                field("Loan Amount"; "Loan Amount")
                {
                    Caption = 'Loan Amount';
                    DecimalPlaces = 3 : 3;
                    ToolTip = 'Specifies the loan amount on loan card';
                    ApplicationArea = all;
                }
                field("Loan Start Date"; "Loan Start Date")
                {
                    ToolTip = 'Soecifies the loan start date on loan card';
                    ApplicationArea = all;
                }
                field("No of Installments"; "No of Installments")
                {
                    Editable = "No of InstallmentsEditable";
                    ToolTip = 'Specifies the loan installemnt for the loan allowed in loan card';
                    ApplicationArea = all;
                }
                field("Loan End Date"; "Loan End Date")
                {
                    Editable = false;
                    ToolTip = '"Specify the loan end date on the loan card "';
                    ApplicationArea = all;
                }
                field("Loan Balance"; "Loan Balance")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The loan balance';
                }
                field("Premium Paid"; "Premium Paid")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Premium Paid of the Loan';
                }
                field("Lumpsum Paid"; "Lumpsum Paid")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Lumpum Paid of the Loan';
                }
                field("Total Loan Payable"; "Total Loan Payable")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Total Loan Payable';
                }
                field("Loan Priority No"; "Loan Priority No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Loan Priority No.';
                }
                field("Loan Posting Group"; "Loan Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the posting group from drill down list like "Advance " " Festival Advace" etc';
                }
                field("Effective Amount"; "Effective Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the effective amount applicable in loan card';
                    ApplicationArea = all;
                }
                field("No Deduction Request"; "No Deduction Request")
                {
                    ToolTip = 'Specifies if a particular period no deduction request raised in the loan card';
                    ApplicationArea = all;
                }
                field("Partial Deduction"; "Partial Deduction")
                {
                    ToolTip = '"Specifies the partical decuction if necessary in loan card "';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        if "Partial Deduction" then
                            PartialDedectingAmountEditable := true
                        else
                            PartialDedectingAmountEditable := false;
                    end;
                }
                field(Closed; Closed)
                {
                    Editable = false;
                    ToolTip = 'specifies if the loan card is closed in loan card';
                    ApplicationArea = all;
                }
                field("Partial Dedecting Amount"; "Partial Dedecting Amount")
                {
                    Editable = PartialDedectingAmountEditable;
                    ToolTip = 'Specifies the partical deducting amount in loan card';
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
                Image = Loaner;
                action("&Details")
                {
                    Caption = '&Details';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Loan Details B2B";
                    RunPageLink = "Employee No." = FIELD("Employee Code"),
                                  "Loan Id" = FIELD(Id);
                    ApplicationArea = all;
                    ToolTip = 'Specify the Details of the Loaner';
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
                    ToolTip = 'Specify the Installments of the Loan';
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

    trigger OnAfterGetRecord();
    begin
        //if  Type = Type :: "2" then begin//Phani
        "No of InstallmentsEditable" := false;
        //end else begin
        "No of InstallmentsEditable" := true;
        //end;
        OnAfterGetCurrRecordCust();
    end;

    trigger OnInit();
    begin
        PartialDedectingAmountEditable := true;
        "Interest RateEditable" := true;
        "No of InstallmentsEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        OnAfterGetCurrRecordCust();
    end;

    trigger OnOpenPage();
    begin
        if "Interest Method" = "Interest Method"::"Interest Free" then
            "Interest RateEditable" := false
        else
            "Interest RateEditable" := true;
        if "Partial Deduction" then
            PartialDedectingAmountEditable := true
        else
            PartialDedectingAmountEditable := false;
    end;

    var
        LoanCalculation: Codeunit "Loan Calculations B2B";
        [InDataSet]
        "No of InstallmentsEditable": Boolean;
        [InDataSet]
        "Interest RateEditable": Boolean;
        [InDataSet]
        PartialDedectingAmountEditable: Boolean;

    local procedure OnAfterGetCurrRecordCust();
    begin
        xRec := Rec;
        if "Interest Method" = "Interest Method"::"Interest Free" then
            "Interest RateEditable" := false
        else
            "Interest RateEditable" := true;
    end;
}

