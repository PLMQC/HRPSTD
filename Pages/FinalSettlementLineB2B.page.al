page 33001503 "Final Settlement Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Final Settlement Line';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "Final Settlement Line B2B";
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
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Select the month of final settlement.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Select the year of final settlement.';
                    ApplicationArea = all;
                }
                field("Addition/Deduction"; "Addition/Deduction")
                {
                    ToolTip = 'Shows the pay element type as addition/deduction.';
                    ApplicationArea = all;
                }
                field("Pay Element Code"; "Pay Element Code")
                {
                    ToolTip = 'Displays the Pay Element code.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Displays the Full description of pay element.';
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ToolTip = 'Shows the Amount against the Pay Element.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

