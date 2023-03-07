page 33001202 "Recruitment Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Recruitment Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Recruitment Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                FreezeColumn = Surname;
                field("Resume Reference No."; "Resume Reference No.")
                {
                    Editable = true;
                    ToolTip = 'Specifies the Resume policy  number series of the involved entry or record, according to the specified number serie';
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Applicant''s First Name';
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                    ToolTip = 'Sepcifies Applicant''s Middle Name';
                    ApplicationArea = all;
                }
                field(Surname; Surname)
                {
                    Editable = false;
                    ToolTip = 'Specifies the Applicant''s Surname';
                    ApplicationArea = all;
                }
                field(DOB; DOB)
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s date of birth';
                    ApplicationArea = all;
                }
                field(Gender; Gender)
                {
                    Editable = false;
                    ToolTip = 'Specifies the Applicant''s Gender';
                    ApplicationArea = all;
                }
                field("Marital Status"; "Marital Status")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Applicant''s Martial Status';
                    ApplicationArea = all;
                }
                field(Address1; Address1)
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s Address';
                    ApplicationArea = all;
                }
                field(Address2; Address2)
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s Address';
                    ApplicationArea = all;
                }
                field(City; City)
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s City';
                    ApplicationArea = all;
                }
                field("Post Code"; "Post Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s Post Code';
                    ApplicationArea = all;
                }
                field(State; State)
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s State Code';
                    ApplicationArea = all;
                }
                field("Country code"; "Country code")
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s Country Code';
                    ApplicationArea = all;
                }
                field("Phone No."; "Phone No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s Phone No.';
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s Mobile No';
                    ApplicationArea = all;
                }
                field("E-Mail1"; "E-Mail1")
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s Email Address';
                    ApplicationArea = all;
                }
                field("E-Mail2"; "E-Mail2")
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s Email Address';
                    ApplicationArea = all;
                }
                field(Reference; Reference)
                {
                    ToolTip = 'Specifies Applicant''s Reference';
                    ApplicationArea = all;
                }
                field("Experience(Years)"; "Experience(Years)")
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s Experience Years';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Specifies any remarks';
                    ApplicationArea = all;
                }
                field(Grade; Grade)
                {
                    ToolTip = 'Specifies Grade applcable whicle converting applicant to employee';
                    ApplicationArea = all;
                }
                field(Priority; Priority)
                {
                    ToolTip = 'Specifies the priority';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the document status as Released,Open,Pending for Approval';
                    ApplicationArea = all;
                }
                field("Documents Issued"; "Documents Issued")
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant''s document Issued - Offer Letter, Appointment Letter';
                    ApplicationArea = all;
                }
                field("Date of Join"; "Date of Join")
                {
                    ToolTip = 'Specifies Applicant''s date of joining in the company.';
                    ApplicationArea = all;
                }
                field(Employed; Employed)
                {
                    Editable = false;
                    ToolTip = 'Specifies Applicant has been employed';
                    ApplicationArea = all;
                }
                field(Selected; Selected)
                {
                    Editable = SelectedEditable;
                    ToolTip = 'Specifies Applicant is selected.';
                    ApplicationArea = all;
                }
                field("Offer Letters Reply"; "Offer Letter Reply")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies Applicant Offer Letter reply wether Accepted or Rejected.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1102152023>")
            {
                Caption = 'Re&cruitment';
                Image = AnalysisView;
                action("<Action1102152014>")
                {
                    Caption = '&Interview Details';
                    Image = ViewDetails;
                    ApplicationArea = all;
                    ToolTip = 'Specifies Applicant Interview Details.';

                    trigger OnAction();
                    begin
                        ShowInterView();
                    end;
                }
                action("Interview History")
                {
                    Caption = '&Interview History';
                    Image = ViewDetails;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Applicant Interview History in Recruitment.';

                    trigger OnAction();
                    begin
                        ShowInterViewHistory();
                    end;
                }
            }
            group("<Action1102152028>")
            {
                Caption = '&Line';
                Image = Line;
                action("<Action1102152035>")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Comments.';

                    trigger OnAction();
                    begin
                        ShowComments();
                    end;
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    ToolTip = 'Attachment';

                    trigger OnAction();
                    var
                        DocumentDetails: Record "Document Attachment";
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentDetails.Reset();
                        DocumentDetails.SetRange("No.", "Resume Reference No.");
                        DocumentDetails.SetRange("Table ID", RecRef.Number());
                        DocumentAttachmentDetails.SetTableView(DocumentDetails);
                        DocumentAttachmentDetails.RUNMODAL();
                    end;
                }
                separator("--------------------")
                {
                    Caption = '--------------------';
                }
                action("<Action1102152011>")
                {
                    Caption = '&Skills';
                    Image = Skills;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the skills for Applicant.';

                    trigger OnAction();
                    begin
                        InsertResumeLines(Rec);
                    end;
                }
            }
            group("<Action1907935204>")
            {
                Caption = 'Function';
                action("<Action1102152019>")
                {
                    Caption = 'Update &Pay Elements';
                    Image = CashFlow;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the update pay elements for convert to Employee.';

                    trigger OnAction();
                    begin
                        UpdatePayElement();
                    end;
                }
                action("<Action1102152003>")
                {

                    Caption = 'Convert to &Employee';
                    Image = Employee;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the convert to Employee update all details.';

                    trigger OnAction();
                    var

                    begin
                        //CheckListLRec: Record "Check list B2B";
                        // CheckListGRec.Reset();
                        // CheckListGRec.SetRange("Document Type", CheckListGRec."Document Type"::Resume);
                        // CheckListGRec.SetRange("No.", "Recruitment Header No");
                        // CheckListGRec.setrange("Document Line No.", "Recruitment Line No.");
                        // CheckListGRec.SetRange(Clearence, CheckListGRec.Clearence::No);
                        // if CheckListGRec.FINDFIRST() then
                        //     Error(Text007Lbl);

                        // CheckListGRec.Reset();
                        // CheckListGRec.SetRange("Document Type", CheckListGRec."Document Type"::Resume);
                        // CheckListGRec.SetRange("No.", "Recruitment Header No");
                        // CheckListGRec.setrange("Document Line No.", "Recruitment Line No.");
                        // if Not CheckListGRec.FINDFIRST() then
                        //     Error(Text008Lbl);
                        if CONFIRM(StrSubstNo(Text006Lbl, "Date of Join"), true) then begin
                            ConvertToEmp1();

                            // CheckListGRec.Reset();
                            // CheckListGRec.SetRange("Document Type", CheckListGRec."Document Type"::Resume);
                            // CheckListGRec.SetRange("No.", "Recruitment Header No");
                            // CheckListGRec.setrange("Document Line No.", "Recruitment Line No.");
                            // if CheckListGRec.FINDSET() then
                            //     repeat
                            //         EmployeeB2B.RESET();
                            //         EmployeeB2B.SetRange("Resume DB No.", "Resume Reference No.");
                            //         if EmployeeB2B.FindFirst() then;
                            //         CheckListLRec.Init();
                            //         CheckListLRec.TransferFields(CheckListGRec);
                            //         CheckListLRec."Document Type" := CheckListLRec."Document Type"::Employee;
                            //         CheckListLRec."No." := EmployeeB2B."No.";
                            //         CheckListLRec.Insert();
                            //     until CheckListGRec.NEXT() = 0;
                            //Updating Employee Credentials & Languague
                            EmployeeCredentials();
                            EmployeeLanguage();
                            EmployeeJobHistory();
                            ResumeFamilyUpdate();
                        end;
                    end;
                }
                separator(Separator1102152018)
                {
                }
                action("<Action1102152015>")
                {
                    Caption = 'Issue OfferLetter';
                    Image = Text;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Issue Offer Letter for Convert to Employee .';

                    trigger OnAction();
                    begin
                        TestField(Selected, true);
                        OfferLetter();
                    end;
                }
                action("<Action1102152016>")
                {
                    Caption = 'Issue AppointmentLetter';
                    Image = Template;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Issue Appointment Letter for Convert to Employee .';


                    trigger OnAction();
                    begin
                        TestField(Selected, true);
                        AppointmentLetter();
                    end;
                }
                action("Offer Letter Reply")
                {
                    Caption = 'Offer Letter Reply';
                    image = EmployeeAgreement;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Offer Letter reply weather applicant Accepted or Rejected.';

                    trigger OnAction();
                    begin
                        OfferLetterReply();
                    end;
                }
                // action("Insert Check List")
                // {
                //     Caption = 'Insert Check List';
                //     Image = Insert;
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Insert check list details for convert to Employee.';
                //     Visible = false;
                //     trigger OnAction()
                //     begin
                //         InsertCheckList();
                //     end;
                // }

                // action("Check List")
                // {
                //     Caption = 'Check List';
                //     Image = CheckList;
                //     RunObject = page "Recruitment Check List B2B";
                //     RunPageLink = "Document Type" = filter('Resume'), "No." = field("Recruitment Header No"), "Document Line No." = field("Recruitment Line No.");
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Check list for convert to Employee.';
                //     Visible = false;

                // }
                separator(Separator1102152012)
                {
                }
            }
            group("<Action1102152037>")
            {
                Caption = '&Print';
                Image = Print;

                action("<Action1102152038>")
                {
                    Caption = 'Offer Letter';
                    Image = PrintForm;
                    ApplicationArea = all;
                    ToolTip = 'Issued  Offer Letter can be printed.';

                    trigger OnAction();
                    begin
                        PrintOfferLetter();
                    end;
                }
                action("<Action1102152039>")
                {
                    Caption = 'Appointment Letter';
                    Image = PrintCover;
                    ApplicationArea = all;
                    ToolTip = 'Issued Appointment Letter can be printed.';

                    trigger OnAction();
                    begin
                        PrintAppointmentLetter();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        SelectedEditable := Selected = false;
    end;

    trigger OnInit();
    begin
        SelectedEditable := true;
    end;

    var
        InterviewHistory: Record "Interview History B2B";
        InterviewHistory3: Record "Interview History B2B";
        //InterviewHistory2: Record "Interview History B2B";
        InterviewDetail: Record "Interview Details B2B";
        InterviewDetail2: Record "Interview Details B2B";
        RecuitmentLine: Record "Recruitment Line B2B";
        IntDet: Record "Interview Details B2B";
        //CheckListGRec: Record "Check list B2B";
        EmployeeB2B: Record "Employee B2B";
        // IntDetailsPage: Page "Interview Detail";
        [InDataSet]
        SelectedEditable: Boolean;
        Text001Lbl: Label 'You Already gave appointment order';
        Text002Lbl: Label 'You shouldnot give appointment letter without giving offer letter';
        Text003Lbl: Label 'You should not give appointment order for an employee';
        Text004Lbl: Label 'You should give Appointment Order before taking Print';
        Text005Lbl: Label 'Please Specify the Interview Schedule first';
        Text006Lbl: Label 'Do You want to convert the candiadate into employee with %1 Employement Date ?', Comment = '%1 = Date of join';
    //Text007Lbl: Label 'Clearance should be check for all records';
    //Text008Lbl: Label 'Check list lines should not be empty';

    procedure ShowComments();
    var
        HRComments: Record "HR Comment Line B2B";
    begin
        HRComments.RESET();
        HRComments.SETRANGE("Table Name", DATABASE::"Recruitment Line B2B");
        HRComments.SETRANGE("No.", "Recruitment Header No");
        HRComments.SETRANGE("Line No.", "Recruitment Line No.");
        PAGE.RUN(PAGE::"HR Comment Sheet B2B", HRComments);
    end;

    // procedure Attachments1();
    // begin
    //     Attachments;
    // end;

    procedure ShowInterViewHistory();
    begin
        InterviewHistory.SETRANGE("Recruitment Header No", "Recruitment Header No");
        InterviewHistory.SETRANGE("Recruitment Line No.", "Recruitment Line No.");
        if InterviewHistory.FINDFIRST() then
            PAGE.RUN(33001214, InterviewHistory);
    end;

    procedure InsertResumeLines(Rec: Record "Recruitment Line B2B");
    var
        Credential: Record "Credentials B2B";
    begin
        Credential.SETRANGE("Document No.", "Recruitment Header No");
        Credential.SETRANGE("Document No.", "Resume Reference No.");
        if Credential.FINDFIRST() then
            PAGE.RUN(33001216, Credential);
    end;

    procedure ConvertToEmp1();
    var

    begin
        ConvertToEmp();
    end;

    procedure OfferLetter();
    var
        RecruitmentLine: Record "Recruitment Line B2B";

        TextL001Lbl: Label 'You cant give Offer Letter after Appointment Letter';
    begin
        if ("Documents Issued" = "Documents Issued"::"Appointment Letter")
            or ("Documents Issued" = "Documents Issued"::"Offer Letter") then
            ERROR(TextL001Lbl);
        RecruitmentLine.RESET();
        RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Header No");
        RecruitmentLine.SETRANGE("Recruitment Line No.", "Recruitment Line No.");
        REPORT.RUN(33001279, true, false, RecruitmentLine);
        "Documents Issued" := "Documents Issued"::"Offer Letter";
        MODIFY();
    end;

    procedure AppointmentLetter();
    var
        RecruitmentLine: Record "Recruitment Line B2B";
    begin
        if "Documents Issued" = "Documents Issued"::"Appointment Letter" then
            ERROR(Text001Lbl)
        else
            if "Documents Issued" <> "Documents Issued"::"Offer Letter" then
                ERROR(Text002Lbl);
        if Employed = true then
            ERROR(Text003Lbl);
        TestField("Offer Letter Reply", "Offer Letter Reply"::Accepted);
        RecruitmentLine.RESET();
        RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Header No");
        RecruitmentLine.SETRANGE("Recruitment Line No.", "Recruitment Line No.");
        REPORT.RUN(33001280, true, false, RecruitmentLine);
        "Documents Issued" := "Documents Issued"::"Appointment Letter";
        MODIFY();
    end;

    procedure PrintOfferLetter();
    var
        RecruitmentLine: Record "Recruitment Line B2B";
    begin
        RecruitmentLine.RESET();
        RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Header No");
        RecruitmentLine.SETRANGE("Recruitment Line No.", "Recruitment Line No.");
        REPORT.RUN(33001279, true, false, RecruitmentLine);
    end;

    procedure PrintAppointmentLetter();
    var
        RecruitmentLine: Record "Recruitment Line B2B";
    begin
        if "Documents Issued" <> "Documents Issued"::"Appointment Letter" then
            ERROR(Text004Lbl);
        RecruitmentLine.RESET();
        RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Header No");
        RecruitmentLine.SETRANGE("Recruitment Line No.", "Recruitment Line No.");
        REPORT.RUN(33001280, true, false, RecruitmentLine);
    end;

    procedure UpdatePayElement();
    var
        PayElementsTemp: Record "Pay Elements Temp B2B";
        PayForm: Page "Pay Elements Temp B2B";
        LPayCadrepayElement: Record "Pay Cadre Pay Element B2B";
        LVLineNum: Integer;

    //RecruitmentLine: Record "Recruitment Line B2B";

    begin
        //CHB2B26082022<<
        PayElementsTemp.Reset();
        PayElementsTemp.SetRange("Resume Referance No.", Rec."Resume Reference No.");
        if not PayElementsTemp.FindSet() then begin

            LPayCadrepayElement.Reset();
            LPayCadrepayElement.SetRange("Pay Cadre Code", Rec.Grade);

            if LPayCadrepayElement.FindSet() then
                repeat


                    PayElementsTemp.Init();
                    PayElementsTemp."Resume Referance No." := Rec."Resume Reference No.";
                    PayElementsTemp."Document No." := Rec."Recruitment Header No";
                    PayElementsTemp."Line No." := Rec."Recruitment Line No.";

                    PayElementsTemp."Pay Element Code" := LPayCadrepayElement."Pay Element Code";
                    PayElementsTemp."Effective Start Date" := LPayCadrepayElement."Effective Start Date";
                    PayElementsTemp."Pay Element Code" := LPayCadrepayElement."Pay Element Code";
                    PayElementsTemp."Fixed/Percent" := LPayCadrepayElement."Fixed/Percent";
                    PayElementsTemp."Amount / Percent" := LPayCadrepayElement."Amount / Percent";
                    PayElementsTemp."Add/Deduct" := LPayCadrepayElement."Add/Deduct";
                    PayElementsTemp."Computation Type" := LPayCadrepayElement."Computation Type";
                    PayElementsTemp."Pay Cadre" := LPayCadrepayElement."Pay Cadre Code";
                    payElementsTemp.Insert();
                until LPayCadrepayElement.next = 0;
        end;



        //CHB2B26082022>>*/



        CLEAR(PayForm);
        PayElementsTemp.RESET();
        PayElementsTemp.SETRANGE("Resume Referance No.", "Resume Reference No.");
        PayForm.SETTABLEVIEW(PayElementsTemp);
        PayForm.RUN();
    end;

    procedure UpdateIntHist();
    begin
        InterviewDetail2.RESET();
        InterviewDetail2.SETRANGE("Document No.", "Recruitment Header No");
        if not InterviewDetail2.FINDFIRST() then
            ERROR(Text005Lbl);

        InterviewDetail.RESET();
        RecuitmentLine.RESET();
        RecuitmentLine.SETRANGE("Recruitment Header No", "Recruitment Header No");
        RecuitmentLine.SETRANGE("Recruitment Line No.", "Recruitment Line No.");
        if RecuitmentLine.FINDFIRST() then
            repeat
                InterviewDetail.SETRANGE("Document No.", RecuitmentLine."Recruitment Header No");
                MESSAGE('%1', InterviewDetail.COUNT());
                if InterviewDetail.FINDFIRST() then
                    repeat
                        InterviewHistory.INIT();
                        InterviewHistory."Recruitment Header No" := InterviewDetail."Document No.";
                        InterviewHistory."Recruitment Line No." := RecuitmentLine."Recruitment Line No.";
                        InterviewHistory."Line No." := InterviewDetail."Line No.";
                        InterviewHistory."Resume Reference No." := RecuitmentLine."Resume Reference No.";
                        InterviewHistory."Interview Type" := InterviewDetail."Interview Type";
                        InterviewHistory.Description := InterviewDetail.Description;
                        InterviewHistory."Interview Call Date" := InterviewDetail."Interview Call Date";
                        InterviewHistory."User Id" := InterviewDetail."User Id";
                        InterviewHistory.Remarks := Remarks;
                        InterviewHistory."Interviewed Date" := InterviewDetail."Starting Date";
                        InterviewHistory3.SETRANGE("Recruitment Header No", InterviewHistory."Recruitment Header No");
                        InterviewHistory3.SETRANGE("Recruitment Line No.", InterviewHistory."Recruitment Line No.");
                        InterviewHistory3.SETRANGE("Resume Reference No.", InterviewHistory."Resume Reference No.");
                        InterviewHistory3.SETRANGE("Line No.", InterviewHistory."Line No.");
                        if not InterviewHistory3.FINDFIRST() then
                            InterviewHistory.INSERT();
                    until InterviewDetail.NEXT() = 0;

            until RecuitmentLine.NEXT() = 0;

    end;

    procedure ShowInterView();
    begin
        IntDet.SETRANGE("Document No.", "Recruitment Header No");
        IntDet.SETRANGE("Recruitment Line No.", "Recruitment Line No.");
        IntDet.SETRANGE("Resume Reference No.", "Resume Reference No.");
        PAGE.RUN(33001215, IntDet);
    end;

    procedure OfferLetterReply();
    var

        OfferletReport: report "Offer Letter Reply Process B2B";
        TextL001Lbl: Label 'You cant give Offer Letter after Appointment Letter';
    begin
        if ("Documents Issued" = "Documents Issued"::"Appointment Letter") then
            ERROR(TextL001Lbl)
        else
            if ("Documents Issued" = "Documents Issued"::"Offer Letter") then begin
                Clear(OfferletReport);
                OfferletReport.SetValues(Rec);
                OfferletReport.Run();
                CurrPage.Update(false);
            end
    end;

    // procedure InsertCheckList();
    // var
    //     CheckList: Record "Check list B2B";
    //     lookupGRec: Record Lookup_B2B;
    //     Text50001Lbl: label 'Check list inserted successfully';
    //     Text50002Lbl: label 'Check list lines are allready inserted';
    //     LineNum: Integer;
    // begin
    //     IF Selected THEN BEGIN
    //         CheckList.RESET();
    //         CheckList.SETRANGE("Document Type", CheckList."Document Type"::Resume);
    //         CheckList.SETRANGE("No.", "Recruitment Header No");
    //         CheckList.SETRANGE("Document Line No.", "Recruitment Line No.");
    //         if checklist.FINDLAST() then
    //             linenum := CheckList."Line No." + 1000
    //         else
    //             LineNum := 1000;
    //         lookupGRec.RESET();
    //         lookupGRec.SETRANGE(lookupGRec."Lookup Type", 34);
    //         IF lookupGRec.FINDSET() then
    //             REPEAT
    //                 CheckList.RESET();
    //                 CheckList.SETRANGE("Document Type", CheckList."Document Type"::Resume);
    //                 CheckList.SETRANGE("No.", "Recruitment Header No");
    //                 CheckList.SETRANGE("Document Line No.", "Recruitment Line No.");
    //                 CheckList.SETRANGE(Code, lookupGRec."Lookup Name");
    //                 IF NOT CheckList.FINDFIRST() then BEGIN
    //                     CheckList.INIT();
    //                     CheckList."Document Type" := CheckList."Document Type"::Resume;
    //                     CheckList."No." := "Recruitment Header No";
    //                     checklist."Document Line No." := "Recruitment Line No.";
    //                     CheckList."Line No." := LineNum;
    //                     CheckList.Code := lookupGRec."Lookup Name";
    //                     CheckList.Description := CopyStr(lookupGRec.Description, 1, 50);
    //                     CheckList.INSERT();
    //                     LineNum += 1000;
    //                 END ELSE
    //                     ERROR(Text50002Lbl);
    //             UNTIL lookupGRec.NEXT() = 0;
    //         MESSAGE(Text50001Lbl);
    //     END;
    // end;

    procedure EmployeeCredentials();
    var
        Credentials: Record "Credentials B2B";
        EmployeeQualifiction: Record "Employee Qualification B2B";
        LineNoLVar: Integer;
    begin
        LineNoLVar := 10000;
        Credentials.Reset();
        Credentials.SetRange("Document No.", "Resume Reference No.");
        Credentials.SetRange("Document Type", Credentials."Document Type"::"Resource Indent");
        IF Credentials.FindSet() then
            repeat
                EmployeeB2B.RESET();
                EmployeeB2B.SetRange("Resume DB No.", "Resume Reference No.");
                if EmployeeB2B.FindFirst() then;
                EmployeeQualifiction.Init();
                EmployeeQualifiction.Validate("Employee No.", EmployeeB2B."No.");
                EmployeeQualifiction.Validate("Line No.", LineNoLVar);
                EmployeeQualifiction.Insert();
                EmployeeQualifiction."Qualification Code" := Credentials."Credential Code";
                EmployeeQualifiction."Skill Type" := Credentials."Skill Type";
                EmployeeQualifiction.Designation := Credentials.Designation;
                EmployeeQualifiction."Institution/Company" := Credentials."Name of Institute/University";
                EmployeeQualifiction."From Date" := Credentials."From Date";
                EmployeeQualifiction."To Date" := Credentials."To Date";
                EmployeeQualifiction.Modify();
                LineNoLVar += 10000;
            until Credentials.Next() = 0;

    end;

    procedure EmployeeLanguage()
    var

        EmployeeLanguage1: Record "Employee Hobbies & Lang. B2B";
        EmployeeLanguage2: Record "Employee Hobbies & Lang. B2B";
        LineNoVar: Integer;
    begin
        LineNoVar := 10000;
        EmployeeLanguage1.Reset();
        EmployeeLanguage1.SetRange("Employee No.", "Resume Reference No.");
        IF EmployeeLanguage1.FindSet() then
            repeat
                EmployeeB2B.RESET();
                EmployeeB2B.SetRange("Resume DB No.", "Resume Reference No.");
                if EmployeeB2B.FindFirst() then;
                EmployeeLanguage2.INIT();
                EmployeeLanguage2.TransferFields(EmployeeLanguage1);
                EmployeeLanguage2.validate("Employee No.", EmployeeB2B."No.");
                EmployeeLanguage2.Validate("Line No.", LineNoVar);
                EmployeeLanguage2."Line Type" := EmployeeLanguage1."Line Type"::Language;
                EmployeeLanguage2.INSERT();
                LineNoVar += 10000;
            until EmployeeLanguage1.Next() = 0;
    end;

    procedure EmployeeJobHistory()
    var
        JobHistory: Record "Job History B2B";
        EmployeeJobHistory1: Record "Job History B2B";

    begin
        EmployeeJobHistory1.Reset();
        EmployeeJobHistory1.SetRange("SNo.", "Resume Reference No.");
        IF EmployeeJobHistory1.FindSet() then
            repeat
                EmployeeB2B.RESET();
                EmployeeB2B.SetRange("Resume DB No.", "Resume Reference No.");
                if EmployeeB2B.FindFirst() then;
                JobHistory.Init();
                JobHistory.TransferFields(EmployeeJobHistory1);
                JobHistory.Validate("Document Type", JobHistory."Document Type"::Employee);
                JobHistory.Validate("SNo.", EmployeeB2B."No.");
                JobHistory.Insert(true);
            until EmployeeJobHistory1.Next() = 0;
    end;

    procedure ResumeFamilyUpdate()
    var
        InitEmployeeFamily: Record "Employee Relative B2B";
        EmployeeFamily: Record "Employee Relative B2B";
    begin
        EmployeeFamily.Reset();
        EmployeeFamily.SetRange("Employee No.", "Resume Reference No.");
        IF EmployeeFamily.FindSet() then
            repeat
                EmployeeB2B.RESET();
                EmployeeB2B.SetRange("Resume DB No.", "Resume Reference No.");
                if EmployeeB2B.FindFirst() then;
                InitEmployeeFamily.Init();
                InitEmployeeFamily.TransferFields(EmployeeFamily);
                InitEmployeeFamily.Validate(Type, InitEmployeeFamily.Type::Employee);
                InitEmployeeFamily.Validate("Employee No.", EmployeeB2B."No.");
                InitEmployeeFamily.Insert(true);
            until EmployeeFamily.Next() = 0;
    end;

}

