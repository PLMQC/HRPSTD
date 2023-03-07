table 33001299 "Leave  Approval Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave  Approval Setup_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,LeaveApplication,LeaveCancelation';
            OptionMembers = " ",LeaveApplication,LeaveCancelation;
            DataClassification = CustomerContent;
        }
        field(2; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(4));
            DataClassification = CustomerContent;
        }
        field(3; User; Code[50])
        {
            Caption = 'User';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(4; HOD; Code[50])
        {
            Caption = 'HOD';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(5; "Additional Approver"; Code[50])
        {
            Caption = 'Additional Approver';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(6; "HR Approver"; Code[50])
        {
            Caption = 'HR Approver';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", Department, "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

