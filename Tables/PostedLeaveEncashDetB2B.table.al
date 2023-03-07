table 33001332 "Posted Leave Encash Det B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Leave Encash Details';
    DrillDownPageID = "Closed Recruitment B2B";
    LookupPageID = "Closed Recruitment B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(2; "Document No"; Code[20])
        {
            Caption = 'Document No';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
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
        field(6; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
        }
        field(7; "Encash Amount"; Decimal)
        {
            Caption = 'Encash Amount';
            DataClassification = CustomerContent;
        }
        field(10; "Amount Paid"; Decimal)
        {
            Caption = 'Amount Paid';
            DataClassification = CustomerContent;
        }
        field(14; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            DataClassification = CustomerContent;
        }
        field(15; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(18; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
        }
        field(19; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
        }
        field(20; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(25; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            DataClassification = CustomerContent;
        }
        field(26; "Leaves To Encash"; Decimal)
        {
            Caption = 'Leaves To Encash';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year, "Posting Date", "Entry No.")
        {
            SumIndexFields = "Amount Paid";
        }
        key(Key2; "Employee Code", Month, Year, "Leave Code")
        {
            SumIndexFields = "Amount Paid";
        }
    }

    fieldgroups
    {
    }
}

