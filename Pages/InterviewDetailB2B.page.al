page 33001215 "Interview Detail B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Interview Details';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = Worksheet;
    SourceTable = "Interview Details B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Interview Type"; "Interview Type")
                {
                    Editable = true;
                    ToolTip = 'Specifies the interview types defined / applicable as per the Recruitment process';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the Description of the Recruitment being done';
                    ApplicationArea = all;
                }
                field("Interviewed By"; "Interviewed By")
                {
                    ToolTip = 'Specifies the number of people / team involved during the interview process';
                    ApplicationArea = all;
                }
                field("Informed by"; "Informed by")
                {
                    ToolTip = 'Specifies the employee''s who are the initiator during the Interview schedule process';
                    ApplicationArea = all;
                }
                field("Interview Call Date"; "Interview Call Date")
                {
                    Caption = 'Interview Call  Date';
                    ToolTip = 'Specifies the Interview call date during the prepration of Interview schedule';
                    ApplicationArea = all;
                }
                field("Starting Date"; "Starting Date")
                {
                    ToolTip = '"Specifies the beginging date / period of days "';
                    ApplicationArea = all;
                }
                field("Ending Date"; "Ending Date")
                {
                    ToolTip = 'Specifies the time frame during the interview schedule " Start Date / End Date"';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Update)
            {
                Caption = 'Update';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the Document update details.';

                trigger OnAction();
                var
                    InterviewDetails: Record "Interview Details B2B";
                begin
                    CurrPage.SETSELECTIONFILTER(InterviewDetails);
                    if InterviewDetails.FINDSET() then
                        repeat
                            InsertInteriewHistory(InterviewDetails);
                        until InterviewDetails.NEXT() = 0;
                end;
            }
        }
    }

    procedure InsertInteriewHistory(InterviewDetailsPar: Record "Interview Details B2B");
    var
        RecruitmentLineLRec: Record "Recruitment Line B2B";
        InterviewHistory: Record "Interview History B2B";
        Employee: Record "Employee B2B";
        TextL001Lbl: Label 'Updated successfully.';
    begin
        RecruitmentLineLRec.RESET();
        RecruitmentLineLRec.SETRANGE("Recruitment Header No", InterviewDetailsPar."Document No.");
        RecruitmentLineLRec.SETRANGE("Recruitment Line No.", InterviewDetailsPar."Recruitment Line No.");
        IF RecruitmentLineLRec.FINDSET() then
            REPEAT
                InterviewHistory.INIT();
                InterviewHistory."Recruitment Header No" := RecruitmentLineLRec."Recruitment Header No";
                InterviewHistory."Recruitment Line No." := RecruitmentLineLRec."Recruitment Line No.";
                InterviewHistory."Resume Reference No." := RecruitmentLineLRec."Resume Reference No.";
                InterviewHistory."Line No." := InterviewDetailsPar."Line No.";
                InterviewHistory.VALIDATE("Interview Type", InterviewDetailsPar."Interview Type");
                InterviewHistory.Description := InterviewDetailsPar.Description;
                InterviewHistory.VALIDATE("Interview Call Date", InterviewDetailsPar."Interview Call Date");
                evaluate(InterviewHistory."User Id", USERID());
                Employee.RESET();
                Employee.SETRANGE("First Name", InterviewDetailsPar."Interviewed By");
                Employee.FINDFIRST();
                InterviewHistory.VALIDATE("Interviewed By", Employee."No.");
                InterviewHistory.VALIDATE("Informed By", InterviewDetailsPar."Informed by");
                InterviewHistory.VALIDATE(Remarks, InterviewDetailsPar.Remarks);
                InterviewHistory.INSERT();
            UNTIL RecruitmentLineLRec.NEXT() = 0;
        Message(TextL001Lbl);

    end;
}

