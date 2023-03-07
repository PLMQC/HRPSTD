table 33001240 "Final Settlement Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Final Settlement Line';
    LookupPageID = "Final Settlement List B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;

        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(5; "Pay Element Code"; Code[30])
        {
            Caption = 'Pay Element Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                FSHeader.RESET();
                FSHeader.SETRANGE(FSHeader."Employee No.", "Employee No.");
                if FSHeader.FINDFIRST() then begin
                    Month := FSHeader.Month;
                    Year := FSHeader.Year;
                    "Document Type" := "Document Type"::Payroll;
                    "Document No." := FSHeader."Document No.";
                    "Journal Template Name" := FSHeader."Journal Template Name";
                    "Journal Batch Name" := FSHeader."Journal Batch Name";
                    "Posting Date" := FSHeader."Posting Date";
                    FSLine.RESET();
                    FSLine.SETRANGE("Employee No.", "Employee No.");
                    if FSLine.FINDLAST() then
                        "Line No." := FSLine."Line No." + 10000
                    else
                        "Line No." := 10000;

                    Lookup_B2B.RESET();
                    Lookup_B2B.SETRANGE("Lookup Type", 16);
                    Lookup_B2B.SETRANGE("Lookup Name", "Pay Element Code");
                    if Lookup_B2B.FINDFIRST() then begin
                        "Addition/Deduction" := Lookup_B2B."Add/Deduct";
                        Description := copystr(Lookup_B2B.Description, 1, 50);
                    end;
                end;
            end;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(8; "Addition/Deduction"; Option)
        {
            Caption = 'Addition/Deduction';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(11; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(12; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(13; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(14; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
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
        field(16; "Shortcut Dimension 2 Code"; Code[20])
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
        field(17; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payroll';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Payroll;
            DataClassification = CustomerContent;
        }
        field(18; "Co. Contribution"; Decimal)
        {
            Caption = 'Co. Contribution';
            DataClassification = CustomerContent;
        }
        field(19; "Co. Contribution2"; Decimal)
        {
            Caption = 'Co. Contribution2';
            DataClassification = CustomerContent;
        }
        field(20; Salary; Decimal)
        {
            Caption = 'Salary';
            DataClassification = CustomerContent;
        }
        field(21; "Computation Type"; Code[50])
        {
            Caption = 'Computation Type';
            DataClassification = CustomerContent;
        }
        field(22; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(25; Sequence; Integer)
        {
            Caption = 'Sequence';
            InitValue = 10000;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(26; "PF Admin Charges"; Decimal)
        {
            Caption = 'PF Admin Charges';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(27; "EDLI Charges"; Decimal)
        {
            Caption = 'EDLI Charges';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(28; "RIFA Charges"; Decimal)
        {
            Caption = 'RIFA Charges';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(29; "From date"; Date)
        {
            Caption = 'From date';
            DataClassification = CustomerContent;
        }
        field(30; "To date"; Date)
        {
            Caption = 'To date';
            DataClassification = CustomerContent;
        }
        field(31; "Bonus Days"; Decimal)
        {
            Caption = 'Bonus Days';
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
        key(Key1; "Employee No.", "Line No.")
        {
        }
        key(Key2; Year, Month, "Employee No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        FSHeader: Record "Final Settlement Header B2B";
        FSLine: Record "Final Settlement Line B2B";
        Lookup_B2B: Record Lookup_B2B;
        DimMgt: Codeunit 408;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ShowDimensions();
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', "Employee No.", "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;
}

