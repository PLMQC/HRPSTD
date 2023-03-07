page 33001248 "Loan Repayment B2B"
{
    // version B2BHR1.00.00
    Caption = 'Loan Repayment';
    PageType = Card;
    SourceTable = "Loan Repayments B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan Id"; "Loan Id")
                {
                    Editable = false;
                    ToolTip = 'Specifies the loan Id number in loan repayment table';
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    Editable = false;
                    ToolTip = '"Specifies the employee number in the loan repayment "';
                    ApplicationArea = all;
                }
                field("Payment Date"; "Payment Date")
                {
                    ToolTip = '"Specifies the payment date of the loan in th eloan repayment "';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        AmountEditable := true;
                        Month := DATE2DMY("Payment Date", 2);
                        Year := DATE2DMY("Payment Date", 3);
                        Loan.SETRANGE(Id, "Loan Id");
                        Loan.SETRANGE("Employee Code", "Employee No.");
                        if Loan.FINDFIRST() then
                            Amount := Loan."Loan Balance";
                    end;
                }
                field(Amount; Amount)
                {
                    Editable = AmountEditable;
                    ToolTip = '"specifies the amount in the laon repyment "';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        Loan.RESET();
                        Loan.SETRANGE(Id, "Loan Id");
                        Loan.SETRANGE("Employee Code", "Employee No.");
                        if Loan.FINDFIRST() then
                            if Amount > Loan."Loan Balance" then
                                ERROR(Text002Lbl, Loan."Loan Balance");
                    end;
                }
                field(LoanPrepaymentType; "Loan Repayment Type")
                {
                    ToolTip = '"Specify the loan repayment from th edrill down list like ""Equsl EMI"", "" Installemtnts"" etc "';
                    Visible = LoanPrepaymentTypeVisible;
                    ApplicationArea = all;
                }
            }
            group("Posting")
            {
                field("Loan Repayment Template Name"; "Loan Repayment Template Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The loan repayment name';
                }
                field("Loan Repayment Batch Name"; "Loan Repayment Batch Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The loan repayment batch';
                    trigger OnLookup(Var Text: Text): Boolean;
                    var
                        NoSeries: Record "No. Series";
                        JournalTemplate: Record "Payroll Journal Template B2B";
                        JournalBatch: Record "Payroll Journal Batch B2B";
                        NoSeriesMgt: Codeunit 396;
                    begin
                        JournalTemplate.RESET();
                        JournalTemplate.SETRANGE("Form ID", 33001248);
                        if JournalTemplate.FINDFIRST() then
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                        if PAGE.RUNMODAL(33001274, JournalBatch) = ACTION::LookupOK then begin
                            "Loan Repayment Batch Name" := JournalBatch.Name;
                            "Loan Repayment Template Name" := JournalBatch."Journal Template Name";
                        end;
                        JournalBatch.FILTERGROUP(0);
                        JournalBatch.RESET();
                        JournalBatch.SETRANGE(Name, "Loan Repayment Batch Name");
                        if JournalBatch.FINDFIRST() then
                            NoSeries.SETRANGE("Code", JournalBatch."No. Series");
                        if not NoSeries.IsEmpty() then
                            "Document No." := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WorkDate(), true);
                    end;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Account type';
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Account no';
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Document No.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(OK)
                {
                    Caption = 'OK';
                    Image = Start;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Function of Loan Repayment';
                    trigger OnAction();
                    begin
                        Loan.RESET();
                        Loan.SETRANGE(Id, "Loan Id");
                        if Loan.FINDFIRST() then
                            if Loan."Interest Method" = Loan."Interest Method"::"Dimnishing Rate" then
                                TESTFIELD("Loan Repayment Type");
                        PostPaymentJournal(Rec);
                        Repayment();
                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        LoanPrepaymentTypeVisible := true;
        AmountEditable := true;
    end;

    trigger OnOpenPage();
    begin
        AmountEditable := false;
        Loan.RESET();
        Loan.SETRANGE(Id, "Loan Id");
        if Loan.FINDFIRST() then
            if Loan."Interest Method" = Loan."Interest Method"::"Dimnishing Rate" then
                LoanPrepaymentTypeVisible := true
            else
                LoanPrepaymentTypeVisible := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if ("Payment Date" <> 0D) and (not Paid) then
            Delete();
    end;

    var
        Loan: Record Loan_B2B;
        LoanDetails: Record "Loan Details B2B";
        Text000Lbl: Label 'Loan already closed.';
        Text001Lbl: Label 'Loan repayment done.';
        Text002Lbl: Label 'Amount should not be greater than %1.', Comment = '%1 = Loan Balance';
        [InDataSet]
        AmountEditable: Boolean;
        [InDataSet]
        LoanPrepaymentTypeVisible: Boolean;

    procedure Repayment();
    begin
        Loan.RESET();
        Loan.SETRANGE(Id, "Loan Id");
        if Loan.FINDFIRST() then
            if Loan.Closed then
                ERROR(Text000Lbl);
        TESTFIELD("Payment Date");
        TESTFIELD(Amount);
        LoanDetails.RESET();
        LoanDetails.SETRANGE("Employee No.", "Employee No.");
        LoanDetails.SETRANGE("Loan Id", "Loan Id");
        LoanDetails.SETRANGE(Month, Month);
        LoanDetails.SETRANGE(Year, Year);
        LoanDetails.SETFILTER(Balance, '<>%1', 0);
        if LoanDetails.FINDFIRST() then begin
            LoanDetails."Lump Sum Payment" := Amount;
            LoanDetails."Repayment Month" := Month;
            LoanDetails."Repayment Year" := Year;
            LoanDetails.Balance := LoanDetails.Balance - Amount;
            if LoanDetails.Balance <= 0 then
                LoanDetails."Loan Closed" := true;
            LoanDetails.MODIFY();
            Loan.SETRANGE("Employee Code", "Employee No.");
            Loan.SETRANGE(Id, "Loan Id");
            if Loan.FINDFIRST() then
                Loan."Loan Balance" := Loan."Loan Balance" - Amount;
            if Loan."Loan Balance" <= 0 then begin
                Loan."Effective Amount" := 0;
                Loan.Closed := true;
            end;
            Loan.MODIFY();
            Paid := true;
            MODIFY();


            if Loan."Interest Method" = Loan."Interest Method"::"Interest Free" then
                LoanRescheduleForIF(LoanDetails, Loan, Amount);

            if Loan."Interest Method" = Loan."Interest Method"::"Flat Rate" then
                LoanRescheduleForFR(LoanDetails, Loan, Amount);

            if Loan."Interest Method" = Loan."Interest Method"::"Dimnishing Rate" then
                LoanRescheduleForDim(LoanDetails, Loan, Amount);
            MESSAGE(Text001Lbl);
        end else begin
            LoanDetails.RESET();
            LoanDetails.SETRANGE("Employee No.", "Employee No.");
            LoanDetails.SETRANGE("Loan Id", "Loan Id");
            LoanDetails.SETRANGE(Month, Month);
            LoanDetails.SETRANGE(Year, Year);
            if LoanDetails.FINDFIRST() then begin
                LoanDetails."Lump Sum Payment" := Amount;
                LoanDetails."Repayment Month" := Month;
                LoanDetails."Repayment Year" := Year;
                Loan.RESET();
                Loan.SETRANGE("Employee Code", "Employee No.");
                Loan.SETRANGE(Id, "Loan Id");
                if Loan.FINDFIRST() then begin
                    LoanDetails.Balance := Loan."Loan Balance" - Amount;
                    if LoanDetails.Balance <= 0 then
                        LoanDetails."Loan Closed" := true;
                    LoanDetails.MODIFY();
                    Loan."Loan Balance" := Loan."Loan Balance" - Amount;
                    if Loan."Loan Balance" <= 0 then begin
                        Loan."Effective Amount" := 0;
                        Loan.Closed := true;
                    end;
                    Loan.MODIFY();
                    Paid := true;
                    MODIFY();
                    if Loan."Interest Method" = Loan."Interest Method"::"Interest Free" then
                        LoanRescheduleForIF(LoanDetails, Loan, Amount);

                    if Loan."Interest Method" = Loan."Interest Method"::"Flat Rate" then
                        LoanRescheduleForFR(LoanDetails, Loan, Amount);

                    if Loan."Interest Method" = Loan."Interest Method"::"Dimnishing Rate" then
                        LoanRescheduleForDim(LoanDetails, Loan, Amount);
                    MESSAGE(Text001Lbl);
                end;
            end;
        end;
    end;

    procedure PostPaymentJournal(LoanRepayment: Record "Loan Repayments B2B")
    var
        GenJnlLine: Record "Gen. Journal Line";
        EmpLRec: Record "Employee B2B";
        LoanPostingSetup: Record "Loan Posting Groups B2B";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Text33010Txt: Label 'PAYMENTJNL';
    begin
        if LoanRepayment.Amount <> 0 then begin
            LoanRepayment.TestField("Loan Repayment Template Name");
            LoanRepayment.TestField("Loan Repayment Batch Name");
            LoanRepayment.TestField("Document No.");
            LoanRepayment.TestField("Account No.");
            Loan.Get(LoanRepayment."Loan Id");
            LoanPostingSetup.Get(Loan."Loan Posting Group");
            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := LoanRepayment."Loan Repayment Template Name";
            GenJnlLine."Journal Batch Name" := LoanRepayment."Loan Repayment Batch Name";
            GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            if LoanRepayment."Account Type" = LoanRepayment."Account Type"::"G/L Account" then
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            if LoanRepayment."Account Type" = LoanRepayment."Account Type"::"Bank Account" then
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := LoanRepayment."Account No.";
            GenJnlLine.VALIDATE("Account No.");
            GenJnlLine."Document No." := LoanRepayment."Document No.";
            if EmpLRec.GET(LoanRepayment."Employee No.") then
                GenJnlLine."Currency Code" := EmpLRec."Currency Code";
            GenJnlLine."Posting Date" := LoanRepayment."Payment Date";
            GenJnlLine.Description :=
               LoanRepayment."Employee No." + ' ' + COPYSTR(GenJnlLine.Description, 1, 20);
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := LoanPostingSetup."Loan Refundable Acc.";
            GenJnlLine.Amount := Amount;
            GenJnlLine.VALIDATE(Amount);
            GenJnlLine."Source Code" := Text33010Txt;
            GenJnlLine."Source No." := EmpLRec."No.";
            GenJnlPostLine.RunWithCheck(GenJnlLine);
        end;
    end;
}

