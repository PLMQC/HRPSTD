page 33001261 "Final Settlement B2B"
{
    // version B2BHR1.00.00

    Caption = 'Final Settlement';
    PageType = Document;
    SourceTable = "Final Settlement Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Employee No."; "Employee No.")
                {
                    ToolTip = '"Specifies the employee numbar from the drill down "';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if "Employee No." = '' then
                            "Employee Name" := '';
                    end;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the emlopee name against the employee number';
                    ApplicationArea = all;
                }
                field("Attended Days"; "Attended Days")
                {
                    ToolTip = 'Specifies the number of attendence days in final settlement';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specifies the month of the final settlement';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Speciifes the year of teh final settelement';
                    ApplicationArea = all;
                }
                field("Date of Leaving"; "Date of Leaving")
                {
                    ToolTip = 'Specifies the date of leaving in final settlement card';
                    ApplicationArea = all;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = all;
                    tooltip = 'Specifies the Approval Status';
                }
            }
            part(SettleLine; "Final Settlement Subform B2B")
            {
                Caption = 'SettleLine';
                SubPageLink = "Employee No." = FIELD("Employee No.");
                ApplicationArea = all;
            }
            field(AddTotal1; AddTotal)
            {
                Caption = 'Additions';
                Editable = false;
                ToolTip = 'Specifies the addition total in final settelement';
                ApplicationArea = all;
            }
            field(DedTotal1; DedTotal)
            {
                Caption = 'Deductions';
                Editable = false;
                ToolTip = 'Specifies the dedduction total in the final settelemnt';
                ApplicationArea = all;
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ToolTip = 'specifies the journal batch name for final settlement postings';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        JournalTemplate.RESET();
                        JournalTemplate.SETRANGE("Form ID", 33001261);
                        if JournalTemplate.FINDFIRST() then begin
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                            if PAGE.RUNMODAL(33001274, JournalBatch) = ACTION::LookupOK then begin
                                "Journal Batch Name" := JournalBatch.Name;
                                "Journal Template Name" := JournalBatch."Journal Template Name";
                                "Posting Date" := workdate();

                                NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                                if NoSeries.FINDFIRST() then
                                    "Document No." := NoSeriesMgt.TryGetNextNo(NoSeries.Code, WORKDATE());

                                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                                FinalSettleLine.SETRANGE(Month, Month);
                                FinalSettleLine.SETRANGE(Year, Year);
                                if FinalSettleLine.FINDSET() then
                                    repeat
                                        FinalSettleLine."Journal Template Name" := "Journal Template Name";
                                        FinalSettleLine."Journal Batch Name" := "Journal Batch Name";
                                        FinalSettleLine."Posting Date" := "Posting Date";
                                        FinalSettleLine."Document No." := "Document No.";
                                        FinalSettleLine.MODIFY();
                                    until FinalSettleLine.NEXT() = 0;
                            end;
                        end;
                    end;
                }
                field("Posting Date"; "Posting Date")
                {
                    ToolTip = 'Specifies the posting date of journal batch in final settlement';
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Specifies the document no of journal batch in final settelment';
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
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Dimension';
                    trigger OnAction();
                    begin
                        ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                action(Release)
                {
                    Image = ReleaseDoc;
                    ShortcutKey = 'Ctrl+F9';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Release';
                    trigger OnAction();
                    var

                    begin
                        if "Approval Status" = "Approval Status"::Released then
                            exit;
                        ReleaseDocument();
                    end;
                }
                separator(DEF) { }
                action(Reopen)
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Reopen';
                    trigger OnAction();
                    begin
                        if "Approval Status" = "Approval Status"::open then
                            exit;

                        ReopenDocument();

                    end;
                }
                action(SendApprovalRequest)
                {
                    ToolTip = 'Request approval of the document.';
                    ApplicationArea = all;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    trigger OnAction();
                    begin
                        IF ApprovalsMgmtCust.CheckFinalSettlementApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmtCust.OnSendFinalSettlementForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Enabled = CanCancelApprovalForRecord;
                    ToolTip = 'Cancel the approval request.';
                    ApplicationArea = all;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    trigger OnAction();
                    begin
                        ApprovalsMgmtCust.OnCancelFinalsettlementApprovalRequest(Rec);
                    end;
                }

            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get Pay &Elements")
                {
                    Caption = 'Get Pay &Elements';
                    Image = GetLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Get Pay Elements';
                    trigger OnAction();
                    begin
                        GetPayElements();
                    end;
                }
                action("Calculate &Amount")
                {
                    Caption = 'Calculate &Amount';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Calculate Amounts';
                    trigger OnAction();
                    begin
                        GetPayElements();
                        CalculateSalary();
                    end;
                }
                action("Attachments")
                {
                    Image = Attachments;
                    ApplicationArea = all;
                    ToolTip = 'Attachment';
                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RUNMODAL();
                    end;
                }
                action("Calculate Bonus")
                {
                    Caption = 'Calculate Bonus';
                    Image = CalculateDiscount;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Calculate Bonus';
                    trigger OnAction();
                    begin
                        BonusCal();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Post';
                    trigger OnAction();
                    begin
                        TestField("Approval Status", "Approval Status"::Released);
                        if CONFIRM(Text001Lbl) then begin
                            FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                            FinalSettleLine.SETRANGE(Posted, true);
                            if FinalSettleLine.FINDFIRST() then
                                ERROR(Text000Lbl);
                            FinalPosting.ProcessPosting(Rec);
                        end;
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("FFS Print")
                {
                    Caption = 'FFS Print';
                    Image = PrintForm;
                    ApplicationArea = all;
                    ToolTip = 'FSS Print';
                    trigger OnAction();
                    begin
                        FSHeader.RESET();
                        FSHeader.SETRANGE("Employee No.", "Employee No.");
                        REPORT.RUNMODAL(33001264, true, true, FSHeader);
                    end;
                }
                action("FFS Att Print")
                {
                    Caption = 'FFS Att Print';
                    Image = PrintCheck;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'FSS Att Print';
                    trigger OnAction();
                    begin
                        MonthlyAttRec.RESET();
                        MonthlyAttRec.SETRANGE("Employee Code", "Employee No.");
                        if MonthlyAttRec.FINDSET() then begin
                            FSFAttReport.SetValues(Year, Month);
                            FSFAttReport.SETTABLEVIEW(MonthlyAttRec);
                            FSFAttReport.RUN();
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        UpdateTotals();
    end;

    var
        FinalSettleLine: Record "Final Settlement Line B2B";
        NoSeries: Record "No. Series";
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        FSHeader: Record "Final Settlement Header B2B";
        MonthlyAttRec: Record "Monthly Attendance B2B";
        FSFAttReport: Report "FSF Att Report B2B";

        ApprovalsMgmtCust: CodeUnit 33001190;
        NoSeriesMgt: Codeunit 396;
        FinalPosting: Codeunit "Final Settlement Posting B2B";
        Text000Lbl: Label 'Records are already Posted';
        Text001Lbl: Label 'Do you want to Post?';
        AddTotal: Decimal;
        DedTotal: Decimal;
        CanCancelApprovalForRecord: Boolean;


    procedure UpdateTotals();
    begin
        CLEAR(AddTotal);
        CLEAR(DedTotal);
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        if FinalSettleLine.FINDFIRST() then
            repeat
                if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Addition then
                    AddTotal += FinalSettleLine.Amount
                else
                    if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Deduction then
                        DedTotal += FinalSettleLine.Amount;
            until FinalSettleLine.NEXT() = 0;
    end;
}

