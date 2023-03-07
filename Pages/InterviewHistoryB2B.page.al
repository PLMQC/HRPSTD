page 33001214 "Interview History B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Interview History';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = Worksheet;
    SourceTable = "Interview History B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Recruitment Header No"; "Recruitment Header No")
                {
                    ToolTip = 'Specifies the Recuritment Header document number generated for the predefined number series';
                    ApplicationArea = all;
                }
                field("Recruitment Line No."; "Recruitment Line No.")
                {
                    ToolTip = 'Specifies the Recuritment Header relationship with the Line document number generated for the predefined number series';
                    ApplicationArea = all;
                }
                field("Resume Reference No."; "Resume Reference No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Resume refrence no details';
                }
                field("Applicant Name"; ApplicantNameTxt)
                {
                    Caption = 'Applicant Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Resume applicant name';
                }
                field("Interview Type"; "Interview Type")
                {
                    Caption = 'Interview Type';
                    ToolTip = 'Specifies the interview types defined / applicable as per the Recruitment process';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the Recruitment Description generated from Manpower Requisition';
                    ApplicationArea = all;
                }
                field("Date of Interview"; "Date of Interview")
                {
                    ToolTip = 'Specifies the date on which the interview is been scheduled.';
                    ApplicationArea = all;
                }
                field("Interview Call Date"; "Interview Call Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the interview time as per the interview schedule defined';
                    ApplicationArea = all;
                }
                field("Informed By"; "Informed By")
                {
                    ToolTip = 'Specifies the interview schedule order of interviwer';
                    ApplicationArea = all;
                }
                field("Interviewed Date"; "Interviewed Date")
                {
                    ToolTip = 'Specifies the date on which the interview is taken place.';
                    ApplicationArea = all;
                }
                field("Interviewed By"; "Interviewed By")
                {
                    ToolTip = 'Specifies the employee''s who were part of Interrview schedule';
                    ApplicationArea = all;
                }
                field("Interview Status"; "Interview Status")
                {
                    ToolTip = 'Specifies the Interview status "Selected, Rejected, On Hold" during the interview process';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Specifies the general remarks during the interview schedule';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Interview Status")
            {
                Caption = 'Update Interview Status';
                Image = UpdateXML;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the Update interview status details';

                trigger OnAction();
                var
                    RecruitmentLine: Record "Recruitment Line B2B";
                    InterviewHistory: Record "Interview History B2B";
                    Employee_B2B: Record "Employee B2B";
                    InterviewHistory2: Record "Interview History B2B";
                    InterviewDetails: Record "Interview Details B2B";
                    InterviewHistoryLRec2: Record "Interview History B2B";
                    Pending: Boolean;
                    TextL001Lbl: Label 'Do you want to update the status?';
                    TextL002Lbl: Label 'Status updated Successfully.';
                begin
                    CLEAR(Pending);
                    CurrPage.SETSELECTIONFILTER(InterviewHistory);
                    if InterviewHistory.FINDSET() then begin
                        if not CONFIRM(TextL001Lbl, true) then
                            exit;
                        repeat
                            InterviewHistory.TESTFIELD("Interview Status");
                            if InterviewHistory."Interview Status" = Text001Lbl then
                                InterviewHistory.TESTFIELD(Remarks);
                            if InterviewHistory."Interview Status" <> '' then begin
                                InterviewDetails.RESET();
                                InterviewDetails.SETRANGE("Document No.", InterviewHistory."Recruitment Header No");
                                InterviewDetails.SETRANGE("Recruitment Line No.", InterviewHistory."Recruitment Line No.");
                                InterviewDetails.SETRANGE("Resume Reference No.", InterviewHistory."Resume Reference No.");
                                InterviewDetails.SETRANGE("Interview Type", InterviewHistory."Interview Type");
                                if InterviewDetails.FINDFIRST() then begin
                                    InterviewDetails.VALIDATE("Interview Status", InterviewHistory."Interview Status");
                                    InterviewDetails.MODIFY(true);
                                end;
                            end;
                            RecruitmentLine.RESET();
                            RecruitmentLine.SETRANGE("Recruitment Header No", InterviewHistory."Recruitment Header No");
                            RecruitmentLine.SETRANGE("Recruitment Line No.", InterviewHistory."Recruitment Line No.");
                            if RecruitmentLine.FINDFIRST() then begin
                                InterviewDetails.RESET();
                                InterviewDetails.SETRANGE("Document No.", InterviewHistory."Recruitment Header No");
                                InterviewDetails.SETRANGE("Recruitment Line No.", InterviewHistory."Recruitment Line No.");
                                InterviewDetails.SETRANGE("Resume Reference No.", InterviewHistory."Resume Reference No.");
                                InterviewDetails.SETFILTER("Interview Status", '%1', '');
                                if InterviewDetails.FINDFIRST() then begin
                                    InterviewHistory2.INIT();
                                    InterviewHistory2."Recruitment Header No" := InterviewDetails."Document No.";
                                    InterviewHistory2."Recruitment Line No." := InterviewDetails."Recruitment Line No.";
                                    InterviewHistory2."Line No." := InterviewDetails."Line No.";
                                    InterviewHistory2."Resume Reference No." := RecruitmentLine."Resume Reference No.";
                                    InterviewHistory2.VALIDATE("Interview Type", InterviewDetails."Interview Type");
                                    InterviewHistory2.Description := InterviewDetails.Description;
                                    Employee_B2B.RESET();
                                    Employee_B2B.SETRANGE("First Name", InterviewDetails."Interviewed By");
                                    Employee_B2B.FINDFIRST();
                                    InterviewHistory2.VALIDATE("Interviewed By", Employee_B2B."No.");
                                    InterviewHistory2.VALIDATE("Informed By", InterviewDetails."Informed by");
                                    InterviewHistory2."Interview Call Date" := InterviewDetails."Interview Call Date";
                                    InterviewHistory2.VALIDATE("Interviewed Date", InterviewDetails."Starting Date");
                                    InterviewHistory2."User Id" := InterviewDetails."User Id";
                                    if InterviewHistory2.INSERT(true) then;
                                    Pending := true;
                                end;
                                if not Pending then begin
                                    InterviewHistoryLRec2.RESET();
                                    InterviewHistoryLRec2.SETCURRENTKEY("Recruitment Header No", "Resume Reference No.", "Recruitment Line No.", "Line No.");
                                    InterviewHistoryLRec2.SETRANGE("Recruitment Header No", RecruitmentLine."Recruitment Header No");
                                    InterviewHistoryLRec2.SETRANGE("Recruitment Line No.", RecruitmentLine."Recruitment Line No.");
                                    InterviewHistoryLRec2.SETRANGE("Resume Reference No.", InterviewHistory."Resume Reference No.");
                                    if InterviewHistoryLRec2.FINDLAST() then
                                        if InterviewHistoryLRec2."Interview Status" <> '' then begin
                                            RecruitmentLine.Status := InterviewHistoryLRec2."Interview Status";
                                            if RecruitmentLine.Status = Text00Lbl then
                                                RecruitmentLine.Selected := true;
                                            RecruitmentLine.MODIFY(true);
                                        end;

                                end;
                            end;
                            InterviewHistory.Updated := true;
                            InterviewHistory.MODIFY();
                        until InterviewHistory.NEXT() = 0;
                        MESSAGE(TextL002Lbl);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Resume: record "Resume Database B2B";
    begin
        ApplicantNameTxt := '';
        Resume.SETRANGE("No.", "Resume Reference No.");
        if Resume.FINDSET() then
            ApplicantNameTxt := Resume."First Name";
    end;

    var
        Text00Lbl: Label 'SELECTED';
        Text001Lbl: Label 'REJECTED';
        ApplicantNameTxt: Text;
}

