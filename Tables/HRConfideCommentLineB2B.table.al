table 33001385 "HR Confide Comment Line B2B"
{
    // version B2BHR1.00.00

    Caption='HR Confidential Comment Line';
    DataCaptionFields = "No.";
    DrillDownPageID = "HR Confi. Comment Sheet_ B2B";
    LookupPageID = "HR Confi. Comment Sheet_ B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption= 'Table Name';
            OptionCaption='Confidential Information_b2b';
            OptionMembers = "Confidential Information B2B";
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption='No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Code"; Code[30])
        {
            Caption='Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE ("Lookup Type" = CONST (25));
            DataClassification = CustomerContent;
        }
        field(4; "Table Line No."; Integer)
        {
            Caption='Table Line No.';
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption='Line No.';
            DataClassification = CustomerContent;
        }
        field(7; Date; Date)
        {
            Caption= 'Date';
            DataClassification = CustomerContent;
        }
        field(9; Comment; Text[80])
        {
            Caption='Comment';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Table Name", "No.", "Code", "Table Line No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetUpNewLine();
    var
        HRConfCommentLine: Record "HR Confide Comment Line B2B";
    begin
        HRConfCommentLine := Rec;
        HRConfCommentLine.SETRECFILTER();
        HRConfCommentLine.SETRANGE("Line No.");
        HRConfCommentLine.SETRANGE(Date, WORKDATE());
        if HRConfCommentLine.IsEmpty() then
            Date := WORKDATE();
    end;
}

