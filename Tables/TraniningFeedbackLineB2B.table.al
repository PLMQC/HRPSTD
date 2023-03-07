table 33001277 "Tranining Feedback Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Tranining Feedback Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }
        field(4; Categories; Text[250])
        {
            Caption = 'Categories';
            DataClassification = CustomerContent;
        }
        field(5; "1"; Boolean)
        {
            Caption = '1';
            DataClassification = CustomerContent;
        }
        field(6; "2"; Boolean)
        {
            Caption = '2';
            DataClassification = CustomerContent;
        }
        field(7; "3"; Boolean)
        {
            Caption = '3';
            DataClassification = CustomerContent;
        }
        field(8; "4"; Boolean)
        {
            Caption = '4';
            DataClassification = CustomerContent;
        }
        field(9; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Question,Answer,Heading';
            OptionMembers = Question,Answer,Heading;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Employee No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

