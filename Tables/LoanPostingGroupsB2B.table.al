table 33001249 "Loan Posting Groups B2B"
{
    // version B2BHR1.00.00

    Caption = 'Loan Posting Groups';
    DrillDownPageID = "Loan Posting Setup B2B";
    LookupPageID = "Loan Posting Setup B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Loan Refundable Acc."; Code[20])
        {
            Caption = 'Loan Refundable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

