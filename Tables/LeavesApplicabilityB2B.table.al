table 33001309 "Leaves Applicability B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leaves Applicability_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "From Leave Code"; Code[20])
        {
            Caption = 'From Leave Code';
            TableRelation = "Leave Master B2B"."Leave Code";
            DataClassification = CustomerContent;
        }
        field(2; "To Leave Code"; Code[20])
        {
            Caption = 'To Leave Code';
            TableRelation = "Leave Master B2B"."Leave Code";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "From Leave Code", "To Leave Code")
        {
        }
    }

    fieldgroups
    {
    }
}

