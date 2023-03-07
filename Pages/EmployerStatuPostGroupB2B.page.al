page 33001531 "Employer Statu Post Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employer Statu Posting Group';
    PageType = Worksheet;
    SourceTable = "Employer Stat. Post. Group B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Code"; Code)
                {
                    ToolTip = 'Enter the Code Name for the Posting Group.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Enter the Description for Employer Satutory Posting Group.';
                    ApplicationArea = all;
                }
                field("Employer PF"; "Employer PF")
                {
                    ToolTip = 'Choose the G/l Account to Which Employer PF to be posted.';
                    ApplicationArea = all;
                }
                field("Employer EPS"; "Employer EPS")
                {
                    ToolTip = 'Choose the G/l Account to Which Employer EPS to be posted.';
                    ApplicationArea = all;
                }
                field("PF Admin. Charges"; "PF Admin. Charges")
                {
                    ToolTip = 'Choose the G/l Account to Which Administrative charges to be posted.';
                    ApplicationArea = all;
                }
                field("EDLI Charges"; "EDLI Charges")
                {
                    ToolTip = 'Choose the G/l Account to Which EDLI Charges to be posted.';
                    ApplicationArea = all;
                }
                field("Employer ESI"; "Employer ESI")
                {
                    ToolTip = 'Choose the G/l Account to Which Employer ESI to be posted.';
                    ApplicationArea = all;
                }
                field("RIFA Charges"; "RIFA Charges")
                {
                    ToolTip = 'Choose the G/l Account to Which RIFA Charges to be posted.';
                    ApplicationArea = all;
                }
                field("Cash Account"; "Cash Account")
                {
                    ToolTip = 'Choose the G/l Account for cash account.';
                    ApplicationArea = all;
                }
                field("Bank Account"; "Bank Account")
                {
                    ToolTip = 'Choose the Bank Account.';
                    ApplicationArea = all;
                }
                field("LWF Account"; "LWF Account")
                {
                    ToolTip = 'Choose the G/l Account for LWF account.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

