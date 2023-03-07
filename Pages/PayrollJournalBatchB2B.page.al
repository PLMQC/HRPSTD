page 33001274 "Payroll Journal Batch B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Journal Batch';
    PageType = Worksheet;
    SourceTable = "Payroll Journal Batch B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Name; Name)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the applicable Journal batch Name';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the applicable Description Name for the Batch';
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the applicable reason code';
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the applicable Balancec from Chart of accounts based on cash / bank';
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';

                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable number series';
                }
                field("Posting No. Series"; "Posting No. Series")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable posting number series';
                }
            }
        }
    }

    actions
    {
    }
}

