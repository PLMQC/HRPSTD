table 33001312 "Temp Leave Plan B2B"
{
    // version B2BHR1.00.00

    Caption = 'Temp Leave Plan_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; "Leave Date"; Date)
        {
            Caption = 'Leave Date';
            DataClassification = CustomerContent;
        }
        field(4; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Leave Master B2B"."Leave Code";
            DataClassification = CustomerContent;
        }
        field(5; "Leave Description"; Text[50])
        {
            Caption = 'Leave Description';
            DataClassification = CustomerContent;
        }
        field(6; "Leave Type"; Option)
        {
            Caption = 'Leave Type';
            OptionCaption = 'Leave,Lop,NonWorking';
            OptionMembers = Leave,Lop,NonWorking;
            DataClassification = CustomerContent;
        }
        field(7; "Approved Status"; Option)
        {
            Caption = 'Approved Status';
            OptionCaption = ' ,Applied,Approved,Rejected,Comp';
            OptionMembers = " ",Applied,Approved,Rejected,Comp;
            DataClassification = CustomerContent;
        }
        field(8; "Leave Application No."; Code[20])
        {
            Caption = 'Leave Application No.';
            DataClassification = CustomerContent;
        }
        field(9; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(10; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(11; level; Integer)
        {
            Caption = 'level';
            DataClassification = CustomerContent;
        }
        field(12; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(13; level2; Integer)
        {
            Caption = 'level2';
            DataClassification = CustomerContent;
        }
        field(14; Flag; Integer)
        {
            Caption = 'Flag';
            DataClassification = CustomerContent;

        }
        field(15; "Show App Code"; Text[20])
        {
            Caption = 'Show App Code';
            DataClassification = CustomerContent;
        }
        field(16; "Show Emp Code"; Text[20])
        {
            Caption = 'Show Emp Code';
            DataClassification = CustomerContent;
        }
        field(17; "Show Leave Desp"; Text[50])
        {
            Caption = 'Show Leave Desp';
            DataClassification = CustomerContent;
        }
        field(18; "Show Leave Date"; Date)
        {
            Caption = 'Show Leave Date';
            DataClassification = CustomerContent;
        }
        field(19; "Show Approval Status"; Text[10])
        {
            Caption = 'Show Approval Status';
            DataClassification = CustomerContent;
        }
        field(20; "Show Emp Name"; Text[50])
        {
            Caption = 'Show Emp Name';
            DataClassification = CustomerContent;
        }
        field(27; "Cancel Request"; Boolean)
        {
            Caption = 'Cancel Request';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No", "Leave Code", "Leave Date", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

