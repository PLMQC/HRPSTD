page 33001434 "TDS Savings B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Savings';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "TDS Savings B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Exemption Group Id"; "Exemption Group Id")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the exemption group id details';
                }
                field("Actual Paid"; "Actual Paid")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify actual paid details';
                }
                field(Limit; Limit)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the limit details';
                }
            }
        }
    }

    actions
    {
    }
}

