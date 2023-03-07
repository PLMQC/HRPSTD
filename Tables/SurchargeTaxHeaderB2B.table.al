table 33001376 "Surcharge Tax Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Surcharge Tax Header';
    DataCaptionFields = "Branch Code";
    DrillDownPageID = "Surcharge Tax List B2B";
    LookupPageID = "Surcharge Tax List B2B";
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

            trigger OnValidate();
            begin
            end;
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
        SurchargeTaxLine: Record "Surcharge Tax Line B2B";
    begin
        SurchargeTaxLine.RESET();
        SurchargeTaxLine.SETRANGE("Branch Code", "Branch Code");
        SurchargeTaxLine.SETRANGE("Effective Date", "Effective Date");
        if SurchargeTaxLine.FINDSET() then
            SurchargeTaxLine.DELETEALL();
    end;

    trigger OnRename();
    begin
    end;
}

