page 33001599 "Posted Training B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Training';
    PageType = Document;
    SourceTable = "Training Header B2B";
    Editable = false;
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ToolTip = 'Specifies the Training number series of the involved entry or record, according to the specified number series';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }


                field("Course Name"; "Course Name")
                {
                    ToolTip = 'Specifies the Training course Name';
                    ApplicationArea = all;
                }
                field("Initiating Dept"; "Initiating Dept")
                {
                    Caption = 'Initiating Dept';
                    ToolTip = 'Specifies the department initiating the training';
                    ApplicationArea = all;
                }
                field("Starting Date"; "Starting Date")
                {
                    ToolTip = 'Specifies the Traning start date';
                    ApplicationArea = all;
                }
                field("Ending Date"; "Ending Date")
                {
                    ToolTip = 'Specifies the Traning start end date';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if "Starting Date" > "Ending Date" then
                            ERROR('%1', Text001Lbl);
                    end;
                }
                field("Need  for Training"; "Need  for Training")
                {
                    ToolTip = 'Specifies the Traning need';
                    ApplicationArea = all;
                }
                field("Global Dimension 1"; "Global Dimension 1")
                {
                    ToolTip = 'Specifies the dimesnsion for which the training is being provided';
                    ApplicationArea = all;
                }
                field("Global Dimension 2"; "Global Dimension 2")
                {
                    ToolTip = 'Specifies the dimesnsion for which the training is being provided';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Physical Location for which the training is being provided';
                }
                field("Training Faculty"; "Training Faculty")
                {
                    ToolTip = 'Specifies the organization / company providing the training';
                    ApplicationArea = all;
                }
                field(Faculty; Faculty)
                {
                    ToolTip = 'Specifies the Traniner Name';
                    ApplicationArea = all;
                }
                field("Training Premises"; "Training Premises")
                {
                    ToolTip = 'Specifies the plaec / premses wherein Traning is being executed';
                    ApplicationArea = all;
                }
                field("Training Type"; "Training Type")
                {
                    ToolTip = 'Specifies the Type / suject of Traning being provided';
                    ApplicationArea = all;
                }
                field(Agency; Agency)
                {
                    ToolTip = 'Specifies the Traning agency name';
                    ApplicationArea = all;
                }
                field("No. of Employees"; "No. of Employees")
                {
                    Editable = false;
                    ToolTip = 'Specifies how many employee''s are being trained';
                    ApplicationArea = all;
                }
                field("Date of Creation"; "Date of Creation")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Traning''s date of creation';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the Traning document status';
                    ApplicationArea = all;
                }
                field(Approved; Approved)
                {
                    ToolTip = 'Specifies the Traning document approval status';
                    ApplicationArea = all;
                }
            }
            part("Training Line Subform"; "Posted Training Subform B2B")
            {
                Caption = 'Training Line Subform';
                SubPageLink = "Training Header No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action("Training &Need Identification")
            {
                Caption = 'Training &Need Identification';
                Image = CheckList;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Training need identification';

                trigger OnAction();
                begin
                    TrainingHeaderRec.RESET();
                    TrainingHeaderRec.SETRANGE("No.", "No.");
                    if TrainingHeaderRec.FINDFIRST() then
                        REPORT.RUN(REPORT::"Training Need Iden B2B", true, false, TrainingHeaderRec);
                end;
            }
            action("Print Feedback")
            {
                Caption = 'Print Feedback';
                Image = Print;
                ApplicationArea = all;
                ToolTip = 'Print Feedback';

                trigger OnAction();
                begin

                    CurrPage."Training Line Subform".PAGE.PrintFeedbackForm();
                end;
            }
        }
        area(navigation)
        {
            group("&Training")
            {
                Caption = '&Training';
                Image = CreateInteraction;
                ToolTip = 'Training';

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Training Header"),
                                  "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Comments';
                }


                action("Training Feedback")
                {
                    Caption = 'Training Feedback';
                    Image = SalutationFormula;
                    ApplicationArea = all;
                    ToolTip = 'Training Feedback';

                    trigger OnAction();
                    begin
                        CurrPage."Training Line Subform".PAGE.FeedBackForm();
                    end;
                }


            }
            group("&Line")
            {
                Caption = '&Line';
                // action("&Attachments")
                // {
                //     Caption = '&Attachments';
                //     Image = Attachments;
                //     ApplicationArea = all;

                //     trigger OnAction();
                //     begin
                //         CurrPage."Training Line Subform".PAGE.Attachments1;
                //     end;
                // }
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
                RunPageLink = "Table Name" = CONST("Training Header"),
                              "No." = FIELD("No.");
                ToolTip = 'Comment';
                ApplicationArea = all;
            }
        }
    }
    var
        TrainingHeaderRec: Record "Training Header B2B";
        Text001Lbl: Label 'Ending Date should be greater than Starting Date';

}

