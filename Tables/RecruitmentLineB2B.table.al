table 33001198 "Recruitment Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Recruitment Line';
    LookupPageID = "Recruitment Subform B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Recruitment Header No"; Code[20])
        {
            Caption = 'Recruitment Header No';
            DataClassification = CustomerContent;
        }
        field(2; "Recruitment Line No."; Integer)
        {
            Caption = 'Recruitment Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Resume Reference No."; Code[20])
        {
            Caption = 'Resume Reference No.';
            TableRelation = "Resume Database B2B"."No." WHERE(Selected = CONST(false),
                                                           Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                LLookuptable: Record Lookup_B2B;
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Resume Reference No."));

                GetRecruitmentHead();
                TestStatusOpen();
                RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Header No");
                if RecruitmentLine.FINDSET() then
                    repeat
                        if RecruitmentLine."Resume Reference No." = "Resume Reference No." then
                            ERROR(Text001Lbl);
                    until RecruitmentLine.NEXT() = 0;


                Resume.SETRANGE("No.", "Resume Reference No.");
                if Resume.FINDSET() then begin
                    "First Name" := Resume."First Name";
                    "Middle Name" := Resume."Middle Name";
                    Surname := Resume.Surname;
                    DOB := Resume.DOB;
                    Gender := Resume.Gender;
                    "Marital Status" := Resume."Marital Status";
                    Address1 := Resume.Address1;
                    Address2 := Resume.Address2;
                    City := Resume.City;
                    "Post Code" := Resume."Post Code";
                    State := Resume.State;
                    "Country code" := Resume."Country code";
                    "Phone No." := Resume."Phone No.";
                    "Mobile Phone No." := Resume."Mobile Phone No.";
                    "E-Mail1" := Resume."E-Mail1";
                    "E-Mail2" := Resume."E-Mail2";
                    Reference := Resume.Reference;
                    "Experience(Years)" := Resume."Experience(Years)";
                    Remarks := Resume.Remarks;
                    Status := Resume.Status;
                    "No. Series" := Resume."No. Series";
                end;  //CHB2B26082022<<
                if RecruimentHeader."Required Position" <> '' then begin
                    LLookuptable.Reset();
                    LLookuptable.SetRange("Lookup Type", 5);
                    LLookuptable.SetRange("Lookup Name", RecruimentHeader."Required Position");
                    if LLookuptable.FindFirst() then
                        "Pay Cadre" := LLookuptable."Designation Pay Cader";
                end;//CHB2B26082022>>

            end;
        }
        field(5; "First Name"; Text[30])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("First Name"));
            end;
        }

        field(6; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Middle Name"));
            end;
        }
        field(7; Surname; Text[30])
        {
            Caption = 'Surname';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(Surname));
            end;
        }
        field(8; DOB; Date)
        {
            Caption = 'DOB';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(DOB));
            end;
        }
        field(9; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(Gender));
            end;
        }
        field(10; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            OptionCaption = 'Married,Single';
            OptionMembers = Married,Single;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Marital Status"));
            end;
        }
        field(11; Address1; Text[30])
        {
            Caption = 'Address1';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(Address1));
            end;
        }
        field(12; Address2; Text[30])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(Address2));
            end;
        }
        field(13; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(City));
            end;
        }
        field(14; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Post Code"));
                Postcode.ValidatePostCode(City, "Post Code", County, "Country code", (CurrFieldNo <> 0) and GUIALLOWED());
            end;
        }
        field(15; State; Text[30])
        {
            Caption = 'State';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(State));
            end;
        }
        field(16; "Country code"; Code[10])
        {
            Caption = 'Country code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Country code"));
            end;
        }
        field(17; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Phone No."));
            end;
        }
        field(18; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Mobile Phone No."));
            end;
        }
        field(19; "E-Mail1"; Text[50])
        {
            Caption = 'E-Mail1';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("E-Mail1"));
            end;
        }
        field(20; "E-Mail2"; Text[50])
        {
            Caption = 'E-Mail2';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("E-Mail2"));
            end;
        }
        field(21; County; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(33; Reference; Text[30])
        {
            Caption = 'Reference';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(Reference));
            end;
        }
        field(34; "Experience(Years)"; Integer)
        {
            Caption = 'Experience(Years)';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Experience(Years)"));
            end;
        }
        field(35; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(Remarks));
            end;
        }
        field(38; Status; Code[20])
        {
            Caption = 'Status';
            Editable = false;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('INTERVIEW STATUS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(Status));
            end;
        }
        field(41; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(45; "System Created"; Boolean)
        {
            Caption = 'System Created';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("System Created"));
            end;
        }
        field(46; Priority; Code[20])
        {
            Caption = 'Priority';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PRIORITY'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(Priority));
            end;
        }
        field(47; "Documents Issued"; Option)
        {
            Caption = 'Documents Issued';
            OptionCaption = ' ,Offer Letter,Appointment Letter';
            OptionMembers = " ","Offer Letter","Appointment Letter";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Documents Issued"));
            end;
        }
        field(48; Employed; Boolean)
        {
            Caption = 'Employed';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(49; "Date of Join"; Date)
        {
            Caption = 'Date of Join';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION("Date of Join"));
            end;
        }
        field(50; Selected; Boolean)
        {
            Caption = 'Selected';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(51; Grade; Code[20])
        {
            Caption = 'Grade';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(20));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if AlreadyEmployeed() then
                    ERROR(Text004Lbl, FIELDCAPTION(Grade));
            end;
        }
        field(52; "Offer Letter Reply"; Option)
        {
            Caption = 'Offer Letter Reply';
            OptionCaption = ' ,Accepted,Rejected,Call Back';
            OptionMembers = "",Accepted,Rejected,"Call Back";
            DataClassification = CustomerContent;
        }
        field(53; "Pay Cadre"; Code[20])
        {
            Caption = 'Pay Cadre';
            DataClassification = CustomerContent;


        }
    }

    keys
    {
        key(Key1; "Recruitment Header No", "Recruitment Line No.")
        {
        }
        key(Key2; "Resume Reference No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatusOpen();
        InterviewHistory.RESET();
        InterviewHistory.SETRANGE("Recruitment Header No", "Recruitment Header No");
        InterviewHistory.SETRANGE("Recruitment Line No.", "Recruitment Line No.");
        InterviewHistory.DELETEALL();
    end;

    trigger OnINSERT();
    begin
        TestStatusOpen();
    end;

    trigger OnModify();
    begin
        GetRecruitmentHead();
    end;

    var
        Postcode: Record "Post Code";
        Resume: Record "Resume Database B2B";
        RecruitmentLine: Record "Recruitment Line B2B";
        RecruimentHeader: Record "Recruitment Header B2B";
        InterviewHistory: Record "Interview History B2B";
        Text004Lbl: Label 'You cannot change the %1,candidate is already employeed.', Comment = '%1 = Employee Value';
        Text012Lbl: Label 'Pay elements are not defined.Do you want to convert the candiadate into employee ?';
        Text001Lbl: Label 'This Resume Reference No is already selected for this Recruitment.';
        Text000Lbl: Label 'The candidate is  already converted to Employee';
        Text002Lbl: Label 'Converte the candidate  to Employee';
        Text003Lbl: Label 'You have to give Appointment letter first';
    /*
    procedure Attachments();
    var
        Attachment: Record "HR Attachment-B2B";
    begin
        Attachment.RESET();
        Attachment.SETRANGE("Table ID", DATABASE::"Resume Database");
        Attachment.SETRANGE("Document No.", "Resume Reference No.");
        PAGE.RUNMODAL(PAGE::HRAttachments_B2B, Attachment);
    end;*/

    procedure ConvertToEmp();
    var
        PayElements: Record "Pay Elements B2B";
        PayElementsTemp: Record "Pay Elements Temp B2B";
        ResumeDatabase: Record "Resume Database B2B";
        Employee: Record "Employee B2B";
        HRSetup: Record "HR Setup B2B";
        NoSeriesMgt: Codeunit 396;
        EmpNo: Code[20];
    begin
        if Employed then
            ERROR(Text000Lbl);
        if "Documents Issued" <> "Documents Issued"::"Appointment Letter" then
            ERROR(Text003Lbl);
        TestField("Date of Join");//B2BBP040919
        PayElementsTemp.RESET();
        PayElementsTemp.SETRANGE("Resume Referance No.", "Resume Reference No.");
        if not PayElementsTemp.FINDFIRST() then
            if not CONFIRM(Text012Lbl, false) then
                exit;

        ResumeDatabase.RESET();
        ResumeDatabase.SETRANGE("No.", "Resume Reference No.");
        if ResumeDatabase.FINDSET() then begin
            HRSetup.GET();
            CLEAR(EmpNo);
            RecruimentHeader.RESET();
            RecruimentHeader.SETRANGE("Recruitment Policy No.", "Recruitment Header No");
            RecruimentHeader.SETFILTER("No.Series", '%1', '');
            if RecruimentHeader.FINDFIRST() then
                Employee."No." := NoSeriesMgt.GetNextNo(HRSetup."Employee Nos.", WORKDATE(), true)
            else
                Employee."No." := NoSeriesMgt.GetNextNo(RecruimentHeader."No.Series", WORKDATE(), true);
            EmpNo := Employee."No.";
            ResumeDatabase."Employee No." := Employee."No.";
            Employee."First Name" := ResumeDatabase."First Name";
            Employee."Middle Name" := ResumeDatabase."Middle Name";
            Employee."Last Name" := ResumeDatabase.Surname;
            Employee."Birth Date" := ResumeDatabase.DOB;
            Employee.Gender := ResumeDatabase.Gender;
            Employee."Martial status" := ResumeDatabase."Marital Status";
            Employee.Address := ResumeDatabase.Address1;
            Employee."Address 2" := ResumeDatabase.Address2;
            Employee.City := ResumeDatabase.City;
            Employee."Post Code" := ResumeDatabase."Post Code";
            Employee."Phone No." := ResumeDatabase."Phone No.";
            Employee."Mobile Phone No." := ResumeDatabase."Mobile Phone No.";
            Employee."E-Mail" := ResumeDatabase."E-Mail1";
            Employee.Scale := RecruimentHeader."Salary Range";
            Employee."Resume DB No." := ResumeDatabase."No.";
            Employee."Pay Cadre" := Grade;
            Employee."Resume Reference No." := "Resume Reference No.";

            PayElementsTemp.RESET();
            PayElementsTemp.SETRANGE("Resume Referance No.", "Resume Reference No.");
            if PayElementsTemp.FINDSET() then
                repeat
                    PayElements.INIT();
                    PayElements."Employee Code" := EmpNo;
                    PayElements."Effective Start Date" := "Date of Join";
                    PayElements."Fixed/Percent" := PayElementsTemp."Fixed/Percent";
                    PayElements."Computation Type" := PayElementsTemp."Computation Type";
                    PayElements."Amount / Percent" := PayElementsTemp."Amount / Percent";
                    PayElements."Add/Deduct" := PayElementsTemp."Add/Deduct";
                    PayElements."Pay Cadre" := PayElementsTemp."Pay Cadre";
                    PayElements.VALIDATE("Pay Element Code", PayElementsTemp."Pay Element Code");
                    PayElements.INSERT();
                until PayElementsTemp.NEXT() = 0;
            ;

            RecruimentHeader.RESET();
            RecruimentHeader.SETRANGE("Recruitment Policy No.", "Recruitment Header No");
            if RecruimentHeader.FINDSET() then begin
                Employee."Employment Date" := "Date of Join";
                Employee."Appointment Date" := TODAY();
                Employee."Department Code" := RecruimentHeader."Required Dept.";
                Employee.Designation := RecruimentHeader."Required Position";
            end;
            if Employee.INSERT(true) then begin
                ResumeDatabase.Selected := true;
                ResumeDatabase.Status := Status;
                ResumeDatabase.MODIFY();
                Employed := true;
                Selected := true;
                MODIFY();
                MESSAGE('%1', Text002Lbl);
            end;
        end;

    end;

    procedure TestStatusOpen();
    begin
        RecruimentHeader.TESTFIELD(Status, RecruimentHeader.Status::Open);
    end;

    procedure GetRecruitmentHead();
    begin
        TESTFIELD("Recruitment Header No");
        if "Recruitment Header No" <> RecruimentHeader."Recruitment Policy No." then
            RecruimentHeader.GET("Recruitment Header No");

    end;

    procedure AlreadyEmployeed(): Boolean;
    begin
        if Employed = true then
            exit(true)
        else
            exit(false);
    end;
}

