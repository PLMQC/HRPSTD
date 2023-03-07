codeunit 33001194 "Event Handling B2B"
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 33001190, 'OnSendFinalSettlementForApproval', '', false, false)]
    PROCEDURE RunWorkflowOnSendFinalSettlementForApproval(VAR FinalSettlementHeader: Record "Final Settlement Header B2B");
    BEGIN
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFinalSettlementForApprovalCode(), FinalSettlementHeader);
    END;

    [EventSubscriber(ObjectType::Codeunit, 33001190, 'OnCancelFinalSettlementApprovalRequest', '', false, false)]
    PROCEDURE RunWorkflowOnCancelFinalSettlementApprovalRequest(VAR FinalSettlementHeader: Record "Final Settlement Header B2B");
    BEGIN
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFinalSettlementApprovalRequestCode(), FinalSettlementHeader);
    END;

    PROCEDURE RunWorkflowOnSendFinalSettlementForApprovalCode(): Code[128];
    var
        ReturnStr: Text[128];
    BEGIN
        ReturnStr := CopyStr('RunWorkflowOnSendFinalSettlementForApproval', 1, 128);
        EXIT(UpperCase(ReturnStr));
    END;

    PROCEDURE RunWorkflowOnCancelFinalSettlementApprovalRequestCode(): Code[128];
    var
        ReturnStr: Text[128];
    BEGIN
        ReturnStr := CopyStr('RunWorkflowOnCancelFinalSettlementApprovalRequest', 1, 128);
        EXIT(UpperCase(ReturnStr));
    END;

    PROCEDURE RunWorkflowOnAfterReleaseIndentCode(): Code[128];
    var
        ReturnStr: Text[128];
    BEGIN
        ReturnStr := CopyStr('RunWorkflowOnAfterReleaseFinalSettlement', 1, 128);
        EXIT(UpperCase(ReturnStr));
    END;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary();
    var
        WorkflowEventHandling: Codeunit 1520;

    begin
        with WorkflowEventHandling do begin
            AddEventToLibrary(RunWorkflowOnSendFinalSettlementForApprovalCode(), DATABASE::"Final Settlement Header B2B",
                copystr(FinalSettlementSendForApprovalEventDescTok, 1, 250), 0, FALSE);
            AddEventToLibrary(RunWorkflowOnCancelFinalSettlementApprovalRequestCode(), DATABASE::"Final Settlement Header B2B",
                copystr(FinalSettlementApprovalRequestCancelEventDescTxt, 1, 250), 0, FALSE);
            AddEventToLibrary(RunWorkflowOnAfterReleaseIndentCode(), DATABASE::"Final Settlement Header B2B",
                copystr(FinalSettlementReleasedEventDescTxt, 1, 250), 0, FALSE);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128]);
    var
        WorkflowEventHandling: Codeunit 1520;

    begin
        with WorkflowEventHandling do
            case EventFunctionName of
                RunWorkflowOnCancelFinalSettlementApprovalRequestCode():
                    AddEventPredecessor(RunWorkflowOnCancelFinalSettlementApprovalRequestCode(), RunWorkflowOnSendFinalSettlementForApprovalCode());
                RunWorkflowOnApproveApprovalRequestCode():

                    AddEventPredecessor(RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendFinalSettlementForApprovalCode());

                RunWorkflowOnRejectApprovalRequestCode():

                    AddEventPredecessor(RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendFinalSettlementForApprovalCode());

                RunWorkflowOnDelegateApprovalRequestCode():

                    AddEventPredecessor(RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendFinalSettlementForApprovalCode());

            end;
    end;

    procedure B2BLicenseValidate()
    var
        LicenseInfoLRec: Record "License Information";
        PositionLVar: Integer;
        LicenseValue: Text[50];
        CheckLicense: Label '4805509';
        ErrorLabel: Label 'Invalid License, Please Contact B2B Software Technologies.';
        ValidLabel: Label 'Valid';
    begin
        LicenseInfoLRec.Reset();
        LicenseInfoLRec.SetRange("Line No.", 4);
        if NOT LicenseInfoLRec.FindFirst() then
            Error(ErrorLabel);

        clear(PositionLVar);
        PositionLVar := StrPos(LicenseInfoLRec.Text, ':');

        clear(LicenseValue);
        LicenseValue := CopyStr(LicenseInfoLRec.Text, PositionLVar + 2, StrLen(LicenseInfoLRec.Text));

        if LicenseValue <> CheckLicense then
            Error(ErrorLabel);
    end;

    var
        WorkflowManagement: Codeunit 1501;
        FinalSettlementSendForApprovalEventDescTok: Label 'Approval of a FinalSettlement document is requested.';
        FinalSettlementApprovalRequestCancelEventDescTxt: Label 'An approval request for a FinalSettlement document is canceled.';
        FinalSettlementReleasedEventDescTxt: Label 'A FinalSettlement document is released.';
}