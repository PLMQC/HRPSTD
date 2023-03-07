page 33001363 "TDS Acknowledgement B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Acknowledgement';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "TDS Acknowledgment B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field(Quarter; Quarter)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the quarter';
                }
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the starting date';
                }
                field("Ending Date"; "Ending Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ending date';
                }
                field("TDS Acknowledgement No."; "TDS Acknowledgement No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the tds acknowledgement';
                }

                }
                }
}

    actions
    {
    }
}

