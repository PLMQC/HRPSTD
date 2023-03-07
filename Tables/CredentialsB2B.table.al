table 33001207 "Credentials B2B"
{
    // version B2BHR1.00.00

    Caption = 'Credentials';
    DrillDownPageID = "Credentials B2B";
    LookupPageID = "Credentials B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Skill Type"; Option)
        {
            Caption = 'Skill Type';
            OptionCaption = ' ,SKILL SET,QUALIFICATION,CERTIFICATION,TYPE OF INDUSTRY,EXPERIENCE TYPE,SOURCE';
            OptionMembers = " ","SKILL SET",QUALIFICATION,CERTIFICATION,"TYPE OF INDUSTRY","EXPERIENCE TYPE",SOURCE;
            DataClassification = CustomerContent;


            trigger OnValidate();
            begin
                Type := FORMAT("Skill Type");
            end;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Credential Code"; Code[20])
        {
            Caption = 'Credential Code';
            DataClassification = CustomerContent;
            TableRelation = IF ("Skill Type" = CONST("SKILL SET")) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('SKILL SET'))
            ELSE
            IF ("Skill Type" = CONST(QUALIFICATION)) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('QUALIFICATION'))
            ELSE
            IF ("Skill Type" = CONST(CERTIFICATION)) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('CERTIFICATION'))
            ELSE
            IF ("Skill Type" = CONST("TYPE OF INDUSTRY")) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('TYPE OF INDUSTRY'));

            trigger OnValidate();
            begin
                Lookup_B2B.SETRANGE("Lookup Name", "Credential Code");
                if Lookup_B2B.FINDFIRST() then
                    Description := Lookup_B2B.Description;

                Credential.SETRANGE("Document No.", "Document No.");
                Credential.SETRANGE("Skill Type", "Skill Type");
                if Credential.FINDFIRST() then
                    repeat
                        if "Credential Code" = Credential."Credential Code" then
                            ERROR(Text003Lbl);

                    until Credential.NEXT() = 0;

            end;
        }
        field(6; Recruitment; Boolean)
        {
            Caption = 'Recruitment';
            DataClassification = CustomerContent;
        }
        field(7; Type; Code[50])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(8; "Resume Database"; Boolean)
        {
            Caption = 'Resume Database';
            DataClassification = CustomerContent;
        }
        field(9; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (Percentage < 0) or (Percentage > 100) then
                    ERROR(Text004Lbl);
            end;
        }
        field(10; Designation; Code[50])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(11; Employee; Boolean)
        {
            Caption = 'Employee';
            DataClassification = CustomerContent;
        }
        field(12; Institution; Text[30])
        {
            Caption = 'Institution';
            DataClassification = CustomerContent;
        }
        field(13; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;
        }
        field(14; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;
        }
        field(15; "Name of Institute/University"; Text[100])
        {
            Caption = 'Name of Institute/University';
            DataClassification = CustomerContent;
        }
        field(18; Remarks; Code[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(19; No; Code[10])
        {
            Caption = 'No';
            TableRelation = "Resume Database B2B";
            DataClassification = CustomerContent;
        }
        field(22; "Recritment Policy No."; Code[20])
        {
            Caption = 'Recritment Policy No.';
            DataClassification = CustomerContent;
        }
        field(23; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Resource Indent,Recruitment,Jobs,Resume Database';
            OptionMembers = "Resource Indent",Recruitment,Jobs,"Resume Database";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Document Type", "Line No.")
        {
        }
        key(Key2; "Document No.", "Skill Type", "Line No.", Designation)
        {
        }
        key(Key3; "Document No.", Employee)
        {
        }
        key(Key4; "Line No.")
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
        TestStatusOpen();
    end;

    trigger OnModify();
    begin
        TestStatusOpen();
    end;

    trigger OnRename();
    begin
        TestStatusOpen();
    end;

    var
        Lookup_B2B: Record Lookup_B2B;
        Credential: Record "Credentials B2B";
        Flag: Boolean;
        Text002Lbl: Label 'Thier is no matched records with this skills.';
        Text003Lbl: Label 'This Credential Code is already selected.';
        Text004Lbl: Label 'Percentage must be between 0 and 100.';
        Text001Lbl: Label 'Their is no released records.';


    procedure InsertResumeRecords("No.": Code[20]; Type: Code[20]; Credentials: Code[20]; Recruitment: Boolean);
    var
        Resume: Record "Resume Database B2B";
        RecruitmentLine: Record "Recruitment Line B2B";
        RecruitmentLine2: Record "Recruitment Line B2B";
        Credential2: Record "Credentials B2B";
        Recruitmentheader: Record "Recruitment Header B2B";
        CheckRecruitmentLine: Record "Recruitment Line B2B";

    begin

        Recruitmentheader.reset();
        Recruitmentheader.setrange("document type", Recruitmentheader."Document Type"::"Resource Indent");
        Recruitmentheader.SetRange("Recruitment Policy No.", "Document No.");
        if Recruitmentheader.findfirst() then;


        RecruitmentLine2.SETRANGE("Recruitment Header No", "Document No.");
        if RecruitmentLine2.FINDFIRST() then
            RecruitmentLine2.DELETEALL();

        Resume.RESET();
        Resume.SETRANGE("Release Status", Resume."Release Status"::Released);
        Resume.SETRANGE(Selected, false);
        /*
        if Recruitmentheader."Source of Hiring" = Recruitmentheader."Source of Hiring"::Local then
            resume.setrange("Source of Hiring", resume."Source of Hiring"::Local)
        else
            resume.setrange("Source of Hiring", resume."Source of Hiring"::Overseas);*/
        if Recruitmentheader.Nationality <> '' then
            Resume.setrange("Country code", Recruitmentheader.Nationality);
        if Recruitmentheader."Gender Preference" = Recruitmentheader."Gender Preference"::Male then
            resume.setrange(Gender, resume.Gender::Male)
        else
            if Recruitmentheader."Gender Preference" = Recruitmentheader."Gender Preference"::Female then
                resume.setrange(Gender, resume.Gender::feMale);
        if Recruitmentheader."Experience Type" = Recruitmentheader."Experience Type"::Experienced then
            Resume.setfilter("Experience(Years)", Recruitmentheader.Experience);
        if Resume.FINDFIRST() then
            repeat
                //if CheckAgeGroup(Resume, Recruitmentheader) then begin //CheckAge 
                Credential.RESET();
                Credential.SETRANGE("Document No.", Resume."No.");
                if Credential.FINDFIRST() then
                    repeat
                        Credential2.RESET();
                        Credential2.SETRANGE("Document No.", "Document No.");
                        Credential2.SETRANGE(Type, Credential.Type);
                        Credential2.SETRANGE("Credential Code", Credential."Credential Code");
                        Credential2.SETRANGE(Recruitment, true);
                        if Credential2.FINDFIRST() then begin
                            repeat
                                RecruitmentLine.INIT();
                                RecruitmentLine."Recruitment Header No" := "No.";
                                RecruitmentLine."Recruitment Line No." := RecruitmentLine."Recruitment Line No." + 10000;
                                RecruitmentLine."Resume Reference No." := Credential."Document No.";
                                RecruitmentLine."First Name" := Resume."First Name";
                                RecruitmentLine."Middle Name" := Resume."Middle Name";
                                RecruitmentLine.Surname := Resume.Surname;
                                RecruitmentLine.DOB := Resume.DOB;
                                RecruitmentLine.Gender := Resume.Gender;
                                RecruitmentLine."Marital Status" := Resume."Marital Status";
                                RecruitmentLine.Address1 := Resume.Address1;
                                RecruitmentLine.Address2 := Resume.Address2;
                                RecruitmentLine.City := Resume.City;
                                RecruitmentLine."Post Code" := Resume."Post Code";
                                RecruitmentLine.State := Resume.State;
                                RecruitmentLine."Country code" := Resume."Country code";
                                RecruitmentLine."Phone No." := Resume."Phone No.";
                                RecruitmentLine."Mobile Phone No." := Resume."Mobile Phone No.";
                                RecruitmentLine."E-Mail1" := Resume."E-Mail1";
                                RecruitmentLine."E-Mail2" := Resume."E-Mail2";
                                RecruitmentLine.Reference := Resume.Reference;
                                RecruitmentLine."Experience(Years)" := Resume."Experience(Years)";
                                RecruitmentLine.Remarks := Resume.Remarks;
                                RecruitmentLine.Status := Resume.Status;
                                RecruitmentLine."No. Series" := Resume."No. Series";
                                RecruitmentLine."System Created" := true;
                            until Credential2.NEXT() = 0;

                            if Resume.Blocked = false then begin
                                CheckRecruitmentLine.Reset();
                                CheckRecruitmentLine.SetRange("Resume Reference No.", RecruitmentLine."Resume Reference No.");
                                if not CheckRecruitmentLine.FindFirst() then begin
                                    RecruitmentLine.INSERT();
                                    Flag := true;
                                end else
                                    Message('Resume No %1 is already selected in Recruitment No. %2', CheckRecruitmentLine."Resume Reference No.", CheckRecruitmentLine."Recruitment Header No");
                            end;
                        end;
                    until Credential.NEXT() = 0

            //end;  //Age End   
            until Resume.NEXT() = 0
        else begin
            MESSAGE(Text001Lbl);
            exit;
        end;
        if Flag = false then
            MESSAGE(Text002Lbl);
    end;

    procedure InsertResumeRecords1("No.": Code[20]; Type: Code[50]; Credentials: Code[20]; Recruitment: Boolean);
    var
        Resume: Record "Resume Database B2B";
        RecruitmentLine: Record "Recruitment Line B2B";
        RecruitmentLine2: Record "Recruitment Line B2B";
        Credential2: Record "Credentials B2B";
        Recruitmentheader: Record "Recruitment Header B2B";
        RecruitmentClose: Record "Recruitment Header B2B";
        RecruitmentLine3: Record "Recruitment Line B2B";
        CheckRecruitmentLine: Record "Recruitment Line B2B";
        ReseumeNotSelected: Boolean;
        Inprocess: Boolean;
    begin

        Recruitmentheader.reset();
        Recruitmentheader.setrange("document type", Recruitmentheader."Document Type"::"Resource Indent");
        Recruitmentheader.SetRange("Recruitment Policy No.", "Document No.");
        if not Recruitmentheader.IsEmpty() then;


        RecruitmentLine2.SETRANGE("Recruitment Header No", "Document No.");
        if RecruitmentLine2.FINDFIRST() then
            RecruitmentLine2.DELETEALL();

        Resume.RESET();
        Resume.SETRANGE("Release Status", Resume."Release Status"::Released);
        Resume.SETRANGE(Selected, false);
        if Resume.FINDFIRST() then
            repeat
                Clear(ReseumeNotSelected);
                clear(Inprocess);
                Credential.RESET();
                Credential.SETRANGE("Document No.", "Document No.");
                Credential.SETRANGE(Recruitment, true);
                if Credential.FINDFIRST() then
                    repeat
                        Credential2.Reset();
                        Credential2.SetRange("Document No.", Resume."No.");
                        Credential2.SetRange(Type, Credential.Type);
                        Credential2.SetRange("Credential Code", Credential."Credential Code");
                        if not Credential2.IsEmpty() then
                            ReseumeNotSelected := false
                        else
                            ReseumeNotSelected := true;
                    until Credential.Next() = 0;

                if not ReseumeNotSelected then begin
                    RecruitmentLine.INIT();
                    RecruitmentLine."Recruitment Header No" := "No.";
                    RecruitmentLine."Recruitment Line No." := RecruitmentLine."Recruitment Line No." + 10000;
                    RecruitmentLine."Resume Reference No." := Resume."No.";
                    RecruitmentLine."First Name" := Resume."First Name";
                    RecruitmentLine."Middle Name" := Resume."Middle Name";
                    RecruitmentLine.Surname := Resume.Surname;
                    RecruitmentLine.DOB := Resume.DOB;
                    RecruitmentLine.Gender := Resume.Gender;
                    RecruitmentLine."Marital Status" := Resume."Marital Status";
                    RecruitmentLine.Address1 := Resume.Address1;
                    RecruitmentLine.Address2 := Resume.Address2;
                    RecruitmentLine.City := Resume.City;
                    RecruitmentLine."Post Code" := Resume."Post Code";
                    RecruitmentLine.State := Resume.State;
                    RecruitmentLine."Country code" := Resume."Country code";
                    RecruitmentLine."Phone No." := Resume."Phone No.";
                    RecruitmentLine."Mobile Phone No." := Resume."Mobile Phone No.";
                    RecruitmentLine."E-Mail1" := Resume."E-Mail1";
                    RecruitmentLine."E-Mail2" := Resume."E-Mail2";
                    RecruitmentLine.Reference := Resume.Reference;
                    RecruitmentLine."Experience(Years)" := Resume."Experience(Years)";
                    RecruitmentLine.Remarks := Resume.Remarks;
                    RecruitmentLine.Status := Resume.Status;
                    RecruitmentLine."No. Series" := Resume."No. Series";
                    RecruitmentLine."System Created" := true;
                    RecruitmentLine2.SETRANGE("Recruitment Header No", RecruitmentLine."Recruitment Header No");
                    RecruitmentLine2.SETRANGE("Resume Reference No.", RecruitmentLine."Resume Reference No.");
                    if RecruitmentLine2.IsEmpty() then
                        if Resume.Blocked = false then begin
                            CheckRecruitmentLine.Reset();
                            CheckRecruitmentLine.SetRange("Resume Reference No.", RecruitmentLine."Resume Reference No.");
                            if CheckRecruitmentLine.IsEmpty() then begin
                                RecruitmentLine.INSERT();
                                Flag := true;
                            end else begin
                                RecruitmentClose.Reset();
                                RecruitmentClose.SetRange("Recruitment Policy No.", '<>%1', RecruitmentLine."Recruitment Header No");
                                RecruitmentClose.SetRange(Close, false);
                                if RecruitmentClose.Findset() then
                                    repeat
                                        RecruitmentLine3.Reset();
                                        RecruitmentLine3.SetRange("Recruitment Header No", RecruitmentClose."Recruitment Policy No.");
                                        RecruitmentLine3.SetRange("Resume Reference No.", RecruitmentLine."Resume Reference No.");
                                        if not RecruitmentLine3.IsEmpty() then
                                            Inprocess := true;
                                    until ((RecruitmentClose.next() = 0) or (Inprocess));

                                if not Inprocess then begin
                                    RecruitmentLine.INSERT();
                                    Flag := true;
                                end;
                            end;
                        end;

                end;
            until Resume.NEXT() = 0
        else begin
            MESSAGE(Text001Lbl);
            exit;
        end;
        if Flag = false then
            MESSAGE(Text002Lbl);
    end;

    procedure TestStatusOpen();
    var
        ResumeDataGRec: Record "Resume Database B2B";
        RecruitHeadGRec: Record "Recruitment Header B2B";
        JobdesHeadeGRec: Record "Job Description Header(RO) B2B";
    begin
        ResumeDataGRec.RESET();
        ResumeDataGRec.SETRANGE("No.", "Document No.");
        if ResumeDataGRec.FINDFIRST() then
            if ResumeDataGRec."Release Status" = ResumeDataGRec."Release Status"::Released then
                ResumeDataGRec.TESTFIELD("Release Status", ResumeDataGRec."Release Status"::Open);


        RecruitHeadGRec.RESET();
        RecruitHeadGRec.SETRANGE("Recruitment Policy No.", "Document No.");
        if RecruitHeadGRec.FINDFIRST() then
            if not (RecruitHeadGRec.Status = RecruitHeadGRec.Status::Open) then
                RecruitHeadGRec.TESTFIELD(Status, RecruitHeadGRec.Status::Open);


        JobdesHeadeGRec.RESET();
        JobdesHeadeGRec.SETRANGE("No.", "Document No.");
        if JobdesHeadeGRec.FINDFIRST() then
            if (JobdesHeadeGRec."Release Status" = JobdesHeadeGRec."Release Status"::Released) then
                JobdesHeadeGRec.TESTFIELD("Release Status", JobdesHeadeGRec."Release Status"::Open);

    end;

    Procedure CheckAgeGroup(ResumeLRec: Record "Resume Database B2B";
    RecruHeaderLRec: Record "Recruitment Header B2B"): Boolean

    Var
        FromAge: Decimal;
        ToAge: Decimal;
        currAge: Decimal;
    begin
        if RecruHeaderLRec."Age group" <> 0 then begin

            Evaluate(FromAge, CopyStr(Format(RecruHeaderLRec."Age group"), 1, 2));
            Evaluate(ToAge, CopyStr(Format(RecruHeaderLRec."Age group"), 4, 2));
            CurrAge := (TODAY() - ResumeLRec.DOB) DIV 365;
            if currAge in [FromAge .. ToAge] then
                Exit(true)
            else
                Exit(false);

        end else
            Exit(true)


    end;
}

