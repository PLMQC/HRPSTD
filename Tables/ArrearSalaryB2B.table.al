table 33001292 "Arrear Salary B2B"
{
    // version B2BHR1.00.00

    Caption = 'Arrear Salary_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
        }
        field(2; "Emp Name"; Text[50])
        {
            Caption = 'Emp Name';
            DataClassification = CustomerContent;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(6; "Add/Deduct Code"; Code[30])
        {
            Caption = 'Add/Deduct Code';
            DataClassification = CustomerContent;
        }
        field(7; "Earned Amount"; Decimal)
        {
            Caption = 'Earned Amount';
            DataClassification = CustomerContent;
        }
        field(8; "Co Contributions"; Decimal)
        {
            Caption = 'Co Contributions';
            DataClassification = CustomerContent;
        }
        field(9; "Co Contributions2"; Decimal)
        {
            Caption = 'Co Contributions2';
            DataClassification = CustomerContent;
        }
        field(10; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year, "Line No.")
        {
        }
        key(Key2; "Employee Code", "Add/Deduct Code")
        {
        }
    }

    fieldgroups
    {
    }
}

