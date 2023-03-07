table 33001324 "Emp. Payelements History1 B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Payelements History1_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; "Pay Cadre"; Code[20])
        {
            Caption = 'Pay Cadre';
            DataClassification = CustomerContent;
        }
        field(4; "Leave PayCadre"; Code[20])
        {
            Caption = 'Leave PayCadre';
            DataClassification = CustomerContent;
        }
        field(5; "Effective Start Date"; Date)
        {
            Caption = 'Effective Start Date';
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

