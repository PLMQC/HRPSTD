table 33001401 "Posted Travel Req. Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Travel Requisition Line';
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
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption='Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            DataClassification = CustomerContent;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption= 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            DataClassification = CustomerContent;
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption= 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption= 'Currency Factor';
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

    var
        DimMgt: Codeunit 408;

    procedure ShowDimensions();
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", CopyStr(STRSUBSTNO('%1 %2 %3', TABLECAPTION(), "Document No.", "Line No."), 1, 250));
    end;
}

