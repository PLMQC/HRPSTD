table 33001301 "Employee Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Leaves_B2B';
    DrillDownPageID = "Emp Leave List B2B";
    LookupPageID = "Emp Leave List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Employee Name"; Text[50])
        {
            CalcFormula = Lookup ("Employee B2B"."First Name" WHERE("No." = FIELD("No.")));
            Caption = 'Employee Name';
            FieldClass = FlowField;
        }
        field(4; "Leave Pay Cadre"; Code[50])
        {
            Caption = 'Leave Pay Cadre';
            Editable = false;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(22));
            DataClassification = CustomerContent;
        }
        field(6; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            Editable = false;
            TableRelation = "Leave Master B2B"."Leave Code";
            DataClassification = CustomerContent;
        }
        field(7; "Leave Description"; Text[50])
        {
            Caption = 'Leave Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "No. of Available Leaves"; Decimal)
        {
            CalcFormula = Sum ("Detailed Leave Records B2B"."No. of Leaves" WHERE("Employee No." = FIELD("No."),
                                                                              "Leave Code" = FIELD("Leave Code"),
                                                                              "Leave Pay Cadre" = FIELD("Leave Pay Cadre")));
            Caption = 'No. of Available Leaves';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Leaves for the Current Period"; Decimal)
        {
            Caption = 'Leaves for the Current Period';
            DataClassification = CustomerContent;
        }
        field(11; "Next Leave Period"; Date)
        {
            Caption = 'Next Leave Period';
            DataClassification = CustomerContent;
        }
        field(12; "Present Leaves"; Boolean)
        {
            Caption = 'Present Leaves';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", "Leave Pay Cadre", "Leave Code")
        {
        }
        key(Key2; "Leave Code", "Leave Pay Cadre")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        DetailedLeaves.SETRANGE("Employee No.", "No.");
        DetailedLeaves.SETRANGE("Leave Code", "Leave Code");
        DetailedLeaves.SETRANGE("Leave Pay Cadre", "Leave Pay Cadre");
        if DetailedLeaves.FINDFIRST() then
            ERROR(Text000Lbl);
    end;

    var
        DetailedLeaves: Record "Detailed Leave Records B2B";
        Text000Lbl: Label 'Detailed leave records exist. So you can not delete the records.';
}

