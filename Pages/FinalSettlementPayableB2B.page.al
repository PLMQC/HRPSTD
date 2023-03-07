page 33001501 "Final Settlement Payable B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Final Settlement Payable';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Final Settlement Payable B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentEmpCode1; CurrentEmpCode)
                {
                    ToolTip = 'Choose the Employee No.';
                    Caption = 'Employee Code';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        FinalSetEmp.RESET();
                        FinalSetEmp.SetRange(Paid, false);
                        if FinalSetEmp.FindSet() then;
                        if PAGE.RUNMODAL(33001406, FinalSetEmp) = ACTION::LookupOK then begin
                            CurrentEmpCode := FinalSetEmp."Employee No.";
                            CurrentYear := FinalSetEmp.Year;
                            CurrentMonth := FinalSetEmp.Month;
                        end;


                        RESET();
                        SETRANGE("Employee No.", CurrentEmpCode);
                        if FINDFIRST() then;
                        CurrPage.UPDATE(false);
                    end;

                    trigger OnValidate();
                    begin
                        CurrentEmpCodeOnAfterValidate();
                    end;
                }
                field(CurrentYear1; CurrentYear)
                {
                    ToolTip = 'Select the year of final settlement.';
                    Caption = 'Year';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    ToolTip = 'Select the month of final settlement.';
                    Caption = 'Month';
                    Editable = false;
                    ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field(PaymentMethod1; PaymentMethod)
                {
                    ToolTip = 'Choose the Payment method for Final settlement ex.Cash, Cheque or Transfer.';
                    Caption = 'Payment Method';
                    OptionCaption = ' ,Cash,Cheque,Bank Transfer';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if (PaymentMethod = PaymentMethod::Cheque) or (PaymentMethod = PaymentMethod::"Bank Transfer") then begin
                            ChequeNoControlEditable := true;
                            ChequeDateControlEditable := true;
                            AccountControlEditable := true;
                        end else begin
                            ChequeNoControlEditable := false;
                            ChequeDateControlEditable := false;
                            AccountControlEditable := false;
                        end;
                    end;
                }
                field(PayAccountNo1; PayAccountNo)
                {
                    ToolTip = 'Choose the Account from drop down which Arrear amount to be paid.';
                    Caption = 'Pay Account No.';
                    Editable = AccountControlEditable;
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        ShowAccounts();
                    end;
                }
                field("Dimesion Code"; "Dimesion Code")
                {
                    ToolTip = 'Choose the Dimension Values from drop down.';
                    ApplicationArea = all;
                }
                field(ChequeNoControl; ChequeNo)
                {
                    ToolTip = 'Enter the Cheque No.';
                    Caption = 'Cheque No.';
                    Editable = ChequeNoControlEditable;
                    ApplicationArea = all;
                }
                field(ChequeDateControl; ChequeDate)
                {
                    ToolTip = 'Enter the Cheque date.';
                    Caption = 'Cheque Date';
                    Editable = ChequeDateControlEditable;
                    ApplicationArea = all;
                }
                field(ShowAll2; ShowAll)
                {
                    ToolTip = 'Check Mark the feild if Want to see all the Employees.';
                    Caption = 'Show All';
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        ShowAllOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102152000)
            {
                Editable = false;
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Shows the Employee No.';
                    Caption = 'Employee No';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Select the month of final settlement.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Select the year of final settlement.';
                    ApplicationArea = all;
                }
                field("Pay Amount"; "Pay Amount")
                {
                    ToolTip = 'Shows the Amount Earned on Final settlement.';
                    ApplicationArea = all;

                    trigger OnDrillDown();
                    begin
                        FSLine.RESET();
                        FSLine.SETRANGE("Employee No.", "Employee No.");
                        FSLine.SETRANGE(Month, Month);
                        FSLine.SETRANGE(Year, Year);
                        PAGE.RUNMODAL(0, FSLine);
                    end;
                }
            }
            group(Postings)
            {
                Caption = 'Postings';
                field(TempBatch1; TempBatch)
                {
                    ToolTip = 'Choose the Bath name to post the Entry.';
                    Caption = 'Journal Batch Name';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        JournalTemplate.SETRANGE("Form ID", 33001501);
                        if JournalTemplate.FINDFIRST() then begin
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                            if PAGE.RUNMODAL(33001274, JournalBatch) = ACTION::LookupOK then begin
                                TempBatch := JournalBatch.Name;
                                TempJournal := JournalBatch."Journal Template Name";
                                PostDate := TODAY();

                                JournalBatch.SETRANGE(Name, TempBatch);
                                if JournalBatch.FINDFIRST() then
                                    NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                                if NoSeries.FINDFIRST() then
                                    "DocNo." := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", PostDate, true);
                            end;
                        end;
                    end;
                }
                field(PostDate1; PostDate)
                {
                    ToolTip = 'Enter the Posting Date to post journal.';
                    Caption = 'PostDate';
                    ApplicationArea = all;
                }
                field("DocNo1."; "DocNo.")
                {
                    ToolTip = 'Enter the Document No.';
                    Caption = 'Document No.';
                    ApplicationArea = all;
                }
                field("<CurrentCadre1>"; CurrentCadre)
                {
                    ToolTip = 'Choose the Pay cadre the Employees will be filtered.';
                    Caption = 'Pay Cadre';
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Lookup_B2B.SETRANGE("LookupType Name", Text33001Lbl);
                        if PAGE.RUNMODAL(0, Lookup_B2B) = ACTION::LookupOK then
                            CurrentCadre := Lookup_B2B."Lookup Name";

                        SelectPayCadre();
                    end;

                    trigger OnValidate();
                    begin
                        CurrentCadreOnAfterValidate();
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Update Amount")
                {
                    ToolTip = 'On clicking updates the final settlement amount.';
                    Caption = 'Update Amount';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        UpdateAmount();
                    end;
                }
                action("<Action1102152017>")
                {
                    ToolTip = 'Post the final settlement.';
                    Caption = '&Post Final Settlement';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Post();
                    end;
                }
            }
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action(Dimensions)
                {
                    ToolTip = 'Specify the Dimesion for employee.';
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(33001193),
                                  "No." = FIELD("Employee No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                }
            }
        }
        area(processing)
        {
        }
    }

    trigger OnAfterGetRecord();
    begin
        if (PaymentMethod = PaymentMethod::Cheque) or (PaymentMethod = PaymentMethod::"Bank Transfer") then begin
            ChequeNoControlEditable := true;
            ChequeDateControlEditable := true;
            AccountControlEditable := true;
        end else begin
            ChequeNoControlEditable := false;
            ChequeDateControlEditable := false;
            AccountControlEditable := false;
        end;
    end;

    trigger OnInit();
    begin
        ChequeDateControlEditable := true;
        ChequeNoControlEditable := true;
    end;

    trigger OnOpenPage();
    begin
        CurrentYear := 0;
        CurrentMonth := 0;
        CurrentEmpCode := '';
        RESET();
        SelectEmpCode();

        if (PaymentMethod = PaymentMethod::Cheque) or (PaymentMethod = PaymentMethod::"Bank Transfer") then begin
            ChequeNoControlEditable := true;
            ChequeDateControlEditable := true;
            AccountControlEditable := true;
        end else begin
            ChequeNoControlEditable := false;
            ChequeDateControlEditable := false;
            AccountControlEditable := false;
        end;
    end;

    var
        Employee: Record "Employee B2B";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        GenJnlLine: Record "Gen. Journal Line";
        NoSeries: Record "No. Series";
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        FinalSetEmp: Record "Final Settlement Header B2B";
        FinalSetLine: Record "Final Settlement Line B2B";
        GenJnlLineRec: Record "Gen. Journal Line";
        FinalSetPayable: Record "Final Settlement Payable B2B";
        FSH: Record "Final Settlement Header B2B";
        FSLine: Record "Final Settlement Line B2B";
        FinalSettlementLine: Record "Final Settlement Line B2B";
        Lookup_B2B: Record Lookup_B2B;
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        NoSeriesMgt: Codeunit 396;
        LineNum: Integer;
        CurrentCadre: Code[30];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        ShowAll: Boolean;
        TempBatch: Code[10];
        TempJournal: Code[10];
        "DocNo.": Code[20];
        PostDate: Date;
        PaymentMethod: Option " ",Cash,Cheque,"Bank Transfer";
        
        PayAccountNo: Code[20];
        ChequeNo: Code[20];
        ChequeDate: Date;
        CurrentEmpCode: Code[20];

        AmountGvar: Decimal;
        Text009Lbl: Label 'You must specify Employee code.';
        Text010Lbl: Label 'You must specify Pay Method.';
        Text011Lbl: Label 'You must specify Pay Account No.';
        Text012Lbl: Label 'You must specify Journal Batch Name.';
        Text005Lbl: Label 'Do you want to post the journal lines?';
        Inserted: Boolean;
        Text006Lbl: Label 'Final Settlement Payment Successfully posted.';
        Text013Lbl: Label 'Final Settlement payment already posted.';
        BonusAmt: Decimal;
        [InDataSet]
        ChequeNoControlEditable: Boolean;
        [InDataSet]
        ChequeDateControlEditable: Boolean;
        [InDataSet]
        AccountControlEditable: Boolean;
        Text33001Lbl: Label 'PAY CADRE';
        Text33002Lbl: Label 'Jan';
        Text33003Lbl: Label 'Febuary';
        Text33004Lbl: Label 'March';
        Text33005Lbl: Label 'April';
        Text33006Lbl: Label 'May';
        Text33007Lbl: Label 'June';
        Text33008Lbl: Label 'July';
        Text33009Lbl: Label 'August';
        Text33010Lbl: Label 'Septmeber';
        Text33011Lbl: Label 'October';
        Text33012Lbl: Label 'November';
        Text33013Lbl: Label 'December';
        Text33014Lbl: Label 'BONUS';

    procedure SelectYear();
    begin
        SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        SETRANGE(Month, CurrentMonth);
        CurrPage.UPDATE(false);
    end;

    procedure SelectStartingDate();
    begin
    end;

    procedure SelectEndingDate();
    begin
    end;

    procedure SelectPayCadre();
    begin
        SETRANGE("Pay Cadre", CurrentCadre);
        CurrPage.UPDATE(false);
    end;

    procedure ReturnMonth(Month: Integer): Code[20];
    begin
        case Month of
            1:
                exit(Text33002Lbl);
            2:
                exit(Text33003Lbl);
            3:
                exit(Text33004Lbl);
            4:
                exit(Text33005Lbl);
            5:
                exit(Text33006Lbl);
            6:
                exit(Text33007Lbl);
            7:
                exit(Text33008Lbl);
            8:
                exit(Text33009Lbl);
            9:
                exit(Text33010Lbl);
            10:
                exit(Text33011Lbl);
            11:
                exit(Text33012Lbl);
            12:
                exit(Text33013Lbl);
        end;

    end;

    procedure SelectPayMethod();
    begin
        SETRANGE("Payment Method", PaymentMethod);
        CurrPage.UPDATE(false);
    end;



    procedure ShowAccounts();
    var
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
    begin
        case PaymentMethod of
            PaymentMethod::Cash:
                begin
                    GLAccount.RESET();
                    if PAGE.RUNMODAL(0, GLAccount) = ACTION::LookupOK then
                        PayAccountNo := GLAccount."No.";
                end;
            PaymentMethod::"Bank Transfer":
                begin
                    BankAccount.RESET();
                    if PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK then
                        PayAccountNo := BankAccount."No.";
                end;
            PaymentMethod::Cheque:
                begin
                    BankAccount.RESET();
                    if PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK then
                        PayAccountNo := BankAccount."No.";
                end;
        end;
    end;

    procedure SelectEmpCode();
    begin
        SETRANGE("Employee No.", CurrentEmpCode);
        CurrPage.UPDATE(false);
    end;

    procedure Post2();
    begin
        FSH.RESET();
        FSH.SETRANGE("Employee No.", CurrentEmpCode);
        if not FSH.IsEmpty() and FSH.Paid then
            ERROR(Text013Lbl);

        CLEAR(Inserted);
        if CurrentEmpCode = '' then
            ERROR(Text009Lbl);
        if PaymentMethod = 0 then
            ERROR(Text010Lbl);
        if PayAccountNo = '' then
            ERROR(Text011Lbl);
        if (TempJournal = '') or (TempBatch = '') then
            ERROR(Text012Lbl);
        if not CONFIRM(Text005Lbl, false) then
            exit;


        FinalSetPayable.RESET();
        FinalSetPayable.SETRANGE("Employee No.", CurrentEmpCode);
        FinalSetPayable.SETRANGE(Month, CurrentMonth);
        FinalSetPayable.SETRANGE(Year, CurrentYear);
        FinalSetPayable.SETFILTER("Pay Amount", '<>%1', 0);
        if FinalSetPayable.FINDFIRST() then begin
            GenJnlLineRec.RESET();
            GenJnlLineRec.SETRANGE("Journal Template Name", TempJournal);
            GenJnlLineRec.SETRANGE("Journal Batch Name", TempBatch);
            if GenJnlLineRec.FINDLAST() then;

            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := TempJournal;
            GenJnlLine."Journal Batch Name" := TempBatch;
            GenJnlLine."Document No." := "DocNo.";
            GenJnlLine."Line No." := (GenJnlLineRec."Line No." + 10000);
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            Employee.SETRANGE("No.", FinalSetPayable."Employee No.");
            if Employee.FINDFIRST() then begin
                if EmpPostingGroup.GET(Employee."Emp Posting Group") then
                    EmpPostingGroup.TESTFIELD("Salary Payable Acc.");
                GenJnlLine."Account No." := EmpPostingGroup."Salary Payable Acc.";
            end;
            GenJnlLine."Shortcut Dimension 1 Code" := FinalSetPayable."Dimesion Code";
            GenJnlLine."Posting Date" := PostDate;
            GenJnlLine.Description := Copystr(FinalSetPayable."Employee No." + ' ' +
                                      ReturnMonth(FinalSetPayable.Month) + ' ' + FORMAT(FinalSetPayable.Year), 1, 100);

            case PaymentMethod of
                PaymentMethod::Cash:
                    begin
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := PayAccountNo;
                    end;
                PaymentMethod::Cheque, PaymentMethod::"Bank Transfer":
                    begin
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"Bank Account";
                        GenJnlLine."Bal. Account No." := PayAccountNo;
                    end;
            end;

            GenJnlLine.VALIDATE(Amount, FinalSetPayable."Pay Amount");
            Inserted := true;
        end;
        GenJnlPostBatch.RUN(GenJnlLine);

        if Inserted then begin
            FSH.RESET();
            FSH.SETRANGE("Employee No.", CurrentEmpCode);
            if FSH.FINDFIRST() then begin
                FSH.Paid := true;
                FSH.MODIFY();
            end;
            MESSAGE(Text006Lbl);
        end;
    end;

    procedure UpdateAmount();
    begin
        CLEAR(AmountGvar);
        FinalSetLine.RESET();
        FinalSetLine.SETRANGE("Employee No.", CurrentEmpCode);
        FinalSetLine.SETRANGE(Month, CurrentMonth);
        FinalSetLine.SETRANGE(Year, CurrentYear);
        FinalSetLine.SETFILTER(Posted, '%1', true);
        if FinalSetLine.FINDFIRST() then
            repeat
                if FinalSetLine."Addition/Deduction" = FinalSetLine."Addition/Deduction"::Addition then
                    AmountGvar += FinalSetLine.Amount
                else
                    if FinalSetLine."Addition/Deduction" = FinalSetLine."Addition/Deduction"::Deduction then
                        AmountGvar -= FinalSetLine.Amount
            until FinalSetLine.NEXT() = 0;


        if AmountGvar <> 0 then begin
            FinalSetPayable.INIT();
            FinalSetPayable."Employee No." := CurrentEmpCode;
            FinalSetPayable.Month := CurrentMonth;
            FinalSetPayable.Year := CurrentYear;
            FinalSetPayable."Pay Amount" := AmountGvar;
            FinalSetPayable.INSERT();
        end;
    end;

    procedure Post();
    var
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        clear(GenJnlPostLine);
        CLEAR(Inserted);
        CLEAR(GenJnlPostBatch);
        if CurrentEmpCode = '' then
            ERROR(Text009Lbl);
        if PaymentMethod = 0 then
            ERROR(Text010Lbl);
        if PayAccountNo = '' then
            ERROR(Text011Lbl);
        if (TempJournal = '') or (TempBatch = '') then
            ERROR(Text012Lbl);
        if not CONFIRM(Text005Lbl, false) then
            exit;


        FinalSetPayable.RESET();
        FinalSetPayable.SETRANGE("Employee No.", CurrentEmpCode);
        FinalSetPayable.SETRANGE(Month, CurrentMonth);
        FinalSetPayable.SETRANGE(Year, CurrentYear);
        FinalSetPayable.SETFILTER("Pay Amount", '<>%1', 0);
        if FinalSetPayable.FINDFIRST() then begin
            GenJnlLineRec.RESET();
            GenJnlLineRec.SETRANGE("Journal Template Name", TempJournal);
            GenJnlLineRec.SETRANGE("Journal Batch Name", TempBatch);
            if GenJnlLineRec.FINDLAST() then
                LineNum := GenJnlLineRec."Line No." + 10000
            else
                LineNum := 10000;

            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := TempJournal;
            GenJnlLine."Journal Batch Name" := TempBatch;
            GenJnlLine."Line No." := LineNum;
            GenJnlLine."Document No." := "DocNo.";
            GenJnlLine.VALIDATE("Posting Date", PostDate);
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

            GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
            Employee.SETRANGE("No.", FinalSetPayable."Employee No.");
            if Employee.FINDFIRST() then begin
                if EmpPostingGroup.GET(Employee."Emp Posting Group") then
                    EmpPostingGroup.TESTFIELD("Salary Payable Acc.");
                GenJnlLine.VALIDATE("Account No.", EmpPostingGroup."Salary Payable Acc.");
            end;
            GenJnlLine.Description := FinalSetPayable."Employee No." + ' ' +
                                      ReturnMonth(FinalSetPayable.Month) + ' ' + FORMAT(FinalSetPayable.Year);
            CLEAR(BonusAmt);
            FinalSettlementLine.RESET();
            FinalSettlementLine.SETRANGE("Employee No.", CurrentEmpCode);
            FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Addition);
            FinalSettlementLine.SETFILTER("Pay Element Code", Text33014Lbl);
            if FinalSettlementLine.FINDFIRST() then
                repeat
                    BonusAmt := BonusAmt + FinalSettlementLine.Amount;
                until FinalSettlementLine.NEXT() = 0;


            GenJnlLine.VALIDATE(Amount, (FinalSetPayable."Pay Amount" - BonusAmt));
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            //GenJnlLine.INSERT();            

            if BonusAmt <> 0 then begin
                LineNum += 10000;
                GenJnlLine.INIT();
                GenJnlLine."Journal Template Name" := TempJournal;
                GenJnlLine."Journal Batch Name" := TempBatch;
                GenJnlLine."Line No." := LineNum;
                GenJnlLine."Document No." := "DocNo.";
                GenJnlLine.VALIDATE("Posting Date", PostDate);
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                Employee.SETRANGE("No.", FinalSetPayable."Employee No.");
                if Employee.FINDFIRST() then begin
                    if EmpPostingGroup.GET(Employee."Emp Posting Group") then
                        EmpPostingGroup.TESTFIELD("Bonus Payable Acc.");
                    GenJnlLine.VALIDATE("Account No.", EmpPostingGroup."Bonus Payable Acc.");
                end;
                GenJnlLine.Description := CopyStr(FinalSetPayable."Employee No." + ' ' +
                                           ReturnMonth(FinalSetPayable.Month) + ' ' + FORMAT(FinalSetPayable.Year), 1, 100);

                GenJnlLine.VALIDATE(Amount, BonusAmt);

                GenJnlPostLine.RunWithCheck(GenJnlLine);
                //GenJnlLine.INSERT();
            end;
            LineNum += 10000;
            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := TempJournal;
            GenJnlLine."Journal Batch Name" := TempBatch;
            GenJnlLine."Line No." := LineNum;
            GenJnlLine."Document No." := "DocNo.";
            GenJnlLine.VALIDATE("Posting Date", PostDate);
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine.Description := FinalSetPayable."Employee No." + ' ' +
                                      ReturnMonth(FinalSetPayable.Month) + ' ' + FORMAT(FinalSetPayable.Year);
            case PaymentMethod of
                PaymentMethod::Cash:
                    begin
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("Account No.", PayAccountNo);
                    end;
                PaymentMethod::Cheque, PaymentMethod::"Bank Transfer":
                    begin
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"Bank Account");
                        GenJnlLine.VALIDATE("Account No.", PayAccountNo);
                    end;
            end;
            GenJnlLine.VALIDATE(Amount, -FinalSetPayable."Pay Amount");
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", FinalSetPayable."Dimesion Code");
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            //GenJnlLine.INSERT();
            Inserted := true;
        end;

        //GenJnlPostBatch.RUN(GenJnlLine);

        if Inserted then begin
            FSH.RESET();
            FSH.SETRANGE("Employee No.", CurrentEmpCode);
            if FSH.FINDFIRST() then begin
                FSH.Paid := true;
                FSH.MODIFY();
            end;
            MESSAGE(Text006Lbl);
        end;
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        SelectYear();
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        SelectMonth();
    end;

    local procedure ShowAllOnAfterValidate();
    begin
        if ShowAll then begin
            RESET();
            SelectYear();
            SelectMonth();
        end else begin
            SelectYear();
            SelectMonth();
        end;
    end;

    local procedure PaymentMethodOnAfterValidate();
    begin
        if PaymentMethod = PaymentMethod::"Bank Transfer" then begin
            ChequeNoControlEditable := true;
            ChequeDateControlEditable := true;
        end else begin
            ChequeNoControlEditable := false;
            ChequeDateControlEditable := false;
        end;
        CurrPage.UPDATE(false);
    end;

    local procedure CurrentEmpCodeOnAfterValidate();
    begin
        SelectEmpCode();

        UpdateAmount();
    end;

    local procedure CurrentCadreOnAfterValidate();
    begin
        SelectPayCadre();
    end;
}

