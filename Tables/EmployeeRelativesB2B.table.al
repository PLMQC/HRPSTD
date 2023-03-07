table 33001280 "Employee Relatives B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Relative B2B';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "LOP Adjustment - Deduction B2B";
    LookupPageID = "LOP Adjustment - Deduction B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            DataClassification = CustomerContent;
            //TableRelation = "Employee B2B";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Relative Code"; Code[20])
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
            DataClassification = CustomerContent;
            Caption = 'Last Name';
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
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
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
        field(20; Relative; Boolean)
        {
            Caption = 'Relative';
            DataClassification = CustomerContent;
        }
        field(21; "Reference Name"; Text[50])
        {
            Caption = 'Reference Name';
            DataClassification = CustomerContent;
        }
        field(22; Address1; Text[50])
        {
            Caption = 'Address1';
            DataClassification = CustomerContent;
        }
        field(23; Address2; Text[50])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;
        }
        field(24; Occupation; Text[50])
        {
            Caption = 'Occupation';
            DataClassification = CustomerContent;
        }
        field(25; "Years Known"; Decimal)
        {
            Caption = 'Years Known';
            DataClassification = CustomerContent;
        }
        field(26; "Contact Number"; Text[30])
        {
            Caption = 'Contact Number';
            DataClassification = CustomerContent;
        }
        field(27; "Age in Years"; Decimal)
        {
            BlankZero = true;
            Caption = 'Age in Years';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(28; "Relative Type"; Option)
        {
            Caption = 'Relative Type';
            OptionCaption = 'Relative,Other than Relative';
            OptionMembers = Relative,"Other than Relative";
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
        HRCommentLine: Record "HR Comment Line B2B";
    begin
        HRCommentLine.SETRANGE("Table Name", HRCommentLine."Table Name"::"Employee Relative B2B");
        HRCommentLine.SETRANGE("No.", "Employee No.");
        HRCommentLine.DELETEALL();
    end;
}

