table 33001386 "LWF Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'LWF Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Employer';
            OptionMembers = Employee,Employer;
            DataClassification = CustomerContent;
        }
        field(3; "Period Type"; Option)
        {
            Caption = 'Period Type';
            OptionCaption = 'Monthly,Quarterly,Halfyearly,Yearly';
            OptionMembers = Monthly,Quarterly,Halfyearly,Yearly;
            DataClassification = CustomerContent;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(5; "Pay Element Code"; Code[30])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Effective Date", Type)
        {
        }
    }

    fieldgroups
    {
    }
}

