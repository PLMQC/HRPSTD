table 33001320 "Employee Confirmation Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Confirmation Line_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                TestHeaderStatus();
            end;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
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
                    Description := copystr(Lookup_B2B.Description, 1, 50);
                    if "Pay Element" = BASICTxt then
                        "Computation Type" := OnAttTxt;
                end;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(5; "Fixed / Percent"; Option)
        {
            Caption = 'Fixed / Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(6; "Amount / Percent"; Decimal)
        {
            Caption = 'Amount / Percent';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(7; "Revised Amount / Percent"; Decimal)
        {
            Caption = 'Revised Amount / Percent';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(8; "Computation Type"; Code[50])
        {
            Caption = 'Computation Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('COMPUTATION TYPE'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(9; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(10; "Revised Date"; Date)
        {
            Caption = 'Revised Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(11; "Arrear Amount"; Decimal)
        {
            Caption = 'Arrear Amount';
            DataClassification = CustomerContent;
        }
        field(12; "Pay Cadre"; Code[30])
        {
            Caption = 'Pay Cadre';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(13; "Header No."; Code[20])
        {
            Caption = 'Header No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(14; "Revised Fixed / Percent"; Option)
        {
            Caption = 'Revised Fixed / Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(15; "Revised Computation Type"; Code[50])
        {
            Caption = 'Revised Computation Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('COMPUTATION TYPE'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(16; "Confirmation Date"; Date)
        {
            Caption = 'Confirmation Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(17; "No."; Code[30])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(19; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
        }
        field(20; "Modified PayElement"; Boolean)
        {
            Caption = 'Modified PayElement';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestHeaderStatus();
            end;
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
        field(30; "Revised Pay Element"; Code[30])
        {
            Caption = 'Revised Pay Element';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));
            DataClassification = CustomerContent;
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
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
    }

    keys
    {
        key(Key1; "Header No.", "No.", "Pay Element", "Revised Date", "Line No.")
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
    end;

    trigger OnRename();
    begin
        TestHeaderStatus();
    end;

    var
        Lookup_B2B: Record Lookup_B2B;
        BASICTxt: Label 'BASIC';
        OnAttTxt: Label 'ON ATTENDANCE';

    procedure TestHeaderStatus();
    var
        EmpConfirmHeader: Record "Employee Confirm. Header B2B";
    begin
        EmpConfirmHeader.RESET();
        EmpConfirmHeader.SETRANGE("Confirmation ID", "Header No.");
        EmpConfirmHeader.SETRANGE("Employee ID", "No.");
        if EmpConfirmHeader.FINDFIRST() then
            EmpConfirmHeader.TESTFIELD(Status, EmpConfirmHeader.Status::Open);
    end;
}

