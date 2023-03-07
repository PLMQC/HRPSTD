page 33001561 "Expense Statement B2B"
{
    // version B2BHR1.00.00

    Caption = 'Expense Statement';
    PageType = Document;
    SourceTable = "Expense Header B2B";
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
                    ToolTip = 'Specify the no.series in general';


                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Travel Req. No."; "Travel Req. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Option to choose the requisition no';
                }
                field("Employee No."; "Employee No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee No';
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee designation';
                }
                field("Category Code"; "Category Code")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel category code';
                }
                field("City Type"; "City Type")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel city type';
                }
                field(Status; Status)
                {
                    LookupPageID = "Posted Travel Requisitions B2B";
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the status Open or Release';
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Shortcut dimension 1 code while posting travel document';
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Shortcut dimension 2 code while posting travel document';
                }
            }
            part("Expense Statement Subform"; "Expense Statement Subform B2B")
            {
                Caption = 'Expense Statement Subform';
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;

            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the posting to view the posted records';
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the journal batch name for posting purpose';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the posting date to post the document purpose';
                }
                field("Offset Account"; "Offset Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the offset account details to map the ledger accounts';
                }
                field("Posting Description"; "Posting Description")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the posting description details';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                field("Time Stamp"; "Time Stamp")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the document approvals';
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the created document user details';
                }
                field("Approved By"; "Approved By")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the approved user details';
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
                    ToolTip = 'Specify the approve status entries';

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
                    ToolTip = 'Specify the approval entrys status reject';

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
                    ToolTip = 'Specify the approval entries delegate details';

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
                    ToolTip = 'Specify the comments for approvals';

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
                    ToolTip = 'Specify the document status open or release';

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
                    ToolTip = 'Specifies the Document status Re-open';

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
                //     ToolTip = 'Specify the approval entries status';

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
                //     ToolTip = 'Specify the dimension while posting travel document';

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
                    ToolTip = 'Specify the post document status';

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
                action(Action5)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Option to choose the print document';

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
                ToolTip = 'Specify the dimension while posting travel document';

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
                ToolTip = 'specify the approval status';



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

