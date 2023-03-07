page 33001311 "Train. Need Identi. List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Need Identi. List';
    CardPageID = "Training Needs Identif B2B";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Train. Need Identi. Header B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Training Plan Number is displayed here';
                }
                field("Name of HOD"; "Name of HOD")
                {
                    ApplicationArea = all;
                    ToolTip = 'The HOD who is Approver towards the Training';
                }
                field("Assessment Period"; "Assessment Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Assesement Period';
                }
                field("Staff Type"; "Staff Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Staff Type as Permanent / Temporary as per Lookup value';
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
                action("&Card")
                {
                    Caption = '&Card';
                    Image = Card;
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Card';

                    trigger OnAction();
                    begin
                        PAGE.RUN(33001309, Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Release';

                    trigger OnAction();
                    begin
                        Release();
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Reopen';

                    trigger OnAction();
                    begin
                        Reopen();
                    end;
                }
            }
        }
    }

    procedure Release();
    var
        TrainNeedIdentiHead: Record "Train. Need Identi. Header B2B";
        TrainNeedIdentiLine: Record "Train. Need Identi. Line B2B";
    begin
        TrainNeedIdentiHead.RESET();
        TrainNeedIdentiHead.SETRANGE("No.", "No.");
        if TrainNeedIdentiHead.FINDFIRST() then begin
            TrainNeedIdentiHead.Status := TrainNeedIdentiHead.Status::Released;
            TrainNeedIdentiHead.MODIFY();
            TrainNeedIdentiLine.RESET();
            TrainNeedIdentiLine.SETRANGE("Document No.", TrainNeedIdentiHead."No.");
            TrainNeedIdentiLine.MODIFYALL(Status, TrainNeedIdentiLine.Status::Released);
        end;
        CurrPage.UPDATE(false);
    end;

    procedure Reopen();
    var
        TrainNeedIdentiHead: Record "Train. Need Identi. Header B2B";
        TrainNeedIdentiLine: Record "Train. Need Identi. Line B2B";
    begin
        TrainNeedIdentiHead.RESET();
        TrainNeedIdentiHead.SETRANGE("No.", "No.");
        if TrainNeedIdentiHead.FINDFIRST() then begin
            TrainNeedIdentiHead.Status := TrainNeedIdentiHead.Status::Open;
            TrainNeedIdentiHead.MODIFY();
            TrainNeedIdentiLine.RESET();
            TrainNeedIdentiLine.SETRANGE("Document No.", TrainNeedIdentiHead."No.");
            TrainNeedIdentiLine.MODIFYALL(Status, TrainNeedIdentiLine.Status::Open);
        end;
        CurrPage.UPDATE(false);
    end;
}

