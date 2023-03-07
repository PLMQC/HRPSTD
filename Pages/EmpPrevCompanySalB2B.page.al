page 33001442 "Emp. Prev. Company Sal. B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Prev. Company Sal. Det.';
    DelayedInsert = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Emp. Previous Company Sal B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Financial Year Start Date"; "Financial Year Start Date")
                {
                    ToolTip = 'Choose the Financial year Start Date.';
                    ApplicationArea = all;

                    trigger OnDrillDown();
                    begin
                        PayRollYears.RESET();
                        PayRollYears.SETRANGE("Year Type", Text33001Lbl);
                        PayRollYears.SETRANGE(PayRollYears.Closed, false);
                        if PAGE.RUNMODAL(PAGE::"Payroll Years B2B", PayRollYears) = ACTION::LookupOK then begin
                            "Financial Year Start Date" := PayRollYears."Year Start Date";
                            "Financial Year End Date" := PayRollYears."Year End Date";
                        end;
                    end;
                }
                field("Financial Year End Date"; "Financial Year End Date")
                {
                    ToolTip = 'Choose the Financial year End Date.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specifies the Month of TDS.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Specifies the Year of TDS.';
                    ApplicationArea = all;
                }
                field("Pay Element Code"; "Pay Element Code")
                {
                    ToolTip = 'Shows the TDS Amount paid By Employee in previous company.';
                    ApplicationArea = all;
                }
                field("Addition/Deduction"; "Addition/Deduction")
                {
                    ToolTip = 'Shows the Addition/Deduction. of the pay element.';
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ToolTip = 'Shows the amount.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        PayRollYears: Record "Payroll Year B2B";
        Text33001Lbl: Label 'FINANCIAL YEAR';
}

