table 33001346 "Excemption Sections B2B"
{
    // version B2BHR1.00.00

    Caption = 'Excemption Sections';
    LookupPageID = "Excemption Sections B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Section ID"; Code[20])
        {
            Caption = 'Section ID';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Chapter ID"; Code[20])
        {
            Caption = 'Chapter ID';
            TableRelation = "IT Chapters B2B";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Section ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "Section ID" = '' then
            ERROR('');
    end;

    trigger OnRename();
    begin
        if xRec."Section ID" <> "Section ID" then begin
            ExepDedGrGRec.RESET();
            ExepDedGrGRec.SETRANGE("Section ID", xRec."Section ID");
            if ExepDedGrGRec.FINDFIRST() then
                ERROR(Text001Lbl, xRec."Section ID");
        end;
    end;

    var
        ExepDedGrGRec: Record "Exep/Ded Groups B2B";
        IncomeTaxRebateGRec: Record "Income Tax Rebate Setup B2B";
        IncomeTaxrebateListFormGVar: Page "Income Tax Rebate Setup B2B";
        IncomeTaxrebateFormGVar: Page "Income Tax Rebate Setup B2B";
        Text001Lbl: Label 'Section ID %1 already exsists in Ded/Exemption Groups', Comment = '%1 = Section Id';

    procedure ShowRebateDetails();
    begin
        TESTFIELD("Chapter ID", '');

        CLEAR(IncomeTaxrebateListFormGVar);
        CLEAR(IncomeTaxrebateFormGVar);

        IncomeTaxRebateGRec.RESET();
        IncomeTaxRebateGRec.SETCURRENTKEY("Document Type", "Section ID", "Rebate Year Starting Date", "Rebate Year Ending Date");
        IncomeTaxRebateGRec.SETRANGE("Document Type", IncomeTaxRebateGRec."Document Type"::Rebate);
        IncomeTaxRebateGRec.SETRANGE("Section ID", "Section ID");

        if GuiAllowed() then begin
            IncomeTaxrebateListFormGVar.SETTABLEVIEW(IncomeTaxRebateGRec);
            IncomeTaxrebateListFormGVar.RUNMODAL()
        end else begin
            IncomeTaxrebateFormGVar.SETTABLEVIEW(IncomeTaxRebateGRec);
            IncomeTaxrebateFormGVar.RUNMODAL()
        end;
    end;
}

