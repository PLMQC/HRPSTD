table 33001330 "Leave Encashment Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Encashment Header_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Encashment Code"; Code[20])
        {
            Caption = 'Encashment Code';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Encashment Code" <> xRec."Encashment Code" then begin
                    HRSetup.GET();
                    NoSeriesMgt.TestManual(HRSetup."Leave Encashment Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = IF (Type = FILTER(Employee)) "Employee B2B"
            WHERE(Blocked = FILTER(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                LELine.RESET();
                LELine.SETRANGE("Encashment Code", "Encashment Code");
                if LELine.FINDSET() then
                    repeat
                        LELine.DELETEALL();
                    until LELine.NEXT() = 0;

                if Type = Type::Employee then begin
                    LELineGRec.RESET();
                    LELineGRec.SETRANGE("Employee Code", "Employee Code");
                    if LELineGRec.FINDFIRST() then
                        ERROR(Text007Lbl, "Employee Code");
                end;

                if Employee.GET("Employee Code") then begin
                    "Employee Name" := Employee."First Name";
                    PayCadre := Employee."Pay Cadre";
                    "Leave Pay Cadre" := Employee."Leave Pay Cadre";
                end else begin
                    "Employee Name" := '';
                    PayCadre := '';
                    "Leave Pay Cadre" := '';
                end;

                if Type = Type::Employee then
                    GetAvailableLeaves();
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(4; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(5; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(6; PayCadre; Code[20])
        {
            Caption = 'PayCadre';
            TableRelation = IF (Type = FILTER(Grade)) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Grade,All';
            OptionMembers = Employee,Grade,All;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if xRec.Type <> Type then begin
                    LELine.RESET();
                    LELine.SETRANGE("Encashment Code", "Encashment Code");
                    if LELine.FINDFIRST() then
                        if CONFIRM(Text000Lbl, false, "Encashment Code") then
                            LELine.DELETEALL()
                        else
                            Rec.Type := xRec.Type;
                end;

                if Type = Type::All then
                    GetAvailableLeaves();
                if Type = Type::All then begin
                    PayCadre := '';
                    "Leave Pay Cadre" := '';
                    "Employee Code" := '';
                    "Employee Name" := '';
                end;
                if Type = Type::Employee then begin
                    PayCadre := '';
                    "Leave Pay Cadre" := '';
                end;
                if Type = Type::Grade then begin
                    "Employee Code" := '';
                    "Employee Name" := '';
                end;
            end;
        }
        field(32; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(33; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(34; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(35; "Product Posting Group"; Code[20])
        {
            Caption = 'Product Posting Group';
            TableRelation = "Payroll Prod. Post. Group B2B";
            DataClassification = CustomerContent;
        }
        field(36; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(37; Post; Boolean)
        {
            Caption = 'Post';
            DataClassification = CustomerContent;
        }
        field(38; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(39; "Leave Pay Cadre"; Code[50])
        {
            Caption = 'Leave Pay Cadre';
            TableRelation = IF (Type = FILTER(Grade)) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = FILTER('LEAVE PAY CADRE'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Type = Type::Grade then
                    GetAvailableLeaves();
            end;
        }
    }

    keys
    {
        key(Key1; "Encashment Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        LELine.RESET();
        LELine.SETRANGE("Encashment Code", "Encashment Code");
        if LELine.FINDFIRST() then
            LELine.DELETEALL();
    end;

    trigger OnInsert();
    begin
        if "Encashment Code" = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD("Leave Encashment Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Encashment Nos.", xRec."No. Series", 0D, "Encashment Code", "No. Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        LELine: Record "Leave Encashment Line B2B";
        LELineGRec: Record "Leave Encashment Line B2B";
        Employee_B2BGRec: Record "Employee B2B";
        PostLEHeader: Record "Posted Leave Encash Header B2B";
        PostLELine: Record "Posted Leave Encash Line B2B";
        NoSeriesMgt: Codeunit 396;

        VDAAmt: Decimal;
        Unit: Code[20];
        Text000Lbl: Label 'Leave Encashment lines exist for the encashment code %1, do you still want to change?', Comment = '%1 = ';
        Text001Lbl: Label 'Payroll product posting group is not defined for leave encashment.';
        Text002Lbl: Label 'Employee Posting group is not defined.';
        Text003Lbl: Label 'Leave encashment %1 posted successfully.', Comment = '%1 = Encashment Code';
        Text005Lbl: Label 'Do you want to post?';
        Text006Lbl: Label 'Encashment %1 already posted.', Comment = '%1 = Encashment Code';
        Text007Lbl: Label 'Un posted Encashments exits against %1', Comment = '%1 = Employee Code';
        MonthTextLbl: Label '<1M>';
        AfterBasicTextLbl: Label 'AFTER BASIC';
        BasicTextLbl: Label 'BASIC';
        AfterBasicAndDaTextLbl: Label 'AFTER BASIC AND DA';
        DATextLbl: Label 'DA';
        GenjnlTextLbl: Label 'GENJNL';

    procedure GetAvailableLeaves();
    var
        LeaveMaster: Record "Leave Master B2B";
        DetailedLeaves: Record "Detailed Leave Records B2B";
        TotalLeaves: Decimal;
        LineNum: Integer;
    begin
        TESTFIELD(Month);
        TESTFIELD(Year);
        if Type = Type::Employee then begin
            LeaveMaster.RESET();
            LeaveMaster.SETRANGE(Encashable, true);
            if LeaveMaster.FINDFIRST() then begin
                LineNum := 10000;
                repeat
                    TotalLeaves := 0;
                    DetailedLeaves.RESET();
                    DetailedLeaves.SETRANGE("Leave Code", LeaveMaster."Leave Code");
                    DetailedLeaves.SETRANGE("Employee No.", "Employee Code");
                    DetailedLeaves.SETFILTER(Year, '<=%1', Year);
                    if DetailedLeaves.FINDFIRST() then begin
                        repeat
                            if not ((DetailedLeaves.Year = Year) and (DetailedLeaves.Month > Month)) then
                                TotalLeaves += DetailedLeaves."No. of Leaves";
                        until DetailedLeaves.NEXT() = 0;
                        CLEAR(Unit);
                        Employee_B2BGRec.RESET();

                        Employee_B2BGRec.SETRANGE("No.", DetailedLeaves."Employee No.");
                        if Employee_B2BGRec.FINDFIRST() then
                            Unit := Employee_B2BGRec."Global Dimension 1 Code";
                        if (TotalLeaves <> 0) then begin
                            LELine.INIT();
                            LELine."Encashment Code" := "Encashment Code";
                            LELine."Line No." := LineNum;
                            LELine."Employee Code" := "Employee Code";
                            LELine."Employee Name" := "Employee Name";
                            LELine.Month := Month;
                            LELine.Year := Year;
                            LELine.PayCadre := PayCadre;
                            LELine."Leave Pay Cadre" := "Leave Pay Cadre";
                            LELine."Shortcut Dimension 1 Code" := Unit;
                            LELine."Leave Code" := LeaveMaster."Leave Code";
                            LELine.Type := Rec.Type;
                            LELine."Available Leaves" := (TotalLeaves - LeaveMaster."Min. Retaining Leaves");
                            if LELine."Available Leaves" > 0 then begin
                                LELine.INSERT();
                                LineNum := LineNum + 10000;
                            end;
                        end;
                    end;
                until LeaveMaster.NEXT() = 0;
            end;
        end;
        if Type = Type::Grade then begin
            LeaveMaster.RESET();
            LeaveMaster.SETRANGE(Encashable, true);
            if LeaveMaster.FINDFIRST() then begin
                LineNum := 10000;
                repeat
                    Employee.RESET();
                    Employee.SETRANGE(Blocked, false);
                    Employee.SETRANGE("Leave Pay Cadre", "Leave Pay Cadre");
                    if Employee.FINDFIRST() then
                        repeat
                            DetailedLeaves.RESET();
                            DetailedLeaves.SETRANGE("Employee No.", Employee."No.");
                            DetailedLeaves.SETRANGE("Leave Code", LeaveMaster."Leave Code");
                            DetailedLeaves.SETFILTER(Year, '<=%1', Year);
                            if DetailedLeaves.FINDFIRST() then begin
                                TotalLeaves := 0;
                                repeat
                                    if not ((DetailedLeaves.Year = Year) and (DetailedLeaves.Month = Month)) then
                                        TotalLeaves := TotalLeaves + DetailedLeaves."No. of Leaves";
                                until DetailedLeaves.NEXT() = 0;
                                CLEAR(Unit);
                                Employee_B2BGRec.RESET();
                                Employee_B2BGRec.SETRANGE("No.", DetailedLeaves."Employee No.");
                                if Employee_B2BGRec.FINDFIRST() then
                                    Unit := Employee_B2BGRec."Global Dimension 1 Code";

                                if (TotalLeaves <> 0) then begin
                                    LELine.INIT();
                                    LELine."Encashment Code" := "Encashment Code";
                                    LELine."Line No." := LineNum;
                                    LELine."Employee Code" := DetailedLeaves."Employee No.";
                                    if Employee.GET(LELine."Employee Code") then;
                                    LELine."Employee Name" := Employee."First Name";
                                    LELine.Month := Month;
                                    LELine.Year := Year;
                                    LELine.PayCadre := PayCadre;
                                    LELine.Type := Rec.Type;
                                    LELine."Leave Pay Cadre" := "Leave Pay Cadre";
                                    LELine."Leave Code" := LeaveMaster."Leave Code";
                                    LELine."Shortcut Dimension 1 Code" := Unit;
                                    LELine."Available Leaves" := (TotalLeaves - LeaveMaster."Min. Retaining Leaves");
                                    if LELine."Available Leaves" > 0 then begin
                                        LELineGRec.RESET();
                                        LELineGRec.SETRANGE("Employee Code", DetailedLeaves."Employee No.");
                                        if not LELineGRec.FINDFIRST() then
                                            LELine.INSERT();
                                        LineNum := LineNum + 10000;
                                    end;
                                end;
                            end;
                        until Employee.NEXT() = 0;
                until LeaveMaster.NEXT() = 0;
            end;
        end;
        if Type = Type::All then begin
            LeaveMaster.RESET();
            LeaveMaster.SETRANGE(Encashable, true);
            if LeaveMaster.FINDFIRST() then begin
                LineNum := 10000;
                repeat
                    Employee.RESET();
                    Employee.SETRANGE(Blocked, false);
                    if Employee.FINDFIRST() then
                        repeat
                            DetailedLeaves.RESET();
                            DetailedLeaves.SETRANGE("Employee No.", Employee."No.");
                            DetailedLeaves.SETRANGE("Leave Code", LeaveMaster."Leave Code");
                            DetailedLeaves.SETFILTER(Year, '<=%1', Year);
                            if DetailedLeaves.FINDFIRST() then begin
                                TotalLeaves := 0;
                                repeat
                                    if not ((DetailedLeaves.Year = Year) and (DetailedLeaves.Month > Month)) then
                                        TotalLeaves := TotalLeaves + DetailedLeaves."No. of Leaves";
                                until DetailedLeaves.NEXT() = 0;
                                CLEAR(Unit);
                                Employee_B2BGRec.RESET();
                                Employee_B2BGRec.SETRANGE("No.", DetailedLeaves."Employee No.");
                                if Employee_B2BGRec.FINDFIRST() then
                                    Unit := Employee_B2BGRec."Global Dimension 1 Code";

                                if (TotalLeaves <> 0) then begin
                                    LELine.INIT();
                                    LELine."Encashment Code" := "Encashment Code";
                                    LELine."Line No." := LineNum;
                                    LELine."Employee Code" := DetailedLeaves."Employee No.";
                                    if Employee.GET(LELine."Employee Code") then;
                                    LELine."Employee Name" := Employee."First Name";
                                    LELine.Month := Month;
                                    LELine.Year := Year;
                                    LELine.PayCadre := Employee."Pay Cadre";
                                    LELine."Leave Pay Cadre" := Employee."Leave Pay Cadre";
                                    LELine."Leave Code" := LeaveMaster."Leave Code";
                                    LELine.Type := Rec.Type;
                                    LELine."Shortcut Dimension 1 Code" := Unit;
                                    LELine."Available Leaves" := (TotalLeaves - LeaveMaster."Min. Retaining Leaves");
                                    if LELine."Available Leaves" > 0 then begin
                                        LELine.INSERT();
                                        LineNum := LineNum + 10000;
                                    end;
                                end;
                            end;
                        until Employee.NEXT() = 0;
                until LeaveMaster.NEXT() = 0;
            end;
        end;
    end;

    procedure UpdateAmount(var LEncahLine: Record "Leave Encashment Line B2B");
    var
        Payelements: Record "Pay Elements B2B";
        Payelements2: Record "Pay Elements B2B";
        Lookup_B2B: Record Lookup_B2B;
        EncashAmount: Decimal;
        MonthDays: Decimal;
        EncashDate: Date;
        BasicAmt: Decimal;
        DAAmt: Decimal;
    begin
        VDAAmt := 0;
        HRSetup.GET();
        EncashDate := DMY2DATE(1, Month, Year);
        MonthDays := (CALCDATE(MonthTextLbl, EncashDate)) - EncashDate;
        EncashAmount := 0;
        Lookup_B2B.RESET();
        Lookup_B2B.SETRANGE("Lookup Type", 16);
        Lookup_B2B.SETRANGE("Leave Encashment", true);
        if Lookup_B2B.FINDFIRST() then begin
            repeat
                Payelements.RESET();
                Payelements.SETCURRENTKEY("Effective Start Date");
                Payelements.SETRANGE("Employee Code", LEncahLine."Employee Code");
                Payelements.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                Payelements.SETFILTER("Effective Start Date", '<=%1', EncashDate);
                if Payelements.FINDLAST() then
                    if Payelements."Fixed/Percent" = Payelements."Fixed/Percent"::Percent then begin
                        if Payelements."Computation Type" = AfterBasicTextLbl then begin
                            Payelements2.RESET();
                            Payelements2.SETCURRENTKEY("Effective Start Date");
                            Payelements2.SETRANGE("Employee Code", LEncahLine."Employee Code");
                            Payelements2.SETRANGE("Pay Element Code", BasicTextLbl);
                            Payelements2.SETFILTER("Effective Start Date", '<=%1', EncashDate);
                            if Payelements2.FINDLAST() then
                                EncashAmount := EncashAmount + ((LEncahLine."Leaves To Encash" / MonthDays) *
                                           ((Payelements2."Amount / Percent" * Payelements."Amount / Percent") / 100));
                        end else
                            if Payelements."Computation Type" = AfterBasicAndDaTextLbl then begin
                                CLEAR(BasicAmt);
                                CLEAR(DAAmt);
                                Payelements2.RESET();
                                Payelements2.SETCURRENTKEY("Effective Start Date");
                                Payelements2.SETRANGE("Employee Code", LEncahLine."Employee Code");
                                Payelements2.SETRANGE("Pay Element Code", BasicTextLbl);
                                Payelements2.SETFILTER("Effective Start Date", '<=%1', EncashDate);
                                if Payelements2.FINDLAST() then
                                    BasicAmt := Payelements2."Amount / Percent";
                                Payelements2.RESET();
                                Payelements2.SETCURRENTKEY("Effective Start Date");
                                Payelements2.SETRANGE("Employee Code", LEncahLine."Employee Code");
                                Payelements2.SETRANGE("Pay Element Code", DATextLbl);
                                Payelements2.SETFILTER("Effective Start Date", '<=%1', EncashDate);
                                if Payelements2.FINDLAST() then
                                    if Payelements2."Fixed/Percent" = Payelements2."Fixed/Percent"::Percent then
                                        DAAmt := (BasicAmt * Payelements2."Amount / Percent") / 100
                                    else
                                        DAAmt := Payelements2."Amount / Percent";
                                EncashAmount := EncashAmount + ((LEncahLine."Leaves To Encash" / MonthDays) *
                                 ((BasicAmt + DAAmt) * Payelements."Amount / Percent" / 100));
                            end
                    end else
                        EncashAmount := EncashAmount + ((LEncahLine."Leaves To Encash" / MonthDays) * Payelements."Amount / Percent");

            until Lookup_B2B.NEXT() = 0;
            EncashAmount := EncashAmount + VDAAmt;
            if HRSetup."Rounding Type" = HRSetup."Rounding Type"::"To the nearest value" then
                LEncahLine."Encash Amount" := ROUND(EncashAmount, HRSetup."Rounding Precision", '=');

            if HRSetup."Rounding Type" = HRSetup."Rounding Type"::Up then
                LEncahLine."Encash Amount" := ROUND(EncashAmount, HRSetup."Rounding Precision", '>');

            if HRSetup."Rounding Type" = HRSetup."Rounding Type"::Down then
                LEncahLine."Encash Amount" := ROUND(EncashAmount, HRSetup."Rounding Precision", '<');
            LEncahLine.MODIFY();
        end;
    end;

    procedure PostEncash(LeaveEncashLine: Record "Leave Encashment Line B2B");
    var
        DetailedLeaves: Record "Detailed Leave Records B2B";
        LeaveMaster: Record "Leave Master B2B";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        PayrollGenGroup: Record "Payroll Gen. Posting Group B2B";
        GenJnlLine: Record "Gen. Journal Line";
        MonAttendance: Record "Monthly Attendance B2B";
        GenJnlPostLine: Codeunit 12;
        TotalEncashed: Decimal;
        EntryNum: Integer;
        I: Decimal;
    begin
        if Employee.GET(LeaveEncashLine."Employee Code") then begin
            Employee.TESTFIELD("Emp Posting Group");
            Employee.TESTFIELD("Payroll Bus. Posting Group");
            if EmpPostingGroup.GET(Employee."Emp Posting Group") then
                EmpPostingGroup.TESTFIELD(EmpPostingGroup."LeaveEncash Payable Acc.")
            else
                ERROR(Text002Lbl);

            PayrollGenGroup.RESET();
            PayrollGenGroup.SETRANGE("Payroll Bus. Posting Group", Employee."Payroll Bus. Posting Group");
            PayrollGenGroup.SETRANGE("Payroll Prod. Posting Group", "Product Posting Group");
            if PayrollGenGroup.FINDFIRST() then
                PayrollGenGroup.TESTFIELD("G/L Code")
            else
                ERROR(Text001Lbl);
        end;

        GenJnlLine.INIT();
        GenJnlLine."Journal Template Name" := "Journal Template Name";
        GenJnlLine."Journal Batch Name" := "Journal Batch Name";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := PayrollGenGroup."G/L Code";
        GenJnlLine.VALIDATE("Account No.");
        GenJnlLine."Document No." := "Document No.";
        GenJnlLine."Posting Date" := workdate();
        GenJnlLine.Description :=
           "Encashment Code" + ' ' + LeaveEncashLine."Leave Code" + ' ' + "Employee Code";
        GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine.Amount := LeaveEncashLine."Encash Amount";
        GenJnlLine.VALIDATE(Amount);
        GenJnlLine."Source Code" := GenjnlTextLbl;
        //GenJnlLine."Source Type" := GenJnlLine."Source Type"::"10";//Phani
        GenJnlLine."Source No." := LeaveEncashLine."Employee Code";
        MonAttendance.SETRANGE("Employee Code", LeaveEncashLine."Employee Code");
        MonAttendance.SETRANGE("Pay Slip Month", LeaveEncashLine.Month);
        MonAttendance.SETRANGE(Year, LeaveEncashLine.Year);
        if MonAttendance.FINDFIRST() then
            repeat
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", MonAttendance."Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", MonAttendance."Shortcut Dimension 2 Code");
                GenJnlLine."Dimension Set ID" := MonAttendance."Dimension Set ID";
            until MonAttendance.NEXT() = 0;

        GenJnlPostLine.RunWithCheck(GenJnlLine);

        GenJnlLine.INIT();
        GenJnlLine."Journal Template Name" := "Journal Template Name";
        GenJnlLine."Journal Batch Name" := "Journal Batch Name";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := EmpPostingGroup."LeaveEncash Payable Acc.";
        GenJnlLine.VALIDATE("Account No.");
        GenJnlLine."Document No." := "Document No.";
        GenJnlLine."Posting Date" := workdate();
        GenJnlLine.Description :=
           "Encashment Code" + ' ' + LeaveEncashLine."Leave Code" + ' ' + "Employee Code";
        GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine.Amount := -(LeaveEncashLine."Encash Amount");
        GenJnlLine.VALIDATE(Amount);
        GenJnlLine."Source Code" := GenjnlTextLbl;

        //GenJnlLine."Source Type" := GenJnlLine."Source Type"::"10";//Phani
        GenJnlLine."Source No." := LeaveEncashLine."Employee Code";
        MonAttendance.RESET();
        MonAttendance.SETRANGE("Employee Code", LeaveEncashLine."Employee Code");
        MonAttendance.SETRANGE("Pay Slip Month", LeaveEncashLine.Month);
        MonAttendance.SETRANGE(Year, LeaveEncashLine.Year);
        if MonAttendance.FINDFIRST() then
            repeat
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", MonAttendance."Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", MonAttendance."Shortcut Dimension 2 Code");
                GenJnlLine."Dimension Set ID" := MonAttendance."Dimension Set ID";
            until MonAttendance.NEXT() = 0;



        GenJnlPostLine.RunWithCheck(GenJnlLine);
        TotalEncashed := LeaveEncashLine."Leaves To Encash";

        if DetailedLeaves.FINDLAST() then
            EntryNum := DetailedLeaves."Entry No." + 1
        else
            EntryNum := 1;

        for I := TotalEncashed downto 1 do begin
            DetailedLeaves.INIT();
            DetailedLeaves."Entry No." := EntryNum;
            DetailedLeaves."Entry Type" := DetailedLeaves."Entry Type"::Encashment;
            DetailedLeaves."Entry Date" := DMY2DATE(1, Month, Year);
            DetailedLeaves."Employee No." := LeaveEncashLine."Employee Code";
            DetailedLeaves."Leave Code" := LeaveEncashLine."Leave Code";
            if LeaveMaster.GET(DetailedLeaves."Leave Code") then
                DetailedLeaves."Leave Description" := LeaveMaster.Description;
            DetailedLeaves.Month := LeaveEncashLine.Month;
            DetailedLeaves.Year := LeaveEncashLine.Year;
            DetailedLeaves."Posting Date" := workdate();
            DetailedLeaves."No. of Leaves" := -1;
            DetailedLeaves.INSERT();
            EntryNum := EntryNum + 1;
        end;
        PostLEHeader.INIT();
        PostLEHeader.TRANSFERFIELDS(Rec);
        PostLEHeader.INSERT();
        PostLELine.INIT();
        PostLELine.TRANSFERFIELDS(LeaveEncashLine);
        PostLELine.INSERT();

        MESSAGE(Text003Lbl, "Encashment Code");

        LeaveEncashLine.DELETEALL();
        Rec.Delete();
    end;

    procedure AssistEdit(OldLE: Record "Leave Encashment Header B2B"): Boolean;
    var
        LE: Record "Leave Encashment Header B2B";
    begin
        with LE do begin

            LE := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD("Leave Encashment Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Leave Encashment Nos.", OldLE."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Encashment Code");
                Rec := LE;
                exit(true);
            end;
        end;
    end;

    procedure PostEncashment();
    var
        DetailedLeaves: Record "Detailed Leave Records B2B";
        LeaveMaster: Record "Leave Master B2B";
        LeaveEncashLine: Record "Leave Encashment Line B2B";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        PayrollGenGroup: Record "Payroll Gen. Posting Group B2B";
        GenJnlLine: Record "Gen. Journal Line";
        MonAttendance: Record "Monthly Attendance B2B";
        GenJnlPostLine: Codeunit 12;
        TotalEncashed: Decimal;
        EntryNum: Integer;
        I: Decimal;

    begin
        TESTFIELD("Product Posting Group");
        if not Post then begin
            if CONFIRM(Text005Lbl) then begin
                LeaveEncashLine.RESET();
                LeaveEncashLine.SETRANGE("Encashment Code", "Encashment Code");
                LeaveEncashLine.SETFILTER("Encash Amount", '<>%1', 0);
                if LeaveEncashLine.FINDSET() then begin
                    PostLEHeader.INIT();
                    PostLEHeader.TRANSFERFIELDS(Rec);
                    PostLEHeader.INSERT();
                    repeat
                        if Employee.GET(LeaveEncashLine."Employee Code") then begin
                            Employee.TESTFIELD("Emp Posting Group");
                            Employee.TESTFIELD("Payroll Bus. Posting Group");
                            if EmpPostingGroup.GET(Employee."Emp Posting Group") then
                                EmpPostingGroup.TESTFIELD(EmpPostingGroup."LeaveEncash Payable Acc.")
                            else
                                ERROR(Text002Lbl);
                            PayrollGenGroup.RESET();
                            PayrollGenGroup.SETRANGE("Payroll Bus. Posting Group", Employee."Payroll Bus. Posting Group");
                            PayrollGenGroup.SETRANGE("Payroll Prod. Posting Group", "Product Posting Group");
                            if PayrollGenGroup.FINDFIRST() then
                                PayrollGenGroup.TESTFIELD("G/L Code")
                            else
                                ERROR(Text001Lbl);
                        end;

                        GenJnlLine.INIT();
                        GenJnlLine."Journal Template Name" := "Journal Template Name";
                        GenJnlLine."Journal Batch Name" := "Journal Batch Name";
                        GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
                        GenJnlLine."Shortcut Dimension 1 Code" := LeaveEncashLine."Shortcut Dimension 1 Code";
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No." := PayrollGenGroup."G/L Code";
                        GenJnlLine."Document No." := "Document No.";
                        GenJnlLine."Posting Date" := workdate();
                        GenJnlLine.Description :=
                           "Encashment Code" + ' ' + LeaveEncashLine."Leave Code" + ' ' + "Employee Code";
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine.Amount := LeaveEncashLine."Encash Amount";
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Source Code" := GenjnlTextLbl;
                        //GenJnlLine."Source Type" := GenJnlLine."Source Type"::"10";//Phani
                        GenJnlLine."Source No." := LeaveEncashLine."Employee Code";
                        MonAttendance.SETRANGE("Employee Code", LeaveEncashLine."Employee Code");
                        MonAttendance.SETRANGE("Pay Slip Month", LeaveEncashLine.Month);
                        MonAttendance.SETRANGE(Year, LeaveEncashLine.Year);
                        if MonAttendance.FINDFIRST() then
                            repeat
                                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", MonAttendance."Shortcut Dimension 1 Code");
                                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", MonAttendance."Shortcut Dimension 2 Code");
                                GenJnlLine."Dimension Set ID" := MonAttendance."Dimension Set ID";

                            until MonAttendance.NEXT() = 0;

                        GenJnlPostLine.RunWithCheck(GenJnlLine);
                        GenJnlLine.INIT();
                        GenJnlLine."Journal Template Name" := "Journal Template Name";
                        GenJnlLine."Journal Batch Name" := "Journal Batch Name";
                        GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
                        GenJnlLine."Shortcut Dimension 1 Code" := LeaveEncashLine."Shortcut Dimension 1 Code";
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No." := EmpPostingGroup."LeaveEncash Payable Acc.";
                        GenJnlLine."Document No." := "Document No.";
                        GenJnlLine."Posting Date" := workdate();
                        GenJnlLine.Description :=
                           "Encashment Code" + ' ' + LeaveEncashLine."Leave Code" + ' ' + "Employee Code";
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine.Amount := -(LeaveEncashLine."Encash Amount");
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Source Code" := GenjnlTextLbl;
                        //GenJnlLine."Source Type" := GenJnlLine."Source Type"::"10";//Phani
                        GenJnlLine."Source No." := LeaveEncashLine."Employee Code";
                        MonAttendance.RESET();
                        MonAttendance.SETRANGE("Employee Code", LeaveEncashLine."Employee Code");
                        MonAttendance.SETRANGE("Pay Slip Month", LeaveEncashLine.Month);
                        MonAttendance.SETRANGE(Year, LeaveEncashLine.Year);
                        if MonAttendance.FINDFIRST() then
                            repeat
                                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", MonAttendance."Shortcut Dimension 1 Code");
                                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", MonAttendance."Shortcut Dimension 2 Code");
                                GenJnlLine."Dimension Set ID" := MonAttendance."Dimension Set ID";

                            until MonAttendance.NEXT() = 0;

                        GenJnlPostLine.RunWithCheck(GenJnlLine);
                        TotalEncashed := LeaveEncashLine."Leaves To Encash";

                        if DetailedLeaves.FINDLAST() then
                            EntryNum := DetailedLeaves."Entry No." + 1
                        else
                            EntryNum := 1;

                        for I := TotalEncashed downto 1 do begin
                            DetailedLeaves.INIT();
                            DetailedLeaves."Entry No." := EntryNum;
                            DetailedLeaves."Entry Type" := DetailedLeaves."Entry Type"::Encashment;
                            DetailedLeaves."Entry Date" := DMY2DATE(1, Month, Year);
                            DetailedLeaves."Employee No." := LeaveEncashLine."Employee Code";
                            DetailedLeaves."Leave Code" := LeaveEncashLine."Leave Code";
                            if LeaveMaster.GET(DetailedLeaves."Leave Code") then
                                DetailedLeaves."Leave Description" := LeaveMaster.Description;
                            DetailedLeaves.Month := LeaveEncashLine.Month;
                            DetailedLeaves.Year := LeaveEncashLine.Year;
                            DetailedLeaves."Posting Date" := workdate();
                            DetailedLeaves."No. of Leaves" := -1;
                            DetailedLeaves.INSERT();
                            EntryNum := EntryNum + 1;
                        end;
                        PostLELine.INIT();
                        PostLELine.TRANSFERFIELDS(LeaveEncashLine);
                        PostLELine.INSERT();
                    until LeaveEncashLine.NEXT() = 0;
                    MESSAGE(Text003Lbl, "Encashment Code");
                    LeaveEncashLine.DELETEALL();
                    Rec.Delete();
                end;
            end;
        end else
            ERROR(Text006Lbl, "Encashment Code");
    end;
}

