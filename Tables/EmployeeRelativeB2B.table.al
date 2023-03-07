table 33001382 "Employee Relative B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Relative';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Family Details & Relation B2B";
    LookupPageID = "Family Details & Relation B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;

            TableRelation = IF (Type = CONST(Employee)) "Employee B2B"
            ELSE
            IF (Type = CONST(Resume)) "Resume Database B2B";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Relative Code"; Code[30])
        {
            Caption = 'Relative Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(26));
            DataClassification = CustomerContent;
        }
        field(4; "First Name"; Text[30])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(5; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }
        field(6; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(7; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
            DataClassification = CustomerContent;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
        }
        field(9; "Relatives Employee No."; Code[20])
        {
            Caption = 'Relative''s Employee No.';
            DataClassification = CustomerContent;

            TableRelation = IF (Type = CONST(Employee)) "Employee B2B"
            ELSE
            IF (Type = CONST(Resume)) "Resume Database B2B";
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = Exist ("HR Comment Line B2B" WHERE("Table Name" = CONST("Employee Relative B2B"),
                                                         "No." = FIELD("Employee No."),
                                                         "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Relative; Boolean)
        {
            Caption = 'Relative';
            DataClassification = CustomerContent;
        }
        field(12; "Reference Name"; Text[50])
        {
            Caption = 'Reference Name';
            DataClassification = CustomerContent;
        }
        field(13; Address1; Text[50])
        {
            Caption = 'Address1';
            DataClassification = CustomerContent;
        }
        field(14; Address2; Text[50])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;
        }
        field(15; Occupation; Text[50])
        {
            Caption = 'Occupation';
            DataClassification = CustomerContent;
        }
        field(16; "Years Known"; Decimal)
        {
            Caption = 'Years Known';
            DataClassification = CustomerContent;
        }
        field(17; "Contact Number"; Text[30])
        {
            Caption = 'Contact Number';
            DataClassification = CustomerContent;
        }
        field(18; "Age in Years"; Decimal)
        {
            BlankZero = true;
            Caption = 'Age in Years';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Relative Type"; Option)
        {
            Caption = 'Relative Type';
            OptionCaption = 'Relative,Other than Relative';
            OptionMembers = Relative,"Other than Relative";
            DataClassification = CustomerContent;
        }
        field(25; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resume,Employee';
            OptionMembers = Resume,Employee;
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SETRANGE("Table Name", HRCommentLine."Table Name"::"Employee Relative");
        HRCommentLine.SETRANGE("No.", "Employee No.");
        HRCommentLine.DELETEALL();
    end;
}

