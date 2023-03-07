page 33001373 "Temp Emp Leave List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Temp Emp Leave List';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Employee Leaves B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the no details';
                }
                field("Leave Pay Cadre"; "Leave Pay Cadre")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave pay cadre details';
                }
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave code details';
                }
                field("Leave Description"; "Leave Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave description';
                }
                field("Next Leave Period"; "Next Leave Period")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the next leave period';
                }
                field("Leaves for the Current Period"; "Leaves for the Current Period")
                {
                    Editable = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leaves for the current period details';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Create &Provisional Leaves")
            {
                Caption = 'Create &Provisional Leaves';
                Image = CreateDocument;
                ApplicationArea = all;
                ToolTip = 'Specify the create provisional leave details';

                trigger OnAction();
                begin
                    EmployeeRec.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50003, false, false, EmployeeRec);
                end;
            }
        }
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Image = Start;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specify the leave ok details';

                trigger OnAction();
                begin
                    if FINDFIRST() then begin
                        repeat
                            InsertEmpLeaves(Rec);
                        until NEXT() = 0;
                        MESSAGE(Text001Lbl);
                    end;
                    CurrPage.CLOSE();
                end;
            }
        }
    }

    var
        EmployeeRec: Record "Employee B2B";
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        PayrollYearRec: Record "Payroll Year B2B";
        HRSetup: Record "HR Setup B2B";
        EmployeeLeaves: Record "Employee Leaves B2B";
        EmpLeaveHistory: Record "Detailed Leave Records B2B";
        EmpLeaveHistoryNum: Record "Detailed Leave Records B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Num: Integer;
        Text001Lbl: Label 'Leaves generated successfully.';
        Text002Lbl: Label 'LEAVE YEAR';

    procedure GetPayrollYearRec(PayrollYearPar: Record "Payroll Year B2B");
    begin
        PayrollYearPar.RESET();
        PayrollYearPar.SETRANGE("Year Type", Text002Lbl);
        PayrollYearPar.SETRANGE(Closed, false);
        PayrollYearPar.FINDFIRST();
        PayrollYearRec := PayrollYearPar;
    end;

    procedure InsertEmpLeaves(TempEmpLeaveRec: Record "Employee Leaves B2B");
    begin
        PayrollYearRec.RESET();
        PayrollYearRec.SETRANGE("Year Type", Text002Lbl);
        PayrollYearRec.SETRANGE(Closed, false);
        PayrollYearRec.FINDFIRST();

        if EmpLeaveHistoryNum.FINDLAST() then
            Num := EmpLeaveHistoryNum."Entry No." + 1
        else
            Num := 1;

        EmployeeLeaves.INIT();
        EmpLeaveHistory.INIT();
        EmployeeRec.INIT();
        EmployeeLeaves."No." := TempEmpLeaveRec."No.";
        EmployeeLeaves."Leave Pay Cadre" := TempEmpLeaveRec."Leave Pay Cadre";
        EmployeeLeaves."Leave Code" := TempEmpLeaveRec."Leave Code";
        EmployeeLeaves."Leave Description" := TempEmpLeaveRec."Leave Description";
        EmployeeLeaves."Next Leave Period" := TempEmpLeaveRec."Next Leave Period";
        EmployeeLeaves.INSERT();

        EmpLeaveHistory."Entry No." := Num;
        EmpLeaveHistory."Employee No." := TempEmpLeaveRec."No.";
        EmpLeaveHistory."Leave Code" := TempEmpLeaveRec."Leave Code";
        EmpLeaveHistory."Leave Description" := TempEmpLeaveRec."Leave Description";
        EmpLeaveHistory."Entry Type" := EmpLeaveHistory."Entry Type"::Entitlement;
        EmpLeaveHistory."Entry Date" := workdate();
        EmpLeaveHistory."Leave Pay Cadre" := TempEmpLeaveRec."Leave Pay Cadre";

        if EmployeeRec.GET(TempEmpLeaveRec."No.") then;

        if HRSetup.GET() then;

        if EmployeeRec."Employment Date" <= PayrollYearRec."Year Start Date" then
            EmpLeaveHistory.Month := DATE2DMY(EmployeeRec."Employment Date", 2)
        else
            EmpLeaveHistory.Month := DATE2DMY(PayrollYearRec."Year Start Date", 2);

        EmpLeaveHistory.Year := DATE2DMY(PayrollYearRec."Year End Date", 3);
        EmpLeaveHistory.VALIDATE("No. of Leaves", TempEmpLeaveRec."Leaves for the Current Period");
        EmpLeaveHistory.INSERT();
        Num := Num + 1;
        EmployeeRec.GET(TempEmpLeaveRec."No.");
        EmployeeRec."Leaves Not Generated" := false;
        EmployeeRec.MODIFY();

        InsertProvLeaves(EmployeeLeaves, EmpLeaveHistory);
    end;

    procedure InsertProvLeaves(EmpLeaves: Record "Employee Leaves B2B"; EmpHistory: Record "Detailed Leave Records B2B");
    var
        PayrollYear: Record "Payroll Year B2B";
        ProvLeaves: Record "Provisional Leaves B2B";
        StartDate: Date;
        EndDate: Date;
        TempDate: Date;
    begin
        PayrollYear.RESET();
        PayrollYear.SETRANGE("Year Type", Text002Lbl);
        PayrollYear.SETRANGE(Closed, false);
        if PayrollYear.FINDFIRST() then
            EndDate := PayrollYear."Year End Date";


        EmployeeRec.GET(EmpLeaves."No.");

        ProvLeaves.INIT();
        ProvLeaves."Employee No." := EmpLeaves."No.";
        ProvLeaves."Employee Name" := EmployeeRec."First Name";
        ProvLeaves."Leave Code" := EmpLeaves."Leave Code";
        ProvLeaves.Month := DATE2DMY(EmployeeRec."Employment Date", 2);
        ProvLeaves.Year := DATE2DMY(EmployeeRec."Employment Date", 3);
        ProvLeaves."Leave Descriptioon" := EmpLeaves."Leave Description";
        ProvLeaves."No.of Leaves" := EmpHistory."No. of Leaves";
        ProvLeaves."Remaining Leaves" := EmpHistory."No. of Leaves";
        ProvLeaves."Leave Year Start Date" := EmployeeRec."Employment Date";
        ProvLeaves."Leave Year End Date" := EndDate;
        ProvLeaves."Period Start Date" := EmployeeRec."Employment Date";
        ProvLeaves."Period End Date" := EmployeeLeaves."Next Leave Period" - 1;
        ProvLeaves.INSERT();

        if EmpLeaves."Next Leave Period" <= EndDate then begin
            StartDate := EmpLeaves."Next Leave Period";
            GradeWiseLeaves.RESET();
            GradeWiseLeaves.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            GradeWiseLeaves.SETRANGE("Leave Pay Cadre", EmpLeaves."Leave Pay Cadre");
            GradeWiseLeaves.SETRANGE("Leave Code", EmpLeaves."Leave Code");
            if GradeWiseLeaves.FINDFIRST() then
                repeat
                    TempDate := StartDate;
                    repeat
                        ProvLeaves.INIT();
                        ProvLeaves."Employee No." := EmpLeaves."No.";
                        ProvLeaves."Employee Name" := EmployeeRec."First Name";
                        ProvLeaves."Leave Code" := GradeWiseLeaves."Leave Code";
                        ProvLeaves.Month := DATE2DMY(TempDate, 2);
                        ProvLeaves.Year := DATE2DMY(TempDate, 3);
                        ProvLeaves."Leave Descriptioon" := GradeWiseLeaves."Leave Description";
                        ProvLeaves."No.of Leaves" := GradeWiseLeaves."Leaves in Crediting Interval";
                        ProvLeaves."Remaining Leaves" := GradeWiseLeaves."Leaves in Crediting Interval";
                        ProvLeaves."Leave Year Start Date" := StartDate;
                        ProvLeaves."Leave Year End Date" := EndDate;
                        ProvLeaves."Period Start Date" := TempDate;
                        ProvLeaves."Period End Date" := (CALCDATE(GradeWiseLeaves."Crediting Interval", TempDate) - 1);
                        ProvLeaves.INSERT();
                        TempDate := CALCDATE(GradeWiseLeaves."Crediting Interval", TempDate);
                    until TempDate > EndDate;
                until GradeWiseLeaves.NEXT() = 0;

        end;
    end;
}

