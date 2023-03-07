page 33001356 "Exep/Ded Limits B2B"
{
    // version B2BHR1.00.00

    Caption = 'Exemption/Deduction Limits';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Exep/Ded Limits B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(FyStartDate1; FyStartDate)
            {
                Caption = 'Financial Year Start Date';
                TableRelation = "Payroll Year B2B"."Year Start Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                        Closed = CONST(false));
                ApplicationArea = all;
                ToolTip = 'Specifies the payroll Financial year start date';

                trigger OnValidate();
                begin
                    PayRollYears.RESET();
                    PayRollYears.SETRANGE("Year Type", Text001Lbl);
                    PayRollYears.SETRANGE("Year Start Date", FyStartDate);
                    if PayRollYears.FINDFIRST() then
                        FyEndDate := PayRollYears."Year End Date";
                    SETRANGE("Financial Year Start Date", FyStartDate);
                    VALIDATE("Financial Year Start Date");
                    FyStartDateOnAfterValidate();
                end;
            }
            field(FyEndDate1; FyEndDate)
            {
                Caption = 'Financial Year End Date';
                Enabled = false;
                TableRelation = "Payroll Year B2B"."Year End Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                      Closed = CONST(false));
                ApplicationArea = all;
                ToolTip = 'Specifies the payroll Financial year end date';
            }
            repeater(Control1102154000)
            {
                field("Exemp / Ded Group ID"; "Exemp / Ded Group ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the TDS ded group id';
                }
                field("Financial Year Start Date"; "Financial Year Start Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payroll Financial year start date';
                }
                field("Financial Year End Date"; "Financial Year End Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payroll Financial year end date';
                }
                field("Exemption Limit"; "Exemption Limit")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Tax Exemption Limit';
                }
                field("Profit /Loss"; "Profit /Loss")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Profit/Loss details';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        SETRANGE("Financial Year Start Date", FyStartDate);
    end;

    var
        PayRollYears: Record "Payroll Year B2B";
        FyStartDate: Date;
        FyEndDate: Date;
        Text001Lbl: Label 'FINANCIAL YEAR';

    local procedure FyStartDateOnAfterValidate();
    begin
        if FyStartDate = 0D then
            CLEAR(FyEndDate);
        CurrPage.UPDATE();
    end;
}

