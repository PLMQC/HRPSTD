table 33001327 "Temp Summary Attendance B2B"
{
    // version B2BHR1.00.00

    Caption = 'Temp Summary Attendance_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; "Time In"; Time)
        {
            Caption = 'Time In';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
            end;
        }
        field(4; "Time Out"; Time)
        {
            Caption = 'Time Out';
            DataClassification = CustomerContent;
        }
        field(5; "Hours Worked"; Decimal)
        {
            Caption = 'Hours Worked';
            DataClassification = CustomerContent;
        }
        field(7; "Non-Working"; Boolean)
        {
            Caption = 'Non-Working';
            DataClassification = CustomerContent;
        }
        field(8; "Non-Working Type"; Option)
        {
            Caption = 'Non-Working Type';
            OptionCaption = ' ,Holiday,OffDay';
            OptionMembers = " ",Holiday,OffDay;
            DataClassification = CustomerContent;
        }
        field(9; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            OptionCaption = ' ,Present,Absent,Leave';
            OptionMembers = " ",Present,Absent,Leave;
            DataClassification = CustomerContent;
        }
        field(11; WeeklyOff; Decimal)
        {
            Caption = 'WeeklyOff';
            DataClassification = CustomerContent;
        }
        field(12; Holiday; Decimal)
        {
            Caption = 'Holiday';
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
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
            DataClassification = CustomerContent;
        }
        field(16; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Leave Master B2B";
            DataClassification = CustomerContent;
        }
        field(17; Present; Decimal)
        {
            Caption = 'Present';
            DataClassification = CustomerContent;
        }
        field(18; Absent; Decimal)
        {
            Caption = 'Absent';
            DataClassification = CustomerContent;
        }
        field(19; Leave; Decimal)
        {
            Caption = 'Leave';
            DataClassification = CustomerContent;
        }
        field(28; "Not Joined"; Decimal)
        {
            Caption = 'Not Joined';
            DataClassification = CustomerContent;
        }
        field(35; "Time Punches"; Integer)
        {
            CalcFormula = Count ("Daily Time Punches B2B" WHERE("Employee No." = FIELD("Employee No."),
                                                            Date = FIELD(Date)));
            Caption = 'Time Punches';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Current Shift"; Code[20])
        {
            Caption = 'Current Shift';
            Editable = false;
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;
        }
        field(74; "Revised Shift"; Code[20])
        {
            Caption = 'Revised Shift';
            Editable = false;
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;
        }
        field(80; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(82; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;
        }
        field(100; Modified; Boolean)
        {
            Caption = 'Modified';
            DataClassification = CustomerContent;
        }
        field(110; "Manual Attendance"; Boolean)
        {
            Caption = 'Manual Attendance';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(151; Executed; Boolean)
        {
            Caption = 'Executed';
            DataClassification = CustomerContent;
        }
        field(152; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(153; "Attandance Type 2"; Option)
        {
            Caption = 'Attandance Type 2';
            OptionCaption = 'WO,Absent,Present*,Present';
            OptionMembers = WO,Absent,"Present*",Present;
            DataClassification = CustomerContent;
        }
        field(154; "Machine Attendance"; Boolean)
        {
            Caption = 'Machine Attendance';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Date)
        {
        }
        key(Key2; Month, Year)
        {
        }
        key(Key3; Date)
        {
        }
        key(Key4; "Manual Attendance")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Window: Dialog;
        Text001Lbl: Label 'Do you want to post the entries for the Month : %1, Year %2', Comment = '%1 = Month ; %2 = Year';
        Text002Lbl: Label 'Current month entries transferred to history successfully.';
        Text003Lbl: Label 'Daily Attendance updated successfully.';
        Text004Lbl: Label 'No records found';
        Text005Lbl: Label 'Posting Employee .....\ Employee No   #1###########################', Comment = '%1 =Employee No ';
        Text006Lbl: Label 'Updating Attendance ....\ Employee No #1########## \ Date        #2##########', Comment = '%1 = Employee No ; %2 = Date';

    procedure UpdateDailyAttendance(PaySlipMonth: Integer; PaySlipYear: Integer; CheckEmployee: Code[20]; CheckDate: Date);
    var
        TempSumAttendance: Record "Temp Summary Attendance B2B";
        DailyAttendance: Record "Daily Attendance B2B";
    begin
        TempSumAttendance.RESET();
        TempSumAttendance.SETCURRENTKEY(TempSumAttendance.Month, TempSumAttendance.Year);
        TempSumAttendance.SETRANGE(Month, PaySlipMonth);
        TempSumAttendance.SETRANGE(Year, PaySlipYear);
        if CheckEmployee <> '' then
            TempSumAttendance.SETRANGE("Employee No.", CheckEmployee);
        if CheckDate <> 0D then
            TempSumAttendance.SETRANGE(Date, CheckDate);
        if TempSumAttendance.FINDFIRST() then begin
            Window.OPEN(Text006Lbl);
            repeat
                DailyAttendance.RESET();
                DailyAttendance.SETRANGE("Employee No.", TempSumAttendance."Employee No.");
                DailyAttendance.SETRANGE(Date, TempSumAttendance.Date);
                if DailyAttendance.FINDFIRST() then begin
                    DailyAttendance.VALIDATE("Revised Shift", TempSumAttendance."Revised Shift");
                    DailyAttendance."Time Out" := TempSumAttendance."Time Out";
                    DailyAttendance."Time In" := TempSumAttendance."Time In";
                    DailyAttendance."Attendance Type" := TempSumAttendance."Attendance Type";
                    DailyAttendance.Present := TempSumAttendance.Present;
                    DailyAttendance.Absent := TempSumAttendance.Absent;
                    DailyAttendance.VALIDATE("Time Out");
                    DailyAttendance.VALIDATE("Time In");
                    DailyAttendance.MODIFY();
                    Window.UPDATE(1, TempSumAttendance."Employee No.");
                    Window.UPDATE(2, TempSumAttendance.Date);
                end;
            until TempSumAttendance.NEXT() = 0;
            Window.CLOSE();
            MESSAGE(Text003Lbl);
        end;
    end;

    procedure PostMachineAttendance(PaySlipMonth: Integer; PaySlipYear: Integer);
    var
        TempSummAttendanceRec: Record "Temp Summary Attendance B2B";
    begin
        if CONFIRM(Text001Lbl, true, PaySlipMonth, PaySlipYear) then begin
            TempSummAttendanceRec.RESET();
            TempSummAttendanceRec.SETRANGE(Year, PaySlipYear);
            TempSummAttendanceRec.SETRANGE(Month, PaySlipMonth);
            TempSummAttendanceRec.SETRANGE(Executed, false);
            if TempSummAttendanceRec.FINDFIRST() then begin
                Window.OPEN(Text005Lbl);
                repeat
                    Window.UPDATE(1, TempSummAttendanceRec."Employee No.");
                    TempSummAttendanceRec.Executed := true;
                    TempSummAttendanceRec.MODIFY();
                until TempSummAttendanceRec.NEXT() = 0;
                Window.CLOSE();
                MESSAGE(Text002Lbl);
            end else
                MESSAGE(Text004Lbl);
        end;
    end;
}

