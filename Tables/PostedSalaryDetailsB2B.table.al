table 33001258 "Posted Salary Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Salary Details';
    DrillDownPageID = "Posted Salary List B2B";
    LookupPageID = "Posted Salary List B2B";
            DataClassification = CustomerContent;

    fields
    {
        field(1;"Posting Date";Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(2;"Document No";Code[20])
        {
            Caption = 'Document No';
            DataClassification = CustomerContent;
        }
        field(3;Description;Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4;Month;Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(5;Year;Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(6;"Employee Code";Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
        }
        field(7;"Total Additions";Decimal)
        {
            Caption = 'Total Additions';
            DataClassification = CustomerContent;
        }
        field(8;"Total Deductions";Decimal)
        {
            Caption = 'Total Deductions';
            DataClassification = CustomerContent;
        }
        field(9;"Net Salary";Decimal)
        {
            Caption = 'Net Salary';
            DataClassification = CustomerContent;
        }
        field(10;"Salary Paid";Decimal)
        {
            Caption = 'Salary Paid';
            DataClassification = CustomerContent;
        }
        field(14;"Account Type";Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            DataClassification = CustomerContent;
        }
        field(15;"Account No.";Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type"=CONST("G/L Account")) "G/L Account"."No."
                            ELSE IF ("Account Type"=CONST("Bank Account")) "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(18;"Cheque No.";Code[20])
        {
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
        }
        field(19;"Cheque Date";Date)
        {
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
        }
        field(20;"Total Arrear Additions";Decimal)
        {
            Caption = 'Total Arrear Additions';
            DataClassification = CustomerContent;
        }
        field(21;"Total Arrear Deductions";Decimal)
        {
            Caption = 'Total Arrear Deductions';
            DataClassification = CustomerContent;
        }
        field(22;"Net Arrear Amount";Decimal)
        {
            Caption = 'Net Arrear Amount';
            DataClassification = CustomerContent;
        }
        field(23;"Arrear Salary paid";Decimal)
        {
            Caption = 'Arrear Salary paid';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1;"Employee Code",Month,Year,"Posting Date")
        {
            SumIndexFields = "Salary Paid";
        }
    }

    fieldgroups
    {
    }
}

