page 33001364 "Employee Skills B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Skills';
    PageType = Worksheet;
    SourceTable = "Credentials B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Skill Type"; "Skill Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the skill type';
                }
                field("Credential Code"; "Credential Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the credential Code';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description';
                }
                field(Institution; Institution)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the instituation';
                }
                field("Name of Institute/University"; "Name of Institute/University")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the institution';
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies From Date';
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies to date';
                }
                field(Percentage; Percentage)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies Percentage';
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies Remarks';
                }
            }
        }
    }

    actions
    {
    }
}

