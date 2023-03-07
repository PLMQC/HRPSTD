table 33001375 "Employee Hobbies & Lang. B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Hobbies & Lang.';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = 'Hobby,Language';
            OptionMembers = Hobby,Language;
            DataClassification = CustomerContent;
        }
        field(6; Hobby; Code[20])
        {
            Caption = 'Hobby';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Hobby <> '' then
                    "Line Type" := "Line Type"::Hobby;
            end;
        }
        field(8; "Hobby Description"; Text[250])
        {
            Caption = 'Hobby Description';
            DataClassification = CustomerContent;
        }
        field(10; "Language Name"; Code[10])
        {
            Caption = 'Language Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Language Name" <> '' then
                    "Line Type" := "Line Type"::Language;
            end;
        }
        field(12; "To Read"; Boolean)
        {
            Caption = 'To Read';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                Testfield("Language Name");
            end;
        }
        field(14; "To Write"; Boolean)
        {
            Caption = 'To Write';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                Testfield("Language Name");
            end;
        }
        field(16; "To Speak"; Boolean)
        {
            Caption = 'To Speak';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                Testfield("Language Name");
            end;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line Type", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

