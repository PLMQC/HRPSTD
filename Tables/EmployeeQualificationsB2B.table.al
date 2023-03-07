table 33001279 "Employee Qualifications B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Qualification B2B';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Employee Qualifications B2B";
    //LookupPageID = 33001208;//Phani
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
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Qualification Code"; Code[20])
        {
            Caption = 'Qualification Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                LookupRec.RESET();
                LookupRec.SETRANGE("Lookup Type", 2);
                LookupRec.SETRANGE("Lookup Name", "Qualification Code");
                if LookupRec.FINDFIRST() then
                    Description := Copystr(LookupRec.Description, 1, 50);
            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "Institution/Company"; Text[50])
        {
            Caption = 'Institution/Company';
            DataClassification = CustomerContent;
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
            DataClassification = CustomerContent;
        }
        field(10; "Course Grade"; Text[50])
        {
            Caption = 'Course Grade';
            DataClassification = CustomerContent;
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
            DataClassification = CustomerContent;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = Exist ("HR Comment Line B2B" WHERE("Table Name" = CONST("Employee Qualification B2B"),
                                                         "No." = FIELD("Employee No."),
                                                         "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(14; "Qualification Type"; Option)
        {
            Caption = 'Qualification Type';
            OptionCaption = 'Qualification,Experience';
            OptionMembers = Qualification,Experience;
            DataClassification = CustomerContent;
        }
        field(15; "Year of Passing"; Integer)
        {
            Caption = 'Year of Passing';
            DataClassification = CustomerContent;
        }
        field(16; Designation; Code[20])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(17; "Gross Salary"; Decimal)
        {
            Caption = 'Gross Salary';
            DataClassification = CustomerContent;
        }
        field(18; Occupation; Code[20])
        {
            Caption = 'Occupation';
            DataClassification = CustomerContent;
        }
        field(19; Class; Text[30])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
        }
        key(Key2; "Qualification Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if Comment then
            ERROR(Text000Lbl);
    end;

    trigger OnInsert();
    begin
        Employee.GET("Employee No.");
        "Employee Status" := Employee.Status;
    end;

    var
        Employee: Record "Employee B2B";
        LookupRec: Record Lookup_B2B;
        Text000Lbl: Label 'You cannot delete employee qualification information if there are comments associated with it.';
}

