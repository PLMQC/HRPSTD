report 33001190 "Generate Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Generate Leaves';
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                "Employee B2B".TESTFIELD("Pay Cadre");
                if not "Employee B2B".Blocked then
                    if "Employee B2B"."Employment Date" <= Startdate then
                        if "Employee B2B".Probation then begin
                            Window.UPDATE(1, "Employee B2B"."No.");
                            InsertLeaveEntitlement();
                            "Employee B2B"."Leaves Not Generated" := false;
                            "Employee B2B".MODIFY()
                        end else begin
                            Window.UPDATE(1, "Employee B2B"."No.");
                            RegularEmployeeLeaves();
                            "Employee B2B"."Leaves Not Generated" := false;
                            "Employee B2B".MODIFY();
                        end;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Generate Leaves';

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

        Window.CLOSE();
    end;

    trigger OnPreReport();
    begin
        Payyear.SETRANGE("Year Type", LeaveTextTxt);
        Payyear.SETRANGE(Closed, false);
        if Payyear.FINDFIRST() then begin
            Startdate := Payyear."Year Start Date";
            Enddate := Payyear."Year End Date";
        end;

        Window.OPEN(Text002Lbl);
    end;

    var
        HRsetup: Record "HR Setup B2B";
        Payyear: Record "Payroll Year B2B";
        LeaveMaster: Record "Leave Master B2B";
        LeaveEntitlement: Record "Leave Entitlement B2B";
        LeaveEntitlement2: Record "Leave Entitlement B2B";
        LeaveEntitlement3: Record "Leave Entitlement B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Num: Integer;
        Text000Lbl: Label 'Leaves created for the employees';
        Check: Boolean;
        Text001Lbl: Label 'Leaves are already created';
        Enddate: Date;
        Startdate: Date;
        Window: Dialog;
        Text002Lbl: Label 'Employee......#1######################', Comment = '%1 = No';
        LeaveTextTxt: Label 'LEAVE YEAR';

    procedure InsertLeaveEntitlement();
    var
        CreditingLeaves: Decimal;
        CreditingMonth: Integer;
        CreditingYear: Integer;
        CreditingDate: Date;
    begin
        LeaveMaster.SETRANGE("Applicable During Probation", true);
        LeaveMaster.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if LeaveMaster.FINDFIRST() then
            repeat
                LeaveEntitlement2.Reset();
                if LeaveEntitlement2.FINDLAST() then
                    Num := LeaveEntitlement2."Entry No."
                else
                    Num := 0;
                LeaveEntitlement.INIT();
                LeaveEntitlement."Entry No." := Num + 1;
                LeaveEntitlement."Employee No." := "Employee B2B"."No.";
                LeaveEntitlement."Employee Name" := "Employee B2B"."First Name";
                LeaveEntitlement.Probation := "Employee B2B".Probation;
                LeaveEntitlement."Leave Code" := LeaveMaster."Leave Code";
                CreditingLeaves := ROUND((LeaveMaster."No.of Leaves During Probation") / 12, 0.5, '>');
                CreditingDate := CALCDATE(LeaveMaster."Crediting Interval", Startdate);
                CreditingMonth := DATE2DMY(CreditingDate, 2);
                CreditingYear := DATE2DMY(CreditingDate, 3);
                LeaveEntitlement."Leave Year Closing Period" := Enddate;
                if HRsetup.FINDFIRST() then begin
                    LeaveEntitlement.Month := HRsetup."Salary Processing month";
                    LeaveEntitlement.Year := HRsetup."Salary Processing Year";
                end;
                if LeaveMaster."Crediting Type" = LeaveMaster."Crediting Type"::"After the Period" then begin
                    if (CreditingMonth = LeaveEntitlement.Month) and (CreditingYear = LeaveEntitlement.Year) then
                        LeaveEntitlement."No.of Leaves" := CreditingLeaves
                end else
                    LeaveEntitlement."No.of Leaves" := CreditingLeaves;
                LeaveEntitlement."Total Leaves" := LeaveEntitlement."No.of Leaves";
                LeaveEntitlement3.SETRANGE("Employee No.", LeaveEntitlement."Employee No.");
                LeaveEntitlement3.SETRANGE("Leave Code", LeaveEntitlement."Leave Code");
                LeaveEntitlement3.SETRANGE(Year, LeaveEntitlement.Year);
                LeaveEntitlement3.SETRANGE(Month, LeaveEntitlement.Month);
                if not LeaveEntitlement3.FINDFIRST() then begin
                    LeaveEntitlement.INSERT();
                    Check := true;
                end else
                    Check := false;
            until LeaveMaster.NEXT() = 0;
    end;

    procedure RegularEmployeeLeaves();
    var

    begin
        LeaveMaster.RESET();
        LeaveMaster.SETRANGE("Crediting Type", LeaveMaster."Crediting Type"::"Before the Period");
        LeaveMaster.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if LeaveMaster.FINDFIRST() then
            repeat
                if LeaveMaster."All Cadres" or (STRPOS(LeaveMaster."Pay Cadre", "Employee B2B"."Pay Cadre") <> 0) then begin
                    if LeaveEntitlement2.FINDLAST() then
                        Num := LeaveEntitlement2."Entry No."
                    else
                        Num := 0;
                    LeaveEntitlement.INIT();
                    LeaveEntitlement."Entry No." := Num + 1;
                    LeaveEntitlement."Employee No." := "Employee B2B"."No.";
                    LeaveEntitlement."Employee Name" := "Employee B2B"."First Name";
                    LeaveEntitlement.Probation := "Employee B2B".Probation;
                    LeaveEntitlement."Leave Code" := LeaveMaster."Leave Code";
                    LeaveEntitlement."No.of Leaves" := LeaveMaster."Leaves in Crediting Interval";
                    LeaveEntitlement."Leave Year Closing Period" := Enddate;
                    if HRsetup.FINDFIRST() then begin
                        LeaveEntitlement.Month := HRsetup."Salary Processing month";
                        LeaveEntitlement.Year := HRsetup."Salary Processing Year";
                    end;
                    LeaveEntitlement."Leave Period Starting Month" := LeaveEntitlement.Month;
                    LeaveEntitlement."Leave Period Starting Year" := LeaveEntitlement.Year;
                    LeaveEntitlement."Total Leaves" := LeaveEntitlement."No.of Leaves";
                    LeaveEntitlement3.SETRANGE("Employee No.", LeaveEntitlement."Employee No.");
                    LeaveEntitlement3.SETRANGE("Leave Code", LeaveEntitlement."Leave Code");
                    LeaveEntitlement3.SETRANGE(Year, LeaveEntitlement.Year);
                    LeaveEntitlement3.SETRANGE(Month, LeaveEntitlement.Month);
                    if not LeaveEntitlement3.FINDFIRST() then begin
                        LeaveEntitlement.INSERT();
                        Check := true
                    end else
                        Check := false;
                end;
            until LeaveMaster.NEXT() = 0;
    end;
}

