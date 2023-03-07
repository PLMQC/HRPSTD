page 33001339 "OT Approval Date Wise old B2B"
{
    // version B2BHR1.00.00

    Caption = 'OT Approval Day Wise';
    DelayedInsert = true;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "OT Approval B2B";
    SourceTableView = SORTING("Employee No.", Date)
                      ORDER(Ascending)
                      WHERE(Updated = FILTER(false));
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DateFilterGVar1; DateFilterGVar)
                {
                    Caption = 'Date Filter';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Dates in which the Employee has worked extra hours';

                    trigger OnValidate();
                    begin
                        DateFilterGVarOnAfterValidate();
                    end;
                }
            }
            repeater(OTList)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify / Pick the Employee No as per list displayed';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee User ID as per list displayed';
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify / define the dates which the employee has worked towards OT';
                }
                field("OT Hrs"; "OT Hrs")
                {
                    ApplicationArea = all;
                    ToolTip = 'Based on the OT Date the Number of Hours will be computed';
                }
                field("OT Approved Hrs"; "OT Approved Hrs")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the data once the OT is approved by a user';
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify any General Remarks / Notes';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Get OT Details")
                {
                    Caption = 'Get OT Details';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'The OT approved wll be called and shown here';

                    trigger OnAction();
                    begin
                        if (STRPOS(DateFilterGVar, '..') > 0) then
                            GetOTDetailsbyRangeOfDates()
                        else
                            GetOTDetails();
                    end;
                }
                action("Update OT Details")
                {
                    Caption = 'Update OT Details';
                    Image = UpdateShipment;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Approve the OT Details';

                    trigger OnAction();
                    begin
                        if (STRPOS(FORMAT(DateFilterGVar), '..') > 0) then
                            UpdateOTDetailsByRangeOfDates()
                        else
                            UpdateOTDetails();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        if (STRPOS(FORMAT(DateFilterGVar), '..') > 0) then begin
            FILTERGROUP(2);
            PayrollUsers.GET(USERID());
            if PayrollUsers."Multiple Locations" <> '' then
                SETFILTER("Location Code", PayrollUsers."Multiple Locations")
            else
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            FILTERGROUP(0);
            SETFILTER(Date, DateFilterGVar);
            SETRANGE(Updated, false);
        end else begin
            FILTERGROUP(2);
            PayrollUsers.GET(USERID());
            if PayrollUsers."Multiple Locations" <> '' then
                SETFILTER("Location Code", PayrollUsers."Multiple Locations")
            else
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            FILTERGROUP(0);
            SETRANGE(Date, DateString);
        end;
    end;

    var
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        DateFilterGVar: Text[30];
        DateString: Date;
        StartDateText: Text[30];
        EndDateText: Text[30];
        StartDate: Date;
        EndDate: Date;
        StartMonth: Integer;
        EndMonth: Integer;
        Loop: Integer;
        OTHrs: Decimal;
        OTDecimal: Decimal;

        Text001Lbl: Label 'Please enter the date filter';
        Text002Lbl: Label 'Salary already posted in this date %1', Comment = '%1 = DateString';
        Text003Lbl: Label 'Records inserted successfully';
        Text004Lbl: Label 'There is nothing to update';
        Text005Lbl: Label 'OT Details updated Successfully';
        Text006Lbl: Label 'Salary already posted in this Month %1', Comment = '%1 = Loop';
        Text007Lbl: Label 'Do you want to retrieve OT details';
        Text008Lbl: Label 'Employee No #1########\ Date #2#######\ Progress @3@@@@@@@@@', Comment = '%1 = No ; %2 =Date ;%3 = Progress';
        Text009Lbl: Label 'Do you want to retrieve OT details';
        Text010Lbl: Label 'Some of the records with "OT Approved Hrs" zero exists,Do you want to continue?';
        Text011Lbl: Label 'Do you want to update OT details';

    procedure GetOTDetails();
    var
        MonthlyAttLRec: Record "Monthly Attendance B2B";
        DailyAttLRec: Record "Daily Attendance B2B";
        OTAppLRec: Record "OT Approval B2B";
        RecordsUpdated: Boolean;
    begin
        if DateString = 0D then
            ERROR(Text001Lbl);
        MonthlyAttLRec.RESET();
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonthlyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonthlyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        MonthlyAttLRec.SETRANGE("Pay Slip Month", DATE2DMY(DateString, 2));
        MonthlyAttLRec.SETRANGE(Year, DATE2DMY(DateString, 3));
        MonthlyAttLRec.SETRANGE(Posted, true);
        if not MonthlyAttLRec.IsEmpty() then
            ERROR(Text002Lbl, DateString);
        if not CONFIRM(Text009Lbl) then
            exit;

        CLEAR(RecordsUpdated);
        DailyAttLRec.RESET();
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            DailyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            DailyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        DailyAttLRec.SETRANGE(Year, DATE2DMY(DateString, 3));
        DailyAttLRec.SETRANGE(Month, DATE2DMY(DateString, 2));
        DailyAttLRec.SETRANGE(Date, DateString);
        DailyAttLRec.SETFILTER("OT Hrs", '<>%1', 0);
        if DailyAttLRec.FINDFIRST() then
            repeat
                OTAppLRec.RESET();
                OTAppLRec.SETRANGE("Employee No.", DailyAttLRec."Employee No.");
                OTAppLRec.SETRANGE(Date, DailyAttLRec.Date);
                if not OTAppLRec.FINDFIRST() then begin
                    OTAppLRec.INIT();
                    OTAppLRec."Employee No." := DailyAttLRec."Employee No.";
                    OTAppLRec.Date := DailyAttLRec.Date;
                    OTAppLRec.Year := DailyAttLRec.Year;
                    OTAppLRec.Month := DailyAttLRec.Month;
                    OTAppLRec."Employee Name" := DailyAttLRec."Employee Name";
                    OTAppLRec."OT Hrs" := DailyAttLRec."OT Hrs";
                    CLEAR(OTHrs);
                    CLEAR(OTDecimal);
                    OTHrs := ROUND(DailyAttLRec."OT Hrs", 1, '<');
                    OTDecimal := DailyAttLRec."OT Hrs" - OTHrs;
                    OTAppLRec."Location Code" := DailyAttLRec."Location Code";
                    if OTAppLRec.INSERT() then
                        RecordsUpdated := true;
                end;
            until DailyAttLRec.NEXT() = 0;
        if RecordsUpdated then
            MESSAGE(Text003Lbl)
    end;

    procedure UpdateOTDetails();
    var
        MonthlyAttLRec: Record "Monthly Attendance B2B";
        DailyAttLRec: Record "Daily Attendance B2B";
        OTAppLRec: Record "OT Approval B2B";
        RecordsUpdated: Boolean;
        "LineNo.": Integer;
        TotalLines: Integer;
        Window: Dialog;
    begin
        if DateString = 0D then
            ERROR(Text001Lbl);

        MonthlyAttLRec.RESET();
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonthlyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonthlyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        MonthlyAttLRec.SETRANGE("Pay Slip Month", DATE2DMY(DateString, 2));
        MonthlyAttLRec.SETRANGE(Year, DATE2DMY(DateString, 3));
        MonthlyAttLRec.SETRANGE(Posted, true);
        if not MonthlyAttLRec.IsEmpty() then
            ERROR(Text002Lbl, DateString);
        OTAppLRec.RESET();
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            OTAppLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            OTAppLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        OTAppLRec.SETRANGE(Year, DATE2DMY(DateString, 3));
        OTAppLRec.SETRANGE(Month, DATE2DMY(DateString, 2));
        OTAppLRec.SETRANGE(Updated, false);
        OTAppLRec.SETFILTER("OT Approved Hrs", '=%1', 0);
        if OTAppLRec.FINDFIRST() then
            if not CONFIRM(Text010Lbl) then
                exit;

        if not CONFIRM(Text011Lbl) then
            exit;

        CLEAR(RecordsUpdated);
        OTAppLRec.RESET();
        OTAppLRec.SETRANGE(Year, DATE2DMY(DateString, 3));
        OTAppLRec.SETRANGE(Month, DATE2DMY(DateString, 2));
        OTAppLRec.SETRANGE(Updated, false);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            OTAppLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            OTAppLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        "LineNo." := 0;
        TotalLines := OTAppLRec.COUNT();
        Window.OPEN(Text008Lbl);

        if OTAppLRec.FINDFIRST() then
            repeat
                "LineNo." := "LineNo." + 1;
                DailyAttLRec.GET(OTAppLRec."Employee No.", OTAppLRec.Date);
                DailyAttLRec.VALIDATE("OT Approved Hrs", OTAppLRec."OT Approved Hrs");
                if DailyAttLRec.MODIFY() then begin
                    OTAppLRec.Updated := true;
                    Evaluate(OTAppLRec."Approved By", USERID());
                    OTAppLRec."Approval Date" := workdate();
                    OTAppLRec.MODIFY();
                    RecordsUpdated := true;
                end;
                Window.UPDATE(1, OTAppLRec."Employee No.");
                Window.UPDATE(2, OTAppLRec.Date);
                Window.UPDATE(3, ROUND("LineNo." / TotalLines * 10000, 1));
                SLEEP(100);
            until OTAppLRec.NEXT() = 0;

        if RecordsUpdated then
            MESSAGE(Text005Lbl)
        else
            ERROR(Text004Lbl);
        CurrPage.UPDATE();
    end;

    procedure ApplyFilters();
    begin
        if (STRPOS(FORMAT(DateFilterGVar), '..') > 0) then begin
            FILTERGROUP(2);
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            FILTERGROUP(0);
            SETFILTER(Date, '%1..%2', StartDate, EndDate);
            SETRANGE(Updated, false);
            CurrPage.UPDATE();
        end else begin
            FILTERGROUP(2);
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            FILTERGROUP(0);
            SETRANGE(Date, DateString);
            CurrPage.UPDATE();
        end;
    end;

    procedure GetOTDetailsbyRangeOfDates();
    var
        MonthlyAttLRec: Record "Monthly Attendance B2B";
        DailyAttLRec: Record "Daily Attendance B2B";
        OTAppLRec: Record "OT Approval B2B";
        RecordsUpdated: Boolean;
    begin
        CLEAR(StartMonth);
        CLEAR(EndMonth);
        CLEAR(Loop);
        if DateFilterGVar = '' then
            ERROR(Text001Lbl);

        StartMonth := DATE2DMY(StartDate, 2);
        EndMonth := DATE2DMY(EndDate, 2);
        Year := DATE2DMY(StartDate, 3);
        Loop := StartMonth;
        repeat
            MonthlyAttLRec.RESET();
            FILTERGROUP(2);
            PayrollUsers.GET(USERID());
            if PayrollUsers."Multiple Locations" <> '' then
                MonthlyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
            else
                MonthlyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            FILTERGROUP(0);
            MonthlyAttLRec.SETRANGE("Pay Slip Month", Loop);
            MonthlyAttLRec.SETRANGE(Year, Year);
            MonthlyAttLRec.SETRANGE(Posted, true);
            if not MonthlyAttLRec.IsEmpty() then
                ERROR(Text006Lbl, Loop);
            Loop := Loop + 1;
        until Loop = EndMonth + 1;
        if not CONFIRM(Text007Lbl) then
            exit;

        CLEAR(RecordsUpdated);
        DailyAttLRec.RESET();
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            DailyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            DailyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        DailyAttLRec.SETFILTER(Date, '%1..%2', StartDate, EndDate);
        DailyAttLRec.SETFILTER("OT Hrs", '<>%1', 0);
        if DailyAttLRec.FINDFIRST() then
            repeat
                OTAppLRec.RESET();
                OTAppLRec.SETRANGE("Employee No.", DailyAttLRec."Employee No.");
                OTAppLRec.SETRANGE(Date, DailyAttLRec.Date);
                if not OTAppLRec.FINDFIRST() then begin
                    OTAppLRec.INIT();
                    OTAppLRec."Employee No." := DailyAttLRec."Employee No.";
                    OTAppLRec.Date := DailyAttLRec.Date;
                    OTAppLRec.Year := DailyAttLRec.Year;
                    OTAppLRec.Month := DailyAttLRec.Month;
                    OTAppLRec."Employee Name" := DailyAttLRec."Employee Name";
                    OTAppLRec."OT Hrs" := DailyAttLRec."OT Hrs";
                    CLEAR(OTHrs);
                    CLEAR(OTDecimal);
                    OTHrs := ROUND(DailyAttLRec."OT Hrs", 1, '<');
                    OTDecimal := DailyAttLRec."OT Hrs" - OTHrs;
                    OTAppLRec."Location Code" := DailyAttLRec."Location Code";
                    if OTAppLRec.INSERT() then
                        RecordsUpdated := true;
                end;
            until DailyAttLRec.NEXT() = 0;
        if RecordsUpdated then
            MESSAGE(Text003Lbl)
    end;

    procedure UpdateOTDetailsByRangeOfDates();
    var
        MonthlyAttLRec: Record "Monthly Attendance B2B";
        DailyAttLRec: Record "Daily Attendance B2B";
        OTAppLRec: Record "OT Approval B2B";
        RecordsUpdated: Boolean;
        "LineNo.": Integer;
        TotalLines: Integer;
        Window: Dialog;
    begin
        CLEAR(StartMonth);
        CLEAR(EndMonth);
        CLEAR(Loop);
        if DateFilterGVar = '' then
            ERROR(Text001Lbl);

        StartMonth := DATE2DMY(StartDate, 2);
        EndMonth := DATE2DMY(EndDate, 2);
        Year := DATE2DMY(StartDate, 3);
        Loop := StartMonth;
        repeat
            MonthlyAttLRec.RESET();
            FILTERGROUP(2);
            PayrollUsers.GET(USERID());
            if PayrollUsers."Multiple Locations" <> '' then
                MonthlyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
            else
                MonthlyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            FILTERGROUP(0);
            MonthlyAttLRec.SETRANGE("Pay Slip Month", Loop);
            MonthlyAttLRec.SETRANGE(Year, Year);
            MonthlyAttLRec.SETRANGE(Posted, true);
            if not MonthlyAttLRec.IsEmpty() then
                ERROR(Text006Lbl, Loop);
            Loop := Loop + 1;
        until Loop = EndMonth + 1;

        if not CONFIRM(Text011Lbl) then
            exit;

        CLEAR(RecordsUpdated);
        CLEAR(StartMonth);
        CLEAR(EndMonth);
        CLEAR(Loop);

        StartMonth := DATE2DMY(StartDate, 2);
        EndMonth := DATE2DMY(EndDate, 2);
        Year := DATE2DMY(StartDate, 3);
        Loop := StartMonth;
        repeat
            OTAppLRec.RESET();
            OTAppLRec.SETRANGE(Year, Year);
            OTAppLRec.SETRANGE(Month, Loop);
            OTAppLRec.SETRANGE(Updated, false);
            FILTERGROUP(2);
            PayrollUsers.GET(USERID());
            if PayrollUsers."Multiple Locations" <> '' then
                OTAppLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
            else
                OTAppLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            FILTERGROUP(0);
            "LineNo." := 0;
            TotalLines := OTAppLRec.COUNT();
            Window.OPEN(Text008Lbl);
            if OTAppLRec.FINDFIRST() then
                repeat
                    "LineNo." := "LineNo." + 1;
                    DailyAttLRec.GET(OTAppLRec."Employee No.", OTAppLRec.Date);
                    DailyAttLRec.VALIDATE("OT Approved Hrs", OTAppLRec."OT Approved Hrs");
                    DailyAttLRec."OT Approved Hrs" := OTAppLRec."OT Approved Hrs";
                    if DailyAttLRec.MODIFY() then begin
                        OTAppLRec.Updated := true;
                        Evaluate(OTAppLRec."Approved By", USERID());
                        OTAppLRec."Approval Date" := workdate();
                        OTAppLRec.MODIFY();
                        RecordsUpdated := true;
                    end;
                    Window.UPDATE(1, OTAppLRec."Employee No.");
                    Window.UPDATE(2, OTAppLRec.Date);
                    Window.UPDATE(3, ROUND("LineNo." / TotalLines * 10000, 1));
                    SLEEP(100);
                until OTAppLRec.NEXT() = 0;
            Loop := Loop + 1;
        until Loop = EndMonth + 1;

        if RecordsUpdated then
            MESSAGE(Text005Lbl)
        else
            ERROR(Text004Lbl);
        CurrPage.UPDATE();
    end;

    local procedure DateFilterGVarOnAfterValidate();
    begin
        CLEAR(DateString);
        CLEAR(StartDateText);
        CLEAR(EndDateText);
        CLEAR(StartDate);
        CLEAR(EndDate);
        if (STRPOS(FORMAT(DateFilterGVar), '..') = 0) then
            EVALUATE(DateString, DateFilterGVar)
        else begin
            StartDateText := CopyStr(COPYSTR(DateFilterGVar, 1, STRPOS(DateFilterGVar, '..') - 1), 1, 30);
            EVALUATE(StartDate, StartDateText);
            EndDateText := CopyStr(COPYSTR(DateFilterGVar, STRPOS(DateFilterGVar, '..') + 2, 99), 1, 30);
            EVALUATE(EndDate, EndDateText);
        end;

        ApplyFilters();
    end;
}

