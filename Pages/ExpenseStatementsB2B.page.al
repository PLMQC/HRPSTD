page 33001560 "Expense Statements B2B"
{
    // version B2BHR1.00.00

    Caption = 'Expense Statements';
    CardPageID = "Expense Statement B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Expense Header B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the no.series detail in group';
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee no.series';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Designation';
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the shortcut  Dimension 1 code while posting document';
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the shortcut  Dimension 1 code while posting document';
                }
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the general template name';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the status of document';
                }
                field("Travel Req. No."; "Travel Req. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the req.no.series in general';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = all;
                    ToolTip = 'Specify the document approval status';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID());
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = all;
                    ToolTip = 'Specify the open entries reject status';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID());
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = all;
                    ToolTip = 'Specify the open entries delegate status ';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID());
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = all;
                    ToolTip = 'Specify the documnet comment details';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group("&Functions")
            {
                Caption = '&Functions';
                action("&Release")
                {
                    Caption = '&Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specify the document status release';

                    trigger OnAction();
                    begin
                        PerformManualRelease(Rec);
                    end;
                }
                action("Re-&Open")
                {
                    Caption = 'Re-&Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    ToolTip = 'Specify the document status Re-open';

                    trigger OnAction();
                    begin
                        PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                // action(SendApprovalRequest)
                // {
                //     CaptionML = ENU = 'Send A&pproval Request',
                //                 ENN = 'Send A&pproval Request';
                //     Enabled = NOT OpenApprovalEntriesExist;
                //     Image = SendApprovalRequest;
                //     Promoted = true;

                //     PromotedCategory = Category9;
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the send approval request';

                //     trigger OnAction();
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         /*if ApprovalsMgmt.CheckExpenseApprovalsWorkflowEnabled(Rec) then
                //             ApprovalsMgmt.OnSendExpenseDocForApproval(Rec);*/
                //     end;
                // }
                // action(CancelApprovalRequest)
                // {
                //     CaptionML = ENU = 'Cancel Approval Re&quest',
                //                 ENN = 'Cancel Approval Re&quest';
                //     Enabled = OpenApprovalEntriesExist;
                //     Image = Cancel;
                //     Promoted = true;

                //     PromotedCategory = Category9;
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the cancel approval request';

                //     trigger OnAction();
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         //ApprovalsMgmt.OnCancelExpenseApprovalRequest(Rec);
                //     end;
                // }
            }
            group("&Posting")
            {
                Caption = '&Posting';
                action(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specify the post document detils';

                    trigger OnAction();
                    begin
                        ExpenseHeader.SETRANGE("No.", "No.");
                        ExpenseHeader.FINDFIRST();
                        PostDocument(ExpenseHeader);
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                action(Action1102152012)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Option to choose the print details';

                    trigger OnAction();
                    begin
                        ExpenseHeader.SETRANGE("No.", "No.");
                        ExpenseHeader.FINDFIRST();
                        REPORT.RUNMODAL(REPORT::"Travel Expense Statement B2B", true, false, ExpenseHeader);
                    end;
                }
            }
        }
        area(navigation)
        {
            //Caption = 'Expenses';

            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = all;
                ToolTip = 'Specify the Dimension while posting documents';

                trigger OnAction();
                begin
                    ShowDimensions();
                    CurrPage.SAVERECORD();
                end;
            }
            action("A&pprovals")
            {
                Caption = 'A&pprovals';
                Image = Approvals;
                ApplicationArea = all;
                ToolTip = 'Specify the approvals detail';

                trigger OnAction();
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalEntry.FILTERGROUP(2);
                    ApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
                    ApprovalEntry.SETRANGE("Table ID", DATABASE::"Travel Requisition B2B");
                    ApprovalEntry.SETRANGE("Document No.", "No.");
                    ApprovalEntry.FILTERGROUP(0);

                    ApprovalEntries.SETTABLEVIEW(ApprovalEntry);
                    ApprovalEntries.RUN();
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        SetControlVisibility();
    end;

    var
        ExpenseHeader: Record "Expense Header B2B";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;

    local procedure SetControlVisibility();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID());
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID());
    end;
}

