codeunit 33001193 "Calendar Gen. New Emp B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    var
        Answer: Boolean;
    begin
        Answer := CheckValidations();
        if Answer then begin
            InsertTempCal();
            MESSAGE(Text003Txt);
        end;

        TempCalendar.RESET();
        if TempCalendar.FINDFIRST() then
            TempCalendar.DELETEALL();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        TempCalendarLRec: Record "Temp Calendar B2B";
        ShiftwiseOffdayLVar: Record "Shiftwise Offday B2B";
        EmployeeShiftLVar: Record "Employee Shift B2B";
        Date: Record Date;
        PayYear: Record "Payroll Year B2B";
        Holiday: Record Holiday_B2B;
        EmployeeShift: Record "Employee Shift B2B";
        TempCalendar: Record "Temp Calendar B2B";
        PayrollLocation: Record "Payroll Locations B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Window: Dialog;
        Text000Txt: Label 'Creating Calendar\Status          @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Text001Txt: Label 'No Holidays are defined for this leave year, Do you want to continue';
        Text002Txt: Label 'Creating attendance records for ...\Employee        #1########\Status          @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', Comment = '%1 = Employee ; %2 = Status';
        StartDate: Date;
        EndDate: Date;
        Text011Txt: Label 'Lock the HR Setup Table';
        Text006Txt: Label 'Shift must be defined for Employee %1 %2.', Comment = '%1 = Employee;%2 Shift';
        Text003Txt: Label 'Records inserted.';
        LoctionsString: Text;
        Text012Txt: Label 'No Holidays are defined for this leave year to All Locations , Do you want to continue';
        Text33001Txt: Label 'LEAVE YEAR';
        Text33002Txt: Label '<-1D>';
        Text33003Txt: Label '<1M>';

    procedure CheckValidations(): Boolean;
    var

        CheckDate: Date;
        Flag: Boolean;
        Answer: Boolean;
        "Count": Integer;
        EmpCount: Integer;
        EmpErr: Label 'No Records found in "Employee B2B"; table.';
    begin
        if HRSetup.FINDFIRST() then
            if not HRSetup.Locked then
                ERROR(Text011Txt);

        Employee.RESET();
        Employee.SETRANGE(Blocked, false);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            Employee.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            Employee.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());

        Employee.SETRANGE("Attendance Not Generated", true);
        if Employee.FINDFIRST() then
            repeat
                Employee.TESTFIELD("Pay Cadre");
                Employee.TESTFIELD("Leave Pay Cadre");
                EmpCount := Employee.Count();
            until Employee.NEXT() = 0;

        IF EmpCount = 0 then
            Error(EmpErr);

        PayYear.SETRANGE("Year Type", Text33001Txt);
        PayYear.SETRANGE(Closed, false);
        if PayYear.FINDFIRST() then begin
            StartDate := PayYear."Year Start Date";
            EndDate := PayYear."Year End Date";
        end;

        Employee.RESET();
        Employee.SETRANGE(Blocked, false);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            Employee.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            Employee.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        Employee.SETRANGE("Attendance Not Generated", true);
        if Employee.FINDFIRST() then
            repeat
                Flag := false;
                if Employee."Employment Date" <= StartDate then
                    CheckDate := Employee."Employment Date"
                else
                    if (StartDate <= Employee."Employment Date") and (Employee."Employment Date" <= EndDate) then
                        CheckDate := Employee."Employment Date";


                EmployeeShift.SETRANGE("Employee Code", Employee."No.");
                if EmployeeShift.FINDFIRST() then
                    repeat
                        if EmployeeShift."Start Date" = CheckDate then
                            Flag := true;
                    until EmployeeShift.NEXT() = 0;
                if not Flag then
                    ERROR(Text006Txt, Employee."No.", CheckDate);
            until Employee.NEXT() = 0;

        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then begin
            LoctionsString := '';
            PayrollLocation.RESET();
            PayrollLocation.SETFILTER("Location Code", PayrollUsers."Multiple Locations");
            if PayrollLocation.FINDFIRST() then
                repeat
                    Holiday.RESET();
                    Holiday.SETRANGE("Location Code", PayrollLocation."Location Code");
                    if Holiday.FINDFIRST() then begin
                        Count := 0;
                        repeat
                            if (StartDate <= Holiday.Date) and (EndDate >= Holiday.Date) then
                                Count := Count + 1
                        until Holiday.NEXT() = 0;
                    end;
                    if Count = 0 then
                        LoctionsString := LoctionsString + ',' + PayrollLocation."Location Code";
                until PayrollLocation.NEXT() = 0;
            if LoctionsString <> '' then begin
                Answer := DIALOG.CONFIRM(Text012Txt, true);
                exit(Answer);
            end else
                exit(true);
        end else begin
            Holiday.RESET();
            Holiday.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            if Holiday.FINDFIRST() then begin
                Count := 0;
                repeat
                    if (StartDate <= Holiday.Date) and (EndDate >= Holiday.Date) then
                        Count := Count + 1
                until Holiday.NEXT() = 0;
            end;

            if Count = 0 then begin
                Answer := DIALOG.CONFIRM(Text001Txt, true);
                exit(Answer);
            end else
                exit(true);
        end;
    end;

    procedure InsertTempCal();
    var

        Counter: Integer;
    begin
        PayYear.SETRANGE("Year Type", Text33001Txt);
        PayYear.SETRANGE(Closed, false);
        if PayYear.FINDFIRST() then begin
            StartDate := PayYear."Year Start Date";
            EndDate := PayYear."Year End Date";
        end;

        Window.OPEN(Text000Txt);
        Counter := 0;
        Date.RESET();
        Date.SETRANGE("Period Type", Date."Period Type"::Date);
        Date.SETRANGE("Period Start", StartDate, EndDate);
        if Date.FINDSET() then
            repeat
                Counter := Counter + 1;
                TempCalendar.INIT();
                TempCalendar.Date := Date."Period Start";
                TempCalendar.Description := copystr(Date."Period Name", 1, 30);
                TempCalendar."Day No." := Date."Period No.";
                TempCalendar.INSERT();
                Window.UPDATE(1, ROUND(Counter / TempCalendar.COUNT() * 10000, 1));
            until Date.NEXT() = 0;

        NonWorking();
    end;

    procedure NonWorking();
    var

    begin
        Window.CLOSE();
        ProcessDailyAttendance();
    end;

    procedure ProcessDailyAttendance();
    var

        StartDate2: Date;
        CheckDate: Date;
        TestDate: Date;
        CheckDay: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        Counter: Integer;
    begin
        Employee.RESET();
        Employee.SETRANGE(Blocked, false);
        Employee.SETRANGE("Attendance Not Generated", true);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            Employee.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            Employee.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if Employee.FINDFIRST() then begin
            Window.OPEN(Text002Txt);
            Counter := 0;
            repeat
                if Employee."Employment Date" <= StartDate then begin
                    StartDate2 := StartDate;
                    TestDate := StartDate;
                end else
                    if (StartDate < Employee."Employment Date") and (Employee."Employment Date" <= EndDate) then begin
                        StartDate2 := Employee."Employment Date";

                        CheckDay := DATE2DMY(Employee."Period Start Date", 1);
                        CheckMonth := DATE2DMY(StartDate2, 2);
                        CheckYear := DATE2DMY(StartDate2, 3);
                        CheckDate := DMY2DATE(CheckDay, CheckMonth, CheckYear);
                        TestDate := CheckDate;

                        DailyAttendance.RESET();
                        DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                        DailyAttendance.SETFILTER(Date, '=%1 | = %2', TestDate, EndDate);
                        if not DailyAttendance.FINDFIRST() then begin
                            while (CheckDate > StartDate2) do begin
                                CheckMonth := CheckMonth - 1;
                                CheckDate := DMY2DATE(CheckDay, CheckMonth, CheckYear);
                            end;

                            TempCalendarLRec.SETFILTER(Date, '%1..%2', CheckDate, (StartDate2 - 1));
                            if TempCalendarLRec.FINDFIRST() then
                                repeat
                                    DailyAttendance.INIT();
                                    DailyAttendance."Employee No." := Employee."No.";
                                    DailyAttendance."Employee Name" := Employee."First Name";
                                    DailyAttendance.PayCadre := Employee."Pay Cadre";
                                    DailyAttendance."Leave Pay Cadre" := Employee."Leave Pay Cadre";
                                    DailyAttendance.Date := TempCalendarLRec.Date;
                                    DailyAttendance."Day No." := TempCalendarLRec."Day No.";
                                    DailyAttendance.Month := DATE2DMY(DailyAttendance.Date, 2);
                                    DailyAttendance.Year := DATE2DMY(DailyAttendance.Date, 3);
                                    DailyAttendance."Not Joined" := 1;
                                    DailyAttendance."Location Code" := Employee."Location Code";
                                    DailyAttendance.INSERT();
                                until TempCalendarLRec.NEXT() = 0;

                        end;
                    end;

                CheckDay := DATE2DMY(Employee."Period Start Date", 1);
                CheckMonth := HRSetup."Salary Processing month";
                CheckYear := HRSetup."Salary Processing Year";
                CheckDate := DMY2DATE(CheckDay, CheckMonth, CheckYear);


                DailyAttendance.RESET();
                DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                DailyAttendance.SETFILTER(Date, '=%1 | = %2', StartDate2, EndDate);
                if DailyAttendance.IsEmpty() then begin
                    Counter := Counter + 1;
                    Window.UPDATE(1, Employee."No.");
                    InsertDailyAttendance(Employee, StartDate2);
                    InsertMonthlyAttendance(Employee, CheckDate, CALCDATE(Text33002Txt, CALCDATE(Text33003Txt, CheckDate)));
                    UpdateShiftTimings(Employee);
                    ModifyMonth(Employee."Period Start Date", Employee."Period End Date");
                    Window.UPDATE(2, ROUND(Counter / Employee.COUNT() * 10000, 1));
                    Employee."Attendance Not Generated" := false;
                    Employee.MODIFY();
                end;
            until Employee.NEXT() = 0;
            Window.CLOSE();
        end;
    end;

    procedure InsertDailyAttendance(Employee: Record "Employee B2B"; StartDate: Date);
    var

        CurrMonthStart: Date;
        CurrMonthEnd: Date;
        DaysCount: Integer;
    begin
        HRSetup.RESET();
        if HRSetup.FINDFIRST() then;

        TempCalendar.SETFILTER(Date, '>=%1 & <= %2', StartDate, EndDate);
        if TempCalendar.FINDFIRST() then
            repeat
                DailyAttendance.INIT();
                DailyAttendance."Employee No." := Employee."No.";
                DailyAttendance.Date := TempCalendar.Date;
                EmployeeShiftLVar.RESET();
                EmployeeShiftLVar.SETRANGE("Employee Code", Employee."No.");
                if EmployeeShiftLVar.FINDFIRST() then begin
                    ShiftwiseOffdayLVar.RESET();
                    ShiftwiseOffdayLVar.SETRANGE("Shift Code", EmployeeShiftLVar."Shift Code");
                    ShiftwiseOffdayLVar.SETRANGE("Location Code", Employee."Location Code");
                    ShiftwiseOffdayLVar.SETRANGE("Day No.", TempCalendar."Day No.");
                    if ShiftwiseOffdayLVar.FINDFIRST() then
                        repeat
                            if ShiftwiseOffdayLVar."Week No." = ShiftwiseOffdayLVar."Week No."::All then begin
                                DailyAttendance."Non-Working" := true;
                                DailyAttendance."Non-Working Type" := DailyAttendance."Non-Working Type"::OffDay;
                                if ShiftwiseOffdayLVar."Weekly Off" = ShiftwiseOffdayLVar."Weekly Off"::"Half Day" then
                                    DailyAttendance.WeeklyOff := 0.5
                                else
                                    DailyAttendance.WeeklyOff := 1;
                            end else begin
                                CLEAR(CurrMonthStart);
                                CLEAR(CurrMonthEnd);
                                CLEAR(DaysCount);
                                CurrMonthStart := DMY2DATE(1, DATE2DMY(TempCalendar.Date, 2), DATE2DMY(TempCalendar.Date, 3));
                                CurrMonthEnd := CALCDATE(Text33003Txt, CurrMonthStart) - 1;
                                TempCalendarLRec.RESET();
                                TempCalendarLRec.SETRANGE(Date, CurrMonthStart, CurrMonthEnd);
                                TempCalendarLRec.SETRANGE("Day No.", ShiftwiseOffdayLVar."Day No.");
                                if TempCalendarLRec.FINDFIRST() then
                                    repeat
                                        DaysCount := DaysCount + 1;
                                        if (DaysCount = ShiftwiseOffdayLVar."Week No.") and (TempCalendarLRec.Date = TempCalendar.Date) then begin
                                            DailyAttendance."Non-Working" := true;
                                            DailyAttendance."Non-Working Type" := DailyAttendance."Non-Working Type"::OffDay;
                                            if ShiftwiseOffdayLVar."Weekly Off" = ShiftwiseOffdayLVar."Weekly Off"::"Half Day" then
                                                DailyAttendance.WeeklyOff := 0.5
                                            else
                                                DailyAttendance.WeeklyOff := 1;
                                        end;
                                    until TempCalendarLRec.NEXT() = 0;
                            end;
                        until ShiftwiseOffdayLVar.NEXT() = 0;
                end;
                Holiday.RESET();
                Holiday.SETRANGE(Date, TempCalendar.Date);
                Holiday.SETRANGE("Location Code", Employee."Location Code");
                if not Holiday.IsEmpty() then begin
                    DailyAttendance."Non-Working" := true;
                    DailyAttendance."Non-Working Type" := DailyAttendance."Non-Working Type"::Holiday;
                    DailyAttendance.Holiday := 1;
                end;

                DailyAttendance.Year := DATE2DMY(DailyAttendance.Date, 3);
                DailyAttendance.Month := DATE2DMY(DailyAttendance.Date, 2);
                DailyAttendance."Employee Name" := Employee."First Name";
                DailyAttendance.PayCadre := Employee."Pay Cadre";
                DailyAttendance."Leave Pay Cadre" := Employee."Leave Pay Cadre";

                if HRSetup."Default Attendance Type" = HRSetup."Default Attendance Type"::Present then
                    DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Present
                else
                    DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Absent;
                if DailyAttendance."Non-Working" then
                    DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Present;
                if DailyAttendance."Attendance Type" = DailyAttendance."Attendance Type"::Present then
                    DailyAttendance.Present := 1
                else
                    if DailyAttendance."Attendance Type" = DailyAttendance."Attendance Type"::Absent then
                        DailyAttendance.Absent := 1;
                DailyAttendance."Location Code" := Employee."Location Code";
                OnBeforeDailyAttendanceInsert(DailyAttendance);
                DailyAttendance.INSERT();
                OnAfterDailyAttendanceInsert(DailyAttendance);
            until TempCalendar.NEXT() = 0;
    end;

    procedure InsertMonthlyAttendance(Employee: Record "Employee B2B"; PeriodStartDate: Date; PeriodEndDate: Date);
    var
        MonthlyAttendance: Record "Monthly Attendance B2B";
        StartMonth: Integer;
        EndMonth: Integer;
    begin
        StartMonth := DATE2DMY(PeriodStartDate, 2);
        repeat
            DailyAttendance.SETFILTER(Date, '%1..%2', PeriodStartDate, PeriodEndDate);
            DailyAttendance.SETRANGE("Employee No.", Employee."No.");
            if not DailyAttendance.IsEmpty() then begin
                MonthlyAttendance.INIT();
                MonthlyAttendance."Employee Code" := Employee."No.";
                MonthlyAttendance."Employee Name" := Employee."First Name";
                MonthlyAttendance.PayCadre := Employee."Pay Cadre";
                MonthlyAttendance."Leave Pay Cadre" := Employee."Leave Pay Cadre";
                MonthlyAttendance."Period Start Date" := PeriodStartDate;
                MonthlyAttendance."Period End Date" := PeriodEndDate;
                MonthlyAttendance."Pay Slip Month" := DATE2DMY(MonthlyAttendance."Period End Date", 2);
                MonthlyAttendance.Year := DATE2DMY(MonthlyAttendance."Period End Date", 3);
                MonthlyAttendance."Location Code" := Employee."Location Code";
                MonthlyAttendance.CreateDim(
                  DATABASE::"Employee B2B", MonthlyAttendance."Employee Code", MonthlyAttendance);

                MonthlyAttendance."No G/L Posting" := Employee."No G/L Posting";
                OnBeforeMonthlyAttendanceInsert(MonthlyAttendance);
                MonthlyAttendance.INSERT();
                OnAfterMonthlyAttendanceInsert(MonthlyAttendance);
            end;
            PeriodStartDate := PeriodEndDate + 1;
            PeriodEndDate := (CALCDATE(Text33003Txt, PeriodStartDate) - 1);
            EndMonth := DATE2DMY(PeriodStartDate, 2);
        until StartMonth = EndMonth;
    end;

    procedure UpdateShiftTimings(Employee: Record "Employee B2B");
    var
        StartDateLVar: Date;
        EndDateLVar: Date;
        StartTime: Time;
        EndTime: Time;
        CheckTime: Time;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
    begin
        CheckTime := 130000T;
        EmployeeShift.SETRANGE("Employee Code", Employee."No.");
        if EmployeeShift.FINDFIRST() then
            repeat
                StartTime := EmployeeShift."Shift Start Time";
                EndTime := EmployeeShift."Shift End Time";
                StartDateLVar := EmployeeShift."Start Date";
                if EmployeeShift.NEXT() <> 0 then begin
                    EndDateLVar := EmployeeShift."Start Date" - 1;
                    EmployeeShift.NEXT(-1);
                end else begin
                    PayYear.SETRANGE("Year Type", Text33001Txt);
                    PayYear.SETRANGE(Closed, false);
                    if PayYear.FINDFIRST() then
                        EndDateLVar := PayYear."Year End Date";
                end;
                DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                DailyAttendance.SETFILTER(Date, '%1..%2', StartDateLVar, EndDateLVar);
                if DailyAttendance.FINDFIRST() then
                    repeat
                        DailyAttendance."Break Duration" := EmployeeShift."Break Duration";
                        DailyAttendance."Actual Time In" := StartTime;
                        DailyAttendance."Actual Time Out" := EndTime;
                        if (StartTime > CheckTime) and (EndTime < CheckTime) then begin
                            StartDateTime := CREATEDATETIME(DailyAttendance.Date, DailyAttendance."Actual Time In");
                            EndDateTime := CREATEDATETIME((DailyAttendance.Date + 1), DailyAttendance."Actual Time Out");
                            DailyAttendance."Actual Hrs" := ABS((StartDateTime - EndDateTime) / 3600000) - EmployeeShift."Break Duration";
                        end else
                            DailyAttendance."Actual Hrs" :=
                              ABS((DailyAttendance."Actual Time In" - DailyAttendance."Actual Time Out") / 3600000) -
                              EmployeeShift."Break Duration";
                        DailyAttendance."Shift Code" := EmployeeShift."Shift Code";
                        DailyAttendance.MODIFY();
                    until DailyAttendance.NEXT() = 0;
            until EmployeeShift.NEXT() = 0;
    end;

    procedure ModifyMonth(PeriodStartDate: Date; PeriodEndDate: Date);
    var
        StartDay: Integer;
        StartMonth: Integer;
        EndMonth: Integer;
        StartYear: Integer;
        EndDateLRec: Date;
    begin
        PayYear.SETRANGE("Year Type", Text33001Txt);
        PayYear.SETRANGE(Closed, false);
        if PayYear.FINDFIRST() then begin
            StartDate := PayYear."Year Start Date";
            EndDateLRec := PayYear."Year End Date";
        end;

        StartDay := DATE2DMY(PeriodStartDate, 1);
        StartMonth := DATE2DMY(StartDate, 2);
        StartYear := DATE2DMY(StartDate, 3);
        StartDate := DMY2DATE(StartDay, StartMonth, StartYear);

        PeriodStartDate := StartDate;
        PeriodEndDate := (CALCDATE(Text33003Txt, PeriodStartDate) - 1);
        repeat
            DailyAttendance.SETFILTER(Date, '%1..%2', PeriodStartDate, PeriodEndDate);
            DailyAttendance.SETRANGE("Employee No.", Employee."No.");
            if DailyAttendance.FINDFIRST() then
                repeat
                    DailyAttendance.Month := DATE2DMY(PeriodEndDate, 2);
                    DailyAttendance.Year := DATE2DMY(PeriodEndDate, 3);
                    DailyAttendance.MODIFY();
                until DailyAttendance.NEXT() = 0;
            PeriodStartDate := PeriodEndDate + 1;
            PeriodEndDate := (CALCDATE(Text33003Txt, PeriodStartDate) - 1);
            EndMonth := DATE2DMY(PeriodStartDate, 2);
        until StartMonth = EndMonth;

        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", Employee."No.");
        if DailyAttendance.FINDLAST() then
            EndDateLRec := DailyAttendance.Date;


        DailyAttendance.RESET();
        DailyAttendance.SETFILTER(Date, '%1..%2', PeriodStartDate, EndDateLRec);
        DailyAttendance.SETRANGE("Employee No.", Employee."No.");
        if DailyAttendance.FINDFIRST() then
            repeat
                DailyAttendance.Month := DATE2DMY(PeriodEndDate, 2);
                DailyAttendance.Year := DATE2DMY(PeriodEndDate, 3);
                DailyAttendance.MODIFY();
            until DailyAttendance.NEXT() = 0;
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeMonthlyAttendanceInsert(var MonthlyAttendance: Record "Monthly Attendance B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeDailyAttendanceInsert(var DailyAttendance: Record "Daily Attendance B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterMonthlyAttendanceInsert(var MonthlyAttendance: Record "Monthly Attendance B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterDailyAttendanceInsert(var DailyAttendance: Record "Daily Attendance B2B")
    begin

    end;

}

