table 33001384 "Confidential Information B2B"
{
    // version B2BHR1.00.00

    Caption='Confidential Information_B2B';
    DataCaptionFields = "Employee No.";
    LookupPageID = "Confidential Information B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption='Employee No.';
            NotBlank = true;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Confidential Code"; Code[30])
        {
            Caption= 'Confidential Code';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(25));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Lookup_B2B.SETRANGE("Lookup Name", "Confidential Code");
                if Lookup_B2B.FINDFIRST() then
                    Description := CopyStr(Lookup_B2B.Description, 1, 50);

            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption='Line No.';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            Caption='Description';
            DataClassification = CustomerContent;
        }
        field(5; Comment; Boolean)
        {
            CalcFormula = Exist ("HR Confide Comment Line B2B" WHERE("Table Name" = CONST("Confidential Information B2B"),
                                                                        "No." = FIELD("Employee No."),
                                                                        "Table Line No." = FIELD("Line No.")));
            Caption= 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Confidential Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        HRConfidentCmtLine.RESET();
        HRConfidentCmtLine.SETRANGE("Table Name", HRConfidentCmtLine."Table Name"::"Confidential Information B2B");
        HRConfidentCmtLine.SETRANGE("No.", "Employee No.");
        HRConfidentCmtLine.SETRANGE(Code, "Confidential Code");
        HRConfidentCmtLine.SETRANGE("Table Line No.", "Line No.");
        HRConfidentCmtLine.DELETEALL();
    end;

    var
        Lookup_B2B: Record Lookup_B2B;
        HRConfidentCmtLine: Record "HR Confide Comment Line B2B";
}

