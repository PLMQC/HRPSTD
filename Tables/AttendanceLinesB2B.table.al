table 33001367 "Attendance Lines B2B"
{
    // version B2BHR1.00.00

    Caption = 'Attendance Lines';
    DrillDownPageID = "Attendance Lines List B2B";
    LookupPageID = "Attendance Lines List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Overtime,On Duty,Tour,Permission,Lop Adj,Comp Off';
            OptionMembers = Overtime,"On Duty",Tour,Permission,"Lop Adj","Comp Off";
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(4; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                InsertEmployee();
            end;
        }
        field(6; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(9; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(11; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                DailyAttendanceGRec: Record "Daily Attendance B2B";
            begin
                if AttHeader2.GET("Document Type", "Document No.") then begin
                    DailyAttendanceGRec.RESET();
                    DailyAttendanceGRec.SETRANGE("Employee No.", "Employee Code");
                    DailyAttendanceGRec.SETRANGE(Year, AttHeader2.Year);
                    DailyAttendanceGRec.SETRANGE(Month, AttHeader2.Month);
                    DailyAttendanceGRec.SETRANGE("Non-Working", true);
                    if PAGE.RUNMODAL(PAGE::"Daily Attendance List B2B", DailyAttendanceGRec) = ACTION::LookupOK then begin
                        "Start Date" := DailyAttendanceGRec.Date;
                        "Comp Off Date" := DailyAttendanceGRec.Date;
                        "Worked Shift" := DailyAttendanceGRec."Shift Code";
                        "Start Time" := DailyAttendanceGRec."Time In";
                        "End Time" := DailyAttendanceGRec."Time Out";
                        "C Off Hours" := DailyAttendanceGRec."Hours Worked"
                    end;
                end;
            end;
        }
        field(12; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(15; "Worked Shift"; Code[20])
        {
            Caption = 'Worked Shift';
            Editable = false;
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CLEAR(LocationCode);
                EmployeeGRec.GET("Employee Code");
                LocationCode := EmployeeGRec."Location Code";
                ShiftRec.GET("Worked Shift", LocationCode);
                if "Start Time" = 000000T then
                    "Start Time" := ShiftRec."Starting Time";

                if "End Time" = 000000T then
                    "End Time" := ShiftRec."Ending Time"
            end;
        }
        field(17; "Comp Off Date"; Date)
        {
            Caption = 'Comp Off Date';
            DataClassification = CustomerContent;
        }
        field(19; "Start Time"; Time)
        {
            Caption = 'Start Time';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckValidations();
            end;
        }
        field(22; "End Time"; Time)
        {
            Caption = 'End Time';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckValidations();
            end;
        }
        field(23; "C Off Hours"; Decimal)
        {
            Caption = 'C Off Hours';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(24; "Duration Not on Work"; Decimal)
        {
            Caption = 'Duration Not on Work';
            DataClassification = CustomerContent;
        }
        field(25; "Applied Hours"; Decimal)
        {
            Caption = 'Applied Hours';
            DataClassification = CustomerContent;
        }
        field(28; "Approved Hours"; Decimal)
        {
            Caption = 'Approved Hours';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Approved Hours" > "Applied Hours" then
                    ERROR(Text003Lbl);
            end;
        }
        field(30; "Permission Type"; Option)
        {
            Caption = 'Permission Type';
            OptionCaption = ' ,Late Coming,Early Going';
            OptionMembers = " ","Late Coming","Early Going";
            DataClassification = CustomerContent;
        }
        field(32; "LOP Period"; Option)
        {
            Caption = 'LOP Period';
            OptionCaption = ' ,Half Day,Full Day';
            OptionMembers = " ","Half Day","Full Day";
            DataClassification = CustomerContent;

        }
        field(34; "LOP Adj."; Decimal)
        {
            Caption = 'LOP Adj.';
            DataClassification = CustomerContent;
        }
        field(35; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(36; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(40; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Pending,Approved,Rejected';
            OptionMembers = " ",Pending,Approved,Rejected;
            DataClassification = CustomerContent;
        }
        field(47; "Leave Type"; Option)
        {
            Caption = 'Leave Type';
            OptionCaption = ' ,Casual,Sick,Earned,Manual Attendance';
            OptionMembers = " ",Casual,Sick,Earned,"Manual Attendance";
            DataClassification = CustomerContent;
        }
        field(51; "Total OT Hours"; Decimal)
        {
            CalcFormula = Sum ("Attendance Lines B2B"."Applied Hours" WHERE("Document Type" = CONST(Overtime),
                                                                        Month = FIELD(Month),
                                                                        Year = FIELD(Year),
                                                                        "Employee Code" = FIELD("Employee Code")));
            Caption = 'Total OT Hours';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Employee Code", "Start Date")
        {
        }
        key(Key2; "Document Type", "Employee Code", Month, Year, Status)
        {
            SumIndexFields = "LOP Adj.", "Applied Hours";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if AttHeader2.GET("Document Type", "Document No.") then begin
            Month := AttHeader2.Month;
            Year := AttHeader2.Year;
        end;
        AttLinesGRec.SETRANGE("Employee Code", "Employee Code");
        AttLinesGRec.SETRANGE("Start Date", "Start Date");
        if AttLinesGRec.FINDFIRST() then
            ERROR(Text000Lbl, "Employee Code", "Start Date");
    end;

    var
        AttHeader: Record "Attendance Header B2B";
        AttHeader2: Record "Attendance Header B2B";
        ShiftRec: Record "Shift Master B2B";
        EmployeeGRec: Record "Employee B2B";
        AttLinesGRec: Record "Attendance Lines B2B";
        LocationCode: Code[20];
        Text000Lbl: Label 'C OFF Is already Approved to %1 For the Date %2', Comment = '%1 = Employe Code ; %2 = StartDate';
        EmpCode: Code[20];
        NameTxt: Text[50];
        Text002Lbl: Label 'Already Employee No : %1 exists in the Reference No : %2', Comment = '%1 = Emp No ; %2 = Ref No';
        Text003Lbl: Label 'OT Approved Hours cannot be greater than OT Hours';

    procedure CheckValidations();
    begin
    end;

    procedure InsertEmployee();
    var
        Employee: Record "Employee B2B";
        AttLines: Record "Attendance Lines B2B";
        DailyAttendance: Record "Daily Attendance B2B";
    begin
        AttHeader.RESET();
        AttHeader.SETRANGE("Document Type", "Document Type");
        AttHeader.SETRANGE("No.", "Document No.");
        if AttHeader.FINDFIRST() then begin
            if AttHeader."Document Type" <> AttHeader."Document Type"::"Comp Off" then
                AttHeader.TESTFIELD("Start Date");
            Employee.RESET();
            if AttHeader.Type = AttHeader.Type::Employee then begin
                AttHeader.TESTFIELD(Code);
                Employee.SETRANGE("No.", AttHeader.Code);
            end;

            if AttHeader.Type = AttHeader.Type::Department then begin
                AttHeader.TESTFIELD(Code);
                Employee.SETRANGE("Department Code", AttHeader.Code);
            end;

            if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then
                if not AttLines.GET("Document Type", "Document No.", Employee."No.") then begin
                    "Employee Code" := Employee."No.";
                    "Employee Name" := CopyStr(Employee.Initials + Employee."First Name", 1, 50);
                    DailyAttendance.RESET();
                    DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                    DailyAttendance.SETRANGE(Date, AttHeader."Start Date");
                    if DailyAttendance.FINDFIRST() then begin
                        "Start Date" := DailyAttendance.Date;
                        "End Date" := DailyAttendance.Date;
                        VALIDATE("Worked Shift", DailyAttendance."Shift Code");
                        case "Permission Type" of
                            "Permission Type"::"Late Coming":
                                if DailyAttendance."Late Hrs" > 0 then
                                    "Applied Hours" := DailyAttendance."Late Hrs"
                                else
                                    CLEAR("Applied Hours");
                            "Permission Type"::"Early Going":
                                if DailyAttendance."Early Going Hrs" > 0 then
                                    "Applied Hours" := DailyAttendance."Early Going Hrs"
                                else
                                    CLEAR(AttLines."Applied Hours");
                        end;
                    end;
                end else
                    ERROR(Text002Lbl, Employee."No.", "Document No.");

        end;
    end;

    procedure InsertEmployeeOnDuty();
    var
        AttLines: Record "Attendance Lines B2B";
        AttLines2: Record "Attendance Lines B2B";
        BaseCalender: Record Date;
        Employee: Record "Employee B2B";
        ShiftMaster: Record "Shift Master B2B";
        StartTime: Time;
        EndTime: Time;

    begin
        if AttHeader.GET("Document Type", "Document No.") then begin
            TESTFIELD("Employee Code");
            if Employee.GET("Employee Code") then;

            if ShiftMaster.GET(AttHeader."Shift Code", Employee."Location Code") then begin
                StartTime := ShiftMaster."Starting Time";
                EndTime := ShiftMaster."Ending Time";
            end;

            BaseCalender.RESET();
            BaseCalender.SETRANGE("Period Start", AttHeader."Start Date", AttHeader."End Date");
            if BaseCalender.FINDFIRST() then
                repeat
                    AttLines2.RESET();
                    AttLines2.SETRANGE("Document Type", "Document Type");
                    AttLines2.SETRANGE("Document No.", "Document No.");
                    AttLines2.SETRANGE("Employee Code", "Employee Code");
                    AttLines2.SETRANGE("Start Date", BaseCalender."Period Start");
                    if AttLines2.IsEmpty() then begin
                        AttLines.init();
                        AttLines."Document Type" := "Document Type";
                        AttLines."Document No." := "Document No.";
                        AttLines."Employee Code" := "Employee Code";
                        AttLines."Employee Name" := CopyStr(Employee.Initials + Employee."First Name", 1, 50);
                        AttLines."Start Date" := BaseCalender."Period Start";
                        AttLines."End Date" := BaseCalender."Period Start";
                        AttLines.VALIDATE("Worked Shift", AttHeader."Shift Code");
                        AttLines.INSERT();
                    end;
                until BaseCalender.NEXT() = 0;

        end;
    end;

    procedure InsertEmployeeOnDuty1();
    var
        AttLines: Record "Attendance Lines B2B";
        AttLines2: Record "Attendance Lines B2B";
        BaseCalender: Record Date;
        Employee: Record "Employee B2B";
        ShiftMaster: Record "Shift Master B2B";
        StartTime: Time;
        EndTime: Time;
    begin

        if AttHeader.GET("Document Type", "Document No.") then begin
            AttHeader.TESTFIELD(Code);
            EmpCode := AttHeader.Code;
            if Employee.GET(AttHeader.Code) then
                NameTxt := CopyStr(Employee."First Name" + Employee."Last Name", 1, 50);

            AttHeader.RESET();
            AttHeader.SETRANGE("No.", "Document No.");
            if AttHeader.FINDFIRST() then begin
                ShiftMaster.RESET();
                ShiftMaster.SETRANGE("Shift Code", AttHeader."Shift Code");
                if ShiftMaster.FINDFIRST() then begin
                    StartTime := ShiftMaster."Starting Time";
                    EndTime := ShiftMaster."Ending Time";
                end;
            end;
            BaseCalender.RESET();
            BaseCalender.SETRANGE("Period Start", AttHeader."Start Date", AttHeader."End Date");
            if BaseCalender.FINDFIRST() then
                repeat
                    AttLines2.RESET();
                    AttLines2.SETRANGE("Document Type", AttHeader."Document Type");
                    AttLines2.SETRANGE("Document No.", AttHeader."No.");
                    AttLines2.SETRANGE("Employee Code", AttHeader.Code);
                    AttLines2.SETRANGE("Start Date", BaseCalender."Period Start");
                    if AttLines2.IsEmpty() then begin
                        AttLines.INIT();
                        AttLines."Document Type" := "Document Type";
                        AttLines."Document No." := "Document No.";
                        AttLines."Employee Code" := EmpCode;
                        AttLines."Employee Name" := CopyStr(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name", 1, 50);
                        AttLines."Start Date" := BaseCalender."Period Start";
                        AttLines."End Date" := BaseCalender."Period Start";
                        AttLines."Start Time" := StartTime;
                        AttLines."End Time" := EndTime;
                        AttLines.Month := DATE2DMY(BaseCalender."Period Start", 2);
                        AttLines.Year := DATE2DMY(BaseCalender."Period Start", 3);
                        AttLines.VALIDATE("Worked Shift", AttHeader."Shift Code");
                        AttLines.INSERT();
                    end;
                until BaseCalender.NEXT() = 0;
        end;
    end;

    procedure Teststatus();
    begin
        AttHeader.SETRANGE("No.", "Document No.");
        if AttHeader.FINDFIRST() then
            AttHeader.TESTFIELD(Status, AttHeader.Status::Open);
    end;
}

