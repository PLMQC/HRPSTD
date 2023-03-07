table 33001358 "Job Description Header(RO) B2B"
{
    // version B2BHR1.00.00

    Caption = 'Job Description Header(RO)';
    LookupPageID = "Job Description List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Job Description"; Text[100])
        {
            Caption = 'Job Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(3; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = FILTER(4));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(4; Section; Code[20])
        {
            Caption = 'Section';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(5; "Date Of Creation"; Date)
        {
            Caption = 'Date Of Creation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(6; "Date Of Modification"; Date)
        {
            Caption = 'Date Of Modification';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(8; Comment; Boolean)
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(9; "Release Status"; Option)
        {
            Caption = 'Release Status';
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(10; "Reports To"; Code[20])
        {
            Caption = 'Reports To';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
                EmpRec.RESET();
                EmpRec.SETRANGE("No.", "Reports To");
                if EmpRec.FINDFIRST() then
                    "Reports To Designation" := EmpRec.Designation;
            end;
        }
        field(11; "Reported By"; Code[20])
        {
            Caption = 'Reported By';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(12; "Salary Range"; Option)
        {
            Caption = 'Salary Range';
            OptionMembers = " ","3000-5000","5000-8000","8000-10000","10000-15000","15000-25000","25000-30000","30000-50000";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(13; "Global Dimension 1"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('PUBLICATION'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(100; "Reports To Designation"; Code[50])
        {
            Caption = 'Reports To Designation';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(101; "Job Designation"; Code[20])
        {
            Caption = 'Job Designation';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(102; Experience; Decimal)
        {
            Caption = 'Experience';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(103; "Organization Chart Ref."; Code[20])
        {
            Caption = 'Organization Chart Ref.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(104; "No. of Reportee"; Integer)
        {
            Caption = 'No. of Reportee';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(105; "Work Group Code"; Code[20])
        {
            Caption = 'Work Group Code';
            TableRelation = "Surcharge Tax Header B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(106; "Level Code"; Code[20])
        {
            Caption = 'Level Code';
            TableRelation = "Employee Goals B2B"."Line No." WHERE("Employee Code" = FIELD("Work Group Code"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(107; "Type of Position"; Option)
        {
            Caption = 'Type of Position';
            OptionCaption = ' ,Permanent,Contract';
            OptionMembers = " ",Permanent,Contract;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
        field(110; "Type of Shift"; Option)
        {
            Caption = 'Type of Shift';
            OptionCaption = ' ,General,Others';
            OptionMembers = " ",General,Others;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Release Status", "Release Status"::Open);
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TESTFIELD("Release Status", "Release Status"::Open);
    end;

    trigger OnInsert();
    begin
        if "No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD("Job Description Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Job Description Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Date Of Creation" := WORKDATE();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        EmpRec: Record "Employee B2B";
        NoSeriesMgt: Codeunit 396;

    procedure AssistEdit(OldJobDescriptionHeader: Record "Job Description Header(RO) B2B"): Boolean;
    var
        JobDescheader: Record "Job Description Header(RO) B2B";
    begin
        with JobDescheader do begin
            JobDescheader := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Job Description Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Job Description Nos.", OldJobDescriptionHeader."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Job Description Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := JobDescheader;
                exit(true);
            end;
        end;
    end;

    procedure Release();
    var
        Text002Lbl: Label 'Do You Want to Release?';
    begin
        if not CONFIRM(Text002Lbl, false) then
            exit;
        TESTFIELD("Release Status", "Release Status"::Open);
        LOCKTABLE();
        "Release Status" := "Release Status"::Released;
        MODIFY();
    end;

    procedure Reopen();
    var
        Text003Lbl: Label 'Do You Want to Reopen?';
    begin
        if not CONFIRM(Text003Lbl, false) then
            exit;
        TESTFIELD("Release Status", "Release Status"::Released);
        LOCKTABLE();
        "Release Status" := "Release Status"::Open;
        MODIFY();
    end;

    procedure JobSkills();
    var
        CredentialLRec: Record "Credentials B2B";
    begin
        CredentialLRec.RESET();
        CredentialLRec.SETRANGE("Document No.", "No.");
        CredentialLRec.SETRANGE("Document Type", CredentialLRec."Document Type"::Jobs);
        PAGE.RUNMODAL(PAGE::"Employee Skills B2B", CredentialLRec);
    end;
}

