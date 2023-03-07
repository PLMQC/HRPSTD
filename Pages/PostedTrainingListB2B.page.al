page 33001598 "Posted Training List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Training List';
    CardPageID = "Posted Training B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Training Header B2B";
    SourceTableView = SORTING()
                      WHERE(status = FILTER(Release));
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("No."; "No.")
                {
                    ToolTip = 'Specifies the Training number series of the involved entry or record, according to the specified number series';
                    ApplicationArea = all;
                }
                field("Course Name"; "Course Name")
                {
                    ToolTip = 'Specifies the Training / Course name.';
                    ApplicationArea = all;
                }
                field("Need  for Training"; "Need  for Training")
                {
                    ToolTip = 'Specifies the Need for Training';
                    ApplicationArea = all;
                }
                field("Initiating Dept"; "Initiating Dept")
                {
                    ToolTip = 'Specifies the department who is  initiating the training';
                    ApplicationArea = all;
                }
                field("Starting Date"; "Starting Date")
                {
                    ToolTip = '"Specifies the Training start date "';
                    ApplicationArea = all;
                }
                field("Ending Date"; "Ending Date")
                {
                    ToolTip = 'Specifies the training end date';
                    ApplicationArea = all;
                }
                field("Training Faculty"; "Training Faculty")
                {
                    ToolTip = 'Specifies the Company / Agency initiating the training';
                    ApplicationArea = all;
                }
                field("Training Premises"; "Training Premises")
                {
                    ToolTip = 'Specifies the place / premises where training will be imparted';
                    ApplicationArea = all;
                }
                field("Training Type"; "Training Type")
                {
                    ToolTip = 'Specifies the kind of training being given';
                    ApplicationArea = all;
                }
                field(Agency; Agency)
                {
                    ToolTip = 'Specifies the Company / Agency initiating the training';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Posted Training B2B";
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = all;
                    ToolTip = 'Specify the EmployeeCard';
                }
            }
            group("&Training")
            {
                Caption = '&Training';
                Image = CreateInteraction;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Training Header"),
                                  "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specify the Comments';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Training &Need Identification")
                {
                    Caption = 'Training &Need Identification';
                    Image = CheckList;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Training Need Identification';

                    trigger OnAction();
                    begin
                        TrainingHeaderRec.RESET();
                        TrainingHeaderRec.SETRANGE("No.", "No.");
                        if TrainingHeaderRec.FINDFIRST() then
                            REPORT.RUN(REPORT::"Training Need Iden B2B", true, false, TrainingHeaderRec);
                    end;
                }



            }
        }
    }

    var
        TrainingHeaderRec: Record "Training Header B2B";
}

