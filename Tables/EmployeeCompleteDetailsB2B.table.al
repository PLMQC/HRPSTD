table 33001326 "Employee Complete Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Complete Details_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Lookup Id"; Integer)
        {
            Caption = 'Lookup ID';
            DataClassification = CustomerContent;
        }
        field(2; "Lookup Name"; Code[50])
        {
            Caption = 'Lookup Name';
            DataClassification = CustomerContent;
        }
        field(3; "Lookup Type"; Integer)
        {
            Caption = 'Lookup Type';
            DataClassification = CustomerContent;
        }
        field(6; "LookupType Name"; Code[50])
        {
            Caption = 'LookupTypeName';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(7; LookUpsInserted; Boolean)
        {
            Caption = 'LookUpsInserted';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Lookup Id", "Lookup Name", "Lookup Type")
        {
        }
    }

    fieldgroups
    {
    }

    var

}

