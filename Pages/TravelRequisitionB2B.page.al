page 33001558 "Travel Requisition B2B"
{
    // version B2BHR1.00.00

    Caption = 'Travel Requisition';
    PageType = Document;
    SourceTable = "Travel Requisition B2B";
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
                    ToolTip = 'Specify the document no in general';

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Travel Requisition Date"; "Travel Requisition Date")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel requisition date';
                }
                field("Category Code"; "Category Code")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the category code';
                }
                field("City Type"; "City Type")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the city type';
                }
                field("Travel From"; "Travel From")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel from details';
                }
                field("Travel To"; "Travel To")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the where to travel details';
                }
                field("Travel From Date"; "Travel From Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel from date details';
                }
                field("Travel To Date"; "Travel To Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel to date details';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the document status';
                }
            }
            part("Requisition Line Subform"; "Requisition Line Subform B2B")
            {
                Caption = 'Requisition Line Subform';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                ApplicationArea = all;

            }
            group("Travel Tickets Details")
            {
                Caption = 'Travel Tickets Detail';
                field("Mode of Travel"; "Mode of Travel")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the mode of travel details';
                }
                field("Coach Type"; "Coach Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the coach type details';
                }
                field("Employee No."; "Employee No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee no';
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee name';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee designation';
                }
                field(Age; Age)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the age details';
                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the gender details';
                }
                field("Boarding at"; "Boarding at")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the boarding at details';
                }
                field(Destination; Destination)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the destination details';
                }
                field("Customer / Client No."; "Customer / Client No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the client no';
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the customer name';
                }
                field("Customer Name 2"; "Customer Name 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the customer name2 details';
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Account No."; "Account No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the account no posting details';
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the bank account no details';
                }
                field("Journal Template Name"; "Journal Template Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the journal template name';
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the journal batch name';
                }
                field("Posting Date"; "Posting Date")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the document posting date';
                }
                field("Posting Description"; "Posting Description")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the document posting description';
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
                    ToolTip = 'Specify the document approval details';

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
                    ToolTip = 'Specify the reject details';

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
                    ToolTip = 'Specify the document delegate details';

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
                    ToolTip = 'Specify the document comments detail';

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
                    ToolTip = 'Specify the document Re-open details';

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
                //     ToolTip = 'Specify the request approval of the document';

                //     trigger OnAction();
                //     var
                //     //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         /*if ApprovalsMgmt.CheckTravelRequisitionApprovalsWorkflowEnabled(Rec) then
                //           ApprovalsMgmt.OnSendTravelRequisitionDocForApproval(Rec);*/
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
                //     ToolTip = 'Specify cancel the approval request';

                //     trigger OnAction();
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         //ApprovalsMgmt.OnCancelTravelRequisitionApprovalRequest(Rec);
                //     end;
                // }
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
            group(ActionGroup5)
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
            //     ToolTip = 'Specify the attachments detail';

            //     trigger OnAction();
            //     var
            //         Attachment: Record "HR Attachment-B2B";
            //         AttachmentsDocumentPage: Page HRAttachments_B2B;
            //     begin
            //         CLEAR(AttachmentsDocumentPage);
            //         Attachment.RESET();
            //         Attachment.FILTERGROUP(2);
            //         Attachment.SETRANGE("Table ID", DATABASE::"Travel Requisition");
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
                ToolTip = 'Specify the dimensions while posting document';

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
                ToolTip = 'Specify the approval details';

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

