table 33001245 "Payroll Bus. Post Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Business Posting Group';
    LookupPageID = "Payroll Bus. Posting Group B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
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

