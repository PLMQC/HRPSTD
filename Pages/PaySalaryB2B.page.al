page 33001277 "Pay Salary B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Salary Payment Journal';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Monthly Attendance B2B";
    SourceTableView = SORTING("Employee Code", Posted)
                      ORDER(Ascending)
                      WHERE(Posted = FILTER(true));
    UsageCategory = Tasks;
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
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Define Year pf salary processed';

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                        SelectStatus();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
                    ApplicationArea = all;
                    ToolTip = 'Define the month for the which the Salary Payment is to be done';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                        SelectStatus();
                    end;
                }
                field(CurrentCadre1; CurrentCadre)
                {
                    Caption = 'Pay Cadre';
                    ApplicationArea = all;
                    ToolTip = 'Define the Pay Cadre applicable';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Lookup_B2B.SETRANGE("LookupType Name", Text010Lbl);
                        if PAGE.RUNMODAL(0, Lookup_B2B) = ACTION::LookupOK then
                            CurrentCadre := Lookup_B2B."Lookup Name";

                        SelectPayCadre();
                    end;

                    trigger OnValidate();
                    begin
                        CurrentCadreOnAfterValidate();
                    end;
                }
                field(PaymentMethod1; PaymentMethod)
                {
                    Caption = 'Payment Method';
                    OptionCaption = ' ,Cash,Cheque,Bank Transfer';
                    ApplicationArea = all;
                    tooltip = 'Define the Payment method e.g. cash / bank.';

                    trigger OnValidate();
                    begin
                        PaymentMethodOnAfterValidate();
                    end;
                }
                field(PayAccountNo1; PayAccountNo)
                {
                    Caption = 'Pay Account No';
                    ApplicationArea = all;
                    tooltip = 'Define / map  the Applicable General Ledger from Chart of accounts';

                    trigger OnLookup(Var Text: Text): Boolean;
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
                }
                field(ChequeNoControl; ChequeNo)
                {
                    Caption = 'Cheque No.';
                    Editable = ChequeNoControlEditable;
                    ApplicationArea = all;
                    ToolTip = 'Cheque No.';
                }
                field(ChequeDateControl; ChequeDate)
                {
                    Caption = 'Cheque Date';
                    Editable = ChequeDateControlEditable;
                    ApplicationArea = all;
                    ToolTip = 'Cheque Date';
                }

                group("Account No")
                {
                    Caption = 'Account No.';
                    field(ShowAll1; ShowAll)
                    {
                        Caption = 'Show All';
                        ApplicationArea = all;
                        tooltip = 'Show All';

                        trigger OnValidate();
                        begin
                            ShowAllOnAfterValidate();
                        end;
                    }
                }
                field(CurrentStatus1; CurrentStatus)
                {
                    Caption = 'Status';
                    OptionCaption = 'Open,Released';
                    Editable = false;
                    ApplicationArea = all;
                    tooltip = 'Status';
                }

            }
            repeater(Control1102152000)
            {
                field("Pay Salary"; "Pay Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pay salary';
                }
                field("Employee Code"; "Employee Code")
                {
                    Caption = 'Employee No';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Employee No.';
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Employee Name';
                }
                field("Gross Salary"; "Gross Salary")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Gross Salary';
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Cheque No.';
                }
                field(Deductions; Deductions)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Deductions';
                }
                field("Monthly Exp"; "Monthly Exp")
                {
                    ApplicationArea = all;
                    ToolTip = 'Monthly Exp';
                }
                field("Net Salary"; "Net Salary")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Net Salary';
                }
                field("Net Payable"; "Net Payable")
                {
                    ApplicationArea = all;
                    ToolTip = 'Net Payable';
                }
                field("Paid Amount"; "Paid Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Paid Employee';
                }
                field("Pay Amount"; "Pay Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pay amount';
                }
                field("Pay Method"; "Pay Method")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pay Method';
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Account Type';
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Account No.';
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Cheque Date';
                }

            }
            group(Postings)
            {
                Caption = 'Postings';
                field(TempBatch1; TempBatch)
                {
                    Caption = 'Journal Batch Name';
                    ApplicationArea = all;
                    tooltip = 'Journal Batch Name';

                    trigger OnLookup(Var Text: Text): Boolean;
                    var
                        NoSeries: Record "No. Series";
                    begin
                        JournalTemplate.SETRANGE("Form ID", 33001277);
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
                        if Not NoSeries.IsEmpty() then
                            "DocNo." := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series", WORKDATE());
                    end;
                }
                field(PostDate1; PostDate)
                {
                    Caption = 'PostDate';
                    ApplicationArea = all;
                    ToolTip = 'Posting date';
                }
                field("DocNo1."; "DocNo.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = all;
                    ToolTip = 'Document No.';
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
                action("Processed &Salary")
                {
                    Caption = 'Processed &Salary';
                    Image = AllocatedCapacity;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Processed Salary List B2B";
                    RunPageLink = "Employee Code" = FIELD("Employee Code"),
                                  Year = FIELD(Year),
                                  "Pay Slip Month" = FIELD("Pay Slip Month");
                    ApplicationArea = all;
                    ToolTip = 'Processed salary';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Dimensions';
                    trigger OnAction();
                    begin
                        ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Select All")
                {
                    Caption = 'Select All';
                    Image = Select;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Select All';
                    trigger OnAction()
                    var
                        SelectMonthly: Record "Monthly Attendance B2B";
                    begin
                        SelectMonthly.Reset();
                        SelectMonthly.SetRange(Year, CurrentYear);
                        SelectMonthly.SetRange("Pay Slip Month", CurrentMonth);
                        SelectMonthly.SetRange(Posted, true);
                        if SelectMonthly.FindSet() then
                            SelectMonthly.ModifyAll("Pay Salary", true, true);

                        CurrPage.Update(false);
                    end;
                }
                action("Un-Select All")
                {
                    Caption = 'Un-Select All';
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Un-Select All';
                    trigger OnAction()
                    var
                        UnSelectMonthly: Record "Monthly Attendance B2B";
                    begin
                        UnSelectMonthly.Reset();
                        UnSelectMonthly.SetRange(Year, CurrentYear);
                        UnSelectMonthly.SetRange("Pay Slip Month", CurrentMonth);
                        UnSelectMonthly.SetRange(Posted, true);
                        if UnSelectMonthly.FindSet() then
                            UnSelectMonthly.ModifyAll("Pay Salary", false, true);

                        CurrPage.Update(false);
                    end;
                }
                action("Release")
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Release';
                    trigger OnAction()
                    var
                        UnSelectMonthly: Record "Monthly Attendance B2B";
                    begin
                        UnSelectMonthly.Reset();
                        UnSelectMonthly.SetRange(Year, CurrentYear);
                        UnSelectMonthly.SetRange("Pay Slip Month", CurrentMonth);
                        UnSelectMonthly.SetRange(Posted, true);
                        if UnSelectMonthly.FindSet() then
                            UnSelectMonthly.ModifyAll(Status, UnSelectMonthly.Status::Released, true);

                        CurrPage.Update(false);
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Re-Open';
                    trigger OnAction()
                    var
                        UnSelectMonthly: Record "Monthly Attendance B2B";
                    begin
                        UnSelectMonthly.Reset();
                        UnSelectMonthly.SetRange(Year, CurrentYear);
                        UnSelectMonthly.SetRange("Pay Slip Month", CurrentMonth);
                        UnSelectMonthly.SetRange(Posted, true);
                        if UnSelectMonthly.FindSet() then
                            UnSelectMonthly.ModifyAll(Status, UnSelectMonthly.Status::Open, true);

                        CurrPage.Update(false);
                    end;
                }
                action("Update Amounts")
                {
                    Caption = 'Update Amounts';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Update Amounts';
                    trigger OnAction();
                    var
                        EmployeeRec: Record "Employee B2B";
                    begin
                        MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAttendance.SETRANGE(Year, CurrentYear);
                        MonAttendance.SETRANGE(Posted, true);
                        PayrollUsers.GET(USERID());
                        if PayrollUsers."Multiple Locations" <> '' then
                            MonAttendance.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                        else
                            MonAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                        if MonAttendance.FINDSET() then
                            repeat
                                EmployeeRec.Get(MonAttendance."Employee Code");
                                MonAttendance."Net Payable" := MonAttendance."Net Salary" + MonAttendance."Monthly Exp";
                                MonAttendance."Pay Amount" := MonAttendance."Net Payable";
                                MonAttendance."Pay Method" := EmployeeRec."Payment Method";
                                if MonAttendance."Pay Method" = MonAttendance."Pay Method"::"Bank Transfer" then
                                    MonAttendance."Account Type" := MonAttendance."Account Type"::"Bank Account";
                                if MonAttendance."Pay Method" = MonAttendance."Pay Method"::Cash then
                                    MonAttendance."Account Type" := MonAttendance."Account Type"::"G/L Account";
                                if MonAttendance."Pay Method" = MonAttendance."Pay Method"::Cheque then
                                    MonAttendance."Account Type" := MonAttendance."Account Type"::"Bank Account";
                                MonAttendance."Account No." := EmployeeRec."Bank/Cash Account";
                                MonAttendance.MODIFY();
                            until MonAttendance.NEXT() = 0;
                    end;
                }
                action("&Post Salary")
                {
                    Caption = '&Post Salary';
                    Image = Post;
                    ShortCutKey = 'F11';
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Post Salary';
                    trigger OnAction();
                    var
                        MonAttendance: Record "Monthly Attendance B2B";
                        PostSalary: Record "Posted Salary Details B2B";
                        GenJnlLine: Record "Gen. Journal Line";
                        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                        Amount: Decimal;

                    begin
                        MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAttendance.SETRANGE(Year, CurrentYear);
                        MonAttendance.SETRANGE(Posted, true);
                        PayrollUsers.GET(USERID());
                        if PayrollUsers."Multiple Locations" <> '' then
                            MonAttendance.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                        else
                            MonAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                        MonAttendance.SETFILTER("Pay Amount", '<>%1', 0);
                        MonAttendance.SetRange("Pay Salary", true);
                        if MonAttendance.FINDFIRST() then
                            repeat
                                MonAttendance.TestField(Status, MonAttendance.Status::Released);
                                Amount := MonAttendance."Pay Amount";
                                if Employee.GET(MonAttendance."Employee Code") then
                                    if not Employee."Stop Payment" then begin
                                        if MonAttendance."Pay Amount" <> 0 then begin
                                            GenJnlLine.INIT();
                                            GenJnlLine."Journal Template Name" := TempJournal;
                                            GenJnlLine."Journal Batch Name" := TempBatch;
                                            GenJnlLine."Document No." := "DocNo.";
                                            GenJnlLine."Line No." := MonAttendance."Line No.";
                                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                            Employee.SETRANGE("No.", MonAttendance."Employee Code");
                                            if Employee.FINDFIRST() then
                                                if EmpPostingGroup.GET(Employee."Emp Posting Group") then
                                                    GenJnlLine."Account No." := EmpPostingGroup."Salary Payable Acc.";

                                            GenJnlLine.VALIDATE("Account No.");
                                            GenJnlLine."Posting Date" := PostDate;
                                            GenJnlLine."Employee No. B2B" := MonAttendance."Employee Code";
                                            GenJnlLine.Description := CopyStr(MonAttendance."Employee Code" + ' ' + GenJnlLine.Description + ' ' + ReturnMonth(ProcessedSalary."Pay Slip Month") + ' ' + FORMAT(ProcessedSalary.Year), 1, 100);
                                            GenJnlLine."Bal. Account Type" := MonAttendance."Account Type";

                                            GenJnlLine."Bal. Account No." := MonAttendance."Account No.";
                                            GenJnlLine.VALIDATE("Bal. Account No.");
                                            GenJnlLine.Amount := Amount;
                                            GenJnlLine.VALIDATE(Amount);
                                            GenJnlLine."Source Code" := Text023Lbl;
                                            GenJnlLine."Dimension Set ID" := MonAttendance."Dimension Set ID";
                                            GenJnlLine."Shortcut Dimension 1 Code" := MonAttendance."Shortcut Dimension 1 Code";
                                            GenJnlLine."Shortcut Dimension 2 Code" := MonAttendance."Shortcut Dimension 2 Code";
                                            GenJnlPostLine.RunWithCheck(GenJnlLine);
                                        end;
                                        PostSalary.INIT();
                                        PostSalary."Employee Code" := MonAttendance."Employee Code";
                                        PostSalary.Month := MonAttendance."Pay Slip Month";
                                        PostSalary.Year := MonAttendance.Year;
                                        PostSalary."Posting Date" := PostDate;
                                        PostSalary."Document No" := "DocNo.";
                                        PostSalary."Net Salary" := MonAttendance."Net Salary";
                                        PostSalary."Salary Paid" := MonAttendance."Pay Amount";
                                        MonAttendance.CALCFIELDS("Gross Salary");
                                        PostSalary."Total Additions" := MonAttendance."Gross Salary";
                                        MonAttendance.CALCFIELDS(Deductions);
                                        PostSalary."Total Deductions" := MonAttendance.Deductions;
                                        PostSalary.INSERT();
                                        MonAttendance."Pay Amount" := 0;
                                        MonAttendance.MODIFY();
                                    end;
                            until MonAttendance.NEXT() = 0;
                        MESSAGE(Text009Lbl);

                        LastNoSeriseNo := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE(), true);
                    end;
                }
                action("<Action1102152008>")
                {
                    Caption = '&Pay Salary';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F11';
                    ApplicationArea = all;
                    ToolTip = 'Post';
                    trigger OnAction();
                    var
                        GenJnlLine: Record "Gen. Journal Line";
                        PostSalary: Record "Posted Salary Details B2B";
                        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                        TotalPaySalaryRevAmount: Decimal;
                        RecordCount: Integer;
                        TempAmount: Decimal;
                    begin
                        if CONFIRM(Text008Lbl) then begin
                            CLEAR(TotalPaySalaryRevAmount);
                            MonAttendance.RESET();
                            MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                            MonAttendance.SETRANGE(Year, CurrentYear);
                            MonAttendance.SETRANGE(Posted, true);
                            PayrollUsers.GET(USERID());
                            if PayrollUsers."Multiple Locations" <> '' then
                                MonAttendance.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                            else
                                MonAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                            MonAttendance.CALCFIELDS("Paid Amount");
                            if UnitCode <> '' then
                                MonAttendance.SETRANGE("Shortcut Dimension 1 Code", UnitCode);
                            if MonAttendance."Paid Amount" < MonAttendance."Net Salary" then
                                MonAttendance.SETFILTER("Paid Amount", '<%1', MonAttendance."Net Salary");
                            MonAttendance.SETFILTER("Pay Amount", '>%1', 0);
                            MonAttendance.SetRange("Pay Salary", true);
                            RecordCount := MonAttendance.COUNT();
                            if RecordCount > 0 then begin
                                if MonAttendance.FINDFIRST() then
                                    repeat
                                        MonAttendance.TestField(Status, MonAttendance.Status::Released);
                                        TempAmount := MonAttendance."Pay Amount";
                                        if Employee.GET(MonAttendance."Employee Code") then
                                            if not Employee."Stop Payment" then begin
                                                if MonAttendance."Pay Amount" <> 0 then begin
                                                    GenJnlLine.INIT();
                                                    GenJnlLine."Journal Template Name" := TempJournal;
                                                    GenJnlLine."Journal Batch Name" := TempBatch;
                                                    GenJnlLine."Document No." := "DocNo.";
                                                    GenJnlLine."Line No." := MonAttendance."Line No.";
                                                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                                    Employee.SETRANGE("No.", MonAttendance."Employee Code");
                                                    if Employee.FINDFIRST() then
                                                        if EmpPostingGroup.GET(Employee."Emp Posting Group") then
                                                            GenJnlLine."Account No." := EmpPostingGroup."Salary Payable Acc.";

                                                    GenJnlLine.VALIDATE("Account No.");
                                                    GenJnlLine."Posting Date" := PostDate;
                                                    GenJnlLine."Employee No. B2B" := MonAttendance."Employee Code";
                                                    GenJnlLine.Description := CopyStr(MonAttendance."Employee Code" + ' ' + MonAttendance."Employee Name" + ' ' + ReturnMonth(MonAttendance."Pay Slip Month") + ' ' + FORMAT(MonAttendance.Year), 1, 100);
                                                    GenJnlLine.Amount := TempAmount;
                                                    TotalPaySalaryRevAmount += TempAmount;
                                                    GenJnlLine.VALIDATE(Amount);
                                                    GenJnlLine."Source Code" := Text023Lbl;
                                                    GenJnlLine."Dimension Set ID" := MonAttendance."Dimension Set ID";
                                                    GenJnlLine."Shortcut Dimension 1 Code" := MonAttendance."Shortcut Dimension 1 Code";
                                                    GenJnlLine."Shortcut Dimension 2 Code" := MonAttendance."Shortcut Dimension 2 Code";
                                                    GenJnlPostLine.RunWithCheck(GenJnlLine);
                                                end;
                                                PostSalary.INIT();
                                                PostSalary."Employee Code" := MonAttendance."Employee Code";
                                                PostSalary.Month := MonAttendance."Pay Slip Month";
                                                PostSalary.Year := MonAttendance.Year;
                                                PostSalary."Posting Date" := PostDate;
                                                PostSalary."Document No" := "DocNo.";
                                                PostSalary."Net Salary" := MonAttendance."Net Salary";
                                                PostSalary."Salary Paid" := MonAttendance."Pay Amount";
                                                MonAttendance.CALCFIELDS("Gross Salary");
                                                PostSalary."Total Additions" := MonAttendance."Gross Salary";
                                                MonAttendance.CALCFIELDS(Deductions);
                                                PostSalary."Total Deductions" := MonAttendance.Deductions;
                                                case MonAttendance."Pay Method" of
                                                    MonAttendance."Pay Method"::Cash:
                                                        begin
                                                            PostSalary."Account Type" := PostSalary."Account Type"::"G/L Account";
                                                            PostSalary."Account No." := MonAttendance."Account No.";
                                                        end;
                                                    MonAttendance."Pay Method"::Cheque:
                                                        begin
                                                            PostSalary."Account Type" := PostSalary."Account Type"::"Bank Account";
                                                            PostSalary."Account No." := MonAttendance."Account No.";
                                                            PostSalary."Cheque No." := ChequeNo;
                                                            PostSalary."Cheque Date" := ChequeDate;
                                                        end;
                                                    MonAttendance."Pay Method"::"Bank Transfer":
                                                        begin
                                                            PostSalary."Account Type" := PostSalary."Account Type"::"Bank Account";
                                                            PostSalary."Account No." := MonAttendance."Account No.";
                                                        end;
                                                end;
                                                if MonAttendance."Pay Amount" <> 0 then
                                                    PostSalary.INSERT();
                                                MonAttendance.CALCFIELDS("Paid Amount");
                                                MonAttendance."Net Payable" := MonAttendance."Net Salary" - MonAttendance."Paid Amount";
                                                MonAttendance."Remaining Amount" := MonAttendance."Net Salary" - MonAttendance."Paid Amount";
                                                MonAttendance."Pay Amount" := 0;
                                                MonAttendance.MODIFY();
                                            end;
                                    until MonAttendance.NEXT() = 0;
                                GenJnlLine.INIT();
                                GenJnlLine."Journal Template Name" := TempJournal;
                                GenJnlLine."Journal Batch Name" := TempBatch;
                                GenJnlLine."Document No." := "DocNo.";
                                GenJnlLine."Line No." := MonAttendance."Line No.";
                                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                GenJnlLine."Posting Date" := PostDate;
                                GenJnlLine.Description := CopyStr(
                                MonAttendance."Employee Code" + ' ' + GenJnlLine.Description + ' ' +
                                 ReturnMonth(MonAttendance."Pay Slip Month") + ' ' +
                                 FORMAT(MonAttendance.Year), 1, 100);
                                case MonAttendance."Pay Method" of
                                    MonAttendance."Pay Method"::Cash:
                                        begin
                                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                            GenJnlLine."Account No." := MonAttendance."Account No.";
                                        end;
                                    MonAttendance."Pay Method"::Cheque:
                                        begin
                                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                                            GenJnlLine."Account No." := MonAttendance."Account No.";
                                        end;
                                    MonAttendance."Pay Method"::"Bank Transfer":
                                        begin
                                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                                            GenJnlLine."Account No." := MonAttendance."Account No.";
                                        end;
                                end;
                                GenJnlLine.VALIDATE("Account No.");
                                GenJnlLine.Amount := -TotalPaySalaryRevAmount;
                                GenJnlLine.VALIDATE(Amount);
                                GenJnlLine."Source Code" := Text023Lbl;
                                GenJnlLine."Dimension Set ID" := MonAttendance."Dimension Set ID";
                                GenJnlLine."Shortcut Dimension 1 Code" := MonAttendance."Shortcut Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code" := MonAttendance."Shortcut Dimension 2 Code";
                                GenJnlPostLine.RunWithCheck(GenJnlLine);
                                LastNoSeriseNo := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE(), true);
                                MESSAGE(Text009Lbl);
                            end;
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Previous)
            {
                Caption = 'Previous';
                Image = PreviousSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ToolTip = 'Previous';
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
                Caption = 'Next';
                Image = NextSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ToolTip = 'Next';
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
        }
    }

    trigger OnInit();
    begin
        ChequeDateControlEditable := true;
        ChequeNoControlEditable := true;
        ChequeDate := 0D;
        ChequeNo := '';
        UnitCode := '';
    end;

    trigger OnOpenPage();
    begin
        if HRSetup.FINDFIRST() then begin
            CurrentYear := HRSetup."Salary Processing Year";
            CurrentMonth := HRSetup."Salary Processing month";
        end;

        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        SelectYear();
        SelectMonth();
        SelectPayCadre();
        SelectStatus();

        if PaymentMethod = PaymentMethod::Cheque then begin
            ChequeNoControlEditable := true;
            ChequeDateControlEditable := true;
        end else begin
            ChequeNoControlEditable := false;
            ChequeDateControlEditable := false;
        end;
    end;

    var
        Lookup_B2B: Record Lookup_B2B;
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        Navigate: Record "Monthly Attendance B2B";
        JournalTemplate: Record "Payroll Journal Template B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        MonAttendance: Record "Monthly Attendance B2B";

        NoSeriesMgt: Codeunit 396;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";

        Text002Lbl: Label 'There are no records with in these filters.';

        CurrentCadre: Code[30];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        CurrentStatus: Option Open,Released;

        Month: Integer;
        ShowAll: Boolean;
        TempBatch: Code[10];
        TempJournal: Code[10];
        "DocNo.": Code[20];
        PostDate: Date;
        LastNoSeriseNo: Code[20];

        Text008Lbl: Label 'Do you want to Post';
        PaymentMethod: Option " ",Cash,Cheque,"Bank Transfer";

        UnitCode: Code[20];
        PayAccountNo: Code[20];

        ChequeNo: Code[20];
        ChequeDate: Date;
        [InDataSet]
        ChequeNoControlEditable: Boolean;
        [InDataSet]
        ChequeDateControlEditable: Boolean;

        Text009Lbl: Label 'Salary Payment Successfully Completed';
        Text010Lbl: Label 'PAY CADRE';
        Text023Lbl: Label 'PAYMENTJNL';

    procedure SelectYear();
    begin
        RESET();
        SETRANGE(Year, CurrentYear);
        SETRANGE(Posted, true);

        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        CurrPage.UPDATE(false);
    end;

    procedure SelectStatus();
    var
        CheckStatusMonthly: Record "Monthly Attendance B2B";
    begin
        CheckStatusMonthly.Reset();
        CheckStatusMonthly.SetRange(Posted, true);
        CheckStatusMonthly.SetRange(Year, CurrentYear);
        CheckStatusMonthly.SetRange("Pay Slip Month", CurrentMonth);
        CheckStatusMonthly.SetRange(Status, CheckStatusMonthly.Status::Open);
        if not CheckStatusMonthly.IsEmpty() then
            CurrentStatus := CurrentStatus::Open
        else
            CurrentStatus := CurrentStatus::Released;

        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    var

    begin
        RESET();
        SETRANGE("Pay Slip Month", CurrentMonth);
        SETRANGE(Posted, true);

        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

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
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        SETRANGE(PayCadre, CurrentCadre);
        SETRANGE(Posted, true);
        CurrPage.UPDATE(false);
    end;

    procedure ReturnMonth(Month: Integer): Code[31];
    var
        DateRec: Record date;
    begin
        DateRec.Reset();
        DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
        DateRec.SetRange("Period No.", CurrentMonth);
        if DateRec.FindFirst() then
            exit(DateRec."Period Name");
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        SelectYear();
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        SelectMonth();
    end;

    local procedure CurrentCadreOnAfterValidate();
    begin
        SelectPayCadre();
    end;

    local procedure ShowAllOnAfterValidate();
    begin
        if ShowAll then begin
            Rec.RESET();
            SelectYear();
            SelectMonth();
        end else begin
            SelectYear();
            SelectMonth();
            SelectPayCadre();
            PaymentMethodOnAfterValidate();
        end;
    end;

    local procedure PaymentMethodOnAfterValidate();
    begin
        if PaymentMethod = PaymentMethod::Cheque then begin
            ChequeNoControlEditable := true;
            ChequeDateControlEditable := true;
        end else begin
            ChequeNoControlEditable := false;
            ChequeDateControlEditable := false;
        end;
        case PaymentMethod of
            PaymentMethod::"Bank Transfer":
                SetRange("Pay Method", "Pay Method"::"Bank Transfer");
            PaymentMethod::Cash:
                SetRange("Pay Method", "Pay Method"::Cash);
            PaymentMethod::Cheque:
                SetRange("Pay Method", "Pay Method"::Cheque);
        end;

        CurrPage.UPDATE(false);
    end;
}

