table 33001233 "Professional Tax Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Professional Tax Header';
    DataCaptionFields = "Branch Code";
    DrillDownPageID = "Prof.Tax Header List B2B";
    LookupPageID = "Prof.Tax Header List B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Branch Code", "Effective Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        ProfLine: Record "Professional Tax Line B2B";
    begin
        Employee.RESET();
        Employee.SETRANGE("PT Branch Code", "Branch Code");
        if Employee.FINDFIRST() then
            ERROR(Text001Lbl, "Branch Code");

        ProfLine.RESET();
        ProfLine.SETRANGE("Branch Code", "Branch Code");
        ProfLine.SETRANGE("Effective Date", "Effective Date");
        if ProfLine.FINDSET() then
            ProfLine.DELETEALL();
    end;

    trigger OnRename();
    var
        ProfLine: Record "Professional Tax Line B2B";
    begin
        ProfLine.RESET();
        ProfLine.SETRANGE("Branch Code", xRec."Branch Code");
        ProfLine.SETRANGE("Effective Date", xRec."Effective Date");
        if ProfLine.FINDSET() then
            repeat
                ProfLine.RENAME("Branch Code", "Effective Date", ProfLine."Line No.");
            until ProfLine.NEXT() = 0;
    end;

    var
        Employee: Record "Employee B2B";
        Text001Lbl: Label 'You cannot delete branch code %1, employees attached.', Comment = '%1 = Branch Code';
}

