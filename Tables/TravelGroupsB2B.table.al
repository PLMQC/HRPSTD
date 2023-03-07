table 33001394 "Travel Groups B2B"
{
    // version B2BHR1.00.00

    Caption = 'Travel Groups';
    DrillDownPageID = "Travel Groups B2B";
    LookupPageID = "Travel Groups B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Category; Code[20])
        {
            Caption = 'Category';
            TableRelation = Category_B2B.Code;
            DataClassification = CustomerContent;
        }
        field(2; "City Type"; Code[20])
        {
            Caption = 'City Type';
            DataClassification = CustomerContent;
        }
        field(3; Component; Code[20])
        {
            Caption = 'Component';
            TableRelation = "Components B2B".Code WHERE (Active = CONST (true));
            DataClassification = CustomerContent;
        }
        field(4; "Mode of Transport"; Option)
        {
            Caption = 'Mode of Transport';
            OptionCaption = ' ,By Road,By Rail,By Air,By Sea';
            OptionMembers = " ","By Road","By Rail","By Air","By Sea";
            DataClassification = CustomerContent;
        }
        field(5; Limits; Decimal)
        {
            Caption = 'Limits';
            DataClassification = CustomerContent;
        }
        field(6; Actuals; Boolean)
        {
            Caption = 'Actuals';
            DataClassification = CustomerContent;
        }
        field(7; UOM; Code[10])
        {
            Caption = 'UOM';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Category, "City Type", Component, "Mode of Transport")
        {
        }
    }

    fieldgroups
    {
    }
}

