table 33001371 "Shift Schedule Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shift Schedule Header';
    DrillDownPageID = "Shift Schedule List B2B";
    LookupPageID = "Shift Schedule List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(4; "Global Dimesion 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimesion 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(5; "Physical Location"; Code[20])
        {
            Caption = 'Physical Location';
            DataClassification = CustomerContent;
        }
        field(6; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;
        }
        field(9; "Current Shift"; Code[20])
        {
            Caption = 'Current Shift';
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckValidations();
            end;
        }
        field(10; "Revised Shift"; Code[20])
        {
            Caption = 'Revised Shift';
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckValidations();
            end;
        }
        field(14; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
        }
        field(25; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(30; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        ShiftSchLines.RESET();
        ShiftSchLines.SETRANGE("Document No.", "No.");
        ShiftSchLines.DELETEALL();
    end;

    trigger OnInsert();
    begin
        if "No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Shift Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Shift Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup B2B";
        ShiftSchLines: Record "Shift Schedule Line B2B";
        NoSeriesMgt: Codeunit 396;
        Text001Lbl: Label 'Current Shift and Revised Shift cannt be same';
        Text002Lbl: Label 'No entries exist against the Document No : %1', Comment = '%1 = No.';
        Text003Lbl: Label 'Processing Employee #1##############', Comment = '%1 = Processing Employee';

    procedure AssistEdit(OldShiftSchedule: Record "Shift Schedule Header B2B"): Boolean;
    var
        ShiftSchedule: Record "Shift Schedule Header B2B";
    begin
        with ShiftSchedule do begin
            ShiftSchedule := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Shift Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Shift Nos.", OldShiftSchedule."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Shift Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := ShiftSchedule;
                exit(true);
            end;
        end;
    end;

    procedure CheckValidations();
    begin
        if "Current Shift" = "Revised Shift" then
            ERROR(Text001Lbl);
    end;

    procedure InsertEmployees();
    var
        EmployeeRec: Record "Employee B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        ScheduleLines: Record "Shift Schedule Line B2B";
    begin
        CheckValidations();

        TESTFIELD("Current Shift");
        TESTFIELD("Revised Shift");
        TESTFIELD("Effective Date");
        EmployeeRec.RESET();
        if "Global Dimesion 1 Code" <> '' then
            EmployeeRec.SETRANGE("Global Dimension 1 Code", "Global Dimesion 1 Code");
        if Department <> '' then
            EmployeeRec.SETRANGE("Department Code", Department);
        if EmployeeRec.FINDFIRST() then
            repeat
                DailyAttendance.RESET();
                DailyAttendance.SETRANGE("Employee No.", EmployeeRec."No.");
                DailyAttendance.SETRANGE(Date, "Effective Date");
                DailyAttendance.SETRANGE("Revised Shift", "Current Shift");
                if DailyAttendance.FINDFIRST() then begin
                    ScheduleLines.INIT();
                    ScheduleLines."Document No." := "No.";
                    ScheduleLines."Employee No." := DailyAttendance."Employee No.";
                    ScheduleLines."Current Shift" := DailyAttendance."Revised Shift";
                    ScheduleLines."Revised Shift" := "Revised Shift";
                    ScheduleLines.INSERT();
                end;
            until EmployeeRec.NEXT() = 0;

    end;

    procedure UpdateEmployeeShift();
    var

        DailyAttendance: Record "Daily Attendance B2B";
        ShiftMaster: Record "Shift Master B2B";
        Window: Dialog;
        ShiftStartTime: Time;
        ShiftEndTime: Time;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        InTimePunch: DateTime;
        OutTimePunch: DateTime;
        CheckTime: Time;
    begin
        InTimePunch := 0DT;
        OutTimePunch := 0DT;
        CheckValidEntries();
        ShiftSchLines.RESET();
        ShiftSchLines.SETRANGE("Document No.", "No.");
        if ShiftSchLines.FINDFIRST() then begin
            Window.OPEN(Text003Lbl);
            repeat
                DailyAttendance.RESET();
                DailyAttendance.SETRANGE("Employee No.", ShiftSchLines."Employee No.");
                DailyAttendance.SETFILTER(Date, '>=%1', "Effective Date");
                DailyAttendance.SETRANGE("Revised Shift", "Current Shift");
                if DailyAttendance.FINDFIRST() then
                    repeat
                        Window.UPDATE(1, DailyAttendance."Employee No.");
                        DailyAttendance."Current Shift" := "Current Shift";
                        DailyAttendance."Revised Shift" := "Revised Shift";
                        if ShiftMaster.GET("Revised Shift", DailyAttendance."Location Code") then begin
                            CheckTime := 130000T;
                            ShiftStartTime := ShiftMaster."Starting Time";
                            ShiftEndTime := ShiftMaster."Ending Time";
                            DailyAttendance."Break Duration" := ShiftMaster."Break Duration";
                            StartDateTime := CREATEDATETIME(DailyAttendance.Date, ShiftStartTime);
                            if ShiftEndTime < ShiftStartTime then
                                EndDateTime := CREATEDATETIME((DailyAttendance.Date + 1), ShiftEndTime)
                            else
                                EndDateTime := CREATEDATETIME((DailyAttendance.Date), ShiftEndTime);
                            if (ShiftStartTime > CheckTime) and (ShiftEndTime < CheckTime) then
                                DailyAttendance."Hours Worked" := ABS((StartDateTime - EndDateTime) / 3600000) - ShiftMaster."Break Duration"
                            else
                                DailyAttendance."Hours Worked" :=
                                  ABS((DailyAttendance."Time In" - DailyAttendance."Time Out") / 3600000) -
                                  ShiftMaster."Break Duration";
                            DailyAttendance."Actual Time In" := DT2TIME(StartDateTime);
                            DailyAttendance."Actual Time Out" := DT2TIME(EndDateTime);
                            if (ShiftStartTime > CheckTime) and (ShiftEndTime < CheckTime) then begin
                                StartDateTime := CREATEDATETIME(DailyAttendance.Date, ShiftStartTime);
                                EndDateTime := CREATEDATETIME((DailyAttendance.Date + 1), ShiftEndTime);
                                DailyAttendance."Actual Hrs" := ABS((StartDateTime - EndDateTime) / 3600000) - ShiftMaster."Break Duration";
                            end else
                                DailyAttendance."Actual Hrs" :=
                                  ABS((DailyAttendance."Actual Time In" - DailyAttendance."Actual Time Out") / 3600000) -
                                  ShiftMaster."Break Duration";
                            DailyAttendance."Time In" := DT2TIME(InTimePunch);
                            DailyAttendance."Time Out" := DT2TIME(OutTimePunch);
                            DailyAttendance.MODIFY();
                        end;
                    until DailyAttendance.NEXT() = 0;

            until ShiftSchLines.NEXT() = 0;
            Posted := true;
            if MODIFY() then;
            Window.CLOSE();
        end;
    end;

    procedure CheckValidEntries();
    var
        RowCount: Integer;
    begin
        CLEAR(RowCount);
        ShiftSchLines.RESET();
        ShiftSchLines.SETRANGE("Document No.", "No.");
        RowCount := ShiftSchLines.COUNT();
        if RowCount = 0 then
            ERROR(Text002Lbl, "No.");
    end;
}

