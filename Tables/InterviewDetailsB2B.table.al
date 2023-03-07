table 33001205 "Interview Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Interview Details';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Interview Type"; Code[20])
        {
            Caption = 'Interview Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('INTERVIEW TYPES'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Lookup_B2B.SETRANGE("Lookup Name", "Interview Type");
                if Lookup_B2B.FINDFIRST() then
                    Description := Lookup_B2B.Description;
            end;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Interview Call Date"; Date)
        {
            Caption = 'Interview Call Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Starting Date" <> 0D then
                    if "Interview Call Date" > "Starting Date" then
                        ERROR(Text000Lbl);
                if "Ending Date" <> 0D then
                    if "Ending Date" < "Interview Call Date" then
                        ERROR(Text003Lbl);
            end;
        }
        field(6; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Interview Call Date" = 0D then
                    ERROR(Text001Lbl);
                if "Interview Call Date" <> 0D then
                    if "Starting Date" < "Interview Call Date" then
                        ERROR(Text000Lbl);
                if "Ending Date" <> 0D then
                    if "Ending Date" < "Starting Date" then
                        ERROR(Text002Lbl);
            end;
        }
        field(7; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Starting Date" = 0D then
                    ERROR(Text003Lbl);
                if "Starting Date" <> 0D then
                    if "Starting Date" > "Ending Date" then
                        ERROR(Text002Lbl);
            end;
        }
        field(8; "User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
        }
        field(20; "Interview Time"; Time)
        {
            Caption = 'Interview Time';
            DataClassification = CustomerContent;
        }
        field(21; "Interview Venue"; Text[50])
        {
            Caption = 'Interview Venue';
            DataClassification = CustomerContent;
        }
        field(22; "Panel of interviewers"; Text[250])
        {
            Caption = 'Panel of interviewers';
            DataClassification = CustomerContent;
        }
        field(100; "Interviewed By"; Text[50])
        {
            Caption = 'Interviewed By';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                    "Interviewed By" := Employee."First Name";
                    "Interviewer UserId" := Employee."User Id";
                    "Interviewer Mail" := Employee."Company E-Mail";
                end;
            end;
        }
        field(101; "Informed by"; Text[50])
        {
            Caption = 'Informed by';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then
                    "Informed by" := Employee."First Name";
            end;
        }
        field(102; Remarks; Text[30])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(103; "Resume Reference No."; Code[20])
        {
            Caption = 'Resume Reference No.';
            DataClassification = CustomerContent;
        }
        field(104; "Recruitment Line No."; Integer)
        {
            Caption = 'Recruitment Line No.';
            DataClassification = CustomerContent;
        }
        field(105; Pannel; Boolean)
        {
            Caption = 'Pannel';
            DataClassification = CustomerContent;
        }
        field(106; "Pannel Members"; Text[250])
        {
            Caption = 'Pannel Members';
            DataClassification = CustomerContent;
        }
        field(107; "Interviewer UserId"; Code[50])
        {
            Caption = 'Interviewer UserId';
            DataClassification = CustomerContent;
        }
        field(108; "Interviewer Mail"; Text[80])
        {
            Caption = 'Interviewer Mail';
            DataClassification = CustomerContent;
        }
        field(109; "Sender Mail"; Text[80])
        {
            Caption = 'Sender Mail';
            DataClassification = CustomerContent;
        }
        field(110; "Interview Status"; Code[20])
        {
            Caption = 'Interview Status';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Recruitment Line No.", "Resume Reference No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        InterviewHistory.SETRANGE("Recruitment Header No", "Document No.");
        if InterviewHistory.FINDFIRST() then
            InterviewHistory.DELETEALL();
    end;

    trigger OnInsert();
    begin
        Evaluate("User Id", USERID());
    end;

    var
        Lookup_B2b: Record Lookup_B2B;
        InterviewHistory: Record "Interview History B2B";
        Employee: Record "Employee B2B";
        Text000Lbl: Label 'Starting date must be greater than or equal to Interview call date.';
        Text001Lbl: Label 'You must enter Interview call date.';
        Text002Lbl: Label 'Ending date must be greater than or equal to Starting date.';
        Text003Lbl: Label 'You must enter Starting date.';

}

