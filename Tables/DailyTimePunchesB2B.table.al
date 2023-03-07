table 33001364 "Daily Time Punches B2B"
{
    // version B2BHR1.00.00

    Caption = 'Daily Time Punches';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; Time; Time)
        {
            Caption = 'Time';
            DataClassification = CustomerContent;
        }
        field(10; Executed; Boolean)
        {
            Caption = 'Executed';
            DataClassification = CustomerContent;
        }
        field(11; "Updated to Daily Attendance"; Boolean)
        {
            Caption = 'Updated to Daily Attendance';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Manual Attendance"; Boolean)
        {
            Caption = 'Manual Attendance';
            DataClassification = CustomerContent;
        }
        field(16; "Time IN"; Time)
        {
            Caption = 'Time IN';
            DataClassification = CustomerContent;
        }
        field(17; "Time Out"; Time)
        {
            Caption = 'Time Out';
            DataClassification = CustomerContent;
        }
        field(18; "Shift Worked"; Code[20])
        {
            Caption = 'Shift Worked';
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;
        }
        field(20; "Date filter"; Date)
        {
            Caption = 'Date filter';
            FieldClass = FlowFilter;

        }
        field(30; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Date)
        {
        }
    }

    fieldgroups
    {
    }
}

