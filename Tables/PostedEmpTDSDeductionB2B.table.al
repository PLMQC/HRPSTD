table 33001297 "Posted Emp TDS Deduction B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Emp TDS Deduction_B2B';
    DrillDownPageID = "TDS Deduction List B2B";
    LookupPageID = "TDS Deduction List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Year Starting Date"; Date)
        {
            Caption = 'Year Starting Date';
            DataClassification = CustomerContent;
        }
        field(3; "Year Ending Date"; Date)
        {
            Caption = 'Year Ending Date';
            DataClassification = CustomerContent;
        }
        field(4; "Gross Salary"; Decimal)
        {
            Caption = 'Gross Salary';
            DataClassification = CustomerContent;
        }
        field(5; "Professional Tax"; Decimal)
        {
            Caption = 'Professional Tax';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(6; "Gross Total Income"; Decimal)
        {
            Caption = 'Gross Total Income';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(7; "Tax Liability"; Decimal)
        {
            Caption = 'Tax Liability';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(8; "Planned Savings"; Decimal)
        {
            Caption = 'Planned Savings';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(9; "Tax Liability after savings"; Decimal)
        {
            Caption = 'Tax Liability after savings';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(10; "Tax Already Deducted"; Decimal)
        {
            Caption = 'Tax Already Deducted';
            DataClassification = CustomerContent;
        }
        field(11; "Remaining Months"; Decimal)
        {
            Caption = 'Remaining Months';
            DataClassification = CustomerContent;
        }
        field(12; "Tax Per Month"; Decimal)
        {
            Caption = 'Tax Per Month';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(13; "Reported Savings"; Decimal)
        {
            Caption = 'Reported Savings';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Year Starting Date", "Year Ending Date")
        {
        }
    }

    fieldgroups
    {
    }
}

