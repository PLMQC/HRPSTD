table 33001257 "Leave Sanction Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Sanction Details';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
        }
        field(2; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            DataClassification = CustomerContent;
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;
        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;
        }
        field(5; "Sanctioned By"; Code[20])
        {
            Caption = 'Sanctioned By';
            TableRelation = "Leave Sanc. Incharge B2B"."Sanctioning Incharge" WHERE("Employee No." = FIELD("Employee Code"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                LeaveApp.SETRANGE("Employee No.", "Employee Code");
                LeaveApp.SETRANGE("From Date", "From Date");
                LeaveApp.SETRANGE("To Date", "To Date");
                if LeaveApp.FINDFIRST() then begin
                    if "Sanctioned By" <> '' then
                        LeaveApp.Sanctioned := true;
                    LeaveApp.MODIFY();
                end;
            end;
        }
        field(6; "Date of Sanction"; Date)
        {
            Caption = 'Date of Sanction';
            DataClassification = CustomerContent;
        }
        field(7; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(8; "No.of Days"; Decimal)
        {
            Caption = 'No.of Days';
            DataClassification = CustomerContent;
        }
        field(9; "Reasons For Leave"; Text[150])
        {
            Caption = 'Reasons For Leave';
            DataClassification = CustomerContent;
        }
        field(10; "Leave Duration"; Option)
        {
            Caption = 'Leave Duration';
            OptionCaption = ' ,Half day,Leave';
            OptionMembers = " ","Half day",Leave;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Leave Code", "From Date", "To Date", "Sanctioned By")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LeaveApp: Record "Leave Application B2B";
}

