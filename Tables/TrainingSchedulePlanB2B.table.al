table 33001268 "Training Schedule Plan B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Schedule Plan';
    DrillDownPageID = "Training Schedule Plan B2B";
    LookupPageID = "Training Schedule Plan B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Department,Dates,KT';
            OptionMembers = Department,Dates,KT;
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(6; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = CustomerContent;
        }
        field(7; "Training Date"; Date)
        {
            Caption = 'Training Date';
            DataClassification = CustomerContent;
        }
        field(8; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B" where(Blocked = const(false));//B2BMMOn08Feb2023
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Employee.GET("Employee No.");
                "Employee Name" := Employee."First Name";


            end;
        }
        field(9; Remarks; Text[150])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(10; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Type, "Document No.", "Document Line No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if Type = Type::KT then
            TESTFIELD("Training Date");
    end;

    var
        Employee: Record "Employee B2B";
}

