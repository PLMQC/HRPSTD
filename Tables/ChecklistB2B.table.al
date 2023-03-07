table 33001407 "Check list B2B"
{
    Caption = 'Check List';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Resume,Employee';
            OptionMembers = Resume,Employee;
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(3; Code; Code[20])
        {
            Caption = 'Code';
            TableRelation = Lookup_B2B;
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; Clearence; Option)
        {
            Caption = 'Clearence';
            OptionMembers = No,Yes;
            OptionCaption = 'No,Yes';
            DataClassification = CustomerContent;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(7; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
            DataClassification = CustomerContent;
        }
        field(8; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = CustomerContent;
        }
        field(9; "Issuing Authority"; text[100])
        {
            Caption = 'Issuing Authority';
            DataClassification = CustomerContent;
        }
        field(10; "Validity From"; Date)
        {
            Caption = 'Validity From';
            DataClassification = CustomerContent;
        }
        field(11; "Renewal Date"; Date)
        {
            Caption = 'Renewal Date';
            DataClassification = CustomerContent;
        }

        field(16; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = CustomerContent;
        }
        field(18; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}