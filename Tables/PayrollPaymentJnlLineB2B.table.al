table 33001252 "Payroll Payment Jnl Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Payment Journal Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Payroll Journal Template"; Code[10])
        {
            Caption = 'Payroll Journal Template';
            TableRelation = "Payroll Journal Template B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Payroll Journal Batch"; Code[10])
        {
            Caption = 'Pay Journal Batch';
            TableRelation = "Payroll Journal Batch B2B".Name WHERE("Journal Template Name" = FIELD("Payroll Journal Template"));
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Posting,FullFinal,Reimbursement,Payment';
            OptionMembers = " ",Posting,FullFinal,Reimbursement,Payment;
            DataClassification = CustomerContent;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(6; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'Employee,G/L Account,Bank Account';
            OptionMembers = Employee,"G/L Account","Bank Account";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Account Type" in ["Account Type"::Employee]) and
                   ("Bal. Account Type" in ["Bal. Account Type"::Employee])
                then
                    ERROR(Text000Lbl, FIELDCAPTION("Account Type"), FIELDCAPTION("Bal. Account Type"));

                VALIDATE("Account No.", '');

                if "Account Type" in ["Account Type"::Employee, "Account Type"::"Bank Account"] then begin
                    VALIDATE("Pay Bus. Posting Group", '');
                    VALIDATE("Pay Prod. Posting Group", '');
                end else
                    if "Bal. Account Type" in ["Bal. Account Type"::"G/L Account", "Account Type"::"Bank Account"] then;
            end;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = FILTER("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Account Type" = FILTER(Employee)) Employee."No.";
            DataClassification = CustomerContent;
        }
        field(8; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(9; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
            DataClassification = CustomerContent;
        }
        field(10; "Posting Month"; Integer)
        {
            Caption = 'Posting Month';
            DataClassification = CustomerContent;
        }
        field(11; "Posting Year"; Integer)
        {
            Caption = 'Posting Year';
            DataClassification = CustomerContent;
        }
        field(12; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(13; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'Employee,G/L Account,Bank Account';
            OptionMembers = Employee,"G/L Account","Bank Account";
            DataClassification = CustomerContent;
        }
        field(14; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = FILTER("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Bal. Account Type" = FILTER(Employee)) Employee."No.";
            DataClassification = CustomerContent;
        }
        field(15; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(16; "Original Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Original Amount';
            DataClassification = CustomerContent;
        }
        field(17; "Original Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Original Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(18; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
        }
        field(20; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(21; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Employee,Bank Account';
            OptionMembers = " ",Employee,"Bank Account";
            DataClassification = CustomerContent;
        }
        field(22; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = CustomerContent;
        }
        field(23; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Posting,FullFinal,Reimbursement,Payment';
            OptionMembers = " ",Posting,FullFinal,Reimbursement,Payment;
            DataClassification = CustomerContent;
        }
        field(24; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = CustomerContent;
        }
        field(25; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = CustomerContent;
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(27; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(28; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
        }
        field(29; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
        }
        field(30; "Pay Bus. Posting Group"; Code[20])
        {
            Caption = 'Pay Bus. Posting Group';
            TableRelation = "Payroll Bus. Post Group B2B";
            DataClassification = CustomerContent;
        }
        field(31; "Pay Prod. Posting Group"; Code[20])
        {
            Caption = 'Pay Prod. Posting Group';
            TableRelation = "Payroll Prod. Post. Group B2B";
            DataClassification = CustomerContent;
        }
        field(32; "Emp Posting Group"; Code[20])
        {
            Caption = 'Emp Posting Group';
            Editable = false;
            TableRelation = IF ("Account Type" = FILTER(Employee)) "Employee Posting Group B2B".Code;
            DataClassification = CustomerContent;
        }
        field(33; "Bal. Pay Bus. Posting Group"; Code[20])
        {
            Caption = 'Bal. Pay Bus. Posting Group';
            TableRelation = "Payroll Bus. Post Group B2B";
            DataClassification = CustomerContent;
        }
        field(34; "Bal. Pay Prod. Posting Group"; Code[20])
        {
            Caption = 'Bal. Pay Prod. Posting Group';
            TableRelation = "Payroll Prod. Post. Group B2B";
            DataClassification = CustomerContent;
        }
        field(35; "Bal. Emp Posting Group"; Code[200])
        {
            Caption = 'Bal. Emp Posting Group';
            TableRelation = IF ("Account Type" = FILTER(Employee)) "Employee Posting Group B2B".Code;
            DataClassification = CustomerContent;
        }
        field(36; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(37; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                ShowDimensions();
            end;
        }
    }

    keys
    {
        key(Key1; "Payroll Journal Template", "Payroll Journal Batch", "Line No.")
        {
        }
        key(Key2; "Payroll Journal Template", "Payroll Journal Batch", "Posting Date", "Document No.")
        {
        }
        key(Key3; "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        LOCKTABLE();
        GenJnlTemplate.GET("Payroll Journal Template");
        GenJnlBatch.GET(GenJnlBatch."Journal Template Name", "Payroll Journal Batch");
        ValidateShortcutDimCode(1, "Global Dimension 1 Code");
        ValidateShortcutDimCode(2, "Global Dimension 2 Code");
    end;

    var
        GenJnlTemplate: Record "Payroll Journal Template B2B";
        GenJnlBatch: Record "Payroll Journal Batch B2B";
        DimMgt: Codeunit 408;
        Text000Lbl: Label '%1 or %2 must be G/L Account or Bank Account.', Comment = '%1 = Account Type ; %2 = Bal. Account Type';

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ShowDimensions();
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2 %3', "Payroll Journal Template", "Payroll Journal Batch", "Line No."),
            "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;
}

