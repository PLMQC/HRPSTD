page 33001309 "Training Needs Identif B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Needs Identification';
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Train. Need Identi. Header B2B";
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
                    ApplicationArea = all;
                    ToolTip = 'The Training Number Series is displayed here';

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Name of HOD"; "Name of HOD")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Name of the HOD whos is initiating the Training is displayed here';
                }
                field("Assessment Period"; "Assessment Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Training Assesment period is displayed here';
                }
                field("Staff Type"; "Staff Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Staff Type to whom the Training Plan is prepared';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'The status of the document is shown as either Released / Open';
                }
            }
            part(Control1102154001; "Train. Need. Identi. Sub B2B")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Training")
            {
                Caption = '&Training';
                action("&List")
                {
                    Caption = '&List';
                    Image = ListPage;
                    RunObject = Page "Train. Need Identi. List B2B";
                    ApplicationArea = all;
                    ToolTip = 'The Training Need Identification List is displayed here';
                }
            }
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
                    ToolTip = 'Specifies the release';

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

