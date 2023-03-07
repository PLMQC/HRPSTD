report 33001191 "Update Leave Entitlement B2B"
{
    // version B2BHR1.00.00

    Caption = 'Update Leave Entitlement';
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                Window.UPDATE(1, "No.");
                if not "Employee B2B".Blocked then begin
                    "Employee B2B".TESTFIELD("Employment Date");
                    if "Employee B2B".Probation then
                        LeaveUpdation()
                    else
                        RegularEmpLeaveUpdation();
                end;
            end;

            trigger OnPostDataItem();
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem();
            begin
                Window.OPEN(Text002Lbl);
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Update Leave Entitlement';

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
        if Check then
            MESSAGE(Text000Lbl)
        else
            MESSAGE(Text001Lbl);
    end;

    trigger OnPreReport();
    begin
        PayYear.SETRANGE("Year Type", LeaveTextTxt);
        PayYear.SETRANGE(Closed, false);
        if PayYear.FINDFIRST() then begin
            Enddate := PayYear."Year End Date";
            PayMonth := DATE2DMY(Enddate, 2);
            Year := DATE2DMY(Enddate, 3);
            StartDate := PayYear."Year Start Date";
        end;
    end;

    var
        HRSetup: Record "HR Setup B2B";
        LeaveMaster: Record "Leave Master B2B";
        LeaveEntitle: Record "Leave Entitlement B2B";
        LeaveEntitle2: Record "Leave Entitlement B2B";
        LeaveEntitle3: Record "Leave Entitlement B2B";
        PayYear: Record "Payroll Year B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text000Lbl: Label 'Leaves updated for the employees';
        Text001Lbl: Label 'Leaves are already updated';
        LeavesCarry: Decimal;
        LeavesExp: Decimal;
        Num: Integer;
        PayMonth: Integer;
        Year: Integer;
        CountMonth: Integer;
        Check: Boolean;
        Enddate: Date;
        Window: Dialog;

        StartDate: Date;
        Text002Lbl: Label 'Employee #1########################', Comment = '%1 = No';
        LeaveTextTxt: Label 'LEAVE YEAR';
        Text330001Txt: Label '-1M';

    procedure LeaveUpdation();
    var
        EmpMonth: Integer;
        EmpYear: Integer;
    begin
        EmpMonth := DATE2DMY("Employee B2B"."Employment Date", 2);
        EmpYear := DATE2DMY("Employee B2B"."Employment Date", 3);
        if EmpYear = Year then begin
            if HRSetup.FINDFIRST() then
                if EmpMonth <= HRSetup."Salary Processing month" + 1 then
                    UpdateLeaveEntitle();
        end else
            if EmpYear < Year then
                UpdateLeaveEntitle();
    end;

    procedure RegularEmpLeaveUpdation();
    var
        EmpMonth: Integer;
        EmpYear: Integer;
    begin
        EmpMonth := DATE2DMY("Employee B2B"."Employment Date", 2);
        EmpYear := DATE2DMY("Employee B2B"."Employment Date", 3);
        if EmpYear = Year then
            if HRSetup.FINDFIRST() then
                if EmpMonth <= HRSetup."Salary Processing month" + 1 then begin
                    CountMonth := (PayMonth - EmpMonth) + 1;
                    RegularEmpLeave();
                    "Employee B2B"."Leaves Not Generated" := false;
                    "Employee B2B".MODIFY();
                end
                else
                    if EmpYear < Year then begin
                        CountMonth := 12;
                        RegularEmpLeave();
                    end;
    end;

    procedure UpdateLeaveEntitle();
    begin
        LeavesCarry := 0;
        LeaveMaster.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        LeaveMaster.SETRANGE("Applicable During Probation", true);
        if LeaveMaster.FINDFIRST() then
            repeat
                if LeaveEntitle2.FINDLAST() then
                    Num := LeaveEntitle2."Entry No."
                else
                    Num := 0;
                LeaveEntitle.INIT();
                LeaveEntitle."Entry No." := Num + 1;
                LeaveEntitle."Employee No." := "Employee B2B"."No.";
                LeaveEntitle."Employee Name" := "Employee B2B"."First Name";
                LeaveEntitle.Probation := "Employee B2B".Probation;
                LeaveEntitle."Leave Code" := LeaveMaster."Leave Code";
                LeaveEntitle."No.of Leaves" := (LeaveMaster."No.of Leaves During Probation") / 12;
                LeaveEntitle."Leave Year Closing Period" := Enddate;
                if HRSetup.FINDFIRST() then
                    if HRSetup."Salary Processing month" = 12 then begin
                        LeaveEntitle.Month := 1;
                        LeaveEntitle.Year := HRSetup."Salary Processing Year" + 1;
                        //LeaveEntitle."Leave Year Closing Period" :=DMY2Date(0,0,0);
                        LeaveEntitle."Leave Year Closing Period" := 0D;
                    end else begin
                        LeaveEntitle.Month := HRSetup."Salary Processing month" + 1;
                        LeaveEntitle.Year := HRSetup."Salary Processing Year";
                    end;

                LeavesCarried(LeaveEntitle, LeaveMaster);
                LeaveEntitle."Leaves Carried" := LeavesCarry;
                if HRSetup.FINDFIRST() then
                    if HRSetup."Salary Processing month" = 12 then
                        LeaveEntitle."Leaves Expired" := LeavesExp;
                LeaveEntitle."Total Leaves" := LeaveEntitle."No.of Leaves" + LeaveEntitle."Leaves Carried";
                LeaveEntitle3.SETRANGE("Employee No.", LeaveEntitle."Employee No.");
                LeaveEntitle3.SETRANGE("Leave Code", LeaveEntitle."Leave Code");
                LeaveEntitle3.SETRANGE(Year, LeaveEntitle.Year);
                LeaveEntitle3.SETRANGE(Month, LeaveEntitle.Month);
                if not LeaveEntitle3.FINDFIRST() then begin
                    LeaveEntitle.INSERT();
                    Check := true
                end else
                    Check := false;
            until LeaveMaster.NEXT() = 0;
    end;

    procedure RegularEmpLeave();
    var
        TempDate: Date;
        TempDate1: Date;
    begin
        HRSetup.RESET();

        if HRSetup.FINDFIRST() then;
        LeaveMaster.RESET();
        LeaveMaster.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if LeaveMaster.FINDFIRST() then
            repeat
                if LeaveMaster."All Cadres" or (STRPOS(LeaveMaster."Pay Cadre", "Employee B2B"."Pay Cadre") <> 0) then begin
                    if LeaveEntitle2.FINDLAST() then
                        Num := LeaveEntitle2."Entry No."
                    else
                        Num := 0;
                    TempDate := StartDate;
                    repeat
                        TempDate := CALCDATE(LeaveMaster."Crediting Interval", TempDate);
                        TempDate1 := CALCDATE('<' + Text330001Txt, TempDate + '>');
                    until (TempDate >= Enddate) or (
                          (DATE2DMY(TempDate1, 2) = HRSetup."Salary Processing month") and
                          (DATE2DMY(TempDate1, 3) = HRSetup."Salary Processing Year"));
                    TempDate := CALCDATE('<' + Text330001Txt, TempDate + '>');
                    if (DATE2DMY(TempDate, 2) = HRSetup."Salary Processing month") and
                       (DATE2DMY(TempDate, 3) = HRSetup."Salary Processing Year") then begin
                        LeaveEntitle.INIT();
                        LeaveEntitle."Entry No." := Num + 1;
                        LeaveEntitle."Employee No." := "Employee B2B"."No.";
                        LeaveEntitle."Employee Name" := "Employee B2B"."First Name";
                        LeaveEntitle.Probation := "Employee B2B".Probation;
                        LeaveEntitle."Leave Code" := LeaveMaster."Leave Code";
                        LeaveEntitle."No.of Leaves" := LeaveMaster."Leaves in Crediting Interval";
                        LeaveEntitle."Leave Year Closing Period" := Enddate;
                        if HRSetup.FINDFIRST() then
                            if HRSetup."Salary Processing month" = 12 then begin
                                LeaveEntitle.Month := 1;
                                LeaveEntitle.Year := HRSetup."Salary Processing Year" + 1;
                                LeaveEntitle."Leave Year Closing Period" := 0D;
                            end else begin
                                LeaveEntitle.Month := HRSetup."Salary Processing month" + 1;
                                LeaveEntitle.Year := HRSetup."Salary Processing Year";
                            end;
                        LeaveEntitle."Leave Period Starting Month" := LeaveEntitle.Month;
                        LeaveEntitle."Leave Period Starting Year" := LeaveEntitle.Year;
                        LeavesCarried(LeaveEntitle, LeaveMaster);
                        if "Employee B2B"."Leaves Not Generated" = true then
                            LeaveEntitle."Total Leaves" := LeaveEntitle."No.of Leaves"
                        else
                            LeaveEntitle."Total Leaves" := LeaveEntitle."No.of Leaves" + LeavesCarry;
                        if HRSetup.FINDFIRST() then
                            if HRSetup."Salary Processing month" = 12 then begin
                                LeaveEntitle."Leaves Carried" := LeavesCarry;
                                LeaveEntitle."Leaves Expired" := LeavesExp;
                                LeaveEntitle."Total Leaves" := LeaveEntitle."No.of Leaves" + LeaveEntitle."Leaves Carried";
                            end;

                        LeaveEntitle3.SETRANGE("Employee No.", LeaveEntitle."Employee No.");
                        LeaveEntitle3.SETRANGE("Leave Code", LeaveEntitle."Leave Code");
                        LeaveEntitle3.SETRANGE(Year, LeaveEntitle.Year);
                        LeaveEntitle3.SETRANGE(Month, LeaveEntitle.Month);
                        if not LeaveEntitle3.FINDFIRST() then begin
                            LeaveEntitle.INSERT();
                            Check := true
                        end else
                            Check := false;
                    end else begin
                        LeaveEntitle.RESET();
                        LeaveEntitle.SETRANGE("Leave Code", LeaveMaster."Leave Code");
                        LeaveEntitle.SETRANGE("Employee No.", "Employee B2B"."No.");
                        LeaveEntitle.SETRANGE(Month, HRSetup."Salary Processing month");
                        LeaveEntitle.SETRANGE(Year, HRSetup."Salary Processing Year");
                        if LeaveEntitle.FINDFIRST() then
                            repeat
                                LeaveEntitle.CALCFIELDS("Leaves taken during Month");
                                if HRSetup."Salary Processing month" = 12 then begin
                                    LeaveEntitle.Month := 1;
                                    LeaveEntitle.Year := HRSetup."Salary Processing Year" + 1;
                                end else begin
                                    LeaveEntitle.Month := HRSetup."Salary Processing month" + 1;
                                    LeaveEntitle.Year := HRSetup."Salary Processing Year";
                                end;
                                LeaveEntitle."Total Leaves" := LeaveEntitle."Leave Bal. at the Month End";
                                LeaveEntitle.MODIFY();
                            until LeaveEntitle.NEXT() = 0;
                    end;
                end;

            until LeaveMaster.NEXT() = 0;
    end;

    procedure LeavesCarried(LeaveEntitlement: Record "Leave Entitlement B2B"; LeaveMaster: Record "Leave Master B2B");
    var
        LeaveEntitlement2: Record "Leave Entitlement B2B";
        Month: Integer;
        CurrMonth: Integer;
        CurrYear: Integer;
    //Year: Integer;
    begin
        CurrMonth := LeaveEntitlement.Month;
        CurrYear := LeaveEntitlement.Year;

        if CurrMonth = 1 then
            Year := CurrYear - 1
        else
            Year := CurrYear;

        if CurrMonth = 1 then
            Month := 12
        else
            Month := CurrMonth - 1;

        LeaveEntitlement2.SETRANGE("Employee No.", LeaveEntitlement."Employee No.");
        LeaveEntitlement2.SETRANGE("Leave Code", LeaveEntitlement."Leave Code");
        LeaveEntitlement2.SETRANGE(Year, Year);
        LeaveEntitlement2.SETRANGE(Month, Month);
        if LeaveEntitlement2.FINDFIRST() then
            if LeaveEntitlement.Probation then begin
                LeavesCarry := LeaveEntitlement2."Leave Bal. at the Month End";
                if HRSetup.FINDFIRST() then
                    if HRSetup."Salary Processing month" = 12 then begin
                        if LeavesCarry > LeaveMaster."Max.Leaves to Carry Forward" then
                            LeavesCarry := LeaveMaster."Max.Leaves to Carry Forward";
                        LeavesExp := LeaveEntitlement2."Leave Bal. at the Month End" - LeavesCarry;
                    end;
            end else begin
                LeavesCarry := LeaveEntitlement2."Leave Bal. at the Month End";
                if HRSetup.FINDFIRST() then
                    if HRSetup."Salary Processing month" = 12 then begin
                        if LeaveEntitlement2."Leave Bal. at the Month End" > LeaveMaster."Max.Leaves to Carry Forward" then
                            LeavesCarry := LeaveMaster."Max.Leaves to Carry Forward";
                        LeavesExp := LeaveEntitlement2."Leave Bal. at the Month End" - LeavesCarry;
                    end;
            end;
    end;
}

