table 33001311 "Provisional Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Provisional Leaves_B2B';
    DrillDownPageID = "Provisional Leaves B2B";
    LookupPageID = "Provisional Leaves B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Employee Name"; Text[90])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Leave Master B2B"."Leave Code";
            DataClassification = CustomerContent;
        }
        field(4; "Leave Descriptioon"; Text[50])
        {
            Caption = 'Leave Descriptioon';
            DataClassification = CustomerContent;
        }
        field(5; "No.of Leaves"; Decimal)
        {
            Caption = 'No.of Leaves';
            DataClassification = CustomerContent;
        }
        field(6; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(7; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(8; "Leave Year Start Date"; Date)
        {
            Caption = 'Leave Year Start Date';
            DataClassification = CustomerContent;
        }
        field(9; "Leave Year End Date"; Date)
        {
            Caption = 'Leave Year End Date';
            DataClassification = CustomerContent;
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;
            DataClassification = CustomerContent;
        }
        field(11; "Applied Leaves"; Decimal)
        {
            Caption = 'Applied Leaves';
            DataClassification = CustomerContent;
        }
        field(12; "Remaining Leaves"; Decimal)
        {
            Caption = 'Remaining Leaves';
            DataClassification = CustomerContent;
        }
        field(13; "Period Start Date"; Date)
        {
            Caption = 'Period Start Date';
            DataClassification = CustomerContent;
        }
        field(14; "Period End Date"; Date)
        {
            Caption = 'Period End Date';
            DataClassification = CustomerContent;
        }
        field(17; "Prev. Month  Balance"; Decimal)
        {
            Caption = 'Prev. Month  Balance';
            DataClassification = CustomerContent;
        }
        field(18; "Leave Pay Cadre"; Code[50])
        {
            Caption = 'Leave Pay Cadre';
            Editable = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(22));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Leave Pay Cadre", "Leave Code", Month, Year, "Period Start Date", "Period End Date")
        {
            SumIndexFields = "Remaining Leaves";
        }
        key(Key2; "Employee No.", Year)
        {
        }
    }

    fieldgroups
    {
    }
}

