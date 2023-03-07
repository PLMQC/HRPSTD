page 33001201 "Recruitment B2B"
{
    // version B2BHR1.00.00

    Caption = 'Recruitment';
    Editable = true;
    PageType = Document;
    SourceTable = "Recruitment Header B2B";
    SourceTableView = WHERE(Approved = CONST(true),
                            Close = CONST(false),
                            Blocked = CONST(false));
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
                    ToolTip = 'Specifies the Recruitment Policy number series of the involved entry or record, according to the specified number series.';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the descriptive / working note';
                    ApplicationArea = all;
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Indenting department from where the request is been raised.';
                    ApplicationArea = all;
                }
                field("Required Dept."; "Required Dept.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Required department from where the request is been raised.';
                    ApplicationArea = all;
                }
                field("Required Position"; "Required Position")
                {
                    Editable = false;
                    ToolTip = 'Specifies what kind of position is been seeked / required.';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    Editable = false;
                    ToolTip = 'Specifies what kind of Designation is needed for the Recruitment proces';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the document status';
                    ApplicationArea = all;
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ToolTip = 'Specifies how many resources are been indented.';
                    ApplicationArea = all;
                }
                field("Vacancy Since"; "Vacancy Since")
                {
                    ToolTip = 'Specifies the Vaccancy open from period';
                    ApplicationArea = all;
                }
                field("Experience Type"; "Experience Type")
                {
                    ToolTip = 'Specifies the Applicant''s Experience Type';
                    ApplicationArea = all;
                }
                field(Experience; Experience)
                {
                    ToolTip = 'Specifies the Experience based on the Experience Type';
                    ApplicationArea = all;
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ToolTip = 'Specifies the date by when the requirement needs to be completed';
                    ApplicationArea = all;
                }
                field(Priority; Priority)
                {
                    ToolTip = 'Specifies the document priority';
                    ApplicationArea = all;
                }
                field("Age Group"; "Age Group")
                {
                    ToolTip = 'Specifies the Age group of Applicant''s.';
                    ApplicationArea = all;
                }
                field(Division; Division)
                {
                    ToolTip = 'Specifies for which Division the Recruitment process is being done';
                    ApplicationArea = all;
                }
                field("Gender Preference"; "Gender Preference")
                {
                    ToolTip = 'Specifies what kind of Gender is required for the position';
                    ApplicationArea = all;
                }
                field("Salary Range"; "Salary Range")
                {
                    ToolTip = 'Specifies the Salary Range';
                    ApplicationArea = all;
                }
                field("Salary Type"; "Salary Type")
                {
                    ToolTip = 'Specifies the Salary Type - CTC,Take Home Pay, Gross';
                    ApplicationArea = all;
                }
                field("No.Series"; "No.Series")
                {
                    ToolTip = 'Specifies the Recruitment Policy number series of the involved entry or record, according to the specified number serie';
                    ApplicationArea = all;
                }
                field("Source of Hiring"; "Source of Hiring")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Source of Hiring department details';
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Candiate Nationality details';
                }

                field("Job Description No."; "Job Description No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Job Description No details';
                }
                field("Reporting To"; "Reporting To")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies any Reporting To';
                }

            }
            part("Recruitment Subform"; "Recruitment Subform B2B")
            {
                Caption = 'Recruitment Subform';
                SubPageLink = "Recruitment Header No" = FIELD("Recruitment Policy No.");
                ApplicationArea = all;

            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Interview Details")
            {
                Caption = 'Interview Details';
                Image = ViewDetails;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the Candiate Interview details';

                trigger OnAction();
                begin
                    CurrPage."Recruitment Subform".PAGE.ShowInterView();
                end;
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Recruitment &Credentials")
                {
                    Caption = 'Recruitment &Credentials';
                    Image = FilterLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recruitment credentials for short list candiates';
                    trigger OnAction();
                    begin
                        RecuritmentCredential();
                    end;
                }
                action("<Action1102152004>")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document Status';
                    trigger OnAction();
                    begin
                        if not CONFIRM(Text010Lbl, false) then
                            exit;
                        TESTFIELD(Status, Status::Open);
                        Status := Status::Release;
                        MODIFY();
                        MESSAGE(Text013Lbl);
                    end;
                }
                action("<Action1102152006>")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document Status Reopen';

                    trigger OnAction();
                    begin
                        if not CONFIRM(Text011Lbl, false) then
                            exit;
                        TESTFIELD(Status, Status::Release);
                        Status := Status::Open;
                        MODIFY();
                    end;
                }
                action("<Action1102152994>")
                {
                    Caption = 'Update &Interview History';
                    Image = History;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Update & Interview history details';

                    trigger OnAction();
                    var

                    begin
                        CurrPage."Recruitment Subform".PAGE.UpdateIntHist();
                    end;
                }
                separator(Separator1102154020)
                {
                }
                action("Close Recruitment")
                {
                    Caption = 'Close Recruitment';
                    Image = Close;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recruitment close details';

                    trigger OnAction();
                    begin
                        CloseRecruitment();
                    end;
                }

            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("Offer Letter")
                {
                    Caption = 'Offer Letter';
                    Image = PrintForm;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Option to choose print Offer Letter';

                    trigger OnAction();
                    begin
                        CurrPage."Recruitment Subform".PAGE.PrintOfferLetter();
                    end;
                }
                action("Appointment Letter")
                {
                    Caption = 'Appointment Letter';
                    Image = PrintAcknowledgement;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Appointment Letter details';

                    trigger OnAction();
                    begin
                        CurrPage."Recruitment Subform".PAGE.PrintAppointmentLetter();
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
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
                ApplicationArea = all;
                ToolTip = 'Specifies the Recruitment Comment details';
            }
        }
    }

    var
        //RecruitmentLine: Record "Recruitment Line B2B";
        Lookup_B2B: Record Lookup_B2B;
        RecruitmentHeadGRec: Record "Recruitment Header B2B";
        // Text001Lbl: Label 'Stuatus mus be Released';
        // Text002Lbl: Label 'You Cannot give offer after Appointment Letter';
        // RecruitmentClosed: Boolean;
        Text010Lbl: Label 'Do you want to Release?';
        Text011Lbl: Label 'Do you want to Reopen?';
        Text012Lbl: Label 'Recruitment is already closed';
        Text013Lbl: Label 'Status is Released';
        Text014Lbl: Label 'Do you want to close the recruitment';
        Text015Lbl: Label 'SKILL SET | QUALIFICATION|CERTIFICATION|TYPE OF INDUSTRY';

    procedure RecuritmentCredential();
    var

        Credential: Record "Credentials B2B";
        Credential2: Record "Credentials B2B";
        Credential3: Record "Credentials B2B";
        LineNum: Integer;
    begin
        Lookup_B2B.Reset();
        Lookup_B2B.SETFILTER("LookupType Name", Text015Lbl);
        if Lookup_B2B.FINDFIRST() then
            repeat
                Credential3.RESET();
                Credential3.SETRANGE("Document No.", "Recruitment Policy No.");
                if Credential3.FINDLAST() then
                    LineNum := Credential3."Line No." + 10000
                else
                    LineNum := 100000;
                Credential.INIT();
                Credential."Document No." := "Recruitment Policy No.";
                Credential."Line No." := LineNum;
                Lookup_B2B.CALCFIELDS(Lookup_B2B."LookupType Name");
                Credential.Type := Lookup_B2B."LookupType Name";
                Credential.Description := Lookup_B2B.Description;
                Credential."Credential Code" := Lookup_B2B."Lookup Name";
                Credential2.Reset();
                Credential2.SETRANGE("Document No.", Credential."Document No.");
                Credential2.SETRANGE(Type, Credential.Type);
                Credential2.SETRANGE("Credential Code", Credential."Credential Code");
                if not Credential2.FINDFIRST() then
                    Credential.INSERT();
            until Lookup_B2B.NEXT() = 0;

        Credential.Reset();
        Credential.SetRange("Document No.", "Recruitment Policy No.");
        Credential.SetRange("Skill Type", Credential."Skill Type"::SOURCE);
        if Credential.FindFirst() then begin
            if Credential."Credential Code" <> Format("Source of Hiring") then begin
                Credential."Credential Code" := Format("Source of Hiring");
                Credential.Modify();
            end;
        end else begin
            Credential3.Reset();
            Credential3.SetRange("Document No.", "Recruitment Policy No.");
            if Credential3.FindLast() then;
            Credential2.INIT();
            Credential2."Document No." := "Recruitment Policy No.";
            Credential2."Line No." := Credential3."Line No." + 10000;
            Credential2."Skill Type" := Credential2."Skill Type"::SOURCE;
            Credential2.Type := format(Credential2."Skill Type"::SOURCE);
            Credential2.Description := Format("Source of Hiring");
            Credential2."Credential Code" := Format("Source of Hiring");
            Credential2.INSERT();
        end;
        Credential.Reset();
        Credential.SETRANGE("Document No.", "Recruitment Policy No.");
        PAGE.RUN(33001217, Credential);
    end;

    procedure CloseRecruitment();
    begin
        RecruitmentHeadGRec.RESET();
        if RecruitmentHeadGRec.GET("Recruitment Policy No.") then
            if RecruitmentHeadGRec.Close then
                ERROR(Text012Lbl);

        if CONFIRM(Text014Lbl, false) then begin
            RecruitmentHeadGRec.RESET();
            if RecruitmentHeadGRec.GET("Recruitment Policy No.") then begin
                RecruitmentHeadGRec.Close := true;
                RecruitmentHeadGRec.MODIFY();
            end;
        end;
    end;
}

