table 33001399 "Expense Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Expense Line';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;

        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(9; "Expense Date"; Date)
        {
            Caption = 'Expense Date';
            DataClassification = CustomerContent;
        }
        field(10; "Component Type"; Code[20])
        {
            Caption = 'Component Type';
            TableRelation = "Components B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if not Components.GET("Component Type") then
                    CLEAR(Components);

                Description := Components.Description;
                ExpenseHeader.GET("Document No.");
                TravelGroups.SETRANGE(Category, ExpenseHeader."Category Code");
                TravelGroups.SETRANGE("City Type", ExpenseHeader."City Type");
                TravelGroups.SETRANGE(Component, "Component Type");
                if Components.GET("Component Type") and Components.Transport then
                    TravelGroups.SETRANGE("Mode of Transport", ExpenseHeader."Mode of Travel");
                TravelGroups.FINDLAST();
                if TravelGroups.Actuals then
                    "Amount Limits" := Amount
                else
                    "Amount Limits" := TravelGroups.Limits;
            end;
        }
        field(11; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(15; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                UpdateAmt();
            end;
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Currency Code" <> xRec."Currency Code" then
                    UpdateCurrencyFactor();
                UpdateAmt();
            end;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(34; "Amount Limits"; Decimal)
        {
            Caption = 'Amount Limits';
            DataClassification = CustomerContent;
        }
        field(35; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = CustomerContent;
        }
        field(36; "Approved Amount (LCY)"; Decimal)
        {
            Caption = 'Approved Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Component Type")
        {
            SumIndexFields = "Amount (LCY)", "Approved Amount (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatus();
    end;

    trigger OnInsert();
    begin
        TestStatus();
    end;

    trigger OnRename();
    begin
        ERROR(Text001Lbl);
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        Components: Record "Components B2B";
        Currency2: Record Currency;
        ExpenseHeader: Record "Expense Header B2B";
        TravelGroups: Record "Travel Groups B2B";
        DimMgt: Codeunit 408;
        Text001Lbl: Label 'You cannot Rename Expense Document.';


    local procedure UpdateCurrencyFactor();
    begin
        if "Currency Code" <> '' then
            "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE(), "Currency Code")
        else
            "Currency Factor" := 0;
    end;

    procedure TestStatus();
    begin
        ExpenseHeader.GET("Document No.");
        ExpenseHeader.TESTFIELD(Status, ExpenseHeader.Status::Open);
    end;

    local procedure UpdateAmt();
    begin
        Currency2.InitRoundingPrecision();
        if "Currency Code" <> '' then
            "Amount (LCY)" :=
              ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE(), "Currency Code",
                  Amount, "Currency Factor"),
                Currency2."Amount Rounding Precision")
        else
            "Amount (LCY)" :=
              ROUND(Amount, Currency2."Amount Rounding Precision");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions();
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1  %2', "Document No.", "Line No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;
}

