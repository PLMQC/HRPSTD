table 33001313 "Salary Adjustment Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Adjustment Setup_B2B';
    DrillDownPageID = "Salary Adjustment Setup B2B";
    LookupPageID = "Salary Adjustment Setup B2B";
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
        field(3; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(4; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }
        field(5; Perk; Boolean)
        {
            Caption = 'Perk';
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

