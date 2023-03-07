table 33001263 "Training Calendar Schedule B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Calendar Schedule';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Training Calendar No."; Code[20])
        {
            Caption = 'Training Calendar No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Date of Training"; Text[50])
        {
            Caption = 'Date of Training';
            DataClassification = CustomerContent;
        }
        field(4; "Topics Covered"; Text[250])
        {
            Caption = 'Topics Covered';
            DataClassification = CustomerContent;
        }
        field(5; Timing; Text[30])
        {
            Caption = 'Timing';
            DataClassification = CustomerContent;
        }
        field(6; "Faculty Name"; Code[20])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Training Calendar No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

