page 33001526 "Pay Arrear Salary B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Pay Arrear Salary';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Monthly Attendance B2B";
    SourceTableView = SORTING("Employee Code", "Pay Slip Month", Year, "Line No.")
                      WHERE("Gross Salary" = FILTER(<> 0));
    ApplicationArea = all;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentYear1; CurrentYear)
                {
                    ToolTip = 'Enter the year for Arrear Salary.';
                    Caption = 'Year';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    ToolTip = 'Enter the Month for Arrear Salary.';
                    Caption = 'Month';
                    ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field(UnitCode1; UnitCode)
                {
                    ToolTip = 'Enter the Branch code.';
                    CaptionClass = '1,1,1';
                    Caption = 'Units';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UnitCodeOnAfterValidate();
                    end;
                }
                field(PaymentMethod1; PaymentMethod)
                {
                    ToolTip = 'Choose the Payment method for arrear Payment ex.Cash, Cheque or Transfer.';
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
                field(CurrentCadre1; CurrentCadre)
                {
                    ToolTip = 'choose the Pay cadre from drop down.';
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
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Choose the Dimension Values from drop down.';
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Choose the Dimension Values from drop down.';
                    ApplicationArea = all;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    ToolTip = 'Shows the Bank account Number of the Employee.';
                    ApplicationArea = all;
                }
                field("Arrear Additions"; "Arrear Additions")
                {
                    ToolTip = 'Shows the Arrear addition Amount earned by employee.';
                    ApplicationArea = all;
                }
                field("Arrear Deductions"; "Arrear Deductions")
                {
                    ToolTip = 'Shows the Arrear Deductions Amount earned by employee.';
                    ApplicationArea = all;
                }
                field("Arrear Net Amount"; "Arrear Net Amount")
                {
                    ToolTip = 'Shows the Arrear Net Amount earned by the employee.';
                    ApplicationArea = all;
                }
                field("Arrear Amt Payable"; "Arrear Amt Payable")
                {
                    ToolTip = 'Arrear Amount Payable to employee.';
                    ApplicationArea = all;
                }
                field("Arrear Amt Paid"; "Arrear Amt Paid")
                {
                    ToolTip = 'Shows the Amount paid to the Employee.';
                    ApplicationArea = all;
                }
                field("Arrear Amt Pay"; "Arrear Amt Pay")
                {
                    ToolTip = 'Shows Arrear Amount to Pay';
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
                    ToolTip = 'Specifies the processed salary of employee.';
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
                }
                action("&Dimensions")
                {
                    ToolTip = 'Specifies the Dimensions of the employees.';
                    Caption = '&Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Default Dimensions";
                    /*RunPageLink = "Table ID"=CONST(33001218),
                                  "No."=FIELD("Employee Code"),
                                  "Dimension Code"=FIELD("Pay Slip Month"),
                                  "Dimension Value Code"=FIELD(Year);*///Phani
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                }
            }
        }
        area(processing)
        {
            action(Previous)
            {
                ToolTip = 'Goes to previous month.';
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
                ToolTip = 'on clicking goes to next month.';
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
                Image = "Action";
                action("Update Amounts")
                {
                    ToolTip = 'On clicking  it updates the amount.';
                    Caption = 'Update Amounts';
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        MonAttendanceRec.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAttendanceRec.SETRANGE(Year, CurrentYear);
                        if UnitCode <> '' then
                            MonAttendanceRec.SETRANGE("Shortcut Dimension 1 Code", UnitCode);
                        MonAttendanceRec.SETRANGE(Posted, true);
                        if MonAttendanceRec.FINDFIRST() then
                            repeat
                                MonAttendanceRec.CALCFIELDS("Arrear Additions");
                                MonAttendanceRec.CALCFIELDS("Arrear Deductions");
                                MonAttendanceRec."Arrear Net Amount" := MonAttendanceRec."Arrear Additions" - MonAttendanceRec."Arrear Deductions";
                                MonAttendanceRec."Arrear Amt Payable" := MonAttendanceRec."Arrear Net Amount" - MonAttendanceRec."Arrear Amt Paid";
                                MonAttendanceRec."Arrear Amt Pay" := MonAttendanceRec."Arrear Amt Payable";
                                MonAttendanceRec.MODIFY();
                            until MonAttendanceRec.NEXT() = 0;
                    end;
                }
                action("&Post Salary")
                {
                    ToolTip = 'On clicking it post the salary to General Ledger.';
                    Caption = '&Post Salary';
                    Image = PostedPayment;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        MonAttendance: Record "Monthly Attendance B2B";
                        PostSalary: Record "Posted Salary Details B2B";
                        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                        TempAmount: Decimal;
                        RecordCount: Integer;
                    begin
                        CLEAR(TotalPaySalaryRevAmount);
                        MonAttendance.RESET();
                        MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAttendance.SETRANGE(Year, CurrentYear);
                        MonAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                        if UnitCode <> '' then
                            MonAttendance.SETRANGE("Shortcut Dimension 1 Code", UnitCode);
                        if MonAttendance."Arrear Amt Paid" < MonAttendance."Arrear Net Amount" then
                            MonAttendance.SETFILTER("Arrear Amt Paid", '<%1', MonAttendance."Arrear Net Amount");
                        if PaymentMethod <> 0 then
                            MonAttendance.SETRANGE("Pay Method", PaymentMethod - 1);
                        MonAttendance.SETFILTER("Arrear Amt Pay", '>%1', 0);
                        RecordCount := MonAttendance.COUNT();
                        if RecordCount > 0 then begin
                            if MonAttendance.FINDFIRST() then
                                repeat
                                    TempAmount := MonAttendance."Arrear Amt Pay";
                                    if Employee.GET(MonAttendance."Employee Code") then
                                        if not Employee."Stop Payment" then begin
                                            if MonAttendance."Arrear Amt Pay" <> 0 then begin
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
                                                Employee.SETRANGE("No.", MonAttendance."Employee Code");
                                                if Employee.FINDFIRST() then
                                                    if EmpPostingGroup.GET(Employee."Emp Posting Group") then
                                                        GenJnlLine."Account No." := EmpPostingGroup."Arrear Salary Payable Acc.";

                                                GenJnlLine.VALIDATE("Account No.");
                                                GenJnlLine."Shortcut Dimension 1 Code" := MonAttendance."Shortcut Dimension 1 Code";
                                                GenJnlLine."Posting Date" := PostDate;
                                                GenJnlLine.Description := CopyStr(
                                                  Text33003Lbl + ' ' + MonAttendance."Employee Code" + ' ' + MonAttendance."Employee Name" + ' ' +
                                                   ReturnMonth(MonAttendance."Pay Slip Month") + ' ' +
                                                   FORMAT(MonAttendance.Year), 1, 100);
                                                GenJnlLine.Amount := TempAmount;
                                                TotalPaySalaryRevAmount += TempAmount;
                                                GenJnlLine.VALIDATE(Amount);
                                                GenJnlLine."Source Code" := Text33002Lbl;
                                                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", MonAttendance."Shortcut Dimension 1 Code");
                                                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", MonAttendance."Shortcut Dimension 2 Code");
                                                GenJnlLine."Dimension Set ID" := MonAttendance."Dimension Set ID";
                                                GenJnlPostLine.RunWithCheck(GenJnlLine);
                                            end;

                                            PostSalary.INIT();
                                            PostSalary."Employee Code" := MonAttendance."Employee Code";
                                            PostSalary.Month := MonAttendance."Pay Slip Month";
                                            PostSalary.Year := MonAttendance.Year;
                                            PostSalary."Posting Date" := PostDate;
                                            PostSalary."Document No" := "DocNo.";
                                            PostSalary."Net Arrear Amount" := MonAttendance."Arrear Net Amount";
                                            PostSalary."Arrear Salary paid" := MonAttendance."Arrear Amt Pay";
                                            MonAttendance.CALCFIELDS("Arrear Additions");
                                            PostSalary."Net Arrear Amount" := MonAttendance."Arrear Additions";
                                            MonAttendance.CALCFIELDS("Arrear Deductions");
                                            PostSalary."Arrear Salary paid" := MonAttendance."Arrear Deductions";
                                            case PaymentMethod of
                                                PaymentMethod::Cash:
                                                    begin
                                                        PostSalary."Account Type" := PostSalary."Account Type"::"G/L Account";
                                                        PostSalary."Account No." := PayAccountNo;
                                                    end;
                                                PaymentMethod::Cheque:
                                                    begin
                                                        PostSalary."Account Type" := PostSalary."Account Type"::"Bank Account";
                                                        PostSalary."Account No." := PayAccountNo;
                                                    end;
                                                PaymentMethod::"Bank Transfer":
                                                    begin
                                                        PostSalary."Account Type" := PostSalary."Account Type"::"Bank Account";
                                                        PostSalary."Account No." := PayAccountNo;
                                                    end;
                                            end;
                                            PostSalary."Cheque No." := ChequeNo;
                                            PostSalary."Cheque Date" := ChequeDate;
                                            if MonAttendance."Arrear Amt Pay" <> 0 then
                                                PostSalary.INSERT();
                                            MonAttendance."Arrear Amt Payable" := MonAttendance."Arrear Amt Payable" - MonAttendance."Arrear Amt Paid";
                                            MonAttendance."Remaining Arrear Amt" := MonAttendance."Net Salary" - MonAttendance."Paid Amount";
                                            MonAttendance."Arrear Amt Pay" := 0;
                                            if MonAttendance."Arrears Included" then begin
                                                ProcessedSalArrear.RESET();
                                                ProcessedSalArrear.SETRANGE(Posted, true);
                                                ProcessedSalArrear.SETRANGE("Employee Code", MonAttendance."Employee Code");
                                                ProcessedSalArrear.SETFILTER("Pay Slip Month", '<=%1', MonAttendance."Pay Slip Month");
                                                ProcessedSalArrear.SETFILTER(Year, '<=%1', MonAttendance.Year);
                                                ProcessedSalArrear.SETRANGE("Arrears Not Posted", true);
                                                if ProcessedSalArrear.FINDFIRST() then
                                                    repeat
                                                        ProcessedSalArrear."Arrears Not Posted" := false;
                                                        ProcessedSalArrear.MODIFY();
                                                    until ProcessedSalArrear.NEXT() = 0;

                                            end;

                                            MonAttendance.MODIFY();

                                        end;
                                until MonAttendance.NEXT() = 0;

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
                            GenJnlLine.Description := CopyStr(Text33003Lbl +
                            MonAttendance."Employee Code" + ' ' + GenJnlLine.Description + ' ' +
                             ReturnMonth(MonAttendance."Pay Slip Month") + ' ' +
                             FORMAT(MonAttendance.Year), 1, 100);
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
                            GenJnlLine.VALIDATE(Amount);
                            GenJnlLine."Source Code" := Text33002Lbl;
                            GenJnlPostLine.RunWithCheck(GenJnlLine);
                            LastNoSeriseNo := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE(), true);
                            MESSAGE(Text0001Lbl);
                        end;
                        BankAccLegdEnt.RESET();
                        BankAccLegdEnt.SETRANGE("Document No.", "DocNo.");
                        if BankAccLegdEnt.FINDLAST() then begin
                            BankAccLegdEnt."Bal. Account No." := EmpPostingGroup."Arrear Salary Payable Acc.";
                            BankAccLegdEnt.MODIFY();
                        end;
                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        ChequeDateControlEditable := true;
        ChequeNoControlEditable := true;
    end;

    trigger OnOpenPage();
    var
        PayrollUsers: Record "Payroll Location Users B2B";
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

        if PaymentMethod = PaymentMethod::"Bank Transfer" then begin
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
        GenJnlLine: Record "Gen. Journal Line";
        NoSeries: Record "No. Series";
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        MonAttendanceRec: Record "Monthly Attendance B2B";
        GenJnlLineRec: Record "Gen. Journal Line";
        BankAccLegdEnt: Record "Bank Account Ledger Entry";
        ProcessedSalArrear: Record "Processed Salary B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        NoSeriesMgt: Codeunit 396;
        TempBatch: Code[10];
        TempJournal: Code[10];
        "DocNo.": Code[20];
        Text002Lbl: Label 'There are no records with in these filters.';
        CurrentCadre: Code[30];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Month: Integer;
        ShowAll: Boolean;
        PostDate: Date;
        LastNoSeriseNo: Code[20];
        PaymentMethod: Option " ",Cash,Cheque,"Bank Transfer";
        UnitCode: Code[20];
        PayAccountNo: Code[20];
        TotalPaySalaryRevAmount: Decimal;
        ChequeNo: Code[20];
        ChequeDate: Date;
        [InDataSet]
        ChequeNoControlEditable: Boolean;
        [InDataSet]
        ChequeDateControlEditable: Boolean;
        Text0001Lbl: Label 'Arrear Salary Payment Successfully Completed';
        Text33001Lbl: Label 'PAY CADRE';
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
        Text33002Lbl: Label 'PAYMENTJNL';
        Text33003Lbl: Label 'Arrear';

    procedure SelectYear();
    begin
        FILTERGROUP(2);
        SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        SETFILTER("Arrear Additions", '<>%1', 0);
        SETRANGE(Year, CurrentYear);
        SETRANGE(Posted, true);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    var
    begin
        FILTERGROUP(2);
        SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        SETRANGE("Pay Slip Month", CurrentMonth);
        SETRANGE(Posted, true);
        SETFILTER("Arrear Additions", '<>%1', 0);
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
        SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        SETRANGE(PayCadre, CurrentCadre);
        SETRANGE(Posted, true);
        SETFILTER("Arrear Additions", '<>%1', 0);
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
        SETFILTER("Arrear Additions", '<>%1', 0);
        CurrPage.UPDATE(false);
    end;

    procedure SelectUnitCode();
    begin
        RESET();
        SelectMonth();
        SelectYear();
        if UnitCode <> '' then
            SETRANGE("Shortcut Dimension 1 Code", UnitCode);
        SETFILTER("Arrear Additions", '<>%1', 0);
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
        if PaymentMethod <> 0 then begin
            SETRANGE("Pay Method", PaymentMethod - 1);
            SETFILTER("Gross Salary", '<>%1', 0);
        end;

        if PaymentMethod = PaymentMethod::"Bank Transfer" then begin
            ChequeNoControlEditable := true;
            ChequeDateControlEditable := true;
        end else begin
            ChequeNoControlEditable := false;
            ChequeDateControlEditable := false;
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

