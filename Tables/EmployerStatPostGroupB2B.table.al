table 33001322 "Employer Stat. Post. Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employer Statury Posting Group';
    DrillDownPageID = "Employer Statu Post Group B2B";
    LookupPageID = "Employer Statu Post Group B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
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
        field(17; "Employer PF"; Code[20])
        {
            Caption = 'Employer PF';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(18; "Employer EPS"; Code[20])
        {
            Caption = 'Employer EPS';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(19; "PF Admin. Charges"; Code[20])
        {
            Caption = 'PF Admin. Charges';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(20; "EDLI Charges"; Code[20])
        {
            Caption = 'EDLI Charges';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(21; "Employer ESI"; Code[20])
        {
            Caption = 'Employer ESI';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(32; "RIFA Charges"; Code[20])
        {
            Caption = 'RIFA Charges';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(42; "Cash Account"; Code[20])
        {
            Caption = 'Cash Account';
            TableRelation = "G/L Account"."No.";
            DataClassification = CustomerContent;
        }
        field(43; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            TableRelation = "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(44; "LWF Account"; Code[20])
        {
            Caption = 'LWF Account';
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

