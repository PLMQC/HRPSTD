table 33001195 "HR Comment Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'HR Comment Line';
    DataCaptionFields = "No.";
    DrillDownPageID = "HR Comment List B2B";
    LookupPageID = "HR Comment List B2B";

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionCaption = '"Employee B2B",Resume Database,Recruitment Header,Training Header,Employee Qualification B2B,Employee Relative B2B,Misc. Article Information B2B,Confidential Information B2B,Employee Alternative Address';
            OptionMembers = "Employee B2B","Resume Database","Recruitment Header","Training Header","Employee Qualification B2B","Employee Relative B2B","Misc. Article Information B2B","Confidential Information B2B","Employee Alternative Address";
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Table Name" = CONST("Employee B2B")) "Employee B2B"."No."
            ELSE
            IF ("Table Name" = CONST("Resume Database")) "Resume Database B2B"."No."
            ELSE
            IF ("Table Name" = CONST("Recruitment Header")) "Recruitment Header B2B"."Recruitment Policy No.";
            DataClassification = CustomerContent;
        }
        field(4; "Alternative Address Code"; Code[20])
        {
            Caption = 'Alternative Address Code';
            TableRelation = IF ("Table Name" = CONST("Employee Alternative Address")) "Emp Alternative Address B2B".Code WHERE("Employee No." = FIELD("No."));
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(8; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(9; Comment; Text[80])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
        field(15; "Table Line No."; Integer)
        {
            Caption = 'Table Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Table Name", "No.", "Table Line No.", "Alternative Address Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }


}

