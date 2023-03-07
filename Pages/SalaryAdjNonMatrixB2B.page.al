page 33001537 "Salary Adj. Non Matrix B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Adjustment Non Matrix';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Salary Adjustment B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentMonth1; CurrentMonth)
                {
                    ToolTip = 'Choose the Month Salary Adjustment.';
                    Caption = 'Month';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field(CurrentYear1; CurrentYear)
                {
                    ToolTip = 'Choose the year for Salary adjustment.';
                    Caption = 'Year';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrLocation1; CurrLocation)
                {
                    ToolTip = 'Choose the Location for salary adjustment.';
                    Caption = 'Location';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PayLoc.RESET();
                        if PAGE.RUNMODAL(0, PayLoc) = ACTION::LookupOK then
                            CurrLocation := PayLoc."Location Code";

                        CheckEmployees();
                    end;

                    trigger OnValidate();
                    begin
                        CurrLocationOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102152015)
            {
                field("Employee No"; "Employee No")
                {
                    ToolTip = 'Choose the Employee No. for Salary Adjustment.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Show the Employee name when Employee No. Selected.';
                    ApplicationArea = all;
                }
                field("Salary Adj. Code"; "Salary Adj. Code")
                {
                    ToolTip = 'Choose the Salary adjustment code.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ToolTip = 'Enter the Amount to be adjusted.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Select the Month of Salary adjustment.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Select the Year of Salary adjustment.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("G/L Account"; "G/L Account")
                {
                    ToolTip = 'Choose the G/l Account number to Which Salary adjustment posted.';
                    ApplicationArea = all;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field(TempBatch1; TempBatch)
                {
                    ToolTip = 'Choose the Bacth name for posting Salary Adjustment.';
                    Caption = 'Journal Batch Name';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        JournalTemplate.SETRANGE("Form ID", 33001537);
                        if JournalTemplate.FINDFIRST() then
                            JournalBatch.RESET();
                        JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                        if PAGE.RUNMODAL(33001274, JournalBatch) = ACTION::LookupOK then begin
                            TempBatch := JournalBatch.Name;
                            TempJournal := JournalBatch."Journal Template Name";
                            PostDate := workdate();
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
                    ToolTip = 'Enter the Posting Date for posting Salary Adjustment.';
                    Caption = 'Posting Date';
                    ApplicationArea = all;
                }
                field("DocNo1."; "DocNo.")
                {
                    ToolTip = 'Enter the Document no.';
                    Caption = 'Document No.';
                    ApplicationArea = all;
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
                action("Get &Employees")
                {
                    ToolTip = ' Get the list of employees.';
                    Caption = 'Get &Employees';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        GetEmployees();
                    end;
                }
                action(Post)
                {
                    ToolTip = 'on clciking it post the document.';
                    Caption = 'Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        Text001Lbl: Label 'Do you want to post?';
                    begin
                        if CONFIRM(Text001Lbl) then
                            PostSalaryAdjustments();

                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        if HrSetup.GET() then begin
            CurrentMonth := HrSetup."Salary Processing month";
            CurrentYear := HrSetup."Salary Processing Year";
        end;
        Employee.RESET();
        Employee.SETRANGE("User Id", USERID());
        if Employee.FINDFIRST() then
            CurrLocation := Employee."Location Code"
        else
            ERROR(Text001Lbl);

        CheckEmployees();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        SalaryAdjust.RESET();
        SalaryAdjust.SETRANGE(Year, CurrentYear);
        SalaryAdjust.SETRANGE(Month, CurrentMonth);
        SalaryAdjust.SETRANGE("Location Code", CurrLocation);
        SalaryAdjust.SETFILTER(Amount, '=%1', 0);
        SalaryAdjust.DELETEALL();
    end;

    var
        NoSeries: Record "No. Series";
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        HrSetup: Record "HR Setup B2B";
        SalaryAdjust: Record "Salary Adjustment B2B";
        Employee: Record "Employee B2B";
        PayLoc: Record "Payroll Locations B2B";
        NoSeriesMgt: Codeunit 396;
        CheckDate: Date;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        CurrLocation: Code[30];
        TempBatch: Code[10];
        TempJournal: Code[10];
        PostDate: Date;
        "DocNo.": Code[20];
        Text001Lbl: Label 'This UserID  is  not assaigned to any of the Employee';
        Text002Lbl: Label 'CurrentMonth And CurrentYear Can not be zero';
        Text003Lbl: Label 'Year should be equal to Setup Year';
        Text004Lbl: Label 'Month should be between 1 and 12';
        Text005Lbl: Label 'Employee #1#################', Comment = '%1 = No';
        Text33001Lbl: Label '<1M>';
        Text33002Lbl: Label 'SalAdjust';
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
        Text33003Lbl: Label '<1M-1D>';

    procedure PostSalaryAdjustments();
    var
        PostedSalaryAdj: Record "Posted Salary Adjustments B2B";
        Window: Dialog;
    begin
        ReprocessCheck();

        Window.OPEN(Text005Lbl);
        SalaryAdjust.RESET();
        SalaryAdjust.SETRANGE(Month, CurrentMonth);
        SalaryAdjust.SETRANGE(Year, CurrentYear);
        SalaryAdjust.SETRANGE("Location Code", CurrLocation);
        if SalaryAdjust.FINDFIRST() then
            repeat
                Window.UPDATE(1, SalaryAdjust."Employee No");
                if SalaryAdjust.Amount <> 0 then
                    SalaryAdjGenJnlLine(SalaryAdjust, SalaryAdjust."G/L Account", SalaryAdjust.Amount);

            until SalaryAdjust.NEXT() = 0;
        Window.CLOSE();

        SalaryAdjust.RESET();
        SalaryAdjust.SETRANGE(Month, CurrentMonth);
        SalaryAdjust.SETRANGE(Year, CurrentYear);
        SalaryAdjust.SETRANGE("Location Code", CurrLocation);
        if SalaryAdjust.FINDFIRST() then
            repeat
                PostedSalaryAdj.INIT();
                PostedSalaryAdj.TRANSFERFIELDS(SalaryAdjust);
                PostedSalaryAdj."Posting Date" := PostDate;
                PostedSalaryAdj.INSERT();
            until SalaryAdjust.NEXT() = 0;

        SalaryAdjust.RESET();
        SalaryAdjust.SETRANGE(Month, CurrentMonth);
        SalaryAdjust.SETRANGE(Year, CurrentYear);
        SalaryAdjust.SETRANGE("Location Code", CurrLocation);
        SalaryAdjust.DELETEALL();
    end;

    procedure ReprocessCheck();
    var
        ProcessedSalary: Record "Processed Salary B2B";
        PostedSalaryAdj: Record "Posted Salary Adjustments B2B";
        NextDate: Date;
        PeriodStartDate: Date;
        Text111Lbl: Label 'Salary cannot be adjusted as Salary has been Processed for the Month %1 and Year %2', Comment = '%1 =  Month; %2 = Year';
        Text112Lbl: Label 'Salary adjustment exists for the present month';
    begin
        PeriodStartDate := DMY2DATE(1, CurrentMonth, CurrentYear);
        NextDate := CALCDATE(Text33001Lbl, PeriodStartDate);
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Pay Slip Month", DATE2DMY(NextDate, 2));
        ProcessedSalary.SETRANGE(Year, DATE2DMY(NextDate, 3));
        if not ProcessedSalary.IsEmpty() then
            ERROR(Text111Lbl, DATE2DMY(NextDate, 2), DATE2DMY(NextDate, 3));

        PostedSalaryAdj.RESET();
        PostedSalaryAdj.SETFILTER(Year, '>=%1', CurrentYear);
        PostedSalaryAdj.SETFILTER(Month, '>=%1', CurrentMonth);
        SalaryAdjust.SETRANGE("Location Code", CurrLocation);
        if not PostedSalaryAdj.IsEmpty() then
            ERROR(Text112Lbl);
    end;

    procedure SalaryAdjGenJnlLine(SalAdjustment: Record "Salary Adjustment B2B"; "AccountNo.": Code[20]; Amount: Decimal);
    var
        GenJournalLine: Record "Gen. Journal Line";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        if Employee.GET(SalAdjustment."Employee No") then
            GenJournalLine.INIT();
        GenJournalLine."Journal Template Name" := TempJournal;
        GenJournalLine."Journal Batch Name" := TempBatch;
        GenJournalLine."Document No." := "DocNo.";
        GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := "AccountNo.";
        GenJournalLine.VALIDATE("Account No.");
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        Employee.SETRANGE("No.", SalAdjustment."Employee No");
        if Employee.FINDFIRST() then begin
            EmpPostingGroup.GET(Employee."Emp Posting Group");
            GenJournalLine."Bal. Account No." := EmpPostingGroup."Salary Payable Acc.";
        end;
        GenJournalLine.VALIDATE("Bal. Account No.");
        GenJournalLine."Posting Date" := PostDate;
        GenJournalLine.Description := CopyStr(
            SalAdjustment."Employee No" + ' ' + GenJournalLine.Description + ' ' +
            ReturnMonth(SalAdjustment.Month) + ' ' +
            FORMAT(SalAdjustment.Year), 1, 100);
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine."Source Code" := Text33002Lbl;

        GenJnlPostLine.RunWithCheck(GenJournalLine);
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

    procedure CheckEmployees();
    begin
        if (CurrentMonth = 0) or (CurrentYear = 0) then
            ERROR(Text002Lbl);
        RESET();
        SETRANGE(Month, CurrentMonth);
        SETRANGE(Year, CurrentYear);
        if CurrLocation <> '' then
            SETRANGE("Location Code", CurrLocation);
    end;

    procedure GetEmployees();
    var
        SalaryAdjst: Record "Salary Adjustment B2B";
        SalaryAdjSetup: Record "Salary Adjustment Setup B2B";
        SalaryAdjstCheck: Record "Salary Adjustment B2B";
    begin
        if (CurrentMonth = 0) or (CurrentYear = 0) then
            ERROR(Text002Lbl);
        CheckDate := DMY2DATE(1, CurrentMonth, CurrentYear);
        CheckDate := CALCDATE(Text33003Lbl, CheckDate);

        Employee.RESET();
        Employee.SETRANGE(Blocked, false);
        Employee.SETFILTER("Employment Date", '<%1', CheckDate);
        if CurrLocation <> '' then
            Employee.SETRANGE("Location Code", CurrLocation);
        if Employee.FINDFIRST() then
            repeat
                SalaryAdjSetup.RESET();
                SalaryAdjSetup.SETRANGE(Active, true);
                if SalaryAdjSetup.FINDFIRST() then
                    repeat
                        SalaryAdjst.INIT();
                        SalaryAdjst."Employee No" := Employee."No.";
                        SalaryAdjst.Month := CurrentMonth;
                        SalaryAdjst.Year := CurrentYear;
                        SalaryAdjst."Location Code" := CurrLocation;
                        SalaryAdjst."G/L Account" := SalaryAdjSetup."G/L Account";
                        SalaryAdjst."Employee Name" := Employee."First Name";
                        SalaryAdjst."Salary Adj. Code" := SalaryAdjSetup.Code;
                        SalaryAdjstCheck.RESET();
                        SalaryAdjstCheck.SETRANGE("Employee No", Employee."No.");
                        SalaryAdjstCheck.SETRANGE(Month, CurrentMonth);
                        SalaryAdjstCheck.SETRANGE(Year, CurrentYear);
                        SalaryAdjstCheck.SETRANGE("Location Code", CurrLocation);
                        SalaryAdjstCheck.SETRANGE("Salary Adj. Code", SalaryAdjSetup.Code);
                        if SalaryAdjstCheck.IsEmpty() then
                            SalaryAdjst.INSERT();
                    until SalaryAdjSetup.NEXT() = 0;
            until Employee.NEXT() = 0;

    end;

    local procedure CurrLocationOnAfterValidate();
    begin
        CheckEmployees();
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        if CurrentYear <> HrSetup."Salary Processing Year" then
            ERROR(Text003Lbl);
        CheckEmployees();
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        if (CurrentMonth < 0) or (CurrentMonth > 12) then
            ERROR(Text004Lbl);
        CheckEmployees();
    end;
}

