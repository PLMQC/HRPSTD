table 33001271 "Employee Seperation B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Seperation';
    LookupPageID = "Employee Seperation List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Seperation ID"; Code[20])
        {
            Caption = 'Seperation ID';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(3; "Employee ID"; Code[20])
        {
            Caption = 'Employee ID';
            TableRelation = "Employee B2B" WHERE(Blocked = CONST(false),
                                                Resigned = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                Employee.RESET();
                Employee.SETRANGE("No.", "Employee ID");
                if Employee.FINDFIRST() then
                    "Employee Name" := Employee."First Name";

            end;
        }
        field(5; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(7; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                CheckForEmployeeNo();
            end;
        }
        field(9; "Seperation Type"; Option)
        {
            Caption = 'Seperation Type';
            OptionCaption = 'Termination,Retirement,Resignation';
            OptionMembers = Termination,Retirement,Resignation;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                if "Seperation Type" = "Seperation Type"::Termination then
                    "Question ID" := '';
            end;
        }
        field(10; "Cause of Inactivity"; Code[20])
        {
            Caption = 'Cause of Inactivity';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('CAUSES OF INACTIVITY'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(11; "Grouds of Termination Group"; Code[30])
        {
            Caption = 'Grouds of Termination Group';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('GROUNDS OF TERMINATION'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(16; "Question ID"; Code[20])
        {
            Caption = 'Question ID';
            TableRelation = "Questionnaire Header B2B" WHERE("Questionnaire Type" = CONST("Exit Interview"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                CheckForEmployeeNo();
                if "Question ID" <> xRec."Question ID" then
                    if SeperationLineExists() then
                        ERROR(Text0010Lbl, FIELDCAPTION("Question ID"));

            end;
        }
        field(25; "Seperation Status"; Option)
        {
            Caption = 'Seperation Status';
            OptionCaption = ' ,Posted';
            OptionMembers = " ",Posted;
            DataClassification = CustomerContent;
        }
        field(36; "Last Working Date"; Date)
        {
            Caption = 'Last Working Date';
            DataClassification = CustomerContent;



        }
        field(38; "Notice Period Last Date"; Date)
        {
            Editable = false;
            Caption = 'Notice Period Last Date';
            DataClassification = CustomerContent;
        }
        //CHB2B15SEP2022<<
        field(50001; "Exit ReasonCode For Pf"; code[30])
        {
            Caption = 'Exit Reasoncode For Pf';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('EXIT REASONCODE FOR PF'));
            DataClassification = CustomerContent;
        }
        //CHB2B15SEP2022>>*/
        //CHB2BJAN52023<<
        field(50002; "Exit ReasonCode For ESI"; code[30])
        {
            Caption = 'Exit ReasonCode For ESI';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = const('EXIT REASONCODE FOR ESI'));
            DataClassification = CustomerContent;
        }
        //CHB2BJAN52023>>
    }

    keys
    {
        key(Key1; "Seperation ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        EmpSepLineGRec.RESET();
        EmpSepLineGRec.SETRANGE("Seperation ID", "Seperation ID");
        EmpSepLineGRec.DELETEALL();
    end;

    trigger OnInsert();
    begin
        if "Seperation ID" = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD("Seperation Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Seperation Nos.", xRec."No. Series", 0D, "Seperation ID", "No. Series");
        end;
    end;

    trigger OnModify();
    begin
        if DocumentPosted() then
            ERROR(Text0001Lbl, "Seperation ID");
    end;

    var

        HRSetup: Record "HR Setup B2B";
        ProvLeaveGRec: Record "Provisional Leaves B2B";
        EmpSepLineGRec: Record "Employee Separation Line B2B";
        EmpSepHeadGRec: Record "Employee Seperation B2B";
        Employee: Record "Employee B2B";
        NoSeriesMgt: Codeunit 396;
        Text0001Lbl: Label 'Document %1 has been already posted.', Comment = '%1 = Seperation Id';
        Text0002Lbl: Label 'Do you want to release the document?';
        Text0003Lbl: Label 'Do you want to reopen the document?';
        Text0005Lbl: Label 'Do you want to terminate the employee?';
        Text0006Lbl: Label '"Seperation type cannot be %1. "', Comment = '%1 = ';
        Text0007Lbl: Label 'Do you want to proceed?';
        Text0008Lbl: Label 'Do you want to conduct an exit interview?';
        Text0009Lbl: Label 'Seperation lines already exists. Do you want to delete and recreate the lines?';
        Text0010Lbl: Label 'You cannot change %1. Seperation Lines already exists.', Comment = '%1 = Question Id';
        Text0011Lbl: Label 'Employee terminated sucessfully.';
        Text0012Lbl: Label 'Details updated successfully.';
        Text0013Lbl: Label 'Seperation lines updated sucessfully.';
        CMExprLbl: Label '<CM>';

    procedure AssistEdit(OldEmpSep: Record "Employee Seperation B2B"): Boolean;
    var
        EmployeeSep: Record "Employee Seperation B2B";
    begin
        with EmployeeSep do begin
            EmployeeSep := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD("Seperation Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Seperation Nos.", OldEmpSep."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Seperation Nos.");
                NoSeriesMgt.SetSeries("Seperation ID");
                Rec := EmployeeSep;
                exit(true);
            end;
        end;
    end;

    procedure SeperationLineExists(): Boolean;
    var
    begin
        EmpSepLineGRec.RESET();
        EmpSepLineGRec.SETRANGE("Seperation ID", "Seperation ID");
        if EmpSepLineGRec.FINDFIRST() then
            exit(true)
        else
            exit(false);
    end;

    procedure CheckForEmployeeNo();
    begin
        TESTFIELD("Employee ID");
    end;

    procedure ClearValues();
    begin
        if ("Seperation Type" = "Seperation Type"::Retirement) or ("Seperation Type" = "Seperation Type"::Resignation) then
            "Grouds of Termination Group" := ''
        else
            if ("Seperation Type" = "Seperation Type"::Termination) then begin
                VALIDATE("Cause of Inactivity", '');
                VALIDATE("Question ID", '');
            end;
    end;

    procedure Release(EmployeeSeperationLRec: Record "Employee Seperation B2B");
    begin

        EmployeeSeperationLRec.TESTFIELD(Status, EmployeeSeperationLRec.Status::Open);
        if not CONFIRM(Text0002Lbl) then
            exit;
        /*
        if EmployeeSeperationLRec."Seperation Type" <> EmployeeSeperationLRec."Seperation Type"::Termination then
            if not SeperationLineExists then
                ERROR(Text0004);
         */
        EmpSepHeadGRec.GET(EmployeeSeperationLRec."Seperation ID");
        EmpSepHeadGRec.Status := EmpSepHeadGRec.Status::Released;
        EmpSepHeadGRec."Cause of Inactivity" := EmployeeSeperationLRec."Cause of Inactivity";
        EmpSepHeadGRec.MODIFY();
    end;

    procedure Reopen();
    begin
        if DocumentPosted() then
            ERROR(Text0001Lbl, "Seperation ID");

        TESTFIELD(Status, Status::Released);
        if not CONFIRM(Text0003Lbl) then
            exit;
        EmpSepHeadGRec.GET("Seperation ID");
        EmpSepHeadGRec.Status := EmpSepHeadGRec.Status::Open;
        EmpSepHeadGRec.MODIFY();
    end;

    procedure TerminateEmployee();
    begin
        if DocumentPosted() then
            ERROR(Text0001Lbl, "Seperation ID");

        TESTFIELD(Status, Status::Released);
        TESTFIELD("Employee ID");
        TESTFIELD("Effective Date");
        TESTFIELD("Grouds of Termination Group");
        TESTFIELD("Seperation Type", "Seperation Type"::Termination);
        if not CONFIRM(Text0005Lbl, false) then
            exit;

        Employee.RESET();
        Employee.SETRANGE("No.", "Employee ID");
        if Employee.FINDFIRST() then begin
            Employee.Status := Employee.Status::Terminated;
            Employee."Termination Date" := "Effective Date";
            Employee."Grounds for Term. Code" := "Grouds of Termination Group";
            Employee.Blocked := true;
            Employee."Blocked Date" := "Effective Date";
            //CHB2B21OCT2022<<
            Employee."Exit ReasonCode For Pf" := "Exit ReasonCode For Pf";
            //CHB2B21OCT2022>>
            //CHB2BJAN52023<<
            Employee."Exit ReasonCode For ESI" := "Exit ReasonCode For ESI";
            //CHB2BJAN52023>>
            Employee.MODIFY();
            DeleteDailyAttendance();
            EmpSepHeadGRec.GET("Seperation ID");
            EmpSepHeadGRec."Seperation Status" := EmpSepHeadGRec."Seperation Status"::Posted;
            EmpSepHeadGRec.MODIFY();
            MESSAGE(Text0011Lbl);
        end;
    end;

    procedure DeleteDailyAttendance();
    var
        DailyAttendance: Record "Daily Attendance B2B";
        MonthlyAtt: Record "Monthly Attendance B2B";
        Currmonth: Integer;
        CurrYear: Integer;
        LastDate: Date;

    begin
        Currmonth := DATE2DMY("Effective Date", 2);
        CurrYear := DATE2DMY("Effective Date", 3);

        LastDate := CALCDATE(CMExprLbl, "Effective Date");

        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", "Employee ID");
        DailyAttendance.SETRANGE(Month, Currmonth);
        DailyAttendance.SETRANGE(Year, CurrYear);
        DailyAttendance.SETFILTER(Date, '%1..%2', "Effective Date", LastDate);
        if DailyAttendance.FINDSET() then
            repeat
                DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Absent;
                DailyAttendance.Absent := 1;
                DailyAttendance.MODIFY();
            until DailyAttendance.NEXT() = 0;

        ProvLeaveGRec.RESET();
        ProvLeaveGRec.SETRANGE(ProvLeaveGRec."Employee No.", "Employee ID");
        ProvLeaveGRec.SETFILTER(ProvLeaveGRec.Month, '>=%1', Currmonth);
        ProvLeaveGRec.SETRANGE(Year, CurrYear);
        if ProvLeaveGRec.FINDSET() then
            repeat
                ProvLeaveGRec.Status := ProvLeaveGRec.Status::Closed;
                ProvLeaveGRec.MODIFY();
            until ProvLeaveGRec.NEXT() = 0;

        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", "Employee ID");
        DailyAttendance.SETFILTER(Date, '>%1', LastDate);
        DailyAttendance.DELETEALL();

        if Currmonth = 12 then begin
            Currmonth := 1;
            CurrYear := CurrYear + 1;
        end else
            Currmonth += 1;


        MonthlyAtt.RESET();
        MonthlyAtt.SETRANGE("Employee Code", "Employee ID");
        MonthlyAtt.SETFILTER("Pay Slip Month", '>=%1', Currmonth);
        MonthlyAtt.SETRANGE(Year, CurrYear);
        if MonthlyAtt.FINDSET() then
            repeat
                MonthlyAtt.Blocked := true;
                MonthlyAtt.MODIFY();
            until MonthlyAtt.NEXT() = 0;
    end;

    procedure UpdateRetirementandResignation();
    var
    begin
        hrsetup.GET();
        if DocumentPosted() then
            ERROR(Text0001Lbl, "Seperation ID");

        TESTFIELD(Status, Status::Released);
        if "Seperation Type" = "Seperation Type"::Termination then
            ERROR(Text0006Lbl, FORMAT("Seperation Type"));
        TESTFIELD("Employee ID");
        TESTFIELD("Effective Date");
        TESTFIELD("Cause of Inactivity");
        HRSetup.testfield("Notice Period");

        if not CONFIRM(Text0007Lbl, false) then
            exit;

        Employee.RESET();
        Employee.SETRANGE("No.", "Employee ID");
        if Employee.FINDFIRST() then begin
            Employee."Inactive Date" := "Effective Date";
            if "Seperation Type" = "Seperation Type"::Retirement then
                Employee."Retirement Date" := "Effective Date"
            else
                if "Seperation Type" = "Seperation Type"::Resignation then
                    Employee."Resignation Date" := "Effective Date";
            Employee.Resigned := true;
            Employee."Cause of Inactivity Code" := "Cause of Inactivity";
            Employee."notice period last date" := CalcDate(HRSetup."Notice Period", "Effective Date");
            Employee.MODIFY();

            EmpSepHeadGRec.GET("Seperation ID");
            EmpSepHeadGRec."Notice Period Last Date" := CalcDate(HRSetup."Notice Period", "Effective Date");
            EmpSepHeadGRec.MODIFY();
            MESSAGE(Text0012Lbl);
        end;
    end;

    procedure ExitInterview();
    begin
        TESTFIELD(Status, Status::Open);
        TESTFIELD("Question ID");
        TESTFIELD("Employee ID");
        if "Seperation Type" = "Seperation Type"::Termination then
            ERROR(Text0006Lbl, FORMAT("Seperation Type"));

        if not CONFIRM(Text0008Lbl, false) then
            exit;

        EmpSepLineGRec.RESET();
        EmpSepLineGRec.SETRANGE("Seperation ID", "Seperation ID");
        if EmpSepLineGRec.FINDFIRST() then begin
            if not CONFIRM(Text0009Lbl, false) then
                exit;
            EmpSepLineGRec.RESET();
            EmpSepLineGRec.SETRANGE("Seperation ID", "Seperation ID");
            EmpSepLineGRec.DELETEALL();
            UpdateSeperationLines();
        end else begin
            UpdateSeperationLines();
            MESSAGE(Text0013Lbl);
        end;
    end;

    procedure UpdateSeperationLines();
    var
        QuestLineRec: Record "Questionnaire Line B2B";
        NextLineNum: Integer;
    begin
        EmpSepLineGRec.RESET();
        EmpSepLineGRec.SETRANGE("Seperation ID", "Seperation ID");
        if EmpSepLineGRec.FINDLAST() then
            NextLineNum := EmpSepLineGRec."Line No." + 10000
        else
            NextLineNum := 10000;

        QuestLineRec.RESET();
        QuestLineRec.SETRANGE("Profile Questionnaire Code", "Question ID");
        if QuestLineRec.FINDSET() then
            repeat
                EmpSepLineGRec.INIT();
                EmpSepLineGRec."Seperation ID" := "Seperation ID";
                EmpSepLineGRec."Employee ID" := "Employee ID";
                EmpSepLineGRec."Line No." := NextLineNum;
                EmpSepLineGRec.Type := QuestLineRec.Type;
                EmpSepLineGRec.Question := QuestLineRec.Description;
                EmpSepLineGRec."Multiple Answers" := QuestLineRec."Multiple Answers";
                EmpSepLineGRec.Set := QuestLineRec.Set;
                EmpSepLineGRec."Hierarchy No." := QuestLineRec."Heirarchy No.";
                EmpSepLineGRec.INSERT();
                NextLineNum += 10000;
            until QuestLineRec.NEXT() = 0;
    end;

    procedure DocumentPosted(): Boolean;
    begin
        if "Seperation Status" = "Seperation Status"::Posted then
            exit(true)
        else
            exit(false);
    end;

    procedure DeleteDailyAttendance2();
    var
        DailyAttendance: Record "Daily Attendance B2B";
        MonthlyAtt: Record "Monthly Attendance B2B";
        Currmonth: Integer;
        CurrYear: Integer;
        LastDate: Date;
        DateExpLbl: Label '<1D>';
    begin
        Currmonth := DATE2DMY("Last working Date", 2);
        CurrYear := DATE2DMY("Last working Date", 3);

        LastDate := CALCDATE(CMExprLbl, "Last working Date");

        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", "Employee ID");
        DailyAttendance.SETRANGE(Month, Currmonth);
        DailyAttendance.SETRANGE(Year, CurrYear);
        DailyAttendance.SETFILTER(Date, '%1..%2', CalcDate(DateExpLbl, "Last working Date"), LastDate);
        if DailyAttendance.FINDSET() then
            repeat
                DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Absent;
                DailyAttendance.Absent := 1;
                DailyAttendance.MODIFY();
            until DailyAttendance.NEXT() = 0;

        ProvLeaveGRec.RESET();
        ProvLeaveGRec.SETRANGE(ProvLeaveGRec."Employee No.", "Employee ID");
        ProvLeaveGRec.SETFILTER(ProvLeaveGRec.Month, '>=%1', Currmonth);
        ProvLeaveGRec.SETRANGE(Year, CurrYear);
        if ProvLeaveGRec.FINDSET() then
            repeat
                ProvLeaveGRec.Status := ProvLeaveGRec.Status::Closed;
                ProvLeaveGRec.MODIFY();
            until ProvLeaveGRec.NEXT() = 0;

        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", "Employee ID");
        DailyAttendance.SETFILTER(Date, '>%1', LastDate);
        DailyAttendance.DELETEALL();

        if Currmonth = 12 then begin
            Currmonth := 1;
            CurrYear := CurrYear + 1;
        end else
            Currmonth += 1;


        MonthlyAtt.RESET();
        MonthlyAtt.SETRANGE("Employee Code", "Employee ID");
        MonthlyAtt.SETFILTER("Pay Slip Month", '>=%1', Currmonth);
        MonthlyAtt.SETRANGE(Year, CurrYear);
        if MonthlyAtt.FINDSET() then
            repeat
                MonthlyAtt.Blocked := true;
                MonthlyAtt.MODIFY();
            until MonthlyAtt.NEXT() = 0;
    end;
}

