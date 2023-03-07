table 33001354 "Emp. Previous TDS History B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Previous TDS History';
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
        field(4; "TDS Amount Paid"; Decimal)
        {
            Caption = 'TDS Amount Paid';
            DataClassification = CustomerContent;
        }
        field(5; "Challan Date"; Date)
        {
            Caption = 'Challan Date';
            DataClassification = CustomerContent;
        }
        field(6; "Challan Number"; Code[20])
        {
            Caption = 'Challan Number';
            DataClassification = CustomerContent;
        }
        field(7; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(8; "Financial Year Start Date"; Date)
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
        field(9; "Financial Year End Date"; Date)
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
        key(Key1; "Employee Code", Month, Year, "Financial Year Start Date")
        {
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

