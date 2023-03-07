codeunit 33001203 "Response Handling B2B"
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128]);
    begin
        with WorkflowResponseHandling do
            case ResponseFunctionName of
                SetStatusToPendingApprovalCode():

                    AddResponsePredecessor(SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendFinalSettlementForApprovalCode());

                CreateApprovalRequestsCode():

                    AddResponsePredecessor(CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendFinalSettlementForApprovalCode());

                SendApprovalRequestForApprovalCode():

                    AddResponsePredecessor(SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendFinalSettlementForApprovalCode());

                OpenDocumentCode():

                    AddResponsePredecessor(OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnSendFinalSettlementForApprovalCode());

                CancelAllApprovalRequestsCode():

                    AddResponsePredecessor(CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendFinalSettlementForApprovalCode());

            end;
    end;
    /*
    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure PendingTranDocument(RecRef: RecordRef; VAR Variant: Variant; VAR IsHandled: Boolean)
    var
        FinalSettlementHeader: Record "Final Settlement Header";
        
    begin
        CASE RecRef.NUMBER OF
            DATABASE::"Travel Requisition":
                BEGIN
                    FinalSettlementHeader := Variant;
                    FinalSettlementHeader."Approval Status" := FinalSettlementHeader."Approval Status"::"Pending Approval";
                    
                    FinalSettlementHeader.MODIFY(TRUE);
                    Variant := FinalSettlementHeader;
                    IsHandled := true;
                END;

           
        end;
    end;
    */
    var
        WorkflowResponseHandling: Codeunit 1521;
        WorkflowEventHandling: Codeunit 33001194;
}