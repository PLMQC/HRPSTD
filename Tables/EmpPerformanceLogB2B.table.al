table 33001201 "Emp Performance Log B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp Performance Log';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            Editable = false;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; Period; Code[20])
        {
            Caption = 'Period';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Action"; Option)
        {
            Caption = 'Action';
            Editable = false;
            OptionCaption = 'Created,Updated,Review,Released,Self Review,Joint Review,Reopen';
            OptionMembers = Created,Updated,Review,Released,"Self Review","Joint Review",Reopen;
            DataClassification = CustomerContent;
        }
        field(6; "Action By"; Code[20])
        {
            Caption = 'Action By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Action Date"; Date)
        {
            Caption = 'Action Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Action Time"; Time)
        {
            Caption = 'Action Time';
            DataClassification = CustomerContent;
        }
        field(41; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Period, "Line No.")
        {
        }
        key(Key2; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

