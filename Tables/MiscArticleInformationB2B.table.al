table 33001383 "Misc. Article Information B2B"
{
    // version B2BHR1.00.00

    Caption= 'Misc. Article Information';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Misc. Article Information B2B";
    LookupPageID = "Misc. Article Information B2B";
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
        field(2; "Misc. Article Code"; Code[30])
        {
            Caption='Misc. Article Code';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(27));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Lookup_B2B.SETRANGE("Lookup Name", "Misc. Article Code");
                if Lookup_B2B.FINDFIRST() then
                    Description := CopyStr(Lookup_B2B.Description, 1, 50);

            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption='Line No.';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            Caption='Description';
            DataClassification = CustomerContent;
        }
        field(5; "From Date"; Date)
        {
            Caption='From Date';
            DataClassification = CustomerContent;
        }
        field(6; "To Date"; Date)
        {
            Caption='To Date';
            DataClassification = CustomerContent;
        }
        field(7; "In Use"; Boolean)
        {
            Caption='In Use';
            DataClassification = CustomerContent;
        }
        field(8; Comment; Boolean)
        {
            CalcFormula = Exist ("HR Comment Line B2B" WHERE("Table Name" = CONST("Misc. Article Information B2B"),
                                                         "No." = FIELD("Employee No."),
                                                         "Alternative Address Code" = FIELD("Misc. Article Code"),
                                                         "Table Line No." = FIELD("Line No.")));
            Caption='Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Serial No."; Text[30])
        {
            Caption='Serial No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Misc. Article Code", "Line No.")
        {
        }
        key(Key2; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        HRCommentLine.RESET();
        HRCommentLine.SETRANGE("Table Name", HRCommentLine."Table Name"::"Misc. Article Information B2B");
        HRCommentLine.SETRANGE("No.", "Employee No.");
        HRCommentLine.SETRANGE("Table Line No.", "Line No.");
        HRCommentLine.DELETEALL();
    end;

    trigger OnInsert();
    var
        MiscArticleInfo: Record "Misc. Article Information B2B";
    begin
        MiscArticleInfo.SETCURRENTKEY("Line No.");
        if MiscArticleInfo.FINDLAST() then
            "Line No." := MiscArticleInfo."Line No." + 1
        else
            "Line No." := 1;
    end;

    var

        Lookup_B2B: Record Lookup_B2B;
        HRCommentLine: Record "HR Comment Line B2B";


}

