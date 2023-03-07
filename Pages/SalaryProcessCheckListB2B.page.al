page 33001358 "Salary Process Check List B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Salary Process Check List';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Salary Process Check List B2B";
    UsageCategory = Lists;
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
                    ToolTip = 'Define the payroll year';

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
                    ToolTip = 'Pick the value towards payroll month from the list displayed';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102152000)
            {
                IndentationControls = Description;
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'The Process displays the important data match towards Payroll Processing';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Status of the Processed Checklist';
                }
                field(Process; Process)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Status of the Processed Checklist';
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
                action("&Error Log")
                {
                    Caption = '&Error Log';
                    Image = ErrorLog;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Error Log ';
                    trigger OnAction();
                    begin
                        ProcessErrorLog.RESET();
                        ProcessErrorLog.SETRANGE(Month, "Line No");
                        ProcessErrorLog.SETRANGE(Year, Year);
                        ProcessErrorLog.SETRANGE("Checklist ID", ID);
                        PAGE.RUN(33001359, ProcessErrorLog);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Process")
                {
                    Caption = '&Process';
                    Image = Production;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the process';
                    trigger OnAction();
                    begin
                        CheckProcessError();
                    end;
                }
                group("&Get")
                {
                    Caption = '&Get';
                    Image = ShowWarning;
                    action(Action1102154012)
                    {
                        Caption = '&Error Log';
                        Image = GetLines;
                        ToolTip = 'Get Error Log';
                        ApplicationArea = all;

                        trigger OnAction();
                        begin
                            ProcessErrorLog.RESET();
                            ProcessErrorLog.SETRANGE(Month, "Line No");
                            ProcessErrorLog.SETRANGE(Year, Year);
                            PAGE.RUN(33001359, ProcessErrorLog);
                        end;
                    }
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
        CheckList: Record "Salary Process Check List B2B";
        ProcessErrorLog: Record "Salary Process Error Log B2B";
        SalaryProcessChkList: Codeunit "Salary Process Checklist B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text001Lbl: Label '001';
        Text002Lbl: Label '002';
        Text003Lbl: Label '003';
        Text004Lbl: Label '004';
        Text005Lbl: Label '005';
        Text006Lbl: Label '006';

    procedure SelectYear();
    begin
        SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        SETRANGE("Line No", CurrentMonth);
        CurrPage.UPDATE(false);
    end;

    procedure CheckProcessError();
    var

    begin
        ProcessErrorLog.RESET();
        ProcessErrorLog.SETRANGE(Year, Year);
        ProcessErrorLog.SETRANGE(Month, "Line No");
        ProcessErrorLog.DELETEALL();

        CheckList.RESET();
        CheckList.SETRANGE("Line No", "Line No");
        CheckList.SETRANGE(Year, Year);
        CheckList.SETFILTER(Status, '<>%1', Status::Completed);
        CheckList.SETRANGE(Process, true);
        if CheckList.FINDFIRST() then
            repeat
                if CheckList.ID = Text001Lbl then
                    SalaryProcessChkList.CheckPayrollYears(CheckList.ID, CheckList."Line No", CheckList.Year, CheckList.Description);
                if CheckList.ID = Text002Lbl then
                    SalaryProcessChkList.CheckNewEmployee(CheckList.ID, CheckList."Line No", CheckList.Year, CheckList.Description);
                if CheckList.ID = Text003Lbl then
                    SalaryProcessChkList.CheckLoanDetails(CheckList.ID, CheckList."Line No", CheckList.Year, CheckList.Description);
                if CheckList.ID = Text004Lbl then
                    SalaryProcessChkList.CheckTDSDetails(CheckList.ID, CheckList."Line No", CheckList.Year, CheckList.Description);
                if CheckList.ID = Text005Lbl then
                    SalaryProcessChkList.CheckOtherPayElements(CheckList.ID, CheckList."Line No", CheckList.Year, CheckList.Description);
                if CheckList.ID = Text006Lbl then
                    SalaryProcessChkList.CheckPayRevisions(CheckList.ID, CheckList."Line No", CheckList.Year, CheckList.Description);
            until CheckList.NEXT() = 0;
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

