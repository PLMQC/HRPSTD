table 33001314 "Salary Adjustment B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Adjustment_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Employee No") then
                    "Employee Name" := Employee."First Name";
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            Editable = false;
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
        field(5; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            Editable = false;
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(10; "Salary Adj. Code"; Code[20])
        {
            Caption = 'Salary Adj. Code';
            DataClassification = CustomerContent;
        }
        field(20; "Location Code"; Code[30])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No", Month, Year, "Salary Adj. Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
}

