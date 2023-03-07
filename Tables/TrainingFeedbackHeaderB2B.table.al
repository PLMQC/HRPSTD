table 33001276 "Training Feedback Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Feedback Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(4; Department; Code[30])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
        }
        field(5; Designation; Code[50])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(6; "Subject of Training"; Text[50])
        {
            Caption = 'Subject of Training';
            DataClassification = CustomerContent;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(8; "Traing Line No."; Integer)
        {
            Caption = 'Traing Line No.';
            DataClassification = CustomerContent;
        }
        field(16; "Question ID"; Code[20])
        {
            Caption = 'Question ID';
            TableRelation = "Questionnaire Header B2B" WHERE("Questionnaire Type" = CONST(Training));
            DataClassification = CustomerContent;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(19; "Physical Location"; Code[20])
        {
            Caption = 'Physical Location';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(23));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }
}

