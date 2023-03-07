page 33001437 "Archived TDS Deductions B2B"
{
    // version B2BHR1.00.00

    Caption = 'Archived TDS Deductions';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "Archive TDS Deductions B2B";
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
                ToolTip = 'Specify the Financial year start date';

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
                ToolTip = 'Specify the Financial year end date';
            }
            repeater(Control1102154000)
            {
                Editable = false;
                field("Emp ID"; "Emp ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the EMP ID details';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field("Gross Salary"; "Gross Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the gross salary details';
                }
                field("PT Amount"; "PT Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the PT amount details';
                }
                field(Perks; Perks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the perk details';
                }
                field("Total Gross Salary"; "Total Gross Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the total gross salary details';
                }
                field("Exem Under 10 and 17"; "Exem Under 10 and 17")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Exem under 10 and 17 details';
                }
                field("Gross Total Income"; "Gross Total Income")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the gross total income details';
                }
                field("Income Charged Under Salary"; "Income Charged Under Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the income charged under salary details';
                }
                field("Other Income"; "Other Income")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the other income details';
                }
                field("Chapter VI"; "Chapter VI")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Chapter VI details';
                }
                field("Chapter VIA"; "Chapter VIA")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Chapter VIA details';
                }
                field("Net Tax Income"; "Net Tax Income")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the net tax income details';
                }
                field("Total Tax Liability"; "Total Tax Liability")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the total tax liability details';
                }
                field("Profit Lieu of Salary"; "Profit Lieu of Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the profit lieu of salary details';
                }
                field("Relief US89"; "Relief US89")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the relief US89 details';
                }
                field("Archived Date"; "Archived Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the archived date details';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Savings)
                {
                    Caption = 'Savings';
                    Image = Save;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Archived TDS Savings B2B";
                    RunPageLink = "Emp ID" = FIELD("Emp ID"),
                                  "Financial Year Start Date" = FIELD("Financial Year Start Date"),
                                  "Archived Date" = FIELD("Archived Date");
                    RunPageMode = Edit;
                    ApplicationArea = all;
                    ToolTip = 'Specify the TDS saving details';

                    trigger OnAction();
                    begin
                        if FyStartDate = 0D then
                            ERROR(Text002Lbl);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        CLEAR(FyStartDate);
        CLEAR(FyEndDate);
        SETRANGE("Financial Year Start Date", FyStartDate);

        FILTERGROUP(2);
        FILTERGROUP(0);
    end;

    var
        PayRollYears: Record "Payroll Year B2B";
        FyStartDate: Date;
        FyEndDate: Date;
        Text002Lbl: Label 'Start date must be filled';
        Text33001Lbl: Label 'FINANCIAL YEAR';

    local procedure FyStartDateOnAfterValidate();
    begin
        if FyStartDate = 0D then
            CLEAR(FyEndDate);
        CurrPage.UPDATE();
    end;
}

