page 33001405 "Closed Recruitment Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Closed Recruitment Subform';
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
                field("Recruitment Header No"; "Recruitment Header No")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the recruitment header no';
                }
                field("Resume Reference No."; "Resume Reference No.")
                {
                    Editable = true;
                    ApplicationArea = all;
                    ToolTip = 'specify the resume reference no';
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the first name';
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the middle name';
                }
                field(Surname; Surname)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the surname';
                }
                field(DOB; DOB)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the date of birth details';
                }
                field(Gender; Gender)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the gender details';
                }
                field("Marital Status"; "Marital Status")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the marital status details';
                }
                field(Address1; Address1)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the address1 details';
                }
                field(Address2; Address2)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the address2 details';
                }
                field(City; City)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the city details';
                }
                field("Post Code"; "Post Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the postcode details';
                }
                field(State; State)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the state details';
                }
                field("Country code"; "Country code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the country code details';
                }
                field("Phone No."; "Phone No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the phone no details';
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the mobile phone no details';
                }
                field("E-Mail1"; "E-Mail1")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the e-mail details';
                }
                field("E-Mail2"; "E-Mail2")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the e-mail2 details';
                }
                field(Reference; Reference)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the reference details';
                }
                field("Experience(Years)"; "Experience(Years)")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the experience details';
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the remark details';
                }
                field(Grade; Grade)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the grade details';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the priority details';
                }
                field(Status; Status)
                {
                    Editable = true;
                    ApplicationArea = all;
                    ToolTip = 'specify the status details';
                }
                field("Documents Issued"; "Documents Issued")
                {
                    Editable = true;
                    ApplicationArea = all;
                    ToolTip = 'specify the documents issued details';
                }
                field("Date of Join"; "Date of Join")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the date of join details';
                }
                field(Employed; Employed)
                {
                    Editable = true;
                    ApplicationArea = all;
                    ToolTip = 'specify the employed details';
                }
                field(Selected; Selected)
                {
                    Editable = SelectedEditable;
                    ApplicationArea = all;
                    ToolTip = 'specify the selected details';
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
                action("<Action1102152014>")
                {
                    Caption = 'Interview Details';
                    Image = Info;
                    ApplicationArea = all;
                    ToolTip = 'specify the interview details';
                    trigger OnAction();
                    begin
                        ShowInterView();
                    end;
                }
            }
            group("<Action1102152028>")
            {
                Caption = '&Line';
                action("<Action1102152035>")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = all;
                    ToolTip = 'specify the comment details';
                    trigger OnAction();
                    begin
                        ShowComments();
                    end;
                }
                // action("<Action1102152027>")
                // {
                //     Caption = '&Attachments';
                //     Image = Attach;
                //     ApplicationArea = all;
                //     ToolTip = 'specify the attachments details';
                //     trigger OnAction();
                //     begin
                //         Attachments1;
                //     end;
                // }
                separator("--------------------")
                {
                    Caption = '--------------------';
                }
                action("<Action1102152033>")
                {
                    Caption = '&Interview History';
                    Image = History;
                    ApplicationArea = all;
                    ToolTip = 'specify the interview history details';
                    trigger OnAction();
                    begin
                        ShowInterViewHistory();
                    end;
                }
                action("<Action1102152011>")
                {
                    Caption = '&Skills';
                    Image = Skills;
                    ApplicationArea = all;
                    ToolTip = 'specify the skills details';
                    trigger OnAction();
                    begin
                        InsertResumeLines(Rec);
                    end;
                }
            }
            group("<Action1102152037>")
            {
                Caption = '&Print';
                action("<Action1102152038>")
                {
                    Caption = 'Offer Letter';
                    Image = Opportunity;
                    ApplicationArea = all;
                    ToolTip = 'specify the offer letter details';
                    trigger OnAction();
                    begin
                        PrintOfferLetter();
                    end;
                }
                action("<Action1102152039>")
                {
                    Caption = 'Appointment Letter';
                    Image = Confirm;
                    ApplicationArea = all;
                    ToolTip = 'specify the appointment letter details';
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
        InterviewDetail: Record "Interview Details B2B";
        InterviewDetail2: Record "Interview Details B2B";
        RecuitmentLine: Record "Recruitment Line B2B";
        IntDet: Record "Interview Details B2B";
        [InDataSet]
        SelectedEditable: Boolean;
        Text001Lbl: Label 'You Already gave appointment order';
        Text002Lbl: Label 'You shouldnot give appointment letter without giving offer letter';
        Text003Lbl: Label 'You should not give appointment order for an employee';
        Text004Lbl: Label 'You should give Appointment Order before taking Print';
        Text005Lbl: Label 'Please Specify the Interview Schedule first';

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
    begin
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
}

