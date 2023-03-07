table 33001216 "Temp Calendar B2B"
{
    // version B2BHR1.00.00

    Caption = 'Temp Calendar';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Non-Working"; Boolean)
        {
            Caption = 'Non-Working';
            DataClassification = CustomerContent;
        }
        field(4; Holiday; Integer)
        {
            Caption = 'Holiday';
            DataClassification = CustomerContent;
        }
        field(5; WeeklyOff; Integer)
        {
            Caption = 'WeeklyOff';
            DataClassification = CustomerContent;
        }
        field(6; "Day No."; Integer)
        {
            Caption = 'Day No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Date)
        {
        }
    }

    fieldgroups
    {
    }
}

