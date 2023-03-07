table 33001296 "Salary Process Error Log B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Process Error Log_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(5; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(8; "Checklist ID"; Code[20])
        {
            Caption = 'Checklist ID';
            DataClassification = CustomerContent;
        }
        field(12; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(15; "Checklist Sub ID"; Code[20])
        {
            Caption = 'Checklist Sub ID';
            DataClassification = CustomerContent;
        }
        field(18; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(22; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(25; Recitified; Boolean)
        {
            Caption = 'Recitified';
            DataClassification = CustomerContent;
        }
        field(29; Type; Text[50])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(32; "Sub Type"; Text[50])
        {
            Caption = 'Sub Type';
            DataClassification = CustomerContent;
        }
        field(34; No; Code[20])
        {
            Caption = 'No';
            DataClassification = CustomerContent;
        }
        field(35; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Month, Year, "Checklist ID", "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

