page 33001229 "Daily Attendance B2B"
{
    // version B2BHR1.00.00

    Caption = 'Daily Attendance';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Daily Attendance B2B";
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
                    ToolTip = 'Specifies the list of employee''s filtered based on the processing month, year and pay cadre.';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            CurrentEmpNo := Employee."No.";
                            Name := Employee."First Name";
                            Cadre := Employee."Pay Cadre";
                        end;
                        SelectEmployee();
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
                        CurrentEmpNoOnAfterValidate();
                    end;
                }
                field(Name1; Name)
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ToolTip = 'Specifies the list of employee''s name based on the employee code filtered for a  processing month, year and pay cadre.';
                    ApplicationArea = all;
                }
                field(Cadre1; Cadre)
                {
                    Caption = 'Pay Cadre';
                    Editable = false;
                    ToolTip = 'Specifies the list of Pay cadre exits in the payroll setup "Staff, Workmen" etc..';
                    ApplicationArea = all;
                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ToolTip = 'Specifies the year for which the payroll processing is being done / computed';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ToolTip = 'Specifies the month for which the payroll processing is being done / computed';
                    ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
            }
            repeater(DailyAttendance)
            {
                Caption = 'DailyAttendance';
                Editable = MakeRepeaterEditable;
                field(Date; Date)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = DateFont;
                    ToolTip = 'Specifies the list of of Days in a month based on the salary processing year and month';
                    ApplicationArea = all;
                }
                field("Shift Code"; "Shift Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the shift assigned to an employee or employees in a processing month and year';
                    ApplicationArea = all;
                }
                field("Revised Shift Code"; "Revised Shift Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Revised shift code Time from the orginal shift code si there is chages in a shift time to an employee or employee''s month for whihc the payroll processing is being done / computed';
                    ApplicationArea = all;
                }
                field("Time Punches"; "Time Punches")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Time Punches in Daily Attendance';
                }
                field("Actual Time In"; "Actual Time In")
                {
                    Caption = 'Shift Time In';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Shift Actul Time In details';
                }
                field("Actual Time Out"; "Actual Time Out")
                {
                    Caption = 'Shift Time Out';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Shift Time Out Details';
                }
                field("Time In"; "Time In")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Time IN details in Employee Daily Attendance';
                }
                field("Time Out"; "Time Out")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Time Out details in Employee Daily Attendance';
                }
                field("Hours Worked"; "Hours Worked")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Hours Worked details in Daily Attendance';
                }
                field("Hrs Worked"; "Hrs Worked")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Hours Worked details in Daily Attendance';
                }
                field("OT Hrs"; "OT Hrs")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee OT Hrs details in Daily Attendance';
                }
                field("OT Approved Hrs"; "OT Approved Hrs")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee OT Approved Hrs';
                }
                field("Outdoor Duty"; "Outdoor Duty")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Outdoor Duty Details';
                }
                field("OT Approved"; "OT Approved")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee OT Approved details';
                }
                field("Comp Off"; "Comp Off")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Comp Off details in Daily Attendance';
                }
                field("C Off Hours"; "C Off Hours")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Comp Off Hours';
                }
                field("Non-Working"; "Non-Working")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Non-Working Details';
                }
                field("Non-Working Type"; "Non-Working Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Non-Working Type like Holiday or Half-Day';
                }
                field("Attendance Type"; "Attendance Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Attendance Type like Present,Obsent or Leave';
                }
                field("Halfday Status"; "Halfday Status")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Half Day Status in Session';
                }
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Leave Code while applying Leave';
                }
                field("Leave Application No."; "Leave Application No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Leave Application No';
                }
                field(Activity; Activity)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Activity Details';
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Remarks Details';
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
                action("OT Approval Details")
                {
                    Caption = 'OT Approval Details';
                    Image = PostedTimeSheet;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee OT Approval Details';

                    trigger OnAction();
                    begin
                        OTApprGRec.RESET();
                        OTApprGRec.SETRANGE("Employee No.", "Employee No.");
                        OTApprGRec.SETRANGE(Date, Date);
                        OTApprGRec.SETRANGE(Updated, true);
                        PAGE.RUNMODAL(33001542, OTApprGRec);
                    end;
                }
            }
        }
        area(processing)
        {
            group(Navigations)
            {
                Caption = 'Navigation';
                Image = Change;
            }
            action(Previous)
            {
                Caption = 'Previous';
                Image = PreviousSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specicfies the Employee Previous month details';

                trigger OnAction();
                var
                    Navigate: Record "Daily Attendance B2B";
                begin
                    if CurrentMonth = 1 then
                        Year := CurrentYear - 1
                    else
                        Year := CurrentYear;
                    if CurrentMonth = 1 then
                        Month := 12
                    else
                        Month := CurrentMonth - 1;
                    Navigate.SETRANGE(Year, Year);
                    Navigate.SETRANGE(Month, Month);
                    if not Navigate.isempty() then begin
                        if CurrentEmpNo = '' then
                            ERROR(Text001Lbl);
                        CurrentYear := Year;
                        CurrentMonth := Month;
                        SelectYear();
                        SelectMonth();
                    end else
                        ERROR(Text000Lbl);
                end;
            }
            action(Next)
            {
                Caption = 'Next';
                Image = NextSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                ToolTip = 'Specicfies the Next Employee Details';

                trigger OnAction();
                var
                    Navigate: Record "Daily Attendance B2B";
                begin
                    if CurrentMonth = 12 then
                        Year := CurrentYear + 1
                    else
                        Year := CurrentYear;
                    if CurrentMonth = 12 then
                        Month := 1
                    else
                        Month := CurrentMonth + 1;
                    Navigate.SETRANGE(Year, Year);
                    Navigate.SETRANGE(Month, Month);
                    if not Navigate.isempty() then begin
                        if CurrentEmpNo = '' then
                            ERROR(Text001Lbl);
                        CurrentYear := Year;
                        CurrentMonth := Month;
                        SelectYear();
                        SelectMonth();
                    end else
                        ERROR(Text000Lbl);
                end;
            }
            group(BttnFunc)
            {
                Caption = 'F&unctions';
                Image = Action;
                Visible = BttnFuncVisible;
                action("<Action1102154011>")
                {
                    Caption = 'Update Leaves';
                    Image = Absence;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Update Leave Details from Leave history';

                    trigger OnAction();
                    begin
                        MonAtt.RESET();
                        MonAtt.SETRANGE("Employee Code", CurrentEmpNo);
                        MonAtt.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAtt.SETRANGE(Year, CurrentYear);
                        if MonAtt.FINDFIRST() then;
                        UpdateLeavePlan.SetInfo(MonAtt."Period Start Date", MonAtt."Period End Date", "Employee No.");
                        UpdateLeavePlan.RUN();
                    end;
                }
                action("<Action1102154002>")
                {
                    Caption = 'Revise Shift';
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Revise Shift details in Daily Attendance';

                    trigger OnAction();
                    begin
                        CLEAR(RevEmpShiftGRepVar);
                        RevEmpShiftGRepVar.SetValues("Employee No.", Month, Year);
                        RevEmpShiftGRepVar.RUNMODAL();
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
        if HRSetup.FINDFIRST() then begin
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        end;
        SelectEmployee();
        SelectYear();
        SelectMonth();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        MonAtt: Record "Monthly Attendance B2B";
        MonthlyAttenGRec: Record "Monthly Attendance B2B";
        OTApprGRec: Record "OT Approval B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        RevEmpShiftGRepVar: Report "Revise Employee shift B2B";
        UpdateLeavePlan: Report "Update Leave Records B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";

        CurrentEmpNo: Code[20];
        Text000Lbl: Label 'There are no records with in these filters';
        Text001Lbl: Label '"Please, Select Employee "';
        Cadre: Code[30];
        Name: Text[50];
        CurrentMonth: Integer;
        CurrentYear: Integer;

        NonEditable: Boolean;
        [InDataSet]
        BttnFuncVisible: Boolean;
        [InDataSet]
        DateFont: Boolean;
        [InDataSet]
        MakeRepeaterEditable: Boolean;


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
}

