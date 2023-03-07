page 33001303 "LOP Adjustment - Deduction B2B"
{
    // version B2BHR1.00.00

    Caption = 'LOP Adjustment - Deduction';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Daily Attendance B2B";
    SourceTableView = WHERE("Attendance Type" = FILTER(Present),
                            "Lop Adj. Posted" = FILTER(false));
    UsageCategory = tasks;
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
                    ToolTip = 'Specifies The employee no';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            CurrentEmpNo := Employee."No.";
                            NameTxt := Employee."First Name";
                            Cadre := Employee."Pay Cadre";
                        end;
                        SelectEmployee();
                    end;

                    trigger OnValidate();
                    begin
                        if Employee.GET(CurrentEmpNo) then begin
                            NameTxt := Employee."First Name";
                            Cadre := Employee."Pay Cadre";
                        end else begin
                            NameTxt := '';
                            Cadre := '';
                        end;

                        if CurrentEmpNo = '' then begin
                            NameTxt := '';
                            Cadre := '';
                        end;
                        CurrentEmpNoOnAfterValidate();
                    end;
                }
                field(Name1; NameTxt)
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Enter / Pick the Employee Name for LOP Adjsutment Process';
                }
                field(Cadre1; Cadre)
                {
                    Caption = 'Pay Cadre';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'The Pay Cadre assigned to the employee is displayed here';
                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Assigend or Pick the Year';

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
                    ToolTip = 'Pick the LOP Adjsutment month';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field("Adj. LOP Year"; AdjLOPYear)
                {
                    Caption = 'Adj. LOP Year';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The adj. lop year';
                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate()
                    end;
                }
                field("Adj. LOP Month"; AdjLOPMonth)
                {
                    Caption = 'Adj. LOP Month';
                    MaxValue = 12;
                    MinValue = 1;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The lop month';
                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate()
                    end;
                }
            }
            field(CurrLocation1; CurrLocation)
            {
                Caption = 'Location';
                TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = FILTER(22));
                Visible = false;
                ApplicationArea = all;
                ToolTip = 'Specifies The ocation code';
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
                    ToolTip = 'Specifies The date';
                }
                field("Shift Code"; "Shift Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The shift code';
                }
                field("Revised Shift Code"; "Revised Shift Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Revised shift code';
                }
                field("Attendance Type"; "Attendance Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The attendance type';
                }
                field("LOP Type"; "LOP Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The lop type';
                }
                field("Lop Adj. Deduction Approved"; "Lop Adj. Deduction Approved")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The lop adj deduction approved';

                    trigger OnValidate();
                    begin
                        TESTFIELD("LOP Type");
                        if "Lop Adj. Deduction Approved" then begin
                            "LOP Ded. Approved Date & Time" := CREATEDATETIME(WORKDATE(), TIME());
                            Evaluate("LOP Ded. Approved User ID", USERID());
                        end else begin
                            CLEAR("LOP Ded. Approved Date & Time");
                            CLEAR("LOP Ded. Approved User ID");
                        end;
                    end;
                }
                field("Lop Adj. Posted"; "Lop Adj. Posted")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The lop adj posted';
                }
                field("LOP Ded. Approved User ID"; "LOP Ded. Approved User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The lop ded. approved user id';
                }
                field("LOP Ded. Approved Date & Time"; "LOP Ded. Approved Date & Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The lop ded approved date time';
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
                                    DailyAttendance.TESTFIELD("Lop Adj. Deduction Approved", true);
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
        NameTxt := '';
        if HRSetup.FINDFIRST() then begin
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        end;
        SelectEmployee();
        SelectYear();
        SelectMonth();
        CLEAR(AdjLOPMonth);
        CLEAR(AdjLOPYear);
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        MonthlyAttenGRec: Record "Monthly Attendance B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LOPAdjEntries: Record "LOP Adj. Entries B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        CurrentEmpNo: Code[20];

        Cadre: Code[30];
        NameTxt: Text[50];
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
        Text004Lbl: Label 'Do you want to Adjust the LOP for this Employee %1?', Comment = '%1 = Employee no';
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
    begin
        MonthlyAttenGRec.RESET();
        MonthlyAttenGRec.SETRANGE("Employee Code", CurrentEmpNo);
        MonthlyAttenGRec.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAttenGRec.SETRANGE(Year, CurrentYear);
        MonthlyAttenGRec.SETRANGE(Posted, true);
        if not MonthlyAttenGRec.IsEmpty() then begin
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
        if not MonthlyAttenGRec.isempty() then begin
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

        if not MonthlyAttenGRec.isempty() then begin
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

        if not MonthlyAttenGRec.isempty() then begin
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
        LOPAdjEntries.Type := LOPAdjEntries.Type::Deduction;
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

