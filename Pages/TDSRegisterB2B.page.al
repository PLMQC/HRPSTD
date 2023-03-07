page 33001449 "TDS Register B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Register';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Worksheet;
    SourceTable = "TDS Salary Details B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                Editable = false;
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Choose the Employee Number.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specifies the month.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Spcifies the year.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("TDS Amount"; "TDS Amount")
                {
                    ToolTip = 'Specifies the TDS Amount deducted.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("TDS Amount Paid"; "TDS Amount Paid")
                {
                    ToolTip = 'Specifies the TDs Amount paid.';
                    ApplicationArea = all;
                }
                field("Sal. Posting Document No."; "Sal. Posting Document No.")
                {
                    ToolTip = 'Spcifies the Salary posting document number.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Challan No."; "Challan No.")
                {
                    ToolTip = 'Specifies the Challan No. for TDS.';
                    ApplicationArea = all;
                }
                field("Challan Date"; "Challan Date")
                {
                    ToolTip = 'Specifies the challan date paid for TDS.';
                    ApplicationArea = all;
                }
                field("Bank Name"; "Bank Name")
                {
                    ToolTip = 'Spcifies the Bank name from which tds paid.';
                    ApplicationArea = all;
                }
                field("BSR Code"; "BSR Code")
                {
                    ToolTip = 'Spcifies the Bank Branch code.';
                    ApplicationArea = all;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ToolTip = 'Spcifies the Cheque number paid tds.';
                    ApplicationArea = all;
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ToolTip = 'Spcifies the Cheque Date.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Update TDS Register")
                {
                    ToolTip = 'Updates the TDS Register.';
                    Caption = 'Update TDS Register';
                    Image = Register;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        REPORT.RUNMODAL(33001256);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        FILTERGROUP(0);
    end;

    var
}

