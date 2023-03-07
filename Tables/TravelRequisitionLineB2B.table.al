table 33001397 "Travel Requisition Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Travel Requisition Line';
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
        field(10; "Component Type"; Code[20])
        {
            Caption = 'Component Type';
            TableRelation = "Components B2B" WHERE(Active = CONST(true));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if not Components.GET("Component Type") then
                    CLEAR(Components);

                Description := Components.Description;
            end;
        }
        field(11; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;


            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(15; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                UpdateAmt();
            end;
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
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
                TestStatus();
                if "Currency Code" <> xRec."Currency Code" then
                    UpdateCurrencyFactor();
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
        DimMgt: Codeunit 408;
        Text001Lbl: Label 'You cannot Rename Requisition Document.';


    local procedure UpdateCurrencyFactor();
    begin
        if "Currency Code" <> '' then
            "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE(), "Currency Code")
        else
            "Currency Factor" := 0;
        UpdateAmt();
    end;

    procedure TestStatus();
    var
        TravelRequisition: Record "Travel Requisition B2B";
    begin
        TravelRequisition.GET("Document No.");
        TravelRequisition.TESTFIELD(Status, TravelRequisition.Status::Open);
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

