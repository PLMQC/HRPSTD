table 33001392 "Cities Type B2B"
{
    // version B2BHR1.00.00

    Caption = 'Cities Type';
    DrillDownPageID = "Cities Types B2B";
    LookupPageID = "Cities Types B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Domestic,Foreign';
            OptionMembers = Domestic,Foreign;
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

