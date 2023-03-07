table 33001328 "Posted Leave Encash Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Leave Encash Header_B2B';
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
            TableRelation = IF (Type = FILTER(Employee)) "Employee B2B" WHERE(Blocked = FILTER(false));
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
            TableRelation = IF (Type = FILTER(Grade)) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Grade,All';
            OptionMembers = Employee,Grade,All;
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
        field(35; "Product Posting Group"; Code[20])
        {
            Caption = 'Product Posting Group';
            TableRelation = "Payroll Prod. Post. Group B2B";
            DataClassification = CustomerContent;
        }
        field(36; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(37; Post; Boolean)
        {
            Caption = 'Post';
            DataClassification = CustomerContent;
        }
        field(38; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Encashment Code")
        {
        }
    }

    fieldgroups
    {
    }
}

