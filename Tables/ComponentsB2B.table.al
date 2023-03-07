table 33001393 "Components B2B"
{
    // version B2BHR1.00.00

    Caption = 'Components';
    DrillDownPageID = "Components B2B";
    LookupPageID = "Components B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }
        field(4; Transport; Boolean)
        {
            Caption = 'Transport';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

