table 33001343 "EMP TDS Gross Salary B2B"
{
    // version B2BHR1.00.00

    Caption = 'EMP TDS Gross Salary';
    DrillDownPageID = "EMP TDS Gross Salary B2B";
    LookupPageID = "EMP TDS Gross Salary B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Emp ID"; Code[20])
        {
            Caption = 'Emp ID';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Payslip Month"; Integer)
        {
            Caption = 'Payslip Month';
            DataClassification = CustomerContent;
        }
        field(3; "Payslip Year"; Integer)
        {
            Caption = 'Payslip Year';
            DataClassification = CustomerContent;
        }
        field(4; "Pay Element Code"; Code[50])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));
            DataClassification = CustomerContent;
        }
        field(5; "Financial Year Start Date"; Date)
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
        field(6; "Financial Year End Date"; Date)
        {
            Caption = 'Financial Year End Date';
            Editable = false;
            TableRelation = "Payroll Year B2B"."Year End Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                  Closed = CONST(false));
            DataClassification = CustomerContent;
        }
        field(8; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Emp ID", "Payslip Month", "Payslip Year", "Pay Element Code", "Financial Year Start Date")
        {
            SumIndexFields = Amount;
        }
        key(Key2; "Emp ID", "Payslip Year", "Payslip Month", "Pay Element Code", "Financial Year Start Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PayRollYears: Record "Payroll Year B2B";
        FinanceYearTextLbl: Label 'FINANCIAL YEAR';
}

