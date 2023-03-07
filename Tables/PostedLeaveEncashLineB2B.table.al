table 33001329 "Posted Leave Encash Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Leave Encash Line_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Encashment Code"; Code[20])
        {
            Caption = 'Encashment Code';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(4; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(5; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(6; PayCadre; Code[20])
        {
            Caption = 'PayCadre';
            DataClassification = CustomerContent;
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Grade,All';
            OptionMembers = Employee,Grade,All;
            DataClassification = CustomerContent;
        }
        field(8; "Available Leaves"; Decimal)
        {
            Caption = 'Available Leaves';
            DataClassification = CustomerContent;
        }
        field(9; "Leaves To Encash"; Decimal)
        {
            Caption = 'Leaves To Encash';
            DataClassification = CustomerContent;
        }
        field(10; "Encash Amount"; Decimal)
        {
            Caption = 'Encash Amount';
            DataClassification = CustomerContent;
        }
        field(11; Post; Boolean)
        {
            Caption = 'Post';
            DataClassification = CustomerContent;
        }
        field(12; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(15; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
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
        field(36; "Paid Amount"; Decimal)
        {
            CalcFormula = Sum ("Posted Leave Encash Det B2B"."Amount Paid" WHERE("Employee Code" = FIELD("Employee Code"),
                                                                                 Month = FIELD(Month),
                                                                                 Year = FIELD(Year),
                                                                                 "Leave Code" = FIELD("Leave Code")));
            Caption = 'Paid Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
            DataClassification = CustomerContent;
        }
        field(42; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(43; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(46; "Cumulative Balance"; Decimal)
        {
            Caption = 'Cumulative Balance';
            DataClassification = CustomerContent;
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
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            DataClassification = CustomerContent;
        }
        field(50; "Pay Amount"; Decimal)
        {
            Caption = 'Pay Amount';
            DataClassification = CustomerContent;
        }
        field(51; "Bank / Cash Account"; Code[20])
        {
            Caption = 'Bank / Cash Account';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(52; "Pay Method"; Option)
        {
            Caption = 'Pay Method';
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            OptionMembers = Cash,Cheque,"Bank Transfer";
            DataClassification = CustomerContent;
        }
        field(53; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(54; "Monthly Exp"; Decimal)
        {
            Caption = 'Monthly Exp';
            DataClassification = CustomerContent;
        }
        field(56; Trainee; Boolean)
        {
            Caption = 'Trainee';
            DataClassification = CustomerContent;
        }
        field(57; "Net Payable"; Decimal)
        {
            Caption = 'Net Payable';
            DataClassification = CustomerContent;
        }
        field(81; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;
        }
        field(85; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = CustomerContent;
        }
        field(101; "Emp Posting Group"; Code[20])
        {
            Caption = 'Emp Posting Group';
            TableRelation = "Employee Posting Group B2B".Code;
            DataClassification = CustomerContent;
        }
        field(102; "Payroll Bus. Posting Group"; Code[20])
        {
            Caption = 'Payroll Bus. Posting Group';
            TableRelation = "Payroll Bus. Post Group B2B".Code;
            DataClassification = CustomerContent;
        }
        field(150; "Reprocess Check"; Boolean)
        {
            Caption = 'Reprocess Check';
            DataClassification = CustomerContent;
        }
        field(151; "Rounding Amount"; Decimal)
        {
            Caption = 'Rounding Amount';
            DataClassification = CustomerContent;
        }
        field(160; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(162; "PF Ceiling Amount"; Decimal)
        {
            Caption = 'PF Ceiling Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(163; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(164; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup();
            begin
                ShowDocDim();
            end;
        }
    }

    keys
    {
        key(Key1; "Encashment Code", "Line No.")
        {
        }
        key(Key2; "Employee Code")
        {
            SumIndexFields = "Encash Amount";
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit 408;


    procedure ShowDocDim();
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2', "Employee Code", "Employee Name"),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then
            MODIFY();
    end;
}

