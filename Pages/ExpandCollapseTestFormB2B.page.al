page 33001360 "Expand/Collapse Test Form B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Process Checklist';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Salary Process Check List B2B";
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
                    ToolTip = 'Displays the Payroll Year of the Processed Checklist';

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
                    ToolTip = 'Displays the month of the Processed Checklist';
                }
            }
            repeater(Control1)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowAsTree = true;
                field(ActualExpansionStatus1; ActualExpansionStatus)
                {
                    Caption = 'Expand';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Expand / Detail Status of the Processed Checklist';

                    trigger OnValidate();
                    begin
                        ActualExpansionStatusOnPush();
                    end;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the False Status of the Processed Checklist';
                }
                field(Status; Status)
                {
                    Editable = false;
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
            group("&Expand")
            {
                Caption = '&Expand';
                Image = ExpandAll;
                action("E&xpand All")
                {
                    Caption = 'E&xpand All';
                    Image = ExpandAll;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Detail / Expand Status of the Processed Checklist';

                    trigger OnAction();
                    begin
                        ExpandAll();
                    end;
                }
                action("C&ollapse All")
                {
                    Caption = 'C&ollapse All';
                    Image = CollapseAll;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Detail / Expand Status of the Processed Checklist';

                    trigger OnAction();
                    begin
                        InitTempTable();
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
                    Tooltip = 'Specifies the Process of Function Details';

                    trigger OnAction();
                    begin
                        CheckProcessError();
                        CurrPage.UPDATE(false);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        DescriptionIndent := 0;
        SetExpansionStatus();
        OnAfterGetCurrRecordCust();
        DescriptionOnFormat();
        StatusOnFormat();
        LogCountOnFormat();
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        TempChkList := Rec;

        while (TempChkList.NEXT() <> 0) and (TempChkList.Level > Level) do
            TempChkList.DELETE(true);
        TempChkList := Rec;
        exit(TempChkList.DELETE());
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    var
        Found: Boolean;
    begin
        TempChkList.COPY(Rec);
        Found := TempChkList.FIND(Which);
        Rec := TempChkList;
        exit(Found);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        MODIFY(true);
        TempChkList := Rec;
        if "Line No" <> 0 then
            TempChkList.MODIFY();
        exit(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        OnAfterGetCurrRecordCust();
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    var
        ResultSteps: Integer;
    begin
        TempChkList.COPY(Rec);
        ResultSteps := TempChkList.NEXT(Steps);
        Rec := TempChkList;
        exit(ResultSteps);
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

        InitTempTable();
        CurrPage.UPDATE();
    end;

    var
        ChkList: Record "Salary Process Check List B2B";
        TempChkList: Record "Salary Process Check List B2B" temporary;
        HRSetup: Record "HR Setup B2B";
        CheckList: Record "Salary Process Check List B2B";
        ProcessErrorLog: Record "Salary Process Error Log B2B";
        SalaryProcessChkList: Codeunit "Salary Process Checklist B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        ErrorList: Page "Salary Process Error Logs B2B";
        CurrentYear: Integer;
        CurrentMonth: Integer;
        ActualExpansionStatus: Integer;

        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;
        [InDataSet]
        StatusEmphasize: Boolean;
        [InDataSet]
        LogCountEmphasize: Boolean;


    procedure SetExpansionStatus();
    begin
        case true of
            IsExpanded(Rec):
                ActualExpansionStatus := 1;
            Level = 0:
                ActualExpansionStatus := 0
            else
                ActualExpansionStatus := 2;
        end;
    end;

    procedure InitTempTable();
    begin
        ChkList.RESET();
        ChkList.COPYFILTERS(TempChkList);
        ChkList.SETRANGE(Year, CurrentYear);
        ChkList.SETRANGE(Month, CurrentMonth);
        ChkList.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        TempChkList.DELETEALL();
        if ChkList.FINDFIRST() then
            repeat
                if ChkList.Level = 0 then begin
                    TempChkList := ChkList;
                    TempChkList.INSERT();
                end;
            until ChkList.NEXT() = 0;
    end;

    local procedure ExpandAll();
    var

    begin
        ChkList.RESET();
        ChkList.COPYFILTERS(TempChkList);
        TempChkList.DELETEALL();

        if ChkList.FINDFIRST() then
            repeat
                TempChkList := ChkList;
                TempChkList.INSERT();
            until ChkList.NEXT() = 0;
    end;

    local procedure IsExpanded(ActualChkList: Record "Salary Process Check List B2B"): Boolean;
    begin
        TempChkList := ActualChkList;
        if TempChkList.NEXT() = 0 then
            exit(false);
        exit(TempChkList.Level > ActualChkList.Level);
    end;

    local procedure ToggleExpandCollapse();
    var

    begin
        if ActualExpansionStatus = 0 then begin
            CheckList.Reset();
            ChkList.SETRANGE(Year, CurrentYear);
            ChkList.SETRANGE(Month, CurrentMonth);
            ChkList.SETFILTER("Line No", '<>%1', "Line No");
            ChkList.SETRANGE(Level, Level, Level + 1);
            ChkList := Rec;
            if ChkList.NEXT() <> 0 then
                repeat
                    if ChkList.Level > Level then begin
                        TempChkList := ChkList;
                        if TempChkList.INSERT() then;
                    end;
                until (ChkList.NEXT() = 0) or (ChkList.Level = Level);
        end else
            if ActualExpansionStatus = 1 then begin
                TempChkList := Rec;
                while (TempChkList.NEXT() <> 0) and (TempChkList.Level > Level) do
                    TempChkList.Delete();
            end;
        CurrPage.UPDATE();
    end;

    procedure SetRecFilters();
    begin
        RESET();
        FILTERGROUP(2);
        FILTERGROUP(0);
        CurrPage.UPDATE(false);
    end;

    procedure SelectYear();
    begin
        SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        SETRANGE(Month, CurrentMonth);
        CurrPage.UPDATE();
    end;

    procedure CheckProcessError();
    var
    begin
        ProcessErrorLog.RESET();
        ProcessErrorLog.SETRANGE(Year, Year);
        ProcessErrorLog.SETRANGE(Month, Month);
        ProcessErrorLog.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        ProcessErrorLog.DELETEALL();

        CheckList.RESET();
        CheckList.SETRANGE(Month, Month);
        CheckList.SETRANGE(Year, Year);
        CheckList.SETFILTER(Status, '<>%1', Status::Completed);
        CheckList.SETRANGE(Process, true);
        CheckList.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if CheckList.FINDFIRST() then
            repeat
                if CheckList.ID = '0001' then
                    SalaryProcessChkList.CheckPayrollYears(CheckList.ID, CheckList.Month, CheckList.Year, CheckList.Description);
                if CheckList.ID = '0002' then
                    SalaryProcessChkList.CheckNewEmployee(CheckList.ID, CheckList.Month, CheckList.Year, CheckList.Description);
                if CheckList.ID = '0003' then
                    SalaryProcessChkList.CheckLoanDetails(CheckList.ID, CheckList.Month, CheckList.Year, CheckList.Description);
                if CheckList.ID = '0004' then
                    SalaryProcessChkList.CheckTDSDetails(CheckList.ID, CheckList.Month, CheckList.Year, CheckList.Description);
                if CheckList.ID = '0005' then
                    SalaryProcessChkList.CheckOtherPayElements(CheckList.ID, CheckList.Month, CheckList.Year, CheckList.Description);
                if CheckList.ID = '0006' then
                    SalaryProcessChkList.CheckPayRevisions(CheckList.ID, CheckList.Month, CheckList.Year, CheckList.Description);
                if CheckList.ID = '0007' then
                    SalaryProcessChkList.CheckLeaves(CheckList.ID, CheckList.Month, CheckList.Year, CheckList.Description);
            until CheckList.NEXT() = 0;

        SalaryProcessChkList.UpdateLogCount(CurrentYear, CurrentMonth);
    end;

    procedure ShowDetails(ProcessMonth: Integer; ProcessYear: Integer; ChkListID: Code[20]; ChkListSubID: Code[20]; Level: Integer; ParentRefID: Code[20]): Integer;
    var
        ErrorLog: Record "Salary Process Error Log B2B";
        ErrorCount: Integer;

    begin
        CLEAR(ErrorCount);
        if Level = 0 then begin
            ErrorLog.RESET();
            ErrorLog.SETRANGE(Year, ProcessYear);
            ErrorLog.SETRANGE(Month, ProcessMonth);
            ErrorLog.SETRANGE("Checklist ID", ChkListID);
            ErrorLog.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            ErrorList.SETTABLEVIEW(ErrorLog);
            ErrorList.RUN();
        end else begin
            ErrorLog.RESET();
            ErrorLog.SETRANGE(Year, ProcessYear);
            ErrorLog.SETRANGE(Month, ProcessMonth);
            ErrorLog.SETRANGE("Checklist Sub ID", ChkListSubID);
            ErrorLog.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            ErrorList.SETTABLEVIEW(ErrorLog);
            ErrorList.RUN();
        end;
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        SelectYear();
        InitTempTable();
        CurrPage.UPDATE(false);
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        SelectMonth();
        InitTempTable();
        CurrPage.UPDATE(false);
    end;

    local procedure OnAfterGetCurrRecordCust();
    begin
        xRec := Rec;
        if GET("Line No") then begin
            TempChkList := Rec;
            if "Line No" <> 0 then
                TempChkList.MODIFY()
        end else
            if TempChkList.GET("Line No") then
                TempChkList.Delete();
    end;

    local procedure ActualExpansionStatusOnPush();
    begin
        ToggleExpandCollapse();
    end;

    local procedure DescriptionOnFormat();
    begin
        if Level = 0 then
            DescriptionEmphasize := true
        else begin
            DescriptionEmphasize := false;
            DescriptionIndent := 1;
        end;
    end;

    local procedure StatusOnFormat();
    begin
        if Level = 0 then
            StatusEmphasize := true
        else
            StatusEmphasize := false;
    end;

    local procedure LogCountOnFormat();
    begin
        if Level = 0 then
            LogCountEmphasize := true
        else
            LogCountEmphasize := false;
    end;
}

