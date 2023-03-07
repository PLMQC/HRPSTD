page 33001256 "TDS Schedule B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Schedule';
    DelayedInsert = true;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Emp TDS Schedule B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Employee No."; "Employee No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the employee no in th eTDS schedule';
                    ApplicationArea = all;
                }
                field("Year Starting Date"; "Year Starting Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the yesr starding date of TDS shedule';
                    ApplicationArea = all;
                }
                field("Year Ending Date"; "Year Ending Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the year endig of the TDS schedule';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    Editable = false;
                    ToolTip = 'Specifies the month of the TDS schedule';
                    ApplicationArea = all;
                }
                field("TDS Amount"; "TDS Amount")
                {
                    ToolTip = 'Specifies the amount of the TDS schedule';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        TDSAmountOnAfterValidate();
                    end;
                }
                field("TDS Amount Deducted"; "TDS Amount Deducted")
                {
                    Editable = false;
                    ToolTip = 'Specifies the TDS amount deducted in TDS schedule';
                    ApplicationArea = all;
                }
            }
            field(TDSCheckAmount1; TDSCheckAmount)
            {
                Caption = 'TDS Check Amount';
                Editable = false;
                ToolTip = 'Specifies the TDS check amount paid in TDS schedule';
                ApplicationArea = all;
            }
            field(TaxLiabiltyAmt1; TaxLiabiltyAmt)
            {
                Caption = 'Tax Liability';
                Editable = false;
                ToolTip = 'Specifies the tax liability amount in the TDS schedule';
                ApplicationArea = all;
            }
            field(Control1102152020; '')
            {
                CaptionClass = Text19034749Lbl;
                MultiLine = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the TDS Details';
            }
            field(Control1102152016; '')
            {
                CaptionClass = Text19026124Lbl;
                MultiLine = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the TDS Details';
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        TDSDeduction.SETRANGE("Employee No.", "Employee No.");
        TDSDeduction.SETRANGE("Year Starting Date", "Year Starting Date");
        TDSDeduction.SETRANGE("Year Ending Date", "Year Ending Date");
        if TDSDeduction.FINDFIRST() then
            repeat
                TDSSchedule.SETRANGE("Employee No.", TDSDeduction."Employee No.");
                TDSSchedule.SETRANGE("Year Starting Date", TDSDeduction."Year Starting Date");
                TDSSchedule.SETRANGE("Year Ending Date", TDSDeduction."Year Ending Date");
                if TDSSchedule.FINDFIRST() then
                    repeat
                        TDSCheckAmount := TDSCheckAmount + TDSSchedule."TDS Amount";
                    until TDSSchedule.NEXT() = 0;
                TDSCheckAmount := ROUND(TDSCheckAmount, 0.01);
                TaxLiabiltyAmt := ROUND(TDSDeduction."Tax Liability after savings", 0.01);
            until TDSDeduction.NEXT() = 0;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        TDSDeduction.SETRANGE("Employee No.", "Employee No.");
        TDSDeduction.SETRANGE("Year Starting Date", "Year Starting Date");
        TDSDeduction.SETRANGE("Year Ending Date", "Year Ending Date");
        if TDSDeduction.FINDFIRST() then
            repeat
                if TDSCheckAmount <> TDSDeduction."Tax Liability after savings" then
                    if CONFIRM(Text002Lbl) then
                        MESSAGE(Text001Lbl, TDSDeduction."Tax Liability after savings", TDSDeduction."Employee No.");
            until TDSDeduction.NEXT() = 0;
    end;

    var
        TDSDeduction: Record "Emp TDS Deduction B2B";
        TDSSchedule: Record "Emp TDS Schedule B2B";

        Text001Lbl: Label 'Total TDS Amount must be equal to %1 for the employee %2', Comment = '%1 = Tax Liability ; %2 = Empoyee No';
        TDSCheckAmount: Decimal;
        TaxLiabiltyAmt: Decimal;
        Text19026124Lbl: Label 'TDS Schedule Amoount';
        Text19034749Lbl: Label 'Tax Liability After Savings';
        Text002Lbl: Label 'Total TDS Amount is not equal to employee. Do you want to Proceed?';

    local procedure TDSAmountOnAfterValidate();
    begin
        TDSCheckAmount := TDSCheckAmount - xRec."TDS Amount" + "TDS Amount";
        TDSCheckAmount := ROUND(TDSCheckAmount, 0.01);
    end;
}

