page 33001377 "Leaves Applied B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leaves Applied';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "Temp Leave Plan B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentEmpNo1; CurrentEmpNo)
                {
                    Caption = 'Employee Code';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee code';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            CurrentEmpNo := Employee."No.";
                            Name := Employee."First Name";
                            Cadre := Employee."Pay Cadre";
                        end;
                        InsertIntoTemp(CurrentEmpNo, 0D, 0D);
                        CurrPage.UPDATE();
                    end;

                    trigger OnValidate();
                    begin
                        if Employee.GET(CurrentEmpNo) then begin
                            Name := Employee."First Name";
                            Cadre := Employee."Pay Cadre";
                        end else begin
                            Name := '';
                            Cadre := '';
                        end;

                        if CurrentEmpNo = '' then begin
                            Name := '';
                            Cadre := '';
                        end;
                    end;
                }
                field(Name1; Name)
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field(Cadre1; Cadre)
                {
                    Caption = 'Employee Cadre';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee cadre';
                }
                field(CurrentFromDate1; CurrentFromDate)
                {
                    Caption = 'From Date';
                    ApplicationArea = all;
                    ToolTip = 'Specify the from date details';

                    trigger OnValidate();
                    begin
                        CurrentToDate := CurrentFromDate;
                        CurrentFromDateOnAfterValidate();
                    end;
                }
                field(CurrentToDate2; CurrentToDate)
                {
                    Caption = 'To Date';
                    ApplicationArea = all;
                    ToolTip = 'Specify the to date details';

                    trigger OnValidate();
                    begin
                        CurrentToDateOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102154002)
            {
                field(ActualExpansionStatus1; ActualExpansionStatus)
                {
                    Caption = 'Expand';
                    Editable = false;
                    //OptionCaption = 'Integer';//Phani
                    ApplicationArea = all;
                    ToolTip = 'Specify the expand details';

                    trigger OnValidate();
                    begin
                        ActualExpansionStatusOnPush();
                    end;
                }
                field("Show App Code"; "Show App Code")
                {
                    Caption = 'Application';
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                    ToolTip = 'Specify the application details';
                }
                field("Show Emp Code"; "Show Emp Code")
                {
                    Caption = 'Employee Code';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee code';
                }
                field("Show Emp Name"; "Show Emp Name")
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field("Show Leave Desp"; "Show Leave Desp")
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the description';
                }
                field("Show Leave Date"; "Show Leave Date")
                {
                    Caption = 'Date';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the date';
                }
                field("Show Approval Status"; "Show Approval Status")
                {
                    Caption = 'Status';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the status';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        SetExpansionStatus();
    end;

    trigger OnOpenPage();
    begin
        TempLeavePlanDELETE.RESET();
        TempLeavePlanDELETE.DELETEALL();
    end;

    var
        TempLeavePlan: Record "Temp Leave Plan B2B";
        Employee: Record "Employee B2B";
        LeavePlan: Record "Leave Plan B2B" temporary;
        TableLeavePlan: Record "Leave Plan B2B";
        LeavePlanRec: Record "Leave Plan B2B";
        TempLeavePlanDELETE: Record "Temp Leave Plan B2B";
        LineNo: Integer;
        TempAppCode: Text[30];
        ActualExpansionStatus: Integer;
        CurrentEmpNo: Code[20];
        Cadre: Code[30];
        Name: Text[50];
        CurrentFromDate: Date;
        CurrentToDate: Date;
        Text001Lbl: Label 'XX';

    procedure InsertIntoTemp(EmpNo: Code[20]; FromDate: Date; ToDate: Date);
    begin
        TempLeavePlan.RESET();
        TempLeavePlan.DELETEALL();
        LineNo := 1000;

        TableLeavePlan.RESET();
        TableLeavePlan.SETFILTER("Employee No", '=%1', EmpNo);
        if TableLeavePlan.FINDFIRST() then
            repeat
                TableLeavePlan.Processed := false;
                TableLeavePlan.MODIFY();
            until TableLeavePlan.NEXT() = 0;

        LeavePlan.RESET();
        LeavePlan.DELETEALL();
        LeavePlanRec.RESET();
        LeavePlanRec.SETFILTER("Employee No", '=%1', EmpNo);
        LeavePlanRec.SETRANGE(Processed, false);
        if (FromDate <> 0D) then
            LeavePlanRec.SETFILTER("Leave Date", '=%1', FromDate);
        if (ToDate <> 0D) then
            LeavePlanRec.SETFILTER("Leave Date", '=%1', ToDate);

        if (FromDate <> 0D) and (ToDate <> 0D) then
            LeavePlanRec.SETFILTER("Leave Date", '>=%1 & <= %2', FromDate, ToDate);

        if LeavePlanRec.FINDFIRST() then
            repeat
                TableLeavePlan.RESET();
                TableLeavePlan.SETRANGE("Leave Application No.", LeavePlanRec."Leave Application No.");
                TableLeavePlan.SETRANGE(Processed, false);
                if TableLeavePlan.FINDFIRST() then
                    repeat
                        LeavePlan.INIT();
                        LeavePlan.TRANSFERFIELDS(TableLeavePlan);
                        LeavePlan.INSERT();
                        TableLeavePlan.Processed := true;
                        TableLeavePlan.MODIFY();
                    until TableLeavePlan.NEXT() = 0;
            until LeavePlanRec.NEXT() = 0;

        LeavePlan.RESET();
        if LeavePlan.FINDFIRST() then begin
            TempAppCode := Text001Lbl;
            repeat
                TempLeavePlan.INIT();
                if (TempAppCode <> '') and (TempAppCode <> LeavePlan."Leave Application No.") then begin
                    TempLeavePlan."Show App Code" := LeavePlan."Leave Application No.";
                    TempLeavePlan."Show Emp Code" := '';
                    TempLeavePlan."Show Leave Desp" := '';
                    TempLeavePlan."Leave Application No." := LeavePlan."Leave Application No.";
                    TempLeavePlan."Employee No" := LeavePlan."Employee No";
                    TempLeavePlan."Employee Name" := LeavePlan."Employee Name";
                    TempLeavePlan."Leave Description" := LeavePlan."Leave Description";
                    TempLeavePlan."Leave Code" := LeavePlan."Leave Code";
                    TempLeavePlan."Leave Date" := LeavePlan."Leave Date";
                    TempLeavePlan."Leave Type" := LeavePlan."Leave Type";
                    TempLeavePlan."Approved Status" := LeavePlan."Approved Status";
                    TempLeavePlan.level := 0;
                    TempLeavePlan."Line No." := LineNo;
                    TempLeavePlan.INSERT();
                    LineNo := LineNo + 1000;
                end;
                TempLeavePlan.TRANSFERFIELDS(LeavePlan);
                TempLeavePlan."Show App Code" := '';
                TempLeavePlan."Show Emp Code" := LeavePlan."Employee No";
                TempLeavePlan."Show Emp Name" := LeavePlan."Employee Name";
                TempLeavePlan."Show Leave Desp" := LeavePlan."Leave Description";
                TempLeavePlan."Show Leave Date" := LeavePlan."Leave Date";
                TempLeavePlan."Show Approval Status" := FORMAT(LeavePlan."Approved Status");
                TempLeavePlan."Line No." := LineNo;
                TempLeavePlan.INSERT();
                LineNo := LineNo + 1000;
                TempAppCode := LeavePlan."Leave Application No.";
            until LeavePlan.NEXT() = 0;
        end;
        RESET();
        SETRANGE(level, 0);
        CurrPage.UPDATE();
    end;

    procedure ToggleExpandCollapse();
    begin

        if Rec.Flag = 1 then
            ActualExpansionStatus := 1;
        if ActualExpansionStatus = 0 then begin
            TempLeavePlan.RESET();
            TempLeavePlan.SETRANGE(level, 0);
            if TempLeavePlan.FINDFIRST() then
                repeat
                    TempLeavePlan.level2 := 1;
                    TempLeavePlan.MODIFY();
                until TempLeavePlan.NEXT() = 0;

            TempLeavePlan.RESET();
            TempLeavePlan.SETRANGE(TempLeavePlan."Leave Application No.", "Leave Application No.");
            if TempLeavePlan.FINDFIRST() then
                repeat
                    TempLeavePlan.level2 := 1;
                    TempLeavePlan.MODIFY();
                until TempLeavePlan.NEXT() = 0;

            TempLeavePlan.RESET();
            TempLeavePlan.SETRANGE(TempLeavePlan."Leave Application No.", "Leave Application No.");
            TempLeavePlan.SETRANGE(TempLeavePlan."Line No.", "Line No.");
            if TempLeavePlan.FINDFIRST() then
                repeat
                    TempLeavePlan.Flag := 1;
                    TempLeavePlan.MODIFY();
                until TempLeavePlan.NEXT() = 0;

        end;
        if ActualExpansionStatus = 1 then begin
            TempLeavePlan.RESET();
            TempLeavePlan.SETRANGE(TempLeavePlan."Leave Application No.", "Leave Application No.");
            if TempLeavePlan.FINDFIRST() then
                repeat
                    TempLeavePlan.level2 := 0;
                    TempLeavePlan.MODIFY();
                until TempLeavePlan.NEXT() = 0;

            TempLeavePlan.RESET();
            TempLeavePlan.SETRANGE(TempLeavePlan."Leave Application No.", "Leave Application No.");
            TempLeavePlan.SETRANGE(TempLeavePlan."Line No.", "Line No.");
            if TempLeavePlan.FINDFIRST() then
                repeat
                    TempLeavePlan.level2 := 1;
                    TempLeavePlan.Flag := 0;
                    TempLeavePlan.MODIFY();
                until TempLeavePlan.NEXT() = 0;

        end;
        RESET();
        SETRANGE(level2, 1);
        CurrPage.UPDATE();
    end;

    procedure SetExpansionStatus();
    begin
        case true of
            level = 1:
                ActualExpansionStatus := 2;
            (level = 0) and (Flag = 1):
                ActualExpansionStatus := 1;
            (level = 0) and (Flag <> 1):
                ActualExpansionStatus := 0;
        end;
    end;

    local procedure CurrentFromDateOnAfterValidate();
    begin
        InsertIntoTemp(CurrentEmpNo, CurrentFromDate, CurrentToDate);
    end;

    local procedure CurrentToDateOnAfterValidate();
    begin
        InsertIntoTemp(CurrentEmpNo, CurrentFromDate, CurrentToDate);
    end;

    local procedure ActualExpansionStatusOnPush();
    begin
        ToggleExpandCollapse();
    end;
}

