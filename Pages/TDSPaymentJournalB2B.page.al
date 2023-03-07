page 33001448 "TDS Payment Journal B2B"
{


    AutoSplitKey = true;
    Caption = 'TDS Payment Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Gen. Journal Line";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName1; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ApplicationArea = all;
                ToolTip = 'Secifies the Batch Name';
                trigger OnLookup(Var Text: Text): Boolean;
                begin
                    CurrPage.SAVERECORD();
                    GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(false);
                end;

                trigger OnValidate();
                begin
                    GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali();
                end;
            }
            repeater(Control1)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Secifies the Posting date';
                }
                field("Document Date"; "Document Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Secifies the Document Date';
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Secifies the Document type';
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Secifies the Document no';
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Secifies the External document no';
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Secifies the account Type';
                    trigger OnValidate();
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                    end;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Secifies the Account No';
                    trigger OnValidate();
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Secifies the description';
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Secifies the salespers/purch code';
                }
                field("Campaign No."; "Campaign No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Secifies the campaignn no';
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    ToolTip = 'Secifies the currency code';

                    trigger OnAssistEdit();
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());

                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Secifies the amount';
                }

                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bal Account Type';
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bal Account No.';
                    trigger OnValidate();
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Applies doc type';
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Applies Doc no';
                }

                field(GetAppliesToDocDueDate; HasPaymentFileErrors())
                {
                    ApplicationArea = all;
                    Caption = 'Applies-to Doc. Due Date';
                    ToolTip = 'Specifies the Applies to doc due date';
                }
                field("Bank Payment Type"; "Bank Payment Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Bank payment type';
                }

                field("Source Type"; "Source Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Source Type';
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Source No';
                }
            }
            group(Control24)
            {
                field(Control30; '')
                {
                    ApplicationArea = all;
                    CaptionClass = Text19039985Lbl;
                    ToolTip = 'Specifies the';
                }
                field(AccName1; AccName)
                {
                    Caption = 'Account Name';
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the Account Name';
                }
                field(BalAccName1; BalAccName)
                {
                    ApplicationArea = all;
                    Caption = 'Bal. Account Name';
                    Editable = false;
                    ToolTip = 'Specifies the Bal account Name';
                }
                field(Balance1; Balance + "Balance (LCY)" - xRec."Balance (LCY)")
                {
                    ApplicationArea = all;
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Visible = BalanceVisible;
                    ToolTip = 'Specifies the Balance';
                }
                field(TotalBalance1; TotalBalance + "Balance (LCY)" - xRec."Balance (LCY)")
                {
                    ApplicationArea = all;
                    AutoFormatType = 1;
                    Caption = 'Total Balance';
                    Editable = false;
                    Visible = TotalBalanceVisible;
                    ToolTip = 'Specifies the Total Balance';
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
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Dimension';

                    trigger OnAction();
                    begin
                        ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
            }
            group("A&ccount")
            {
                Caption = 'A&ccount';
                action(Card)
                {
                    Caption = 'Card';
                    RunObject = Codeunit "Gen. Jnl.-Show Card";
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = all;
                    Image = Card;
                    ToolTip = 'Specifies the Card';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = Codeunit "Gen. Jnl.-Show Entries";
                    ShortCutKey = 'Ctrl+F5';
                    ApplicationArea = all;
                    Image = Ledger;
                    ToolTip = 'Ledger';
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Apply Entries")
                {
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    RunObject = Codeunit "Gen. Jnl.-Apply";
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Apply entries';
                }
                action("Insert Conv. LCY Rndg. Lines")
                {
                    Caption = 'Insert Conv. LCY Rndg. Lines';
                    RunObject = Codeunit "Adjust Gen. Journal Balance";
                    ApplicationArea = all;
                    Image = InsertAccount;
                    ToolTip = 'Specifies the insert lct rndg lines';
                }
            }
            group("&Payments")
            {
                Caption = '&Payments';

                group("Tax Payments")
                {
                    Caption = 'Tax Payments';

                    action(TDS)
                    {
                        Caption = 'TDS';
                        ApplicationArea = all;
                        Image = TaxDetail;
                        ToolTip = 'Specifies the TDS';

                        trigger OnAction();
                        begin
                            //PaymentofTaxes.PayTDS(Rec);
                            TDSSalDet.RESET();
                            TDSSalDet.SETFILTER("TDS Amount Paid", '=%1', 0);
                            CLEAR(TDSSalDetForm);
                            TDSSalDetForm.PayTDS1(Rec);
                            TDSSalDetForm.SETTABLEVIEW(TDSSalDet);
                            TDSSalDetForm.RUNMODAL();
                        end;
                    }
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Reconcile)
                {
                    Caption = 'Reconcile';
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    Image = Reconcile;
                    ToolTip = 'Specifies the Reconcile';
                    trigger OnAction();
                    begin
                        GLReconcile.SetGenJnlLine(Rec);
                        GLReconcile.RUN();
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Test';
                    trigger OnAction();
                    begin
                        ReportPrint.PrintGenJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Post';
                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(false);
                    end;
                }
                // action("Post and &Print")
                // {
                //     Caption = 'Post and &Print';
                //     Image = PostPrint;
                //     ShortCutKey = 'Shift+F9';
                //     ApplicationArea = all;
                //     trigger OnAction();
                //     begin
                //         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
                //         CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                //         CurrPage.UPDATE(false);
                //     end;
                // }
            }
        }

    }

    trigger OnAfterGetRecord();
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecords();
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        TDSSalDet.RESET();
        TDSSalDet.SETRANGE("TDS Payment Doc. No.", "Document No.");
        if TDSSalDet.FINDFIRST() then
            repeat
                TDSSalDet."TDS Payment Date" := 17540101D;
                TDSSalDet."TDS Payment Doc. No." := '';
                TDSSalDet.Select := false;
                TDSSalDet.MODIFY();
            until TDSSalDet.NEXT() = 0;
    end;

    trigger OnInit();
    begin
        TotalBalanceVisible := true;
        BalanceVisible := true;
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        if "Posting Date" <> xRec."Posting Date" then begin
            TDSSalDet.RESET();
            TDSSalDet.SETRANGE("TDS Payment Doc. No.", "Document No.");
            if TDSSalDet.FINDFIRST() then
                repeat
                    TDSSalDet."TDS Payment Date" := "Posting Date";
                    TDSSalDet.MODIFY();
                until TDSSalDet.NEXT() = 0;
        end;

        if "Document No." <> xRec."Document No." then begin
            TDSSalDet.RESET();
            TDSSalDet.SETRANGE("TDS Payment Doc. No.", xRec."Document No.");
            if TDSSalDet.FINDFIRST() then
                repeat
                    TDSSalDet."TDS Payment Doc. No." := "Document No.";
                    TDSSalDet.MODIFY();
                until TDSSalDet.NEXT() = 0;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        UpdateBalance();
        SetUpNewLine(xRec, Balance, BelowxRec);
        CLEAR(ShortcutDimCode);
        OnAfterGetCurrRecords();
    end;

    trigger OnOpenPage();
    var
        JnlSelected: Boolean;
    begin
        BalAccName := '';
        OpenedFromBatch := ("Journal Batch Name" <> '') and ("Journal Template Name" = '');
        if OpenedFromBatch then begin
            CurrentJnlBatchName := "Journal Batch Name";
            GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
            exit;
        end;
        GenJnlManagement.TemplateSelection(PAGE::"Payment Journal", 4, false, Rec, JnlSelected);
        if not JnlSelected then
            ERROR('');
        GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
        GLSetup.GET();
    end;

    var
        TDSSalDet: Record "TDS Salary Details B2B";
        GLSetup: Record "General Ledger Setup";
        GenJnlManagement: Codeunit GenJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        TDSSalDetForm: Page "Posted Salary TDS Details B2B";

        GLReconcile: Page Reconciliation;
        ChangeExchangeRate: Page "Change Exchange Rate";
        CurrentJnlBatchName: Code[10];
        AccName: Text[100];
        BalAccName: Text[100];
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        OpenedFromBatch: Boolean;

        [InDataSet]
        BalanceVisible: Boolean;
        [InDataSet]
        TotalBalanceVisible: Boolean;
        Text19039985Lbl: Label 'Account Name';

    local procedure UpdateBalance();
    begin
        GenJnlManagement.CalcBalance(
          Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali();
    begin
        CurrPage.SAVERECORD();
        GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(false);
    end;

    local procedure OnAfterGetCurrRecords();
    begin
        xRec := Rec;
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance();
    end;
}

