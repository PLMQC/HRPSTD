table 33001374 "VDA Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'VDA Line';
    DataClassification = CustomerContent;

    fields
    {
        field(2; Month; Option)
        {
            Caption = 'Month';
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            DataClassification = CustomerContent;
        }
        field(3; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                HRSetup.GET();
                "Point Value" := Points * HRSetup."Linking Factor1";
                Values := "Point Value" * HRSetup."Linking Factor2";
                "Point Value" := ROUND("Point Value", 1, '=');
                Values := ROUND(Values, 1, '=');
                MODIFY();
            end;
        }
        field(4; Quarter; Option)
        {
            Caption = 'Quarter';
            OptionCaption = ' ,Q1,Q2,Q3,Q4';
            OptionMembers = " ",Q1,Q2,Q3,Q4;
            DataClassification = CustomerContent;
        }
        field(5; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(6; "Point Value"; Decimal)
        {
            Caption = 'Point Value';
            DataClassification = CustomerContent;
        }
        field(7; Values; Decimal)
        {
            Caption = 'Values';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Year, Month, Quarter)
        {
        }
    }

    fieldgroups
    {
    }

    var
        HRSetup: Record "HR Setup B2B";

}

