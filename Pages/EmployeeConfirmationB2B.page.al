page 33001211 "Employee Confirmation B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Confirmation';
    PageType = Document;
    SourceTable = "Employee Confirm. Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Confirmation ID"; "Confirmation ID")
                {
                    ToolTip = 'Specifies the Confirmation ID number series of the involved entry or record, according to the specified number series';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Employee ID"; "Employee ID")
                {
                    ToolTip = '"specifies / select the Probation Employee ID "';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        EmployeeIDOnAfterValidate();
                    end;
                }
                field("Date of Confirmation"; "Date of Confirmation")
                {
                    ToolTip = 'Specifies / Define the Date on which employee is going to be confirmed';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        DateofConfirmationOnAfterValid();
                    end;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the employee confirmation documetn status as released / open.';
                    ApplicationArea = all;
                }
                field("Report Reference No."; "Report Reference No.")
                {
                    ToolTip = 'Specifies the report number';
                    ApplicationArea = all;
                }
                field(Scale; Scale)
                {
                    ToolTip = 'Specifies the pay scale applicable to the said employee';
                    ApplicationArea = all;
                }
                field("Leave Pay Cadre"; "Leave Pay Cadre")
                {
                    ToolTip = 'Specicfies the Leave Pay Cader applicable';
                    ApplicationArea = all;
                }
            }
            part("Conformation Line"; "Employee Confirm. Subform B2B")
            {
                Caption = 'Conformation Line';
                SubPageLink = "Header No." = FIELD("Confirmation ID");
                ApplicationArea = all;

            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Update &Confirmation")
                {
                    Caption = 'Update &Confirmation';
                    Image = Confirm;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Update & Confirmation details';

                    trigger OnAction();
                    begin
                        TESTFIELD(Status, Status::Release);
                        if not CONFIRM(Text001Lbl) then
                            exit;

                        Employee.RESET();
                        Employee.SETRANGE("No.", "Employee ID");
                        Employee.SETRANGE("Confirmation Date", "Date of Confirmation");
                        if Employee.FINDFIRST() then
                            ERROR(Text004Lbl);

                        Employee.RESET();
                        Employee.SETRANGE("No.", "Employee ID");
                        if Employee.FINDFIRST() then begin
                            Employee.Probation := false;
                            Employee."Confirmation Date" := "Date of Confirmation";
                            Employee."Employee Status" := Text009Lbl;
                            Employee."Leave Pay Cadre" := "Leave Pay Cadre";
                            Employee.MODIFY();
                        end;

                        EmpConfirmLine2.RESET();
                        EmpConfirmLine2.SETRANGE("Header No.", "Confirmation ID");
                        if EmpConfirmLine2.FINDFIRST() then
                            repeat
                                PayElements2.RESET();
                                PayElements2.SETRANGE("Employee Code", EmpConfirmLine2."No.");
                                if PayElements2.FINDSET() then
                                    repeat
                                        PayElements2."Active Pay Elements" := false;
                                        PayElements2.MODIFY();
                                    until PayElements2.NEXT() = 0;
                            until EmpConfirmLine2.NEXT() = 0;
                        EmpConfirmLine.RESET();
                        EmpConfirmLine.SETRANGE("Header No.", "Confirmation ID");
                        if EmpConfirmLine.FINDFIRST() then
                            repeat
                                PayElements.RESET();
                                PayElements.SETRANGE("Employee Code", EmpConfirmLine."No.");
                                if PayElements.FINDLAST() then
                                    repeat
                                        PayElements.INIT();
                                        PayElements.VALIDATE("Employee Code", EmpConfirmLine."No.");
                                        PayElements."Effective Start Date" := EmpConfirmLine."Confirmation Date";
                                        PayElements."Computation Type" := EmpConfirmLine."Revised Computation Type";
                                        PayElements."Fixed/Percent" := EmpConfirmLine."Revised Fixed / Percent";
                                        PayElements."Effective Start Date" := EmpConfirmLine."Confirmation Date";
                                        PayElements."Add/Deduct" := EmpConfirmLine."Add/Deduct";
                                        PayElements."Amount / Percent" := EmpConfirmLine."Revised Amount / Percent";
                                        PayElements.VALIDATE("Pay Element Code", EmpConfirmLine."Revised Pay Element");
                                        PayElements."Pay Cadre" := EmpConfirmLine."Pay Cadre";
                                        PayElements."Active Pay Elements" := true;
                                        PayElements.INSERT();
                                    until PayElements.NEXT() = 0;
                            until EmpConfirmLine.NEXT() = 0;
                        InsertTempLeaves();
                        MESSAGE(Text003Lbl, "Employee ID");
                    end;
                }
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Document Status Release';

                    trigger OnAction();
                    begin
                        EmpConfirmHeaderRec.GET("Confirmation ID");
                        if (EmpConfirmHeaderRec.Status = EmpConfirmHeaderRec.Status::Release) then
                            ERROR(Text005Lbl)
                        else begin
                            EmpConfirmHeaderRec.Status := EmpConfirmHeaderRec.Status::Release;
                            EmpConfirmHeaderRec.MODIFY();
                        end;
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Document Status Re-Open';

                    trigger OnAction();
                    begin
                        EmpConfirmHeaderRec2.GET("Confirmation ID");
                        if (EmpConfirmHeaderRec2.Status = EmpConfirmHeaderRec2.Status::Open) then
                            ERROR(Text006Lbl)
                        else begin
                            EmpConfirmHeaderRec2.Status := EmpConfirmHeaderRec2.Status::Open;
                            EmpConfirmHeaderRec2.MODIFY();
                        end;
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortCutKey = 'Ctrl+P';
                ApplicationArea = all;
                ToolTip = 'Option to choose Print details';

                trigger OnAction();
                begin
                    EmpConfirmHeaderRec.RESET();
                    EmpConfirmHeaderRec.SETRANGE("Confirmation ID", "Confirmation ID");
                    EmpConfirmHeaderRec.SETRANGE("Employee ID", "Employee ID");
                    REPORT.RUNMODAL(33001270, true, false, EmpConfirmHeaderRec);
                end;
            }
        }
    }

    var
        EmpConfirmHeaderRec: Record "Employee Confirm. Header B2B";
        EmpConfirmHeaderRec2: Record "Employee Confirm. Header B2B";
        Employee: Record "Employee B2B";
        EmpConfirmLine: Record "Employee Confirmation Line B2B";
        PayElements: Record "Pay Elements B2B";
        PayElements2: Record "Pay Elements B2B";
        EmpConfirmLine2: Record "Employee Confirmation Line B2B";

        Text001Lbl: Label 'Do you want to update Pay Elements ?';

        Text003Lbl: Label 'Employee %1 has been confirmed successfully.', Comment = '%1 = Employee Id';

        Text004Lbl: Label 'Employee is already confirmed.';
        LineNum: Integer;
        Text005Lbl: Label 'Document is already Released';
        Text006Lbl: Label 'Document is already in Open status';
        Text007Lbl: Label 'Do you want to clear existing %1', Comment = '%1 = Leave Code';
        Text008Lbl: Label 'LEAVE YEAR';
        Text009Lbl: Label 'EMPLOYEED';

    local procedure EmployeeIDOnAfterValidate();
    begin
        ClearValues();
        EmpElements(Rec);
        CurrPage.UPDATE(true);
    end;

    local procedure DateofConfirmationOnAfterValid();
    begin
        EmpConfirmLine2.RESET();
        EmpConfirmLine2.SETRANGE("Header No.", "Confirmation ID");
        EmpConfirmLine2.SETRANGE("No.", "Employee ID");
        if EmpConfirmLine2.FINDSET() then
            repeat
                EmpConfirmLine2."Confirmation Date" := "Date of Confirmation";
                EmpConfirmLine2.MODIFY();
            until EmpConfirmLine2.NEXT() = 0;

        CurrPage.UPDATE();
    end;

    procedure ClearValues();
    var
        EmpcformLine: Record "Employee Confirmation Line B2B";
    begin
        EmpcformLine.RESET();
        EmpcformLine.SETRANGE("Header No.", "Confirmation ID");
        if EmpcformLine.FINDFIRST() then
            EmpcformLine.DELETEALL();
    end;

    procedure EmpElements(EmpConfirmHeader: Record "Employee Confirm. Header B2B");
    var
        PayElementRec: Record "Pay Elements B2B";
        EmployeeCFormLRec: Record "Employee Confirmation Line B2B";
    begin
        PayElements.RESET();
        PayElements.SETRANGE("Employee Code", EmpConfirmHeader."Employee ID");
        if PayElements.FINDLAST() then begin
            PayElementRec.RESET();
            PayElementRec.SETRANGE("Employee Code", EmpConfirmHeader."Employee ID");
            PayElementRec.SETRANGE("Effective Start Date", PayElements."Effective Start Date");
            if PayElementRec.FINDFIRST() then
                repeat
                    LineNum := 0;
                    EmpConfirmLine2.RESET();
                    EmpConfirmLine2.SETRANGE("Header No.", "Confirmation ID");
                    if EmpConfirmLine2.FINDLAST() then
                        LineNum := EmpConfirmLine2."Line No." + 10000
                    else
                        LineNum := 10000;
                    EmployeeCFormLRec.INIT();
                    EmployeeCFormLRec."Header No." := EmpConfirmHeader."Confirmation ID";
                    EmployeeCFormLRec."No." := "Employee ID";
                    EmployeeCFormLRec."Line No." := LineNum;
                    EmployeeCFormLRec."Pay Element" := PayElementRec."Pay Element Code";
                    EmployeeCFormLRec."Revised Pay Element" := PayElementRec."Pay Element Code";
                    EmployeeCFormLRec."Fixed / Percent" := PayElementRec."Fixed/Percent";
                    EmployeeCFormLRec."Amount / Percent" := PayElementRec."Amount / Percent";
                    EmployeeCFormLRec."Revised Amount / Percent" := PayElementRec."Amount / Percent";
                    EmployeeCFormLRec."Computation Type" := PayElementRec."Computation Type";
                    EmployeeCFormLRec."Revised Computation Type" := PayElementRec."Computation Type";
                    EmployeeCFormLRec."Starting Date" := PayElementRec."Effective Start Date";
                    EmployeeCFormLRec."Pay Cadre" := PayElementRec."Pay Cadre";
                    EmployeeCFormLRec."Employee Name" := EmpConfirmHeader."Employee Name";
                    EmployeeCFormLRec."Starting Date" := PayElementRec."Effective Start Date";
                    EmployeeCFormLRec."Add/Deduct" := PayElementRec."Add/Deduct";
                    EmployeeCFormLRec."Confirmation Date" := "Date of Confirmation";
                    LineNum += 10000;
                    EmployeeCFormLRec.INSERT();
                until PayElementRec.NEXT() = 0;

        end;
    end;

    procedure InsertTempLeaves();
    var
        PayrollYearRec: Record "Payroll Year B2B";
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        GradeWiseLeaves2: Record "Grade Wise Leaves B2B";
        TempEmpLeaves: Record "Employee Leaves B2B" temporary;
        StartDate: Date;

    begin
        if Employee.GET("Employee ID") then begin
            Employee."Leave Pay Cadre" := "Leave Pay Cadre";
            if not Employee."Leaves Not Generated" then
                Employee."Leaves Not Generated" := true;
            Employee.MODIFY();

            Employee.TESTFIELD("Leave Pay Cadre");
            Employee.TESTFIELD("Employment Date");
            GradeWiseLeaves2.RESET();
            GradeWiseLeaves2.SETRANGE(GradeWiseLeaves2."Leave Pay Cadre", "Leave Pay Cadre");
            GradeWiseLeaves2.SETRANGE(GradeWiseLeaves2."Crediting Type", GradeWiseLeaves2."Crediting Type"::"Before the Period");
            GradeWiseLeaves2.SETRANGE("Location Code", Employee."Location Code");
            if GradeWiseLeaves2.FINDFIRST() then
                repeat
                    TempEmpLeaves.INIT();
                    TempEmpLeaves."No." := Employee."No.";
                    TempEmpLeaves."Leave Pay Cadre" := "Leave Pay Cadre";
                    TempEmpLeaves."Leave Code" := GradeWiseLeaves2."Leave Code";
                    TempEmpLeaves."Leave Description" := GradeWiseLeaves2."Leave Description";
                    TempEmpLeaves."Leaves for the Current Period" := GradeWiseLeaves2."Leaves in Crediting Interval";

                    PayrollYearRec.RESET();
                    PayrollYearRec.SETRANGE("Year Type", Text008Lbl);
                    PayrollYearRec.SETRANGE(Closed, false);
                    PayrollYearRec.FINDFIRST();

                    GradeWiseLeaves.RESET();
                    GradeWiseLeaves.SETRANGE("Leave Code", TempEmpLeaves."Leave Code");
                    GradeWiseLeaves.SETRANGE("Leave Pay Cadre", Employee."Leave Pay Cadre");
                    GradeWiseLeaves.FINDFIRST();
                    if Employee."Employment Date" >= PayrollYearRec."Year Start Date" then begin
                        StartDate := Employee."Employment Date";
                        repeat
                            StartDate := CALCDATE(GradeWiseLeaves."Crediting Interval", StartDate);
                        until (Employee."Employment Date" < StartDate) or (StartDate > PayrollYearRec."Year End Date");
                    end;
                    TempEmpLeaves."Next Leave Period" := StartDate;
                    TempEmpLeaves.INSERT();
                    InsertEmpLeaves(TempEmpLeaves);
                until GradeWiseLeaves2.NEXT() = 0;

        end;
    end;

    procedure InsertEmpLeaves(TempEmpLeaveRec: Record "Employee Leaves B2B");
    var
        EmployeeRec: Record "Employee B2B";
        PayrollYearRec: Record "Payroll Year B2B";
        EmployeeLeaves: Record "Employee Leaves B2B";
        EmpLeaveHistory: Record "Detailed Leave Records B2B";
        EmpLeaveHistoryNum: Record "Detailed Leave Records B2B";
        HRSetup: Record "HR Setup B2B";
        Num: Integer;
    begin
        PayrollYearRec.RESET();
        PayrollYearRec.SETRANGE("Year Type", Text008Lbl);
        PayrollYearRec.SETRANGE(Closed, false);
        PayrollYearRec.FINDFIRST();

        if EmpLeaveHistoryNum.FINDLAST() then
            Num := EmpLeaveHistoryNum."Entry No." + 1
        else
            Num := 1;
        EmpLeaveHistory.RESET();
        EmpLeaveHistory.SETRANGE("Employee No.", TempEmpLeaveRec."No.");
        EmpLeaveHistory.SETRANGE("Leave Code", TempEmpLeaveRec."Leave Code");
        if EmpLeaveHistory.FINDSET() then
            if not CONFIRM(STRSUBSTNO(Text007Lbl, EmpLeaveHistory."Leave Code"), true) then
                exit
            else begin
                EmpLeaveHistory.DELETEALL();
                EmployeeLeaves.RESET();
                EmployeeLeaves.SETRANGE("No.", TempEmpLeaveRec."No.");
                EmployeeLeaves.SETRANGE("Leave Code", TempEmpLeaveRec."Leave Code");
                if EmployeeLeaves.FINDSET() then
                    EmployeeLeaves.DELETEALL();

            end;


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
        EmployeeRec: Record "Employee B2B";
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        StartDate: Date;
        EndDate: Date;
        TempDate: Date;
    begin
        PayrollYear.RESET();
        PayrollYear.SETRANGE("Year Type", Text008Lbl);
        PayrollYear.SETRANGE(Closed, false);
        if PayrollYear.FINDFIRST() then
            EndDate := PayrollYear."Year End Date";


        EmployeeRec.GET(EmpLeaves."No.");
        ProvLeaves.RESET();
        ProvLeaves.SETRANGE("Employee No.", EmpLeaves."No.");
        ProvLeaves.SETRANGE("Leave Code", EmpLeaves."Leave Code");
        if ProvLeaves.FINDSET() then
            ProvLeaves.DELETEALL();
        ProvLeaves.INIT();
        ProvLeaves."Employee No." := EmpLeaves."No.";
        ProvLeaves."Employee Name" := EmployeeRec."First Name";
        ProvLeaves."Leave Pay Cadre" := EmpHistory."Leave Pay Cadre";
        ProvLeaves."Leave Code" := EmpLeaves."Leave Code";
        ProvLeaves.Month := DATE2DMY(EmployeeRec."Employment Date", 2);
        ProvLeaves.Year := DATE2DMY(EmployeeRec."Employment Date", 3);
        ProvLeaves."Leave Descriptioon" := EmpLeaves."Leave Description";
        ProvLeaves."No.of Leaves" := EmpHistory."No. of Leaves";
        ProvLeaves."Remaining Leaves" := EmpHistory."No. of Leaves";
        ProvLeaves."Leave Year Start Date" := EmployeeRec."Employment Date";
        ProvLeaves."Leave Year End Date" := EndDate;
        ProvLeaves."Period Start Date" := EmployeeRec."Employment Date";
        ProvLeaves."Period End Date" := EmpLeaves."Next Leave Period" - 1;
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

