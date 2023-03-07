table 33001351 "IT Slab Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'IT Slab Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; SlabType; Option)
        {
            Caption = 'SlabType';
            OptionCaption = 'Male,Female,Sr. Citizen,Option2';//TDSOP2
            OptionMembers = Male,Female,"Sr. Citizen",Option2;//TDSOP2
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
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(7; "Income From"; Decimal)
        {
            Caption = 'Income From';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Income To"; Decimal)
        {
            Caption = 'Income To';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Income From" <> 0 then
                    "Total Income" := "Income To" - "Income From" + 1
                else
                    "Total Income" := "Income To" - "Income From";
                if "Income To" <= "Income From" then
                    ERROR(Text001Lbl);
            end;
        }
        field(11; "Total Income"; Decimal)
        {
            Caption = 'Total Income';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(13; "Tax Rate %"; Decimal)
        {
            Caption = 'Tax Rate %';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; SlabType, "Financial Year Start Date", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PayRollYears: Record "Payroll Year B2B";
        Text001Lbl: Label 'To-Income Must greater than From-Income';
        FinanceYearTextLbl: Label 'FINANCIAL YEAR';
}

