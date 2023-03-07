table 33001293 "Calendar Code B2B"
{
    // version B2BHR1.00.00

    Caption = 'Calendar Code_B2B';
    DrillDownPageID = "Calendar Code List B2B";
    LookupPageID = "Calendar Code List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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

