page 33001323 "Recruitment Request (?) B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resource Indent';
    DeleteAllowed = false;
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
                    Caption = 'Resource Indent No';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Resource Indent Number defined from the Number Series';

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field(Priority; Priority)
                {
                    Caption = 'Priority';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Resource Indent Priority';
                }
                field(Division; Division)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Division towards which the Resource Indent is raised';
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Indenting Department towards which the Resource Indent is raised';
                }
                field("Required Position"; "Required Position")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Required Postion details towards which the Resource Indent is raised';
                }
                field("Required Dept."; "Required Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Required Department towards which the Resource Indent is raised';
                }
                field("Salary Range"; "Salary Range")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Salary Range towards which the Resource Indent is raised';
                }
                field("Salary Type"; "Salary Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Salary TYpe e.g. CTC Per Annum or Take Home towards which the Resource Indent is raised';
                }
                field("Salary Period"; "Salary Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Salary Period e.g. Yearly or MOnthly towards which the Resource Indent is raised';
                }
                field(Expertise; Expertise)
                {
                    Caption = 'Technical / Area of Expertise';
                    Lookup = false;
                    ApplicationArea = all;
                    ToolTip = 'Technical /Area of expertise';
                }
                field("Job Description2"; "Job Description2")
                {
                    Caption = 'Breif Job Description';
                    ApplicationArea = all;
                    ToolTip = 'Breif Job description';
                }
                field(Justification; Justification)
                {
                    ApplicationArea = all;
                    ToolTip = 'Justification';
                }
                field("Future Growth"; "Future Growth")
                {
                    Caption = 'Carrier Growth';
                    ApplicationArea = all;
                    ToolTip = 'Carrier Growth';
                }
                field("Other Spec"; "Other Spec")
                {
                    Caption = 'Other Specifications';
                    ApplicationArea = all;
                    ToolTip = 'Other Specification';
                }
                field("Managerial Expertise"; "Managerial Expertise")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the whether the Applicant has Managerial Expertise towards which the Resource Indent is raised';
                }
                field("Job Description No."; "Job Description No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Job Details towards which the Resource Indent is raised';
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Number of Resources needed towards which the Resource Indent is raised';
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Date of Requirement towards which the Resource Indent is raised';
                }
                field("Age Group"; "Age Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Age Criteria towards which the Resource Indent is raised';
                }
                field(Comments; Comments)
                {
                    ApplicationArea = all;
                    ToolTip = 'Any General Remarks to be written';
                }
                field("Gender Preference"; "Gender Preference")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Gender Preference towards which the Resource Indent is raised';
                }
                field(Control1102154027; '')
                {
                    CaptionClass = Text19034222Lbl;
                    ApplicationArea = all;
                    ToolTip = 'Reason for recruitment';
                }
                field(Position; Position)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Position towards which the Resource Indent is raised';
                }
                field("Nature of Position"; "Nature of Position")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Nature of the Job towards which the Resource Indent is raised';
                }
                field("Within Budget"; "Within Budget")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the whether the Resource Indent raised is within Budget';
                }
                field("Indent Closed"; "Indent Closed")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Resource Indent Status';
                }
                field(Approved; Approved)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Resource Indent is approved Status';
                }
                
                field("Vacancy Since"; "Vacancy Since")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Resource Indent Vaccancy Periord Status';
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Request")
            {
                Caption = '&Request';
                action(List)
                {
                    Caption = 'List';
                    Image = List;
                    RunObject = Page "Recruitment Header List B2B";
                    ShortCutKey = 'F5';
                    ApplicationArea = all;
                    ToolTip = 'List';
                }
                separator(Separator1000000001)
                {
                }
                action("&Comments")
                {
                    Caption = '&Comments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Recruitment Header"),
                                  "No." = FIELD("Recruitment Policy No.");
                    ApplicationArea = all;
                    ToolTip = 'Comment';
                }
                action("&Approve")
                {
                    Caption = '&Approve';
                    Image = Approve;
                    ApplicationArea = all;
                    ToolTip = 'Approve';

                    trigger OnAction();
                    begin
                        if Approved = false then begin
                            if CONFIRM(Text003Lbl, false) then begin
                                Approved := true;
                                MODIFY();
                                CurrPage.UPDATE(false);
                                MESSAGE(Text004Lbl, "Recruitment Policy No.");
                            end;
                        end else
                            ERROR(Text005Lbl, "Recruitment Policy No.");
                    end;
                }
                action("&Send Message")
                {
                    Caption = '&Send Message';
                    Image = SendTo;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Send Message';

                    trigger OnAction();
                    var
                        HRSetup: Record "HR Setup B2B";
                    begin
                        HRSetup.GET();
                        HRSetup.TESTFIELD("HR E-Mail");
                    end;
                }
                action("&Skills")
                {
                    Caption = '&Skills';
                    Image = Skills;
                    ToolTip = 'Skill';

                    RunObject = Page "Qualif. Overview Matrix B2B";
                    RunPageLink = "No." = FIELD("Recruitment Policy No.");
                    ApplicationArea = all;
                }
                separator(Separator1000000002)
                {
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;
                    RunObject = Report "Resource Indent B2B";
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Print';
                }
            }
        }
        area(processing)
        {
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
    }

    var
        lookup: Record Lookup_B2B;
        Text003Lbl: Label 'Do u want to Approve ?';
        Text19034222Lbl: Label 'Reason for Recruitment';
        Text004Lbl: Label 'Recuitment Policy No. %1 is Approved', Comment = '%1 = Policy No';
        Text005Lbl: Label 'Recuitment Policy No. %1 is already Approved', Comment = '%1 = Policy No';
        Text006Lbl: Label 'SKILL SET | QUALIFICATION|CERTIFICATION |Type Of Industry|Experience Type';

    procedure RecuritmentCredential();
    var
        Credential: Record "Credentials B2B";
        Credential2: Record "Credentials B2B";
    begin
        Lookup.SETFILTER("LookupType Name", Text006Lbl);
        if Lookup.FINDFIRST() then
            repeat
                Credential.INIT();
                Credential."Document No." := "Recruitment Policy No.";
                Credential."Line No." := Credential."Line No." + 10000;
                Lookup.CALCFIELDS(Lookup."LookupType Name");
                Credential.Type := Lookup."LookupType Name";
                Credential.Description := Lookup.Description;
                Credential."Credential Code" := Lookup."Lookup Name";
                Credential2.SETRANGE("Document No.", Credential."Document No.");
                Credential2.SETRANGE(Type, Credential.Type);
                Credential2.SETRANGE("Credential Code", Credential."Credential Code");
                if Credential2.IsEmpty() then
                    Credential.INSERT();
            until Lookup.NEXT() = 0;
        Credential.SETRANGE("Resume Database", false);
        Credential.SETRANGE("Document No.", "Recruitment Policy No.");
        PAGE.RUN(33001217, Credential);
    end;
}

