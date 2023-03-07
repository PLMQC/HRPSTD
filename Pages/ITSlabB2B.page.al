page 33001431 "IT Slab B2B"
{
    // version B2BHR1.00.00

    Caption = 'IT Slab';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "IT Slab Header B2B";
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
                ToolTip = 'specify the Financial year start date';

                trigger OnValidate();
                begin
                    PayRollYears.RESET();
                    PayRollYears.SETRANGE("Year Type", Text33001Lbl);
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
                Editable = false;
                TableRelation = "Payroll Year B2B"."Year End Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                      Closed = CONST(false));
                ApplicationArea = all;
                ToolTip = 'specify the Financial year end date';
            }
            repeater(Control1102154000)
            {
                field(SlabType; SlabType)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the Income tax slab type details';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the description';
                }
            }
            part(Control1102154008; "IT Slab Subform B2B")
            {
                SubPageLink = SlabType = FIELD(SlabType),
                              "Financial Year Start Date" = FIELD("Financial Year Start Date");
                ApplicationArea = all;

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        "Financial Year End Date" := FyEndDate;
        "Financial Year Start Date" := FyStartDate;
    end;

    trigger OnOpenPage();
    begin
        CLEAR(FyStartDate);
        CLEAR(FyEndDate);
        SETRANGE("Financial Year Start Date", FyStartDate);
    end;

    var
        PayRollYears: Record "Payroll Year B2B";
        FyStartDate: Date;
        FyEndDate: Date;
        Text33001Lbl: Label 'FINANCIAL YEAR';

    local procedure FyStartDateOnAfterValidate();
    begin
        if FyStartDate = 0D then
            CLEAR(FyEndDate);
        CurrPage.UPDATE();
    end;
}

