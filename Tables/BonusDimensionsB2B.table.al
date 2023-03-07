table 33001261 "Bonus Dimensions B2B"
{
    // version B2BHR1.00.00

    Caption = 'Bonus Dimensions';
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(5; "Bonus Line No."; Integer)
        {
            Caption = 'Bonus Line No.';
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(7; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            TableRelation = Dimension;
            DataClassification = CustomerContent;
        }
        field(8; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
        }
    }

    fieldgroups
    {
    }
}

