table 33001253 "Expected Sal Computation B2B"
{
    // version B2BHR1.00.00

    Caption = 'Expected Salary Computation';
    DrillDownPageID = "Processed Salary List B2B";
    LookupPageID = "Processed Salary List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
        }
        field(2; "Expected Salary"; Decimal)
        {
            Caption = 'Expected Salary';
            DataClassification = CustomerContent;
        }
        field(3; Account; Code[50])
        {
            Caption = 'Account';
            DataClassification = CustomerContent;
        }
        field(4; Month; Integer)
        {
            Caption = 'Month';
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
            DataClassification = CustomerContent;
        }
        field(5; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(6; "Actual Earned Salary"; Decimal)
        {
            CalcFormula = Sum ("Monthly Attendance B2B"."Net Salary" WHERE("Employee Code" = FIELD("Employee Code"),
                                                                       "Pay Slip Month" = FIELD(Month),
                                                                       Year = FIELD(Year)));
            Caption = 'Actual Earned Salary';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Year, Month)
        {
        }
    }

    fieldgroups
    {
    }
}

