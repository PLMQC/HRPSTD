page 33001227 "Pay Elements B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Elements';
    PageType = Worksheet;
    SourceTable = "Pay Elements B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Effective Start Date"; "Effective Start Date")
                {
                    ToolTip = 'Specifies the effective start date from which the Pay elements should be effective from';
                    ApplicationArea = all;
                }
                field("Pay Element Code"; "Pay Element Code")
                {
                    ToolTip = 'Specifies the List of pay elements of a company applicable to a employee or employee''s "Basic,HRA,DA, Bonus etc.."';
                    ApplicationArea = all;
                }
                field("Fixed/Percent"; "Fixed/Percent")
                {
                    ToolTip = 'Specifies fixed / percent for the pay element opted for salary computation';
                    ApplicationArea = all;
                }
                field("Amount / Percent"; "Amount / Percent")
                {
                    ToolTip = 'Specifies fixed / percent for the pay element opted for salary computation. "Fixed - A predefined value, Pecent - % defined dependent on a pay element"';
                    ApplicationArea = all;
                }
                field("Computation Type"; "Computation Type")
                {
                    ToolTip = 'Specifies the calculation / computation of salaries on depending payelement as fixed / percent "After Basic , After Basic and DA"';
                    ApplicationArea = all;
                }
                field("Add/Deduct"; "Add/Deduct")
                {
                    Editable = false;
                    ToolTip = 'Specifies the categorization of pay elements as "Add / Deduct" applicable to an employee or group of employee''s';
                    ApplicationArea = all;
                }
                field(PF; PF)
                {
                    ToolTip = 'Specifies the calculation of PF based on the statutory setup and based on dependent pay element';
                    ApplicationArea = all;
                }
                field(PT; PT)
                {
                    ToolTip = 'Specifies the calculation of PT based on the statutory setup and based on dependent pay element';
                    ApplicationArea = all;
                }
                field(ESI; ESI)
                {
                    ToolTip = 'Specifies the calculation of ESI based on the statutory setup and based on dependent pay element';
                    ApplicationArea = all;
                }
                field("Applicable for OT"; "Applicable for OT")
                {
                    ToolTip = 'Specifies the calculation of OT based on the setup and based on dependent pay element';
                    ApplicationArea = all;
                }
                field("Applicable for C Off"; "Applicable for C Off")
                {
                    ToolTip = 'Specifies the calculation of C OFF based on the setup and based on dependent pay element';
                    ApplicationArea = all;
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    Editable = false;
                    ToolTip = 'Specifies the different category / grades / Cadre applicable foe payroll computation';
                    ApplicationArea = all;
                }
                field("Active Pay Elements"; "Active Pay Elements")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Active pay elements.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        PayElement.SETRANGE("Employee Code", "Employee Code");
        if PayElement.FINDFIRST() then
            repeat
                PayElement.TESTFIELD("Computation Type");
                PayElement.TESTFIELD("Amount / Percent");
            until PayElement.NEXT() = 0
    end;

    var
        PayElement: Record "Pay Elements B2B";

}

