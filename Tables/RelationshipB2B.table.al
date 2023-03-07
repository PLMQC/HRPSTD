table 33001368 Relationship_B2B
{
    // version B2BHR1.00.00

    Caption = 'Relationship';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Relative Code"; Code[10])
        {
            Caption = 'Relative Code';
            TableRelation = Relative;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Relative Code" <> '' then
                    Relative := true
                else
                    Relative := false;
            end;
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
            trigger OnValidate();
            begin
                "Age in Years" := (DATE2DMY(WORKDATE(), 3) - DATE2DMY("Birth Date", 3));
            end;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
        }
        field(9; "Relative's Employee No."; Code[20])
        {
            Caption = 'Relative''s Employee No.';
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = Exist ("Human Resource Comment Line" WHERE("Table Name" = CONST("Employee Relative"),
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
}

