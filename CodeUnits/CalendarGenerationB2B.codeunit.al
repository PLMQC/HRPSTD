codeunit 33001192 "Calendar Generation B2B"
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

            GenerateProvisionalLeavesOB.UpdateDate();
            GenerateProvisionalLeavesOB.USEREQUESTPAGE(false);
            GenerateProvisionalLeavesOB.RUN();
            MESSAGE(Text012Txt);
        end;

        InsertCheckList();

        TempCalendar.RESET();
        if TempCalendar.FINDSET() then
            TempCalendar.DELETEALL();
    end;

    var
        Date: Record Date;
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        PayYear: Record "Payroll Year B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        TempCalendar: Record "Temp Calendar B2B";
        EmployeeShift: Record "Employee Shift B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        TempCalendarLRec: Record "Temp Calendar B2B";
        DailyAttendOff: Record "Daily Attendance B2B";
        EmployeeOff: Record "Employee B2B";
        Weekly: Record "Shiftwise Offday B2B";
        EmpShift: Record "Employee Shift B2B";
        EmpShift2: Record "Employee Shift B2B";
        GenerateProvisionalLeavesOB: Report "Generate Prov. Leaves OB B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Window: Dialog;
        Text000Txt: Label 'Creating Calendar\Status          @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', Comment = '%1 = Employee';
        Text001Txt: Label 'No Holidays are defined for this leave year, Do you want to continue';
        Text002Txt: Label 'Creating attendance records for ...\Employee        #1########\Status          @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', Comment = '%1 = Employee;%2 = Status';
        StartDate: Date;
        EndDate: Date;
        Text010Txt: Label 'Verifications......\Employee        #1########\Status          @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', Comment = '%1 = Employee;%2 = Status';
        Text011Txt: Label 'Lock the HR Setup Table';
        Text006Txt: Label 'Shift must be definee for the employee %1 for the period.', Comment = '%1 = Employee';
        Text003Txt: Label 'Attendance Generated.';
        Text004Txt: Label 'Attendance already exist for this leave year.';
        Text012Txt: Label 'Leaves generated successfully.';
        Text33001Txt: Label 'LEAVE YEAR';
        Text33002Txt: Label 'Date';
        Text33003Txt: Label '<1M>';
        Text33004Txt: Label '<-1D>';
        Text33005Txt: Label '<-1Y>';
        Text33006Txt: Label '<+1Y>';
        Text33007Txt: Label '0001';
        Text33008Txt: Label 'Payroll Years';
        Text33009Txt: Label 'Payroll Years not defined';
        Text33010Txt: Label '1001';
        Text33011Txt: Label '0002';
        Text33012Txt: Label 'New Employee';
        Text33013Txt: Label '2001';
        Text33014Txt: Label '2002';
        Text33015Txt: Label '2003';
        Text33016Txt: Label '2004';
        Text33017Txt: Label '2005';
        Text33018Txt: Label '2006';
        Text33019Txt: Label '2007';
        Text33020Txt: Label '2008';
        Text33021Txt: Label '2009';
        Text33022Txt: Label '2010';
        Text33023Txt: Label '2011';
        Text33024Txt: Label '2012';
        Text33025Txt: Label '2013';
        Text33026Txt: Label '2014';
        Text33027Txt: Label 'Employment Date not defined';
        Text33028Txt: Label 'Pay Elements not defined';
        Text33029Txt: Label 'Pay Cadre not defined';
        Text33030Txt: Label 'Leave Pay Cadre not defined';
        Text33031Txt: Label 'Employee Posting Group not defined';
        Text33032Txt: Label 'Business Posting Group not defined';
        Text33033Txt: Label 'PT Branch Code not defined';
        Text33034Txt: Label 'OT Applicability';
        Text33035Txt: Label 'ESI Applicability';
        Text33036Txt: Label 'PF Applicability';
        Text33037Txt: Label 'VDA Applicability';
        Text33038Txt: Label 'Attendance Not Generated';
        Text33039Txt: Label 'Leaves Not Generated';
        Text33040Txt: Label 'Department not defined';
        Text33041Txt: Label 'Cash/Bank Account';
        Text33042Txt: Label '0003';
        Text33043Txt: Label 'Loan';
        Text33044Txt: Label '3001';
        Text33045Txt: Label 'Installments not defined';
        Text33046Txt: Label '0004';
        Text33047Txt: Label '0005';
        Text33048Txt: Label 'TDS Deductions';
        Text33049Txt: Label '4001';
        Text33050Txt: Label 'TDS Schedule not defined';
        Text33051Txt: Label 'Other Pay Elements';
        Text33052Txt: Label '5001';
        Text33053Txt: Label 'Other Pay Elements not posted';
        Text33054Txt: Label '0006';
        Text33055Txt: Label '0007';
        Text33056Txt: Label '6001';
        Text33057Txt: Label 'Pay Revision not posted';
        Text33058Txt: Label '7001';
        Text33059Txt: Label '7002';
        Text33060Txt: Label '7003';
        Text33061Txt: Label '7004';
        Text33062Txt: Label 'Leaves';
        Text33063Txt: Label 'Leaves Applied but not posted';
        Text33064Txt: Label 'Leaves posted but not Authorised';
        Text33065Txt: Label 'Leaves cancelled but not posted';
        Text33066Txt: Label 'Leaves cancelled but not Approved';
        Text33067Txt: Label 'Pay Revision';

    procedure CheckValidations(): Boolean;
    var
        Holiday: Record Holiday_B2B;

        CheckDate: Date;
        Count2: Integer;
        Flag: Boolean;
        Answer: Boolean;
        EmpCount: Integer;
        EmpErr: Label 'No Records found in Employee table.';
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
        if Employee.FINDSET() then
            repeat
                Flag := false;
                if Employee."Employment Date" <= StartDate then
                    CheckDate := StartDate
                else
                    if (StartDate <= Employee."Employment Date") and (Employee."Employment Date" <= EndDate) then
                        CheckDate := Employee."Employment Date";


                EmployeeShift.SETRANGE("Employee Code", Employee."No.");
                if EmployeeShift.FINDSET() then
                    repeat
                        if EmployeeShift."Start Date" <= CheckDate then
                            Flag := true;
                    until EmployeeShift.NEXT() = 0;
                if not Flag then
                    ERROR(Text006Txt, Employee."No.");
            until Employee.NEXT() = 0;

        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            Employee.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            Employee.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if Holiday.FINDFIRST() then begin
            Count2 := 0;
            repeat
                if (StartDate <= Holiday.Date) and (EndDate >= Holiday.Date) then
                    Count2 := Count2 + 1
            until Holiday.NEXT() = 0;
        end;

        if Count2 = 0 then begin
            Answer := DIALOG.CONFIRM(Text001Txt, true);
            exit(Answer);
        end else
            exit(true);
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
        Date.SETFILTER("Period Type", Text33002Txt);
        Date.SETFILTER(Date."Period Start", '>=%1 & <= %2', StartDate, EndDate);
        if Date.FINDFIRST() then begin
            Counter := 0;
            repeat
                Counter := Counter + 1;
                TempCalendar.INIT();
                TempCalendar.Date := Date."Period Start";
                TempCalendar.Description := copystr(Date."Period Name", 1, 30);
                TempCalendar."Day No." := Date."Period No.";
                TempCalendar.INSERT();
                Window.UPDATE(1, ROUND(Counter / TempCalendar.COUNT() * 10000, 1));
            until Date.NEXT() = 0;
        end;
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
                        CheckDay := DATE2DMY(StartDate2, 1);
                        CheckMonth := DATE2DMY(StartDate2, 2);
                        CheckYear := DATE2DMY(StartDate2, 3);
                        CheckDate := DMY2DATE(CheckDay, CheckMonth, CheckYear);
                        TestDate := CheckDate;

                        DailyAttendance.RESET();
                        DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                        DailyAttendance.SETFILTER(Date, '=%1 | = %2', TestDate, EndDate);
                        if not DailyAttendance.FINDFIRST() then begin
                            while (CheckDate > StartDate2) do begin
                                if CheckMonth <> 1 then
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
                    if (DATE2DMY(StartDate, 3) <> DATE2DMY(Employee."Period End Date", 3)) then
                        ModifyPeriods(Employee);

                    InsertMonthlyAttendance(Employee, CheckDate, CALCDATE(Text33004Txt, CALCDATE(Text33003Txt, CheckDate)));
                    UpdateShiftTimings(Employee);
                    Offdays(Employee."No.");

                    Window.UPDATE(2, ROUND(Counter / Employee.COUNT() * 10000, 1));
                    Employee."Attendance Not Generated" := false;
                    Employee.MODIFY();
                end else
                    ERROR(Text004Txt);
            until Employee.NEXT() = 0;
            Window.CLOSE();
        end;

        Employee.RESET();
        Employee.SETRANGE(Blocked, false);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            Employee.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            Employee.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if Employee.FINDFIRST() then begin
            Window.OPEN(Text010Txt);
            Counter := 0;
            repeat
                Counter := Counter + 1;
                Window.UPDATE(1, Employee."No.");
                ModifyMonth(Employee."Period Start Date", Employee."Period End Date");
                Window.UPDATE(2, ROUND(Counter / Employee.COUNT() * 10000, 1));
            until Employee.NEXT() = 0;
            Window.CLOSE();
        end;
    end;

    procedure InsertDailyAttendance(Employee: Record "Employee B2B"; StartDate: Date);
    var

        Holiday: Record Holiday_B2B;
    begin
        HRSetup.RESET();
        if HRSetup.FINDFIRST() then;

        TempCalendarLRec.SETFILTER(Date, '>=%1 & <= %2', StartDate, EndDate);
        if TempCalendarLRec.FINDFIRST() then
            repeat
                DailyAttendance.INIT();
                DailyAttendance."Employee No." := Employee."No.";
                DailyAttendance.Date := TempCalendarLRec.Date;

                Holiday.RESET();
                Holiday.SETRANGE("Location Code", Employee."Location Code");
                Holiday.SETRANGE(Date, TempCalendarLRec.Date);
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
                DailyAttendance.INSERT();
            until TempCalendarLRec.NEXT() = 0;
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
                //B2BMMOn19Aug2022>>
                MonthlyAttendance."Physical Location" := Employee."Physical Location";
                MonthlyAttendance."Department Code" := Employee."Department Code";
                //B2BMMOn19Aug2022<<
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
                            DailyAttendance."Actual Hrs" := (ABS((StartDateTime - EndDateTime) / 3600000) - (EmployeeShift."Break Duration"));
                        end else
                            DailyAttendance."Actual Hrs" :=
                              (ABS((DailyAttendance."Actual Time In" - DailyAttendance."Actual Time Out") / 3600000) -
                              (EmployeeShift."Break Duration"));

                        DailyAttendance."Shift Code" := EmployeeShift."Shift Code";
                        DailyAttendance.MODIFY();
                    until DailyAttendance.NEXT() = 0;
            until EmployeeShift.NEXT() = 0;
    end;

    procedure ModifyMonth(PeriodStartDate: Date; PeriodEndDate: Date);
    var
        DailyAttendance2: Record "Daily Attendance B2B";
        StartDay: Integer;
        StartMonth: Integer;
        EndMonth: Integer;
        StartYear: Integer;
        Endyear: Integer;
        EndDateLVar: Date;
    begin
        PayYear.SETRANGE("Year Type", Text33001Txt);
        PayYear.SETRANGE(Closed, false);
        if PayYear.FINDFIRST() then begin
            StartDate := PayYear."Year Start Date";
            EndDateLVar := PayYear."Year End Date";
            Endyear := DATE2DMY(EndDateLVar, 3);
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
        DailyAttendance.SETRANGE(Year, Endyear + 1);
        if DailyAttendance.FINDFIRST() then
            repeat
                DailyAttendance2.INIT();
                DailyAttendance2.TRANSFERFIELDS(DailyAttendance);
                DailyAttendance2.Year := Endyear;
                DailyAttendance2.Date := CALCDATE(Text33005Txt, DailyAttendance.Date);
                OnBeforeDailyAttendanceInsert(DailyAttendance2);
                DailyAttendance2.INSERT();
                OnAfterDailyAttendanceInsert(DailyAttendance2);
                DailyAttendance.DELETE();
            until DailyAttendance.NEXT() = 0;
    end;

    procedure ModifyPeriods(var EmployeeLocal: Record "Employee B2B");
    begin
        EmployeeLocal."Period Start Date" := CALCDATE(Text33006Txt, EmployeeLocal."Period Start Date");
        EmployeeLocal."Period End Date" := CALCDATE(Text33006Txt, EmployeeLocal."Period End Date");
        EmployeeLocal.MODIFY();
    end;

    procedure InsertCheckList();
    var
        PrevMonth: Integer;
        PrevYear: Integer;
        CurrentMonth: Integer;
        CurrentYear: Integer;
    begin
        TempCalendar.RESET();
        if TempCalendar.FINDFIRST() then
            repeat
                CurrentMonth := DATE2DMY(TempCalendar.Date, 2);
                CurrentYear := DATE2DMY(TempCalendar.Date, 3);
                if (CurrentMonth <> PrevMonth) or (CurrentYear <> PrevYear) then begin
                    InsertMonthlyDetails(CurrentMonth, CurrentYear);
                    PrevMonth := CurrentMonth;
                    PrevYear := CurrentYear;
                end;
            until TempCalendar.NEXT() = 0;
    end;

    procedure InsertMonthlyDetails(CurrentMonth: Integer; CurrentYear: Integer);
    var
        CheckList: Record "Salary Process Check List B2B";
        CheckList2: Record "Salary Process Check List B2B";
    begin
        CheckList.RESET();
        CheckList.SETRANGE(Month, CurrentMonth);
        CheckList.SETRANGE(Year, CurrentYear);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            Employee.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            Employee.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if CheckList.IsEmpty() then begin
            CheckList2.INIT();
            CheckList2."Line No" := ReturnLineNo();
            CheckList2.Month := CurrentMonth;
            CheckList2.Year := CurrentYear;
            CheckList2.ID := Text33007Txt;
            CheckList2.Description := Text33008Txt;
            CheckList2.Status := CheckList2.Status::"Not Started";
            CheckList2.Level := 0;
            CheckList2.INSERT();

            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33010Txt, Text33009Txt,
            CheckList2.Status::"Not Started", 1, Text33007Txt);

            CheckList2."Line No" := ReturnLineNo();
            CheckList2.Month := CurrentMonth;
            CheckList2.Year := CurrentYear;
            CheckList2.ID := Text33011Txt;
            CheckList2.Description := Text33012Txt;
            CheckList2.Status := CheckList2.Status::"Not Started";
            CheckList2.Level := 0;
            CheckList2.INSERT();

            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33013Txt, Text33027Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33014Txt, Text33028Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33015Txt, Text33029Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33015Txt, Text33030Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33016Txt, Text33031Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33017Txt, Text33032Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33018Txt, Text33033Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33019Txt, Text33034Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33020Txt, Text33035Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33021Txt, Text33036Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33022Txt, Text33037Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33023Txt, Text33038Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33024Txt, Text33039Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33025Txt, Text33040Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33026Txt, Text33041Txt,
            CheckList2.Status::"Not Started", 1, Text33011Txt);

            CheckList2."Line No" := ReturnLineNo();
            CheckList2.Month := CurrentMonth;
            CheckList2.Year := CurrentYear;
            CheckList2.ID := Text33042Txt;
            CheckList2.Description := Text33043Txt;
            CheckList2.Status := CheckList2.Status::"Not Started";
            CheckList2.Level := 0;
            CheckList2.INSERT();

            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33044Txt, Text33045Txt,
            CheckList2.Status::"Not Started", 1, Text33042Txt);

            CheckList2."Line No" := ReturnLineNo();
            CheckList2.Month := CurrentMonth;
            CheckList2.Year := CurrentYear;
            CheckList2.ID := Text33046Txt;
            CheckList2.Description := Text33048Txt;
            CheckList2.Status := CheckList2.Status::"Not Started";
            CheckList2.Level := 0;
            CheckList2.INSERT();

            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33049Txt, Text33050Txt,
            CheckList2.Status::"Not Started", 1, Text33046Txt);

            CheckList2."Line No" := ReturnLineNo();
            CheckList2.Month := CurrentMonth;
            CheckList2.Year := CurrentYear;
            CheckList2.ID := Text33047Txt;
            CheckList2.Description := Text33051Txt;
            CheckList2.Status := CheckList2.Status::"Not Started";
            CheckList2.Level := 0;
            CheckList2.INSERT();

            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33052Txt, Text33053Txt,
            CheckList2.Status::"Not Started", 1, Text33047Txt);

            CheckList2."Line No" := ReturnLineNo();
            CheckList2.Month := CurrentMonth;
            CheckList2.Year := CurrentYear;
            CheckList2.ID := Text33054Txt;
            CheckList2.Description := Text33067Txt;
            CheckList2.Status := CheckList2.Status::"Not Started";
            CheckList2.Level := 0;
            CheckList2.INSERT();

            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33056Txt, Text33057Txt,
            CheckList2.Status::"Not Started", 1, Text33054Txt);

            CheckList2."Line No" := ReturnLineNo();
            CheckList2.Month := CurrentMonth;
            CheckList2.Year := CurrentYear;
            CheckList2.ID := Text33055Txt;
            CheckList2.Description := Text33062Txt;
            CheckList2.Status := CheckList2.Status::"Not Started";
            CheckList2.Level := 0;
            CheckList2.INSERT();

            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33058Txt, Text33063Txt,
            CheckList2.Status::"Not Started", 1, Text33055Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33059Txt, Text33064Txt,
            CheckList2.Status::"Not Started", 1, Text33055Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33060Txt, Text33065Txt,
            CheckList2.Status::"Not Started", 1, Text33055Txt);
            InsertSubGroups(ReturnLineNo(), CurrentYear, CurrentMonth, Text33061Txt, Text33066Txt,
            CheckList2.Status::"Not Started", 1, Text33055Txt);
        end;
    end;

    procedure InsertSubGroups(ProcessLineNo: Integer; ProcessYear: Integer; ProcessMonth: Integer; ChkListSubID: Code[20]; Description: Text[50]; ProcessStatus: Option; ProcessLevel: Integer; ParentRefID: Code[20]);
    var
        SubCheckList: Record "Salary Process Check List B2B";
    begin
        SubCheckList.INIT();
        SubCheckList."Line No" := ProcessLineNo;
        SubCheckList.Month := ProcessMonth;
        SubCheckList.Year := ProcessYear;
        SubCheckList."Sub ID" := ChkListSubID;
        SubCheckList.Description := Description;
        SubCheckList.Status := ProcessStatus;
        SubCheckList.Level := ProcessLevel;
        SubCheckList."Parent Ref ID" := ParentRefID;
        SubCheckList.INSERT();
    end;

    procedure ReturnLineNo(): Integer;
    var
        ProcessCheckList: Record "Salary Process Check List B2B";
        ProcessLineNo: Integer;
    begin
        ProcessCheckList.RESET();
        if ProcessCheckList.FINDLAST() then
            ProcessLineNo := ProcessCheckList."Line No"
        else
            ProcessLineNo := 0;
        exit(ProcessLineNo + 1);
    end;

    procedure Offdays(EmpCode: Code[20]);
    var
        TempEmpShift: Record "Employee Shift B2B" temporary;
        ShiftCode: Code[20];
        "Count": Integer;
        MonthStartDate: Date;
        StartDateLVar: Date;
        EndDateLVar: Date;
        ShiftStartDate: Date;
        ShiftEndDate: Date;
    begin
        PayYear.SETRANGE("Year Type", Text33001Txt);
        PayYear.SETRANGE(Closed, false);
        if PayYear.FINDFIRST() then begin
            StartDateLVar := PayYear."Year Start Date";
            EndDateLVar := PayYear."Year End Date";
        end;

        if EmployeeOff.GET(EmpCode) then
            if StartDateLVar <= EmployeeOff."Employment Date" then
                StartDateLVar := EmployeeOff."Employment Date";


        TempEmpShift.DELETEALL();

        EmpShift.SETRANGE("Employee Code", EmpCode);
        EmpShift.SETFILTER("Start Date", '<=%1', StartDateLVar);
        if EmpShift.FINDLAST() then begin
            EmpShift2.RESET();
            EmpShift2.SETRANGE("Employee Code", EmpShift."Employee Code");
            EmpShift2.SETFILTER("Start Date", '>= %1', EmpShift."Start Date");
            if EmpShift2.FINDFIRST() then
                repeat
                    TempEmpShift.INIT();
                    TempEmpShift.TRANSFERFIELDS(EmpShift2);
                    TempEmpShift.INSERT();
                until EmpShift2.NEXT() = 0;
        end;

        if TempEmpShift.FINDFIRST() then
            repeat
                ShiftCode := TempEmpShift."Shift Code";
                if TempEmpShift."Start Date" <= StartDateLVar then
                    ShiftStartDate := StartDateLVar
                else
                    ShiftStartDate := TempEmpShift."Start Date";
                if TempEmpShift.NEXT() <> 0 then begin
                    ShiftEndDate := TempEmpShift."Start Date" - 1;
                    TempEmpShift.NEXT(-1);
                end else
                    ShiftEndDate := EndDateLVar;

                Weekly.RESET();
                Weekly.SETRANGE("Location Code", EmployeeOff."Location Code");
                Weekly.SETRANGE("Shift Code", ShiftCode);
                if Weekly.FINDFIRST() then
                    repeat
                        if Weekly."Week No." = Weekly."Week No."::All then begin
                            TempCalendar.RESET();
                            TempCalendar.SETFILTER(Date, '%1..%2', ShiftStartDate, ShiftEndDate);
                            TempCalendar.SETRANGE("Day No.", Weekly."Day No.");
                            if TempCalendar.FINDFIRST() then
                                repeat
                                    DailyAttendOff.SETRANGE("Employee No.", EmpCode);
                                    DailyAttendOff.SETRANGE(Date, TempCalendar.Date);
                                    if DailyAttendOff.FINDFIRST() then
                                        repeat
                                            DailyAttendOff."Non-Working" := true;
                                            DailyAttendOff."Non-Working Type" := DailyAttendOff."Non-Working Type"::OffDay;
                                            DailyAttendOff."Attendance Type" := DailyAttendOff."Attendance Type"::Present;
                                            DailyAttendOff.Present := 1;
                                            DailyAttendOff.Absent := 0;
                                            if Weekly."Weekly Off" = Weekly."Weekly Off"::"Half Day" then
                                                DailyAttendOff.WeeklyOff := 0.5
                                            else
                                                DailyAttendOff.WeeklyOff := 1;
                                            OnBeforeUpdateOffDays(DailyAttendOff);
                                            DailyAttendOff.MODIFY();
                                            OnAfterUpdateOffDays(DailyAttendOff);
                                        until DailyAttendOff.NEXT() = 0;
                                until TempCalendar.NEXT() = 0;
                        end else begin
                            if DATE2DMY(ShiftStartDate, 1) = 1 then
                                MonthStartDate := ShiftStartDate
                            else
                                MonthStartDate := DMY2DATE(1, DATE2DMY(ShiftStartDate, 2), DATE2DMY(ShiftStartDate, 3));
                            repeat
                                Count := 0;
                                TempCalendar.RESET();
                                TempCalendar.SETFILTER(Date, '%1..%2', MonthStartDate, CALCDATE(Text33003Txt, MonthStartDate) - 1);
                                TempCalendar.SETRANGE("Day No.", Weekly."Day No.");
                                if TempCalendar.FINDFIRST() then
                                    repeat
                                        Count := Count + 1;
                                        if Count = Weekly."Week No." then begin
                                            DailyAttendOff.RESET();
                                            DailyAttendOff.SETRANGE("Employee No.", EmpCode);
                                            DailyAttendOff.SETRANGE(Date, TempCalendar.Date);
                                            if DailyAttendOff.FINDFIRST() then
                                                if DailyAttendOff.Date > TempEmpShift."Start Date" then begin
                                                    DailyAttendOff."Non-Working" := true;
                                                    DailyAttendOff."Non-Working Type" := DailyAttendOff."Non-Working Type"::OffDay;
                                                    DailyAttendOff."Attendance Type" := DailyAttendOff."Attendance Type"::Present;
                                                    DailyAttendOff.Present := 1;
                                                    DailyAttendOff.Absent := 0;

                                                    if Weekly."Weekly Off" = Weekly."Weekly Off"::"Half Day" then
                                                        DailyAttendOff.WeeklyOff := 0.5
                                                    else
                                                        DailyAttendOff.WeeklyOff := 1;
                                                    OnBeforeUpdateOffDays(DailyAttendOff);
                                                    DailyAttendOff.MODIFY();
                                                    OnAfterUpdateOffDays(DailyAttendOff);
                                                end;
                                        end;
                                    until TempCalendar.NEXT() = 0;
                                MonthStartDate := CALCDATE(Text33003Txt, MonthStartDate);
                            until MonthStartDate > ShiftEndDate;
                        end;
                    until Weekly.NEXT() = 0;

            until (TempEmpShift.NEXT() = 0) or (ShiftStartDate >= EndDateLVar)
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
    procedure OnBeforeUpdateOffDays(var DailyAttendance: Record "Daily Attendance B2B")
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

    [IntegrationEvent(false, false)]
    procedure OnAfterUpdateOffDays(var DailyAttendance: Record "Daily Attendance B2B")
    begin

    end;
}

