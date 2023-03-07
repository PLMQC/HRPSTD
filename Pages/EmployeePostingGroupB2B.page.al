page 33001270 "Employee Posting  Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Posting Group';
    PageType = Worksheet;
    SourceTable = "Employee Posting Group B2B";
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Employee Posting Group';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Description applicable towards the Employee Posting group';
                }
                field("Salary Payable Acc."; "Salary Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("Arrear Salary Payable Acc."; "Arrear Salary Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("PF Payable Acc."; "PF Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("TDS Payable Acc."; "TDS Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("ESI Payable Acc."; "ESI Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("EPS Payable Acc."; "EPS Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("EDLI Charges Acc."; "EDLI Charges Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("PF Admin Charge Payable Acc."; "PF Admin Charge Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("RIFA Charges Acc."; "RIFA Charges Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("Bonus Payable Acc."; "Bonus Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("PT Payable Account"; "PT Payable Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("LeaveEncash Payable Acc."; "LeaveEncash Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("LWF Payable Acc."; "LWF Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
                field("VPF Payable Acc."; "VPF Payable Acc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable General Ledger from Chart of accounts';
                }
            }
        }
    }

    actions
    {
    }
}

