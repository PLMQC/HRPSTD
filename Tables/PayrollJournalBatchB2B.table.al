table 33001251 "Payroll Journal Batch B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Journal Batch';
    LookupPageID = "Payroll Journal Batch B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            NotBlank = true;
            TableRelation = "Payroll Journal Template B2B";
            DataClassification = CustomerContent;
        }
        field(2; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Reason Code" <> xRec."Reason Code" then begin
                    ModifyLines(FIELDNO("Reason Code"));
                    MODIFY();
                end;
            end;
        }
        field(5; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Bal. Account No." := '';
            end;
        }
        field(6; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Bal. Account Type" = "Bal. Account Type"::"G/L Account" then
                    CheckGLAcc("Bal. Account No.");
            end;
        }
        field(7; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "No. Series" <> '' then begin
                    GenJnlTemplate.GET("Journal Template Name");
                    if GenJnlTemplate.Recurring then
                        ERROR(Text000Lbl, FIELDCAPTION("Posting No. Series"));
                    if "No. Series" = "Posting No. Series" then
                        VALIDATE("Posting No. Series", '');
                end;
            end;
        }
        field(8; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(9; "Copy VAT Setup to Jnl. Lines"; Boolean)
        {
            Caption = 'Copy VAT Setup to Jnl. Lines';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(10; "Allow VAT Difference"; Boolean)
        {
            Caption = 'Allow VAT Difference';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", Name)
        {
        }
    }

    fieldgroups
    {
    }

    var
        GenJnlTemplate: Record "Payroll Journal Template B2B";
        GenJnlLine: Record "Payroll Payment Jnl Line B2B";
        Text000Lbl: Label 'Only the %1 field can be filled in on recurring journals.', Comment = '%1 = Posting No. Series';


    procedure SetupNewBatch();
    begin
        GenJnlTemplate.GET("Journal Template Name");
        "Bal. Account Type" := GenJnlTemplate."Bal. Account Type";
        "Bal. Account No." := GenJnlTemplate."Bal. Account No.";
        "No. Series" := GenJnlTemplate."No. Series";
        "Posting No. Series" := GenJnlTemplate."Posting No. Series";
        "Reason Code" := GenJnlTemplate."Reason Code";
        "Copy VAT Setup to Jnl. Lines" := GenJnlTemplate."Copy VAT Setup to Jnl. Lines";
        "Allow VAT Difference" := GenJnlTemplate."Allow VAT Difference";
    end;

    local procedure CheckGLAcc(AccNo: Code[20]);
    var
        GLAcc: Record "G/L Account";
    begin
        if AccNo <> '' then begin
            GLAcc.GET(AccNo);
            GLAcc.CheckGLAcc();
            GLAcc.TESTFIELD("Direct Posting", true);
        end;
    end;

    procedure ModifyLines(i: Integer);
    begin
        GenJnlLine.LOCKTABLE();
        GenJnlLine.SETRANGE("Payroll Journal Template", "Journal Template Name");
        GenJnlLine.SETRANGE("Payroll Journal Batch", Name);
        if GenJnlLine.FINDFIRST() then
            repeat
                case i of
                    FIELDNO("Reason Code"):
                        GenJnlLine.VALIDATE("Reason Code", "Reason Code");
                    FIELDNO("Posting No. Series"):
                        GenJnlLine.VALIDATE("Posting No. Series", "Posting No. Series");
                end;
                GenJnlLine.MODIFY(true);
            until GenJnlLine.NEXT() = 0;
    end;
}

