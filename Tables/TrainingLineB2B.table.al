table 33001200 "Training Line B2B"
{
    // version B2BHR1.00.00
    DataClassification = CustomerContent;
    Caption = 'Training Line';

    fields
    {
        field(1; "Training Header No."; Code[20])
        {
            Caption = 'Training Header No.';
            DataClassification = CustomerContent;
        }
        field(2; "Training Line No."; Integer)
        {
            Caption = 'Training Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B" where(Blocked = const(false));//B2BMMOn08Feb2023
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TrainingLine.SETRANGE("Training Header No.", "Training Header No.");
                if TrainingLine.FINDFIRST() then
                    repeat
                        if "Employee No." = TrainingLine."Employee No." then
                            ERROR(Text001Lbl);
                    until TrainingLine.NEXT() = 0;

                if Employee.GET("Employee No.") then begin  //B2BMMOn08Feb2023
                    //Employee.SETRANGE("No.", "Employee No.");
                    //if Employee.FINDFIRST() then begin
                    Name := Employee."First Name";
                    "Middle Name" := Employee."Middle Name";
                    Surname := Employee.Initials;
                    "Department Code" := Employee."Department Code";
                    Designation := Employee.Designation;
                end;
            end;
        }
        field(4; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(5; "Employee Feedback"; Text[30])
        {
            Caption = 'Employee Feedback';
            DataClassification = CustomerContent;
        }
        field(6; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }
        field(7; Surname; Text[30])
        {
            Caption = 'Surname';
            DataClassification = CustomerContent;
        }
        field(8; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;

        }
        field(9; Designation; Code[50])
        {
            Caption = 'Designation';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            DataClassification = CustomerContent;
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(11; "KT Given"; Boolean)
        {
            Caption = 'KT Given';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; Attendance; Boolean)
        {
            Caption = 'Attendance';
            DataClassification = CustomerContent;
        }
        field(16; "Emp no."; Code[20])
        {
            Caption = 'Emp no.';
            DataClassification = CustomerContent;
        }
        field(17; EmployeeName; Text[30])
        {
            Caption = 'EmployeeName';
            DataClassification = CustomerContent;
        }
        field(18; Subject; Code[10])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
        }
        field(19; Justification; Text[30])
        {
            Caption = 'Justification';
            DataClassification = CustomerContent;
        }
        field(21; "Internal/External"; Option)
        {
            Caption = 'Internal/External';
            OptionMembers = " ",Internal,External;
            DataClassification = CustomerContent;
        }
        field(22; Venue; Text[30])
        {
            Caption = 'Venue';
            DataClassification = CustomerContent;
        }
        field(23; "Institute/Trainer"; Text[30])
        {
            Caption = 'Institute/Trainer';
            DataClassification = CustomerContent;
        }
        field(24; Remarks; Text[30])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(25; Reason; Text[30])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
        }
        field(26; "Appox. Cost"; Decimal)
        {
            Caption = 'Appox. Cost';
            DataClassification = CustomerContent;
        }
        field(27; "Management Approval"; Boolean)
        {
            Caption = 'Management Approval';
            DataClassification = CustomerContent;
        }
        field(28; Section; Code[20])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(29; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;
        }
        field(30; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;
        }
        field(31; Department; Code[20])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
        }
        field(32; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(33; "Effective Rating"; Code[30])
        {
            Caption = 'Effective Rating';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('EFFECTIVE RATINGS'));
            DataClassification = CustomerContent;
        }
        field(34; "HR Remarks"; Text[100])
        {
            Caption = 'HR Remarks';
            DataClassification = CustomerContent;
        }
        field(36; "Need  for Training"; Text[30])
        {
            Caption = 'Need  for Training';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('NEED FOR TRAINING'));
            DataClassification = CustomerContent;
        }
        field(38; "Training Facility"; Option)
        {
            Caption = 'Training Facility';
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
            DataClassification = CustomerContent;
        }
        field(40; "Training Premises"; Option)
        {
            Caption = 'Training Premises';
            OptionCaption = 'Outside Office,Within Office';
            OptionMembers = "Outside Office","Within Office";
            DataClassification = CustomerContent;
        }
        field(42; "Training Type"; Text[30])
        {
            Caption = 'Training Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('TYPE OF TRAINING'));
            DataClassification = CustomerContent;
        }
        field(44; "Training Start Date"; Date)
        {
            Caption = 'Training Start Date';
            DataClassification = CustomerContent;
        }
        field(45; "Emp. Training Need Doc. No."; Code[20])
        {
            Caption = 'Emp. Training Need Doc. No.';
            DataClassification = CustomerContent;
        }
        field(46; Duration; Decimal)
        {
            BlankZero = true;
            Caption = 'Duration';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(52; Attend; Boolean)
        {
            Caption = 'Attend';
            DataClassification = CustomerContent;

        }
        field(55; "Attend Date"; Date)
        {
            Caption = 'Attend Date';
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(Key1; "Training Header No.", "Training Line No.")
        {
        }
        key(Key2; "Training Header No.", "Emp no.", "Department Code", "Internal/External", "Training Line No.", Subject)
        {
        }
        key(Key3; "Employee No.")
        {
        }
        key(Key4; "Employee No.", "Training Facility", "Training Premises", "Training Type", "Need  for Training", "Training Start Date")
        {
            SumIndexFields = Duration;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
        TrainingLine: Record "Training Line B2B";
        Text001Lbl: Label 'Employee already exixts';

    /*
    procedure Attachments();
    var
        Attachment: Record "HR Attachment-B2B";
    begin
        Attachment.RESET();
        Attachment.SETRANGE("Table ID", DATABASE::"Training Line");
        Attachment.SETRANGE("Document No.", "Employee No.");
        PAGE.RUNMODAL(PAGE::HRAttachments_B2B, Attachment);
    end;*/
}

