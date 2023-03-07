page 33001357 "HRA Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'HRA Setup';
    PageType = Worksheet;
    SourceTable = "HRA Setup B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Location Type"; "Location Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Location TYpe as Metro / Non Metro';
                }
                field("Limit 1 %"; "Limit 1 %")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfy the HRA Setup as per Metro Applicability Used in for TDS Purpose';
                }
                field("Limit 2 %"; "Limit 2 %")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfy the HRA Setup as per Metro Applicability used in for TDS Purpose';
                }
            }
        }
    }

    actions
    {
    }
}

