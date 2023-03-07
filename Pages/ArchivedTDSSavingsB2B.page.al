page 33001438 "Archived TDS Savings B2B"
{
    // version B2BHR1.00.00

    Caption = 'Archived TDS Savings';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "Archive TDS Savings B2B";
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
                    ToolTip = 'Sepceifies the Exemption Group id.';
                    ApplicationArea = all;
                }
                field("Actual Paid"; "Actual Paid")
                {
                    ToolTip = 'Actual TDS amount paid.';
                    ApplicationArea = all;
                }
                field(Limit; Limit)
                {
                    ToolTip = 'Specifies the limit of TDS.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

