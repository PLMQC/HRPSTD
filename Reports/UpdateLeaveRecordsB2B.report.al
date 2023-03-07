report 33001249 "Update Leave Records B2B"
{
    // version B2BHR1.00.00

    Caption = 'Update Leave Records';
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Leave Plan"; "Leave Plan B2B")
        {
            DataItemTableView = SORTING ("Employee No", "Leave Code", "Leave Date") WHERE ("Approved Status" = FILTER (<> " " | <> Applied), "Posted Status" = FILTER (<> Cancelled), "Attendance Processed" = CONST (false));
            dataitem("Daily Attendance"; "Daily Attendance B2B")
            {
                DataItemLink = "Employee No." = FIELD ("Employee No"), Date = FIELD ("Leave Date");
                DataItemTableView = SORTING ("Employee No.", Date);

                trigger OnAfterGetRecord();
                begin
                    if ("Leave Plan"."Leave Type" = "Leave Plan"."Leave Type"::LOP) and not "Leave Plan"."Compensatory Leave" then begin
                        "Daily Attendance"."Leave Application No." := "Leave Plan"."Leave Application No.";
                        if "Leave Plan"."Leave Duration" = "Leave Plan"."Leave Duration"::"Half Day" then begin
                            "Daily Attendance"."Halfday Status" := "Daily Attendance"."Halfday Status"::"HD Absent";
                            "Daily Attendance"."Session Time" := "Leave Plan"."Session Time";
                            "Daily Attendance"."Leave Code" := "Leave Plan"."Leave Code";
                            "Daily Attendance".Leave := 0;
                            "Daily Attendance".Absent := 0.5;
                            "Daily Attendance".Present := 0.5;
                        end else begin
                            "Daily Attendance"."Attendance Type" := "Daily Attendance"."Attendance Type"::Absent;
                            "Daily Attendance"."Leave Code" := "Leave Plan"."Leave Code";
                            "Daily Attendance".Leave := 0;
                            "Daily Attendance".Absent := 1;
                            "Daily Attendance".Present := 0;
                        end;
                        "Daily Attendance".MODIFY();
                    end else
                        if ("Leave Plan"."Leave Type" = "Leave Plan"."Leave Type"::LOP) and "Leave Plan"."Compensatory Leave" then begin
                            "Daily Attendance"."Attendance Type" := "Daily Attendance"."Attendance Type"::Leave;
                            "Daily Attendance"."Compensatory Leave" := true;
                            "Daily Attendance"."Leave Application No." := "Leave Plan"."Leave Application No.";
                            "Daily Attendance".Leave := 0;
                            "Daily Attendance".Absent := 0;
                            "Daily Attendance".Present := 1;
                            "Daily Attendance".MODIFY();
                        end else
                            if "Leave Plan"."Leave Type" = "Leave Plan"."Leave Type"::Leave then
                                if "Leave Plan"."Approved Status" = "Leave Plan"."Approved Status"::Rejected then begin
                                    "Daily Attendance"."Leave Application No." := "Leave Plan"."Leave Application No.";
                                    if "Leave Plan"."Leave Duration" = "Leave Plan"."Leave Duration"::"Half Day" then begin
                                        "Daily Attendance"."Halfday Status" := "Daily Attendance"."Halfday Status"::"HD Absent";
                                        "Daily Attendance"."Session Time" := "Leave Plan"."Session Time";
                                        "Daily Attendance"."Leave Code" := "Leave Plan"."Leave Code";
                                        "Daily Attendance".Leave := 0;
                                        "Daily Attendance".Absent := 0.5;
                                        "Daily Attendance".Present := 0.5;
                                    end else begin
                                        "Daily Attendance"."Attendance Type" := "Daily Attendance"."Attendance Type"::Absent;
                                        "Daily Attendance"."Leave Code" := "Leave Plan"."Leave Code";
                                        "Daily Attendance".Leave := 0;
                                        "Daily Attendance".Absent := 1;
                                        "Daily Attendance".Present := 0;
                                    end;
                                    "Daily Attendance".MODIFY();
                                end else
                                    if "Leave Plan"."Approved Status" = "Leave Plan"."Approved Status"::Approved then begin
                                        "Daily Attendance"."Leave Code" := "Leave Plan"."Leave Code";
                                        "Daily Attendance"."Leave Application No." := "Leave Plan"."Leave Application No.";
                                        if "Leave Plan"."Leave Duration" = "Leave Plan"."Leave Duration"::"Half Day" then begin
                                            "Daily Attendance"."Halfday Status" := "Daily Attendance"."Halfday Status"::"HD Leave";
                                            "Daily Attendance"."Session Time" := "Leave Plan"."Session Time";
                                            "Daily Attendance".Leave := 0.5;
                                            "Daily Attendance".Absent := 0;
                                            "Daily Attendance".Present := 1;
                                        end else begin
                                            "Daily Attendance"."Attendance Type" := "Daily Attendance"."Attendance Type"::Leave;
                                            "Daily Attendance".Leave := 1;
                                            "Daily Attendance".Absent := 0;
                                            "Daily Attendance".Present := 1;
                                        end;
                                        "Daily Attendance".MODIFY();
                                    end;

                    "Leave Plan"."Attendance Processed" := true;
                    "Leave Plan".MODIFY();
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Window.UPDATE(1, "Leave Plan"."Employee No");
                InsertDetailLeaves("Leave Plan");
            end;

            trigger OnPreDataItem();
            begin
                "Leave Plan".SETFILTER("Leave Date", '>=%1 & <=%2', FromDate, ToDate);
                "Leave Plan".SETFILTER("Employee No", EmployeeNo);

                PostedLeaveAppLine.RESET();
                PostedLeaveAppLine.SETFILTER("Employee No.", EmployeeNo);
                PostedLeaveAppLine.SETRANGE("Set For Approval", true);
                if PostedLeaveAppLine.FINDFIRST() then
                    repeat
                        if ((PostedLeaveAppLine."From Date" >= FromDate) and (PostedLeaveAppLine."From Date" <= ToDate)) or
                          ((PostedLeaveAppLine."To Date" >= FromDate) and (PostedLeaveAppLine."To Date" <= ToDate)) then
                            ERROR(Text002Txt);
                    until PostedLeaveAppLine.NEXT() = 0;

                PostedLeaveAppLine.RESET();
                PostedLeaveAppLine.SETFILTER("Employee No.", EmployeeNo);
                PostedLeaveAppLine.SETRANGE("Pending For Cancellation", true);
                if PostedLeaveAppLine.FINDFIRST() then
                    repeat
                        if ((PostedLeaveAppLine."From Date" >= FromDate) and (PostedLeaveAppLine."From Date" <= ToDate))
                          or
                          ((PostedLeaveAppLine."To Date" >= FromDate) and (PostedLeaveAppLine."To Date" <= ToDate)) then
                            ERROR(Text002Txt);
                    until PostedLeaveAppLine.NEXT() = 0;
            end;
        }
    }

    requestpage
    {
        Caption = 'Update Leave Records';

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        Window.CLOSE();
    end;

    trigger OnPreReport();
    begin
        Window.OPEN(Text001Txt);
    end;

    var
        PostedLeaveAppLine: Record "Posted Leave App Line B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Window: Dialog;
        Text001Txt: Label 'Emp No.....#1######################\', Comment = '%1 = No';
        FromDate: Date;
        ToDate: Date;

        EmployeeNo: Code[20];
        Text002Txt: Label 'One or more Leave applications are pending for Approval';
        CompensatoryLeaveTxt: Label 'Compensatory Leave';

    procedure InsertDetailLeaves(LeavePlan: Record "Leave Plan B2B");
    var
        Employee: Record "Employee B2B";
        EmpLeaves: Record "Employee Leaves B2B";
        EmpLeavesRec: Record "Employee Leaves B2B";
        DetailedLeaves: Record "Detailed Leave Records B2B";
        DetailsLeaveRec: Record "Detailed Leave Records B2B";
        DetailsLeaveRecNum: Record "Detailed Leave Records B2B";
        HRSetup: Record "HR Setup B2B";
        Num: Integer;
    begin
        CLEAR(Num);
        HRSetup.GET();
        DetailsLeaveRecNum.RESET();
        if DetailsLeaveRecNum.FINDLAST() then
            Num := DetailsLeaveRecNum."Entry No." + 1
        else
            Num := 1;

        if (LeavePlan."Leave Type" = LeavePlan."Leave Type"::Leave) and (LeavePlan."Approved Status" = LeavePlan."Approved Status"::Approved) then begin
            Employee.GET(LeavePlan."Employee No");
            DetailsLeaveRec.INIT();
            DetailsLeaveRec."Entry No." := Num;
            DetailsLeaveRec."Employee No." := LeavePlan."Employee No";
            DetailsLeaveRec.VALIDATE("Leave Code", LeavePlan."Leave Code");
            DetailsLeaveRec."Entry Type" := DetailsLeaveRec."Entry Type"::Utilization;
            DetailsLeaveRec."Entry Date" := LeavePlan."Leave Date";
            DetailsLeaveRec."Posting Date" := WORKDATE();
            DetailsLeaveRec."Leave Pay Cadre" := Employee."Pay Cadre";
            DetailsLeaveRec.Month := DATE2DMY(DetailsLeaveRec."Entry Date", 2);
            DetailsLeaveRec.Year := DATE2DMY(DetailsLeaveRec."Entry Date", 3);
            if LeavePlan."Leave Duration" = LeavePlan."Leave Duration"::"Half Day" then
                DetailsLeaveRec."No. of Leaves" := -0.5
            else
                DetailsLeaveRec."No. of Leaves" := -1;
            evaluate(DetailsLeaveRec."Approved By",USERID());
            DetailsLeaveRec."Leave Application No." := LeavePlan."Leave Application No.";
            DetailedLeaves.RESET();
            DetailedLeaves.SETRANGE("Employee No.", DetailsLeaveRec."Employee No.");
            DetailedLeaves.SETRANGE("Entry Type", DetailsLeaveRec."Entry Type");
            DetailedLeaves.SETRANGE("Leave Code", DetailsLeaveRec."Leave Code");
            DetailedLeaves.SETRANGE("Entry Date", DetailsLeaveRec."Entry Date");
            if not DetailedLeaves.FINDFIRST() then begin
                DetailsLeaveRec.INSERT();
                Num := Num + 1;
            end;
        end;

        if (LeavePlan."Leave Type" = LeavePlan."Leave Type"::LOP) and (LeavePlan."Compensatory Leave") then begin
            HRSetup.TESTFIELD("Compensatory Leave Code");
            Employee.GET(LeavePlan."Employee No");
            EmpLeavesRec.RESET();
            EmpLeavesRec.SETRANGE("No.", LeavePlan."Employee No");
            EmpLeavesRec.SETRANGE("Leave Code", HRSetup."Compensatory Leave Code");
            if EmpLeavesRec.IsEmpty() then begin
                EmpLeaves.INIT();
                EmpLeaves."No." := LeavePlan."Employee No";
                EmpLeaves."Leave Pay Cadre" := Employee."Pay Cadre";
                EmpLeaves."Leave Code" := HRSetup."Compensatory Leave Code";
                EmpLeaves."Leave Description" := CompensatoryLeaveTxt;
                EmpLeaves.INSERT();
            end;

            DetailsLeaveRec.INIT();
            DetailsLeaveRec."Entry No." := Num;
            DetailsLeaveRec."Employee No." := LeavePlan."Employee No";
            DetailsLeaveRec."Leave Code" := HRSetup."Compensatory Leave Code";
            DetailsLeaveRec."Leave Description" := CompensatoryLeaveTxt;
            DetailsLeaveRec."Entry Type" := DetailsLeaveRec."Entry Type"::Entitlement;
            DetailsLeaveRec."Entry Date" := LeavePlan."Leave Date";
            DetailsLeaveRec."Posting Date" := WORKDATE();
            DetailsLeaveRec."Leave Pay Cadre" := Employee."Pay Cadre";
            DetailsLeaveRec.Month := DATE2DMY(DetailsLeaveRec."Entry Date", 2);
            DetailsLeaveRec.Year := DATE2DMY(DetailsLeaveRec."Entry Date", 3);
            if LeavePlan."Leave Duration" = LeavePlan."Leave Duration"::"Half Day" then
                DetailsLeaveRec."No. of Leaves" := 0.5
            else
                DetailsLeaveRec."No. of Leaves" := 1;
            DetailsLeaveRec."Leave Application No." := LeavePlan."Leave Application No.";
            DetailedLeaves.RESET();
            DetailedLeaves.SETRANGE("Employee No.", DetailsLeaveRec."Employee No.");
            DetailedLeaves.SETRANGE("Entry Type", DetailsLeaveRec."Entry Type");
            DetailedLeaves.SETRANGE("Leave Code", DetailsLeaveRec."Leave Code");
            DetailedLeaves.SETRANGE("Entry Date", DetailsLeaveRec."Entry Date");
            DetailedLeaves.SETRANGE(Month, DetailsLeaveRec.Month);
            DetailedLeaves.SETRANGE(Year, DetailsLeaveRec.Year);
            if not DetailedLeaves.FINDFIRST() then begin
                DetailsLeaveRec.INSERT();
                Num := Num + 1;
            end;

            DetailsLeaveRec.INIT();
            DetailsLeaveRec."Entry No." := Num;
            DetailsLeaveRec."Employee No." := LeavePlan."Employee No";
            DetailsLeaveRec."Leave Code" := HRSetup."Compensatory Leave Code";
            DetailsLeaveRec."Leave Description" := CompensatoryLeaveTxt;
            DetailsLeaveRec."Entry Type" := DetailsLeaveRec."Entry Type"::Utilization;
            DetailsLeaveRec."Entry Date" := LeavePlan."Leave Date";
            DetailsLeaveRec."Posting Date" := WORKDATE();
            DetailsLeaveRec."Leave Pay Cadre" := Employee."Pay Cadre";
            DetailsLeaveRec.Month := DATE2DMY(DetailsLeaveRec."Entry Date", 2);
            DetailsLeaveRec.Year := DATE2DMY(DetailsLeaveRec."Entry Date", 3);
            if LeavePlan."Leave Duration" = LeavePlan."Leave Duration"::"Half Day" then
                DetailsLeaveRec."No. of Leaves" := -0.5
            else
                DetailsLeaveRec."No. of Leaves" := -1;
            DetailsLeaveRec."Leave Application No." := LeavePlan."Leave Application No.";
            DetailedLeaves.RESET();
            DetailedLeaves.SETRANGE("Employee No.", DetailsLeaveRec."Employee No.");
            DetailedLeaves.SETRANGE("Entry Type", DetailsLeaveRec."Entry Type");
            DetailedLeaves.SETRANGE("Leave Code", DetailsLeaveRec."Leave Code");
            DetailedLeaves.SETRANGE("Entry Date", DetailsLeaveRec."Entry Date");
            DetailedLeaves.SETRANGE(Month, DetailsLeaveRec.Month);
            DetailedLeaves.SETRANGE(Year, DetailsLeaveRec.Year);
            if DetailedLeaves.IsEmpty() then
                DetailsLeaveRec.INSERT();
        end;
    end;

    procedure SetDates(CurrentFromDate: Date; CurrentToDate: Date);
    begin
        FromDate := CurrentFromDate;
        ToDate := CurrentToDate;
    end;

    procedure OffDayUpdations();
    var
        DailyAttend: Record "Daily Attendance B2B";
        OffdayDailyAttend: Record "Daily Attendance B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        Flag: Boolean;
    begin
        CLEAR(Flag);
        DailyAttend.RESET();
        DailyAttend.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        DailyAttend.SETFILTER(Date, '>=%1 & <=%2', FromDate, ToDate);
        DailyAttend.SETFILTER("Leave Code", '<>%1', '');
        if DailyAttend.FINDFIRST() then
            repeat
                OffdayDailyAttend.RESET();
                OffdayDailyAttend.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                OffdayDailyAttend.SETFILTER("Leave Code", '<>%1', '');
                OffdayDailyAttend.SETFILTER(Date, '>%1', DailyAttend.Date);
                if OffdayDailyAttend.FINDFIRST() then
                    if DailyAttend."Leave Code" = OffdayDailyAttend."Leave Code" then begin
                        DailyAttendance.RESET();
                        DailyAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                        DailyAttendance.SETFILTER(Date, '>%1 & <%2', DailyAttend.Date, OffdayDailyAttend.Date);
                        if DailyAttendance.FINDFIRST() then
                            repeat
                                if (DailyAttendance."Attendance Type" = DailyAttendance."Attendance Type"::Present) and
                                  not (DailyAttendance."Non-Working") then
                                    Flag := true;
                            until DailyAttendance.NEXT() = 0;
                        if not Flag then begin
                            DailyAttendance.RESET();
                            DailyAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                            DailyAttendance.SETFILTER(Date, '>%1 & <%2', DailyAttend.Date, OffdayDailyAttend.Date);
                            if DailyAttendance.FINDFIRST() then
                                repeat
                                    DailyAttendance."Attendance Type" := "Daily Attendance"."Attendance Type"::Absent;
                                    DailyAttendance.Leave := 0;
                                    DailyAttendance.Absent := 1;
                                    DailyAttendance.Present := 0;
                                    DailyAttendance.MODIFY();
                                until DailyAttendance.NEXT() = 0;
                        end;
                    end;
            until DailyAttend.NEXT() = 0;
    end;

    procedure OffDayUpdationsHalfday();
    var
        DailyAttend: Record "Daily Attendance B2B";
        OffdayDailyAttend: Record "Daily Attendance B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        Flag: Boolean;
    begin
        DailyAttend.RESET();
        DailyAttend.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        DailyAttend.SETFILTER(Date, '>=%1 & <=%2', FromDate, ToDate);
        DailyAttend.SETFILTER("Leave Code", '<>%1', '');
        DailyAttend.SETFILTER("Session Time", '=%1', 2);
        if DailyAttend.FINDFIRST() then
            repeat
                OffdayDailyAttend.RESET();
                OffdayDailyAttend.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                OffdayDailyAttend.SETFILTER(Date, '>%1', DailyAttend.Date);
                OffdayDailyAttend.SETRANGE("Attendance Type", OffdayDailyAttend."Attendance Type"::Absent);
                if not OffdayDailyAttend.FINDFIRST() then begin
                    OffdayDailyAttend.RESET();
                    OffdayDailyAttend.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                    OffdayDailyAttend.SETFILTER("Leave Code", '<>%1', '');
                    OffdayDailyAttend.SETFILTER(Date, '>%1', DailyAttend.Date);
                    OffdayDailyAttend.SETFILTER("Session Time", '=%1', 1);
                end;
                if OffdayDailyAttend.FINDFIRST() then begin
                    Flag := false;
                    DailyAttendance.RESET();
                    DailyAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                    DailyAttendance.SETFILTER(Date, '>%1 & <%2', DailyAttend.Date, OffdayDailyAttend.Date);
                    if DailyAttendance.FINDFIRST() then
                        repeat
                            if (DailyAttendance."Attendance Type" = DailyAttendance."Attendance Type"::Present) and
                               not (DailyAttendance."Non-Working")
                            then
                                Flag := true;

                        until DailyAttendance.NEXT() = 0;
                    if not Flag then begin
                        DailyAttendance.RESET();
                        DailyAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                        DailyAttendance.SETFILTER(Date, '>%1 & <%2', DailyAttend.Date, OffdayDailyAttend.Date);
                        if DailyAttendance.FINDFIRST() then
                            repeat
                                DailyAttendance."Attendance Type" := "Daily Attendance"."Attendance Type"::Absent;
                                DailyAttendance.Leave := 0;
                                DailyAttendance.Absent := 1;
                                DailyAttendance.Present := 0;
                                DailyAttendance.MODIFY();
                            until DailyAttendance.NEXT() = 0;
                    end;
                end;
            until DailyAttend.NEXT() = 0;
    end;

    procedure TestDays();
    var
        DailyAttend: Record "Daily Attendance B2B";
        OffdayDailyAttend: Record "Daily Attendance B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        Flag: Boolean;
    begin
        DailyAttend.RESET();
        DailyAttend.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        DailyAttend.SETFILTER(Date, '>=%1 & <=%2', FromDate, ToDate);
        if DailyAttend.FINDFIRST() then
            repeat
                if (DailyAttend."Attendance Type" = DailyAttend."Attendance Type"::Absent) or
                   (DailyAttend."Leave Code" <> '') then begin
                    OffdayDailyAttend.RESET();
                    OffdayDailyAttend.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                    OffdayDailyAttend.SETRANGE("Non-Working", false);
                    OffdayDailyAttend.SETFILTER(Date, '>%1', DailyAttend.Date);
                    if OffdayDailyAttend.FINDFIRST() then
                        if (OffdayDailyAttend."Attendance Type" = OffdayDailyAttend."Attendance Type"::Absent) or
                           (OffdayDailyAttend."Leave Code" <> '') then begin
                            DailyAttendance.RESET();
                            DailyAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                            DailyAttendance.SETFILTER(Date, '>%1 & <%2', DailyAttend.Date, OffdayDailyAttend.Date);
                            if DailyAttendance.FINDFIRST() then
                                repeat
                                    if (DailyAttendance."Attendance Type" = DailyAttendance."Attendance Type"::Present) and
                                       not (DailyAttendance."Non-Working") then
                                        Flag := true;

                                until DailyAttendance.NEXT() = 0;
                            if not Flag then begin
                                DailyAttendance.RESET();
                                DailyAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                                DailyAttendance.SETFILTER(Date, '>%1 & <%2', DailyAttend.Date, OffdayDailyAttend.Date);
                                if DailyAttendance.FINDFIRST() then
                                    repeat
                                        DailyAttendance."Attendance Type" := "Daily Attendance"."Attendance Type"::Absent;
                                        DailyAttendance.Leave := 0;
                                        DailyAttendance.Absent := 1;
                                        DailyAttendance.Present := 0;
                                        DailyAttendance.MODIFY();
                                    until DailyAttendance.NEXT() = 0;
                            end;
                        end;
                end;
            until DailyAttend.NEXT() = 0;
    end;

    procedure TestHalfdays();
    var
        DailyAttend: Record "Daily Attendance B2B";
        OffdayDailyAttend: Record "Daily Attendance B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        Flag: Boolean;
    begin
        DailyAttend.RESET();
        DailyAttend.SETFILTER(Date, '>=%1 & <=%2', FromDate, ToDate);
        DailyAttend.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if DailyAttend.FINDFIRST() then
            repeat
                if (DailyAttend."Halfday Status" = DailyAttend."Halfday Status"::"HD Absent") or
                   (DailyAttend."Leave Code" <> '') or (DailyAttend."Halfday Status" = DailyAttend."Halfday Status"::"HD Leave")
                   and (DailyAttend."Session Time" = DailyAttend."Session Time"::"Second Half") then begin
                    OffdayDailyAttend.RESET();
                    OffdayDailyAttend.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                    OffdayDailyAttend.SETRANGE("Non-Working", false);
                    OffdayDailyAttend.SETFILTER(Date, '>%1', DailyAttend.Date);
                    if OffdayDailyAttend.FINDFIRST() then
                        if (OffdayDailyAttend."Halfday Status" = OffdayDailyAttend."Halfday Status"::"HD Absent") or
                           (OffdayDailyAttend."Leave Code" <> '') or
                           (OffdayDailyAttend."Halfday Status" = OffdayDailyAttend."Halfday Status"::"HD Leave") and
                           (OffdayDailyAttend."Session Time" = OffdayDailyAttend."Session Time"::"First Half") then begin
                            DailyAttendance.RESET();
                            DailyAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                            DailyAttendance.SETFILTER(Date, '>%1 & <%2', DailyAttend.Date, OffdayDailyAttend.Date);
                            if DailyAttendance.FINDFIRST() then
                                repeat
                                    if (DailyAttendance."Attendance Type" = DailyAttendance."Attendance Type"::Present) and
                                       not (DailyAttendance."Non-Working") then
                                        Flag := true;
                                until DailyAttendance.NEXT() = 0;
                            if not Flag then begin
                                DailyAttendance.RESET();
                                DailyAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                                DailyAttendance.SETFILTER(Date, '>%1 & <%2', DailyAttend.Date, OffdayDailyAttend.Date);
                                if DailyAttendance.FINDFIRST() then
                                    repeat
                                        DailyAttendance."Attendance Type" := "Daily Attendance"."Attendance Type"::Absent;
                                        DailyAttendance.Leave := 0;
                                        DailyAttendance.Absent := 1;
                                        DailyAttendance.Present := 0;
                                        DailyAttendance.MODIFY();
                                    until DailyAttendance.NEXT() = 0;
                            end;
                        end;
                end;
            until DailyAttend.NEXT() = 0;
    end;

    procedure SetInfo(CurrentFromDate: Date; CurrentToDate: Date; CurrentEmployeeNo: Code[20]);
    begin
        FromDate := CurrentFromDate;
        ToDate := CurrentToDate;
        EmployeeNo := CurrentEmployeeNo;
    end;
}

