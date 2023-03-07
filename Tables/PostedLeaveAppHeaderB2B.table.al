table 33001307 "Posted Leave App Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Leave App Header_B2B';
    LookupPageID = "Posted Leave App List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Employee UserID"; Code[50])
        {
            Caption = 'Employee UserID';
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(7; "Applied Date"; Date)
        {
            Caption = 'Applied Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(15; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Last Modified Date"; Date)
        {
            Caption = 'Last Modified Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Emp Performance Log B2B"."Employee Code";
            DataClassification = CustomerContent;
        }
        field(25; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        PostedLeaveAppLine.RESET();
        PostedLeaveAppLine.SETRANGE("Document No.", "Document No.");
        PostedLeaveAppLine.DELETEALL(true);
    end;

    var
        PostedLeaveAppLine: Record "Posted Leave App Line B2B";
}

