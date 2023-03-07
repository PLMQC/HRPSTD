table 33001246 "Payroll Prod. Post. Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Product Posting Group';
    LookupPageID = "Payroll Product Post Group B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
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

