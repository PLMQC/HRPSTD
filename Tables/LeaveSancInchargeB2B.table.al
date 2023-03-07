table 33001256 "Leave Sanc. Incharge B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Sanc. Incharge';
    DrillDownPageID = "Leave Sanc. Incharge B2B";
    LookupPageID = "Leave Sanc. Incharge B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }
        field(2; "Sanctioning Incharge"; Code[20])
        {
            Caption = 'Sanctioning Incharge';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; Hierarchy; Integer)
        {
            Caption = 'Hierarchy';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Sanctioning Incharge")
        {
        }
    }

    fieldgroups
    {
    }
}

