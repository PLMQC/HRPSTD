page 33001525 "Leave Encashment Pay Jou B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Leave Encashment Pay Journal';
    DeleteAllowed = true;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Posted Leave Encash Line B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentYear1; CurrentYear)
                {
                    ToolTip = 'Enter the Year for Leave Encashment.';
                    Caption = 'Year';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    ToolTip = 'Choose the Month for Leave Encashment.';
                    Caption = 'Month';
                    ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field(PaymentMethod1; PaymentMethod)
                {
                    ToolTip = 'Choose the Payment method for Leave Encashment Payment ex.Cash, Cheque or Transfer.';
                    Caption = 'Payment Method';
                    OptionCaption = ' ,Cash,Cheque,Bank Transfer';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        PaymentMethodOnAfterValidate();
                    end;
                }
                field(PayAccountNo1; PayAccountNo)
                {
                    ToolTip = 'Choose the Account from drop down which Arrear amount to be paid.';
                    Caption = 'Pay Account No.';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        ShowAccounts();
                    end;
                }
                field("Dimension Code"; "Dimension Code")
                {
                    ToolTip = 'Choose the Dimension Values from drop down.';
                    Caption = 'Dimension Code';
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
                field(ShowAll1; ShowAll)
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
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Shows the Employee No.';
                    Caption = 'Employee No';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Shows the Employee Name.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Bank / Cash Account"; "Bank / Cash Account")
                {
                    ToolTip = 'Choose the Bank / cash account ';
                    Editable = true;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Available Leaves"; "Available Leaves")
                {
                    ToolTip = 'No. of Leaves Available for Leave Encashment.';
                    ApplicationArea = all;
                }
                field("Leave Code"; "Leave Code")
                {
                    ToolTip = 'Shows the Leave Code.';
                    ApplicationArea = all;
                }
                field("Leaves To Encash"; "Leaves To Encash")
                {
                    ToolTip = 'Need to give No. of Days for Leaves to encash.';
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Choose the Dimension Values from drop down.';
                    ApplicationArea = all;
                }
                field("Encash Amount"; "Encash Amount")
                {
                    ToolTip = 'Shows the Amount Earned on leaves Encashment.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Net Payable"; "Net Payable")
                {
                    ToolTip = 'Shows The net Amount payable on leave Encashment.';
                    ApplicationArea = all;
                }
                field("Paid Amount"; "Paid Amount")
                {
                    ToolTip = 'Shows the Amount paid to the Employee.';
                    Editable = false;
                    ApplicationArea = all;
                }

                field("Cheque No."; "Cheque No.")
                {
                    ToolTip = 'Enter the Cheque No.';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ToolTip = 'Enter the Cheque Date.';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Pay Amount"; "Pay Amount")
                {
                    ToolTip = 'Shows the Amount paid to Employee.';
                    ApplicationArea = all;
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
                        JournalTemplate.SETRANGE("Form ID", 33001525);
                        if JournalTemplate.FINDFIRST() then begin
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                            if PAGE.RUNMODAL(33001274, JournalBatch) = ACTION::LookupOK then begin
                                TempBatch := JournalBatch.Name;
                                TempJournal := JournalBatch."Journal Template Name";
                                PostDate := TODAY();
                            end;
                        end;
                        JournalBatch.SETRANGE(Name, TempBatch);
                        if JournalBatch.FINDFIRST() then
                            NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                        if NoSeries.FINDFIRST() then
                            "DocNo." := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series", WORKDATE());
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
                field(CurrentCadre1; CurrentCadre)
                {
                    ToolTip = 'Choose the Pay cadre the Employees will be filtered.';
                    Caption = 'Pay Cadre';
                    Visible = false;
                    ApplicationArea = all;

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
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("&Dimensions")
                {
                    ToolTip = 'Shows the Dimensions of the employee.';
                    Caption = '&Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(33001193),
                                  "No." = FIELD("Employee Code");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                }
            }
        }
        area(processing)
        {
            group("P&ost")
            {
                ToolTip = 'on clicking it post the leave Encashment Document.';
                Caption = 'P&ost';
                Image = Post;
                action(Action1102152002)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Post';
                    trigger OnAction();
                    begin
                        LEPost();
                    end;
                }
            }
            action(Previous)
            {
                ToolTip = 'Specifies the Previous record.';
                Caption = 'Previous';
                Image = PreviousRecord;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    if CurrentMonth = 1 then
                        Year := CurrentYear - 1
                    else
                        Year := CurrentYear;

                    if CurrentMonth = 1 then
                        Month := 12
                    else
                        Month := CurrentMonth - 1;

                    Navigate.SETRANGE(Year, Year);
                    Navigate.SETRANGE("Pay Slip Month", Month);
                    if Navigate.FINDFIRST() then begin
                        CurrentYear := Year;
                        CurrentMonth := Month;
                        SelectYear();
                        SelectMonth();
                    end else
                        ERROR(Text002Lbl);
                end;
            }
            action(Next)
            {
                ToolTip = 'Specifies the nest.';
                Caption = 'Next';
                Image = NextRecord;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    if CurrentMonth = 12 then
                        Year := CurrentYear + 1
                    else
                        Year := CurrentYear;

                    if CurrentMonth = 12 then
                        Month := 1
                    else
                        Month := CurrentMonth + 1;

                    Navigate.SETRANGE(Year, Year);
                    Navigate.SETRANGE("Pay Slip Month", Month);
                    if Navigate.FINDFIRST() then begin
                        CurrentYear := Year;
                        CurrentMonth := Month;
                        SelectYear();
                        SelectMonth();
                    end else
                        ERROR(Text002Lbl);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Update Amounts")
                {
                    ToolTip = ' on clicking Update amount it updates the amount.';
                    Caption = 'Update Amounts';
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        PostLeaveEncashLine.SETRANGE(Month, CurrentMonth);
                        PostLeaveEncashLine.SETRANGE(Year, CurrentYear);
                        if UnitCode <> '' then
                            PostLeaveEncashLine.SETRANGE("Shortcut Dimension 1 Code", UnitCode);
                        if PostLeaveEncashLine.FINDFIRST() then
                            repeat
                                PostLeaveEncashLine."Net Payable" := PostLeaveEncashLine."Encash Amount" - PostLeaveEncashLine."Paid Amount";
                                PostLeaveEncashLine."Pay Amount" := PostLeaveEncashLine."Encash Amount";
                                PostLeaveEncashLine.MODIFY();
                            until PostLeaveEncashLine.NEXT() = 0;
                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        ChequeDateControlEditable := true;
        ChequeNoControlEditable := true;
        UnitCode := '';
    end;

    trigger OnOpenPage();
    begin
        if HRSetup.FINDFIRST() then begin
            CurrentYear := HRSetup."Salary Processing Year";
            CurrentMonth := HRSetup."Salary Processing month";
        end;
        SelectYear();
        SelectMonth();

        ShowAll := true;
        if ShowAll then begin
            RESET();
            SelectYear();
            SelectMonth();
        end else begin
            SelectYear();
            SelectMonth();
        end;

        if PaymentMethod = PaymentMethod::Cash then begin
            ChequeNoControlEditable := false;
            ChequeDateControlEditable := false;
        end else begin
            ChequeNoControlEditable := true;
            ChequeDateControlEditable := true;
        end;
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        Navigate: Record "Monthly Attendance B2B";
        GenJnlLine: Record "Gen. Journal Line";
        NoSeries: Record "No. Series";
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        GenJnlLineRec: Record "Gen. Journal Line";
        PostLeaveEncashLine: Record "Posted Leave Encash Line B2B";
        PostedLeaveEncashDetails: Record "Posted Leave Encash Det B2B";
        BankAccLegdEntry: Record "Bank Account Ledger Entry";
        PostedLeaveEncashDetails2: Record "Posted Leave Encash Det B2B";
        NoSeriesMgt: Codeunit 396;
        Text002Lbl: Label 'There are no records with in these filters.';
        CurrentCadre: Code[30];
        PostDate: Date;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        ShowAll: Boolean;
        TempBatch: Code[10];
        TempJournal: Code[10];
        "DocNo.": Code[20];
        LastNoSeriseNo: Code[20];
        Text008Lbl: Label 'Do you want to Post';
        PaymentMethod: Option " ",Cash,Cheque,"Bank Transfer";
        UnitCode: Code[20];
        PayAccountNo: Code[20];
        TotalPaySalaryRevAmount: Decimal;
        ChequeNo: Code[20];
        ChequeDate: Date;
        EntryNum: Integer;
        [InDataSet]
        ChequeNoControlEditable: Boolean;
        [InDataSet]
        ChequeDateControlEditable: Boolean;
        Text009Lbl: Label 'Leave Encashment Payment Successfully Completed';
        JanTxt: Label 'January';
        FebuaryTxt: Label 'Febuary';
        MarchTxt: Label 'March';
        AprilTxt: Label 'April';
        MayTxt: Label 'May';
        JuneTxt: Label 'June';
        JulyTxt: Label 'July';
        AugustTxt: Label 'August';
        SeptemberTxt: Label 'September';
        OctoberTxt: Label 'October';
        NovemberTxt: Label 'November';
        DecemberTxt: Label 'December';
        Text0000Lbl: Label 'PAYMENTJNL';

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
        SETRANGE(PayCadre, CurrentCadre);
        CurrPage.UPDATE(false);
    end;

    procedure ReturnMonth(Month: Integer): Code[20];
    begin
        case Month of
            1:
                exit(JanTxt);
            2:
                exit(FebuaryTxt);
            3:
                exit(MarchTxt);
            4:
                exit(AprilTxt);
            5:
                exit(MayTxt);
            6:
                exit(JuneTxt);
            7:
                exit(JulyTxt);
            8:
                exit(AugustTxt);
            9:
                exit(SeptemberTxt);
            10:
                exit(OctoberTxt);
            11:
                exit(NovemberTxt);
            12:
                exit(DecemberTxt);
        end;
    end;

    procedure SelectPayMethod();
    begin
        SETRANGE("Pay Method", PaymentMethod);
        CurrPage.UPDATE(false);
    end;

    procedure SelectUnitCode();
    begin
        RESET();
        SelectMonth();
        SelectYear();
        if UnitCode <> '' then
            SETRANGE("Shortcut Dimension 1 Code", UnitCode);
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

    procedure LEPost();
    var
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        TempAmount: Decimal;
        RecordCount: Integer;
    begin
        if CONFIRM(Text008Lbl) then begin
            CLEAR(TotalPaySalaryRevAmount);
            PostLeaveEncashLine.RESET();
            PostLeaveEncashLine.SETRANGE(Month, CurrentMonth);
            PostLeaveEncashLine.SETRANGE(Year, CurrentYear);
            PostLeaveEncashLine.SETFILTER("Pay Amount", '>%1', 0);
            RecordCount := PostLeaveEncashLine.COUNT();
            if RecordCount > 0 then begin
                if PostLeaveEncashLine.FINDFIRST() then
                    repeat
                        TempAmount := PostLeaveEncashLine."Pay Amount";
                        if Employee.GET(PostLeaveEncashLine."Employee Code") then
                            if not Employee."Stop Payment" then begin
                                if PostLeaveEncashLine."Pay Amount" <> 0 then begin
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
                                    Employee.SETRANGE("No.", PostLeaveEncashLine."Employee Code");
                                    if Employee.FINDFIRST() then
                                        if EmpPostingGroup.GET(Employee."Emp Posting Group") then
                                            GenJnlLine."Account No." := EmpPostingGroup."LeaveEncash Payable Acc.";

                                    GenJnlLine."Shortcut Dimension 1 Code" := PostLeaveEncashLine."Shortcut Dimension 1 Code";
                                    GenJnlLine."Posting Date" := PostDate;
                                    GenJnlLine.Description := CopyStr(
                                    PostLeaveEncashLine."Employee Code" + ' ' + PostLeaveEncashLine."Employee Name" + ' ' +
                                     ReturnMonth(PostLeaveEncashLine.Month) + ' ' +
                                     FORMAT(PostLeaveEncashLine.Year), 1, 100);

                                    GenJnlLine.Amount := TempAmount;
                                    TotalPaySalaryRevAmount += TempAmount;
                                    GenJnlLine.VALIDATE(Amount);
                                    GenJnlLine."Source Code" := Text0000Lbl;
                                    GenJnlLine."Dimension Set ID" := PostLeaveEncashLine."Dimension Set ID";
                                    GenJnlPostLine.RunWithCheck(GenJnlLine);

                                end;
                                PostedLeaveEncashDetails2.RESET();
                                PostedLeaveEncashDetails2.SETRANGE("Employee Code", PostLeaveEncashLine."Employee Code");
                                PostedLeaveEncashDetails2.SETRANGE(Month, PostLeaveEncashLine.Month);
                                PostedLeaveEncashDetails2.SETRANGE(Year, PostLeaveEncashLine.Year);
                                if PostedLeaveEncashDetails2.FINDLAST() then
                                    EntryNum := PostedLeaveEncashDetails2."Entry No." + 1
                                else
                                    EntryNum := 1;
                                PostedLeaveEncashDetails.INIT();
                                PostedLeaveEncashDetails."Employee Code" := PostLeaveEncashLine."Employee Code";
                                PostedLeaveEncashDetails.Month := PostLeaveEncashLine.Month;
                                PostedLeaveEncashDetails.Year := PostLeaveEncashLine.Year;
                                PostedLeaveEncashDetails."Posting Date" := PostDate;
                                PostedLeaveEncashDetails."Document No" := "DocNo.";
                                PostedLeaveEncashDetails."Encash Amount" := PostLeaveEncashLine."Encash Amount";
                                PostedLeaveEncashDetails."Amount Paid" := PostLeaveEncashLine."Pay Amount";
                                PostedLeaveEncashDetails."Entry No." := EntryNum;
                                PostedLeaveEncashDetails."Leave Code" := PostLeaveEncashLine."Leave Code";
                                PostedLeaveEncashDetails."Leaves To Encash" := PostLeaveEncashLine."Leaves To Encash";
                                case PaymentMethod of
                                    PaymentMethod::Cash:
                                        begin
                                            PostedLeaveEncashDetails."Account Type" := PostedLeaveEncashDetails."Account Type"::"G/L Account";
                                            PostedLeaveEncashDetails."Account No." := PayAccountNo;
                                        end;
                                    PaymentMethod::Cheque:
                                        begin
                                            PostedLeaveEncashDetails."Account Type" := PostedLeaveEncashDetails."Account Type"::"Bank Account";
                                            PostedLeaveEncashDetails."Account No." := PayAccountNo;
                                        end;
                                    PaymentMethod::"Bank Transfer":
                                        begin
                                            PostedLeaveEncashDetails."Account Type" := PostedLeaveEncashDetails."Account Type"::"Bank Account";
                                            PostedLeaveEncashDetails."Account No." := PayAccountNo;
                                        end;

                                end;
                                PostedLeaveEncashDetails."Cheque No." := ChequeNo;
                                PostedLeaveEncashDetails."Cheque Date" := ChequeDate;
                                if PostLeaveEncashLine."Pay Amount" <> 0 then
                                    PostedLeaveEncashDetails.INSERT();

                                PostLeaveEncashLine."Net Payable" := PostLeaveEncashLine."Paid Amount";
                                PostLeaveEncashLine."Remaining Amount" := PostLeaveEncashLine."Encash Amount" - PostLeaveEncashLine."Pay Amount";
                                PostLeaveEncashLine."Pay Amount" := 0;
                                PostLeaveEncashLine.MODIFY();
                            end;
                    until PostLeaveEncashLine.NEXT() = 0;

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
                GenJnlLine."Posting Date" := PostDate;
                GenJnlLine.Description := CopyStr(
                PostLeaveEncashLine."Employee Code" + ' ' + GenJnlLine.Description + ' ' +
                 ReturnMonth(PostLeaveEncashLine.Month) + ' ' +
                 FORMAT(PostLeaveEncashLine.Year), 1, 100);
                case PaymentMethod of
                    PaymentMethod::Cash:
                        begin
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No." := PayAccountNo;

                        end;
                    PaymentMethod::Cheque:
                        begin
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                            GenJnlLine."Account No." := PayAccountNo;

                        end;
                    PaymentMethod::"Bank Transfer":
                        begin
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                            GenJnlLine."Account No." := PayAccountNo;

                        end;
                end;
                GenJnlLine.Amount := -TotalPaySalaryRevAmount;

                GenJnlLine."Dimension Set ID" := PostLeaveEncashLine."Dimension Set ID";

                GenJnlPostLine.RunWithCheck(GenJnlLine);

                LastNoSeriseNo := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE(), true);
                MESSAGE(Text009Lbl);
            end;
        end;
        BankAccLegdEntry.RESET();
        BankAccLegdEntry.SETRANGE("Document No.", "DocNo.");
        if BankAccLegdEntry.FINDLAST() then begin
            BankAccLegdEntry."Bal. Account No." := EmpPostingGroup."LeaveEncash Payable Acc.";
            BankAccLegdEntry.MODIFY();
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
        if PaymentMethod = PaymentMethod::Cash then begin
            ChequeNoControlEditable := false;
            ChequeDateControlEditable := false;
        end else begin
            ChequeNoControlEditable := true;
            ChequeDateControlEditable := true;
        end;
        CurrPage.UPDATE(false);
    end;

    local procedure UnitCodeOnAfterValidate();
    begin
        SelectUnitCode();
    end;

    local procedure CurrentCadreOnAfterValidate();
    begin
        SelectPayCadre();
    end;
}

