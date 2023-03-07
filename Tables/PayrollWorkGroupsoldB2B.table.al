table 33001359 "Payroll Work Groups old B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Work Groups old';
    DataClassification = CustomerContent;
    //LookupPageID = 33001326;//Phani

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
        field(11; "Print Designation in Pay Slip"; Boolean)
        {
            Caption = 'Print Designation in Pay Slip';
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

