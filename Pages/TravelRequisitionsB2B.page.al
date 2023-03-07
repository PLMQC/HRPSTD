page 33001556 "Travel Requisitions B2B"
{
    // version B2BHR1.00.00

    Caption = 'Travel Requisitions';
    CardPageID = "Travel Requisition B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Travel Requisition B2B";
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
                    ToolTip = 'Specify the document No in group';
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee no';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee designation';
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the customer name';
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the shortcut dimension 1 code  details';
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the shortcut dimension 2 code details';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the posting date details';
                }
                field("Time Stamp"; "Time Stamp")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Time stamp details';
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the document created by user details';
                }
                field("Approved By"; "Approved By")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the approved by user';
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
                    ToolTip = 'Specify the approve document details';

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
                    ToolTip = 'Specify the document reject details';

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
                    ToolTip = 'Specify the documnet delegate details';

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
                    ToolTip = 'Specify the document comment  details';

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
                    ToolTip = 'Specify the document release details';

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
                    ToolTip = 'Specify the document re-open details';

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
                //     action(SendApprovalRequest)
                //     {
                //         CaptionML = ENU = 'Send A&pproval Request',
                //                     ENN = 'Send A&pproval Request';
                //         Enabled = NOT OpenApprovalEntriesExist;
                //         Image = SendApprovalRequest;
                //         Promoted = true;

                //         PromotedCategory = Category9;
                //         ApplicationArea = all;
                //         ToolTip = 'Specify the request approval of the document';

                //         trigger OnAction();
                //         var
                //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //         begin
                //             /*if ApprovalsMgmt.CheckTravelRequisitionApprovalsWorkflowEnabled(Rec) then
                //               ApprovalsMgmt.OnSendTravelRequisitionDocForApproval(Rec);*/
                //         end;
                //     }
                //     action(CancelApprovalRequest)
                //     {
                //         CaptionML = ENU = 'Cancel Approval Re&quest',
                //                     ENN = 'Cancel Approval Re&quest';
                //         Enabled = OpenApprovalEntriesExist;
                //         Image = Cancel;
                //         Promoted = true;

                //         PromotedCategory = Category9;
                //         ApplicationArea = all;
                //         ToolTip = 'Specify the cancel the approval request';

                //         trigger OnAction();
                //         var
                //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //         begin
                //             /*ApprovalsMgmt.OnCancelTravelRequisitionApprovalRequest(Rec);*/
                //         end;
                //     }
            }
            group("&Posting")
            {
                Caption = '&Posting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specify the document post details';

                    trigger OnAction();
                    begin
                        TravelRequisition.SETRANGE("No.", "No.");
                        TravelRequisition.FINDFIRST();
                        PostDocument(TravelRequisition);
                    end;
                }
            }
            group(ActionGroup1102152010)
            {
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Specify the option to choose print details';

                    trigger OnAction();
                    begin
                        TravelRequisition.SETRANGE("No.", "No.");
                        REPORT.RUNMODAL(REPORT::"Travel Requisition B2B", true, false, TravelRequisition);
                    end;
                }
            }
        }
        area(navigation)
        {
            //Caption = 'Travel Requisition';
            // action(Attachments)
            // {
            //     Caption = 'Attachments';
            //     Image = Attach;
            //     Promoted = true;

            //     PromotedCategory = Process;
            //     ApplicationArea = all;
            //     ToolTip = 'Specify the document attachment details';

            //     trigger OnAction();
            //     var
            //         Attachment: Record "HR Attachment-B2B";
            //         AttachmentsDocumentPage: Page HRAttachments_B2B;
            //     begin
            //         CLEAR(AttachmentsDocumentPage);
            //         Attachment.RESET();
            //         Attachment.FILTERGROUP(2);
            //         Attachment.SETRANGE("Table ID", DATABASE::"Travel Requisition B2B");
            //         Attachment.SETRANGE("Document No.", "No.");
            //         Attachment.SETRANGE("Document Line No.", 0);
            //         Attachment.FILTERGROUP(0);
            //         AttachmentsDocumentPage.SETTABLEVIEW(Attachment);
            //         AttachmentsDocumentPage.CAPTION(CurrPage.CAPTION);
            //         AttachmentsDocumentPage.RUNMODAL;
            //     end;
            // }
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = all;
                ToolTip = 'Specify the dimension while posting document';

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
                ToolTip = 'Specify the approval  details';

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
        TravelRequisition: Record "Travel Requisition B2B";
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

