page 33001600 "Posted Training Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Posted Training Line Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Training Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Specifies the Name of employee''s being called / nominated for Traning';
                    ApplicationArea = all;
                }
                field(Name; Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the Name of employee''s being called / nominated for Traning';
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Middle Name of employee''s being called / nominated for Traning';
                    ApplicationArea = all;
                }
                field(Surname; Surname)
                {
                    Editable = false;
                    ToolTip = 'Specifies the Surname Name of employee''s being called / nominated for Traning';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Specifies the Department code of employee''s being called / nominated for Traning';
                    ApplicationArea = all;
                }
                field("KT Given"; "KT Given")
                {
                    ToolTip = 'Specifies whether the KT (Knowledge has been transferred)';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ToolTip = 'Specifies the designation of employee''s being called / nominated for Traning';
                    ApplicationArea = all;
                }

                field(Attend; Attend)
                {
                    Caption = 'Attend';
                    ApplicationArea = all;
                    ToolTip = 'Attend';
                }
                field("Attend Date"; "Attend Date")
                {
                    Caption = 'Attend Date';
                    ToolTip = 'Attend Date';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        testfield(Attend, true);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                // action("&Attachments")
                // {
                //     Caption = '&Attachments';
                //     Image = Attach;
                //     ApplicationArea = all;

                //     trigger OnAction();
                //     begin
                //         Attachments1;
                //     end;
                // }
                action("&Print Feedback")
                {
                    Caption = '&Print Feedback';
                    Image = PrintAcknowledgement;
                    ApplicationArea = all;
                    ToolTip = 'Print Feedback';

                    trigger OnAction();
                    begin
                        PrintFeedbackForm();
                    end;
                }
                action("&Training Feedback")
                {
                    Caption = '&Training Feedback';
                    Image = SalutationFormula;
                    visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Training Feedback';

                    trigger OnAction();
                    begin
                        FeedBackForm();
                    end;
                }
                action("&Knowledge Transfer")
                {
                    Caption = '&Knowledge Transfer';
                    Image = Union;
                    visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Knowledge Transfer';
                    trigger OnAction();
                    begin
                        ShowTraining();
                    end;
                }
            }
        }
    }

    var
        TrainingLine: Record "Training Line B2B";
        TSPlan: Record "Training Schedule Plan B2B";
        TrainingHead: Record "Training Header B2B";
        TrainingFeedback: Record "Training Feedback Header B2B";

    procedure ShowDetails();
    var
        Employee: Record "Employee B2B";

    begin
        TrainingLine.SETRANGE("Employee No.", Employee."No.");
        //if TrainingLine.FINDFIRST() then
        //PAGE.RUN(PAGE::Page80036,TrainingLine);//Phani
    end;



    procedure ShowTraining();
    begin

        TrainingLine.RESET();
        TrainingLine.SETRANGE("Training Header No.", "Training Header No.");
        TrainingLine.SETRANGE("Training Line No.", "Training Line No.");
        TrainingLine.SETRANGE("Employee No.", "Employee No.");
        if TrainingLine.FINDFIRST() then begin
            TSPlan.RESET();
            TSPlan.SETRANGE("Document No.", TrainingLine."Training Header No.");
            TSPlan.SETRANGE("Document Line No.", TrainingLine."Training Line No.");
            PAGE.RUNMODAL(33001488, TSPlan);
        end;
    end;

    procedure FeedBackForm();
    begin

        TrainingLine.RESET();
        TrainingLine.SETRANGE("Training Header No.", "Training Header No.");
        TrainingLine.SETRANGE("Training Line No.", "Training Line No.");
        if TrainingLine.FINDFIRST() then begin
            TrainingLine.Testfield(Attend, true);
            TrainingLine.TestField("Attend Date");
            TrainingFeedback.RESET();
            TrainingFeedback.SETRANGE("Document No.", TrainingLine."Training Header No.");
            TrainingFeedback.SETRANGE("Employee No.", TrainingLine."Employee No.");
            if not TrainingFeedback.FINDFIRST() then begin
                TrainingFeedback.INIT();
                TrainingFeedback."Document No." := TrainingLine."Training Header No.";
                TrainingFeedback."Employee No." := TrainingLine."Employee No.";
                TrainingFeedback."Employee Name" := TrainingLine.Name;
                TrainingFeedback.Department := TrainingLine."Department Code";
                TrainingFeedback.Designation := TrainingLine.Designation;
                TrainingHead.RESET();
                TrainingHead.SETRANGE("No.", "Training Header No.");
                if TrainingHead.FINDFIRST() then begin
                    TrainingFeedback."Subject of Training" := TrainingHead."Need  for Training";
                    TrainingFeedback.Date := TrainingHead."Starting Date";
                end;
                TrainingFeedback."Traing Line No." := TrainingLine."Training Line No.";
                TrainingFeedback.INSERT();
            end;
        end;
        PAGE.RUN(33001493, TrainingFeedback);
    end;

    procedure PrintFeedbackForm();
    begin

        TrainingFeedback.RESET();
        TrainingFeedback.SETRANGE("Employee No.", "Employee No.");
        REPORT.RUN(33001285, true, false, TrainingFeedback);
    end;
}

