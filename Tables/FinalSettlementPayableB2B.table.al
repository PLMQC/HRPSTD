table 33001259 "Final Settlement Payable B2B"
{
    // version B2BHR1.00.00

    Caption = 'Final Settlement Payable';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CreateDim(DATABASE::"Employee B2B", "Employee No.");
            end;
        }
        field(5; Month; Integer)
        {
            Caption = 'Month';
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
            DataClassification = CustomerContent;
        }
        field(17; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(32; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(33; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(34; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(35; "Pay Cadre"; Code[20])
        {
            Caption = 'PayCadre';
            DataClassification = CustomerContent;
        }
        field(42; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(43; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(47; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
        }
        field(48; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
        }
        field(49; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            DataClassification = CustomerContent;
        }
        field(50; "Pay Amount"; Decimal)
        {
            Caption = 'Pay Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(51; "Bank/Cash Account"; Code[20])
        {
            Caption = 'Bank/Cash Account';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(52; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            OptionCaption = ' ,Cash,Cheque,Bank Transfer';
            OptionMembers = " ",Cash,Cheque,"Bank Transfer";
            DataClassification = CustomerContent;
        }
        field(163; "Dimesion Code"; Code[20])
        {
            Caption = 'Dimesion Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(164; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                ShowDocDim();
            end;
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit 408;

    procedure CreateDim(Type1: Integer; No1: Code[20]);
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.GET();
        TableID[1] := Type1;
        No[1] := No1;

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(TableID, No, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

        if (OldDimSetID <> "Dimension Set ID") then
            MODIFY();
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        if "Employee No." <> '' then
            MODIFY();

        if OldDimSetID <> "Dimension Set ID" then
            MODIFY();
    end;

    procedure ShowDocDim();
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", CopyStr(STRSUBSTNO('%1 %2', Rec.TABLECAPTION(), "Employee No."), 1, 250),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then
            MODIFY();
    end;
}

