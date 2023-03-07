table 33001197 "Recruitment Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Recruitment Header';
    DrillDownPageID = "Recruitment Header List B2B";
    LookupPageID = "Recruitment Header List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Recruitment Policy No."; Code[20])
        {
            Caption = 'Recruitment Policy No.';
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Resource Indent,Recruitment';
            OptionMembers = "Resource Indent",Recruitment;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(4; "Indenting Dept."; Code[30])
        {
            Caption = 'Indenting Dept.';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(5; "No. of Resources"; Integer)
        {
            Caption = 'No. of Resources';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(6; "Skill Set"; Text[30])
        {
            Caption = 'Skill Set';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('SKILL SET'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(7; Qualification; Text[30])
        {
            Caption = 'Qualification';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('QUALIFICATION'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(9; "Date of Requirement"; Date)
        {
            Caption = 'Date of Requirement';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Required End Date" := CalcDate("Days Limit", "Date of Requirement");
            end;
        }
        field(10; Comments; Text[30])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(12; "Required Position"; Code[20])
        {
            Caption = 'Required Position';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(13; "Required Dept."; Code[30])
        {
            Caption = 'Required Dept.';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(14; Certification; Text[30])
        {
            Caption = 'Certification';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('CERTIFICATION'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(47; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(56; "Experience Type"; Option)
        {
            Caption = 'Experience Type';
            OptionCaption = ' ,Fresher,Experienced';
            OptionMembers = " ",Fresher,Experienced;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(57; " Experience(Years)"; Integer)
        {
            Caption = '" Experience(Years)"';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(58; Months; Integer)
        {
            Caption = 'Months';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(70; Expertise; Text[50])
        {
            Caption = 'Expertise';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(71; "Job Description2"; Text[250])
        {
            Caption = 'Job Description2';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(72; "Age Group"; Option)
        {
            Caption = 'Age Group';
            OptionCaption = ' ,20-25,25-30,30-35,35-40,40-45,45-50,50-55,55-60';
            OptionMembers = " ","20-25","25-30","30-35","35-40","40-45","45-50","50-55","55-60";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(73; "Other Spec"; Text[50])
        {
            Caption = 'Other Spec';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(74; "Salary Range"; Text[100])
        {
            Caption = 'Salary Range';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(75; "Future Growth"; Text[30])
        {
            Caption = 'Future Growth';
            DataClassification = CustomerContent;
        }
        field(76; Priority; Option)
        {
            Caption = 'Priority';
            OptionCaption = ' ,Normal,Low,High,Immediate';
            OptionMembers = " ",Normal,Low,High,Immediate;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(77; Recuritment; Option)
        {
            Caption = 'Recuritment';
            OptionCaption = 'e';
            OptionMembers = e;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(80; Division; Code[20])
        {
            Caption = 'Division';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(81; "Reason For Recruitment"; Option)
        {
            Caption = 'Reason For Recruitment';
            OptionCaption = ' ,&New,&Replacement';
            OptionMembers = " ","&New","&Replacement";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(82; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Release,Pending for HOD Approval,Pending For Additional Approval,Pending For HR Approval,Rejected';
            OptionMembers = Open,Release,"Pending for HOD Approval","Pending For Additional Approval","Pending For HR Approval",Rejected;
            DataClassification = CustomerContent;


            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(200; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Indent Closed", false);
            end;
        }
        field(201; "Last Date of Modified"; Date)
        {
            Caption = 'Last Date of Modified';
            DataClassification = CustomerContent;
        }
        field(202; "Type of Industry"; Code[250])
        {
            Caption = 'Type of Industry';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE(Lookup_B2B."Lookup Type", 22);
                if PAGE.RUNMODAL(0, Lookup_B2B) = ACTION::LookupOK then
                    "Type of Industry" := Lookup_B2B.Description;

                RecruitmentLine.RESET();
                RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Policy No.");
                if RecruitmentLine.FINDFIRST() then
                    repeat
                        JobHistoryRec.RESET();
                        JobHistoryRec.SETRANGE("SNo.", RecruitmentLine."Resume Reference No.");
                        JobHistoryRec.SETRANGE("Type of Industry", "Type of Industry");
                        if not JobHistoryRec.FINDFIRST() then
                            RecruitmentLine.DELETE();
                    until RecruitmentLine.NEXT() = 0;
            end;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(203; Docno; Code[20])
        {
            Caption = 'Docno';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(204; Designation; Code[30])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE(Lookup_B2B."Lookup Type", 5);
                if PAGE.RUNMODAL(0, Lookup_B2B) = ACTION::LookupOK then
                    Designation := Lookup_B2B."Lookup Name";

                RecruitmentLine.RESET();
                RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Policy No.");
                if RecruitmentLine.FINDFIRST() then
                    repeat
                        JobHistoryRec.RESET();
                        JobHistoryRec.SETRANGE("SNo.", RecruitmentLine."Resume Reference No.");
                        JobHistoryRec.SETRANGE(Designation, Designation);
                        if not JobHistoryRec.FINDFIRST() then
                            RecruitmentLine.DELETE();
                    until RecruitmentLine.NEXT() = 0;
            end;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(205; "Exp. in Related Designation"; Decimal)
        {
            Caption = 'Exp. in Related Designation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Indent Closed", false);
                RecruitmentLine.RESET();
                RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Policy No.");
                if RecruitmentLine.FINDFIRST() then
                    repeat
                        JobHistoryRec.RESET();
                        JobHistoryRec.SETRANGE("SNo.", RecruitmentLine."Resume Reference No.");
                        JobHistoryRec.SETRANGE(JobHistoryRec.Experience, "Exp. in Related Designation");
                        if not JobHistoryRec.FINDFIRST() then
                            RecruitmentLine.DELETE();
                    until RecruitmentLine.NEXT() = 0;
            end;
        }
        field(206; "Gender Preference"; Option)
        {
            Caption = 'Gender Preference';
            OptionCaption = ' ,Male,Female,AnyOne';
            OptionMembers = " ",Male,Female,AnyOne;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(207; Justification; Text[250])
        {
            Caption = 'Justification';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(208; Available; Boolean)
        {
            Caption = 'Available';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(209; Required; Boolean)
        {
            Caption = 'Required';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(211; Experience; Text[30])
        {
            Caption = 'Experience';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(212; Position; Option)
        {
            Caption = 'Position';
            OptionCaption = ' ,NewRequirement,Replacement,Deputation';
            OptionMembers = " ",NewRequirement,Replacement,Deputation;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Position <> Position::Replacement then begin
                    "Replacement For" := '';
                    "Replacement Name" := '';
                end;
            end;
        }
        field(213; "Nature of Position"; Option)
        {
            Caption = 'Nature of Position';
            OptionCaption = ' ,Permanent,Temporary';
            OptionMembers = " ",Permanent,"Temporary";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(214; "Within Budget"; Option)
        {
            Caption = 'Within Budget';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Indent Closed", false);
            end;
        }
        field(215; "Managerial Expertise"; Text[50])
        {
            Caption = 'Managerial Expertise';
            DataClassification = CustomerContent;
        }
        field(216; Createddate; Date)
        {
            Caption = 'Createddate';
            DataClassification = CustomerContent;
        }
        field(217; "Salary Type"; Option)
        {
            Caption = 'Salary Type';
            OptionCaption = ' ,CTC,TakeHomePay,Gross';
            OptionMembers = " ",CTC,TakeHomePay,Gross;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(218; "Salary Period"; Option)
        {
            Caption = 'Salary Period';
            OptionCaption = ' ,PerMonth,PerAnnum';
            OptionMembers = " ",PerMonth,PerAnnum;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(219; "Indent Closed"; Boolean)
        {
            Caption = 'Indent Closed';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(300; "Resource Indent No."; Code[20])
        {
            Caption = 'Resource Indent No.';
            TableRelation = "Recruitment Header B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(301; "Vacancy Since"; Date)
        {
            Caption = 'Vacancy Since';
            DataClassification = CustomerContent;
        }
        field(302; "Job Description No."; Code[20])
        {
            Caption = 'Job Description No.';
            TableRelation = "Job Description Header(RO) B2B";//Phani
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(303; "Reporting To"; Code[20])
        {
            Caption = 'Reporting To';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(304; "Reporting to Designation"; Code[20])
        {
            Caption = 'Reporting to Designation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(305; CLOSE; Boolean)
        {
            Caption = 'Close';
            DataClassification = CustomerContent;
        }
        field(306; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(307; "Training/Probation Period"; Code[10])
        {
            Caption = 'Training/Probation Period';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(308; "Source of Getting Manpower"; Text[100])
        {
            Caption = 'Source of Getting Manpower';
            TableRelation = IF (Source = CONST("Employee Reference")) "Employee B2B"
            ELSE
            IF (Source = CONST(Consultant)) Vendor;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(309; "Physaical Location"; Code[20])
        {
            Caption = 'Physaical Location';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PHYSICAL LOCATIONS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(310; "Thrid Party"; Code[20])
        {
            Caption = 'Thrid Party';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(311; "Expected Target"; Text[50])
        {
            Caption = 'Expected Target';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(312; Reason; Text[50])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
        }
        field(313; "Days Limit"; Text[30])
        {
            Caption = 'Days Limit';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                "Required End Date" := CalcDate("Days Limit", "Date of Requirement");
            end;
        }
        field(314; "Reason for Rejection"; Text[100])
        {
            Caption = 'Reason for Rejection';
            DataClassification = CustomerContent;
        }
        field(315; "No. Of Archived Version"; Integer)
        {
            CalcFormula = Count ("Recruitment Header Archive B2B" WHERE("Recruitment Policy No." = FIELD("Recruitment Policy No.")));
            Caption = 'No. Of Archived Version';
            Editable = false;
            FieldClass = FlowField;
        }
        field(316; Source; Option)
        {
            Caption = 'Source';
            OptionCaption = 'News Paper,Employee Reference,Advertisement,Internet,Consultant,Others';
            OptionMembers = "News Paper","Employee Reference",Advertisement,Internet,Consultant,Others;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(317; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(318; "HOD User"; Code[50])
        {
            Caption = 'HOD User';
            DataClassification = CustomerContent;
        }
        field(319; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(320; Approver; Code[50])
        {
            Caption = 'Approver';
            DataClassification = CustomerContent;
        }
        field(321; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(323; "Replacement For"; Code[20])
        {
            Caption = 'Replacement For';
            TableRelation = IF (Position = CONST(Replacement)) "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Employee.GET("Replacement For");
                "Replacement Name" := Employee."First Name" + ' ' + Employee."Last Name";
            end;
        }
        field(325; "Replacement Name"; Text[120])
        {
            Caption = 'Replacement Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(326; "Source of Hiring"; Option)
        {
            Caption = 'Source of Hiring';
            OptionCaption = 'Local,Overseas';
            OptionMembers = Local,Overseas;
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;

        }
        field(327; "Nationality"; code[10])
        {
            Caption = 'Nationality';
            TableRelation = "country/region";
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(400; "Resource Planning"; Boolean)
        {
            Caption = 'Resource Planning';
            Editable = false;
            DataClassification = CustomerContent;

        }
        field(401; "Resource Planning No."; Code[20])
        {
            Caption = 'Resource Planning No.';
            DataClassification = CustomerContent;
        }
        field(402; "Required End Date"; Date)
        {
            Caption = 'Required End Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Recruitment Policy No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        InterviewHistory.SETRANGE("Recruitment Header No", "Recruitment Policy No.");
        InterviewHistory.SETFILTER("Last Date Modified", '<>%1', 0D);
        if InterviewHistory.FINDSET() then
            ERROR(Text001Lbl);

        InterviewHistory.RESET();
        InterviewHistory.SETRANGE("Recruitment Header No", "Recruitment Policy No.");
        if InterviewHistory.FINDSET() then
            InterviewHistory.DELETEALL();

        RecLine.RESET();
        RecLine.SETRANGE("Recruitment Header No", "Recruitment Policy No.");
        if RecLine.FINDSET() then
            RecLine.DELETEALL();

        InterviewDetails.RESET();
        InterviewDetails.SETRANGE("Document No.", "Recruitment Policy No.");
        if InterviewDetails.FINDSET() then
            InterviewDetails.DELETEALL();
    end;

    trigger OnInsert();
    begin

        if not "Resource Planning" Then
            Error(Text009Lbl);
        if "Recruitment Policy No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Recruitment Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Recruitment Nos.", xRec."No. Series", 0D, "Recruitment Policy No.", "No. Series");
        end;
        Employee.RESET();
        Employee.SETRANGE("User Id", USERID());
        if Employee.FINDFIRST() then
            "Department Code" := Employee."Department Code";

        "Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();
        if "Location Code" = '' then
            ERROR('');
    end;

    var
        RecLine: Record "Recruitment Line B2B";
        HRSetup: Record "HR Setup B2B";


        InterviewHistory: Record "Interview History B2B";
        InterviewDetails: Record "Interview Details B2B";
        Lookup_B2B: Record Lookup_B2B;
        RecruitmentLine: Record "Recruitment Line B2B";
        JobHistoryRec: Record "Job History B2B";
        Employee: Record "Employee B2B";
        NoSeriesMgt: Codeunit 396;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text009Lbl: Label 'You should not create manually go for Resource planning';
        Text001Lbl: Label 'Interview History exist so you can not delete this Recruitment Policy';

    procedure AssistEdit(OldRecruitment: Record "Recruitment Header B2B"): Boolean;
    var
        Recruitment: Record "Recruitment Header B2B";
    begin
        with Recruitment do begin
            Recruitment := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Recruitment Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Recruitment Nos.", OldRecruitment."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Recruitment Nos.");
                NoSeriesMgt.SetSeries("Recruitment Policy No.");
                Rec := Recruitment;
                exit(true);
            end;
        end;
    end;

    procedure ConvertToEmployee();
    begin
    end;

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;

    procedure ResourceIndentSkills();
    var
        CredentialsLRec: Record "Credentials B2B";
    begin
        CredentialsLRec.RESET();
        CredentialsLRec.SETRANGE("Document No.", "Recruitment Policy No.");
        CredentialsLRec.SETRANGE("Document Type", CredentialsLRec."Document Type"::"Resource Indent");
        PAGE.RUNMODAL(PAGE::"Credentials B2B", CredentialsLRec);
    end;
}

