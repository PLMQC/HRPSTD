table 33001365 "Loan Log Entry B2B"
{
    // version B2BHR1.00.00

    Caption = 'Loan Log Entry';
    DrillDownPageID = "Loan Log Entry List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Loan ID"; Code[20])
        {
            Caption = 'Loan ID';
            TableRelation = Loan_B2B;
            DataClassification = CustomerContent;
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Loan Type"; Code[50])
        {
            Caption = 'Loan Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('LOAN TYPES'));
            DataClassification = CustomerContent;
        }
        field(5; "Date Initiated"; Date)
        {
            Caption = 'Date Initiated';
            DataClassification = CustomerContent;
        }
        field(6; "Loan Status"; Option)
        {
            Caption = 'Loan Status';
            OptionCaption = ' ,Open,Stopped,Re-Activated,Closed';
            OptionMembers = " ",Open,Stopped,"Re-Activated",Closed;
            DataClassification = CustomerContent;
        }
        field(15; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Loan ID", "Date Initiated", "Loan Status")
        {
        }
    }

    fieldgroups
    {
    }
}

