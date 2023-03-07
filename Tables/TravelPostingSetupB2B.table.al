table 33001395 "Travel Posting Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Travel Posting Setup';
    DrillDownPageID = "Travel Posting Setup B2B";
    LookupPageID = "Travel Posting Setup B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Components; Code[20])
        {
            Caption = 'Components';
            TableRelation = "Components B2B".Code WHERE(Active = CONST(true));
            DataClassification = CustomerContent;
        }
        field(2; "Posting Account"; Code[20])
        {
            Caption = 'Posting Account';
            TableRelation = "G/L Account" WHERE("Direct Posting" = CONST(true));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Components)
        {
        }
    }

    fieldgroups
    {
    }
}

