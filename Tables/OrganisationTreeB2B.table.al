table 33001405 "Organisation Tree B2B"
{
    DataClassification = CustomerContent;
    Fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(5; Code; code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(7; Name; Text[250])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(10; Indenantion; Integer)
        {
            Caption = 'Indenantion';
            DataClassification = CustomerContent;
        }
        field(15; EMPCount; Integer)
        {
            Caption = 'Count';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}