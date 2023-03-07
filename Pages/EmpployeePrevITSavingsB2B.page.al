page 33001444 "Empployee Prev. IT Savings B2B"
{
    // version B2BHR1.00.00

    Caption = 'Empployee Prev. IT Savings';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Emp. Previous IT Savings B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

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
                field("Exemption/Deduction Group ID"; "Exemption/Deduction Group ID")
                {
                    ToolTip = 'Specifies Exemption Deduction Group ID.';
                    ApplicationArea = all;
                }
                field("Amount Exempted"; "Amount Exempted")
                {
                    ToolTip = 'Specifies the Exempted Amount.';
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

