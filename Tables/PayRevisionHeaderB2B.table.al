table 33001237 "Pay Revision Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Revision Header';
    DrillDownPageID = "Pay Revision Header List B2B";
    LookupPageID = "Pay Revision Header List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Id."; Code[20])
        {
            Caption = 'Id.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Employee No." <> '' then
                    CreateDim(DATABASE::"Employee B2B", "Employee No.");
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; Grade; Code[30])
        {
            Caption = 'Grade';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(5; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                PayRevisionLine: Record "Pay Revision Line B2B";
            begin
                TestStatus();
                PayRevisionLine.RESET();
                PayRevisionLine.SETRANGE("Header No.", "Id.");
                if PayRevisionLine.FINDFIRST() then
                    repeat
                        PayRevisionLine."Effective Date" := "Effective Date";
                        PayRevisionLine.Month := DATE2DMY("Effective Date", 2);
                        PayRevisionLine.Year := DATE2DMY("Effective Date", 3);
                        PayRevisionLine.MODIFY();
                    until PayRevisionLine.NEXT() = 0;
            end;
        }
        field(6; "New Grade"; Code[20])
        {
            Caption = 'New Grade';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(7; "Revisied Date"; Date)
        {
            Caption = 'Revisied Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(8; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Grade';
            OptionMembers = Employee,Grade,All;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD(Type, Type::Employee);
            end;
        }
        field(9; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(Grade)) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'))
            ELSE
            IF (Type = FILTER('Employee|All')) "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                PayRevisionLine: Record "Pay Revision Line B2B";
            begin
                TestStatus();
                if Type = Type::Grade then begin
                    PayRevisionLine.SETRANGE("Header No.", "Id.");
                    PayRevisionLine.SETRANGE(Type, xRec.Type);
                    PayRevisionLine.SETRANGE("No.", xRec."No.");
                    if PayRevisionLine.FINDFIRST() then
                        PayRevisionLine.DELETEALL();
                    GetPayCadrePayElements(Rec);
                    PayCadrePayElement.RESET();
                    if PayCadrePayElement.FINDFIRST() then
                        repeat
                            PayCadrePayElement.Processed := false;
                            PayCadrePayElement.MODIFY();
                        until PayCadrePayElement.NEXT() = 0;

                end else
                    if Type = Type::Employee then
                        if "No." <> '' then begin
                            if Employee.GET("No.") then begin
                                "Employee Name" := Employee."First Name";
                                Grade := Employee."Pay Cadre";
                            end;
                            PayRevisionLine.SETRANGE("Header No.", "Id.");
                            if PayRevisionLine.FINDFIRST() then
                                PayRevisionLine.DELETEALL();
                            GetEmpPayElements(Rec);
                            PayElement.RESET();
                            if PayElement.FINDFIRST() then
                                repeat
                                    PayElement.Processed := false;
                                    PayElement.MODIFY();
                                until PayElement.NEXT() = 0;

                            CreateDim(DATABASE::"Employee B2B", "No.");

                        end else begin
                            CLEAR("Employee Name");
                            CLEAR(Grade);
                            CLEAR("New Grade");
                            CLEAR("Effective Date");
                            PayRevisionLine.SETRANGE("Header No.", "Id.");
                            if PayRevisionLine.FINDFIRST() then
                                PayRevisionLine.DELETEALL();
                        end;

                CLEAR(Grade);
                CLEAR("New Grade");
                CLEAR("Effective Date");
            end;
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(11; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(12; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(13; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(14; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(16; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(20; "Caluclate For Entire Month"; Boolean)
        {
            Caption = 'Caluclate For Entire Month';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if "Caluclate For Entire Month" then
                    "Caluclate From Effective Date" := false
                else
                    "Caluclate From Effective Date" := true;
            end;
        }
        field(21; "Caluclate From Effective Date"; Boolean)
        {
            Caption = 'Caluclate From Effective Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if "Caluclate From Effective Date" then
                    "Caluclate For Entire Month" := false
                else
                    "Caluclate For Entire Month" := true;
            end;
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                ShowDocDim();
            end;
        }
        field(481; Post; Boolean)
        {

            DataClassification = CustomerContent;
        }
        field(482; "Payment Posted"; Boolean)
        {

            DataClassification = CustomerContent;
        }
        field(483; "Pay Amount"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(484; "Revision ID"; Code[20])
        {
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(Key1; "Id.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
    begin
        TestStatus();
        PayRevisionLine.SETRANGE("Header No.", "Id.");
        PayRevisionLine.SETRANGE(Type, Type);
        PayRevisionLine.SETRANGE("No.", "No.");
        if PayRevisionLine.FINDFIRST() then
            PayRevisionLine.DELETEALL();
    end;

    trigger OnInsert();
    begin
        if "Id." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Pay Revision Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Pay Revision Nos.", xRec."No. Series", 0D, "Id.", "No. Series");
        end;

        "Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();
        if "Location Code" = '' then
            ERROR(Text008Lbl, USERID());
        "Revisied Date" := WORKDATE();
    end;

    trigger OnRename();
    begin
        TestStatus();
    end;

    var

        Employee: Record "Employee B2B";
        PayElement: Record "Pay Elements B2B";
        PayElement2: Record "Pay Elements B2B";
        HRSetup: Record "HR Setup B2B";
        PayRevision: Record "Pay Revision Header B2B";
        PayCadrePayElement: Record "Pay Cadre Pay Element B2B";
        PayRevisionLineGRec: Record "Pay Revision Line B2B";
        NoSeriesMgt: Codeunit 396;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        DimMgt: Codeunit DimensionManagement;
        Text002Lbl: Label 'No processed salary Records found.';
        Text003Lbl: Label 'Either "Caluclate For Entire Month" or "Caluclate From Effective Date" is not selected';
        Text004Lbl: Label 'Do you want to release the document ?';
        Text005Lbl: Label 'Do you want to reopen the document ?';
        Text006Lbl: Label 'Document %1 has been already posted.', Comment = '%1 = No.';
        Text008Lbl: Label 'Location is not found for %1.', Comment = '%1 = User ID';
        Text010Lbl: Label 'Pay revision document %1 has been already posted.', Comment = '%1 = Id';
        LineNoVar: Integer;
        SkipConfirmation: Boolean;
        Text011Lbl: Label 'Arrears are already caluclated';
        TDSTxt: Label 'TDS';
        PFTxt: Label 'PF';
        PTTxt: Label 'PT';
        ESITxt: Label 'ESI';
        LOANTxt: Label 'LOAN';
        LEAVEENCASHMENTTxt: Label 'LEAVE ENCASHMENT';
        OTTxt: Label 'OT';
        BASICTxt: Label 'BASIC';
        OnAttTxt: Label 'ON ATTENDANCE';
        NonAttTxt: Label 'NON ATTENDANCE';
        AFTERBASICTxt: Label 'AFTER BASIC';
        AFTERBASICANDDATxt: Label 'AFTER BASIC AND DA';
        DATxt: Label 'DA';
        CMExprLbl: Label '<CM>';
        AddDedTxt: Label 'ADDITIONS AND DEDUCTIONS';

    procedure GetEmpPayElements(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        CheckDate: Date;
    begin
        if HRSetup.FINDFIRST() then
            CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
        if PayRevisionHeader.Type = PayRevisionHeader.Type::Employee then begin
            PayElement.SETFILTER("Effective Start Date", '<=%1', CheckDate);
            PayElement.SETRANGE("Employee Code", PayRevisionHeader."No.");
            PayElement.SETRANGE(PayElement.Processed, false);
            if PayElement.FINDFIRST() then
                repeat
                    PayElement2.SETRANGE(PayElement2.Processed, false);
                    PayElement2.SETRANGE("Employee Code", PayElement."Employee Code");
                    PayElement2.SETRANGE("Pay Element Code", PayElement."Pay Element Code");
                    if PayElement2.FINDFIRST() then begin
                        repeat
                            PayElement2.Processed := true;
                            PayElement2.MODIFY();
                            if PayElement2."Effective Start Date" <= CheckDate then begin
                                PayRevisionLine."Header No." := PayRevisionHeader."Id.";
                                PayRevisionLine."No." := PayRevisionHeader."No.";
                                PayRevisionLine.Type := PayRevisionHeader.Type;
                                PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
                                PayRevisionLine."Pay Element" := PayElement2."Pay Element Code";
                                PayRevisionLine."Fixed / Percent" := PayElement2."Fixed/Percent";
                                PayRevisionLine."Amount / Percent" := PayElement2."Amount / Percent";
                                PayRevisionLine."Computation Type" := PayElement2."Computation Type";
                                PayRevisionLine."Starting Date" := PayElement2."Effective Start Date";
                                PayRevisionLine.Grade := PayElement."Pay Cadre";
                                PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
                                PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
                                PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
                                if PayRevisionLine."Effective Date" <> 0D then begin
                                    PayRevisionLine.Month := DATE2DMY(PayRevisionLine."Effective Date", 2);
                                    PayRevisionLine.Year := DATE2DMY(PayRevisionLine."Effective Date", 3);
                                end;
                                PayRevisionLine."Revised Amount / Percent" := PayElement2."Amount / Percent";
                                PayRevisionLine."Revised Fixed / Percent" := PayElement2."Fixed/Percent";
                                PayRevisionLine."Revised Computation Type" := PayElement2."Computation Type";
                                PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct";
                                PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
                            end;
                        until PayElement2.NEXT() = 0;
                        if PayRevisionLine."Amount / Percent" <> 0 then
                            PayRevisionLine.INSERT();

                    end;
                until PayElement.NEXT() = 0;

        end;
    end;

    procedure GetPayCadrePayElements(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayCadrePayElement2: Record "Pay Cadre Pay Element B2B";
        PayRevisionLine: Record "Pay Revision Line B2B";
        CheckDate: Date;
    begin
        if HRSetup.FINDFIRST() then
            CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
        if PayRevisionHeader.Type = PayRevisionHeader.Type::Grade then begin
            PayCadrePayElement.SETRANGE("Pay Cadre Code", PayRevisionHeader."No.");
            PayCadrePayElement.SETRANGE(PayCadrePayElement.Processed, false);
            if PayCadrePayElement.FINDFIRST() then
                repeat
                    PayCadrePayElement2.SETRANGE(PayCadrePayElement2.Processed, false);
                    PayCadrePayElement2.SETRANGE("Pay Cadre Code", PayCadrePayElement."Pay Cadre Code");
                    PayCadrePayElement2.SETRANGE("Pay Element Code", PayCadrePayElement."Pay Element Code");
                    if PayCadrePayElement2.FINDFIRST() then
                        repeat
                            PayCadrePayElement2.Processed := true;
                            PayCadrePayElement2.MODIFY();
                            if PayCadrePayElement2."Effective Start Date" <= CheckDate then begin
                                PayRevisionLine."No." := PayRevisionHeader."No.";
                                PayRevisionLine.Type := PayRevisionHeader.Type;
                                PayRevisionLine."Header No." := PayRevisionHeader."Id.";
                                PayRevisionLine.Grade := PayCadrePayElement2."Pay Cadre Code";
                                PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
                                PayRevisionLine."Pay Element" := PayCadrePayElement2."Pay Element Code";
                                PayRevisionLine."Fixed / Percent" := PayCadrePayElement2."Fixed/Percent";
                                PayRevisionLine."Amount / Percent" := PayCadrePayElement2."Amount / Percent";
                                PayRevisionLine."Computation Type" := PayCadrePayElement2."Computation Type";
                                PayRevisionLine."Starting Date" := PayCadrePayElement2."Effective Start Date";
                                PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
                                PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
                                PayRevisionLine."Revised Amount / Percent" := PayCadrePayElement2."Amount / Percent";
                                PayRevisionLine."Revised Fixed / Percent" := PayCadrePayElement2."Fixed/Percent";
                                PayRevisionLine."Revised Computation Type" := PayCadrePayElement2."Computation Type";
                                PayRevisionLine."Add/Deduct" := PayCadrePayElement2."Add/Deduct";
                                PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
                            end;
                        until PayCadrePayElement2.NEXT() = 0;
                    if PayRevisionLine."Amount / Percent" <> 0 then
                        PayRevisionLine.INSERT();
                until PayCadrePayElement.NEXT() = 0;
        end;
    end;

    procedure PostPayRevision(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        MonAttendance: Record "Monthly Attendance B2B";
        PayRevisionLine: Record "Pay Revision Line B2B";
        GradeTransMonth: Integer;
        GradeTransYear: Integer;
    begin
        TestStatus();
        PayRevisionHeader.TESTFIELD(PayRevisionHeader."Effective Date");
        if PayRevisionHeader.Type = PayRevisionHeader.Type::Employee then begin
            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
            PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
            PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
            PayRevisionLine.SETRANGE("Effective Date", PayRevisionHeader."Effective Date");
            if PayRevisionLine.FINDFIRST() then
                repeat
                    if not ((PayRevisionLine."Pay Element" = TDSTxt) or (PayRevisionLine."Pay Element" = PFTxt) or
                       (PayRevisionLine."Pay Element" = PTTxt) or (PayRevisionLine."Pay Element" = ESITxt) or (PayRevisionLine."Pay Element" = LOANTxt)
                        or (PayRevisionLine."Pay Element" = OTTxt) or (PayRevisionLine."Pay Element" = LEAVEENCASHMENTTxt))
                    then begin
                        PayRevisionLine.TESTFIELD(PayRevisionLine."Effective Date");
                        PayElement.INIT();
                        PayElement."Employee Code" := PayRevisionLine."No.";
                        PayElement."Effective Start Date" := PayRevisionLine."Effective Date";
                        PayElement."Pay Element Code" := PayRevisionLine."Pay Element";
                        PayElement.VALIDATE("Pay Element Code");
                        PayElement."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                        PayElement."Computation Type" := PayRevisionLine."Revised Computation Type";
                        PayElement."Amount / Percent" := PayRevisionLine."Revised Amount / Percent";
                        PayElement."Add/Deduct" := PayRevisionLine."Add/Deduct";
                        if PayRevisionHeader."New Grade" <> '' then
                            PayElement."Pay Cadre" := PayRevisionHeader."New Grade"
                        else
                            PayElement."Pay Cadre" := PayRevisionLine.Grade;
                        PayElement.INSERT();
                    end;
                until PayRevisionLine.NEXT() = 0;

            if PayRevisionHeader."New Grade" <> '' then begin
                Employee.SETRANGE("No.", PayRevisionHeader."No.");
                if Employee.FINDFIRST() then begin
                    Employee."Pay Cadre" := PayRevisionHeader."New Grade";
                    Employee.MODIFY();
                end;
                GradeTransMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
                GradeTransYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
                MonAttendance.SETRANGE("Employee Code", PayRevisionHeader."No.");
                MonAttendance.SETFILTER("Pay Slip Month", '>=%1', GradeTransMonth);
                MonAttendance.SETFILTER(Year, '>=%1', GradeTransYear);
                if MonAttendance.FINDFIRST() then
                    repeat
                        MonAttendance.PayCadre := PayRevisionHeader."New Grade";
                        MonAttendance.MODIFY();
                    until MonAttendance.NEXT() = 0;
            end;
        end;

        if PayRevisionHeader.Type = PayRevisionHeader.Type::Grade then begin
            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
            PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
            PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
            if PayRevisionLine.FINDFIRST() then
                repeat
                    if not ((PayRevisionLine."Pay Element" = TDSTxt) or (PayRevisionLine."Pay Element" = PFTxt) or
                       (PayRevisionLine."Pay Element" = PTTxt) or (PayRevisionLine."Pay Element" = ESITxt) or (PayRevisionLine."Pay Element" = LOANTxt)
                        or (PayRevisionLine."Pay Element" = OTTxt) or (PayRevisionLine."Pay Element" = LEAVEENCASHMENTTxt))
                    then begin
                        PayRevisionLine.TESTFIELD(PayRevisionLine."Effective Date");
                        PayCadrePayElement.INIT();
                        PayCadrePayElement."Pay Cadre Code" := PayRevisionLine."No.";
                        PayCadrePayElement."Effective Start Date" := PayRevisionLine."Effective Date";
                        PayCadrePayElement."Pay Element Code" := PayRevisionLine."Pay Element";
                        PayCadrePayElement."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                        PayCadrePayElement."Computation Type" := PayRevisionLine."Revised Computation Type";
                        PayCadrePayElement."Amount / Percent" := PayRevisionLine."Revised Amount / Percent";
                        PayCadrePayElement."Add/Deduct" := PayRevisionLine."Add/Deduct";
                        PayCadrePayElement.INSERT();
                        Employee.RESET();
                        Employee.SETRANGE("Pay Cadre", PayRevisionHeader."No.");
                        if Employee.FINDFIRST() then
                            repeat
                                PayElement2.INIT();
                                PayElement2."Employee Code" := Employee."No.";
                                PayElement2."Effective Start Date" := PayRevisionLine."Effective Date";
                                PayElement2."Pay Element Code" := PayRevisionLine."Pay Element";
                                PayElement2."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                                PayElement2."Computation Type" := PayRevisionLine."Revised Computation Type";
                                PayElement2."Amount / Percent" := PayRevisionLine."Revised Amount / Percent";
                                PayElement2."Pay Cadre" := PayRevisionLine.Grade;
                                PayElement2."Add/Deduct" := PayRevisionLine."Add/Deduct";
                                PayElement2.INSERT();
                            until Employee.NEXT() = 0;
                    end;
                until PayRevisionLine.NEXT() = 0;
        end;


        if PayRevisionHeader.Type = PayRevisionHeader.Type::All then begin
            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
            PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
            PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
            if PayRevisionLine.FINDFIRST() then
                repeat
                    if not ((PayRevisionLine."Pay Element" = TDSTxt) or (PayRevisionLine."Pay Element" = PFTxt) or
                       (PayRevisionLine."Pay Element" = PTTxt) or (PayRevisionLine."Pay Element" = ESITxt) or (PayRevisionLine."Pay Element" = LOANTxt)
                        or (PayRevisionLine."Pay Element" = OTTxt) or (PayRevisionLine."Pay Element" = LEAVEENCASHMENTTxt))
                    then begin
                        PayRevisionLine.TESTFIELD(PayRevisionLine."Effective Date");
                        PayCadrePayElement.INIT();
                        PayCadrePayElement."Pay Cadre Code" := PayRevisionLine."No.";
                        PayCadrePayElement."Effective Start Date" := PayRevisionLine."Effective Date";
                        PayCadrePayElement."Pay Element Code" := PayRevisionLine."Pay Element";
                        PayCadrePayElement."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                        PayCadrePayElement."Computation Type" := PayRevisionLine."Revised Computation Type";
                        PayCadrePayElement."Amount / Percent" := PayRevisionLine."Revised Amount / Percent";
                        PayCadrePayElement."Add/Deduct" := PayRevisionLine."Add/Deduct";
                        PayCadrePayElement.INSERT();
                        Employee.RESET();
                        Employee.SETRANGE("Pay Cadre", PayRevisionHeader."No.");
                        if Employee.FINDFIRST() then
                            repeat
                                PayElement2.INIT();
                                PayElement2."Employee Code" := Employee."No.";
                                PayElement2."Effective Start Date" := PayRevisionLine."Effective Date";
                                PayElement2."Pay Element Code" := PayRevisionLine."Pay Element";
                                PayElement2."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                                PayElement2."Computation Type" := PayRevisionLine."Revised Computation Type";
                                PayElement2."Amount / Percent" := PayRevisionLine."Revised Amount / Percent";
                                PayElement2."Pay Cadre" := PayRevisionLine.Grade;
                                PayElement2."Add/Deduct" := PayRevisionLine."Add/Deduct";
                                PayElement2.INSERT();
                            until Employee.NEXT() = 0;
                    end;
                until PayRevisionLine.NEXT() = 0;
        end;
    end;

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;

    procedure CalculateArrearAmount(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        ProcessedSalary: Record "Processed Salary B2B";
        PayRevisionLine: Record "Pay Revision Line B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        ProcessedSalary2: Record "Processed Salary B2B";
        ProcessedSalary3: Record "Processed Salary B2B";
        MonAtt: Record "Monthly Attendance B2B";
        PayRevisionLineDA: Record "Pay Revision Line B2B";
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        NoofDays: Decimal;
        MonthDays: Decimal;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        EndMonth: Integer;
        EndYear: Integer;
        EffectDays: Integer;
        DAProcessed: Boolean;
        DATempAmt: Decimal;

    begin
        DA := 0;
        CheckIfAlreadyCaluclated(PayRevisionHeader);
        if PayRevisionHeader."Caluclate For Entire Month" then begin
            CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
            CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
            ProcessedSalary.SETRANGE("Employee Code", PayRevisionHeader."No.");
            ProcessedSalary.SETRANGE(ProcessedSalary."Pay Slip Month", CurrentMonth);
            ProcessedSalary.SETRANGE(ProcessedSalary.Year, CurrentYear);
            ProcessedSalary.SETRANGE("LOP Adjustment", false);
            if ProcessedSalary.FINDFIRST() then begin
                NoofDays := ProcessedSalary.Attendance;
                MonthDays := ProcessedSalary.Days;
            end else
                ERROR(Text002Lbl);
            ProcessedSalary2.RESET();
            ProcessedSalary2.SETRANGE("Employee Code", PayRevisionHeader."No.");
            ProcessedSalary2.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
            ProcessedSalary2.SETFILTER(Year, '>=%1', CurrentYear);
            ProcessedSalary2.SETRANGE(Posted, true);
            ProcessedSalary2.SETRANGE("Add/Deduct Code", BASICTxt);
            ProcessedSalary2.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year);
            ProcessedSalary2.SETRANGE("LOP Adjustment", false);
            if ProcessedSalary2.FINDFIRST() then begin
                DAProcessed := false;
                DATempAmt := 0;
                repeat
                    ProcessedSalary3.RESET();
                    ProcessedSalary3.SETRANGE("Employee Code", ProcessedSalary2."Employee Code");
                    ProcessedSalary3.SETRANGE("Pay Slip Month", ProcessedSalary2."Pay Slip Month");
                    ProcessedSalary3.SETRANGE(Year, ProcessedSalary2.Year);
                    ProcessedSalary3.SETRANGE(Posted, true);
                    ProcessedSalary3.SETRANGE("LOP Adjustment", false);
                    if ProcessedSalary3.FINDFIRST() then
                        repeat
                            MonAtt.RESET();
                            MonAtt.SETRANGE("Employee Code", ProcessedSalary3."Employee Code");
                            MonAtt.SETRANGE("Pay Slip Month", ProcessedSalary3."Pay Slip Month");
                            MonAtt.SETRANGE(Year, ProcessedSalary3.Year);
                            if MonAtt.FINDFIRST() then begin
                                MonAtt.CALCFIELDS(Attendance, MonAtt.Leaves, Days, MonAtt.Holidays);
                                CLEAR(NoofDays);
                                CLEAR(MonthDays);
                                //NoofDays := MonAtt.Attendance + MonAtt.Leaves;
                                //NoofDays := MonAtt.Attendance + MonAtt.Holidays;
                                NoofDays := MonAtt.Attendance - MonAtt."Loss Of Pay";
                                MonthDays := MonAtt.Days;
                            end;
                            PayRevisionLine.RESET();
                            PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
                            PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
                            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
                            PayRevisionLine.SETRANGE("No.", ProcessedSalary3."Employee Code");
                            PayRevisionLine.SETRANGE("Pay Element", ProcessedSalary3."Add/Deduct Code");
                            if PayRevisionLine.FINDFIRST() then
                                repeat
                                    if PayRevisionLine."Pay Element" = BASICTxt then begin
                                        if (PayRevisionLine."Revised Computation Type" = OnAttTxt) then begin
                                            Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent";
                                            Basic := Total;
                                        end else
                                            if (PayRevisionLine."Revised Computation Type" = NonAttTxt) then begin
                                                Total := PayRevisionLine."Revised Amount / Percent";
                                                Basic := Total;
                                            end;
                                    end else
                                        if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Fixed) then begin
                                            if (PayRevisionLine."Revised Computation Type" = OnAttTxt) then
                                                Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent"
                                            else
                                                Total := PayRevisionLine."Revised Amount / Percent";
                                        end else
                                            if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) and
                                               (PayRevisionLine."Revised Computation Type" = AFTERBASICTxt)
                                   then
                                                Total := (PayRevisionLine."Revised Amount / Percent" * Basic) / 100
                                            else
                                                if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) and
                                                   (PayRevisionLine."Revised Computation Type" = AFTERBASICANDDATxt)
                                           then
                                                    if not DAProcessed then begin
                                                        CLEAR(DATempAmt);
                                                        PayRevisionLineDA.RESET();
                                                        PayRevisionLineDA.SETCURRENTKEY("No.", "Pay Element");
                                                        PayRevisionLineDA.SETRANGE(Type, PayRevisionLineDA.Type::Employee);
                                                        PayRevisionLineDA.SETRANGE("Header No.", PayRevisionHeader."Id.");
                                                        PayRevisionLineDA.SETRANGE("No.", ProcessedSalary3."Employee Code");
                                                        PayRevisionLineDA.SETRANGE("Pay Element", DATxt);
                                                        if PayRevisionLineDA.FINDFIRST() then
                                                            repeat
                                                                if (PayRevisionLineDA."Revised Fixed / Percent" = PayRevisionLineDA."Revised Fixed / Percent"::Fixed) then begin
                                                                    if (PayRevisionLineDA."Revised Computation Type" = OnAttTxt) then
                                                                        DATempAmt := (NoofDays / MonthDays) * PayRevisionLineDA."Revised Amount / Percent"
                                                                    else
                                                                        DATempAmt := PayRevisionLineDA."Revised Amount / Percent";
                                                                end else
                                                                    if (PayRevisionLineDA."Revised Fixed / Percent" =
                                                                          PayRevisionLineDA."Revised Fixed / Percent"::Percent) and
                                                                       (PayRevisionLineDA."Revised Computation Type" = AFTERBASICTxt)
                                                           then
                                                                        DATempAmt := (PayRevisionLineDA."Revised Amount / Percent" * Basic) / 100;
                                                            until PayRevisionLineDA.NEXT() = 0;
                                                        DATempAmt := ROUND((DATempAmt - ProcessedSalary3."Earned Amount"), 1, '=');
                                                        Total := (PayRevisionLine."Revised Amount / Percent" * (Basic + DATempAmt)) / 100;
                                                    end else
                                                        if DAProcessed then
                                                            Total := (PayRevisionLine."Revised Amount / Percent" * (Basic + DA)) / 100;


                                    if PayRevisionLine."Pay Element" = DATxt then begin
                                        DA := Total;
                                        DAProcessed := true;
                                    end;
                                    ProcessedSalary3."Arrear Amount" := ROUND((Total - ProcessedSalary3."Earned Amount"), 1, '=');
                                    ProcessedSalary3."Arrears Not Posted" := true;
                                    ProcessedSalary3.MODIFY();
                                    PayRevisionLine."Arrear Inserted" := true;
                                    PayRevisionLine.MODIFY();
                                    ProcessedSalary.RESET();
                                    ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                                    ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                                    ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                                    ProcessedSalary.SETRANGE(Posted, true);
                                    ProcessedSalary.SETRANGE("LOP Adjustment", false);
                                    ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                                    if ProcessedSalary.FINDLAST() then begin
                                        EndMonth := ProcessedSalary."Pay Slip Month";
                                        EndYear := ProcessedSalary.Year;
                                    end;

                                    CheckMonth := CurrentMonth;
                                    CheckYear := CurrentYear;
                                    repeat
                                        if PayRevisionLine."Arrear Inserted" = false then begin
                                            ProcessedSalary.INIT();
                                            ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                                            ProcessedSalary."Employee Code" := PayRevisionLine."No.";
                                            ProcessedSalary."Pay Slip Month" := CheckMonth;
                                            ProcessedSalary.Year := CheckYear;
                                            ProcessedSalary."Line No." := ProcessedSalary."Line No." + 100000;
                                            ProcessedSalary."Arrear Amount" := Total;
                                            ProcessedSalary."Add/Deduct Code" := PayRevisionLine."Pay Element";
                                            ProcessedSalary."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                                            ProcessedSalary."Computation Type" := PayRevisionLine."Revised Computation Type";
                                            ProcessedSalary."Add/Deduct" := PayRevisionLine."Add/Deduct";
                                            ProcessedSalary."Arrears Not Posted" := true;
                                            ProcessedSalary.INSERT();
                                        end;
                                        CalculateESIArrearAmount(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                        CalculatePTArrearAmount(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                        if Employee.GET(PayRevisionLine."No.") and (Employee."PF Applicability" <> Employee."PF Applicability"::"Employee Specific")
                                        then
                                            CalculatePFArrearAmount(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                        CheckMonth := CheckMonth + 1;
                                        if CheckMonth = 13 then begin
                                            CheckMonth := 1;
                                            CheckYear := CheckYear + 1;
                                        end;
                                    until ((CheckMonth > EndMonth) and (CheckYear = EndYear)) or (CheckYear > EndYear);
                                until PayRevisionLine.NEXT() = 0;
                        until ProcessedSalary3.NEXT() = 0;

                until ProcessedSalary2.NEXT() = 0;
            end;
        end else
            if PayRevisionHeader."Caluclate From Effective Date" then begin
                CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
                CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionHeader."No.");
                ProcessedSalary.SETRANGE("Pay Slip Month", CurrentMonth);
                ProcessedSalary.SETRANGE(Year, CurrentYear);
                ProcessedSalary.SETRANGE("LOP Adjustment", false);
                if ProcessedSalary.FINDFIRST() then begin
                    CLEAR(EffectDays);
                    EffectDays := (CALCDATE(CMExprLbl, PayRevisionHeader."Effective Date") - PayRevisionHeader."Effective Date") + 1;
                    MonthDays := EffectDays;

                    if ProcessedSalary.Days = ProcessedSalary.Attendance then
                        NoofDays := EffectDays
                    else begin
                        DailyAttendance.RESET();
                        DailyAttendance.SETRANGE("Employee No.", PayRevisionHeader."No.");
                        DailyAttendance.SETRANGE(Date, PayRevisionHeader."Effective Date", CALCDATE(CMExprLbl, PayRevisionHeader."Effective Date"));
                        DailyAttendance.SETFILTER("Attendance Type", '<>%1', DailyAttendance."Attendance Type"::Absent);
                        if DailyAttendance.FINDFIRST() then
                            repeat
                                NoofDays := NoofDays + 1;
                            until DailyAttendance.NEXT() = 0;
                    end
                end else
                    ERROR(Text002Lbl);
                ProcessedSalary2.RESET();
                ProcessedSalary2.SETRANGE("Employee Code", PayRevisionHeader."No.");
                ProcessedSalary2.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary2.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary2.SETRANGE(Posted, true);
                ProcessedSalary2.SETRANGE("Add/Deduct Code", BASICTxt);
                ProcessedSalary2.SETRANGE("LOP Adjustment", false);
                if ProcessedSalary2.FINDFIRST() then begin
                    DAProcessed := false;
                    DATempAmt := 0;
                    repeat
                        ProcessedSalary3.RESET();
                        ProcessedSalary3.SETRANGE("Employee Code", PayRevisionHeader."No.");
                        ProcessedSalary3.SETRANGE("Pay Slip Month", ProcessedSalary2."Pay Slip Month");
                        ProcessedSalary3.SETRANGE(Year, ProcessedSalary2.Year);
                        ProcessedSalary3.SETRANGE(Posted, true);
                        ProcessedSalary3.SETRANGE("LOP Adjustment", false);
                        if ProcessedSalary3.FINDFIRST() then
                            repeat
                                if (ProcessedSalary3."Pay Slip Month" = CurrentMonth) and (ProcessedSalary3.Year = CurrentYear) then begin
                                    CLEAR(EffectDays);
                                    CLEAR(NoofDays);
                                    CLEAR(MonthDays);
                                    EffectDays := (CALCDATE(CMExprLbl, PayRevisionHeader."Effective Date") - PayRevisionHeader."Effective Date") + 1;
                                    MonthDays := EffectDays;
                                    if ProcessedSalary3.Days = ProcessedSalary3.Attendance then
                                        NoofDays := EffectDays
                                    else begin
                                        DailyAttendance.RESET();
                                        DailyAttendance.SETRANGE("Employee No.", PayRevisionHeader."No.");
                                        DailyAttendance.SETRANGE(Date, PayRevisionHeader."Effective Date", CALCDATE(CMExprLbl, PayRevisionHeader."Effective Date"));
                                        DailyAttendance.SETFILTER("Attendance Type", '<>%1', DailyAttendance."Attendance Type"::Absent);
                                        if DailyAttendance.FINDFIRST() then
                                            repeat
                                                NoofDays := NoofDays + 1;
                                            until DailyAttendance.NEXT() = 0;
                                    end;
                                end else begin
                                    CLEAR(NoofDays);
                                    CLEAR(MonthDays);
                                    MonAtt.RESET();
                                    MonAtt.SETRANGE("Employee Code", ProcessedSalary3."Employee Code");
                                    MonAtt.SETRANGE("Pay Slip Month", ProcessedSalary3."Pay Slip Month");
                                    MonAtt.SETRANGE(Year, ProcessedSalary3.Year);
                                    if MonAtt.FINDFIRST() then begin
                                        MonAtt.CALCFIELDS(Attendance, MonAtt.Leaves, Days, MonAtt.Holidays);
                                        // NoofDays := MonAtt.Attendance + MonAtt.Leaves;
                                        //NoofDays := MonAtt.Attendance + MonAtt.Holidays;
                                        NoofDays := MonAtt.Attendance + MonAtt.Leaves;//TEST
                                        MonthDays := MonAtt.Days;
                                    end;
                                end;
                                PayRevisionLine.RESET();
                                PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
                                PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
                                PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
                                PayRevisionLine.SETRANGE("No.", ProcessedSalary3."Employee Code");
                                PayRevisionLine.SETRANGE("Pay Element", ProcessedSalary3."Add/Deduct Code");
                                if PayRevisionLine.FINDFIRST() then
                                    repeat
                                        if PayRevisionLine."Pay Element" = BASICTxt then begin
                                            if (PayRevisionLine."Revised Computation Type" = OnAttTxt) then begin
                                                if (ProcessedSalary3."Pay Slip Month" = CurrentMonth) and (ProcessedSalary3.Year = CurrentYear) then
                                                    Total := NoofDays * (PayRevisionLine."Revised Amount / Percent" / ProcessedSalary3.Days)
                                                else
                                                    Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent";
                                                Basic := Total;
                                            end else
                                                if (PayRevisionLine."Revised Computation Type" = NonAttTxt) then begin
                                                    Total := PayRevisionLine."Revised Amount / Percent";
                                                    Basic := Total;
                                                end;
                                        end else
                                            if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Fixed) then begin
                                                if (PayRevisionLine."Revised Computation Type" = OnAttTxt) then begin
                                                    if (ProcessedSalary3."Pay Slip Month" = CurrentMonth) and (ProcessedSalary3.Year = CurrentYear) then
                                                        Total := NoofDays * (PayRevisionLine."Revised Amount / Percent" / ProcessedSalary3.Days)
                                                    else
                                                        Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent"
                                                end else
                                                    Total := PayRevisionLine."Revised Amount / Percent";
                                            end else
                                                if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) and
                                                   (PayRevisionLine."Revised Computation Type" = AFTERBASICTxt)
                                       then
                                                    Total := (PayRevisionLine."Revised Amount / Percent" * Basic) / 100
                                                else
                                                    if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) and
                                                       (PayRevisionLine."Revised Computation Type" = AFTERBASICANDDATxt)
                                               then
                                                        if not DAProcessed then begin
                                                            CLEAR(DATempAmt);
                                                            PayRevisionLineDA.RESET();
                                                            PayRevisionLineDA.SETCURRENTKEY("No.", "Pay Element");
                                                            PayRevisionLineDA.SETRANGE(Type, PayRevisionLineDA.Type::Employee);
                                                            PayRevisionLineDA.SETRANGE("Header No.", PayRevisionHeader."Id.");
                                                            PayRevisionLineDA.SETRANGE("No.", ProcessedSalary3."Employee Code");
                                                            PayRevisionLineDA.SETRANGE("Pay Element", DATxt);
                                                            if PayRevisionLineDA.FINDFIRST() then
                                                                repeat
                                                                    if (PayRevisionLineDA."Revised Fixed / Percent" = PayRevisionLineDA."Revised Fixed / Percent"::Fixed) then begin
                                                                        if (PayRevisionLineDA."Revised Computation Type" = OnAttTxt) then
                                                                            DATempAmt := (NoofDays / MonthDays) * PayRevisionLineDA."Revised Amount / Percent"
                                                                        else
                                                                            DATempAmt := PayRevisionLineDA."Revised Amount / Percent";
                                                                    end else
                                                                        if (PayRevisionLineDA."Revised Fixed / Percent" =
                                                                              PayRevisionLineDA."Revised Fixed / Percent"::Percent) and
                                                                           (PayRevisionLineDA."Revised Computation Type" = AFTERBASICTxt)
                                                               then
                                                                            DATempAmt := (PayRevisionLineDA."Revised Amount / Percent" * Basic) / 100
                                                                until PayRevisionLineDA.NEXT() = 0;
                                                            if (ProcessedSalary3."Pay Slip Month" = CurrentMonth) and (ProcessedSalary3.Year = CurrentYear) then
                                                                DATempAmt := DATempAmt - (NoofDays * (ProcessedSalary3."Earned Amount" / ProcessedSalary3.Days))
                                                            else
                                                                DATempAmt := (DATempAmt - ProcessedSalary3."Earned Amount");
                                                            Total := (PayRevisionLine."Revised Amount / Percent" * (Basic + DATempAmt)) / 100;
                                                        end else
                                                            if DAProcessed then
                                                                Total := (PayRevisionLine."Revised Amount / Percent" * (Basic + DA)) / 100;

                                        if PayRevisionLine."Pay Element" = DATxt then begin
                                            DA := Total;
                                            DAProcessed := true;
                                        end;
                                        if (ProcessedSalary3."Pay Slip Month" = CurrentMonth) and (ProcessedSalary3.Year = CurrentYear) then
                                            //ProcessedSalary3."Arrear Amount" := Total - (NoofDays * (ProcessedSalary3."Earned Amount" / ProcessedSalary3.Days))
                                            ProcessedSalary3."Arrear Amount" := (Total - ProcessedSalary3."Earned Amount")//TEST
                                        else
                                            ProcessedSalary3."Arrear Amount" := (Total - ProcessedSalary3."Earned Amount");
                                        ProcessedSalary3."Arrears Not Posted" := true;
                                        ProcessedSalary3.MODIFY();
                                        PayRevisionLine."Arrear Inserted" := true;
                                        PayRevisionLine.MODIFY();

                                        ProcessedSalary.RESET();
                                        ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                                        ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                                        ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                                        ProcessedSalary.SETRANGE(Posted, true);
                                        ProcessedSalary.SETRANGE("LOP Adjustment", false);
                                        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                                        if ProcessedSalary.FINDLAST() then begin
                                            EndMonth := ProcessedSalary."Pay Slip Month";
                                            EndYear := ProcessedSalary.Year;
                                        end;
                                        CheckMonth := CurrentMonth;
                                        CheckYear := CurrentYear;
                                        repeat
                                            if PayRevisionLine."Arrear Inserted" = false then begin
                                                ProcessedSalary.INIT();
                                                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                                                ProcessedSalary."Employee Code" := PayRevisionLine."No.";
                                                ProcessedSalary."Pay Slip Month" := CheckMonth;
                                                ProcessedSalary.Year := CheckYear;
                                                ProcessedSalary."Line No." := ProcessedSalary."Line No." + 10000;
                                                ProcessedSalary."Arrear Amount" := Total;
                                                ProcessedSalary."Add/Deduct Code" := PayRevisionLine."Pay Element";
                                                ProcessedSalary."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                                                ProcessedSalary."Computation Type" := PayRevisionLine."Revised Computation Type";
                                                ProcessedSalary."Add/Deduct" := PayRevisionLine."Add/Deduct";
                                                ProcessedSalary."Arrears Not Posted" := true;
                                                ProcessedSalary.INSERT();
                                            end;
                                            CalculateESIArrearAmount(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                            CalculatePTArrearAmount(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                            if Employee.GET(PayRevisionLine."No.") and (Employee."PF Applicability" <> Employee."PF Applicability"::
                                            "Employee Specific")
                                            then
                                                CalculatePFArrearAmount(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                            CheckMonth := CheckMonth + 1;
                                            if CheckMonth = 13 then begin
                                                CheckMonth := 1;
                                                CheckYear := CheckYear + 1;
                                            end;
                                        until ((CheckMonth > EndMonth) and (CheckYear = EndYear)) or (CheckYear > EndYear);
                                    until PayRevisionLine.NEXT() = 0;
                            until ProcessedSalary3.NEXT() = 0;

                    until ProcessedSalary2.NEXT() = 0
                end;
            end else
                ERROR(Text003Lbl);
    end;

    procedure CalculateESIArrearAmount(ProcessedSalary: Record "Processed Salary B2B"; PayRevisionLine: Record "Pay Revision Line B2B"; CheckMonth: Integer; CheckYear: Integer);
    var
        Lookup_B2B: Record Lookup_B2B;
        ESI: Record ESI_B2B;
        TotalESIArrearAmount: Decimal;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        CheckDate: Date;
    begin
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
        ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
        ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
        ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
        ProcessedSalary.SETRANGE(Posted, true);
        ProcessedSalary.SETRANGE("Arrears Not Posted", true);
        ProcessedSalary.SETRANGE("LOP Adjustment", false);
        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
        if ProcessedSalary.FINDFIRST() then
            repeat
                Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
                Lookup_B2B.SETFILTER(ESI, '<>%1', Lookup_B2B.ESI::" ");
                Lookup_B2B.SETRANGE("Lookup Name", ProcessedSalary."Add/Deduct Code");
                if not Lookup_B2B.IsEmpty() then
                    TotalESIArrearAmount := TotalESIArrearAmount + ProcessedSalary."Arrear Amount";
            until ProcessedSalary.NEXT() = 0;
        if ESI.FINDFIRST() then
            if TotalESIArrearAmount <= ESI."ESI Salary Amount" then begin
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", ESITxt);
                ProcessedSalary.SETRANGE("LOP Adjustment", false);
                ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                if ProcessedSalary.FINDFIRST() then begin
                    ProcessedSalary."Arrear Salary" := TotalESIArrearAmount;
                    ProcessedSalary."Arrears Not Posted" := true;
                    ProcessedSalary.MODIFY();
                    CheckDate := DMY2DATE(1, CheckMonth, CheckYear);
                    if ESI.FINDFIRST() then
                        repeat
                            if ESI."Effective Date" <= CheckDate then
                                case ESI."Rounding Method" of
                                    ESI."Rounding Method"::Nearest:
                                        begin
                                            EmployerContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employer %") / 100, ESI."Rounding Amount", '=');
                                            EmployeeContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employee %") / 100, ESI."Rounding Amount", '=');
                                        end;
                                    ESI."Rounding Method"::Up:
                                        begin
                                            EmployerContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employer %") / 100, ESI."Rounding Amount", '>');
                                            EmployeeContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employee %") / 100, ESI."Rounding Amount", '>');
                                        end;
                                    ESI."Rounding Method"::Down:
                                        begin
                                            EmployerContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employer %") / 100, ESI."Rounding Amount", '<');
                                            EmployeeContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employee %") / 100, ESI."Rounding Amount", '<');
                                        end;
                                end;

                        until ESI.NEXT() = 0;

                    ProcessedSalary."Arrear Co. Contribution" := EmployerContribution;
                    ProcessedSalary."Arrear Amount" := EmployeeContribution;
                    ProcessedSalary.MODIFY();
                end;
            end;

    end;

    procedure CalculatePFArrearAmount(ProcessedSalary: Record "Processed Salary B2B"; PayRevisionLine: Record "Pay Revision Line B2B"; CheckMonth: Integer; CheckYear: Integer);
    var
        Lookup_B2B: Record Lookup_B2B;
        EmployeeLocal: Record "Employee B2B";
        PRLine: Record "Pay Revision Line B2B";
        PF: Record PF_B2B;
        TotalPFArrearAmount: Decimal;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        EPSAmount: Decimal;
        CheckDate: Date;
        Grossamt: Decimal;
        GrossSalary: Decimal;

    begin
        PRLine.RESET();
        PRLine.SETRANGE("Header No.", "Id.");
        PRLine.SETRANGE(PRLine."Fixed / Percent", PRLine."Fixed / Percent"::Fixed);
        PRLine.SETFILTER(PRLine."Pay Element", '%1', BASICTxt);
        if not PRLine.IsEmpty() then begin
            ProcessedSalary.RESET();
            ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
            ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
            ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
            ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
            ProcessedSalary.SETRANGE(Posted, true);
            ProcessedSalary.SETRANGE("Arrears Not Posted", true);
            ProcessedSalary.SETRANGE("LOP Adjustment", false);
            ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
            if ProcessedSalary.FINDFIRST() then
                repeat
                    Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
                    Lookup_B2B.SETRANGE(PF, true);
                    Lookup_B2B.SETRANGE("Lookup Name", ProcessedSalary."Add/Deduct Code");
                    if not Lookup_B2B.IsEmpty() then begin
                        TotalPFArrearAmount := TotalPFArrearAmount + ProcessedSalary."Arrear Amount";
                        Grossamt := Grossamt + ProcessedSalary."Earned Amount";
                    end;
                until ProcessedSalary.NEXT() = 0;
            PF.RESET();
            PF.SETFILTER("Effective Date", '<=%1', DMY2DATE(1, CheckMonth, CheckYear));
            PF.FINDFIRST();
            if not (EmployeeLocal.GET(ProcessedSalary."Employee Code") and
              (EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::Statutory) and
              (Grossamt > PF."PF Amount")) then begin

                GrossSalary := Grossamt + TotalPFArrearAmount;

                if EmployeeLocal.GET(ProcessedSalary."Employee Code") and
                  (EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::Statutory) and
                  (GrossSalary > PF."PF Amount") then begin
                    GrossSalary := PF."PF Amount";
                    TotalPFArrearAmount := GrossSalary - Grossamt;
                end;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PFTxt);
                ProcessedSalary.SETRANGE("LOP Adjustment", false);
                ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                if ProcessedSalary.FINDFIRST() then begin
                    ProcessedSalary."Arrear Salary" := TotalPFArrearAmount;
                    ProcessedSalary."Arrears Not Posted" := true;
                    CheckDate := DMY2DATE(1, CheckMonth, CheckYear);
                    if PF.FINDFIRST() then
                        repeat
                            if PF."Effective Date" <= CheckDate then
                                if GrossSalary > PF."PF Amount" then begin
                                    if PF."Rounding Method" = PF."Rounding Method"::Nearest then begin
                                        EPSAmount := ROUND((GrossSalary * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                        EmployerContribution := ROUND((GrossSalary * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '=')
                                                                  - EPSAmount;
                                        EmployeeContribution := ROUND((GrossSalary * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                                    end;
                                    if PF."Rounding Method" = PF."Rounding Method"::Up then begin
                                        EPSAmount := ROUND((GrossSalary * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                        EmployerContribution := ROUND((GrossSalary * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '>')
                                                                  - EPSAmount;
                                        EmployeeContribution := ROUND((GrossSalary * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                                    end;
                                    if PF."Rounding Method" = PF."Rounding Method"::Down then begin
                                        EPSAmount := ROUND((GrossSalary * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                        EmployerContribution := ROUND((GrossSalary * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '<')
                                                                  - EPSAmount;
                                        EmployeeContribution := ROUND((GrossSalary * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                                    end;
                                end else begin
                                    if PF."Rounding Method" = PF."Rounding Method"::Nearest then begin
                                        EmployerContribution := ROUND((TotalPFArrearAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '=');
                                        EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                                        EPSAmount := ROUND((TotalPFArrearAmount * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                    end;
                                    if PF."Rounding Method" = PF."Rounding Method"::Up then begin
                                        EmployerContribution := ROUND((TotalPFArrearAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '>');
                                        EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                                        EPSAmount := ROUND((TotalPFArrearAmount * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                    end;
                                    if PF."Rounding Method" = PF."Rounding Method"::Down then begin
                                        EmployerContribution := ROUND((TotalPFArrearAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '<');
                                        EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                                        EPSAmount := ROUND((TotalPFArrearAmount * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                    end;
                                end;
                        until PF.NEXT() = 0;

                    if (EmployerContribution <> 0) and (EmployeeLocal."PF Applicability" <> EmployeeLocal."PF Applicability"::Statutory) then
                        ProcessedSalary."Arrear Co. Contribution" := EmployerContribution - ProcessedSalary."Co. Contributions";
                    if (EPSAmount <> 0) and (EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::Statutory) then
                        ProcessedSalary."Arrear Co. Contribution2" := EPSAmount - ProcessedSalary."Co. Contribution2";
                    if (EmployeeContribution <> 0) and (EmployeeLocal."PF Applicability" <> EmployeeLocal."PF Applicability"::Statutory) then
                        ProcessedSalary."Arrear Amount" := EmployeeContribution - ProcessedSalary."Earned Amount";

                    if (EmployerContribution <> 0) and ((EmployerContribution - ProcessedSalary."Co. Contributions") > 0) and (EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::Statutory) then
                        ProcessedSalary."Arrear Co. Contribution" := EmployerContribution - ProcessedSalary."Co. Contributions"
                    else
                        ProcessedSalary."Arrear Co. Contribution" := EmployerContribution;

                    if (EPSAmount <> 0) and ((EPSAmount - ProcessedSalary."Co. Contribution2") > 0) and (EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::Statutory) then
                        ProcessedSalary."Arrear Co. Contribution2" := EPSAmount - ProcessedSalary."Co. Contribution2"
                    else
                        ProcessedSalary."Arrear Co. Contribution2" := EPSAmount;

                    if (EmployeeContribution <> 0) and ((EmployeeContribution - ProcessedSalary."Earned Amount") > 0) and (EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::Statutory) then
                        ProcessedSalary."Arrear Amount" := EmployeeContribution - ProcessedSalary."Earned Amount"
                    else
                        ProcessedSalary."Arrear Amount" := EmployeeContribution;



                    /*if EmployerContribution > ProcessedSalary."Co. Contributions" then
                        ProcessedSalary."Arrear Co. Contribution" := EmployerContribution - ProcessedSalary."Co. Contributions"
                    else
                        ProcessedSalary."Arrear Co. Contribution" := 0;

                    if EPSAmount > ProcessedSalary."Co. Contribution2" then
                        ProcessedSalary."Arrear Co. Contribution2" := EPSAmount - ProcessedSalary."Co. Contribution2"
                    else
                        ProcessedSalary."Arrear Co. Contribution2" := 0;
                    if EmployeeContribution > ProcessedSalary."Earned Amount" then
                        ProcessedSalary."Arrear Amount" := EmployeeContribution - ProcessedSalary."Earned Amount"
                    else
                        ProcessedSalary."Arrear Amount" := 0;*/

                    ProcessedSalary.MODIFY();
                end;
            end;
        end;
    end;

    procedure CalculatePTArrearAmount(ProcessedSalary2: Record "Processed Salary B2B"; PayRevisionLine: Record "Pay Revision Line B2B"; CheckMonth: Integer; CheckYear: Integer);
    var
        Lookup_B2B: Record Lookup_B2B;
        PRLine: Record "Pay Revision Line B2B";
        PTLine: Record "Professional Tax Line B2B";
        TotalPTArrearAmount: Decimal;

        CheckDate: Date;
        Grossamt: Decimal;
        PreviousPT: Decimal;
        AfterPT: Decimal;
        ArrearPT: Decimal;
        PTAmount: Decimal;
        PTCode: Code[20];
        LineNum: Integer;
    begin
        ProcessedSalary2.RESET();
        ProcessedSalary2.SETRANGE("Employee Code", PayRevisionLine."No.");
        ProcessedSalary2.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
        ProcessedSalary2.SETFILTER(Year, '=%1', CheckYear);
        ProcessedSalary2.SETRANGE("Add/Deduct Code", PTTxt);
        ProcessedSalary2.SETFILTER("Arrear Amount", '<>%1', 0);
        ProcessedSalary2.SETRANGE("LOP Adjustment", false);
        if not ProcessedSalary2.FINDFIRST() then begin
            CLEAR(TotalPTArrearAmount);
            CLEAR(Grossamt);
            CLEAR(ArrearPT);
            CLEAR(PreviousPT);
            CLEAR(AfterPT);
            PRLine.RESET();
            PRLine.SETRANGE("Header No.", "Id.");
            PRLine.SETRANGE(PRLine."Fixed / Percent", PRLine."Fixed / Percent"::Fixed);
            PRLine.SETFILTER(PRLine."Pay Element", '%1', BASICTxt);
            if PRLine.FINDFIRST() then begin
                ProcessedSalary2.RESET();
                ProcessedSalary2.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary2.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                ProcessedSalary2.SETFILTER(Year, '=%1', CheckYear);
                ProcessedSalary2.SETRANGE("Add/Deduct", ProcessedSalary2."Add/Deduct"::Addition);
                ProcessedSalary2.SETRANGE(Posted, true);
                ProcessedSalary2.SETRANGE("LOP Adjustment", false);
                if ProcessedSalary2.FINDFIRST() then
                    repeat
                        Lookup_B2B.RESET();
                        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
                        Lookup_B2B.SETRANGE(PT, true);
                        Lookup_B2B.SETRANGE("Lookup Name", ProcessedSalary2."Add/Deduct Code");
                        if not Lookup_B2B.IsEmpty() then begin
                            TotalPTArrearAmount := TotalPTArrearAmount + ProcessedSalary2."Arrear Amount";
                            Grossamt := Grossamt + ProcessedSalary2."Earned Amount";
                        end;
                    until ProcessedSalary2.NEXT() = 0;
            end;
            ArrearPT := TotalPTArrearAmount + Grossamt;
            CLEAR(PTCode);
            Employee.RESET();
            Employee.SETRANGE("No.", PRLine."No.");
            if Employee.FINDFIRST() then
                PTCode := Employee."PT Branch Code";
            PTLine.RESET();
            PTLine.SETRANGE("Branch Code", PTCode);
            if PTLine.FINDFIRST() then
                repeat
                    if (Grossamt >= PTLine."Income From") and (Grossamt <= PTLine."Income To") then
                        PreviousPT := PTLine."Tax Amount";
                    if (ArrearPT >= PTLine."Income From") and (ArrearPT <= PTLine."Income To") then
                        AfterPT := PTLine."Tax Amount";
                until PTLine.NEXT() = 0;

            if PreviousPT <> AfterPT then begin
                PTAmount := AfterPT - PreviousPT;
                ProcessedSalary2.RESET();
                ProcessedSalary2.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary2.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                ProcessedSalary2.SETFILTER(Year, '=%1', CheckYear);
                ProcessedSalary2.SETRANGE(Posted, true);
                ProcessedSalary2.SETRANGE("Add/Deduct Code", PTTxt);
                ProcessedSalary2.SETRANGE("LOP Adjustment", false);
                ProcessedSalary2.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                if ProcessedSalary2.FINDFIRST() then begin
                    ProcessedSalary2."Arrear Salary" := PTAmount;
                    ProcessedSalary2."Arrears Not Posted" := true;
                    ProcessedSalary2.MODIFY();
                    CheckDate := DMY2DATE(1, CheckMonth, CheckYear);
                    ProcessedSalary2."Arrear Amount" := PTAmount;
                    ProcessedSalary2.MODIFY();
                end else
                    if PTAmount > 0 then begin
                        ProcessedSalary2.RESET();
                        ProcessedSalary2.SETRANGE("Employee Code", PayRevisionLine."No.");
                        ProcessedSalary2.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                        ProcessedSalary2.SETFILTER(Year, '=%1', CheckYear);
                        ProcessedSalary2.SETRANGE(Posted, true);
                        if ProcessedSalary2.FINDLAST() then
                            LineNum := ProcessedSalary2."Line No." + 10000;
                        ProcessedSalary2.INIT();
                        ProcessedSalary2."Document Type" := ProcessedSalary2."Document Type"::Payroll;
                        ProcessedSalary2."Employee Code" := PayRevisionLine."No.";
                        ProcessedSalary2."Pay Slip Month" := CheckMonth;
                        ProcessedSalary2.Year := CheckYear;
                        ProcessedSalary2."Line No." := LineNum;
                        ProcessedSalary2."Add/Deduct Code" := PTTxt;
                        ProcessedSalary2."Earned Amount" := 0;
                        ProcessedSalary2."Arrear Amount" := PTAmount;
                        ProcessedSalary2."Arrears Not Posted" := true;
                        ProcessedSalary2.Posted := true;
                        ProcessedSalary2.INSERT();
                    end;

            end;
        end;
    end;


    procedure UpdateArrearAmount(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Total: Decimal;
    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
        PayRevisionLine.RESET();
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                Total := 0;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PayRevisionLine."Pay Element");
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        Total := Total + ProcessedSalary."Arrear Amount";
                    until ProcessedSalary.NEXT() = 0;
                PayRevisionLine."Arrear Amount" := Total;
                PayRevisionLine.MODIFY();
            until PayRevisionLine.NEXT() = 0;
    end;

    procedure UpdateESIArrearAmount(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        ESITotal: Decimal;
        ESICoAmt: Decimal;
    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
        PayRevisionLine.RESET();
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                ESITotal := 0;
                ESICoAmt := 0;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", ESITxt);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        ESITotal := ESITotal + ProcessedSalary."Arrear Amount";
                        ESICoAmt := ESICoAmt + ProcessedSalary."Arrear Co. Contribution";
                    until ProcessedSalary.NEXT() = 0;
            until PayRevisionLine.NEXT() = 0;
        LineNoVar := 0;
        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        if PayRevisionLine.FINDLAST() then
            LineNoVar := PayRevisionLine."Line No." + 10000
        else
            LineNoVar := 10000;
        PayRevisionLine.INIT();
        PayRevisionLine."Header No." := PayRevisionHeader."Id.";
        PayRevisionLine."No." := PayRevisionHeader."No.";
        PayRevisionLine.Type := PayRevisionHeader.Type;
        PayRevisionLine."Line No." := LineNoVar;
        PayRevisionLine."Pay Element" := ESITxt;
        PayRevisionLine.Grade := PayElement."Pay Cadre";
        PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
        PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
        PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
        PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct"::Deduction;
        PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
        PayRevisionLine."Arrear Amount" := ESITotal;
        PayRevisionLine."Arrear Co. Contribution" := ESICoAmt;
        PayRevisionLine."Arrear Inserted" := true;
        PayRevisionLine.INSERT();
    end;

    procedure UpdatePFArrearAmount(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        PFTotal: Decimal;
        PFCoAmt: Decimal;
        PFCoAmt2: Decimal;

    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
        PayRevisionLine.RESET();
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                PFTotal := 0;
                PFCoAmt := 0;
                PFCoAmt2 := 0;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionHeader."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PFTxt);
                ProcessedSalary.SETRANGE("LOP Adjustment", false);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        PFTotal := PFTotal + ProcessedSalary."Arrear Amount";
                        PFCoAmt := PFCoAmt + ProcessedSalary."Arrear Co. Contribution";
                        PFCoAmt2 := PFCoAmt2 + ProcessedSalary."Arrear Co. Contribution2";
                    until ProcessedSalary.NEXT() = 0;
            until PayRevisionLine.NEXT() = 0;
        LineNoVar := 0;
        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        if PayRevisionLine.FINDLAST() then
            LineNoVar := PayRevisionLine."Line No." + 10000
        else
            LineNoVar := 10000;
        PayRevisionLine.INIT();
        PayRevisionLine."Header No." := PayRevisionHeader."Id.";
        PayRevisionLine."No." := PayRevisionHeader."No.";
        PayRevisionLine.Type := PayRevisionHeader.Type;
        PayRevisionLine."Line No." := LineNoVar;
        PayRevisionLine."Pay Element" := PFTxt;
        PayRevisionLine.Grade := PayElement."Pay Cadre";
        PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
        PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
        PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
        PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct"::Deduction;
        PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
        PayRevisionLine."Arrear Amount" := PFTotal;
        PayRevisionLine."Arrear Co. Contribution" := PFCoAmt;
        PayRevisionLine."Arrear Co. Contribution2" := PFCoAmt2;
        PayRevisionLine."Arrear Inserted" := true;
        PayRevisionLine.INSERT();
    end;

    procedure UpdatePTArrearAmount(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        PTTotal: Decimal;
        PTCoAmt: Decimal;

    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
        PayRevisionLine.RESET();
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                PTTotal := 0;
                PTCoAmt := 0;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PTTxt);
                ProcessedSalary.SETRANGE("LOP Adjustment", false);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        PTTotal := PTTotal + ProcessedSalary."Arrear Amount";
                        PTCoAmt := PTCoAmt + ProcessedSalary."Arrear Co. Contribution";
                    until ProcessedSalary.NEXT() = 0;
            until PayRevisionLine.NEXT() = 0;
        LineNoVar := 0;
        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        if PayRevisionLine.FINDLAST() then
            LineNoVar := PayRevisionLine."Line No." + 10000
        else
            LineNoVar := 10000;
        PayRevisionLine.INIT();
        PayRevisionLine."Header No." := PayRevisionHeader."Id.";
        PayRevisionLine."No." := PayRevisionHeader."No.";
        PayRevisionLine.Type := PayRevisionHeader.Type;
        PayRevisionLine."Line No." := LineNoVar;
        PayRevisionLine."Pay Element" := PTTxt;
        PayRevisionLine.Grade := PayElement."Pay Cadre";
        PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
        PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
        PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
        PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct"::Deduction;
        PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
        PayRevisionLine."Arrear Amount" := PTTotal;
        PayRevisionLine."Arrear Co. Contribution" := PTCoAmt;
        PayRevisionLine."Arrear Inserted" := true;
        PayRevisionLine.INSERT();
    end;

    procedure AssistEdit(OldPayrevision: Record "Pay Revision Header B2B"): Boolean;
    begin
        with PayRevision do begin
            PayRevision := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD("Pay Revision Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Pay Revision Nos.", OldPayrevision."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Pay Revision Nos.");
                NoSeriesMgt.SetSeries("Id.");
                Rec := PayRevision;
                exit(true);
            end;
        end;
    end;

    // procedure Attachments();
    // var
    //     Attachment : Record "HR Attachment-B2B";
    // begin
    //     Attachment.RESET();
    //     Attachment.SETRANGE("Table ID",DATABASE::"Employee B2B");
    //     Attachment.SETRANGE("Document No.","No.");
    //     PAGE.RUNMODAL(PAGE::HRAttachments_B2B,Attachment);
    // end;

    procedure CalculateNewlyAddedArrears(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevLineLRec: Record "Pay Revision Line B2B";
        ProcSal: Record "Processed Salary B2B";
        ProcSal3: Record "Processed Salary B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        MonAtt: Record "Monthly Attendance B2B";
        ProcSal2: Record "Processed Salary B2B";
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        LineNum: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        NoofDays: Decimal;
        MonthDays: Decimal;

    begin
        DA := 0;
        CheckMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CheckYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
        ProcSal3.RESET();
        ProcSal3.SETRANGE("Employee Code", PayRevisionHeader."No.");
        ProcSal3.SETFILTER("Pay Slip Month", '>=%1', CheckMonth);
        ProcSal3.SETFILTER(Year, '>=%1', CheckYear);
        ProcSal3.SETRANGE(Posted, true);
        ProcSal3.SETRANGE("Add/Deduct Code", BASICTxt);
        Procsal3.SETRANGE("LOP Adjustment", false);
        ProcSal3.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year);
        if ProcSal3.FINDFIRST() then
            repeat
                PayRevLineLRec.RESET();
                PayRevLineLRec.SETRANGE("Header No.", PayRevisionHeader."Id.");
                if PayRevLineLRec.FINDFIRST() then
                    repeat
                        ProcSal.RESET();
                        ProcSal.SETRANGE("Employee Code", PayRevLineLRec."No.");
                        ProcSal.SETRANGE("Pay Slip Month", ProcSal3."Pay Slip Month");
                        ProcSal.SETRANGE(Year, ProcSal3.Year);
                        ProcSal.SETRANGE("Add/Deduct Code", PayRevLineLRec."Pay Element");
                        Procsal.SETRANGE("LOP Adjustment", false);
                        if not ProcSal.FINDFIRST() then begin
                            MonAtt.RESET();
                            MonAtt.SETRANGE("Employee Code", PayRevLineLRec."No.");
                            MonAtt.SETRANGE("Pay Slip Month", CheckMonth);
                            MonAtt.SETRANGE(Year, CheckYear);
                            if MonAtt.FINDFIRST() then begin
                                MonAtt.CALCFIELDS(Attendance, MonAtt.Leaves, Days, MonAtt.Holidays);
                                CLEAR(NoofDays);
                                CLEAR(MonthDays);
                                //NoofDays := MonAtt.Attendance + MonAtt.Leaves; 
                                if ((Date2dmy(PayRevLineLRec."Effective Date", 2) = ProcSal3."Pay Slip Month") and
                                    (Date2dmy(PayRevLineLRec."Effective Date", 3) = ProcSal3.Year)) then begin
                                    DailyAttendance.RESET();
                                    DailyAttendance.SETRANGE("Employee No.", PayRevisionHeader."No.");
                                    DailyAttendance.SETRANGE(Date, PayRevisionHeader."Effective Date", CALCDATE(CMExprLbl, PayRevisionHeader."Effective Date"));
                                    DailyAttendance.SETFILTER("Attendance Type", '<>%1', DailyAttendance."Attendance Type"::Absent);
                                    IF DailyAttendance.FINDFIRST() THEN
                                        REPEAT
                                            NoofDays := NoofDays + 1;
                                        UNTIL DailyAttendance.NEXT() = 0;
                                    //NoofDays := MonAtt.Attendance - (Date2dmy(PayRevLineLRec."Effective Date",1))+1
                                end else
                                    //NoofDays := MonAtt.Attendance + MonAtt.Holidays;
                                    NoofDays := MonAtt.Attendance + MonAtt."Loss Of Pay";
                                MonthDays := MonAtt.Days;
                            end;
                            if PayRevLineLRec."Pay Element" = BASICTxt then begin
                                if (PayRevLineLRec."Revised Computation Type" = OnAttTxt) then begin
                                    Total := (NoofDays / MonthDays) * PayRevLineLRec."Revised Amount / Percent";
                                    Basic := Total;
                                end else
                                    if (PayRevLineLRec."Revised Computation Type" = NonAttTxt) then begin
                                        Total := PayRevLineLRec."Revised Amount / Percent";
                                        Basic := Total;
                                    end;
                            end else
                                if (PayRevLineLRec."Revised Fixed / Percent" = PayRevLineLRec."Revised Fixed / Percent"::Fixed) then begin
                                    if (PayRevLineLRec."Revised Computation Type" = OnAttTxt) then
                                        Total := (NoofDays / MonthDays) * PayRevLineLRec."Revised Amount / Percent"
                                    else
                                        Total := PayRevLineLRec."Revised Amount / Percent";
                                end else
                                    if (PayRevLineLRec."Revised Fixed / Percent" = PayRevLineLRec."Revised Fixed / Percent"::Percent) and
                                       (PayRevLineLRec."Revised Computation Type" = AFTERBASICTxt)
                           then
                                        Total := (PayRevLineLRec."Revised Amount / Percent" * Basic) / 100
                                    else
                                        if (PayRevLineLRec."Revised Fixed / Percent" = PayRevLineLRec."Revised Fixed / Percent"::Percent) and
                                           (PayRevLineLRec."Revised Computation Type" = AFTERBASICANDDATxt)
                                   then
                                            Total := (PayRevLineLRec."Revised Amount / Percent" * (Basic + DA)) / 100;

                            if PayRevLineLRec."Pay Element" = DATxt then
                                DA := Total;

                            PayRevLineLRec."Arrear Inserted" := true;
                            PayRevLineLRec.MODIFY();

                            ProcSal2.RESET();
                            ProcSal2.SETRANGE("Employee Code", PayRevLineLRec."No.");
                            ProcSal2.SETRANGE("Pay Slip Month", ProcSal."Pay Slip Month");
                            ProcSal2.SETRANGE(Year, ProcSal.Year);
                            ProcSal2.SETRANGE(Posted, true);
                            if ProcSal2.FINDLAST() then begin
                                LineNum := ProcSal2."Line No." + 10000;
                                ProcSal2.INIT();
                                ProcSal2."Document Type" := ProcSal2."Document Type"::Payroll;
                                ProcSal2."Employee Code" := PayRevLineLRec."No.";
                                ProcSal2."Pay Slip Month" := ProcSal."Pay Slip Month";
                                ProcSal2.Year := ProcSal.Year;
                                ProcSal2."Line No." := LineNum;
                                ProcSal2."Arrear Amount" := Total;
                                ProcSal2."Add/Deduct Code" := PayRevLineLRec."Pay Element";
                                ProcSal2."Fixed/Percent" := PayRevLineLRec."Revised Fixed / Percent";
                                ProcSal2."Computation Type" := PayRevLineLRec."Revised Computation Type";
                                ProcSal2."Add/Deduct" := PayRevLineLRec."Add/Deduct";
                                ProcSal2.Days := ProcSal.Days;
                                ProcSal2.Posted := true;
                                ProcSal2."Arrears Not Posted" := true;
                                ProcSal2.INSERT();
                            end;
                        end;
                    until PayRevLineLRec.NEXT() = 0;
            until ProcSal3.NEXT() = 0;
    end;

    procedure GetAllEmpPayElements(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        CheckDate: Date;
    begin
        if HRSetup.FINDFIRST() then
            CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");

        if PayRevisionHeader.Type = PayRevisionHeader.Type::All then begin
            PayElement.Reset();
            PayElement.SETFILTER("Effective Start Date", '<=%1', CheckDate);
            PayElement.SETRANGE(PayElement.Processed, false);
            if PayElement.FINDFIRST() then
                repeat
                    PayElement2.Reset();
                    PayElement2.SETRANGE("Employee Code", PayElement."Employee Code");
                    PayElement2.SETRANGE(PayElement2.Processed, false);
                    PayElement2.SETRANGE("Pay Element Code", PayElement."Pay Element Code");
                    if PayElement2.FINDFIRST() then begin
                        repeat
                            PayElement2.Processed := true;
                            PayElement2.MODIFY();
                            if PayElement2."Effective Start Date" <= CheckDate then begin
                                PayRevisionLine."Header No." := PayRevisionHeader."Id.";
                                PayRevisionLine."No." := PayElement2."Employee Code";
                                PayRevisionLine.Type := PayRevisionLine.Type::All;
                                PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
                                PayRevisionLine."Pay Element" := PayElement2."Pay Element Code";
                                PayRevisionLine."Fixed / Percent" := PayElement2."Fixed/Percent";
                                PayRevisionLine."Amount / Percent" := PayElement2."Amount / Percent";
                                PayRevisionLine."Computation Type" := PayElement2."Computation Type";
                                PayRevisionLine."Starting Date" := PayElement2."Effective Start Date";
                                PayRevisionLine.Grade := PayElement."Pay Cadre";
                                PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
                                PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
                                PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
                                if PayRevisionLine."Effective Date" <> 0D then begin
                                    PayRevisionLine.Month := DATE2DMY(PayRevisionLine."Effective Date", 2);
                                    PayRevisionLine.Year := DATE2DMY(PayRevisionLine."Effective Date", 3);
                                end;
                                PayRevisionLine."Revised Amount / Percent" := PayElement2."Amount / Percent";
                                PayRevisionLine."Revised Fixed / Percent" := PayElement2."Fixed/Percent";
                                PayRevisionLine."Revised Computation Type" := PayElement2."Computation Type";
                                PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct";
                                PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
                            end;
                        until PayElement2.NEXT() = 0;
                        if PayRevisionLine."Amount / Percent" <> 0 then
                            PayRevisionLine.INSERT();

                    end;
                until PayElement.NEXT() = 0;

        end;
    end;

    procedure CalculateArrearAmountNew(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        ProcessedSalary: Record "Processed Salary B2B";
        PayRevisionLine: Record "Pay Revision Line B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        ProcessedSalary2: Record "Processed Salary B2B";
        ProcessedSalary3: Record "Processed Salary B2B";
        MonAtt: Record "Monthly Attendance B2B";
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        NoofDays: Decimal;
        MonthDays: Decimal;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        EndMonth: Integer;
        EndYear: Integer;
        EffectDays: Integer;

    begin
        DA := 0;
        if PayRevisionHeader."Caluclate For Entire Month" then begin
            CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
            CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
            ProcessedSalary.SETRANGE("Employee Code", PayRevisionHeader."No.");
            ProcessedSalary.SETRANGE(ProcessedSalary."Pay Slip Month", CurrentMonth);
            ProcessedSalary.SETRANGE(ProcessedSalary.Year, CurrentYear);
            if ProcessedSalary.FINDFIRST() then begin
                NoofDays := ProcessedSalary.Attendance;
                MonthDays := ProcessedSalary.Days;
            end else
                ERROR(Text002Lbl);
            ProcessedSalary2.RESET();
            ProcessedSalary2.SETRANGE("Employee Code", PayRevisionHeader."No.");
            ProcessedSalary2.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
            ProcessedSalary2.SETFILTER(Year, '>=%1', CurrentYear);
            ProcessedSalary2.SETRANGE(Posted, true);
            ProcessedSalary2.SETRANGE("Add/Deduct Code", BASICTxt);
            ProcessedSalary2.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year);
            if ProcessedSalary2.FINDFIRST() then
                repeat
                    ProcessedSalary3.RESET();
                    ProcessedSalary3.SETRANGE("Employee Code", ProcessedSalary2."Employee Code");
                    ProcessedSalary3.SETRANGE("Pay Slip Month", ProcessedSalary2."Pay Slip Month");
                    ProcessedSalary3.SETRANGE(Year, ProcessedSalary2.Year);
                    ProcessedSalary3.SETRANGE(Posted, true);
                    if ProcessedSalary3.FINDFIRST() then
                        repeat
                            MonAtt.RESET();
                            MonAtt.SETRANGE("Employee Code", ProcessedSalary3."Employee Code");
                            MonAtt.SETRANGE("Pay Slip Month", ProcessedSalary3."Pay Slip Month");
                            MonAtt.SETRANGE(Year, ProcessedSalary3.Year);
                            if MonAtt.FINDFIRST() then begin
                                MonAtt.CALCFIELDS(Attendance, MonAtt.Leaves, Days, MonAtt.Holidays);
                                CLEAR(NoofDays);
                                CLEAR(MonthDays);
                                //NoofDays := MonAtt.Attendance + MonAtt.Leaves;
                                //NoofDays := MonAtt.Attendance + MonAtt.Holidays;
                                NoofDays := MonAtt.Attendance + MonAtt."Loss Of Pay";

                                MonthDays := MonAtt.Days;
                            end;
                            PayRevisionLine.RESET();
                            PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
                            PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::All);
                            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
                            PayRevisionLine.SETRANGE("No.", ProcessedSalary3."Employee Code");
                            PayRevisionLine.SETRANGE("Pay Element", ProcessedSalary3."Add/Deduct Code");
                            if PayRevisionLine.FINDFIRST() then
                                repeat
                                    if PayRevisionLine."Pay Element" = BASICTxt then begin
                                        if (PayRevisionLine."Revised Computation Type" = OnAttTxt) then begin
                                            Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent";
                                            Basic := Total;
                                        end else
                                            if (PayRevisionLine."Revised Computation Type" = NonAttTxt) then begin
                                                Total := PayRevisionLine."Revised Amount / Percent";
                                                Basic := Total;
                                            end;
                                    end else
                                        if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Fixed) then begin
                                            if (PayRevisionLine."Revised Computation Type" = OnAttTxt) then
                                                Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent"
                                            else
                                                Total := PayRevisionLine."Revised Amount / Percent";
                                        end else
                                            if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) and
                                               (PayRevisionLine."Revised Computation Type" = AFTERBASICTxt)
                                   then
                                                Total := (PayRevisionLine."Revised Amount / Percent" * Basic) / 100
                                            else
                                                if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) and
                                                   (PayRevisionLine."Revised Computation Type" = AFTERBASICANDDATxt)
                                           then
                                                    Total := (PayRevisionLine."Revised Amount / Percent" * (Basic + DA)) / 100;

                                    if PayRevisionLine."Pay Element" = DATxt then
                                        DA := Total;

                                    ProcessedSalary3."Arrear Amount" := ROUND((Total - ProcessedSalary3."Earned Amount"), 1, '=');
                                    ProcessedSalary3."Arrears Not Posted" := true;
                                    ProcessedSalary3.MODIFY();
                                    PayRevisionLine."Arrear Inserted" := true;
                                    PayRevisionLine.MODIFY();
                                    ProcessedSalary.RESET();
                                    ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                                    ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                                    ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                                    ProcessedSalary.SETRANGE(Posted, true);
                                    ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                                    if ProcessedSalary.FINDLAST() then begin
                                        EndMonth := ProcessedSalary."Pay Slip Month";
                                        EndYear := ProcessedSalary.Year;
                                    end;

                                    CheckMonth := CurrentMonth;
                                    CheckYear := CurrentYear;
                                    repeat
                                        if PayRevisionLine."Arrear Inserted" = false then begin
                                            ProcessedSalary.INIT();
                                            ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                                            ProcessedSalary."Employee Code" := PayRevisionLine."No.";
                                            ProcessedSalary."Pay Slip Month" := CheckMonth;
                                            ProcessedSalary.Year := CheckYear;
                                            ProcessedSalary."Line No." := ProcessedSalary."Line No." + 100000;
                                            ProcessedSalary."Arrear Amount" := Total;
                                            ProcessedSalary."Add/Deduct Code" := PayRevisionLine."Pay Element";
                                            ProcessedSalary."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                                            ProcessedSalary."Computation Type" := PayRevisionLine."Revised Computation Type";
                                            ProcessedSalary."Add/Deduct" := PayRevisionLine."Add/Deduct";
                                            ProcessedSalary."Arrears Not Posted" := true;
                                            ProcessedSalary.INSERT();
                                        end;
                                        CalculateESIArrearAmountNew(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                        CalculatePTArrearAmountNew(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                        if Employee.GET(PayRevisionLine."No.") and (Employee."PF Applicability" <> Employee."PF Applicability"::"Employee Specific")
                                        then
                                            CalculatePFArrearAmountNew(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                        CheckMonth := CheckMonth + 1;
                                        if CheckMonth = 13 then begin
                                            CheckMonth := 1;
                                            CheckYear := CheckYear + 1;
                                        end;
                                    until ((CheckMonth > EndMonth) and (CheckYear = EndYear)) or (CheckYear > EndYear);
                                until PayRevisionLine.NEXT() = 0;
                        until ProcessedSalary3.NEXT() = 0;

                until ProcessedSalary2.NEXT() = 0;
        end else
            if PayRevisionHeader."Caluclate From Effective Date" then begin
                CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
                CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionHeader."No.");
                ProcessedSalary.SETRANGE("Pay Slip Month", CurrentMonth);
                ProcessedSalary.SETRANGE(Year, CurrentYear);
                if ProcessedSalary.FINDFIRST() then begin
                    CLEAR(EffectDays);
                    EffectDays := (CALCDATE(CMExprLbl, PayRevisionHeader."Effective Date") - PayRevisionHeader."Effective Date") + 1;
                    MonthDays := EffectDays;
                    if ProcessedSalary.Days = ProcessedSalary.Attendance then
                        NoofDays := EffectDays
                    else begin
                        DailyAttendance.RESET();
                        DailyAttendance.SETRANGE("Employee No.", PayRevisionHeader."No.");
                        DailyAttendance.SETRANGE(Date, PayRevisionHeader."Effective Date", CALCDATE(CMExprLbl, PayRevisionHeader."Effective Date"));
                        DailyAttendance.SETFILTER("Attendance Type", '<>%1', DailyAttendance."Attendance Type"::Absent);
                        if DailyAttendance.FINDFIRST() then
                            repeat
                                NoofDays := NoofDays + 1;
                            until DailyAttendance.NEXT() = 0;
                    end
                end else
                    ERROR(Text002Lbl);
                ProcessedSalary2.RESET();
                ProcessedSalary2.SETRANGE("Employee Code", PayRevisionHeader."No.");
                ProcessedSalary2.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary2.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary2.SETRANGE(Posted, true);
                ProcessedSalary2.SETRANGE("Add/Deduct Code", BASICTxt);
                if ProcessedSalary2.FINDFIRST() then
                    repeat
                        ProcessedSalary3.RESET();
                        ProcessedSalary3.SETRANGE("Employee Code", PayRevisionHeader."No.");
                        ProcessedSalary3.SETRANGE("Pay Slip Month", ProcessedSalary2."Pay Slip Month");
                        ProcessedSalary3.SETRANGE(Year, ProcessedSalary2.Year);
                        ProcessedSalary3.SETRANGE(Posted, true);
                        if ProcessedSalary3.FINDFIRST() then
                            repeat
                                if (ProcessedSalary3."Pay Slip Month" = CurrentMonth) and (ProcessedSalary3.Year = CurrentYear) then begin
                                    CLEAR(EffectDays);
                                    CLEAR(NoofDays);
                                    CLEAR(MonthDays);
                                    EffectDays := (CALCDATE(CMExprLbl, PayRevisionHeader."Effective Date") - PayRevisionHeader."Effective Date") + 1;
                                    MonthDays := EffectDays;
                                    if ProcessedSalary3.Days = ProcessedSalary3.Attendance then
                                        NoofDays := EffectDays
                                    else begin
                                        DailyAttendance.RESET();
                                        DailyAttendance.SETRANGE("Employee No.", PayRevisionHeader."No.");
                                        DailyAttendance.SETRANGE(Date, PayRevisionHeader."Effective Date", CALCDATE(CMExprLbl, PayRevisionHeader."Effective Date"));
                                        DailyAttendance.SETFILTER("Attendance Type", '<>%1', DailyAttendance."Attendance Type"::Absent);
                                        if DailyAttendance.FINDFIRST() then
                                            repeat
                                                NoofDays := NoofDays + 1;
                                            until DailyAttendance.NEXT() = 0;
                                    end;
                                end else begin
                                    CLEAR(NoofDays);
                                    CLEAR(MonthDays);
                                    MonAtt.RESET();
                                    MonAtt.SETRANGE("Employee Code", ProcessedSalary3."Employee Code");
                                    MonAtt.SETRANGE("Pay Slip Month", ProcessedSalary3."Pay Slip Month");
                                    MonAtt.SETRANGE(Year, ProcessedSalary3.Year);
                                    if MonAtt.FINDFIRST() then begin
                                        MonAtt.CALCFIELDS(Attendance, MonAtt.Leaves, Days, MonAtt.Holidays);
                                        //NoofDays := MonAtt.Attendance + MonAtt.Leaves;
                                        NoofDays := MonAtt.Attendance + MonAtt."Loss Of Pay";
                                        MonthDays := MonAtt.Days;
                                    end;
                                end;
                                PayRevisionLine.RESET();
                                PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
                                PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::All);
                                PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
                                PayRevisionLine.SETRANGE("No.", ProcessedSalary3."Employee Code");
                                PayRevisionLine.SETRANGE("Pay Element", ProcessedSalary3."Add/Deduct Code");
                                if PayRevisionLine.FINDFIRST() then
                                    repeat
                                        if PayRevisionLine."Pay Element" = BASICTxt then begin
                                            if (PayRevisionLine."Revised Computation Type" = OnAttTxt) then begin
                                                if (ProcessedSalary3."Pay Slip Month" = CurrentMonth) and (ProcessedSalary3.Year = CurrentYear) then
                                                    Total := NoofDays * (PayRevisionLine."Revised Amount / Percent" / ProcessedSalary3.Days)
                                                else
                                                    Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent";
                                                Basic := Total;
                                            end else
                                                if (PayRevisionLine."Revised Computation Type" = NonAttTxt) then begin
                                                    Total := PayRevisionLine."Revised Amount / Percent";
                                                    Basic := Total;
                                                end;
                                        end else
                                            if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Fixed) then begin
                                                if (PayRevisionLine."Revised Computation Type" = OnAttTxt) then begin
                                                    if (ProcessedSalary3."Pay Slip Month" = CurrentMonth) and (ProcessedSalary3.Year = CurrentYear) then
                                                        Total := NoofDays * (PayRevisionLine."Revised Amount / Percent" / ProcessedSalary3.Days)
                                                    else
                                                        Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent"
                                                end else
                                                    Total := PayRevisionLine."Revised Amount / Percent";
                                            end else
                                                if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) and
                                                   (PayRevisionLine."Revised Computation Type" = AFTERBASICTxt)
                                       then
                                                    Total := (PayRevisionLine."Revised Amount / Percent" * Basic) / 100
                                                else
                                                    if (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) and
                                                       (PayRevisionLine."Revised Computation Type" = AFTERBASICANDDATxt)
                                               then
                                                        Total := (PayRevisionLine."Revised Amount / Percent" * (Basic + DA)) / 100;

                                        if PayRevisionLine."Pay Element" = DATxt then
                                            DA := Total;
                                        if (ProcessedSalary3."Pay Slip Month" = CurrentMonth) and (ProcessedSalary3.Year = CurrentYear) then
                                            ProcessedSalary3."Arrear Amount" := Total - (NoofDays * (ProcessedSalary3."Earned Amount" / ProcessedSalary3.Days))
                                        else
                                            ProcessedSalary3."Arrear Amount" := (Total - ProcessedSalary3."Earned Amount");
                                        ProcessedSalary3."Arrears Not Posted" := true;
                                        ProcessedSalary3.MODIFY();
                                        PayRevisionLine."Arrear Inserted" := true;
                                        PayRevisionLine.MODIFY();
                                        ProcessedSalary.RESET();
                                        ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                                        ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                                        ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                                        ProcessedSalary.SETRANGE(Posted, true);
                                        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                                        if ProcessedSalary.FINDLAST() then begin
                                            EndMonth := ProcessedSalary."Pay Slip Month";
                                            EndYear := ProcessedSalary.Year;
                                        end;
                                        CheckMonth := CurrentMonth;
                                        CheckYear := CurrentYear;
                                        repeat
                                            if PayRevisionLine."Arrear Inserted" = false then begin
                                                ProcessedSalary.INIT();
                                                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                                                ProcessedSalary."Employee Code" := PayRevisionLine."No.";
                                                ProcessedSalary."Pay Slip Month" := CheckMonth;
                                                ProcessedSalary.Year := CheckYear;
                                                ProcessedSalary."Line No." := ProcessedSalary."Line No." + 10000;
                                                ProcessedSalary."Arrear Amount" := Total;
                                                ProcessedSalary."Add/Deduct Code" := PayRevisionLine."Pay Element";
                                                ProcessedSalary."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                                                ProcessedSalary."Computation Type" := PayRevisionLine."Revised Computation Type";
                                                ProcessedSalary."Add/Deduct" := PayRevisionLine."Add/Deduct";
                                                ProcessedSalary."Arrears Not Posted" := true;
                                                ProcessedSalary.INSERT();
                                            end;
                                            CalculateESIArrearAmountNew(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                            CalculatePTArrearAmountNew(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                            if Employee.GET(PayRevisionLine."No.") and (Employee."PF Applicability" <> Employee."PF Applicability"::
                                            "Employee Specific")
                                            then
                                                CalculatePFArrearAmountNew(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                                            CheckMonth := CheckMonth + 1;
                                            if CheckMonth = 13 then begin
                                                CheckMonth := 1;
                                                CheckYear := CheckYear + 1;
                                            end;
                                        until ((CheckMonth > EndMonth) and (CheckYear = EndYear)) or (CheckYear > EndYear);
                                    until PayRevisionLine.NEXT() = 0;
                            until ProcessedSalary3.NEXT() = 0;

                    until ProcessedSalary2.NEXT() = 0
            end else
                ERROR(Text003Lbl);
    end;

    procedure CalculateESIArrearAmountNew(ProcessedSalary: Record "Processed Salary B2B"; PayRevisionLine: Record "Pay Revision Line B2B"; CheckMonth: Integer; CheckYear: Integer);
    var
        Lookup_B2B: Record Lookup_B2B;
        ESI: Record ESI_B2B;
        TotalESIArrearAmount: Decimal;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        CheckDate: Date;
    begin
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
        ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
        ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
        ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
        ProcessedSalary.SETRANGE(Posted, true);
        ProcessedSalary.SETRANGE("Arrears Not Posted", true);
        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
        if ProcessedSalary.FINDFIRST() then
            repeat
                Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
                Lookup_B2B.SETFILTER(ESI, '<>%1', Lookup_B2B.ESI::" ");
                Lookup_B2B.SETRANGE("Lookup Name", ProcessedSalary."Add/Deduct Code");
                if not Lookup_B2B.IsEmpty() then
                    TotalESIArrearAmount := TotalESIArrearAmount + ProcessedSalary."Arrear Amount";
            until ProcessedSalary.NEXT() = 0;
        if ESI.FINDFIRST() then
            if TotalESIArrearAmount <= ESI."ESI Salary Amount" then begin
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", ESITxt);
                ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                if ProcessedSalary.FINDFIRST() then begin
                    ProcessedSalary."Arrear Salary" := TotalESIArrearAmount;
                    ProcessedSalary."Arrears Not Posted" := true;
                    ProcessedSalary.MODIFY();
                    CheckDate := DMY2DATE(1, CheckMonth, CheckYear);
                    if ESI.FINDFIRST() then
                        repeat
                            if ESI."Effective Date" <= CheckDate then begin
                                if ESI."Rounding Method" = ESI."Rounding Method"::Nearest then begin
                                    EmployerContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employer %") / 100, ESI."Rounding Amount", '=');
                                    EmployeeContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employee %") / 100, ESI."Rounding Amount", '=');
                                end;
                                if ESI."Rounding Method" = ESI."Rounding Method"::Up then begin
                                    EmployerContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employer %") / 100, ESI."Rounding Amount", '>');
                                    EmployeeContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employee %") / 100, ESI."Rounding Amount", '>');
                                end;
                                if ESI."Rounding Method" = ESI."Rounding Method"::Down then begin
                                    EmployerContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employer %") / 100, ESI."Rounding Amount", '<');
                                    EmployeeContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employee %") / 100, ESI."Rounding Amount", '<');
                                end;
                            end;
                        until ESI.NEXT() = 0;

                    ProcessedSalary."Arrear Co. Contribution" := EmployerContribution;
                    ProcessedSalary."Arrear Amount" := EmployeeContribution;
                    ProcessedSalary.MODIFY();
                end;
            end;

    end;

    procedure CalculatePFArrearAmountNew(ProcessedSalary: Record "Processed Salary B2B"; PayRevisionLine: Record "Pay Revision Line B2B"; CheckMonth: Integer; CheckYear: Integer);
    var
        Lookup_B2B: Record Lookup_B2B;
        EmployeeLocal: Record "Employee B2B";
        PRLine: Record "Pay Revision Line B2B";
        PF: Record PF_B2B;
        TotalPFArrearAmount: Decimal;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        EPSAmount: Decimal;
        CheckDate: Date;
        Grossamt: Decimal;
        GrossSalary: Decimal;
    begin
        PRLine.RESET();
        PRLine.SETRANGE("Header No.", "Id.");
        PRLine.SETRANGE(PRLine."Fixed / Percent", PRLine."Fixed / Percent"::Fixed);
        PRLine.SETFILTER(PRLine."Pay Element", '%1', BASICTxt);
        if not PRLine.IsEmpty() then begin
            ProcessedSalary.RESET();
            ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
            ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
            ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
            ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
            ProcessedSalary.SETRANGE(Posted, true);
            ProcessedSalary.SETRANGE("Arrears Not Posted", true);
            ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
            if ProcessedSalary.FINDFIRST() then
                repeat
                    Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
                    Lookup_B2B.SETRANGE(PF, true);
                    Lookup_B2B.SETRANGE("Lookup Name", ProcessedSalary."Add/Deduct Code");
                    if not Lookup_B2B.IsEmpty() then begin
                        TotalPFArrearAmount := TotalPFArrearAmount + ProcessedSalary."Arrear Amount";
                        Grossamt := Grossamt + ProcessedSalary."Earned Amount";
                    end;
                until ProcessedSalary.NEXT() = 0;
            PF.RESET();
            PF.SETFILTER("Effective Date", '<%1', DMY2DATE(1, CheckMonth, CheckYear));
            PF.FINDFIRST();
            if not (EmployeeLocal.GET(ProcessedSalary."Employee Code") and
              (EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::Statutory) and
              (Grossamt > PF."PF Amount")) then begin

                GrossSalary := Grossamt + TotalPFArrearAmount;
                if EmployeeLocal.GET(ProcessedSalary."Employee Code") and
                  (EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::Statutory) and
                  (GrossSalary > PF."PF Amount") then begin
                    GrossSalary := PF."PF Amount";
                    TotalPFArrearAmount := GrossSalary - Grossamt;
                end;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PFTxt);
                ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                if ProcessedSalary.FINDFIRST() then begin
                    ProcessedSalary."Arrear Salary" := TotalPFArrearAmount;
                    ProcessedSalary."Arrears Not Posted" := true;
                    CheckDate := DMY2DATE(1, CheckMonth, CheckYear);
                    if PF.FINDFIRST() then
                        repeat
                            if PF."Effective Date" <= CheckDate then
                                if GrossSalary > PF."PF Amount" then begin
                                    if PF."Rounding Method" = PF."Rounding Method"::Nearest then begin
                                        EmployerContribution := ROUND(((PF."PF Amount" - ProcessedSalary.Salary) * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                        EmployeeContribution := ROUND((PF."PF Amount" * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                                        EPSAmount := ROUND((((ProcessedSalary."Arrear Salary" * (PF."Employer Contribution" + PF."EPS %")) / 100)
                                                          - ProcessedSalary."Arrear Co. Contribution2"), PF."Rounding Amount", '=');
                                    end;
                                    if PF."Rounding Method" = PF."Rounding Method"::Up then begin
                                        EmployerContribution := ROUND(((PF."PF Amount" - ProcessedSalary.Salary) * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                        EmployeeContribution := ROUND((PF."PF Amount" * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                                        EPSAmount := ROUND((((ProcessedSalary."Arrear Salary" * (PF."Employer Contribution" + PF."EPS %")) / 100)
                                                         - ProcessedSalary."Arrear Co. Contribution2"), PF."Rounding Amount", '>');
                                    end;
                                    if PF."Rounding Method" = PF."Rounding Method"::Down then begin
                                        EmployerContribution := ROUND(((PF."PF Amount" - ProcessedSalary.Salary) * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                        EmployeeContribution := ROUND((PF."PF Amount" * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                                        EPSAmount := ROUND((((ProcessedSalary."Arrear Salary" * (PF."Employer Contribution" + PF."EPS %")) / 100)
                                                          - ProcessedSalary."Arrear Co. Contribution2"), PF."Rounding Amount", '<');
                                    end;
                                end else begin
                                    if PF."Rounding Method" = PF."Rounding Method"::Nearest then begin
                                        EmployerContribution := ROUND((TotalPFArrearAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '=');
                                        EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                                        EPSAmount := ROUND((TotalPFArrearAmount * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                    end;
                                    if PF."Rounding Method" = PF."Rounding Method"::Up then begin
                                        EmployerContribution := ROUND((TotalPFArrearAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '>');
                                        EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                                        EPSAmount := ROUND((TotalPFArrearAmount * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                    end;
                                    if PF."Rounding Method" = PF."Rounding Method"::Down then begin
                                        EmployerContribution := ROUND((TotalPFArrearAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '<');
                                        EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                                        EPSAmount := ROUND((TotalPFArrearAmount * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                    end;
                                end;
                        until PF.NEXT() = 0;

                    ProcessedSalary."Arrear Co. Contribution" := EmployerContribution;
                    ProcessedSalary."Arrear Co. Contribution2" := EPSAmount;
                    ProcessedSalary."Arrear Amount" := EmployeeContribution;
                    ProcessedSalary.MODIFY();
                end;
            end;
        end;
    end;

    procedure CalculatePTArrearAmountNew(ProcessedSalary2: Record "Processed Salary B2B"; PayRevisionLine: Record "Pay Revision Line B2B"; CheckMonth: Integer; CheckYear: Integer);
    var
        Lookup_B2B: Record Lookup_B2B;
        PRLine: Record "Pay Revision Line B2B";
        PTLine: Record "Professional Tax Line B2B";
        TotalPTArrearAmount: Decimal;
        CheckDate: Date;
        Grossamt: Decimal;
        PreviousPT: Decimal;
        AfterPT: Decimal;
        ArrearPT: Decimal;
        PTAmount: Decimal;
        PTCode: Code[20];
        LineNum: Integer;
    begin
        ProcessedSalary2.RESET();
        ProcessedSalary2.SETRANGE("Employee Code", PayRevisionLine."No.");
        ProcessedSalary2.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
        ProcessedSalary2.SETFILTER(Year, '=%1', CheckYear);
        ProcessedSalary2.SETRANGE("Add/Deduct Code", PTTxt);
        ProcessedSalary2.SETFILTER("Arrear Amount", '<>%1', 0);
        if not ProcessedSalary2.FINDFIRST() then begin
            CLEAR(TotalPTArrearAmount);
            CLEAR(Grossamt);
            CLEAR(ArrearPT);
            CLEAR(PreviousPT);
            CLEAR(AfterPT);
            PRLine.RESET();
            PRLine.SETRANGE("Header No.", "Id.");
            PRLine.SETRANGE(PRLine."Fixed / Percent", PRLine."Fixed / Percent"::Fixed);
            PRLine.SETFILTER(PRLine."Pay Element", '%1', BASICTxt);
            if PRLine.FINDFIRST() then begin
                ProcessedSalary2.RESET();
                ProcessedSalary2.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary2.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                ProcessedSalary2.SETFILTER(Year, '=%1', CheckYear);
                ProcessedSalary2.SETRANGE("Add/Deduct", ProcessedSalary2."Add/Deduct"::Addition);
                ProcessedSalary2.SETRANGE(Posted, true);
                if ProcessedSalary2.FINDFIRST() then
                    repeat
                        Lookup_B2B.RESET();
                        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
                        Lookup_B2B.SETRANGE(PT, true);
                        Lookup_B2B.SETRANGE("Lookup Name", ProcessedSalary2."Add/Deduct Code");
                        if not Lookup_B2B.IsEmpty() then begin
                            TotalPTArrearAmount := TotalPTArrearAmount + ProcessedSalary2."Arrear Amount";
                            Grossamt := Grossamt + ProcessedSalary2."Earned Amount";
                        end;
                    until ProcessedSalary2.NEXT() = 0;
            end;
            ArrearPT := TotalPTArrearAmount + Grossamt;
            CLEAR(PTCode);
            Employee.RESET();
            Employee.SETRANGE("No.", PRLine."No.");
            if Employee.FINDFIRST() then
                PTCode := Employee."PT Branch Code";
            PTLine.RESET();
            PTLine.SETRANGE("Branch Code", PTCode);
            if PTLine.FINDFIRST() then
                repeat
                    if (Grossamt >= PTLine."Income From") and (Grossamt <= PTLine."Income To") then
                        PreviousPT := PTLine."Tax Amount";
                    if (ArrearPT >= PTLine."Income From") and (ArrearPT <= PTLine."Income To") then
                        AfterPT := PTLine."Tax Amount";
                until PTLine.NEXT() = 0;

            if PreviousPT <> AfterPT then begin
                PTAmount := AfterPT - PreviousPT;
                ProcessedSalary2.RESET();
                ProcessedSalary2.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary2.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                ProcessedSalary2.SETFILTER(Year, '=%1', CheckYear);
                ProcessedSalary2.SETRANGE(Posted, true);
                ProcessedSalary2.SETRANGE("Add/Deduct Code", PTTxt);
                ProcessedSalary2.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                if ProcessedSalary2.FINDFIRST() then begin
                    ProcessedSalary2."Arrear Salary" := PTAmount;
                    ProcessedSalary2."Arrears Not Posted" := true;
                    ProcessedSalary2.MODIFY();
                    CheckDate := DMY2DATE(1, CheckMonth, CheckYear);
                    ProcessedSalary2."Arrear Amount" := PTAmount;
                    ProcessedSalary2.MODIFY();
                end else
                    if PTAmount > 0 then begin
                        ProcessedSalary2.RESET();
                        ProcessedSalary2.SETRANGE("Employee Code", PayRevisionLine."No.");
                        ProcessedSalary2.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
                        ProcessedSalary2.SETFILTER(Year, '=%1', CheckYear);
                        ProcessedSalary2.SETRANGE(Posted, true);
                        if ProcessedSalary2.FINDLAST() then
                            LineNum := ProcessedSalary2."Line No." + 10000;
                        ProcessedSalary2.INIT();
                        ProcessedSalary2."Document Type" := ProcessedSalary2."Document Type"::Payroll;
                        ProcessedSalary2."Employee Code" := PayRevisionLine."No.";
                        ProcessedSalary2."Pay Slip Month" := CheckMonth;
                        ProcessedSalary2.Year := CheckYear;
                        ProcessedSalary2."Line No." := LineNum;
                        ProcessedSalary2."Add/Deduct Code" := PTTxt;
                        ProcessedSalary2."Earned Amount" := 0;
                        ProcessedSalary2."Arrear Amount" := PTAmount;
                        ProcessedSalary2."Arrears Not Posted" := true;
                        ProcessedSalary2.Posted := true;
                        ProcessedSalary2.INSERT();
                    end;

            end;
        end;
    end;

    procedure UpdateArrearAmountNew(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Total: Decimal;
    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);

        PayRevisionLine.RESET();
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::All);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                Total := 0;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PayRevisionLine."Pay Element");
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        Total := Total + ProcessedSalary."Arrear Amount";
                    until ProcessedSalary.NEXT() = 0;
                PayRevisionLine."Arrear Amount" := Total;
                PayRevisionLine.MODIFY();
            until PayRevisionLine.NEXT() = 0;
    end;

    procedure UpdateESIArrearAmountNew(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        ESITotal: Decimal;
        ESICoAmt: Decimal;
    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
        PayRevisionLine.RESET();
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::All);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                ESITotal := 0;
                ESICoAmt := 0;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", ESITxt);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        ESITotal := ESITotal + ProcessedSalary."Arrear Amount";
                        ESICoAmt := ESICoAmt + ProcessedSalary."Arrear Co. Contribution";
                    until ProcessedSalary.NEXT() = 0;
            until PayRevisionLine.NEXT() = 0;
        PayRevisionLine.INIT();
        PayRevisionLine."Header No." := PayRevisionHeader."Id.";
        PayRevisionLine."No." := PayRevisionHeader."No.";
        PayRevisionLine.Type := PayRevisionHeader.Type;
        PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
        PayRevisionLine."Pay Element" := ESITxt;
        PayRevisionLine.Grade := PayElement."Pay Cadre";
        PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
        PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
        PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
        PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct"::Deduction;
        PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
        PayRevisionLine."Arrear Amount" := ESITotal;
        PayRevisionLine."Arrear Co. Contribution" := ESICoAmt;
        PayRevisionLine."Arrear Inserted" := true;
        PayRevisionLine.INSERT();
    end;

    procedure UpdatePFArrearAmountNew(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        PFTotal: Decimal;
        PFCoAmt: Decimal;
        PFCoAmt2: Decimal;

    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);

        PayRevisionLine.RESET();
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::All);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                PFTotal := 0;
                PFCoAmt := 0;
                PFCoAmt2 := 0;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionHeader."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PFTxt);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        PFTotal := PFTotal + ProcessedSalary."Arrear Amount";
                        PFCoAmt := PFCoAmt + ProcessedSalary."Arrear Co. Contribution";
                        PFCoAmt2 := PFCoAmt2 + ProcessedSalary."Arrear Co. Contribution2";
                    until ProcessedSalary.NEXT() = 0;
            until PayRevisionLine.NEXT() = 0;
        PayRevisionLine.INIT();
        PayRevisionLine."Header No." := PayRevisionHeader."Id.";
        PayRevisionLine."No." := PayRevisionHeader."No.";
        PayRevisionLine.Type := PayRevisionHeader.Type;
        PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
        PayRevisionLine."Pay Element" := PFTxt;
        PayRevisionLine.Grade := PayElement."Pay Cadre";
        PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
        PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
        PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
        PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct"::Deduction;
        PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
        PayRevisionLine."Arrear Amount" := PFTotal;
        PayRevisionLine."Arrear Co. Contribution" := PFCoAmt;
        PayRevisionLine."Arrear Co. Contribution2" := PFCoAmt2;
        PayRevisionLine."Arrear Inserted" := true;
        PayRevisionLine.INSERT();
    end;

    procedure UpdatePTArrearAmountNew(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        PTTotal: Decimal;
        PTCoAmt: Decimal;
    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);

        PayRevisionLine.RESET();
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::All);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                PTTotal := 0;
                PTCoAmt := 0;
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, true);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", true);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PTTxt);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        PTTotal := PTTotal + ProcessedSalary."Arrear Amount";
                        PTCoAmt := PTCoAmt + ProcessedSalary."Arrear Co. Contribution";
                    until ProcessedSalary.NEXT() = 0;
            until PayRevisionLine.NEXT() = 0;
        PayRevisionLine.INIT();
        PayRevisionLine."Header No." := PayRevisionHeader."Id.";
        PayRevisionLine."No." := PayRevisionHeader."No.";
        PayRevisionLine.Type := PayRevisionHeader.Type;
        PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
        PayRevisionLine."Pay Element" := PTTxt;
        PayRevisionLine.Grade := PayElement."Pay Cadre";
        PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
        PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
        PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
        PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct"::Deduction;
        PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
        PayRevisionLine."Arrear Amount" := PTTotal;
        PayRevisionLine."Arrear Co. Contribution" := PTCoAmt;
        PayRevisionLine."Arrear Inserted" := true;
        PayRevisionLine.INSERT();
    end;

    procedure CalculateNewlyAddedArrearsNew(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        ProcSal2: Record "Processed Salary B2B";
        MonAtt: Record "Monthly Attendance B2B";
        PayRevLineLRec: Record "Pay Revision Line B2B";
        ProcSal: Record "Processed Salary B2B";
        ProcSal3: Record "Processed Salary B2B";
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        LineNum: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        NoofDays: Decimal;
        MonthDays: Decimal;

    begin
        DA := 0;
        CheckMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CheckYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);

        ProcSal3.RESET();
        ProcSal3.SETRANGE("Employee Code", PayRevisionHeader."No.");
        ProcSal3.SETFILTER("Pay Slip Month", '>=%1', CheckMonth);
        ProcSal3.SETFILTER(Year, '>=%1', CheckYear);
        ProcSal3.SETRANGE(Posted, true);
        ProcSal3.SETRANGE("Add/Deduct Code", BASICTxt);
        ProcSal3.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year);
        if ProcSal3.FINDFIRST() then
            repeat
                PayRevLineLRec.RESET();
                PayRevLineLRec.SETRANGE("Header No.", PayRevisionHeader."Id.");
                if PayRevLineLRec.FINDFIRST() then
                    repeat
                        ProcSal.RESET();
                        ProcSal.SETRANGE("Employee Code", PayRevLineLRec."No.");
                        ProcSal.SETRANGE("Pay Slip Month", ProcSal3."Pay Slip Month");
                        ProcSal.SETRANGE(Year, ProcSal3.Year);
                        ProcSal.SETRANGE("Add/Deduct Code", PayRevLineLRec."Pay Element");
                        if not ProcSal.FINDFIRST() then begin
                            MonAtt.RESET();
                            MonAtt.SETRANGE("Employee Code", PayRevLineLRec."No.");
                            MonAtt.SETRANGE("Pay Slip Month", CheckMonth);
                            MonAtt.SETRANGE(Year, CheckYear);
                            if MonAtt.FINDFIRST() then begin
                                MonAtt.CALCFIELDS(Attendance, MonAtt.Leaves, Days, MonAtt.Holidays);
                                CLEAR(NoofDays);
                                CLEAR(MonthDays);
                                //NoofDays := MonAtt.Attendance + MonAtt.Leaves;
                                NoofDays := MonAtt.Attendance + MonAtt."Loss Of Pay";
                                MonthDays := MonAtt.Days;
                            end;
                            if PayRevLineLRec."Pay Element" = BASICTxt then begin
                                if (PayRevLineLRec."Revised Computation Type" = OnAttTxt) then begin
                                    Total := (NoofDays / MonthDays) * PayRevLineLRec."Revised Amount / Percent";
                                    Basic := Total;
                                end else
                                    if (PayRevLineLRec."Revised Computation Type" = NonAttTxt) then begin
                                        Total := PayRevLineLRec."Revised Amount / Percent";
                                        Basic := Total;
                                    end;
                            end else
                                if (PayRevLineLRec."Revised Fixed / Percent" = PayRevLineLRec."Revised Fixed / Percent"::Fixed) then begin
                                    if (PayRevLineLRec."Revised Computation Type" = OnAttTxt) then
                                        Total := (NoofDays / MonthDays) * PayRevLineLRec."Revised Amount / Percent"
                                    else
                                        Total := PayRevLineLRec."Revised Amount / Percent";
                                end else
                                    if (PayRevLineLRec."Revised Fixed / Percent" = PayRevLineLRec."Revised Fixed / Percent"::Percent) and
                                       (PayRevLineLRec."Revised Computation Type" = AFTERBASICTxt)
                           then
                                        Total := (PayRevLineLRec."Revised Amount / Percent" * Basic) / 100
                                    else
                                        if (PayRevLineLRec."Revised Fixed / Percent" = PayRevLineLRec."Revised Fixed / Percent"::Percent) and
                                           (PayRevLineLRec."Revised Computation Type" = AFTERBASICANDDATxt)
                                   then
                                            Total := (PayRevLineLRec."Revised Amount / Percent" * (Basic + DA)) / 100;

                            if PayRevLineLRec."Pay Element" = DATxt then
                                DA := Total;
                            PayRevLineLRec."Arrear Inserted" := true;
                            PayRevLineLRec.MODIFY();
                            ProcSal2.RESET();
                            ProcSal2.SETRANGE("Employee Code", PayRevLineLRec."No.");
                            ProcSal2.SETRANGE("Pay Slip Month", ProcSal."Pay Slip Month");
                            ProcSal2.SETRANGE(Year, ProcSal.Year);
                            ProcSal2.SETRANGE(Posted, true);
                            if ProcSal2.FINDLAST() then begin
                                LineNum := ProcSal2."Line No." + 10000;
                                ProcSal2.INIT();
                                ProcSal2."Document Type" := ProcSal2."Document Type"::Payroll;
                                ProcSal2."Employee Code" := PayRevLineLRec."No.";
                                ProcSal2."Pay Slip Month" := ProcSal."Pay Slip Month";
                                ProcSal2.Year := ProcSal.Year;
                                ProcSal2."Line No." := LineNum;
                                ProcSal2."Arrear Amount" := Total;
                                ProcSal2."Add/Deduct Code" := PayRevLineLRec."Pay Element";
                                ProcSal2."Fixed/Percent" := PayRevLineLRec."Revised Fixed / Percent";
                                ProcSal2."Computation Type" := PayRevLineLRec."Revised Computation Type";
                                ProcSal2."Add/Deduct" := PayRevLineLRec."Add/Deduct";
                                ProcSal2.Days := ProcSal.Days;
                                ProcSal2.Posted := true;
                                ProcSal2."Arrears Not Posted" := true;
                                ProcSal2.INSERT();
                            end;
                        end;
                    until PayRevLineLRec.NEXT() = 0;
            until ProcSal3.NEXT() = 0;
    end;

    procedure CheckIfAlreadyCaluclated(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLineLoc: Record "Pay Revision Line B2B";
    begin
        PayRevisionLineLoc.RESET();
        PayRevisionLineLoc.SETRANGE(PayRevisionLineLoc."Header No.", PayRevisionHeader."Id.");
        PayRevisionLineLoc.SETFILTER("Arrear Amount", '<>%1', 0);
        if not PayRevisionLineLoc.IsEmpty() then
            ERROR(Text011Lbl);
    end;

    procedure Release();
    begin
        TESTFIELD(Status, Status::Open);
        CheckMandatoryFields();
        if not CONFIRM(Text004Lbl) then
            exit;

        PayRevision.GET("Id.");
        PayRevision.Status := PayRevision.Status::Released;
        PayRevision.MODIFY();
    end;

    procedure Reopen();
    begin
        TESTFIELD(Status, Status::Released);
        if Posted = true then
            ERROR(Text006Lbl, "No.");

        if not CONFIRM(Text005Lbl) then
            exit;
        PayRevision.GET("Id.");
        PayRevision.Status := PayRevision.Status::Open;
        PayRevision.MODIFY();
    end;

    procedure PayRevisionLinesExists(): Boolean;
    begin
        PayRevisionLineGRec.RESET();
        PayRevisionLineGRec.SETRANGE("Header No.", "Id.");
        if PayRevisionLineGRec.FINDFIRST() then
            exit(true)
        else
            exit(false);
    end;

    procedure CheckDocumentStatusPosted();
    begin
        if Posted then
            ERROR(Text010Lbl, "Id.");
    end;

    procedure CheckMandatoryFields();
    begin
        PayRevisionLineGRec.RESET();
        PayRevisionLineGRec.SETRANGE("Header No.", "Id.");
        if PayRevisionLineGRec.FINDSET() then
            repeat
                PayRevisionLineGRec.TESTFIELD("Effective Date");
                PayRevisionLineGRec.TESTFIELD("Pay Element");
                //PayRevisionLineGRec.TESTFIELD("Amount / Percent");
                PayRevisionLineGRec.TESTFIELD("Revised Amount / Percent");
                PayRevisionLineGRec.TESTFIELD("Revised Computation Type");
            until PayRevisionLineGRec.NEXT() = 0;
    end;

    procedure ShowDocDim();
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1', "Id."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then begin
            MODIFY();
            if LinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]);
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.GET();
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(TableID, No, '', "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if (OldDimSetID <> "Dimension Set ID") and LinesExist() then begin
            MODIFY();
            SkipConfirmationDialog(true);
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "Id." <> '' then
            MODIFY();

        if OldDimSetID <> "Dimension Set ID" then begin
            MODIFY();
            if LinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        DimChangeTxt: Label 'You may have changed a dimension.\\Do you want to update the lines?';
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not SkipConfirmation then
            if not CONFIRM(DimChangeTxt) then
                exit;

        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", "Id.");
        PayRevisionLine.LOCKTABLE();
        if PayRevisionLine.FINDFIRST() then
            repeat
                if PayRevisionLine."Dimension Set ID" <> NewParentDimSetID then begin
                    PayRevisionLine."Dimension Set ID" := NewParentDimSetID;

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PayRevisionLine."Dimension Set ID", PayRevisionLine."Shortcut Dimension 1 Code", PayRevisionLine."Shortcut Dimension 2 Code");
                    PayRevisionLine.MODIFY();
                end;
            until PayRevisionLine.NEXT() = 0;
    end;

    procedure LinesExist(): Boolean;
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
    begin
        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", "Id.");
        exit(not PayRevisionLine.IsEmpty());
    end;

    procedure SkipConfirmationDialog(Flag: Boolean);
    begin
        SkipConfirmation := Flag;
    end;
}

