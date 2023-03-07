table 33001342 "TDS Acknowledgment B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Acknowledgment';
    DrillDownPageID = "TDS Acknowledgement List B2B";
    LookupPageID = "TDS Acknowledgement List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(2; Quarter; Option)
        {
            Caption = 'Quarter';
            OptionCaption = ' ,Q1,Q2,Q3,Q4';
            OptionMembers = " ",Q1,Q2,Q3,Q4;
            DataClassification = CustomerContent;
        }
        field(3; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            TableRelation = "Payroll Year B2B"."Year Start Date" WHERE ("Year Type" = CONST ('FINANCIAL YEAR'),
                                                                    Closed = CONST (false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PayRollYears.RESET();
                PayRollYears.SETRANGE("Year Type", FinanceYearTextLbl);
                PayRollYears.SETRANGE("Year Start Date", "Starting Date");
                if PayRollYears.FINDFIRST() then
                    "Ending Date" := PayRollYears."Year End Date";
            end;
        }
        field(4; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
        }
        field(5; "TDS Acknowledgement No."; Code[20])
        {
            Caption = 'TDS Acknowledgement No.';
            DataClassification = CustomerContent;
        }
        field(6; "TDS Acknowledgment Date"; Date)
        {
            Caption = 'TDS Acknowledgment Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Location Code", Quarter, "Starting Date")
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

