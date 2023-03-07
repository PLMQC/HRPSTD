page 33001241 "Pay Deductions B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Deductions';
    PageType = Worksheet;
    SourceTable = "Pay Deductions B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Pay Element code"; "Pay Element code")
                {
                    ApplicationArea = all;
                    ToolTip = '"Specify the Pay Element from the drill down as defined in the ""Additions and Deductions"" lookup. "';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Description of the the Pay Eleement in relatioship to pay element code "HRA - House Rent Allowance"';
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the type  of the deduction from pay Element';
                }
                field("Add/Deduct"; "Add/Deduct")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Speficies the informations based on the Pay Element either " Addition" or "Deduction"';
                }
            }
        }
    }

    actions
    {
    }
}

