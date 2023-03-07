table 33001355 "Emp. Previous IT Savings B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Previous IT Savings';
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
        field(3; "Financial Year End Date"; Date)
        {
            Caption = 'Financial Year End Date';
            Editable = false;
            TableRelation = "Payroll Year B2B"."Year End Date" WHERE ("Year Type" = CONST ('FINANCIAL YEAR'),
                                                                  Closed = CONST (false));
            DataClassification = CustomerContent;
        }
        field(4; "Amount Exempted"; Decimal)
        {
            Caption = 'Amount Exempted';
            DataClassification = CustomerContent;
        }
        field(5; "Exemption/Deduction Group ID"; Code[20])
        {
            Caption = 'Exemption/Deduction Group ID';
            TableRelation = "Exep/Ded Groups B2B";
            DataClassification = CustomerContent;
        }
        field(6; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Financial Year Start Date", "Exemption/Deduction Group ID")
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

