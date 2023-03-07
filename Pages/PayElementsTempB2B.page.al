page 33001341 "Pay Elements Temp B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Elements Temp';
    PageType = Worksheet;
    SourceTable = "Pay Elements Temp B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Employee Code"; "Employee Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Code';
                }
                field("Active Pay Elements"; "Active Pay Elements")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Active Pay Elements';
                }
                field("Effective Start Date"; "Effective Start Date")
                {
                    ToolTip = 'Specifies the Pay Element Effictive Date';
                    ApplicationArea = all;
                }
                field("Pay Element Code"; "Pay Element Code")
                {
                    ToolTip = 'Specifies The  Pay Element Code from the list';
                    ApplicationArea = all;
                }
                field("Fixed/Percent"; "Fixed/Percent")
                {
                    ToolTip = '"Specifies the Pay Element  is Fixed or Percentage "';
                    ApplicationArea = all;
                }
                field("Amount / Percent"; "Amount / Percent")
                {
                    ToolTip = 'Specifes if it is  Fixed "Amount " or If it is  Percenatge in Pay Element  " Percentage"';
                    ApplicationArea = all;
                }
                field("Add/Deduct"; "Add/Deduct")
                {
                    ToolTip = 'Specifies Pay Element is "Addition" or " Deduction"';
                    ApplicationArea = all;
                }

                field("Computation Type"; "Computation Type")
                {
                    ToolTip = '"Specifies Computation type is "" After Basic"" , ""After Basic and DA"" ""Non Attendence"" ""On Attendence""  etc "';
                    ApplicationArea = all;
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    Editable = true;
                    ToolTip = 'Specifes the Pay Cader Type Like "Staff" , "Worker " Etc';
                    Visible = true;
                    ApplicationArea = all;
                }
            }
            field(TotalGrossAmount1; TotalGrossAmount)
            {
                Caption = 'Actual Gross';
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies The Actual gross';
            }
        }
    }

    actions
    {
    }

    var
        TotalGrossAmount: Decimal;
}

