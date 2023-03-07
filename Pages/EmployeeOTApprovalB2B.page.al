page 33001450 "Employee OT Approval B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee OT Approval';
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
                field(CurrentEmpNo1; CurrentEmpNo)
                {
                    ToolTip = 'Choose the Employee No.';
                    Caption = 'Employee No.';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            CurrentEmpNo := Employee."No.";
                            Name := Employee."First Name";
                            ApplyFilters();
                        end;
                    end;

                    trigger OnValidate();
                    begin
                        if Employee.GET(CurrentEmpNo) then
                            Name := Employee."First Name"
                        else
                            Name := '';

                        if CurrentEmpNo = '' then
                            Name := '';

                        CurrentEmpNoOnAfterValidate();
                    end;
                }
                field(Name1; Name)
                {
                    ToolTip = 'Specifies The Employee name.';
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(CurrentYear1; CurrentYear)
                {
                    ToolTip = 'Specifies the Year';
                    Caption = 'Year';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    ToolTip = 'Specifies the Month.';
                    Caption = 'Month';
                    ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102154000)
            {
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Specifies the Employee Name.';
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ToolTip = 'Specifies the Date of over time.';
                    ApplicationArea = all;
                }
                field("OT Hrs"; "OT Hrs")
                {
                    ToolTip = 'Specifies the Overtime hours.';
                    ApplicationArea = all;
                }
                field("OT Approved Hrs"; "OT Approved Hrs")
                {
                    ToolTip = 'Spcifies Over time approved hours.';
                    ApplicationArea = all;
                }
                field("Cancel OT Approved Hrs"; "Cancel OT Approved Hrs")
                {
                    ToolTip = 'Spcifies Approved Over time Cancelled hours.';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Enter the Remarks if any.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                ToolTip = 'Specifies the Functions.';
                Caption = 'F&unctions';
                Image = "Action";
                action("Get OT Details")
                {
                    ToolTip = 'Gets Employee over time details.';
                    Caption = 'Get OT Details';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        GetOTDetails();
                    end;
                }
                action("Update OT Details")
                {
                    ToolTip = 'Shows the Updated overtime details.';
                    Caption = 'Update OT Details';
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        UpdateOTDetails();
                    end;
                }
                action("Get Approved OT Details")
                {
                    ToolTip = ' Shows the Approved Over time details.';
                    Caption = 'Get Approved OT Details';
                    Image = PostingEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        GetApprovedOTDetails();
                    end;
                }
                action("Cancel Approved OT Hours")
                {
                    ToolTip = 'Shows the Approved cancelled over time hours.';
                    Caption = 'Cancel Approved OT Hours';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        CancelApprovedOTHours();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        SETRANGE("Employee No.", CurrentEmpNo);
        SETRANGE(Year, CurrentYear);
        SETRANGE(Month, CurrentMonth);
    end;

    var
        Employee: Record "Employee B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        CurrentEmpNo: Code[20];
        Name: Text[50];
        CurrentYear: Integer;
        CurrentMonth: Integer;

        Text001Lbl: Label 'Select employee';
        Text002Lbl: Label 'Select year';
        Text003Lbl: Label 'Select Month';
        Text004Lbl: Label 'Salary already posted for the employee %1 in the month of %2 year %3', Comment = '%1 =  Empno; %2 = Month;%3 = Year';
        Text005Lbl: Label 'Records inserted successfully';
        Text006Lbl: Label 'OT Hours are already Approved';
        Text007Lbl: Label 'OT Details updated Successfully';
        Text008Lbl: Label 'There is nothing to update';
        Text009Lbl: Label 'Do you want to retrieve OT details?';
        Text010Lbl: Label 'Do you want to post with ZERO "OT Approved Hrs"?';
        Text011Lbl: Label 'Do you want to update OT details?';
        Text012Lbl: Label 'Do you want to retrieve Approved OT details?';

    procedure GetOTDetails();
    var
        MonthlyAttLRec: Record "Monthly Attendance B2B";
        DailyAttLRec: Record "Daily Attendance B2B";
        OTAppLRec: Record "OT Approval B2B";
        RecordsUpdated: Boolean;
    begin
        if CurrentEmpNo = '' then
            ERROR(Text001Lbl);
        if CurrentYear = 0 then
            ERROR(Text002Lbl);
        if CurrentMonth = 0 then
            ERROR(Text003Lbl);


        MonthlyAttLRec.RESET();
        MonthlyAttLRec.SETRANGE("Employee Code", CurrentEmpNo);
        MonthlyAttLRec.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAttLRec.SETRANGE(Year, CurrentYear);
        MonthlyAttLRec.SETRANGE(Posted, true);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonthlyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonthlyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        if not MonthlyAttLRec.IsEmpty() then
            ERROR(Text004Lbl, CurrentEmpNo, CurrentMonth, CurrentYear);


        if not CONFIRM(Text009Lbl) then
            exit;

        CLEAR(RecordsUpdated);
        DailyAttLRec.RESET();
        DailyAttLRec.SETRANGE("Employee No.", CurrentEmpNo);
        DailyAttLRec.SETRANGE(Year, CurrentYear);
        DailyAttLRec.SETRANGE(Month, CurrentMonth);
        DailyAttLRec.SETFILTER("OT Hrs", '<>%1', 0);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            DailyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            DailyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
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
                    OTAppLRec."Location Code" := DailyAttLRec."Location Code";
                    if OTAppLRec.INSERT() then
                        RecordsUpdated := true;
                end;
            until DailyAttLRec.NEXT() = 0;

        ApplyFilters();

        if RecordsUpdated then
            MESSAGE(Text005Lbl)
        else
            MESSAGE(Text006Lbl)
    end;

    procedure UpdateOTDetails();
    var
        MonthlyAttLRec: Record "Monthly Attendance B2B";
        DailyAttLRec: Record "Daily Attendance B2B";
        OTAppLRec: Record "OT Approval B2B";
        RecordsUpdated: Boolean;
    begin
        if CurrentEmpNo = '' then
            ERROR(Text001Lbl);
        if CurrentYear = 0 then
            ERROR(Text002Lbl);
        if CurrentMonth = 0 then
            ERROR(Text003Lbl);

        MonthlyAttLRec.RESET();
        MonthlyAttLRec.SETRANGE("Employee Code", CurrentEmpNo);
        MonthlyAttLRec.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAttLRec.SETRANGE(Year, CurrentYear);
        MonthlyAttLRec.SETRANGE(Posted, true);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonthlyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonthlyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        if not MonthlyAttLRec.IsEmpty() then
            ERROR(Text004Lbl, CurrentEmpNo, CurrentMonth, CurrentYear);

        OTAppLRec.RESET();
        OTAppLRec.SETRANGE("Employee No.", CurrentEmpNo);
        OTAppLRec.SETRANGE(Year, CurrentYear);
        OTAppLRec.SETRANGE(Month, CurrentMonth);
        OTAppLRec.SETRANGE(Updated, false);
        OTAppLRec.SETFILTER("OT Approved Hrs", '=%1', 0);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            OTAppLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            OTAppLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        if not OTAppLRec.IsEmpty() then
            if not CONFIRM(Text010Lbl) then
                exit;


        if not CONFIRM(Text011Lbl) then
            exit;

        CLEAR(RecordsUpdated);
        OTAppLRec.RESET();
        OTAppLRec.SETRANGE("Employee No.", CurrentEmpNo);
        OTAppLRec.SETRANGE(Year, CurrentYear);
        OTAppLRec.SETRANGE(Month, CurrentMonth);
        OTAppLRec.SETRANGE(Updated, false);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            OTAppLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            OTAppLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        if OTAppLRec.FINDFIRST() then
            repeat
                DailyAttLRec.GET(OTAppLRec."Employee No.", OTAppLRec.Date);
                DailyAttLRec.VALIDATE("OT Approved Hrs", OTAppLRec."OT Approved Hrs");
                if DailyAttLRec.MODIFY() then begin
                    OTAppLRec.Updated := true;
                    Evaluate(OTAppLRec."Approved By", USERID());
                    OTAppLRec."Approval Date" := workdate();
                    OTAppLRec.MODIFY();
                    RecordsUpdated := true;
                end;
            until OTAppLRec.NEXT() = 0;

        if RecordsUpdated then
            MESSAGE(Text007Lbl)
        else
            ERROR(Text008Lbl);

        CurrPage.UPDATE();
    end;

    procedure ApplyFilters();
    begin
        RESET();
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        SETRANGE("Employee No.", CurrentEmpNo);
        SETRANGE(Year, CurrentYear);
        SETRANGE(Month, CurrentMonth);
        CurrPage.UPDATE();
    end;

    procedure GetApprovedOTDetails();
    var
        MonthlyAttLRec: Record "Monthly Attendance B2B";
        DailyAttLRec: Record "Daily Attendance B2B";
        OTAppLRec: Record "OT Approval B2B";
        RecordsUpdated: Boolean;
    begin
        if CurrentEmpNo = '' then
            ERROR(Text001Lbl);
        if CurrentYear = 0 then
            ERROR(Text002Lbl);
        if CurrentMonth = 0 then
            ERROR(Text003Lbl);


        MonthlyAttLRec.RESET();
        MonthlyAttLRec.SETRANGE("Employee Code", CurrentEmpNo);
        MonthlyAttLRec.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAttLRec.SETRANGE(Year, CurrentYear);
        MonthlyAttLRec.SETRANGE(Posted, true);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonthlyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonthlyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        if not MonthlyAttLRec.IsEmpty() then
            ERROR(Text004Lbl, CurrentEmpNo, CurrentMonth, CurrentYear);


        if not CONFIRM(Text012Lbl) then
            exit;

        CLEAR(RecordsUpdated);
        DailyAttLRec.RESET();
        DailyAttLRec.SETRANGE("Employee No.", CurrentEmpNo);
        DailyAttLRec.SETRANGE(Year, CurrentYear);
        DailyAttLRec.SETRANGE(Month, CurrentMonth);
        DailyAttLRec.SETFILTER("OT Approved Hrs", '>%1', 0);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            DailyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            DailyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
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
                    OTAppLRec."OT Approved Hrs" := DailyAttLRec."OT Approved Hrs";
                    OTAppLRec."Location Code" := DailyAttLRec."Location Code";
                    if OTAppLRec.INSERT() then
                        RecordsUpdated := true;
                end;

            until DailyAttLRec.NEXT() = 0;

        ApplyFiltersToCancel();
        if RecordsUpdated then
            MESSAGE(Text005Lbl)
    end;

    procedure ApplyFiltersToCancel();
    begin
        RESET();
        SETRANGE(Updated, true);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        SETRANGE("Employee No.", CurrentEmpNo);
        SETRANGE(Year, CurrentYear);
        SETRANGE(Month, CurrentMonth);
        CurrPage.UPDATE();
    end;

    procedure CancelApprovedOTHours();
    var
        MonthlyAttLRec: Record "Monthly Attendance B2B";
        DailyAttLRec: Record "Daily Attendance B2B";
        OTAppLRec: Record "OT Approval B2B";
        RecordsUpdated: Boolean;
        CancelErrLbl: Label 'No OT records found to cancel';
    begin
        if CurrentEmpNo = '' then
            ERROR(Text001Lbl);
        if CurrentYear = 0 then
            ERROR(Text002Lbl);
        if CurrentMonth = 0 then
            ERROR(Text003Lbl);

        MonthlyAttLRec.RESET();
        MonthlyAttLRec.SETRANGE("Employee Code", CurrentEmpNo);
        MonthlyAttLRec.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAttLRec.SETRANGE(Year, CurrentYear);
        MonthlyAttLRec.SETRANGE(Posted, true);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonthlyAttLRec.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonthlyAttLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        if not MonthlyAttLRec.IsEmpty() then
            ERROR(Text004Lbl, CurrentEmpNo, CurrentMonth, CurrentYear);



        OTAppLRec.RESET();
        OTAppLRec.SETRANGE("Employee No.", CurrentEmpNo);
        OTAppLRec.SETRANGE(Year, CurrentYear);
        OTAppLRec.SETRANGE(Month, CurrentMonth);
        OTAppLRec.SETRANGE(Updated, true);
        OTAppLRec.SETFILTER("Cancel OT Approved Hrs", '=%1', 0);
        OTAppLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if not OTAppLRec.IsEmpty() then begin
            if not CONFIRM(Text010Lbl) then
                exit;
        end else
            Error(CancelErrLbl);

        if not CONFIRM(Text011Lbl) then
            exit;

        CLEAR(RecordsUpdated);
        OTAppLRec.RESET();
        OTAppLRec.SETRANGE("Employee No.", CurrentEmpNo);
        OTAppLRec.SETRANGE(Year, CurrentYear);
        OTAppLRec.SETRANGE(Month, CurrentMonth);
        OTAppLRec.SETRANGE(Updated, true);
        OTAppLRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if OTAppLRec.FINDFIRST() then
            repeat
                DailyAttLRec.GET(OTAppLRec."Employee No.", OTAppLRec.Date);
                DailyAttLRec.VALIDATE("OT Approved Hrs", (OTAppLRec."OT Approved Hrs" - OTAppLRec."Cancel OT Approved Hrs"));
                if DailyAttLRec.MODIFY() then begin
                    Evaluate(OTAppLRec."Approved By", USERID());
                    OTAppLRec."Approval Date" := workdate();
                    OTAppLRec.MODIFY();
                    RecordsUpdated := true;
                end;
            until OTAppLRec.NEXT() = 0;

        if RecordsUpdated then
            MESSAGE(Text006Lbl)
        else
            ERROR(Text008Lbl);

        CurrPage.UPDATE();
    end;

    local procedure CurrentEmpNoOnAfterValidate();
    begin
        ApplyFilters();
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        ApplyFilters();
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        ApplyFilters();
    end;
}

