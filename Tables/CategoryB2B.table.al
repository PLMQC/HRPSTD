table 33001391 Category_B2B
{
    // version B2BHR1.00.00

    Caption = 'Category';
    DrillDownPageID = "Categories B2B";
    LookupPageID = "Categories B2B";
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

