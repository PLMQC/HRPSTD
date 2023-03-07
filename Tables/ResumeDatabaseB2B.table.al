table 33001196 "Resume Database B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resume Database';
    DataCaptionFields = "No.", "First Name", "Middle Name", Surname;
    DrillDownPageID = "Resume Database List B2B";
    LookupPageID = "Resume Database List B2B";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(4; Surname; Text[30])
        {
            Caption = 'Surname';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(5; DOB; Date)
        {
            Caption = 'DOB';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(6; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(7; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            OptionCaption = 'Married,Single';
            OptionMembers = Married,Single;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(8; Address1; Text[30])
        {
            Caption = 'Address1';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(9; Address2; Text[30])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
                Postcode.ValidatePostCode(City, "Post Code", County, "Country code", (CurrFieldNo <> 0) and GUIALLOWED());
            end;
        }
        field(12; State; Text[30])
        {
            Caption = 'State';

            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(13; "Country code"; Code[10])
        {
            Caption = 'Country code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(14; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(15; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(16; "E-Mail1"; Text[50])
        {
            Caption = 'E-Mail1';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(17; "E-Mail2"; Text[50])
        {
            Caption = 'E-Mail2';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(18; County; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(30; Reference; Text[30])
        {
            Caption = 'Reference';
            TableRelation = IF (Source = CONST("Employee Reference")) "Employee B2B"."No." else
            IF (Source = CONST(Consultant)) Vendor."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(31; "Experience(Years)"; Integer)
        {
            Caption = 'Experience(Years)';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(32; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(34; Selected; Boolean)
        {
            Caption = 'Selected';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(35; Status; Code[20])
        {
            Caption = 'Status';
            Editable = false;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(7));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(38; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(39; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(40; Source; Option)
        {
            Caption = 'Source';
            OptionCaption = 'News Paper,Employee Reference,Internet,Consultant,Others';
            OptionMembers = "News Paper","Employee Reference",Internet,Consultant,Others;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
                if Source <> Source::"Employee Reference" then
                    Reference := '';
            end;
        }
        field(41; "Others Description"; Code[30])
        {
            Caption = 'Others Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(42; "Release Status"; Option)
        {
            Caption = 'Release Status';
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(43; Months; Integer)
        {
            Caption = 'Months';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(44; "Released Date"; Date)
        {
            Caption = 'Released Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(45; "Date of Receipt of Resume"; Date)
        {
            Caption = 'Date of Receipt of Resume';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(46; "Last Updated"; Date)
        {
            Caption = 'Last Updated';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(47; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(50; "In Process of Recruitment"; Boolean)
        {
            Caption = 'In Process of Recruitment';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(326; "Source of Hiring"; Option)
        {
            Caption = 'Source of Hiring';
            OptionCaption = ' ,Local,Overseas';
            OptionMembers = " ",Local,Overseas;
            DataClassification = CustomerContent;
            trigger OnValidate();
            var
                Credential: Record "Credentials B2B";
                Credential2: Record "Credentials B2B";
                Credential3: Record "Credentials B2B";
            begin
                TestStatusOpen();
                Credential.Reset();
                Credential.SetRange("Document No.", "No.");
                Credential.SetRange("Skill Type", Credential."Skill Type"::SOURCE);
                if Credential.FindFirst() then begin
                    Credential."Credential Code" := Format("Source of Hiring");
                    Credential.Description := Format("Source of Hiring");
                    Credential.Modify();
                end else begin
                    Credential3.Reset();
                    Credential3.SetRange("Document No.", "No.");
                    if Credential3.FindLast() then;
                    Credential2.INIT();
                    Credential2."Document No." := "No.";
                    Credential2."Document Type" := Credential2."Document Type"::"Resume Database";
                    Credential2."Line No." := Credential3."Line No." + 10000;
                    Credential2."Skill Type" := Credential2."Skill Type"::SOURCE;
                    Credential2.Type := format(Credential2."Skill Type"::SOURCE);
                    Credential2.Description := Format("Source of Hiring");
                    Credential2."Credential Code" := Format("Source of Hiring");
                    Credential2.INSERT();
                end;

            end;

        }
        field(327; "Experience Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Fresher,Experienced;
            OptionCaption = 'Fresher,Experienced';


        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "First Name", Surname)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatusOpen();
    end;

    trigger OnInsert();
    begin
        if "No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Resume DB Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Resume DB Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Date of Receipt of Resume" := TODAY();
        if "Last Updated" = 0D then
            "Last Updated" := TODAY();
    end;

    trigger OnModify();
    begin
        TestStatusOpen();
        "Last Updated" := TODAY();
    end;

    trigger OnRename();
    begin
        TestStatusOpen();
    end;

    var
        Postcode: Record "Post Code";
        HRSetup: Record "HR Setup B2B";
        NoSeriesMgt: Codeunit 396;

    procedure AssistEdit(OldResumeDB: Record "Resume Database B2B"): Boolean;
    var
        ResumeDB: Record "Resume Database B2B";
    begin
        with ResumeDB do begin
            ResumeDB := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Resume DB Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Resume DB Nos.", OldResumeDB."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Resume DB Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := ResumeDB;
                exit(true);
            end;
        end;
    end;

    /*
    procedure Attachments();
    var
        Attachment: Record "HR Attachment-B2B";
    begin
        Attachment.RESET();
        Attachment.SETRANGE("Table ID", DATABASE::"Resume Database");
        Attachment.SETRANGE("Document No.", "No.");
        PAGE.RUNMODAL(PAGE::HRAttachments_B2B, Attachment);
    end;*/

    procedure Release();
    var
        Text002Lbl: Label 'Do You Want to Release?';
    begin
        TESTFIELD("Release Status", "Release Status"::Open);
        TESTFIELD(DOB);
        if not CONFIRM(Text002Lbl, false) then
            exit;

        LOCKTABLE();
        "Release Status" := "Release Status"::Released;
        "Released Date" := WORKDATE();
        MODIFY();
    end;

    local procedure TestStatusOpen();
    begin
        TESTFIELD("Release Status", "Release Status"::Open);
    end;

    procedure Reopen();
    var
        Text003Lbl: Label 'Do you want to Reopen?';
    begin
        TESTFIELD("Release Status", "Release Status"::Released);
        if not CONFIRM(Text003Lbl, false) then
            exit;

        LOCKTABLE();
        "Release Status" := "Release Status"::Open;
        MODIFY();
    end;

    procedure ResumeSkills();
    var
        CredentialLRec: Record "Credentials B2B";
    begin
        CredentialLRec.RESET();
        CredentialLRec.SETRANGE("Document No.", "No.");
        CredentialLRec.SETRANGE("Document Type", CredentialLRec."Document Type"::"Resume Database");
        PAGE.RUNMODAL(PAGE::"Credentials B2B", CredentialLRec);
    end;
}

