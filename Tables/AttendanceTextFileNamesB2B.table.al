table 33001323 "Attendance Text FileNames B2B"
{
    // version B2BHR1.00.00

    Caption = 'Attendance Text FileNames_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Text File Name"; Code[100])
        {
            Caption = 'Text File Name';
            DataClassification = CustomerContent;
        }
        field(3; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
        }
        field(4; Executed; Boolean)
        {
            Caption = 'Executed';
            DataClassification = CustomerContent;
        }
        field(5; "Text File Name 2"; Code[100])
        {
            Caption = 'Text File Name 2';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Text File Name")
        {
        }
    }

    fieldgroups
    {
    }
}

