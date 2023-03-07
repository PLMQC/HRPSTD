
page 33001407 "PayRevision Payment Jou B2B"
{
    Caption = 'PayRevision Payment Journal';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = 33001237;
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
                    ToolTip = 'Year';
                    trigger OnValidate()
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    //ValuesAllowed = 1;2;3;4;5;6;7;8;9;10;11;12;
                    ApplicationArea = all;
                    ToolTip = 'Month';
                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The location code';
                }
                field(PaymentMethod1; PaymentMethod)
                {
                    Caption = 'Payment Method';
                    OptionCaption = ' ,Cash,Cheque,Bank Transfer';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The payment method';
                    trigger OnValidate()
                    begin
                        PaymentMethodOnAfterValidate();
                    end;
                }
                field(PayAccountNo1; PayAccountNo)
                {
                    Caption = 'Pay Account No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The account no';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        GLAccount: Record 15;
                        BankAccount: Record 270;
                    begin
                        CASE PaymentMethod OF
                            PaymentMethod::Cash:
                                BEGIN
                                    GLAccount.RESET();
                                    IF PAGE.RUNMODAL(0, GLAccount) = ACTION::LookupOK THEN
                                        PayAccountNo := GLAccount."No.";
                                END;
                            PaymentMethod::"Bank Transfer":
                                BEGIN
                                    BankAccount.RESET();
                                    IF PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK THEN
                                        PayAccountNo := BankAccount."No.";
                                END;
                            PaymentMethod::Cheque:
                                BEGIN
                                    BankAccount.RESET();
                                    IF PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK THEN
                                        PayAccountNo := BankAccount."No.";
                                END;
                        END;
                    end;
                }
                field(ChequeNoControl1; ChequeNo)
                {
                    Caption = 'Cheque No.';
                    Editable = ChequeNoControlEditable;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Cheque no';
                }
                field(ChequeDateControl1; ChequeDate)
                {
                    Caption = 'Cheque Date';
                    Editable = ChequeDateControlEditable;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The cheque date';
                }
                field(DeptGVar1; DeptGVar)
                {
                    Caption = 'Department Code';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                    ApplicationArea = all;
                    ToolTip = 'Specifies The department code';

                }
                field("Check Amount"; ChequeAmount)
                {
                    Caption = 'Check Amount';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The check amount';

                }
                field(Amounts1; Amounts)
                {
                    Caption = 'Amounts';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The amounts';
                }
            }
            repeater(Revision)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The No';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee name';
                }
                field(Grade; Grade)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Grade';
                }
                field("Gross Arrear Amount"; ArrearAmount)
                {
                    Caption = 'Gross Arrear Amount';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Gross arrear amount';
                }
                field(Deductions1; Deductions)
                {
                    Caption = 'Deductions';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The deductions';
                }
                field("Net Arrear"; ArrearAmount - Deductions)
                {
                    Caption = 'Net Arrear';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The net arrear';
                }
                field("Pay Amount"; "Pay Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Pay amount';
                }
                /*
                field("Revision ID"; "Revision ID")
                {
                }*/
                field(Post; Post)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Post';
                }
                field("Payment Posted"; "Payment Posted")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Payment posted';
                }
            }
            group(Postings)
            {
                Caption = 'Postings';
                field(TempBatch1; TempBatch)
                {
                    Caption = 'Journal Batch Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The journal batch';
                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        JournalTemplate.SETRANGE("Form ID", 33001277);
                        IF JournalTemplate.FINDFIRST() THEN BEGIN
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                            IF PAGE.RUNMODAL(PAGE::"Payroll Journal Batch B2B", JournalBatch) = ACTION::LookupOK THEN BEGIN
                                TempBatch := JournalBatch.Name;
                                TempJournal := JournalBatch."Journal Template Name";
                                PostDate := TODAY();
                            END;
                        END;
                        JournalBatch.SETRANGE(Name, TempBatch);
                        IF JournalBatch.FINDFIRST() THEN
                            NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                        IF NoSeries.FINDFIRST() THEN
                            DocNo := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series", WORKDATE());
                        //DocNo :=  NoSeriesMgt.GetNextNo(NoSeries.Code,WORKDATE,TRUE);
                    end;
                }
                field(PostDate1; PostDate)
                {
                    Caption = 'Posting Date';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The date';
                }
                field(DocNo1; DocNo)
                {
                    Caption = 'Document No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The document no';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Navigate11")
            {
                Caption = 'Navigation';
                Image = Change;
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
                    trigger OnAction()
                    begin
                        IF CurrentMonth = 1 THEN
                            Year := CurrentYear - 1
                        ELSE
                            Year := CurrentYear;

                        IF CurrentMonth = 1 THEN
                            Month := 12
                        ELSE
                            Month := CurrentMonth - 1;

                        Navigate.SETRANGE(Year, Year);
                        Navigate.SETRANGE("Pay Slip Month", Month);
                        IF Navigate.FINDFIRST() THEN BEGIN
                            CurrentYear := Year;
                            CurrentMonth := Month;
                            SelectYear();
                            SelectMonth();
                        END ELSE
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
                    trigger OnAction()
                    begin
                        IF CurrentMonth = 12 THEN
                            Year := CurrentYear + 1
                        ELSE
                            Year := CurrentYear;

                        IF CurrentMonth = 12 THEN
                            Month := 1
                        ELSE
                            Month := CurrentMonth + 1;

                        Navigate.SETRANGE(Year, Year);
                        Navigate.SETRANGE("Pay Slip Month", Month);
                        IF Navigate.FINDFIRST() THEN BEGIN
                            CurrentYear := Year;
                            CurrentMonth := Month;
                            SelectYear();
                            SelectMonth();
                        END ELSE
                            ERROR(Text002Lbl);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Pay Salary Action")
                {
                    Caption = '&Pay Arrears';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The post';
                    trigger OnAction()
                    begin
                        PostArrears();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        CLEAR(ArrearAmount);
        CLEAR(Deductions);

        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Revision ID", "Revision ID");
        IF PayRevisionLine.FINDSET() then
            REPEAT
                IF PayRevisionLine."Add/Deduct" = PayRevisionLine."Add/Deduct"::Addition THEN
                    ArrearAmount += PayRevisionLine."Arrear Amount"
                ELSE
                    Deductions += PayRevisionLine."Arrear Amount";
            UNTIL PayRevisionLine.NEXT() = 0;

    end;

    trigger OnInit()
    begin
        ChequeDateControlEditable := TRUE;
        ChequeNoControlEditable := TRUE;
    end;

    trigger OnOpenPage()
    var
        PayrevisionHeader1: Record "Pay Revision Header B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
    begin
        CLEAR(ArrearAmount);
        CLEAR(Deductions);

        PayRevisionHeader1.Reset();
        PayrevisionHeader1.SetRange(Posted, true);
        PayRevisionHeader1.SetRange("Payment Posted", false);
        PayrevisionHeader1.SetRange("Pay Amount", 0);
        if PayrevisionHeader1.FindSet() then
            repeat
                CLEAR(ArrearAmount);
                CLEAR(Deductions);
                PayRevisionLine.RESET();
                PayRevisionLine.SETRANGE(PayRevisionLine."Header No.", PayrevisionHeader1."Id.");
                IF PayRevisionLine.FINDSET() THEN
                    REPEAT
                        IF PayRevisionLine."Add/Deduct" = PayRevisionLine."Add/Deduct"::Addition THEN
                            ArrearAmount += PayRevisionLine."Arrear Amount"
                        ELSE
                            Deductions += PayRevisionLine."Arrear Amount";
                    UNTIL PayRevisionLine.NEXT() = 0;
                PayrevisionHeader1."Pay Amount" := ArrearAmount - Deductions;
                PayrevisionHeader1.MODIFY();
            until PayrevisionHeader1.Next() = 0;

        IF HRSetup.FINDFIRST() THEN BEGIN
            CurrentYear := HRSetup."Salary Processing Year";
            CurrentMonth := HRSetup."Salary Processing Month";
        END;

        FILTERGROUP(2);
        SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());

        FILTERGROUP(0);

        SelectYear();
        SelectMonth();
        SETRANGE("Payment Posted", FALSE);
        SETRANGE(Posted, TRUE);
        IF PaymentMethod = PaymentMethod::Cheque THEN BEGIN
            ChequeNoControlEditable := TRUE;
            ChequeDateControlEditable := TRUE;
        END ELSE BEGIN
            ChequeNoControlEditable := FALSE;
            ChequeDateControlEditable := FALSE;
        END;
    end;

    var
        HRSetup: Record 33001190;
        Employee: Record 33001193;
        EmpPostingGroup: Record 33001248;
        Navigate: Record 33001218;
        GenJnlLine: Record 81;
        NoSeries: Record 308;
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record 33001251;
        PayrollUsers: Record 33001363;
        PayRevisionHeader: Record 33001237;
        Employee2: Record 33001193;
        PayRevisionLine: Record 33001238;
        NoSeriesMgt: Codeunit 396;

        GenJnlPostLine: Codeunit 12;
        Text002Lbl: Label 'There are no records with in these filters.';
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Month: Integer;
        Year: Integer;
        ShowAll: Boolean;
        TempBatch: Code[10];
        TempJournal: Code[10];
        DocNo: Code[20];
        PostDate: Date;
        LastNoSeriseNo: Code[20];
        PaymentMethod: Option " ",Cash,Cheque,"Bank Transfer";
        PayAccountNo: Code[20];
        TotalPaySalaryRevAmount: Decimal;
        ChequeNo: Code[20];
        ChequeDate: Date;
        RecordCount: Integer;
        TempAmount: Decimal;

        [InDataSet]
        ChequeNoControlEditable: Boolean;
        [InDataSet]
        ChequeDateControlEditable: Boolean;
        Text009Lbl: Label 'Salary payment successfully completed.';
        Text010Lbl: Label 'Do you want to Post?';
        DeptGVar: Code[20];
        ArrearAmount: Decimal;
        Deductions: Decimal;
        ChequeAmount: Decimal;
        Amounts: Decimal;


    procedure SelectYear()
    var
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";

    begin
        RESET();
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        IF PayrollUsers."Multiple Locations" <> '' THEN
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        ELSE
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());

        FILTERGROUP(0);
        CurrPage.UPDATE(FALSE);
    end;


    procedure SelectMonth()
    begin
        /*
        RESET();
        SETRANGE(Year,CurrentYear);
        SETRANGE(Month,CurrentMonth);
        SETRANGE("Salary Adjustment Code",'LEAVE ENCASHMENT');
        
        
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        IF PayrollUsers.MultipleLocations<> '' THEN
          SETFILTER("Location Code",PayrollUsers.MultipleLocations)
         ELSE
          SETRANGE("Location Code",LocWiseMiscGCU.ReturnUserLocationCode());
        
        FILTERGROUP(0);
        CurrPage.UPDATE(FALSE);
        */

    end;


    procedure SelectStartingDate()
    begin
    end;


    procedure SelectEndingDate()
    begin
    end;


    procedure ReturnMonth(Month: Integer): Code[20]
    var
        Text33011Txt: Label 'Jan';
        Text33012Txt: Label 'Febuary';
        Text33013Txt: Label 'March';
        Text33014Txt: Label 'April';
        Text33015Txt: Label 'May';
        Text33016Txt: Label 'June';
        Text33017Txt: Label 'July';
        Text33018Txt: Label 'August';
        Text33019Txt: Label 'Septmeber';
        Text33020Txt: Label 'October';
        Text33021Txt: Label 'November';
        Text33022Txt: Label 'December';
    begin
        case Month of
            1:
                exit(Text33011Txt);
            2:
                exit(Text33012Txt);
            3:
                exit(Text33013Txt);
            4:
                exit(Text33014Txt);
            5:
                exit(Text33015Txt);
            6:
                exit(Text33016Txt);
            7:
                exit(Text33017Txt);
            8:
                exit(Text33018Txt);
            9:
                exit(Text33019Txt);
            10:
                exit(Text33020Txt);
            11:
                exit(Text33021Txt);
            12:
                exit(Text33022Txt);
        end;
    end;

    local procedure CurrentYearOnAfterValidate()
    begin
        SelectYear();
    end;

    local procedure CurrentMonthOnAfterValidate()
    begin
        SelectMonth();
    end;


    local procedure ShowAllOnAfterValidate()
    begin
        IF ShowAll THEN BEGIN
            Rec.RESET();
            SelectYear();
            SelectMonth();

        END ELSE BEGIN
            SelectYear();
            SelectMonth();
        END;
    end;

    local procedure PaymentMethodOnAfterValidate()
    begin
        /*
        IF PaymentMethod <> 0 THEN
          SETRANGE("Pay Method",PaymentMethod-1);
        CurrPAGE.UPDATE(FALSE);
        */
        IF PaymentMethod = PaymentMethod::Cheque THEN BEGIN
            ChequeNoControlEditable := TRUE;
            ChequeDateControlEditable := TRUE;
        END ELSE BEGIN
            ChequeNoControlEditable := FALSE;
            ChequeDateControlEditable := FALSE;
        END;
        CurrPage.UPDATE(FALSE);

    end;


    local procedure PostArrears()
    var
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
    begin
        IF CONFIRM(Text010Lbl) THEN BEGIN
            CLEAR(TotalPaySalaryRevAmount);
            IF PaymentMethod = PaymentMethod::Cheque THEN
                IF ChequeNo = '' THEN
                    ERROR('Cheque No. must not be empty');

            PayRevisionHeader.RESET();
            PayRevisionHeader.SETRANGE(Post, TRUE);
            PayRevisionHeader.SETRANGE(Posted, TRUE);
            PayRevisionHeader.SETRANGE("Payment Posted", FALSE);
            PayrollUsers.GET(USERID());
            IF PayrollUsers."Multiple Locations" <> '' THEN
                PayRevisionHeader.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
            ELSE
                PayRevisionHeader.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            RecordCount := PayRevisionHeader.COUNT();

            IF RecordCount > 0 THEN BEGIN
                IF PayRevisionHeader.FINDFIRST() then
                    REPEAT
                        TempAmount := PayRevisionHeader."Pay Amount";
                        IF Employee.GET(PayRevisionHeader."No.") THEN
                            IF NOT Employee."Stop Payment" THEN BEGIN
                                IF PayRevisionHeader."Pay Amount" <> 0 THEN BEGIN
                                    GenJnlLine.INIT();
                                    GenJnlLine."Journal Template Name" := TempJournal;
                                    GenJnlLine."Journal Batch Name" := TempBatch;
                                    GenJnlLine."Document No." := DocNo;
                                    //GenJnlLine."Line No." := PayRevisionHeader."Line No.";
                                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                    Employee.SETRANGE("No.", PayRevisionHeader."No.");
                                    IF Employee.FINDFIRST() THEN
                                        IF EmpPostingGroup.GET(Employee."Emp Posting Group") THEN
                                            GenJnlLine."Account No." := EmpPostingGroup."Salary Payable Acc.";

                                    GenJnlLine.VALIDATE("Account No.");
                                    GenJnlLine."Posting Date" := PostDate;
                                    GenJnlLine."Employee No. B2B" := PayRevisionHeader."No.";
                                    //GenJnlLine."Salary Payment" := TRUE;
                                    //GenJnlLine."Payment Completed" := PaymentCompleted;
                                    GenJnlLine.Description :=
                                      "No." + ' ' + "Employee Name" + ' ' +
                                       ReturnMonth(Month) + ' ' +
                                       FORMAT(Year);

                                    GenJnlLine.Amount := TempAmount;
                                    TotalPaySalaryRevAmount += TempAmount;
                                    GenJnlLine.VALIDATE(Amount);
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    Employee2.GET(PayRevisionHeader."No.");
                                    //GenJnlLine."Responsibility Center" := Employee2."Responsibility Center";//GR1.0
                                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", Employee2."Global Dimension 1 Code");
                                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", Employee2."Global Dimension 2 Code");
                                    GenJnlLine."Dimension Set ID" := PayRevisionHeader."Dimension Set ID";

                                    GenJnlPostLine.RunWithCheck(GenJnlLine);
                                END;
                                PayRevisionHeader."Payment Posted" := TRUE;
                                PayRevisionHeader.MODIFY();
                            END;
                    UNTIL PayRevisionHeader.NEXT() = 0;


                GenJnlLine.INIT();
                GenJnlLine."Journal Template Name" := TempJournal;
                GenJnlLine."Journal Batch Name" := TempBatch;
                GenJnlLine."Document No." := DocNo;
                //GenJnlLine."Line No." := "Line No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Posting Date" := PostDate;
                GenJnlLine.Description := CopyStr(
                "No." + ' ' + GenJnlLine.Description + ' ' +
                ReturnMonth(Month) + ' ' +
                FORMAT(Year), 1, 100);

                CASE PaymentMethod OF
                    PaymentMethod::Cash:
                        BEGIN
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No." := PayAccountNo;
                        END;
                    PaymentMethod::Cheque:
                        BEGIN
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                            GenJnlLine."Account No." := PayAccountNo;
                        END;
                    PaymentMethod::"Bank Transfer":
                        BEGIN
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                            GenJnlLine."Account No." := PayAccountNo;
                        END;
                END;

                GenJnlLine.VALIDATE("Account No.");
                GenJnlLine.Amount := -TotalPaySalaryRevAmount;
                GenJnlLine.VALIDATE(Amount);
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                Employee2.GET("No.");
                //Employee2.TESTFIELD("Responsibility Center");
                //GenJnlLine."Responsibility Center" := Employee2."Responsibility Center";//GR1.0
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", Employee2."Global Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", Employee2."Global Dimension 2 Code");
                GenJnlLine."Dimension Set ID" := PayRevisionHeader."Dimension Set ID";

                IF ChequeNo <> '' THEN
                    GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Manual Check";


                GenJnlPostLine.RunWithCheck(GenJnlLine);

                LastNoSeriseNo := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE(), TRUE);
                CLEAR(TempBatch);
                CLEAR(PostDate);
                CLEAR(DocNo);
                MESSAGE(Text009Lbl);
            END;
        END;
    end;
}

