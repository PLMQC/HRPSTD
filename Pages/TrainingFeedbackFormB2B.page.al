page 33001493 "Training Feedback Form B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Feedback Form';
    PageType = Document;
    SourceTable = "Training Feedback Header B2B";
    UsageCategory = Tasks;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Unquie Document No. for Training Feedback form';
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee Number';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Shows the Employee name';
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ToolTip = 'Choose the Section of the Department.';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ToolTip = 'Choose the Designation of the Employee.';
                    ApplicationArea = all;
                }
                field("Subject of Training"; "Subject of Training")
                {
                    ToolTip = 'Enter the Subject of Training in Feedback form.';
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ToolTip = 'Enter the Date.';
                    ApplicationArea = all;
                }
                field("Question ID"; "Question ID")
                {
                    ToolTip = 'Choose the Question ID from drop down.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Choose the Dimenision Value.';
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Choose the Dimenision Value.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Physical Location for which the training is being provided';
                }
            }
            part(Control1102152016; "Training Feedback Subform B2B")
            {
                SubPageLink = "Document No." = FIELD("Document No."),
                              "Employee No." = FIELD("Employee No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                ToolTip = 'Specifies the functions.';
                Caption = 'F&unctions';
                Image = "Action";
                action("Report")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        FeedbackReport.SetTableView(Rec);
                        FeedbackReport.Run();
                    end;
                }
                action("Get Questions")
                {
                    ToolTip = 'Get the Question for Training Feedback form.';
                    Caption = 'Get Questions';
                    Image = Questionaire;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        TrainingFeedbackLine.RESET();
                        TrainingFeedbackLine.SETRANGE("Document No.", "Document No.");
                        if TrainingFeedbackLine.FINDLAST() then
                            LineNum := TrainingFeedbackLine."Line No."
                        else
                            LineNum := 10000;


                        QuestLineRec.RESET();
                        QuestLineRec.SETRANGE("Profile Questionnaire Code", "Question ID");
                        if QuestLineRec.FINDFIRST() then
                            repeat
                                ExitIntNo := TrainingFeedbackLine."Document No.";

                                TrainingFeedbackLine.INIT();
                                TrainingFeedbackLine."Document No." := "Document No.";
                                TrainingFeedbackLine."Line No." := LineNum;
                                TrainingFeedbackLine."Employee No." := "Employee No.";
                                TrainingFeedbackLine.Type := QuestLineRec.Type;
                                TrainingFeedbackLine.Categories := QuestLineRec.Description;
                                TrainingFeedbackLine.INSERT();
                                LineNum += 10000;
                            until QuestLineRec.NEXT() = 0
                        else
                            ERROR(Text001Lbl);
                    end;
                }
            }
        }
    }

    var
        TrainingFeedbackLine: Record "Tranining Feedback Line B2B";
        QuestLineRec: Record "Questionnaire Line B2B";
        LineNum: Integer;
        ExitIntNo: Code[20];
        Text001Lbl: Label 'Please Define "Question ID"';
        FeedbackReport: Report "Training FeedBack B2B";
}

