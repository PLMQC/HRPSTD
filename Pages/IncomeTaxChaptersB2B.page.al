page 33001351 "Income Tax Chapters B2B"
{
    // version B2BHR1.00.00

    Caption = 'Income Tax Chapters';
    DelayedInsert = true;
    Editable = true;
    PageType = Worksheet;
    SourceTable = "IT Chapters B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Chapter ID"; "Chapter ID")
                {
                    Editable = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax chapter id details';
                }
                field("Maximum Limit"; "Maximum Limit")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax limits details';
                }
                field("Standard Deduction"; "Standard Deduction")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax standard deductions details';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1102152001>")
            {
                Caption = '&Section';
                action("<Action1102152002>")
                {
                    Caption = 'Standard Deduction';
                    Image = GetLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Income tax standard deductions details';

                    trigger OnAction();
                    begin
                        ShowRebateDetails();
                    end;
                }
            }
        }
    }

    procedure ShowRebateDetails();
    var
        IncomeTaxRebateGRec: Record "Income Tax Rebate Setup B2B";
        IncomeTaxrebateListFormGVar: Page "Income Tax Rebate Setup B2B";
        IncomeTaxrebateFormGVar: Page "Income Tax Rebate Setup B2B";
    begin
        TESTFIELD("Chapter ID");

        CLEAR(IncomeTaxrebateListFormGVar);
        CLEAR(IncomeTaxrebateFormGVar);

        IncomeTaxRebateGRec.RESET();
        IncomeTaxRebateGRec.SETCURRENTKEY("Document Type", "Section ID", "Rebate Year Starting Date", "Rebate Year Ending Date");
        IncomeTaxRebateGRec.SETRANGE("Document Type", IncomeTaxRebateGRec."Document Type"::"Standard Deduction");
        IncomeTaxRebateGRec.SETRANGE("Section ID", "Chapter ID");
        if GuiAllowed() then begin
            IncomeTaxrebateListFormGVar.SETTABLEVIEW(IncomeTaxRebateGRec);
            IncomeTaxrebateListFormGVar.RUNMODAL()
        end else begin
            IncomeTaxrebateFormGVar.SETTABLEVIEW(IncomeTaxRebateGRec);
            IncomeTaxrebateFormGVar.RUNMODAL()
        end;
    end;
}

