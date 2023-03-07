page 33001451 "Salary Adjustment Card B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Adjustment';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Matrix Options';
    SaveValues = true;
    SourceTable = "Employee B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Month; CurrentMonth)
                {
                    Caption = 'Month';
                    ToolTip = 'Choose the Month.';
                    ApplicationArea = all;
                }
                field(Year; CurrentYear)
                {
                    ToolTip = 'Choose the year.';
                    Caption = 'Year';
                    ApplicationArea = all;
                }
                field(Location; CurrLocation)
                {
                    ToolTip = 'Specifies the Location.';
                    Caption = 'Location';
                    ApplicationArea = all;
                }
                field("Show Column Name"; ShowColumnName)
                {
                    ToolTip = 'Choose the Coloum name.';
                    Caption = 'Show Column Name';
                    ApplicationArea = all;
                }
            }
            group(Postings)
            {
                Caption = 'Postings';
                field("Journal Batch Name"; TempBatch)
                {
                    ToolTip = 'Choose the Journal Batch name.';
                    Caption = 'Journal Batch Name';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin

                        JournalTemplate.SETRANGE("Form ID", 33001451);
                        if JournalTemplate.FINDFIRST() then
                            JournalBatch.RESET();
                        JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                        if PAGE.RUNMODAL(PAGE::"Payroll Journal Batch B2B", JournalBatch) = ACTION::LookupOK then begin
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
                field("Posting Date"; PostDate)
                {
                    ToolTip = 'Choose the Posting date for the journal to post.';
                    Caption = 'Posting Date';
                    ApplicationArea = all;
                }
                field("Document No."; "DocNo.")
                {
                    ToolTip = 'Choose the Document Number.';
                    Caption = 'Document No.';
                    ApplicationArea = all;
                }
            }
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
                field(MATRIXCaptionRange1; MATRIXCaptionRange)
                {
                    Caption = 'Column Set';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Matrix Options in Leave Applicability';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Matrix Related")
            {
                Caption = 'Matrix Related';
                action(ShowMatrix)
                {
                    ToolTip = 'Specifies the Matrix.';
                    Caption = 'Show Matrix';
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        SalaryAdjustMents: Page "Salary Adjustment Matrix B2B";
                    begin
                        SalaryAdjustMents.Load(MATRIXCaptionSet, MatrixRecords, MatrixRecord, CurrentMonth, CurrentYear, CurrLocation);
                        SalaryAdjustMents.SETRECORD(Rec);
                        SalaryAdjustMents.RUNMODAL();
                    end;
                }
                action("Next Set")
                {
                    ToolTip = 'Specifies the Next set.';
                    Caption = 'Next Set';
                    Image = NextSet;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        SetColumns(MATRIXSetWanted::Next);
                    end;
                }
                action("Previous Set")
                {
                    ToolTip = 'Specifies the previous Set.';
                    Caption = 'Previous Set';
                    Image = PreviousSet;

                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        SetColumns(MATRIXSetWanted::Previous);
                    end;
                }
            }
        }
        area(processing)
        {
            group(Posting)
            {
                ToolTip = 'Specifies the posting of document.';
                Caption = 'Posting';
                action(Post)
                {
                    ToolTip = 'Specifies the post of the document.';
                    Caption = 'Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;

                    trigger OnAction();
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
        SelectLocation();
        // if CurrLocation = '' then
        //     ERROR(Text002Lbl, USERID());

        SetColumns(MATRIXSetWanted::Initial);
    end;

    var
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        MatrixRecord: Record "Salary Adjustment Setup B2B";
        Employee: Record "Employee B2B";
        SalaryAdjustmentSetup: Record "Salary Adjustment Setup B2B";
        NoSeries: Record "No. Series";
        MatrixRecords: array[32] of Record "Salary Adjustment Setup B2B";
        SalaryAdjust: Record "Salary Adjustment B2B";
        TDSDeductions: Record "TDS Deductions B2B";
        NoSeriesMgt: Codeunit 396;
        DimMgt: Codeunit DimensionManagement;
        MatrixRecordRef: RecordRef;
        MATRIXSetWanted: Option Initial,Previous,Same,Next;
        ShowColumnName: Boolean;
        MATRIXCaptionSet: array[32] of Text[1024];
        MATRIXCaptionRange: Text;
        MATRIXPKFirstRecInCurrSet: Text;
        MATRIXCurrSetLength: Integer;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        TempJournal: Code[10];
        TempBatch: Code[10];
        "DocNo.": Code[20];
        PostDate: Date;
        Text001Lbl: Label 'Do you want to post?';
        CurrLocation: Code[20];
        Text002Lbl: Label 'No Location is defined for %1', Comment = '%1 =UserId ';
        Text003Lbl: Label 'Employee #1#################', Comment = '%1 = No';
        Text33001Lbl: Label 'Jan';
        Text33002Lbl: Label 'Febuary';
        Text33003Lbl: Label 'March';
        Text33004Lbl: Label 'April';
        Text33005Lbl: Label 'May';
        Text33006Lbl: Label 'June';
        Text33007Lbl: Label 'July';
        Text33008Lbl: Label 'August';
        Text33009Lbl: Label 'Septmeber';
        Text33010Lbl: Label 'October';
        Text33011Lbl: Label 'November';
        Text33012Lbl: Label 'December';
        Text33013Lbl: Label 'SalAdjust';
        Text33014Lbl: Label '<1M>';

    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next);
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        CLEAR(MATRIXCaptionSet);
        CLEAR(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GETTABLE(MatrixRecord);
        MatrixRecordRef.SETTABLE(MatrixRecord);

        if ShowColumnName then
            CaptionFieldNo := MatrixRecord.FIELDNO(Description)
        else
            CaptionFieldNo := MatrixRecord.FIELDNO(Code);

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, SetWanted, ARRAYLEN(MatrixRecords), CaptionFieldNo, MATRIXPKFirstRecInCurrSet,
          MATRIXCaptionSet, MATRIXCaptionRange, MATRIXCurrSetLength);

        if MATRIXCurrSetLength > 0 then begin
            MatrixRecord.SETPOSITION(MATRIXPKFirstRecInCurrSet);
            MatrixRecord.FIND();
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MatrixRecord);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MATRIXCurrSetLength) or (MatrixRecord.NEXT() <> 1);
        end;
    end;

    local procedure ShowColumnNameOnAfterValidate();
    begin
        SetColumns(MATRIXSetWanted::Same);
    end;

    local procedure ShowInTransitOnAfterValidate();
    begin
        SetColumns(MATRIXSetWanted::Initial);
    end;

    procedure SelectLocation();
    begin

        FILTERGROUP(2);
        Rec.SETRANGE(Blocked, false);
        FILTERGROUP(0);
    end;

    procedure PostSalaryAdjustments();
    var
        PostedSalaryAdj: Record "Posted Salary Adjustments B2B";
        Window: Dialog;
    begin
        ReprocessCheck();

        Window.OPEN(Text003Lbl);
        SalaryAdjust.RESET();
        SalaryAdjust.SETRANGE(Month, CurrentMonth);
        SalaryAdjust.SETRANGE(Year, CurrentYear);
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
        if SalaryAdjust.FINDFIRST() then
            repeat
                SalaryAdjustmentSetup.RESET();
                SalaryAdjustmentSetup.SETRANGE(Code, SalaryAdjust."Salary Adj. Code");
                SalaryAdjustmentSetup.SETRANGE(Perk, true);
                if SalaryAdjustmentSetup.FINDFIRST() then begin
                    TDSDeductions.RESET();
                    TDSDeductions.SETRANGE("Emp ID", SalaryAdjust."Employee No");
                    TDSDeductions.SETFILTER("Financial Year Start Date", '<=%1', DMY2DATE(1, CurrentMonth, CurrentYear));
                    TDSDeductions.SETFILTER("Financial Year End Date", '>=%1', DMY2DATE(1, CurrentMonth, CurrentYear));
                    if TDSDeductions.FINDFIRST() then begin
                        TDSDeductions.Perks += SalaryAdjust.Amount;
                        TDSDeductions.MODIFY();
                    end;
                end;

            until SalaryAdjust.NEXT() = 0;

        SalaryAdjust.RESET();
        SalaryAdjust.SETRANGE(Month, CurrentMonth);
        SalaryAdjust.SETRANGE(Year, CurrentYear);
        SalaryAdjust.DELETEALL();
    end;

    procedure ReturnMonth(Month: Integer): Code[20];
    begin
        case Month of
            1:
                exit(Text33001Lbl);
            2:
                exit(Text33002Lbl);
            3:
                exit(Text33003Lbl);
            4:
                exit(Text33004Lbl);
            5:
                exit(Text33005Lbl);
            6:
                exit(Text33006Lbl);
            7:
                exit(Text33007Lbl);
            8:
                exit(Text33008Lbl);
            9:
                exit(Text33009Lbl);
            10:
                exit(Text33010Lbl);
            11:
                exit(Text33011Lbl);
            12:
                exit(Text33012Lbl);
        end;

    end;

    procedure SalaryAdjGenJnlLine(SalAdjustment: Record "Salary Adjustment B2B"; "AccountNo.": Code[20]; Amount: Decimal);
    var
        GenJournalLine: Record "Gen. Journal Line";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        Employee.GET(SalAdjustment."Employee No");
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
        GenJournalLine."Source Code" := Text33013Lbl;

        TableID[1] := DATABASE::"Employee B2B";
        No[1] := SalAdjustment."Employee No";
        GenJournalLine."Dimension Set ID" := DimMgt.GetDefaultDimID(TableID, No, '',
                                             GenJournalLine."Shortcut Dimension 1 Code", GenJournalLine."Shortcut Dimension 1 Code", 0, 0);
        GenJnlPostLine.RunWithCheck(GenJournalLine);
    end;

    procedure ReprocessCheck();
    var
        ProcessedSalary: Record "Processed Salary B2B";
        PostedSalaryAdj: Record "Posted Salary Adjustments B2B";
        Text111Lbl: Label 'Salary cannot be adjusted as Salary has been Processed for the Month %1 and Year %2', Comment = '%1 = MonthDate ; %2 = yearDate';
        Text112Lbl: Label 'Salary adjustment exists for the present month';
        NextDate: Date;
        PeriodStartDate: Date;
    begin
        PeriodStartDate := DMY2DATE(1, CurrentMonth, CurrentYear);
        NextDate := CALCDATE(Text33014Lbl, PeriodStartDate);
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Pay Slip Month", DATE2DMY(NextDate, 2));
        ProcessedSalary.SETRANGE(Year, DATE2DMY(NextDate, 3));
        if not ProcessedSalary.IsEmpty() then
            ERROR(Text111Lbl, DATE2DMY(NextDate, 2), DATE2DMY(NextDate, 3));

        PostedSalaryAdj.RESET();
        PostedSalaryAdj.SETFILTER(Year, '>=%1', CurrentYear);
        PostedSalaryAdj.SETFILTER(Month, '>=%1', CurrentMonth);
        if not PostedSalaryAdj.IsEmpty() then
            ERROR(Text112Lbl);
    end;
}

