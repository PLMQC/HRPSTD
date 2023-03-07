table 33001212 "Employee Shift B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Shift';
    DrillDownPageID = "Employee Shift B2B";
    LookupPageID = "Employee Shift B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                Employee.GET("Employee Code");
                "Employee Name" := Employee."First Name";
                VALIDATE("Start Date", Employee."Employment Date");
            end;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Employee.SETRANGE("No.", "Employee Code");
                if Employee.FINDFIRST() then
                    if "Start Date" < Employee."Employment Date" then
                        ERROR(Text000Lbl, Employee."No.");

            end;
        }
        field(3; "Shift Code"; Code[20])
        {
            Caption = 'Shift Code';
            NotBlank = true;
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Start Date");
                Employee.GET("Employee Code");
                if ShiftMaster.GET("Shift Code", Employee."Location Code") then begin
                    "Shift Start Time" := ShiftMaster."Starting Time";
                    "Shift End Time" := ShiftMaster."Ending Time";
                    "Break Duration" := ShiftMaster."Break Duration";
                end;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(5; "Shift Start Time"; Time)
        {
            Caption = 'Shift Start Time';
            DataClassification = CustomerContent;
        }
        field(6; "Shift End Time"; Time)
        {
            Caption = 'Shift End Time';
            DataClassification = CustomerContent;
        }
        field(7; "Break Duration"; Decimal)
        {
            Caption = 'Break Duration';
            DataClassification = CustomerContent;
        }
        field(10; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Start Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
        ShiftMaster: Record "Shift Master B2B";
        Text000Lbl: Label 'Shift start date should be greater than employement date%1.', Comment = '%1 = Employee  No';
        LEAVEYEARTxt: Label 'LEAVE YEAR';

    procedure UpdateShiftTimings();
    var
        DailyAttendance: Record "Daily Attendance B2B";
        EmployeeShift: Record "Employee Shift B2B";
        Payyear: Record "Payroll Year B2B";
        EndDate: Date;
        StartDate: Date;
        StartTime: Time;
        EndTime: Time;
        CheckTime: Time;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
    begin
        CheckTime := 130000T;
        EmployeeShift.SETRANGE("Employee Code", "Employee Code");
        if EmployeeShift.FINDFIRST() then
            repeat
                StartTime := EmployeeShift."Shift Start Time";
                EndTime := EmployeeShift."Shift End Time";
                StartDate := EmployeeShift."Start Date";
                if EmployeeShift.NEXT() <> 0 then begin
                    EndDate := EmployeeShift."Start Date" - 1;
                    EmployeeShift.NEXT(-1);
                end else begin
                    Payyear.SETRANGE("Year Type", LEAVEYEARTxt);
                    Payyear.SETRANGE(Closed, false);
                    if Payyear.FINDFIRST() then
                        EndDate := Payyear."Year End Date";
                end;
                DailyAttendance.SETRANGE("Employee No.", "Employee Code");
                DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, EndDate);
                if DailyAttendance.FINDFIRST() then
                    repeat
                        DailyAttendance."Time In" := StartTime;
                        DailyAttendance."Time Out" := EndTime;
                        if (StartTime > CheckTime) and (EndTime < CheckTime) then begin
                            StartDateTime := CREATEDATETIME(DailyAttendance.Date, DailyAttendance."Time In");
                            EndDateTime := CREATEDATETIME((DailyAttendance.Date + 1), DailyAttendance."Time Out");
                            DailyAttendance."Hours Worked" := ABS((StartDateTime - EndDateTime) / 3600000) - EmployeeShift."Break Duration";
                        end else
                            DailyAttendance."Hours Worked" :=
                              ABS((DailyAttendance."Time In" - DailyAttendance."Time Out") / 3600000) -
                              EmployeeShift."Break Duration";
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
                        DailyAttendance."Revised Shift Code" := EmployeeShift."Shift Code";
                        DailyAttendance.MODIFY();
                    until DailyAttendance.NEXT() = 0;

            until EmployeeShift.NEXT() = 0;
    end;
}

