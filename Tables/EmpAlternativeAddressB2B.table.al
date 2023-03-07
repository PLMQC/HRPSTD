table 33001262 "Emp Alternative Address B2B"
{
    // version B2BHR1.00.00

    Caption = 'Alternative Address';
    DataCaptionFields = "Employee No.", Name, "Code";
    DrillDownPageID = "Emp Alternative Add List B2B";
    LookupPageID = "Emp Alternative Add List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Employee.GET("Employee No.");
                Name := Employee."Last Name";
            end;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED());
            end;
        }
        field(8; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED());
            end;
        }
        field(9; County; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(10; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(11; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = CustomerContent;
        }
        field(12; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = Exist ("Human Resource Comment Line" WHERE("Table Name" = CONST("Alternative Address"),
                                                                     "No." = FIELD("Employee No."),
                                                                     "Alternative Address Code" = FIELD(Code)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(15; "Permanent Address"; Boolean)
        {
            Caption = 'Permanent Address';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
        Employee: Record "Employee B2B";
}

