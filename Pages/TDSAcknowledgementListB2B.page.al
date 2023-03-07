page 33001365 "TDS Acknowledgement List B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Acknowledgement List';
    CardPageID = "TDS Acknowledgement B2B";
    Editable = false;
    PageType = List;
    SourceTable = "TDS Acknowledgment B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the location code';
                }
                field(Quarter; Quarter)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Quarter';
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
                    ToolTip = 'Specifies the tds acknowledgement no';
                }
                field("TDS Acknowledgment Date"; "TDS Acknowledgment Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the tds acknowledgement date';
                }
            }
        }
    }

    actions
    {
    }
}

