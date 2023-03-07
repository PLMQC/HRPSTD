page 33001299 "Resource Indent B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resource Indent';
    PageType = Card;
    SourceTable = "Recruitment Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Recruitment Policy No."; "Recruitment Policy No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Rcuruitment Policy Number Series';

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Recuritment Description';
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Department Name from the list by whom the Indent is raised.';
                }
                field("Required Dept."; "Required Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Department Name from the list by whom the Indent is raised.';
                }
                field("Required Position"; "Required Position")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Pick the Postion Name from the list.';
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the Number of Applicants / Resources required.';
                }
                field("Experience Type"; "Experience Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Type of Resource Need. E.g. Experienced or Fresher.';

                    trigger OnValidate();
                    begin
                        if "Experience Type" = "Experience Type"::Fresher then
                            ExperienceEditable := false
                        else
                            if "Experience Type" = "Experience Type"::Experienced then
                                ExperienceEditable := true;
                    end;
                }
                field(Experience; Experience)
                {
                    ApplicationArea = all;
                    Editable = ExperienceEditable;
                    ToolTip = 'Displays the Number of Years Experience';
                }
                field(Position; Position)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Postion being seeked to.';
                }
                field("Replacement For"; "Replacement For")
                {
                    ApplicationArea = all;
                    ToolTip = 'Mention the Employee Name from the List if the Option is Replacement';
                }
                field("Replacement Name"; "Replacement Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Employee Name';
                }
                field("Salary Period"; "Salary Period")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Salary Period Type as Per Annum, Per Month, CTC.';
                }
                field("Reporting To"; "Reporting To")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Pick the Person the Applicant is Reporting to from the list';
                }
                field("Physaical Location"; "Physaical Location")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Pick the Physical Location applicable';
                }
                field("Expected Target"; "Expected Target")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Expected Target date';
                }
                field(Source; Source)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Application Source e.g. Newspapers, Consultant or Employee Ref.';
                }
                field("Source of Getting Manpower"; "Source of Getting Manpower")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Application Source e.g. Newspapers, Consultant or Employee Ref.';
                }
                field(Comments; Comments)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Comments / Remarks if any';
                }
                field("No. Of Archived Version"; "No. Of Archived Version")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Archive Versions.';
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Date of Indent Requirement';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Prioity type e.g High,Low,Medium';

                }
                field("Age Group"; "Age Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Age Group as per the list';
                }
                field("Gender Preference"; "Gender Preference")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Gender Preference from the list';
                }
                field("Salary Range"; "Salary Range")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Pick the Salaray Range from the List shown';
                }
                field("Salary Type"; "Salary Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Pick the Salary Type of the List';
                }
                field(Approved; Approved)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays whether the document is Approved Yes / No.';
                }
                field("Nature of Position"; "Nature of Position")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Nature of Postion. Pick the applicable option from the list.';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Document Status e.g. Open / Released';
                }
                field("Training/Probation Period"; "Training/Probation Period")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define the Training and Probation Period';
                }
                field("Thrid Party"; "Thrid Party")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define the if the Recruitment is being done towards a Third party';
                }
                field(Reason; Reason)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Reason Code if applicable';
                }
                field("Days Limit"; "Days Limit")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define Days Limit towrads Recruitment Indent';
                }
                field("Reason for Rejection"; "Reason for Rejection")
                {
                    Visible = "Reason for RejectionVisible";
                    ApplicationArea = all;
                    ToolTip = 'Define the Reason of Rejection';
                }
                field("Department Code"; "Department Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define the Department Code applicable';
                }
                field("Source of Hiring"; "Source of Hiring")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Source of Hiring';


                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Nationality of the Applicant';

                }

                field("Job Description No."; "Job Description No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Define the Job Description Number';
                }
                field("Required End Date"; "Required End Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Define the Required End Date for the Indent';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Once the details of the Indent is filled in the Documents needs to be realeased';
                    trigger OnAction();
                    var
                        Credentials: Record "Credentials B2B";
                    begin
                        RecruitmentHeadGRec.RESET();
                        RecruitmentHeadGRec.GET("Recruitment Policy No.");
                        if (RecruitmentHeadGRec.Status = RecruitmentHeadGRec.Status::Release) then
                            ERROR(Text006Lbl)
                        else begin
                            if Hrsetup.GET() then;
                            if not Hrsetup."Activate Res. Indent Approvals" then begin
                                Status := Status::Release;
                                Approved := true;
                                Credentials.RESET();
                                Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::"SKILL SET");
                                if Credentials.FINDFIRST() then
                                    "Skill Set" := Credentials."Credential Code";
                                Credentials.RESET();
                                Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::QUALIFICATION);
                                if Credentials.FINDFIRST() then
                                    Qualification := Credentials."Credential Code";
                                MODIFY();
                                MESSAGE('%1', Text005Lbl);
                            end else
                                if Hrsetup."Activate Res. Indent Approvals" then begin
                                    CLEAR(Dept);
                                    EmployeeGrec.RESET();
                                    EmployeeGrec.SETRANGE("User Id", USERID());
                                    if EmployeeGrec.FINDFIRST() then
                                        Dept := EmployeeGrec."Department Code";
                                    ResIndSetup.RESET();
                                    ResIndSetup.SETRANGE("Document Type", ResIndSetup."Document Type"::"Resource Indent");
                                    ResIndSetup.SETRANGE(Department, Dept);
                                    ResIndSetup.SETRANGE(User, USERID());
                                    if ResIndSetup.FINDFIRST() then begin
                                        ResIndSetup1.RESET();
                                        ResIndSetup1.SETRANGE("Document Type", ResIndSetup."Document Type");
                                        ResIndSetup1.SETRANGE("Line No.", ResIndSetup."Line No.");
                                        if ResIndSetup1.FINDFIRST() then begin
                                            if ResIndSetup1.HOD <> '' then begin
                                                Status := Status::"Pending for HOD Approval";
                                                Approver := ResIndSetup1.HOD;
                                                Approved := false;
                                                Credentials.RESET();
                                                Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                                Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                                Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::"SKILL SET");
                                                if Credentials.FINDFIRST() then
                                                    "Skill Set" := Credentials."Credential Code";
                                                Credentials.RESET();
                                                Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                                Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                                Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::QUALIFICATION);
                                                if Credentials.FINDFIRST() then
                                                    Qualification := Credentials."Credential Code";
                                                MODIFY();
                                            end else
                                                if ResIndSetup1."Addtional  Approver" <> '' then begin
                                                    Status := Status::"Pending For Additional Approval";
                                                    Approver := ResIndSetup1."Addtional  Approver";
                                                    Approved := false;
                                                    Credentials.RESET();
                                                    Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                                    Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                                    Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::"SKILL SET");
                                                    if Credentials.FINDFIRST() then
                                                        "Skill Set" := Credentials."Credential Code";
                                                    Credentials.RESET();
                                                    Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                                    Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                                    Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::QUALIFICATION);
                                                    if Credentials.FINDFIRST() then
                                                        Qualification := Credentials."Credential Code";
                                                    MODIFY();
                                                end else begin
                                                    Status := Status::"Pending For HR Approval";
                                                    Approver := ResIndSetup1."HR Approval";
                                                    Approved := false;
                                                    Credentials.RESET();
                                                    Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                                    Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                                    Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::"SKILL SET");
                                                    if Credentials.FINDFIRST() then
                                                        "Skill Set" := Credentials."Credential Code";
                                                    Credentials.RESET();
                                                    Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                                    Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                                    Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::QUALIFICATION);
                                                    if Credentials.FINDFIRST() then
                                                        Qualification := Credentials."Credential Code";
                                                    MODIFY();
                                                end;
                                        end else
                                            ERROR(Text003Lbl, EmployeeGrec."No.");
                                        Credentials.RESET();
                                        Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                        Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                        Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::"SKILL SET");
                                        if Credentials.FINDFIRST() then
                                            "Skill Set" := Credentials."Credential Code";
                                        Credentials.RESET();
                                        Credentials.SETRANGE("Document No.", "Recruitment Policy No.");
                                        Credentials.SETRANGE("Document Type", Credentials."Document Type"::"Resource Indent");
                                        Credentials.SETRANGE("Skill Type", Credentials."Skill Type"::QUALIFICATION);
                                        if Credentials.FINDFIRST() then
                                            Qualification := Credentials."Credential Code";
                                        MODIFY();
                                        MESSAGE(Text004Lbl, "Recruitment Policy No.");
                                    end else
                                        ERROR(Text003Lbl, EmployeeGrec."No.");
                                end;
                        end;
                        CurrPage.UPDATE(false);
                    end;
                }
                action("&Archive Document")
                {
                    Caption = '&Archive Document';
                    Image = Archive;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Archive Document';

                    trigger OnAction();
                    begin
                        Status := Status::Open;
                        Modify(true);
                        CurrPage.UPDATE(false);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortCutKey = 'Ctrl+P';
                ApplicationArea = all;
                ToolTip = 'Print';

                trigger OnAction();
                begin
                    RecruitmentHeadGRec.RESET();
                    RecruitmentHeadGRec.SETRANGE("Recruitment Policy No.", "Recruitment Policy No.");
                    REPORT.RUNMODAL(33001300, true, false, RecruitmentHeadGRec);
                end;
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = ViewComments;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page "HR Comment Sheet B2B";
                RunPageLink = "Table Name" = CONST("Recruitment Header"),
                              "No." = FIELD("Recruitment Policy No.");
                ToolTip = 'Comment';
                ApplicationArea = all;
            }
        }
        area(navigation)
        {
            action(Skills)
            {
                Caption = 'Skills';
                Image = Skills;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Credentials B2B";
                RunPageView = sorting("Document No.", "Document Type", "Line No.") where("Document Type" = filter(Jobs));
                RunPageLink = "Document No." = field("Job Description No.");
                ApplicationArea = all;
                ToolTip = 'Skills';
            }
        }

    }

    trigger OnAfterGetRecord();
    begin
        if "Experience Type" = "Experience Type"::Fresher then
            ExperienceEditable := false
        else
            if "Experience Type" = "Experience Type"::Experienced then
                ExperienceEditable := true;
    end;

    trigger OnInit();
    begin
        "Reason for RejectionVisible" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        if PayrollLoc.FINDFIRST() then
            if USERID() <> PayrollLoc."Location Incharge" then begin
                EmployeeGrec.RESET();
                EmployeeGrec.SETRANGE("User Id", USERID());
                if EmployeeGrec.FINDFIRST() then
                    SETRANGE("Department Code", EmployeeGrec."Department Code");
            end;
    end;

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        if Status = Status::Rejected then
            "Reason for RejectionVisible" := true
        else
            "Reason for RejectionVisible" := false;
    end;

    var

        RecruitmentHeadGRec: Record "Recruitment Header B2B";
        ResIndSetup: Record "HR Approval setup B2B";
        EmployeeGrec: Record "Employee B2B";

        ResIndSetup1: Record "HR Approval setup B2B";
        PayrollLoc: Record "Payroll Locations B2B";
        Hrsetup: Record "HR Setup B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";

        Dept: Code[30];
        [InDataSet]
        "Reason for RejectionVisible": Boolean;
        Text003Lbl: Label '"No Resource Indent Approval Setup is defined for %1 "', Comment = '%1 = No';
        Text004Lbl: Label 'Man Power Requisition %1 sent for approval', Comment = '%1 = Policy No';
        Text005Lbl: Label 'Document is released';
        [InDataSet]
        ExperienceEditable: Boolean;
        Text006Lbl: Label 'Document is already Released';


}

