table 33001298 "Posted Emp TDS Schedule B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Emp TDS Schedule_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
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
        field(4; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(5; "TDS Amount"; Decimal)
        {
            Caption = 'TDS Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(6; "TDS Amount Deducted"; Decimal)
        {
            CalcFormula = Lookup ("Processed Salary B2B"."Earned Amount" WHERE("Employee Code" = FIELD("Employee No."),
                                                                           "Add/Deduct Code" = CONST('TDS DED'),
                                                                           "Pay Slip Month" = FIELD(Month),
                                                                           Year = FIELD(Year)));
            Caption = 'TDS Amount Deducted';
            FieldClass = FlowField;
        }
        field(7; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(8; Processes; Boolean)
        {
            Caption = 'Processes';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Year, Month, "Year Starting Date", "Year Ending Date")
        {
        }
    }

    fieldgroups
    {
    }
}

