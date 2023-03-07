table 33001349 "HRA Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'HRA Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Type"; Option)
        {
            Caption = 'Location Type';
            OptionCaption = 'Metro,Non-Mertro';
            OptionMembers = Metro,"Non-Mertro";
            DataClassification = CustomerContent;
        }
        field(2; "Limit 1 %"; Decimal)
        {
            Caption = 'Limit 1 %';
            DataClassification = CustomerContent;
        }
        field(3; "Limit 2 %"; Decimal)
        {
            Caption = 'Limit 2 %';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Location Type")
        {
        }
    }

    fieldgroups
    {
    }
}

