table 33001227 "Processed Salary B2B"
{
    // version B2BHR1.00.00

    Caption = 'Processed Salary';
    DrillDownPageID = "Processed Salary List B2B";
    LookupPageID = "Processed Salary List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;
        }
        field(4; "Computation Type"; Code[50])
        {
            Caption = 'Computation Type';
            DataClassification = CustomerContent;
        }
        field(5; "Add/Deduct Code"; Code[30])
        {
            Caption = 'Add/Deduct Code';
            DataClassification = CustomerContent;
        }
        field(6; "Loan Priority No"; Integer)
        {
            Caption = 'Loan Priority No';
            DataClassification = CustomerContent;
        }
        field(8; "Earned Amount"; Decimal)
        {
            Caption = 'Earned Amount';
            DataClassification = CustomerContent;
        }
        field(12; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(13; Attendance; Decimal)
        {
            Caption = 'Attendance';
            DataClassification = CustomerContent;
        }
        field(14; Days; Integer)
        {
            Caption = 'Days';
            DataClassification = CustomerContent;
        }
        field(15; "Pay Slip Month"; Integer)
        {
            Caption = 'Pay Slip Month';
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
            DataClassification = CustomerContent;
        }
        field(16; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(17; Check; Boolean)
        {
            Caption = 'Check';
            DataClassification = CustomerContent;
        }
        field(18; "Co. Contributions"; Decimal)
        {
            Caption = 'Co. Contributions';
            DataClassification = CustomerContent;
        }
        field(19; "Co. Contribution2"; Decimal)
        {
            Caption = 'Co. Contribution2';
            DataClassification = CustomerContent;
        }
        field(20; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(21; Salary; Decimal)
        {
            Caption = 'Salary';
            DataClassification = CustomerContent;
        }
        field(24; "Loan Id"; Code[20])
        {
            Caption = 'Loan Id';
            DataClassification = CustomerContent;
        }
        field(25; "Bonus/Exgratia"; Decimal)
        {
            Caption = 'Bonus/Exgratia';
            DataClassification = CustomerContent;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
            DataClassification = CustomerContent;
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
            DataClassification = CustomerContent;
        }
        field(42; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payroll';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Payroll;
            DataClassification = CustomerContent;
        }
        field(43; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(44; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
        }
        field(45; "Arrear Amount"; Decimal)
        {
            Caption = 'Arrear Amount';
            DataClassification = CustomerContent;
        }
        field(46; "Arrears Not Posted"; Boolean)
        {
            Caption = 'Arrears Not Posted';
            DataClassification = CustomerContent;
        }
        field(47; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(48; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(49; "Pay Cadre"; Code[30])
        {
            Caption = 'Pay Cadre';
            DataClassification = CustomerContent;
        }
        field(50; "PF Admin Charges"; Decimal)
        {
            Caption = 'PF Admin Charges';
            DataClassification = CustomerContent;
        }
        field(51; "EDLI Charges"; Decimal)
        {
            Caption = 'EDLI Charges';
            DataClassification = CustomerContent;
        }
        field(52; "RIFA Charges"; Decimal)
        {
            Caption = 'RIFA Charges';
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
        field(55; "Arrear Salary"; Decimal)
        {
            Caption = 'Arrear Salary';
            DataClassification = CustomerContent;
        }
        field(103; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(104; "LOP Adjustment"; Boolean)
        {
            Caption = 'LOP Adjustment';
            DataClassification = CustomerContent;
        }
        field(105; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ShowDimensions();
            end;
        }
        field(106; "Shortcut Dim 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dim 4 Code';
            DataClassification = CustomerContent;
        }
        field(107; "Shortcut Dim 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dim 2 Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.")
        {
        }
        key(Key2; "Employee Code", "Add/Deduct Code", "Pay Slip Month", Year, "Add/Deduct", "Earned Amount")
        {
            SumIndexFields = "Earned Amount";
        }
        key(Key3; "Employee Code", Year, "Pay Slip Month", "Add/Deduct")
        {
            SumIndexFields = "Earned Amount";
        }
        key(Key4; "Add/Deduct", "Add/Deduct Code")
        {
        }
        key(Key5; "Employee Code", "Pay Slip Month", Year, Posted)
        {
        }
        key(Key6; "Employee Code")
        {
        }
        key(Key7; "Employee Code", "Document Type", "Loan Id")
        {
            SumIndexFields = "Earned Amount";
        }
        key(Key8; "Employee Code", "Add/Deduct", "Add/Deduct Code", "Arrear Amount", "Arrears Not Posted")
        {
            SumIndexFields = "Arrear Amount";
        }
        key(Key9; "Shortcut Dim 4 Code", "Shortcut Dim 2 Code", "Add/Deduct Code")
        {
        }
    }

    fieldgroups
    {
    }

    procedure ShowDimensions();
    var
        DimMgt: Codeunit 408;
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", CopyStr(STRSUBSTNO('%1 %2', TABLECAPTION(), "Employee Code"), 1, 250));
    end;
}

