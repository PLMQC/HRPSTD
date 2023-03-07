page 33001205 "Training Line Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Training Line Subform';
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
                    ToolTip = 'Specifies the Traning Attend Employee"s list';
                }
                field("Attend Date"; "Attend Date")
                {
                    Caption = 'Attend Date';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Traning Attend Date Employee"s list';
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
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Attchment';


                    trigger OnAction();
                    var
                        DocumentDetails: Record "Document Attachment";
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentDetails.Reset();
                        DocumentDetails.SetRange("No.", "Employee No.");
                        DocumentDetails.SetRange("Table ID", RecRef.Number());
                        DocumentAttachmentDetails.SetTableView(DocumentDetails);
                        DocumentAttachmentDetails.RUNMODAL();
                    end;
                }
                action("&Print Feedback")
                {
                    Caption = '&Print Feedback';
                    Image = PrintAcknowledgement;
                    ApplicationArea = all;
                    ToolTip = 'Option to choose Print Feedback details';

                    trigger OnAction();
                    begin
                        PrintFeedbackForm();
                    end;
                }
                action("&Training Feedback")
                {
                    Caption = '&Training Feedback';
                    Image = SalutationFormula;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Feedback for all  Employee"s';

                    trigger OnAction();
                    begin
                        FeedBackForm();
                    end;
                }
                action("&Knowledge Transfer")
                {
                    Caption = '&Knowledge Transfer';
                    Image = Union;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Traning Knowledge Transfer updated Details for Employee wise';

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
    //TrainingFeedbackLine: Record "Tranining Feedback Line B2B";

    procedure ShowDetails();
    var
        Employee: Record "Employee B2B";

    begin

        TrainingLine.SETRANGE("Employee No.", Employee."No.");
        //if TrainingLine.FINDFIRST() then
        //PAGE.RUN(PAGE::Page80036,TrainingLine);//Phani
    end;

    procedure Attachments1();
    begin
        Attachments1();
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
                TrainingHead.Get(TrainingLine."Training Header No.");
                TrainingFeedback.INIT();
                TrainingFeedback."Document No." := TrainingLine."Training Header No.";
                TrainingFeedback."Employee No." := TrainingLine."Employee No.";
                TrainingFeedback."Employee Name" := TrainingLine.Name;
                TrainingFeedback.Department := TrainingLine."Department Code";
                TrainingFeedback.Designation := TrainingLine.Designation;
                TrainingFeedback."Global Dimension 1 Code" := TrainingHead."Global Dimension 1";
                TrainingFeedback."Global Dimension 2 Code" := TrainingHead."Global Dimension 2";
                TrainingFeedback."Physical Location" := TrainingHead."Physical Location";

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
        TrainingFeedback.SetRange("Document No.", "Training Header No.");
        if TrainingFeedback.FindSet() then
            REPORT.RUN(33001285, true, false, TrainingFeedback);
    end;
}

