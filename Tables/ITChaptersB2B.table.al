table 33001345 "IT Chapters B2B"
{
    // version B2BHR1.00.00

    Caption = 'IT Chapters';
    LookupPageID = "Income Tax Chapters B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Chapter ID"; Code[20])
        {
            Caption = 'Chapter ID';
            DataClassification = CustomerContent;
        }
        field(2; "Maximum Limit"; Decimal)
        {
            Caption = 'Maximum Limit';
            DataClassification = CustomerContent;
        }
        field(3; "Standard Deduction"; Boolean)
        {
            Caption = 'Standard Deduction';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Chapter ID")
        {
        }
    }

    fieldgroups
    {
    }
}

