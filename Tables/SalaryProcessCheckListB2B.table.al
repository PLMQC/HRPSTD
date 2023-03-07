table 33001295 "Salary Process Check List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Process Check List_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(4; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(5; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(8; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(9; "Sub ID"; Code[20])
        {
            Caption = 'Sub ID';
            DataClassification = CustomerContent;
        }
        field(12; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(15; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Not Started,Inprogress,Completed,ErrorLog';
            OptionMembers = "Not Started",Inprogress,Completed,ErrorLog;
            DataClassification = CustomerContent;
        }
        field(18; Process; Boolean)
        {
            Caption = 'Process';
            DataClassification = CustomerContent;
        }
        field(21; Level; Integer)
        {
            Caption = 'Level';
            DataClassification = CustomerContent;
        }
        field(24; "Parent Ref ID"; Code[20])
        {
            Caption = 'Parent Ref ID';
            DataClassification = CustomerContent;
        }
        field(30; LogCount; Integer)
        {
            Caption = 'LogCount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(31; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

