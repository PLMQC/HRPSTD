page 33001265 "Bonus/Exgratia Adjustment B2B"
{
    // version B2BHR1.00.00

    Caption = 'Bonus/Exgratia Adjustment';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Bonus Adjust B2B";
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
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee bonus in bonus adjustment';

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee bonus month in bonus year';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102152000)
            {
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee code in bonus list';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee name in bonus list';
                }
                field("Bonus/Exgratia Amt"; "Bonus/Exgratia Amt")
                {
                    Caption = 'Bonus Amt';
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise bonus amount in bonus list';
                }
                field("Exgratia Amt"; "Exgratia Amt")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise exgratia amount in exgratia list ';
                }
                field("Adv. Bonus"; "Adv. Bonus")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise adv bonus in bonus list';
                }
                field("Arrear Bonus"; "Arrear Bonus")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise areear bonus in bonus list';
                }
                field("Arrear Exgratia"; "Arrear Exgratia")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise arrear exgratia in bonus list';
                }
                field("Additional Bonus"; "Additional Bonus")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise additional bonus in bonus list';
                }
                field(Adjustments; Adjustments)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise adjustments in bonus list';
                }
                field("Net Payable"; "Net Payable")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise net payable amount in bonus';
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field(TempBatch1; TempBatch)
                {
                    Caption = 'Journal Batch Name';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Temporary Batch';
                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        JournalTemplate.RESET();
                        JournalTemplate.SETRANGE("Form ID", 33001265);
                        if JournalTemplate.FINDFIRST() then begin
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
                    end;
                }
                field(PostDate1; PostDate)
                {
                    Caption = 'PostDate';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Posting Date ';
                }
                field("DocNo.1"; "DocNo.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Document No.';
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
                    RunObject = Page "Bonus Dimensions B2B";
                    RunPageLink = "Employee Code" = FIELD("Employee Code"),
                                  Month = FIELD(Month),
                                  Year = FIELD(Year),
                                  "Bonus Line No." = FIELD("Line No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    tooltip = 'Dimensions';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate Amounts")
                {
                    Caption = 'Calculate Amounts';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Calculate Amounts';
                    trigger OnAction();
                    begin
                        BonusRec.RESET();
                        BonusRec.SETRANGE(Month, Month);
                        BonusRec.SETRANGE(Year, Year);
                        BonusRec.SETFILTER(BonusRec."Bonus/Exgratia Amt", '<>%1', 0);
                        if BonusRec.FINDFIRST() then
                            ERROR(Text011Lbl);
                        BonusRec.RESET();
                        BonusRec.SETRANGE(Month, Month);
                        BonusRec.SETRANGE(Year, Year);
                        BonusRec.SETFILTER("Exgratia Amt", '<>%1', 0);
                        if BonusRec.FINDFIRST() then
                            ERROR(Text012Lbl);
                        BonusCalc.GetMonthAndYear(CurrentMonth, CurrentYear);
                        BonusCalc.RUN();
                        SelectYear();
                        SelectMonth();
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Update Amount")
                {
                    Caption = 'Update Amount';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    tooltip = 'Update Amount';
                    trigger OnAction();
                    begin
                        if Posted then
                            ERROR(Text013Lbl);
                        if FINDFIRST() then
                            repeat
                                "Net Payable" := "Bonus/Exgratia Amt" + "Exgratia Amt" + "Additional Bonus";
                                Updated := true;
                                MODIFY();
                            until NEXT() = 0;
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Print';
                    trigger OnAction();
                    begin
                        BonusRegister.GetMonthandYear(CurrentMonth, CurrentYear);
                        BonusRegister.RUN();
                    end;
                }
                separator(Separator1102154012)
                {
                }
                action(Post)
                {
                    Caption = 'Post';
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
                        SalaryPost();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        if HRSetup.FINDFIRST() then begin
            CurrentYear := HRSetup."Salary Processing Year";
            CurrentMonth := HRSetup."Salary Processing month";
        end;
        SelectYear();
        SelectMonth();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        BonusRec: Record "Bonus Adjust B2B";
        NoSeries: Record "No. Series";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        Employee: Record "Employee B2B";
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        BonusRegister: Report "Bonus Register B2B";
        BonusCalc: Report "Bonus Calculation B2B";
        NoSeriesMgt: Codeunit 396;
        CurrentMonth: Integer;
        CurrentYear: Integer;


        TempBatch: Code[10];
        TempJournal: Code[10];
        "DocNo.": Code[20];
        PostDate: Date;
        LastNoSeriseNo: Code[20];

        Window: Dialog;
        Text005Lbl: Label 'Bonus Posted';
        Text007Lbl: Label '"Employee No..... #1######################\ "', Comment = '%1 = Employe No.';
        Text008Lbl: Label 'Do you want to Post';

        Text011Lbl: Label 'Amounts are already Calculated';
        Text012Lbl: Label 'Amounts are already Calculated';
        Text013Lbl: Label 'Records Are Already Posted';

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

    procedure SalaryPost();
    var
        Flag: Boolean;
    begin
        if CONFIRM(Text008Lbl) then begin
            BonusRec.RESET();
            BonusRec.SETRANGE(Month, CurrentMonth);
            BonusRec.SETRANGE(Year, CurrentYear);
            BonusRec.SETRANGE(Updated, false);
            if BonusRec.FINDFIRST() then
                ERROR(Text008Lbl);
            Window.OPEN(Text007Lbl);
            if FINDFIRST() then
                repeat
                    Employee.SETRANGE("No.", "Employee Code");
                    Employee.SETRANGE(Blocked, false);
                    if Employee.FINDFIRST() then begin
                        Employee.TESTFIELD(Employee."Emp Posting Group");
                        Employee.TESTFIELD(Employee."Payroll Bus. Posting Group");
                    end;
                    EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
                    if EmpPostingGroup.FINDFIRST() then
                        EmpPostingGroup.TESTFIELD("Bonus Payable Acc.");

                until NEXT() = 0;
            BonusRec.RESET();
            BonusRec.SETRANGE(Month, CurrentMonth);
            BonusRec.SETRANGE(Year, CurrentYear);
            BonusRec.SETRANGE(Posted, false);
            if BonusRec.FINDFIRST() then
                repeat
                    BonusRec."Journal Batch Name" := TempBatch;
                    BonusRec."Document No." := "DocNo.";
                    BonusRec."Journal Template Name" := TempJournal;
                    BonusRec."Posting Date" := PostDate;
                    BonusRec.MODIFY();
                    PostRecords11(BonusRec);
                    Window.UPDATE(1, BonusRec."Employee Code");
                    BonusRec.Posted := true;
                    BonusRec.MODIFY();
                until BonusRec.NEXT() = 0;
            "DocNo." := '';
            BonusRec.SETRANGE(Month, CurrentMonth);
            BonusRec.SETRANGE(Year, CurrentYear);
            if BonusRec.FINDFIRST() then
                repeat
                    if BonusRec.Posted = false then
                        Flag := true;
                until BonusRec.NEXT() = 0;
            if not Flag then
                MESSAGE(Text005Lbl);
            Window.CLOSE();
            LastNoSeriseNo := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE(), true);
        end;
        SelectYear();
        SelectMonth();
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        SelectYear();
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        SelectMonth();
    end;
}

