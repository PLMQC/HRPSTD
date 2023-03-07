page 33001404 "Closed Recruitment B2B"
{
    // version B2BHR1.00.00

    Caption = 'Closed Recruitment';
    DeleteAllowed = false;
    Editable = false;
    PageType = Document;
    SourceTable = "Recruitment Header B2B";
    SourceTableView = WHERE(Approved = CONST(true),
                            Close = CONST(true),
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
                    ApplicationArea = all;
                    ToolTip = 'specify the recruitmnt policy no in general';
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the description';
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the indenting dept details';
                }
                field("Required Dept."; "Required Dept.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the required dept details';
                }
                field("Required Position"; "Required Position")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the required position details';
                }
                field(Designation; Designation)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the designation details';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the status';
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the no.of resource details';
                }
                field("Vacancy Since"; "Vacancy Since")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the vacancy details';
                }
                field("Experience Type"; "Experience Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the experience type details';
                }
                field(Experience; Experience)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the experience';
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the date of requirement details';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the priority details';
                }
                field("Age Group"; "Age Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the age group details';
                }
                field(Division; Division)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the division details';
                }
                field("Gender Preference"; "Gender Preference")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the gender preference details';
                }
                field("Salary Range"; "Salary Range")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the salary range details';
                }
                field("Salary Type"; "Salary Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the salary type details';
                }
                field("No.Series"; "No.Series")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the no.series ';
                }
            }
            part("Recruitment Subform"; "Closed Recruitment Subform B2B")
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
                Image = Info;
                ApplicationArea = all;
                ToolTip = 'specify the interview details';
                trigger OnAction();
                begin
                    CurrPage."Recruitment Subform".PAGE.ShowInterView();
                end;
            }
        }
        area(processing)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Offer Letter")
                {
                    Caption = 'Offer Letter';
                    Image = Opportunity;
                    ApplicationArea = all;
                    ToolTip = 'specify the offer letter details';
                    trigger OnAction();
                    begin
                        CurrPage."Recruitment Subform".PAGE.PrintOfferLetter();
                    end;
                }
                action("Appointment Letter")
                {
                    Caption = 'Appointment Letter';
                    Image = Confirm;
                    ApplicationArea = all;
                    ToolTip = 'specify the appointment letter details';
                    trigger OnAction();
                    begin
                        CurrPage."Recruitment Subform".PAGE.PrintAppointmentLetter();
                    end;
                }
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page "HR Comment Sheet B2B";
                RunPageLink = "Table Name" = CONST("Recruitment Header"),
                              "No." = FIELD("Recruitment Policy No.");
                ApplicationArea = all;
                ToolTip = 'specify the comment details';
            }
        }
    }

    var

        RecruitmentHeadGRec: Record "Recruitment Header B2B";
        Text012Lbl: Label 'Recruitment is already closed';
        Text013Lbl: Label 'Do you want to close the recruitment';
        Text33001Lbl: Label 'SKILL SET|QUALIFICATION|CERTIFICATION';

    procedure RecuritmentCredential();
    var
        Lookup_B2B: Record Lookup_B2B;
        Credential: Record "Credentials B2B";
        Credential2: Record "Credentials B2B";
    begin
        Lookup_B2B.SETFILTER("LookupType Name", Text33001Lbl);
        if Lookup_B2B.FINDFIRST() then
            repeat
                Credential.INIT();
                Credential."Document No." := "Recruitment Policy No.";
                Credential."Line No." := Credential."Line No." + 10000;
                Lookup_B2B.CALCFIELDS(Lookup_B2B."LookupType Name");
                Credential.Type := Lookup_B2B."LookupType Name";
                Credential.Description := Lookup_B2B.Description;
                Credential."Credential Code" := Lookup_B2B."Lookup Name";
                Credential2.SETRANGE("Document No.", Credential."Document No.");
                Credential2.SETRANGE(Type, Credential.Type);
                Credential2.SETRANGE("Credential Code", Credential."Credential Code");
                if Credential2.IsEmpty() then
                    Credential.INSERT();
            until Lookup_B2B.NEXT() = 0;
        Credential.SETRANGE("Document No.", "Recruitment Policy No.");
        PAGE.RUN(33001217, Credential);
    end;

    procedure CloseRecruitment();
    begin
        RecruitmentHeadGRec.RESET();
        if RecruitmentHeadGRec.GET("Recruitment Policy No.") then
            if RecruitmentHeadGRec.Close then
                ERROR(Text012Lbl);

        if CONFIRM(Text013Lbl, false) then begin
            RecruitmentHeadGRec.RESET();
            if RecruitmentHeadGRec.GET("Recruitment Policy No.") then begin
                RecruitmentHeadGRec.Close := true;
                RecruitmentHeadGRec.MODIFY();
            end;
        end;
    end;
}

