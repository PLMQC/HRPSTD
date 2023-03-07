page 33001455 "Posted Final Settlement B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Final Settlement';
    PageType = Document;
    SourceTable = "Final Settlement Header B2B";
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Employee No."; "Employee No.")
                {
                    ToolTip = '"Specifies the employee numbar from the drill down "';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if "Employee No." = '' then
                            "Employee Name" := '';
                    end;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the emlopee name against the employee number';
                    ApplicationArea = all;
                }
                field("Attended Days"; "Attended Days")
                {
                    ToolTip = 'Specifies the number of attendence days in final settlement';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specifies the month of the final settlement';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Speciifes the year of teh final settelement';
                    ApplicationArea = all;
                }
                field("Date of Leaving"; "Date of Leaving")
                {
                    ToolTip = 'Specifies the date of leaving in final settlement card';
                    ApplicationArea = all;
                }

                field("Notice Period Last Date"; "Notice Period Last Date")
                {
                    Caption = 'Notice Period Last Date';
                    ApplicationArea = all;
                    ToolTip = 'Specifi the Notice Period of Last date ';
                }

            }
            part(SettleLine; "Final Settlement Subform B2B")
            {
                Caption = 'SettleLine';
                SubPageLink = "Employee No." = FIELD("Employee No.");
                ApplicationArea = all;
            }
            field(AddTotal1; AddTotal)
            {
                Caption = 'Additions';
                Editable = false;
                ToolTip = 'Specifies the addition total in final settelement';
                ApplicationArea = all;
            }
            field(DedTotal1; DedTotal)
            {
                Caption = 'Deductions';
                Editable = false;
                ToolTip = 'Specifies the dedduction total in the final settelemnt';
                ApplicationArea = all;
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ToolTip = 'specifies the journal batch name for final settlement postings';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        JournalTemplate.RESET();
                        JournalTemplate.SETRANGE("Form ID", 33001261);
                        if JournalTemplate.FINDFIRST() then begin
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                            if PAGE.RUNMODAL(33001274, JournalBatch) = ACTION::LookupOK then begin
                                "Journal Batch Name" := JournalBatch.Name;
                                "Journal Template Name" := JournalBatch."Journal Template Name";
                                "Posting Date" := workdate();

                                NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                                if NoSeries.FINDFIRST() then
                                    "Document No." := NoSeriesMgt.TryGetNextNo(NoSeries.Code, WORKDATE());

                                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                                FinalSettleLine.SETRANGE(Month, Month);
                                FinalSettleLine.SETRANGE(Year, Year);
                                if FinalSettleLine.FINDSET() then
                                    repeat
                                        FinalSettleLine."Journal Template Name" := "Journal Template Name";
                                        FinalSettleLine."Journal Batch Name" := "Journal Batch Name";
                                        FinalSettleLine."Posting Date" := "Posting Date";
                                        FinalSettleLine."Document No." := "Document No.";
                                        FinalSettleLine.MODIFY();
                                    until FinalSettleLine.NEXT() = 0;
                            end;
                        end;
                    end;
                }
                field("Posting Date"; "Posting Date")
                {
                    ToolTip = 'Specifies the posting date of journal batch in final settlement';
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Specifies the document no of journal batch in final settelment';
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
        }
        area(processing)
        {


            group("&Print")
            {
                Caption = '&Print';
                Image = Print;

                action("FFS Print")
                {
                    Caption = 'FFS Print';
                    Image = PrintForm;
                    ApplicationArea = all;
                    ToolTip = 'Fss Print';

                    trigger OnAction();
                    begin
                        FSHeader.RESET();
                        FSHeader.SETRANGE("Employee No.", "Employee No.");
                        REPORT.RUNMODAL(33001264, true, true, FSHeader);
                    end;
                }
                action("FFS Att Print")
                {
                    Caption = 'FFS Att Print';
                    Image = PrintCheck;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Fss Att Print';

                    trigger OnAction();
                    begin
                        MonthlyAttRec.RESET();
                        MonthlyAttRec.SETRANGE("Employee Code", "Employee No.");
                        if MonthlyAttRec.FINDSET() then begin
                            FSFAttReport.SetValues(Year, Month);
                            FSFAttReport.SETTABLEVIEW(MonthlyAttRec);
                            FSFAttReport.RUN();
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        UpdateTotals();
    end;

    var
        FinalSettleLine: Record "Final Settlement Line B2B";
        NoSeries: Record "No. Series";
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        FSHeader: Record "Final Settlement Header B2B";
        MonthlyAttRec: Record "Monthly Attendance B2B";
        FSFAttReport: Report "FSF Att Report B2B";
        NoSeriesMgt: Codeunit 396;
        AddTotal: Decimal;
        DedTotal: Decimal;

    procedure UpdateTotals();
    begin
        CLEAR(AddTotal);
        CLEAR(DedTotal);
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        if FinalSettleLine.FINDFIRST() then
            repeat
                if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Addition then
                    AddTotal += FinalSettleLine.Amount
                else
                    if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Deduction then
                        DedTotal += FinalSettleLine.Amount;
            until FinalSettleLine.NEXT() = 0;
    end;
}

