table 33001302 "Detailed Leave Records B2B"
{
    // version B2BHR1.00.00

    Caption = 'Detailed Leave Records_B2B';
    DrillDownPageID = "Emp Leave History List B2B";
    LookupPageID = "Emp Leave History List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Entitlement,Utilization,Lapse,Encashment,Correction,Opening Balance';
            OptionMembers = Entitlement,Utilization,Lapse,Encashment,Correction,"Opening Balance";
            DataClassification = CustomerContent;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(3; "Entry Date"; Date)
        {
            Caption = 'Entry Date';
            DataClassification = CustomerContent;
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(6; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Leave Master B2B"."Leave Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Employee.GET("Employee No.");
                if LeaveMaster.GET("Leave Code") then
                    "Leave Description" := LeaveMaster.Description;
            end;
        }
        field(7; "Leave Description"; Text[50])
        {
            Caption = 'Leave Description';
            DataClassification = CustomerContent;
        }
        field(8; "Leave Pay Cadre"; Code[50])
        {
            Caption = 'Leave Pay Cadre';
            DataClassification = CustomerContent;
        }
        field(10; "No. of Leaves"; Decimal)
        {
            Caption = 'No. of Leaves';
            DataClassification = CustomerContent;
        }
        field(12; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(13; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(14; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(17; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approved By';
        }
        field(18; "Reason For Leave"; Text[50])
        {
            Caption = 'Reason For Leave';
            DataClassification = CustomerContent;
        }
        field(19; "Leave Application No."; Code[20])
        {
            Caption = 'Leave Application No.';
            DataClassification = CustomerContent;
        }
        field(20; "Lapse"; Boolean)
        {

            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            SumIndexFields = "No. of Leaves";
        }
        key(Key2; "Employee No.", "Leave Code", "Leave Pay Cadre")
        {
            SumIndexFields = "No. of Leaves";
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
        LeaveMaster: Record "Leave Master B2B";
}

