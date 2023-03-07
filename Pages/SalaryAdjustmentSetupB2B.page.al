page 33001366 "Salary Adjustment Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Adjustment Setup';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Salary Adjustment Setup B2B";
    UsageCategory = Documents;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description';
                }
                field(Perk; Perk)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Perk';
                }
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the G/L account';
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                    ToolTip = 'Active';
                }
            }
        }
    }

    actions
    {
    }
}

