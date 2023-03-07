page 33001298 "LOP Adjustment B2B"
{
    // version B2BHR1.00.00

    Caption = 'LOP Adjustment';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Daily Attendance B2B";
    SourceTableView = WHERE("Attendance Type" = FILTER(Absent),
                            "Lop Adj. Posted" = FILTER(false));
    UsageCategory = Tasks;
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
                    Caption = 'Employee No.';
                    ApplicationArea = all;
                    ToolTip = 'Displays the Employee Code of the employee';

                    trigger OnLookup(Var Text: Text): Boolean;
                    var
                        Employee_B2B: Record "Employee B2B";
                    begin
                        if PAGE.RUNMODAL(0, Employee_B2B) = ACTION::LookupOK then begin
                            CurrentEmpNo := Employee_B2B."No.";
                            Name := Employee_B2B."First Name";
                            PayCadre := Employee_B2B."Pay Cadre";
                        end;
                        SelectEmployee();
                    end;

                    trigger OnValidate();
                    var
                        Employee_B2B: Record "Employee B2B";
                    begin
                        if Employee_B2B.GET(CurrentEmpNo) then begin
                            Name := Employee_B2B."First Name";
                            PayCadre := Employee_B2B."Pay Cadre";
                        end else begin
                            Name := '';
                            PayCadre := '';
                        end;

                        if CurrentEmpNo = '' then begin
                            Name := '';
                            PayCadre := '';
                        end;
                        CurrentEmpNoOnAfterValidate();
                    end;
                }

                field(Name1; Name)
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Employee Name of the employee';
                }
                field(PayCadr1e; PayCadre)
                {
                    Caption = 'Pay Cadre';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Employees Pay Cadre assigned';
                }
                field(CurrentYear1; Year)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Displays the LOP Adjustment Year.';

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
                    ToolTip = 'Displays the LOP Adjsutment Month';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field("Adj. LOP Year"; AdjLOPYear)
                {
                    Caption = 'Adj. LOP Year';
                    ApplicationArea = all;
                    ToolTip = 'Displays the LOP Adjustment month';
                }
                field("Adj. LOP Month"; AdjLOPMonth)
                {
                    Caption = 'Adj. LOP Month';
                    MaxValue = 12;
                    MinValue = 1;
                    ApplicationArea = all;
                    ToolTip = 'Displays the LOP Adjsutment Month';
                }
            }
            field(CurrLocation1; CurrLocation)
            {
                Caption = 'Location';
                TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = FILTER(22));
                Visible = false;
                ApplicationArea = all;
                ToolTip = 'Displays the Employee Location';
            }
            repeater(DailyAttendance1)
            {
                Caption = 'DailyAttendance';
                field(Date; Date)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = DateFont;
                    ApplicationArea = all;
                    ToolTip = 'Displays the LOP Adjsutment Date of the employee';
                }
                field("Shift Code"; "Shift Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Employee Shift Code';
                }
                field("Revised Shift Code"; "Revised Shift Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Revised Shift code of the Employee';
                }
                field("Attendance Type"; "Attendance Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Attendance Type as Present, Absent , Leave of the employee';
                }
                field("LOP Type"; "LOP Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the LOP type as Addition / Decuction towards the Employee LOP Adjsutment';
                }
                field("Lop Adj. Approved"; "Lop Adj. Approved")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Approval Employee Name';

                    trigger OnValidate();
                    begin
                        TESTFIELD("LOP Type");
                        if "Lop Adj. Approved" then begin
                            "Approved Date & Time" := CREATEDATETIME(WORKDATE(), TIME());
                            Evaluate("Approved User ID", USERID());
                        end else begin
                            CLEAR("Approved Date & Time");
                            CLEAR("Approved User ID");
                        end;
                    end;
                }
                field("Lop Adj. Posted"; "Lop Adj. Posted")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the whtether the LOP Adjustment is posted (True / False)towards the employee';
                }
                field("Approved User ID"; "Approved User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Approver User ID of the employee';
                }
                field("Approved Date & Time"; "Approved Date & Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Approved date and Time of the LOP Adjsutment entry';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(BttnFunc)
            {
                Caption = 'F&unctions';
                Image = Action;
                Visible = BttnFuncVisible;
                action("<Action1102154011>")
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Post';

                    trigger OnAction();
                    begin
                        if AdjLOPYear = 0 then
                            ERROR(Text002Lbl);

                        if AdjLOPMonth = 0 then
                            ERROR(Text003Lbl);


                        if CONFIRM(Text004Lbl, true, "Employee No.") then begin
                            DailyAttendance.RESET();
                            CurrPage.SETSELECTIONFILTER(DailyAttendance);
                            if DailyAttendance.FINDSET() then
                                repeat
                                    DailyAttendance.TESTFIELD("Lop Adj. Approved", true);
                                    PostLOP(DailyAttendance);
                                    DailyAttendance."Lop Adj. Posted" := true;
                                    DailyAttendance.MODIFY();
                                until DailyAttendance.NEXT() = 0;
                            MESSAGE(Text005Lbl, "Employee No.");
                            CurrPage.UPDATE(false);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        DateOnFormat();

        if "Non-Working" then
            DateFont := true
        else
            DateFont := false;
    end;

    trigger OnInit();
    begin
        BttnFuncVisible := true;
    end;

    trigger OnOpenPage();
    begin
        CurrentEmpNo := '';
        Name := '';
        HRSetup.GET();
        //if HRSetup.FINDFIRST() then begin
        CurrentMonth := HRSetup."Salary Processing month";
        CurrentYear := HRSetup."Salary Processing Year";
        //end;
        SelectEmployee();
        SelectYear();
        SelectMonth();
        CLEAR(AdjLOPMonth);
        CLEAR(AdjLOPYear);
    end;

    var
        HRSetup: Record "HR Setup B2B";
        MonthlyAttenGRec: Record "Monthly Attendance B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LOPAdjEntries: Record "LOP Adj. Entries B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        LocWiseMiscGCU: Codeunit 33001213;
        CurrentEmpNo: Code[20];
        Name: Text[50];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        CurrLocation: Code[30];
        NonEditable: Boolean;

        [InDataSet]
        BttnFuncVisible: Boolean;
        [InDataSet]
        DateFont: Boolean;
        [InDataSet]
        MakeRepeaterEditable: Boolean;
        AdjLOPMonth: Integer;
        AdjLOPYear: Integer;
        Text002Lbl: Label 'Please provide Adjustment year';
        Text003Lbl: Label 'Please provide Adjustment Month';
        Text004Lbl: Label 'Do you want to Adjust the LOP for this Employee %1?', Comment = '%1 = Employee No';
        Text005Lbl: Label 'LOP Adjusted for this Employee %1  Successfully.', Comment = '%1 = Employee No';

    procedure SelectYear();
    begin
        FILTERGROUP(2);
        SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        SETRANGE("Not Joined", 0);
        SETRANGE(Year, CurrentYear);
        CheckPostedMonth();
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        SETRANGE("Not Joined", 0);
        SETRANGE(Month, CurrentMonth);
        CheckPostedMonth();
        CurrPage.UPDATE(false);
    end;

    procedure SelectEmployee();
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        SETRANGE("Not Joined", 0);
        SETRANGE("Employee No.", CurrentEmpNo);
        CheckPostedMonth();
        CurrPage.UPDATE(false);
    end;

    procedure CheckPostedMonth();
    var

    begin
        MonthlyAttenGRec.RESET();
        MonthlyAttenGRec.SETRANGE("Employee Code", CurrentEmpNo);
        MonthlyAttenGRec.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAttenGRec.SETRANGE(Year, CurrentYear);
        MonthlyAttenGRec.SETRANGE(Posted, true);

        if not MonthlyAttenGRec.isempty() then begin
            CurrPage.EDITABLE := false;
            BttnFuncVisible := false;
            MakeRepeaterEditable := false
        end else begin
            CurrPage.EDITABLE := true;
            BttnFuncVisible := true;
            MakeRepeaterEditable := true
        end;
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        SelectYear()
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        SelectMonth();
    end;

    local procedure CurrentEmpNoOnAfterValidate();
    begin
        SelectEmployee();
    end;

    local procedure CurrentYearOnDeactivate();
    begin
        MonthlyAttenGRec.RESET();
        MonthlyAttenGRec.SETRANGE("Employee Code", CurrentEmpNo);
        MonthlyAttenGRec.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAttenGRec.SETRANGE(Year, CurrentYear);
        MonthlyAttenGRec.SETRANGE(Posted, true);
        if MonthlyAttenGRec.FINDFIRST() then begin
            CurrPage.EDITABLE := false;
            BttnFuncVisible := false;
        end else begin
            CurrPage.EDITABLE := true;
            BttnFuncVisible := true;
        end;
    end;

    local procedure CurrentMonthOnDeactivate();
    begin
        MonthlyAttenGRec.RESET();
        MonthlyAttenGRec.SETRANGE("Employee Code", CurrentEmpNo);
        MonthlyAttenGRec.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAttenGRec.SETRANGE(Year, CurrentYear);
        MonthlyAttenGRec.SETRANGE(Posted, true);

        if MonthlyAttenGRec.FINDFIRST() then begin
            CurrPage.EDITABLE := false;
            BttnFuncVisible := false;
        end else begin
            CurrPage.EDITABLE := true;
            BttnFuncVisible := true;
        end;
    end;

    local procedure CurrentEmpNoOnDeactivate();
    begin
        MonthlyAttenGRec.RESET();
        MonthlyAttenGRec.SETRANGE("Employee Code", CurrentEmpNo);
        MonthlyAttenGRec.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAttenGRec.SETRANGE(Year, CurrentYear);
        MonthlyAttenGRec.SETRANGE(Posted, true);

        if MonthlyAttenGRec.FINDFIRST() then begin
            CurrPage.EDITABLE := false;
            BttnFuncVisible := false;
        end else begin
            CurrPage.EDITABLE := true;
            BttnFuncVisible := true;
        end;
    end;

    local procedure CurrentYearOnActivate();
    begin
        CLEAR(NonEditable);
        if CurrPage.EDITABLE() = false then begin
            NonEditable := true;
            CurrPage.EDITABLE := true;
        end;
    end;

    local procedure CurrentMonthOnActivate();
    begin
        CLEAR(NonEditable);
        if CurrPage.EDITABLE() = false then begin
            NonEditable := true;
            CurrPage.EDITABLE := true;
        end;
    end;

    local procedure CurrentEmpNoOnActivate();
    begin
        CLEAR(NonEditable);
        if CurrPage.EDITABLE() = false then begin
            NonEditable := true;
            CurrPage.EDITABLE := true;
        end;
    end;

    local procedure DateOnFormat();
    begin
        if "Non-Working" then;
        if (Holiday = 1.0) then;
    end;

    procedure PostLOP(var DailyAttendance: Record "Daily Attendance B2B");
    begin
        LOPAdjEntries.INIT();
        LOPAdjEntries.Type := LOPAdjEntries.Type::Addition;
        LOPAdjEntries."Employee No." := DailyAttendance."Employee No.";
        LOPAdjEntries."Pay Cadre" := DailyAttendance.PayCadre;
        LOPAdjEntries."Adj. LOP Month" := AdjLOPMonth;
        LOPAdjEntries."Adj. LOP Year" := AdjLOPYear;
        LOPAdjEntries."LOP Month" := DailyAttendance.Month;
        LOPAdjEntries."LOP Year" := DailyAttendance.Year;
        LOPAdjEntries.Date := DailyAttendance.Date;
        LOPAdjEntries."User ID" := DailyAttendance."Approved User ID";
        LOPAdjEntries."LOP Type" := DailyAttendance."LOP Type";
        LOPAdjEntries."Day Count" := DailyAttendance."Day Count";
        LOPAdjEntries.INSERT();
    end;
}

