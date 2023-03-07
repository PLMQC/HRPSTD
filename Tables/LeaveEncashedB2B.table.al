table 33001222 "Leave Encashed B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Encashed';
    DrillDownPageID = "Leave Encashment B2B";
    LookupPageID = "Leave Encashment B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Leave Master B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Leave Balance"; Decimal)
        {
            CalcFormula = Sum ("Leave Entitlement B2B"."Leave Bal. at the Month End" WHERE("Employee No." = FIELD("Employee Code"),
                                                                                       "Leave Code" = FIELD("Leave Code"),
                                                                                       Year = FIELD(Year),
                                                                                       Month = FIELD(Month)));
            Caption = 'Leave Balance';
            FieldClass = FlowField;
        }
        field(4; "Leaves Encashed"; Decimal)
        {
            Caption = 'Leaves Encashed';
            DataClassification = CustomerContent;
        }
        field(5; "Leaves to Encash"; Decimal)
        {
            Caption = 'Leaves to Encash';
            DataClassification = CustomerContent;
        }
        field(6; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
        }
        field(7; "Encash Amount"; Decimal)
        {
            Caption = 'Encash Amount';
            DataClassification = CustomerContent;
        }
        field(8; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(9; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Leave Code", "Employee Code", Year, Month)
        {
            SumIndexFields = "Leaves to Encash", "Encash Amount";
        }
    }

    fieldgroups
    {
    }
}

