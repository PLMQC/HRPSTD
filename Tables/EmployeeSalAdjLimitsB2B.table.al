table 33001357 "Employee Sal Adj. Limits B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Salary Adj. Limits';
    DrillDownPageID = "Emp. Salary Adj. Limits B2B";
    LookupPageID = "Emp. Salary Adj. Limits B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Financial Year Start Date"; Date)
        {
            Caption = 'Financial Year Start Date';
            TableRelation = "Payroll Year B2B"."Year Start Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                    Closed = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PayRollYears.RESET();
                PayRollYears.SETRANGE("Year Type", FinanceTextLbl);
                PayRollYears.SETRANGE("Year Start Date", "Financial Year Start Date");
                if PayRollYears.FINDFIRST() then
                    "Financial Year End Date" := PayRollYears."Year End Date";
            end;
        }
        field(3; "Financial Year End Date"; Date)
        {
            Caption = 'Financial Year End Date';
            Editable = false;
            TableRelation = "Payroll Year B2B"."Year End Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                  Closed = CONST(false));
            DataClassification = CustomerContent;
        }
        field(4; "Adjustment Element Code"; Code[20])
        {
            Caption = 'Adjustment Element Code';
            TableRelation = "Salary Adjustment Setup B2B".Code;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SalAdjSetup.GET("Adjustment Element Code");
                Perk := SalAdjSetup.Perk;
            end;
        }
        field(5; "Annual Limit"; Decimal)
        {
            Caption = 'Annual Limit';
            DataClassification = CustomerContent;
        }
        field(6; Perk; Boolean)
        {
            Caption = 'Perk';
            DataClassification = CustomerContent;
        }
        field(7; Limit; Decimal)
        {
            Caption = 'Limit';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CLEAR(NoofMonths);
                FyEdDate := "Financial Year Start Date";
                repeat
                    NoofMonths += 1;
                    FyEdDate := CALCDATE(MonthTextLbl, FyEdDate);
                until (FyEdDate > "Financial Year End Date");
                "Annual Limit" := (NoofMonths * Limit);
            end;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Financial Year Start Date", "Adjustment Element Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PayRollYears: Record "Payroll Year B2B";
        SalAdjSetup: Record "Salary Adjustment Setup B2B";
        NoofMonths: Integer;
        FyEdDate: Date;
        FinanceTextLbl: Label 'FINANCIAL YEAR';
        MonthTextLbl: Label '<1M>';
}

