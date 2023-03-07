table 33001347 "Exep/Ded Groups B2B"
{
    // version B2BHR1.00.00

    Caption = 'Exep/Ded Groups';
    LookupPageID = "Exep/Ded Groups B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Exemp / Ded Group Id"; Code[20])
        {
            Caption = 'Exemp / Ded Group Id';
            DataClassification = CustomerContent;
        }
        field(2; "Section ID"; Code[20])
        {
            Caption = 'Section ID';
            TableRelation = "Excemption Sections B2B";
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Pay Element Code"; Code[30])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Exemp / Ded Group Id")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "Exemp / Ded Group Id" = '' then
            ERROR('');
    end;

    trigger OnRename();
    begin
        if xRec."Exemp / Ded Group Id" <> "Exemp / Ded Group Id" then begin
            TDSSavingsGRec.RESET();
            TDSSavingsGRec.SETRANGE("Exemption Group Id", xRec."Exemp / Ded Group Id");
            if TDSSavingsGRec.FINDFIRST() then
                ERROR(Text006Lbl, xRec."Exemp / Ded Group Id");
        end;
    end;

    var

        TDSSavingsGRec: Record "TDS Savings B2B";

        Text006Lbl: Label 'TDS Savings already exists for this Exep / Ded Group ID %1', Comment = '%1 = GroupID';
}

