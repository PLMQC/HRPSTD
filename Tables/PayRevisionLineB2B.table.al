table 33001238 "Pay Revision Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Revision Line';
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; "Pay Element"; Code[30])
        {
            Caption = 'Pay Element';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
                Lookup_B2B.SETRANGE("Lookup Name", "Pay Element");
                if Lookup_B2B.FINDFIRST() then begin
                    "Add/Deduct" := Lookup_B2B."Add/Deduct";
                    Description := Lookup_B2B.Description;
                    if "Pay Element" = BASICTxt then
                        "Computation Type" := OnAttTxt;
                end;
            end;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Fixed / Percent"; Option)
        {
            Caption = 'Fixed / Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;
        }
        field(6; "Amount / Percent"; Decimal)
        {
            Caption = 'Amount / Percent';
            DataClassification = CustomerContent;
        }
        field(7; "Revised Amount / Percent"; Decimal)
        {
            Caption = 'Revised Amount / Percent';
            DataClassification = CustomerContent;
        }
        field(8; "Computation Type"; Code[50])
        {
            Caption = 'Computation Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('COMPUTATION TYPE'));
            DataClassification = CustomerContent;
        }
        field(9; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(10; "Revised Date"; Date)
        {
            Caption = 'Revised Date';
            DataClassification = CustomerContent;
        }
        field(11; "Arrear Amount"; Decimal)
        {
            Caption = 'Arrear Amount';
            DataClassification = CustomerContent;
        }
        field(12; Grade; Code[30])
        {
            Caption = 'Grade';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(13; "Header No."; Code[20])
        {
            Caption = 'Header No.';
            DataClassification = CustomerContent;
        }
        field(14; "Revised Fixed / Percent"; Option)
        {
            Caption = 'Revised Fixed / Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;
        }
        field(15; "Revised Computation Type"; Code[50])
        {
            Caption = 'Revised Computation Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('COMPUTATION TYPE'));
            DataClassification = CustomerContent;
        }
        field(16; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
        }
        field(17; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(18; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Grade,All';
            OptionMembers = Employee,Grade,All;
            DataClassification = CustomerContent;
        }
        field(19; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(20; "Modified PayElement"; Boolean)
        {
            Caption = 'Modified PayElement';
            DataClassification = CustomerContent;
        }
        field(21; "Arrear Inserted"; Boolean)
        {
            Caption = 'Arrear Inserted';
            DataClassification = CustomerContent;
        }
        field(22; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(23; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(24; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(25; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
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
        field(31; "Shortcut Dimension 2 Code"; Code[20])
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
        field(32; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payroll';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Payroll;
            DataClassification = CustomerContent;
        }
        field(33; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(53; "Arrear Co. Contribution"; Decimal)
        {
            Caption = 'Arrear Co. Contribution';
            DataClassification = CustomerContent;
        }
        field(54; "Arrear Co. Contribution2"; Decimal)
        {
            Caption = 'Arrear Co. Contribution2';
            DataClassification = CustomerContent;
        }
        field(55; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(56; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(57; "Dimension Set ID"; Integer)
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
        field(61; "Revision ID"; Code[20])
        {
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(Key1; "Header No.", "Line No.")
        {
        }
        key(Key2; "No.", "Pay Element")
        {
        }
        key(Key3; "Add/Deduct", "Pay Element")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestHeaderStatus();
        RemodifyProcessesal();
    end;

    trigger OnInsert();
    begin
        TestHeaderStatus();
    end;

    trigger OnModify();
    begin
        TestHeaderStatus();
    end;

    trigger OnRename();
    begin
        TestHeaderStatus();
    end;

    var
        Lookup_B2B: Record Lookup_B2B;
        DimMgt: Codeunit 408;
        BASICTxt: Label 'BASIC';
        OnAttTxt: Label 'ON ATTENDANCE';

    procedure TestHeaderStatus();
    var
        PayRevisionHeader: Record "Pay Revision Header B2B";
    begin
        PayRevisionHeader.SETRANGE("Id.", "Header No.");
        PayRevisionHeader.SETRANGE(Type, Type);
        PayRevisionHeader.SETRANGE("No.", "No.");
        if PayRevisionHeader.FINDFIRST() then
            PayRevisionHeader.TESTFIELD(Status, PayRevisionHeader.Status::Open);
    end;

    procedure RemodifyProcessesal();
    var
        ProcessedSalary: Record "Processed Salary B2B";
        StartMonth: Integer;
        StartYear: Integer;
    begin
        StartMonth := DATE2DMY("Effective Date", 2);
        StartYear := DATE2DMY("Effective Date", 3);
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", "No.");
        ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', StartMonth);
        ProcessedSalary.SETFILTER(Year, '>=%1', StartYear);
        ProcessedSalary.SETRANGE("Arrears Not Posted", true);
        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
        if ProcessedSalary.FINDFIRST() then
            repeat
                ProcessedSalary."Arrear Amount" := 0;
                ProcessedSalary."Arrears Not Posted" := false;
                ProcessedSalary."Arrear Co. Contribution" := 0;
                ProcessedSalary."Arrear Co. Contribution2" := 0;
                ProcessedSalary."Arrear Salary" := 0;
                ProcessedSalary.MODIFY();
            until ProcessedSalary.NEXT() = 0;

    end;

    procedure ShowDimensions();
    var
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', "Header No.", "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;
}

