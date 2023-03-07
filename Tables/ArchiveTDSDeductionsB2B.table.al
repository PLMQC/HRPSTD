table 33001340 "Archive TDS Deductions B2B"
{
    // version B2BHR1.00.00

    Caption = 'Archive TDS Deductions';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Emp ID"; Code[20])
        {
            Caption = 'Emp ID';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Emp ID") then
                    "Employee Name" := Employee."First Name";
            end;
        }
        field(2; "Financial Year Start Date"; Date)
        {
            Caption = 'Financial Year Start Date';
            TableRelation = "Payroll Year B2B"."Year Start Date" WHERE ("Year Type" = CONST ('FINANCIAL YEAR'),
                                                                    Closed = CONST (false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PayRollYears.RESET();
                PayRollYears.SETRANGE("Year Type", FinanceYearTextLbl);
                PayRollYears.SETRANGE("Year Start Date", "Financial Year Start Date");
                if PayRollYears.FINDFIRST() then
                    "Financial Year End Date" := PayRollYears."Year End Date";
            end;
        }
        field(3; "Financial Year End Date"; Date)
        {
            Caption = 'Financial Year End Date';
            Editable = false;
            TableRelation = "Payroll Year B2B"."Year End Date" WHERE ("Year Type" = CONST ('FINANCIAL YEAR'),
                                                                  Closed = CONST (false));
            DataClassification = CustomerContent;
        }
        field(4; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(5; "Gross Salary"; Decimal)
        {
            Caption = 'Gross Salary';
            DataClassification = CustomerContent;
        }
        field(6; "PT Amount"; Decimal)
        {
            Caption = 'PT Amount';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Total Gross Salary" := "Gross Salary" - "PT Amount";
            end;
        }
        field(7; "Exem Under 10 and 17"; Decimal)
        {
            Caption = 'Exem Under 10 and 17';
            DataClassification = CustomerContent;
        }
        field(8; "Income Charged Under Salary"; Decimal)
        {
            Caption = 'Income Charged Under Salary';
            DataClassification = CustomerContent;
        }
        field(9; "Other Income"; Decimal)
        {
            Caption = 'Other Income';
            DataClassification = CustomerContent;
        }
        field(10; "Gross Total Income"; Decimal)
        {
            Caption = 'Gross Total Income';
            DataClassification = CustomerContent;
        }
        field(11; "Chapter VI"; Decimal)
        {
            Caption = 'Chapter VI';
            DataClassification = CustomerContent;
        }
        field(12; "Chapter VIA"; Decimal)
        {
            Caption = 'Chapter VIA';
            DataClassification = CustomerContent;
        }
        field(13; "Net Tax Income"; Decimal)
        {
            Caption = 'Net Tax Income';
            DataClassification = CustomerContent;
        }
        field(14; "Total Tax Liability"; Decimal)
        {
            Caption = 'Total Tax Liability';
            DataClassification = CustomerContent;
        }
        field(15; Perks; Decimal)
        {
            Caption = 'Perks';
            DataClassification = CustomerContent;
        }
        field(16; "Profit Lieu of Salary"; Decimal)
        {
            Caption = 'Profit Lieu of Salary';
            DataClassification = CustomerContent;
        }
        field(17; "Total Gross Salary"; Decimal)
        {
            Caption = 'Total Gross Salary';
            DataClassification = CustomerContent;
        }
        field(18; "Relief US89"; Decimal)
        {
            Caption = 'Relief US89';
            DataClassification = CustomerContent;
        }
        field(19; Surcharge; Decimal)
        {
            Caption = 'Surcharge';
            DataClassification = CustomerContent;
        }
        field(20; eCess; Decimal)
        {
            Caption = 'eCess';
            DataClassification = CustomerContent;
        }
        field(21; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(22; "Archived Date"; Date)
        {
            Caption = 'Archived Date';
            DataClassification = CustomerContent;
        }
        field(23; "Archived Version"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Archived Version';
            DataClassification = CustomerContent;
        }
        field(41; "PF Amount"; Decimal)
        {
            Caption = 'PF Amount';
            DataClassification = CustomerContent;
        }
        field(42; "Income Tax"; Decimal)
        {
            Caption = 'Income Tax';
            DataClassification = CustomerContent;
        }
        field(43; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(44; Bonus; Decimal)
        {
            Caption = 'Bonus';
            DataClassification = CustomerContent;
        }
        field(45; Archived; Boolean)
        {
            Caption = 'Archived';
            DataClassification = CustomerContent;
        }
        field(49; "ST Deduction"; Decimal)
        {
            Caption = 'ST Deduction';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Archived Date", "Emp ID", "Financial Year Start Date", "Archived Version")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PayRollYears: Record "Payroll Year B2B";
        Employee: Record "Employee B2B";
        FinanceYearTextLbl: Label 'FINANCIAL YEAR';
}

