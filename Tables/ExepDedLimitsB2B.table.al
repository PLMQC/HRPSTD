table 33001348 "Exep/Ded Limits B2B"
{
    // version B2BHR1.00.00

    Caption = 'Exep/Ded Limits';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Exemp / Ded Group ID"; Code[20])
        {
            Caption = 'Exemp / Ded Group ID';
            TableRelation = "Exep/Ded Groups B2B";
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
        field(5; "Exemption Limit"; Decimal)
        {
            Caption = 'Exemption Limit';
            DataClassification = CustomerContent;
        }
        field(7; "Profit /Loss"; Option)
        {
            Caption = 'Profit /Loss';
            OptionCaption = 'Profit,Loss';
            OptionMembers = Profit,Loss;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Exemp / Ded Group ID", "Financial Year Start Date")
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

