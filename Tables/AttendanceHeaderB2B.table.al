table 33001366 "Attendance Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Attendance Header';
    DataCaptionFields = "No.";
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
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Document Type" <> xRec."Document Type" then begin
                    HRSetup.GET();
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                    "No. Series" := '';
                end;
            end;
        }
        field(3; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(5; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(8; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(9; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                if ("End Date" < "Start Date") then
                    ERROR(Text0001Lbl);
            end;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(13; "Physical Location"; Code[20])
        {
            Caption = 'Physical Location';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(23));
            DataClassification = CustomerContent;
        }
        field(14; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Department';
            OptionMembers = Employee,Department;
            DataClassification = CustomerContent;
        }
        field(16; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(Employee)) "Employee B2B"."No."
            ELSE
            IF (Type = CONST(Department)) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
        }
        field(18; "Shift Code"; Code[20])
        {
            Caption = 'Shift Code';
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;
        }
        field(20; "Permission Type"; Option)
        {
            Caption = 'Permission Type';
            OptionCaption = ' ,Late Coming,Early Going';
            OptionMembers = " ","Late Coming","Early Going";
            DataClassification = CustomerContent;
        }
        field(35; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(36; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(40; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(41; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending for Approval HOD,Pending for Additional Approval,Pending for HR Approval,Approved';
            OptionMembers = Open,"Pending for Approval HOD","Pending for Additional Approval","Pending for HR Approval",Approved;
            DataClassification = CustomerContent;
        }
        field(42; "To Location"; Code[20])
        {
            Caption = 'To Location';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(23));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(43; "Advance Request"; Decimal)
        {
            Caption = 'Advance Request';
            DataClassification = CustomerContent;
        }
        field(44; "Mode Of Travel"; Option)
        {
            Caption = 'Mode Of Travel';
            OptionCaption = ' ,By Road,By Rail,By Air';
            OptionMembers = " ","By Road","By Rail","By Air";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(45; "Mode of Booking"; Text[100])
        {
            Caption = 'Mode of Booking';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(46; "Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';
            DataClassification = CustomerContent;
        }
        field(47; "Assignment Name"; Text[50])
        {
            Caption = 'Assignment Name';
            DataClassification = CustomerContent;
        }
        field(48; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(49; "Places To Visit"; Text[250])
        {
            Caption = 'Places To Visit';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(50; Approver; Code[50])
        {
            Caption = 'Approver';
            DataClassification = CustomerContent;
        }
        field(51; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(52; "Employee Name"; Text[80])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(53; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(54; "Get Dates"; Boolean)
        {
            Caption = 'Get Dates';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        AttLines.RESET();
        AttLines.SETRANGE("Document Type", "Document Type");
        AttLines.SETRANGE("Document No.", "No.");
        AttLines.DELETEALL();
    end;

    trigger OnInsert();
    begin
        HRSetup.GET();
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "No.", "No. Series");
            "Creation Date" := WORKDATE();
            Month := HRSetup."Salary Processing month";
            Year := HRSetup."Salary Processing Year";
            "User ID" := CopyStr(USERID(), 1, 50);
            "Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();
        end;
    end;

    var
        HRSetup: Record "HR Setup B2B";
        AttLines: Record "Attendance Lines B2B";
        NoSeriesMgt: Codeunit 396;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text0001Lbl: Label 'End date shouldnot be leessthan the Start date.';
        Text0002Lbl: Label 'No entries exist against the Document No : %1', Comment = '%1 = Doc No';

    local procedure TestNoSeries(): Boolean;
    begin
        case "Document Type" of
            "Document Type"::Overtime:
                HRSetup.TESTFIELD("Over Time Nos.");
            "Document Type"::"On Duty":
                HRSetup.TESTFIELD("On Duty Nos.");
            "Document Type"::Tour:
                HRSetup.TESTFIELD("Tour intimation Nos.");
            "Document Type"::Permission:
                HRSetup.TESTFIELD("Permission Nos.");
            "Document Type"::"Lop Adj":
                HRSetup.TESTFIELD("LOP Adj. Nos.");
            "Document Type"::"Comp Off":
                HRSetup.TESTFIELD("Comp Off Nos.");
        end;
    end;

    local procedure GetNoSeriesCode(): Code[20];
    begin
        case "Document Type" of
            "Document Type"::Overtime:
                exit(HRSetup."Over Time Nos.");
            "Document Type"::"On Duty":
                exit(HRSetup."On Duty Nos.");
            "Document Type"::Tour:
                exit(HRSetup."Tour intimation Nos.");
            "Document Type"::Permission:
                exit(HRSetup."Permission Nos.");
            "Document Type"::"Lop Adj":
                exit(HRSetup."LOP Adj. Nos.");
            "Document Type"::"Comp Off":
                exit(HRSetup."Comp Off Nos.");
        end;
    end;

    procedure AssistEdit(OldAttHeader: Record "Attendance Header B2B"): Boolean;
    var

    begin
        HRSetup.get();
        TestNoSeries();
        if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldAttHeader."No. Series", "No. Series") then begin
            HRSetup.get();
            TestNoSeries();
            NoSeriesMgt.SetSeries("No.");
            "Creation Date" := workdate();
            Month := HRSetup."Salary Processing month";
            Year := HRSetup."Salary Processing Year";
            evaluate("User ID", USERID());
            exit(true);
        end;
    end;

    procedure InsertOvertimeDetails();
    var
        DailyAttendance: Record "Daily Attendance B2B";
        AttendanceLines: Record "Attendance Lines B2B";
    begin
        DailyAttendance.RESET();
        DailyAttendance.SETRANGE(Year, Year);
        DailyAttendance.SETRANGE(Month, Month);
        DailyAttendance.SETFILTER(Date, '%1..%2', "Start Date", "End Date");
        DailyAttendance.SETRANGE("Non-Working", false);
        if DailyAttendance.findfirst() then
            repeat
                AttendanceLines.init();
                AttendanceLines."Document Type" := "Document Type";
                AttendanceLines."Document No." := "No.";
            until DailyAttendance.NEXT() = 0;

    end;

    procedure InsertOTEmployees();
    var
        Employee: Record "Employee B2B";
        AttHeader: Record "Attendance Header B2B";
        DailyAttendance: Record "Daily Attendance B2B";
    begin
        AttHeader.RESET();
        AttHeader.SETRANGE("Document Type", "Document Type");
        AttHeader.SETRANGE("No.", "No.");
        if AttHeader.findfirst() then begin
            AttHeader.TESTFIELD("Start Date");
            Employee.RESET();
            if AttHeader."Global Dimension 1 Code" <> '' then
                Employee.SETRANGE("Global Dimension 1 Code", AttHeader."Global Dimension 1 Code");
            if AttHeader.Type = AttHeader.Type::Department then begin
                AttHeader.TESTFIELD(Code);
                Employee.SETRANGE("Department Code", AttHeader.Code);
            end;
            if Employee.findfirst() then
                repeat
                    AttLines.init();
                    AttLines."Document Type" := "Document Type";
                    AttLines."Document No." := "No.";
                    AttLines."Employee Code" := Employee."No.";
                    AttLines."Employee Name" := copystr(Employee.Initials + Employee."First Name", 1, 50);
                    AttLines."Start Date" := AttHeader."Start Date";
                    AttLines."End Date" := AttHeader."Start Date";
                    AttLines."Permission Type" := "Permission Type";
                    DailyAttendance.RESET();
                    DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                    DailyAttendance.SETRANGE(Date, AttHeader."Start Date");
                    DailyAttendance.SETFILTER("Hours Worked", '<>%1', 0);
                    if DailyAttendance.findfirst() then begin
                        AttLines.VALIDATE("Worked Shift", DailyAttendance."Revised Shift");
                        AttLines."Applied Hours" := DailyAttendance."Hours Worked" - DailyAttendance."Actual Hrs";
                    end else begin
                        AttLines.VALIDATE("Worked Shift", DailyAttendance."Revised Shift");
                        AttLines."Applied Hours" := ((AttLines."End Time" - AttLines."Start Time") / 3600000) - DailyAttendance."Actual Hrs";
                    end;
                    AttLines.INSERT();
                until Employee.NEXT() = 0;

        end;
    end;

    procedure InsertPermissionEmployees();
    var
        Employee: Record "Employee B2B";
        AttHeader: Record "Attendance Header B2B";
        DailyAttendance: Record "Daily Attendance B2B";
    begin
        AttHeader.RESET();
        AttHeader.SETRANGE("Document Type", "Document Type");
        AttHeader.SETRANGE("No.", "No.");
        if AttHeader.findfirst() then begin
            AttHeader.TESTFIELD("Start Date");
            Employee.RESET();
            if AttHeader."Global Dimension 1 Code" <> '' then
                Employee.SETRANGE("Global Dimension 1 Code", AttHeader."Global Dimension 1 Code");
            if AttHeader.Type = AttHeader.Type::Department then begin
                AttHeader.TESTFIELD(Code);
                Employee.SETRANGE("Department Code", AttHeader.Code);
            end;
            if AttHeader.Type = AttHeader.Type::Employee then begin
                AttHeader.TESTFIELD(Code);
                Employee.SETRANGE("No.", AttHeader.Code);
            end;
            if Employee.findfirst() then
                repeat
                    AttLines.init();
                    AttLines."Document Type" := "Document Type";
                    AttLines."Document No." := "No.";
                    AttLines."Employee Code" := Employee."No.";
                    AttLines."Employee Name" := copystr(Employee.Initials + Employee."First Name", 1, 50);
                    AttLines."Start Date" := AttHeader."Start Date";
                    AttLines."End Date" := AttHeader."Start Date";
                    AttLines."Permission Type" := "Permission Type";
                    AttLines.Month := Month;
                    AttLines.Year := Year;
                    DailyAttendance.RESET();
                    DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                    DailyAttendance.SETRANGE(Date, AttHeader."Start Date");
                    DailyAttendance.SETFILTER("Hours Worked", '<>%1', 0);
                    DailyAttendance.SETFILTER("Shift Code", '<>%1', '');
                    if DailyAttendance.findfirst() then begin
                        AttLines.VALIDATE("Worked Shift", DailyAttendance."Shift Code");
                        //B2BSRA230227 >>
                        AttLines."Start Time" := DailyAttendance."Actual Time In";
                        AttLines."End Time" := DailyAttendance."Actual Time Out";
                        //B2BSRA230227 <<
                        case AttLines."Permission Type" of
                            AttLines."Permission Type"::"Late Coming":

                                if DailyAttendance."Time In" > DailyAttendance."Actual Time In" then
                                    AttLines."Applied Hours" := DailyAttendance."Late Hrs"
                                else
                                    CLEAR(AttLines."Applied Hours");

                            AttLines."Permission Type"::"Early Going":

                                if DailyAttendance."Time Out" < DailyAttendance."Actual Time Out" then
                                    AttLines."Applied Hours" := DailyAttendance."Early Going Hrs"
                                else
                                    CLEAR(AttLines."Applied Hours");

                        end;
                        AttLines.INSERT();
                    end;
                until Employee.NEXT() = 0;

        end;
    end;

    procedure CheckValidEntries();
    var
        AttendanceLines: Record "Attendance Lines B2B";
        RowCount: Integer;
    begin
        CLEAR(RowCount);
        AttendanceLines.RESET();
        AttendanceLines.SETRANGE("Document Type", "Document Type");
        AttendanceLines.SETRANGE("Document No.", "No.");
        AttendanceLines.SETFILTER("Employee Code", '<>%1', '');
        AttendanceLines.SETFILTER(Month, '<>%1', 0);
        AttendanceLines.SETFILTER(Year, '<>%1', 0);
        RowCount := AttendanceLines.COUNT();
        if RowCount = 0 then
            ERROR(Text0002Lbl, "No.");
    end;
}

