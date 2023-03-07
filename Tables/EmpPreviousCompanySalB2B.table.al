table 33001353 "Emp. Previous Company Sal B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Previous Company Salary';
    DrillDownPageID = "Empployee Prev. IT Savings B2B";
    LookupPageID = "Empployee Prev. IT Savings B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(3; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(4; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE ("LookupType Name" = CONST ('ADDITIONS AND DEDUCTIONS'));
            DataClassification = CustomerContent;
        }
        field(5; "Addition/Deduction"; Option)
        {
            Caption = 'Addition/Deduction';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(8; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;

        }
        field(9; "Financial Year Start Date"; Date)
        {
            Caption = 'Financial Year Start Date';
            TableRelation = "Payroll Year B2B"."Year Start Date" WHERE ("Year Type" = CONST ('FINANCIAL YEAR'),
                                                                    Closed = CONST (false));
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
        field(10; "Financial Year End Date"; Date)
        {
            Caption = 'Financial Year End Date';
            Editable = false;
            TableRelation = "Payroll Year B2B"."Year End Date" WHERE ("Year Type" = CONST ('FINANCIAL YEAR'),
                                                                  Closed = CONST (false));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year, "Pay Element Code", "Financial Year Start Date")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        B2BEmp.GET("Employee Code");
        "Location Code" := B2BEmp."Location Code";
    end;

    var
        B2BEmp: Record "Employee B2B";
        PayRollYears: Record "Payroll Year B2B";
        FinanceTextLbl: Label 'FINANCIAL YEAR';
}

