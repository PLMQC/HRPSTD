table 33001306 "Leave Application Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Application Line_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Leave Application Header B2B"."Document No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if LeaveApplicationHeader.GET("Document No.") then
                    VALIDATE("Employee No.", LeaveApplicationHeader."Employee No.");

            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Employee No.") then begin
                    "Employee Name" := copystr(Employee.FullName(), 1, 50);
                    "Employee User ID" := Employee."User Id";
                    "Location Code" := Employee."Location Code";
                end;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(5; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if "Employee No." = '' then begin
                    LeaveApplicationHeader.GET("Document No.");
                    VALIDATE("Employee No.", LeaveApplicationHeader."Employee No.");
                end;
                EmpLeaves.RESET();
                EmpLeaves.SETRANGE("No.", "Employee No.");
                EmpLeaves.SETFILTER("Leave Code", '<>%1', COMPTxt);
                if PAGE.RUNMODAL(0, EmpLeaves) = ACTION::LookupOK then
                    VALIDATE("Leave Code", EmpLeaves."Leave Code");
            end;

            trigger OnValidate();
            begin
                if "Employee No." = '' then begin
                    LeaveApplicationHeader.GET("Document No.");
                    VALIDATE("Employee No.", LeaveApplicationHeader."Employee No.");
                end;
                if "Leave Code" = COMPTxt then
                    ERROR(Text002Lbl);

                if "To Date" <> 0D then
                    VALIDATE("To Date");

                LeavePlan.RESET();
                LeavePlan.SETRANGE("Leave Application No.", "Document No.");
                LeavePlan.SETRANGE("Employee No", "Employee No.");
                if LeavePlan.FINDFIRST() then begin
                    LeavePlan.DELETEALL(true);
                    MESSAGE(Text010Lbl);
                end;

                LeaveApplicationHeader.RESET();
                LeaveApplicationHeader.GET("Document No.");
                "Department Code" := LeaveApplicationHeader."Department Code";
            end;
        }
        field(6; "Leave Duration"; Option)
        {
            Caption = 'Leave Duration';
            InitValue = Leave;
            OptionCaption = ' ,Half Day,Leave';
            OptionMembers = " ","Half Day",Leave;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Leave Duration" = "Leave Duration"::"Half Day" then
                    if "From Date" <> 0D then begin
                        VALIDATE("To Date", "From Date");
                        "No.of Days" := 0.5;
                        "Half Day Modification" := "From Date";
                    end;


                if "Leave Duration" = "Leave Duration"::Leave then begin
                    "Session Time" := "Session Time"::" ";
                    "Half Day Modification" := 0D;
                    if "From Date" <> 0D then
                        FromDateValidations();
                    if "To Date" <> 0D then
                        ToDateValidations()
                end;

                LeaveAppLine.RESET();
                LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
                LeaveAppLine.SETRANGE("Leave Code", "Leave Code");
                LeaveAppLine.SETRANGE("Leave Duration", "Leave Duration");
                if LeaveAppLine.FINDFIRST() then
                    ERROR(Text003Lbl, "Leave Code");
                ;

                LeavePlan.RESET();
                LeavePlan.SETRANGE("Leave Application No.", "Document No.");
                LeavePlan.SETRANGE("Employee No", "Employee No.");
                if LeavePlan.FINDFIRST() then begin
                    LeavePlan.DELETEALL(true);
                    MESSAGE(Text010Lbl);
                end;
            end;
        }
        field(7; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                MonthlyAttendLRec.RESET();
                MonthlyAttendLRec.SETRANGE("Employee Code", "Employee No.");
                MonthlyAttendLRec.SETRANGE("Pay Slip Month", DATE2DMY("From Date", 2));
                MonthlyAttendLRec.SETRANGE(Year, DATE2DMY("From Date", 3));
                MonthlyAttendLRec.SETRANGE(Posted, true);
                if MonthlyAttendLRec.FINDFIRST() then
                    ERROR(Text011Lbl);

                FromDateValidations();
                HalfDayValidations();
                if "Leave Duration" = "Leave Duration"::"Half Day" then begin
                    CalcProvLeaves();
                    CreateAppliedLeaves()
                end;
            end;
        }
        field(8; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                MonthlyAttendLRec.RESET();
                MonthlyAttendLRec.SETRANGE("Employee Code", "Employee No.");
                MonthlyAttendLRec.SETRANGE("Pay Slip Month", DATE2DMY("To Date", 2));
                MonthlyAttendLRec.SETRANGE(Year, DATE2DMY("To Date", 3));
                MonthlyAttendLRec.SETRANGE(Posted, true);
                if MonthlyAttendLRec.FINDFIRST() then
                    ERROR(Text011Lbl);

                ToDateValidations();
                HalfDayValidations();
                CalcProvLeaves();
                CreateAppliedLeaves()
            end;
        }
        field(9; "Reason for Leave"; Text[50])
        {
            Caption = 'Reason for Leave';
            DataClassification = CustomerContent;
        }
        field(11; "Date of Cancellation"; Date)
        {
            Caption = 'Date of Cancellation';
            DataClassification = CustomerContent;
        }
        field(13; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(14; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(16; "No.of Days"; Decimal)
        {
            Caption = 'No.of Days';
            DataClassification = CustomerContent;
        }
        field(19; "Apply Leave"; Boolean)
        {
            Caption = 'Apply Leave';
            DataClassification = CustomerContent;
        }
        field(20; "Employee User ID"; Code[50])
        {
            Caption = 'Employee User ID';
            Editable = false;
            TableRelation = user."User Name";
            DataClassification = CustomerContent;
        }
        field(31; "Provisional Leaves Avail"; Decimal)
        {
            Caption = 'Provisional Leaves Avail';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(32; "Applied Leaves History"; Decimal)
        {
            Caption = 'Applied Leaves History';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(33; "Session Time"; Option)
        {
            Caption = 'Session Time';
            OptionCaption = ' ,First Half,Second Half';
            OptionMembers = " ","First Half","Second Half";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                HalfDayValidations();
                SessionValidations();
            end;
        }
        field(37; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(45; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
        }
        field(53; Approver; Code[50])
        {
            Caption = 'Approver';
            DataClassification = CustomerContent;
        }
        field(54; "Half Day Modification"; Date)
        {
            Caption = 'Half Day Modification';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Document No.", "Leave Code", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Leave Application No.", "Document No.");
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETRANGE("Leave Code", "Leave Code");
        if LeavePlanRec.FINDFIRST() then begin
            LeavePlanRec.DELETEALL();
            MESSAGE(Text010Lbl);
        end;
    end;

    var
        Employee: Record "Employee B2B";
        DailyAttend: Record "Daily Attendance B2B";
        LeaveApplicationHeader: Record "Leave Application Header B2B";

        LeaveAppLine: Record "Leave Application Line B2B";
        LeavePlanRec: Record "Leave Plan B2B";
        LeaveApplicability: Record "Leaves Applicability B2B";
        LeavePlan: Record "Leave Plan B2B";
        DailyAttRec: Record "Daily Attendance B2B";
        LeaveMaster: Record "Leave Master B2B";
        MonthlyAttendLRec: Record "Monthly Attendance B2B";
        EmpLeaves: Record "Employee Leaves B2B";
        LeavePlanGRec: Record "Leave Plan B2B";
        TotalLeaves: Decimal;
        UsedLeaves: Decimal;
        YearStartDate: Date;
        YearEndDate: Date;
        SkipLoop: Boolean;
        ChqEndDate: Date;
        ChqStDate: Date;
        Text000Lbl: Label 'Leave End Date should be equal to Leave Start Date for Half day Leaves';
        Text001Lbl: Label 'To Date should be greater than the From Date';
        Text002Lbl: Label 'you can not select the leave code ''Comp''.';
        Text003Lbl: Label 'You already have unposted leave of type %1.', Comment = '%1 = LeaveCode';
        Text004Lbl: Label 'You can not apply leave types %1 and %2 successively.', Comment = '%1 = LeaveCode ; %2 = LeavCode';
        Text005Lbl: Label 'You can apply leaves only for this leave year.';
        Text006Lbl: Label 'You already applied leaves in between %1 and %2, Please check your leaves.', Comment = '%1 = From Date ; %2 = To Date';
        Text007Lbl: Label 'You already applied leave for the date %1, Please check your leaves.', Comment = '%1 = From Date';
        Text008Lbl: Label 'Leave start date should be greater than employment date.';
        Text009Lbl: Label '%1 is Non-working.', Comment = '%1 = To Date';
        Text010Lbl: Label 'Leave Plan will be deleted and should be regenerated.';
        Text011Lbl: Label 'Salary already posted for this employee in this month and year';
        Text012Lbl: Label 'Leave plan not found';
        Text013Lbl: Label 'Check your leaves';
        COMPTxt: Label 'COMP';
        OneDayLessExprLbl: Label '<-1D>';
        OneDayExprLbl: Label '<1D>';
        LYTxt: Label 'LEAVE YEAR';

    procedure OffdayLeave(): Decimal;
    var
        DailyAttendance: Record "Daily Attendance B2B";
        OffdaysCount: Decimal;
    begin
        OffdaysCount := 0;
        Employee.GET("Employee No.");
        LeaveMaster.RESET();
        LeaveMaster.GET("Leave Code", Employee."Location Code");
        if not LeaveMaster."Off Days b/w Leaves" then begin
            DailyAttendance.RESET();
            DailyAttendance.SETRANGE("Employee No.", "Employee No.");
            DailyAttendance.SETFILTER(Date, '%1..%2', "From Date", "To Date");
            DailyAttendance.SETRANGE("Non-Working", true);

            DailyAttendance.SETFILTER(WeeklyOff, '<>%1', 0.5);
            if DailyAttendance.FINDFIRST() then
                OffdaysCount := DailyAttendance.COUNT();

            DailyAttendance.RESET();
            DailyAttendance.SETRANGE("Employee No.", "Employee No.");
            DailyAttendance.SETFILTER(Date, '%1..%2', "From Date", "To Date");
            DailyAttendance.SETRANGE("Non-Working", true);
            DailyAttendance.SETFILTER(WeeklyOff, '=%1', 0.5);
            if DailyAttendance.FINDFIRST() then
                OffdaysCount := OffdaysCount + (DailyAttendance.COUNT() / 2);

            exit(OffdaysCount);

        end else
            exit(0);
    end;

    procedure LeavePlanning(LeaveAppLine: Record "Leave Application Line B2B");
    var
        ProvisionalLeaves: Record "Provisional Leaves B2B";
        StartDate: Date;
        EndDate: Date;
        ProvLeaves: Decimal;
        Flag: Integer;
    begin
        CLEAR(SkipLoop);
        ChqStDate := LeaveAppLine."From Date";
        repeat
            ChqStDate := CALCDATE(OneDayLessExprLbl, ChqStDate);
            DailyAttRec.RESET();
            DailyAttRec.SETRANGE("Employee No.", LeaveAppLine."Employee No.");
            DailyAttRec.SETRANGE(Date, ChqStDate);
            DailyAttRec.SETRANGE("Non-Working", true);
            if not DailyAttRec.FINDFIRST() then
                SkipLoop := true;
        until SkipLoop;

        CLEAR(SkipLoop);
        ChqEndDate := LeaveAppLine."To Date";
        repeat
            ChqEndDate := CALCDATE(OneDayExprLbl, ChqEndDate);
            DailyAttRec.RESET();
            DailyAttRec.SETRANGE("Employee No.", LeaveAppLine."Employee No.");
            DailyAttRec.SETRANGE(Date, ChqEndDate);
            DailyAttRec.SETRANGE("Non-Working", true);
            if not DailyAttRec.FINDFIRST() then
                SkipLoop := true;
        until SkipLoop;
        LeaveMaster.GET(LeaveAppLine."Leave Code", LeaveAppLine."Location Code");
        if LeaveMaster."Off Days b/w Leaves" then begin
            LeavePlanGRec.RESET();
            LeavePlanGRec.SETRANGE("Employee No", LeaveAppLine."Employee No.");
            LeavePlanGRec.SETRANGE("Leave Date", ChqStDate);
            LeavePlanGRec.SETFILTER("Approved Status", '<>%1', LeavePlanGRec."Approved Status"::Cancelled);
            if LeavePlanGRec.FINDSET() then begin
                if (LeavePlanGRec."Session Time" = LeavePlanGRec."Session Time"::" ") or (LeavePlanGRec."Session Time" = LeavePlanGRec."Session Time"::"Second Half") then
                    if (LeaveAppLine."Session Time" = LeaveAppLine."Session Time"::"First Half") or (LeaveAppLine."Session Time" = LeaveAppLine."Session Time"::" ") then
                        LeaveAppLine."From Date" := CALCDATE(OneDayExprLbl, ChqStDate);
                LeaveAppLine.MODIFY();
            end;

            LeavePlanGRec.RESET();
            LeavePlanGRec.SETRANGE("Employee No", LeaveAppLine."Employee No.");
            LeavePlanGRec.SETRANGE("Leave Date", ChqEndDate);
            LeavePlanGRec.SETFILTER("Approved Status", '<>%1', LeavePlanGRec."Approved Status"::Cancelled);
            if LeavePlanGRec.FINDSET() then begin
                if (LeavePlanGRec."Session Time" = LeavePlanGRec."Session Time"::" ") or (LeavePlanGRec."Session Time" = LeavePlanGRec."Session Time"::"First Half") then
                    if (LeaveAppLine."Session Time" = LeaveAppLine."Session Time"::"Second Half") or (LeaveAppLine."Session Time" = LeaveAppLine."Session Time"::" ") then
                        LeaveAppLine."To Date" := CALCDATE(OneDayLessExprLbl, ChqEndDate);
                LeaveAppLine.MODIFY();
            end;
        end;
        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Leave Application No.", LeaveAppLine."Document No.");
        LeavePlanRec.SETRANGE("Employee No", LeaveAppLine."Employee No.");
        LeavePlanRec.SETRANGE("Leave Code", LeaveAppLine."Leave Code");
        LeavePlanRec.SETRANGE("Leave Duration", LeaveAppLine."Leave Duration");
        if LeavePlanRec.FINDFIRST() then
            LeavePlanRec.DELETEALL();


        Flag := 0;
        UsedLeaves := 0;
        ProvisionalLeaves.RESET();
        ProvisionalLeaves.SETRANGE("Employee No.", LeaveAppLine."Employee No.");
        ProvisionalLeaves.SETRANGE("Leave Code", LeaveAppLine."Leave Code");
        ProvisionalLeaves.SETRANGE(Status, ProvisionalLeaves.Status::Open);
        if ProvisionalLeaves.FINDFIRST() then
            repeat
                ProvLeaves := ProvLeaves + ProvisionalLeaves."Remaining Leaves";
                if (LeaveAppLine."From Date" >= ProvisionalLeaves."Period Start Date") and
                   (LeaveAppLine."To Date" <= ProvisionalLeaves."Period End Date")
                then begin
                    InsertLeavePlan(LeaveAppLine."From Date", LeaveAppLine."To Date", ProvLeaves);
                    Flag := 1;
                end;
            until ProvisionalLeaves.NEXT() = 0;
        if Flag = 0 then begin
            ProvLeaves := 0;
            ProvisionalLeaves.RESET();
            ProvisionalLeaves.SETRANGE("Employee No.", LeaveAppLine."Employee No.");
            ProvisionalLeaves.SETRANGE("Leave Code", LeaveAppLine."Leave Code");
            ProvisionalLeaves.SETRANGE(Status, ProvisionalLeaves.Status::Open);
            if ProvisionalLeaves.FINDFIRST() then begin
                StartDate := LeaveAppLine."From Date";
                EndDate := LeaveAppLine."To Date";
                repeat
                    ProvLeaves := ProvLeaves + ProvisionalLeaves."Remaining Leaves";
                    if (ProvisionalLeaves."Period Start Date" <= StartDate) and (ProvisionalLeaves."Period End Date" >= StartDate)
                    then
                        if (StartDate >= ProvisionalLeaves."Period Start Date") and (EndDate <= ProvisionalLeaves."Period End Date") then
                            InsertLeavePlan(StartDate, EndDate, (TotalLeaves + ProvisionalLeaves."Remaining Leaves"))
                        else
                            if (StartDate >= ProvisionalLeaves."Period Start Date") and (EndDate >= ProvisionalLeaves."Period End Date")
                   then begin
                                EndDate := ProvisionalLeaves."Period End Date";
                                InsertLeavePlan(StartDate, EndDate, ProvLeaves - UsedLeaves);
                                StartDate := EndDate + 1;
                                EndDate := "To Date";
                            end;

                until ProvisionalLeaves.NEXT() = 0;
            end;
        end;
    end;

    procedure CheckPlanning(LeaveApp: Record "Leave Application Line B2B");
    var
    begin
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", "Document No.");
        LeavePlan.SETRANGE("Employee No", LeaveApp."Employee No.");
        LeavePlan.SETRANGE("Leave Code", LeaveApp."Leave Code");
        LeavePlan.SETFILTER("Leave Date", '>=%1 & <= %2', LeaveApp."From Date", LeaveApp."To Date");
        if LeavePlan.FINDFIRST() then
            repeat
                LeavePlan."Approved Status" := LeavePlan."Approved Status"::Applied;
                LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0
        else
            ERROR(Text012Lbl);
    end;

    procedure InsertLeavePlan(StartDate: Date; EndDate: Date; ProLeaves: Decimal);
    var
        GradeLeaves: Record "Grade Wise Leaves B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        AvailableLeaves: Decimal;
        CheckDate: Date;
        Offday: Boolean;
    begin
        Employee.GET("Employee No.");
        GradeLeaves.RESET();
        GradeLeaves.SETRANGE("Leave Code", "Leave Code");
        GradeLeaves.SETRANGE("Off Days b/w Leaves", false);
        GradeLeaves.SETRANGE("Location Code", Employee."Location Code");
        if not GradeLeaves.IsEmpty() then
            Offday := true
        else
            Offday := false;
        AvailableLeaves := ProLeaves;
        for CheckDate := StartDate to EndDate do begin
            LeavePlan.INIT();
            LeavePlan."Leave Code" := "Leave Code";
            LeaveMaster.GET("Leave Code", Employee."Location Code");
            LeavePlan."Leave Description" := LeaveMaster.Description;
            LeavePlan."Leave Date" := CheckDate;
            LeavePlan."Employee No" := "Employee No.";
            LeavePlan."Employee Name" := "Employee Name";
            LeavePlan."Leave Duration" := "Leave Duration";
            if Offday then begin
                DailyAttendance.RESET();
                DailyAttendance.SETRANGE("Employee No.", "Employee No.");
                DailyAttendance.SETRANGE(Date, CheckDate);
                DailyAttendance.SETRANGE("Non-Working", true);
                if not DailyAttendance.IsEmpty() then
                    LeavePlan."Leave Type" := LeavePlan."Leave Type"::NonWorking
                else
                    if AvailableLeaves > 0 then
                        if (LeavePlan."Leave Duration" = LeavePlan."Leave Duration"::"Half Day") and (CheckDate = "Half Day Modification") then begin
                            LeavePlan."Leave Type" := LeavePlan."Leave Type"::Leave;
                            LeavePlan."Session Time" := "Session Time";
                            AvailableLeaves := AvailableLeaves - 0.5;
                            UsedLeaves := UsedLeaves + 0.5;
                        end else
                            if (AvailableLeaves >= 1) then begin
                                LeavePlan."Leave Type" := LeavePlan."Leave Type"::Leave;
                                LeavePlan."Session Time" := LeavePlan."Session Time"::" ";
                                AvailableLeaves := AvailableLeaves - 1;
                                UsedLeaves := UsedLeaves + 1;
                            end else begin
                                LeavePlan."Leave Type" := LeavePlan."Leave Type"::Leave;
                                LeavePlan."Leave Duration" := LeavePlan."Leave Duration"::"Half Day";
                                LeavePlan."Session Time" := LeavePlan."Session Time"::"First Half";
                                AvailableLeaves := AvailableLeaves - 0.5;
                                UsedLeaves := UsedLeaves + 0.5;
                                InsertHalfDayLOP(LeavePlan);
                            end

                    else
                        LeavePlan."Leave Type" := LeavePlan."Leave Type"::LOP;

            end else
                if AvailableLeaves > 0 then
                    if (LeavePlan."Leave Duration" = LeavePlan."Leave Duration"::"Half Day") and (CheckDate = "Half Day Modification") then begin
                        LeavePlan."Leave Type" := LeavePlan."Leave Type"::Leave;
                        LeavePlan."Session Time" := "Session Time";
                        AvailableLeaves := AvailableLeaves - 0.5;
                        UsedLeaves := UsedLeaves + 0.5;
                    end else
                        if (AvailableLeaves >= 1) then begin
                            LeavePlan."Leave Type" := LeavePlan."Leave Type"::Leave;
                            LeavePlan."Session Time" := LeavePlan."Session Time"::" ";
                            AvailableLeaves := AvailableLeaves - 1;
                            UsedLeaves := UsedLeaves + 1;
                        end else begin
                            LeavePlan."Leave Type" := LeavePlan."Leave Type"::Leave;
                            LeavePlan."Leave Duration" := LeavePlan."Leave Duration"::"Half Day";
                            LeavePlan."Session Time" := LeavePlan."Session Time"::"First Half";
                            AvailableLeaves := AvailableLeaves - 0.5;
                            UsedLeaves := UsedLeaves + 0.5;
                            InsertHalfDayLOP(LeavePlan);
                        end

                else
                    LeavePlan."Leave Type" := LeavePlan."Leave Type"::LOP;

            LeavePlan."Leave Application No." := "Document No.";
            LeavePlan.Month := DATE2DMY(LeavePlan."Leave Date", 2);
            LeavePlan.Year := DATE2DMY(LeavePlan."Leave Date", 3);
            LeavePlan."Approved Status" := LeavePlan."Approved Status"::Applied;
            LeavePlan.INSERT();
        end;
        TotalLeaves := AvailableLeaves;
    end;

    procedure UpdateProLeaves(LeaveAppRec: Record "Leave Application Line B2B");
    var
        ProvLeaves: Record "Provisional Leaves B2B";
        AppliedLeaves: Decimal;
    begin
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", LeaveAppRec."Document No.");
        LeavePlan.SETRANGE("Employee No", LeaveAppRec."Employee No.");
        LeavePlan.SETRANGE("Leave Code", LeaveAppRec."Leave Code");
        LeavePlan.SETRANGE("Leave Type", LeavePlan."Leave Type"::Leave);
        if LeavePlan.FINDFIRST() then
            repeat
                if LeavePlan."Leave Duration" = LeavePlan."Leave Duration"::"Half Day" then
                    AppliedLeaves := AppliedLeaves + 0.5
                else
                    AppliedLeaves := AppliedLeaves + 1;
            until LeavePlan.NEXT() = 0;

        ProvLeaves.RESET();
        ProvLeaves.SETRANGE("Employee No.", LeaveAppRec."Employee No.");
        ProvLeaves.SETRANGE("Leave Code", LeaveAppRec."Leave Code");
        ProvLeaves.SETFILTER(ProvLeaves."Remaining Leaves", '<>%1', 0);
        ProvLeaves.SETFILTER("Leave Year Start Date", '<=%1', LeaveAppRec."From Date");
        ProvLeaves.SETFILTER("Leave Year End Date", '>=%1', LeaveAppRec."To Date");
        if ProvLeaves.FINDFIRST() then
            repeat
                if AppliedLeaves <> 0 then begin
                    if ProvLeaves."Remaining Leaves" <= AppliedLeaves then begin
                        ProvLeaves."Applied Leaves" := ProvLeaves."Applied Leaves" + ProvLeaves."Remaining Leaves";
                        AppliedLeaves := AppliedLeaves - ProvLeaves."Remaining Leaves";
                        ProvLeaves."Remaining Leaves" := ProvLeaves."Remaining Leaves" - ProvLeaves."Applied Leaves";
                        ProvLeaves.MODIFY();
                    end else begin
                        ProvLeaves."Applied Leaves" := ProvLeaves."Applied Leaves" + AppliedLeaves;
                        ProvLeaves."Remaining Leaves" := ProvLeaves."Remaining Leaves" - AppliedLeaves;
                        AppliedLeaves := AppliedLeaves - AppliedLeaves;
                        ProvLeaves.MODIFY();
                    end;
                end else
                    if AppliedLeaves = 0 then
                        exit;
            until ProvLeaves.NEXT() = 0;
    end;

    procedure GetLeaveYear();
    var
        PayrollYear: Record "Payroll Year B2B";
    begin
        PayrollYear.RESET();
        PayrollYear.SETRANGE("Year Type", LYTxt);
        PayrollYear.SETRANGE(Closed, false);
        if PayrollYear.FINDFIRST() then begin
            YearStartDate := PayrollYear."Year Start Date";
            YearEndDate := PayrollYear."Year End Date";
        end;
    end;

    procedure FromDateValidations();
    begin
        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Leave Application No.", "Document No.");
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETRANGE("Leave Code", "Leave Code");
        if LeavePlanRec.FINDFIRST() then begin
            LeavePlanRec.DELETEALL();
            MESSAGE(Text010Lbl);
        end;

        GetLeaveYear();
        if ("From Date" < YearStartDate) or ("From Date" > YearEndDate) then
            ERROR(Text005Lbl);

        DailyAttend.SETRANGE(Date, "From Date");
        DailyAttend.SETRANGE("Employee No.", "Employee No.");
        DailyAttend.SETRANGE("Non-Working", true);
        DailyAttend.SETFILTER(WeeklyOff, '<>%1', 0.5);
        if DailyAttend.FINDFIRST() then
            ERROR(Text009Lbl, "From Date");

        Employee.GET("Employee No.");
        if (Employee."Employment Date" > YearStartDate) then
            if "From Date" < Employee."Employment Date" then
                ERROR(Text008Lbl);


        if "Leave Duration" = "Leave Duration"::"Half Day" then begin
            "To Date" := "From Date";
            "No.of Days" := 0.5;
            "Half Day Modification" := "From Date";
        end else begin
            if "To Date" <> 0D then begin
                if "To Date" < "From Date" then
                    ERROR(Text001Lbl);
                "No.of Days" := ("To Date" - "From Date") + 1 - OffdayLeave();
            end;
            "Half Day Modification" := 0D;
        end;

        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETFILTER("Leave Date", '%1', ("From Date" - 1));
        LeavePlanRec.SETFILTER("Session Time", '<>%1', 1);
        LeavePlanRec.SETFILTER("Posted Status", '<>%1', LeavePlanRec."Posted Status"::Cancelled);
        if LeavePlanRec.FINDFIRST() then
            if (LeavePlanRec."Leave Code" <> "Leave Code") and ("Leave Duration" <> "Leave Duration"::"Half Day") then begin
                LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                if not LeaveApplicability.FINDFIRST() then
                    ERROR(Text004Lbl, LeavePlanRec."Leave Code", "Leave Code");
            end;


        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETFILTER("Leave Date", '<%1', "From Date");
        LeavePlanRec.SETFILTER("Session Time", '<>%1', 1);
        LeavePlanRec.SETFILTER("Posted Status", '<>%1', LeavePlanRec."Posted Status"::Cancelled);
        if LeavePlanRec.FINDFIRST() then begin
            DailyAttend.RESET();
            DailyAttend.SETRANGE("Employee No.", "Employee No.");
            DailyAttend.SETRANGE("Non-Working", false);
            DailyAttend.SETRANGE("Attendance Type", DailyAttend."Attendance Type"::Present);
            DailyAttend.SETFILTER(Date, '>%1 & <%2', LeavePlanRec."Leave Date", "From Date");
            if DailyAttend.IsEmpty() then
                if (LeavePlanRec."Leave Code" <> "Leave Code") and ("Leave Duration" <> "Leave Duration"::"Half Day") then begin
                    LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                    LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                    if not LeaveApplicability.FINDFIRST() then
                        ERROR(Text004Lbl, LeavePlanRec."Leave Code", "Leave Code");
                end;

        end;

        LeaveAppLine.RESET();
        LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
        if LeaveAppLine.FINDFIRST() then begin
            LeaveAppLine.SETFILTER(LeaveAppLine."To Date", '%1|%2', ("From Date" - 1), "From Date");
            LeaveAppLine.SETFILTER("Session Time", '<>%1', 1);
            if LeaveAppLine.FINDFIRST() then
                if (LeaveAppLine."Leave Code" <> "Leave Code") and ("Leave Duration" <> "Leave Duration"::"Half Day") then begin
                    LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                    LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                    if not LeaveApplicability.FINDFIRST() then
                        ERROR(Text004Lbl, LeaveAppLine."Leave Code", "Leave Code");
                end;

        end;

        LeaveAppLine.RESET();
        LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
        if LeaveAppLine.FINDFIRST() then begin
            LeaveAppLine.SETFILTER("Session Time", '<>%1', 1);
            if LeaveAppLine.FINDFIRST() then
                repeat
                    DailyAttend.RESET();
                    DailyAttend.SETRANGE("Employee No.", "Employee No.");
                    DailyAttend.SETRANGE("Non-Working", false);
                    DailyAttend.SETRANGE("Attendance Type", DailyAttend."Attendance Type"::Present);
                    DailyAttend.SETFILTER(Date, '>%1 & <%2', "From Date", LeaveAppLine."To Date");
                    if not DailyAttend.FINDFIRST() then
                        if (LeaveAppLine."Leave Code" <> "Leave Code") and ("Leave Duration" <> "Leave Duration"::"Half Day") then begin
                            LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                            LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                            if not LeaveApplicability.FINDFIRST() then
                                ERROR(Text004Lbl, LeaveAppLine."Leave Code", "Leave Code");
                        end;

                until LeaveAppLine.NEXT() = 0;

        end;


        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETFILTER("Leave Date", '=%1', "From Date");
        LeavePlanRec.SETRANGE("Session Time", "Session Time");
        LeavePlanRec.SETFILTER("Posted Status", '<>%1', LeavePlanRec."Posted Status"::Cancelled);
        LeavePlanRec.SETFILTER("Approved Status", '<>%1', LeavePlanRec."Approved Status"::Rejected);
        if LeavePlanRec.FINDFIRST() then
            ERROR(Text007Lbl, "From Date");


        LeaveAppLine.RESET();
        LeaveAppLine.SETRANGE("Employee No.", Rec."Employee No.");
        LeaveAppLine.SETRANGE("Session Time", "Session Time");
        LeaveAppLine.SETFILTER(LeaveAppLine."From Date", '<=%1', Rec."From Date");
        LeaveAppLine.SETFILTER(LeaveAppLine."To Date", '>=%1', Rec."From Date");
        if LeaveAppLine.FINDFIRST() then
            repeat
                if (LeaveAppLine."Line No." <> "Line No.") or (LeaveAppLine."Document No." <> "Document No.") then
                    ERROR(Text007Lbl, "From Date");
            until LeaveAppLine.NEXT() = 0;

    end;

    procedure ToDateValidations();
    begin
        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Leave Application No.", "Document No.");
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETRANGE("Leave Code", "Leave Code");
        if LeavePlanRec.FINDFIRST() then begin
            LeavePlanRec.DELETEALL();
            MESSAGE(Text010Lbl);
        end;

        if ("To Date" < "From Date") and ("From Date" <> 0D) and ("To Date" <> 0D) then
            ERROR(Text001Lbl);

        GetLeaveYear();
        if ("To Date" <> 0D) and (("To Date" > YearEndDate) or ("To Date" < YearStartDate)) then
            ERROR(Text005Lbl);

        if "Leave Duration" = "Leave Duration"::"Half Day" then
            if "From Date" <> "To Date" then
                ERROR(Text000Lbl);



        DailyAttend.SETRANGE(Date, "To Date");
        DailyAttend.SETRANGE("Employee No.", "Employee No.");
        DailyAttend.SETRANGE("Non-Working", true);
        DailyAttend.SETFILTER(WeeklyOff, '<>%1', 0.5);
        if DailyAttend.FINDFIRST() then
            ERROR(Text009Lbl, "To Date");


        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETFILTER("Leave Date", '%1', ("To Date" + 1));
        LeavePlanRec.SETFILTER("Session Time", '<>%1', 2);
        LeavePlanRec.SETFILTER("Posted Status", '<>%1', LeavePlanRec."Posted Status"::Cancelled);
        if LeavePlanRec.FINDFIRST() then
            if (LeavePlanRec."Leave Code" <> "Leave Code") and ("Leave Duration" <> "Leave Duration"::"Half Day") then begin
                LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                if not LeaveApplicability.FINDFIRST() then
                    ERROR(Text004Lbl, LeavePlanRec."Leave Code", "Leave Code");
            end;


        LeaveAppLine.RESET();
        LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
        if LeaveAppLine.FINDFIRST() then begin
            LeaveAppLine.SETFILTER("From Date", '%1|%2', ("To Date" + 1), "To Date");
            if LeaveAppLine.FINDFIRST() then
                if (LeaveAppLine."Leave Code" <> "Leave Code") and ("Leave Duration" <> "Leave Duration"::"Half Day") then begin
                    LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                    LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                    if not LeaveApplicability.FINDFIRST() then
                        ERROR(Text004Lbl, LeaveAppLine."Leave Code", "Leave Code");
                end;

        end;

        LeaveAppLine.RESET();
        LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
        if LeaveAppLine.FINDFIRST() then begin
            DailyAttend.RESET();
            DailyAttend.SETRANGE("Employee No.", "Employee No.");
            DailyAttend.SETRANGE("Non-Working", false);
            DailyAttend.SETRANGE("Attendance Type", DailyAttend."Attendance Type"::Present);
            DailyAttend.SETFILTER(Date, '>%1 & <%2', "To Date", LeaveAppLine."From Date");
            if not DailyAttend.FINDFIRST() then
                if (LeaveAppLine."Leave Code" <> "Leave Code") and ("Leave Duration" <> "Leave Duration"::"Half Day") then begin
                    LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                    LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                    if not LeaveApplicability.FINDFIRST() then
                        ERROR(Text004Lbl, LeaveAppLine."Leave Code", "Leave Code");
                end;

        end;

        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETFILTER("Leave Date", '>=%1&<=%2', "From Date", "To Date");
        LeavePlanRec.SETFILTER("Posted Status", '<>%1', LeavePlanRec."Posted Status"::Cancelled);
        LeavePlanRec.SETFILTER("Approved Status", '<>%1', LeavePlanRec."Approved Status"::Rejected);
        if LeavePlanRec.FINDFIRST() then
            ERROR(Text006Lbl, "From Date", "To Date");


        LeaveAppLine.RESET();
        LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
        if LeaveAppLine.FINDFIRST() then
            repeat
                if (LeaveAppLine."Line No." <> "Line No.") or (LeaveAppLine."Document No." <> "Document No.") then
                    if ("From Date" <= LeaveAppLine."From Date") and ("To Date" >= LeaveAppLine."From Date") then
                        ERROR(Text006Lbl, "From Date", "To Date")
                    else
                        if ("From Date" <= LeaveAppLine."To Date") and ("To Date" >= LeaveAppLine."To Date") then
                            ERROR(Text006Lbl, "From Date", "To Date")

            until LeaveAppLine.NEXT() = 0;


        if "Leave Duration" = "Leave Duration"::"Half Day" then
            "No.of Days" := 0.5
        else
            "No.of Days" := ("To Date" - "From Date") + 1 - OffdayLeave();

    end;

    procedure HalfDayValidations();
    begin
        LeaveAppLine.RESET();
        LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
        LeaveAppLine.SETRANGE("Leave Duration", "Leave Duration"::"Half Day");
        if LeaveAppLine.FINDFIRST() then
            repeat
                if ("To Date" = LeaveAppLine."From Date" - 1) and
                  (LeaveAppLine."Session Time" = LeaveAppLine."Session Time"::"First Half")
                then
                    if (LeaveAppLine."Leave Code" <> "Leave Code") and ("Session Time" = "Session Time"::"Second Half") then begin
                        LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                        LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                        if not LeaveApplicability.FINDFIRST() then
                            ERROR(Text004Lbl, LeaveAppLine."Leave Code", "Leave Code");
                    end;

                if ("From Date" = LeaveAppLine."To Date" + 1) and
                  (LeaveAppLine."Session Time" = LeaveAppLine."Session Time"::"Second Half")
                then
                    if (LeaveAppLine."Leave Code" <> "Leave Code") and ("Session Time" = "Session Time"::"First Half") then begin
                        LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                        LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                        if not LeaveApplicability.FINDFIRST() then
                            ERROR(Text004Lbl, LeaveAppLine."Leave Code", "Leave Code");
                    end;


            until LeaveAppLine.NEXT() = 0;

    end;

    procedure SessionValidations();
    begin
        if "Session Time" = "Session Time"::"First Half" then begin
            LeaveAppLine.RESET();
            LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
            if LeaveAppLine.FINDFIRST() then begin
                LeaveAppLine.SETFILTER(LeaveAppLine."To Date", '%1|%2', ("From Date" - 1), "From Date");
                LeaveAppLine.SETFILTER("Session Time", '<>%1', 1);
                if LeaveAppLine.FINDFIRST() then
                    if (LeaveAppLine."Leave Code" <> "Leave Code") and ("Leave Duration" = "Leave Duration"::"Half Day") then begin
                        LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                        LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                        if not LeaveApplicability.FINDFIRST() then
                            ERROR(Text004Lbl, LeaveAppLine."Leave Code", "Leave Code");
                    end;

            end;
            LeavePlanRec.RESET();
            LeavePlanRec.SETRANGE("Employee No", "Employee No.");
            LeavePlanRec.SETFILTER("Leave Date", '%1', ("From Date" - 1));
            LeavePlanRec.SETFILTER("Session Time", '<>%1', 1);
            LeavePlanRec.SETFILTER("Posted Status", '<>%1', LeavePlanRec."Posted Status"::Cancelled);
            if LeavePlanRec.FINDFIRST() then
                if (LeavePlanRec."Leave Code" <> "Leave Code") and ("Leave Duration" = "Leave Duration"::"Half Day") then begin
                    LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                    LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                    if not LeaveApplicability.FINDFIRST() then
                        ERROR(Text004Lbl, LeavePlanRec."Leave Code", "Leave Code");
                end;

        end;
        if "Session Time" = "Session Time"::"Second Half" then begin
            LeaveAppLine.RESET();
            LeaveAppLine.SETRANGE("Employee No.", "Employee No.");
            if LeaveAppLine.FINDFIRST() then begin
                LeaveAppLine.SETFILTER("From Date", '%1|%2', ("To Date" + 1), "To Date");
                if LeaveAppLine.FINDFIRST() then
                    if (LeaveAppLine."Leave Code" <> "Leave Code") and ("Leave Duration" = "Leave Duration"::"Half Day") then begin
                        LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                        LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeaveAppLine."Leave Code", "Leave Code");
                        if not LeaveApplicability.FINDFIRST() then
                            ERROR(Text004Lbl, LeaveAppLine."Leave Code", "Leave Code");
                    end;

            end;
            LeavePlanRec.RESET();
            LeavePlanRec.SETRANGE("Employee No", "Employee No.");
            LeavePlanRec.SETFILTER("Leave Date", '%1', ("To Date" + 1));
            LeavePlanRec.SETFILTER("Session Time", '<>%1', 2);
            LeavePlanRec.SETFILTER("Posted Status", '<>%1', LeavePlanRec."Posted Status"::Cancelled);
            if LeavePlanRec.FINDFIRST() then
                if (LeavePlanRec."Leave Code" <> "Leave Code") and ("Leave Duration" = "Leave Duration"::"Half Day") then begin
                    LeaveApplicability.SETFILTER("From Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                    LeaveApplicability.SETFILTER("To Leave Code", '%1|%2', LeavePlanRec."Leave Code", "Leave Code");
                    if not LeaveApplicability.FINDFIRST() then
                        ERROR(Text004Lbl, LeavePlanRec."Leave Code", "Leave Code");
                end;

        end;
        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETFILTER("Leave Date", '=%1', "From Date");
        LeavePlanRec.SETRANGE("Session Time", "Session Time");
        LeavePlanRec.SETFILTER("Posted Status", '<>%1', LeavePlanRec."Posted Status"::Cancelled);
        LeavePlanRec.SETFILTER("Approved Status", '<>%1', LeavePlanRec."Approved Status"::Rejected);
        if LeavePlanRec.FINDFIRST() then
            ERROR(Text007Lbl, "From Date");


        LeaveAppLine.RESET();
        LeaveAppLine.SETRANGE("Employee No.", Rec."Employee No.");
        LeaveAppLine.SETRANGE("Session Time", "Session Time");
        LeaveAppLine.SETFILTER(LeaveAppLine."From Date", '<=%1', Rec."From Date");
        LeaveAppLine.SETFILTER(LeaveAppLine."To Date", '>=%1', Rec."From Date");
        if LeaveAppLine.FINDFIRST() then
            repeat
                if (LeaveAppLine."Line No." <> "Line No.") or (LeaveAppLine."Document No." <> "Document No.") then
                    ERROR(Text007Lbl, "From Date");
            until LeaveAppLine.NEXT() = 0;

    end;

    procedure CalcProvLeaves();
    var
        ProvisionalLeaves: Record "Provisional Leaves B2B";
        ProLeaves: Decimal;
    begin
        CLEAR(ProLeaves);
        ProvisionalLeaves.RESET();
        ProvisionalLeaves.SETRANGE("Employee No.", "Employee No.");
        ProvisionalLeaves.SETRANGE("Leave Code", "Leave Code");
        ProvisionalLeaves.SETRANGE(Status, ProvisionalLeaves.Status::Open);
        ProvisionalLeaves.SETFILTER("Remaining Leaves", '<>%1', 0);
        ProvisionalLeaves.SETFILTER(ProvisionalLeaves."Period Start Date", '<=%1', "To Date");
        if ProvisionalLeaves.FINDFIRST() then
            repeat
                ProLeaves := ProLeaves + ProvisionalLeaves."Remaining Leaves";
            until ProvisionalLeaves.NEXT() = 0;
        "Provisional Leaves Avail" := ProLeaves;
    end;

    procedure CreateAppliedLeaves();
    var
        AppliedLeaves: Decimal;
    begin
        CLEAR(AppliedLeaves);
        GetLeaveYear();
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Employee No", "Employee No.");
        LeavePlan.SETRANGE("Leave Code", "Leave Code");
        LeavePlan.SETFILTER("Approved Status", '=%1|=%2', LeavePlan."Approved Status"::Applied, LeavePlan."Approved Status"::Approved);
        LeavePlan.SETFILTER("Posted Status", '<>%1', LeavePlan."Posted Status"::Cancelled);
        LeavePlan.SETFILTER("Leave Date", '>=%1&<=%2', YearStartDate, YearEndDate);
        if LeavePlan.FINDFIRST() then
            repeat
                AppliedLeaves += 1;
            until LeavePlan.NEXT() = 0;
        "Applied Leaves History" := AppliedLeaves;
    end;

    procedure CheckLeavePlan(LeaveAppPar: Record "Leave Application Line B2B");
    var
        TempProvLeaves: Record "Provisional Leaves B2B" temporary;
        ProvisionalLeaves: Record "Provisional Leaves B2B";
        AvailableLeaves: Decimal;
        CountLeaves: Decimal;
    begin
        CLEAR(CountLeaves);
        TempProvLeaves.DELETEALL();
        ProvisionalLeaves.RESET();
        ProvisionalLeaves.SETRANGE("Employee No.", "Employee No.");
        ProvisionalLeaves.SETRANGE("Leave Code", "Leave Code");
        ProvisionalLeaves.SETFILTER("Period Start Date", '<=%1', "To Date");
        if ProvisionalLeaves.FINDFIRST() then
            repeat
                TempProvLeaves.INIT();
                TempProvLeaves.TRANSFERFIELDS(ProvisionalLeaves);
                TempProvLeaves.INSERT();
            until ProvisionalLeaves.NEXT() = 0;


        AvailableLeaves := 0;
        if TempProvLeaves.FINDFIRST() then
            repeat
                AvailableLeaves := AvailableLeaves + TempProvLeaves."Remaining Leaves";
                LeavePlanRec.RESET();
                LeavePlanRec.SETRANGE("Leave Application No.", LeaveAppPar."Document No.");
                LeavePlanRec.SETRANGE("Employee No", LeaveAppPar."Employee No.");
                LeavePlanRec.SETRANGE("Leave Code", TempProvLeaves."Leave Code");
                LeavePlanRec.SETRANGE("Leave Type", LeavePlanRec."Leave Type"::Leave);
                LeavePlanRec.SETFILTER(LeavePlanRec."Posted Status", '<>%1', LeavePlanRec."Posted Status"::Cancelled);
                LeavePlanRec.SETFILTER("Leave Date", '>=%1&<=%2', TempProvLeaves."Period Start Date", TempProvLeaves."Period End Date");
                if LeavePlanRec.FINDFIRST() then begin
                    repeat
                        if LeavePlanRec."Leave Duration" = LeavePlanRec."Leave Duration"::Leave then
                            CountLeaves := CountLeaves + 1
                        else
                            if LeavePlanRec."Leave Duration" = LeavePlanRec."Leave Duration"::"Half Day" then
                                CountLeaves := CountLeaves + 0.5;
                    until LeavePlanRec.NEXT() = 0;
                    if CountLeaves > AvailableLeaves then
                        ERROR(Text013Lbl)
                    else
                        AvailableLeaves := AvailableLeaves - LeavePlanRec.COUNT();
                end;
            until TempProvLeaves.NEXT() = 0;

    end;

    procedure InsertHalfDayLOP(LeavePlanVar: Record "Leave Plan B2B");
    var
        LeavePlan2: Record "Leave Plan B2B";
    begin
        LeavePlan2.INIT();
        LeavePlan2.TRANSFERFIELDS(LeavePlanVar);
        LeavePlan2."Leave Duration" := LeavePlan2."Leave Duration"::"Half Day";
        LeavePlan2."Leave Type" := LeavePlan2."Leave Type"::LOP;
        LeavePlan2."Session Time" := LeavePlan2."Session Time"::"Second Half";
        LeavePlan2."Leave Application No." := "Document No.";
        LeavePlan2.Month := DATE2DMY(LeavePlanVar."Leave Date", 2);
        LeavePlan2.Year := DATE2DMY(LeavePlanVar."Leave Date", 3);
        LeavePlan2."Approved Status" := LeavePlanVar."Approved Status"::Applied;
        LeavePlan2.INSERT();
    end;
}

