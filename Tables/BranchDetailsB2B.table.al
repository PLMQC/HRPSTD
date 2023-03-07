table 33001255 "Branch Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Branch Details';

    fields
    {
        field(1; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = CustomerContent;
        }
        field(2; "Branch Name"; Text[30])
        {
            Caption = 'Branch Name';
            DataClassification = CustomerContent;
        }
        field(3; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(4; Address2; Text[50])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;
        }
        field(5; "Post Code/City"; Code[20])
        {
            Caption = 'Post Code/City';
            DataClassification = CustomerContent;
        }
        field(6; "Phone No."; Integer)
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(7; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = CustomerContent;
        }
        field(8; "Email Id"; Code[20])
        {
            Caption = 'Email Id';
            DataClassification = CustomerContent;
        }
        field(9; "PF No."; Text[30])
        {
            Caption = 'PF No.';
            DataClassification = CustomerContent;
        }
        field(10; "ESI No."; Text[30])
        {
            Caption = 'ESI No.';
            DataClassification = CustomerContent;
        }
        field(11; "PAN No."; Text[30])
        {
            Caption = 'PAN No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Branch Code")
        {
        }
    }

    fieldgroups
    {
    }
}

