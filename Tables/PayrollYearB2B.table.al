table 33001208 "Payroll Year B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Year';
    DrillDownPageID = "Payroll Years B2B";
    LookupPageID = "Payroll Years B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(2; "Year Type"; Code[50])
        {
            Caption = 'Year Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAYROLL YEARS'));
            DataClassification = CustomerContent;
        }
        field(3; "Year Start Date"; Date)
        {
            Caption = 'Year Start Date';
            DataClassification = CustomerContent;
        }
        field(4; "Year End Date"; Date)
        {
            Caption = 'Year End Date';
            DataClassification = CustomerContent;
        }
        field(5; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Year Type", "Year Start Date", "Year End Date")
        {
        }
        key(key2; "Year Type", Closed)
        {

        }
    }

    fieldgroups
    {
    }
}

