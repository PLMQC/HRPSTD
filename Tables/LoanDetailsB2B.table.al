table 33001229 "Loan Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Loan Details';
    DrillDownPageID = "Loan Details B2B";
    LookupPageID = "Loan Details B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Loan Code"; Code[50])
        {
            Caption = 'Loan Code';
            DataClassification = CustomerContent;
        }
        field(3; "Pay Date"; Date)
        {
            Caption = 'Pay Date';
            DataClassification = CustomerContent;
        }
        field(4; "Loan Amount"; Decimal)
        {
            Caption = 'Loan Amount';
            DataClassification = CustomerContent;
        }
        field(5; "Repayment Date"; Date)
        {
            Caption = 'Repayment Date';
            DataClassification = CustomerContent;
        }
        field(6; "EMI Deducted"; Decimal)
        {
            Caption = 'EMI Deducted';
            DataClassification = CustomerContent;
        }
        field(7; "EMI Amount"; Decimal)
        {
            Caption = 'EMI Amount';
            DataClassification = CustomerContent;
        }
        field(8; Interest; Decimal)
        {
            Caption = 'Interest';
            DataClassification = CustomerContent;
        }
        field(9; Principal; Decimal)
        {
            Caption = 'Principal';
            DataClassification = CustomerContent;
        }
        field(10; "Lump Sum Payment"; Decimal)
        {
            CalcFormula = Sum ("Loan Repayments B2B".Amount WHERE("Loan Id" = FIELD("Loan Id"),
                                                              "Employee No." = FIELD("Employee No."),
                                                              Month = FIELD(Month),
                                                              Year = FIELD(Year),
                                                              Paid = CONST(true)));
            Caption = 'Lump Sum Payment';
            FieldClass = FlowField;
        }
        field(11; Balance; Decimal)
        {
            Caption = 'Balance';
            DataClassification = CustomerContent;
        }
        field(12; "Paid Month"; Integer)
        {
            Caption = 'Paid Month';
            DataClassification = CustomerContent;
        }
        field(13; "Paid Year"; Integer)
        {
            Caption = 'Paid Year';
            DataClassification = CustomerContent;
        }
        field(14; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(15; "Loan Closed"; Boolean)
        {
            Caption = 'Loan Closed';
            DataClassification = CustomerContent;
        }
        field(16; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(17; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(18; "Loan Id"; Code[20])
        {
            Caption = 'Loan Id';
            DataClassification = CustomerContent;
        }
        field(19; "Knocked Off ag lumsum"; Boolean)
        {
            Caption = 'Knocked Off ag lumsum';
            DataClassification = CustomerContent;
        }
        field(20; "knocked Off Amount"; Decimal)
        {
            Caption = 'knocked Off Amount';
            DataClassification = CustomerContent;
        }
        field(21; "Balance (Base)"; Decimal)
        {
            Caption = 'Balance (Base)';
            DataClassification = CustomerContent;
        }
        field(22; "Repayment Month"; Integer)
        {
            Caption = 'Repayment Month';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(23; "Repayment Year"; Integer)
        {
            Caption = 'Repayment Year';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Loan Id", "Line No")
        {
        }
        key(Key2; "Employee No.", "Loan Code", Month, Year)
        {
            SumIndexFields = "EMI Amount";
        }
        key(Key3; "Loan Id")
        {
        }
    }

    fieldgroups
    {
    }
}

