table 33001284 "Income Tax Rebate Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Income Tax Rebate Setup_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Rebate,Standard Deduction';
            OptionMembers = Rebate,"Standard Deduction";
            DataClassification = CustomerContent;
        }
        field(4; "Rebate Year Starting Date"; Date)
        {
            Caption = 'Rebate Year Starting Date';
            Editable = true;
            TableRelation = "Payroll Year B2B"."Year Start Date" WHERE ("Year Type" = CONST ('FINANCIAL YEAR'),
                                                                    Closed = CONST (false));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                PayRollYears.RESET();
                PayRollYears.SETRANGE("Year Type", FYTxt);
                PayRollYears.SETRANGE("Year Start Date", "Rebate Year Starting Date");
                if PayRollYears.FINDFIRST() then
                    "Rebate Year Ending Date" := PayRollYears."Year End Date";
            end;
        }
        field(7; "Rebate Year Ending Date"; Date)
        {
            Caption = 'Rebate Year Ending Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Section ID"; Code[20])
        {
            Caption = 'Section ID';
            Editable = false;
            TableRelation = IF ("Document Type" = CONST (Rebate)) "Excemption Sections B2B"."Section ID" WHERE ("Chapter ID" = FILTER (= ''))
            ELSE
            IF ("Document Type" = FILTER ("Standard Deduction")) "IT Chapters B2B"."Chapter ID";
            DataClassification = CustomerContent;
        }
        field(13; "Max. Net Taxable Income"; Decimal)
        {
            Caption = 'Max. Net Taxable Income';
            DataClassification = CustomerContent;
        }
        field(16; "Min. Net Taxable Income"; Decimal)
        {
            Caption = 'Min. Net Taxable Income';
            DataClassification = CustomerContent;
        }
        field(19; "Max. Rebate Amount"; Decimal)
        {
            Caption = 'Max. Rebate Amount';
            DataClassification = CustomerContent;
        }
        field(21; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }
        field(22; "Standard Deduction Amount"; Decimal)
        {
            Caption = 'Standard Deduction Amount';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Section ID", "Rebate Year Starting Date", "Rebate Year Ending Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PayRollYears: Record "Payroll Year B2B";
        FYTxt: Label 'FINANCIAL YEAR';
}

