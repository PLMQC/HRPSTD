table 33001335 "Leave Encashment Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Encashment Line_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Encashment Code"; Code[20])
        {
            Caption = 'Encashment Code';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
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
        field(6; PayCadre; Code[20])
        {
            Caption = 'PayCadre';
            DataClassification = CustomerContent;
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Grade,All';
            OptionMembers = Employee,Grade,All;
            DataClassification = CustomerContent;
        }
        field(8; "Available Leaves"; Decimal)
        {
            Caption = 'Available Leaves';
            DataClassification = CustomerContent;
        }
        field(9; "Leaves To Encash"; Decimal)
        {
            Caption = 'Leaves To Encash';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if LeaveMaster.GET("Leave Code") then begin
                    if "Leaves To Encash" > LeaveMaster."Max. Encashable" then
                        ERROR(Text001Lbl);
                    if "Leaves To Encash" > "Available Leaves" then
                        if not CONFIRM(Text002Lbl, false) then
                            ERROR('');
                end;
            end;
        }
        field(10; "Encash Amount"; Decimal)
        {
            Caption = 'Encash Amount';
            DataClassification = CustomerContent;
        }
        field(11; Post; Boolean)
        {
            Caption = 'Post';
            DataClassification = CustomerContent;
        }
        field(12; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(15; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            DataClassification = CustomerContent;
        }
        field(42; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(43; "Leave Pay Cadre"; Code[50])
        {
            Caption = 'Leave Pay Cadre';
            TableRelation = IF (Type = FILTER(Grade)) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = filter('LEAVE PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(45; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Encashment Code", "Line No.")
        {
        }
        key(Key2; "Employee Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LeaveMaster: Record "Leave Master B2B";
        Text001Lbl: Label 'Leaves to encash should be less than maximum leaves to encashable.';
        Text002Lbl: Label 'Do you want to allow to Encash?';
}

