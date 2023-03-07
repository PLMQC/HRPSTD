table 33001310 "Leave Plan B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Plan_B2B';
    DrillDownPageID = "Leave Plan Posted B2B";
    LookupPageID = "Leave Plan B2B";
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
            TableRelation = "Leave Master B2B";
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
            OptionCaption = 'Leave,LOP,NonWorking';
            OptionMembers = Leave,LOP,NonWorking;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (xRec."Leave Type" = xRec."Leave Type"::NonWorking) or (Rec."Leave Type" = Rec."Leave Type"::NonWorking) then
                    ERROR(Text001Lbl);
            end;
        }
        field(7; "Approved Status"; Option)
        {
            Caption = 'Approved Status';
            OptionCaption = ' ,Applied,Approved,Rejected,Cancelled';
            OptionMembers = " ",Applied,Approved,Rejected,Cancelled;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Approved Status" = "Approved Status"::Rejected then
                    "Posted Status" := "Posted Status"::Cancelled
                else
                    "Posted Status" := "Posted Status"::Post;
            end;
        }
        field(8; "Leave Application No."; Code[20])
        {
            Caption = 'Leave Application No.';
            TableRelation = "Leave Application Header B2B"."Document No.";
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
        field(11; Level; Integer)
        {
            Caption = 'Level';
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(25; "Posted Status"; Option)
        {
            Caption = 'Posted Status';
            OptionCaption = ' ,Post,Cancelled';
            OptionMembers = " ",Post,Cancelled;
            DataClassification = CustomerContent;
        }
        field(26; Processed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Processed';
        }
        field(27; "Cancel Request"; Boolean)
        {
            Caption = 'Cancel Request';
            DataClassification = CustomerContent;
        }
        field(28; "Attendance Processed"; Boolean)
        {
            Caption = 'Attendance Processed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50; "Compensatory Leave"; Boolean)
        {
            Caption = 'Compensatory Leave';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Compensatory Leave" then 
                    if ("Leave Type" <> "Leave Type"::LOP) or ("Approved Status" <> "Approved Status"::Approved) then
                        ERROR(Text002Lbl);
                
            end;
        }
        field(51; "Session Time"; Option)
        {
            Caption = 'Session Time';
            OptionCaption = ' ,First Half,Second Half';
            OptionMembers = " ","First Half","Second Half";
            DataClassification = CustomerContent;
        }
        field(52; "Leave Duration"; Option)
        {
            Caption = 'Leave Duration';
            OptionCaption = ' ,Half Day,Leave';
            OptionMembers = " ","Half Day",Leave;
            DataClassification = CustomerContent;
        }
        field(53; Cancel; Boolean)
        {
            Caption = 'Cancel';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Cancel then
                    "Approved Status" := "Approved Status"::Cancelled
                else
                    "Approved Status" := "Approved Status"::Approved;
                MODIFY();
            end;
        }
    }

    keys
    {
        key(Key1; "Employee No", "Leave Code", "Leave Date", "Leave Application No.", "Session Time")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnRename();
    begin
        ERROR('');
    end;

    var
        Text001Lbl: Label 'You cannot change to Non-Working.';
        Text002Lbl: Label 'leave type should be ''''LOP'''' and approved status should be ''''Approved''''';
}

