table 33001339 "TDS Deductions B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Deductions_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Emp ID"; Code[20])
        {
            Caption = 'Emp ID';
            Editable = false;
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
            TableRelation = "Payroll Year B2B"."Year Start Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                    Closed = CONST(false));
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
            TableRelation = "Payroll Year B2B"."Year End Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                  Closed = CONST(false));
            DataClassification = CustomerContent;
        }
        field(4; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Gross Salary"; Decimal)
        {
            CalcFormula = Sum("EMP TDS Gross Salary B2B".Amount WHERE("Emp ID" = FIELD("Emp ID"),
                                                                   "Financial Year Start Date" = FIELD("Financial Year Start Date")));
            Caption = 'Gross Salary';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "PT Amount"; Decimal)
        {
            Caption = 'PT Amount';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CALCFIELDS("Gross Salary");
                "Total Gross Salary" := (("Gross Salary" + "Prev. Comp. Gross Salary" + Perks + "Value of prequisites") - "PT Amount" - "ST Deduction");
            end;
        }
        field(7; "Exem Under 10 and 17"; Decimal)
        {
            Caption = 'Exem Under 10 and 17';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Income Charged Under Salary"; Decimal)
        {
            Caption = 'Income Charged Under Salary';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Other Income"; Decimal)
        {
            Caption = 'Other Income';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Gross Total Income"; Decimal)
        {
            Caption = 'Gross Total Income';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; "Chapter VI"; Decimal)
        {
            Caption = 'Chapter VI';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(12; "Chapter VIA"; Decimal)
        {
            Caption = 'Chapter VIA';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; "Net Tax Income"; Decimal)
        {
            Caption = 'Net Tax Income';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "Total Tax Liability"; Decimal)
        {
            Caption = 'Total Tax Liability';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; Perks; Decimal)
        {
            Caption = 'Perks';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(16; "Profit Lieu of Salary"; Decimal)
        {
            Caption = 'Profit Lieu of Salary';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "Total Gross Salary"; Decimal)
        {
            Caption = 'Total Gross Salary';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Relief US89"; Decimal)
        {
            Caption = 'Relief US89';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; Surcharge; Decimal)
        {
            Caption = 'Surcharge';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; eCess; Decimal)
        {
            Caption = 'eCess';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(21; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(25; "Prev. Comp. Gross Salary"; Decimal)
        {
            CalcFormula = Sum("Emp. Previous Company Sal B2B".Amount WHERE("Employee Code" = FIELD("Emp ID"),
                                                                           "Financial Year Start Date" = FIELD("Financial Year Start Date")));
            Caption = 'Prev. Comp. Gross Salary';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Value of prequisites"; Decimal)
        {
            Caption = 'Value of prequisites';
            DataClassification = CustomerContent;
        }
        field(40; "Entertainment Allowance"; Decimal)
        {
            Caption = 'Entertainment Allowance';
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
            CalcFormula = Lookup("Employee B2B".Blocked WHERE("No." = FIELD("Emp ID")));
            Caption = 'Blocked';
            FieldClass = FlowField;
        }
        field(44; Bonus; Decimal)
        {
            Caption = 'Bonus';
            DataClassification = CustomerContent;
        }
        field(46; "Bonus Paid Date"; Date)
        {
            Caption = 'Bonus Paid Date';
            DataClassification = CustomerContent;
        }
        field(47; "Update Tax Liability"; Boolean)
        {
            Caption = 'Update Tax Liability';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(48; "Rebate U/S 87 A"; Decimal)
        {
            Caption = 'Rebate U/S 87 A';
            DataClassification = CustomerContent;
        }
        field(49; "ST Deduction"; Decimal)
        {
            Caption = 'ST Deduction';
            DataClassification = CustomerContent;
        }
        //TDSOP2 >>
        field(50; "IT Slab Type"; Option)
        {
            Caption = '"IT Slab Type"';
            OptionCaption = 'Male,Female,Sr. Citizen,Option2';
            OptionMembers = Male,Female,"Sr. Citizen",Option2;
            DataClassification = CustomerContent;
        }
        //TDSOP2 <<
    }

    keys
    {
        key(Key1; "Emp ID", "Financial Year Start Date")
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

