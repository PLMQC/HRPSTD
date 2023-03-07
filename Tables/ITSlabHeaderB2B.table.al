table 33001350 "IT Slab Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'IT Slab Header';
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
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Financial Year Start Date"; Date)
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
        field(4; "Financial Year End Date"; Date)
        {
            Caption = 'Financial Year End Date';
            Editable = false;
            TableRelation = "Payroll Year B2B"."Year End Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                  Closed = CONST(false));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; SlabType, "Financial Year Start Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        ITSlabLine.RESET();
        ITSlabLine.SETRANGE(SlabType, SlabType);
        ITSlabLine.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
        if ITSlabLine.FINDSET() then
            ITSlabLine.DELETEALL();
    end;

    var
        PayRollYears: Record "Payroll Year B2B";
        ITSlabLine: Record "IT Slab Line B2B";
        FinanceYearTextLbl: Label 'FINANCIAL YEAR';
}

