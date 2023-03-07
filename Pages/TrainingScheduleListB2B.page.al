page 33001473 "Training Schedule List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Schedule List';
    CardPageID = "Training Schedule B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Training Schedule Header B2B";
    SourceTableView = WHERE("Training Created" = CONST(false));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                Editable = false;
                field("No."; "No.")
                {
                    ToolTip = 'Unquie No sereis for Traning Schedule.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Shows the Description of the Training Schedule.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Choose the dimension values for Training.';
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Choose the Dimenision Value.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Physical Location for which the training is being provided';
                }
                field(Frequency; Frequency)
                {
                    ToolTip = 'Specifies the Frequency of Training.';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Choose the Start date of Training.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Choose the End Date of Training Schedule.';
                    ApplicationArea = all;
                }
                field("Type of Training"; "Type of Training")
                {
                    ToolTip = 'Spedifies The Type of Trainig.';
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Training")
            {
                ToolTip = 'Specifies The training.';
                Caption = '&Training';
                Image = Salutation;
                action("Training Plan")
                {
                    ToolTip = 'Specifies the Training plan for employees.';
                    Caption = 'Training Plan';
                    Image = Planning;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        OpenTrainingPlan();
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get Employees")
                {
                    ToolTip = ' Get Employees who needs the Training.';
                    Caption = 'Get Employees';
                    Image = Employee;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        GetEmployees();
                    end;
                }
                separator(Separator1102152004)
                {
                }
                action("Create Training")
                {
                    ToolTip = 'Create Training schedule for employees.';
                    Caption = 'Create Training';
                    Image = CreateReminders;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        CreateTraining();
                    end;
                }
                separator(Separator1102152002)
                {
                }
                action("Re&lease")
                {
                    ToolTip = 'Shows the Document in release state.';
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        ReleaseDocument();
                    end;
                }
                action("Re&open")
                {
                    ToolTip = 'shows the Dcouments state in re-open.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        if "Training Created" then
                            PAGE.RUNMODAL(PAGE::"Update Daily Time Punches B2B", Rec);
                    end;
                }
            }
        }
    }

    var
        Text001Lbl: Label 'Training Need Identification is not defined for %1', Comment = '%1 = Training Topic';
        Text002Lbl: Label 'Trainings %1 to %2 created', Comment = '%1 =  FormNo; %2 = No';
        Text003Lbl: Label 'Training plan not defined.';
        Text004Lbl: Label 'Already employees exist. Do you want to delete those Employees ?';

    procedure GetEmployees();
    var
        TrainingLine: Record "Training Schedule Line B2B";
        EmployeeTrainingNeedIden: Record "Emp. Train Need Iden. Line B2B";
        Employee: Record "Employee B2B";
        EmpTrainingNeedHeader: Record "Employee PerformanceHeader B2B";
        TempLineNo: Integer;
    begin
        TESTFIELD("Type of Training");
        TestStatus();

        TrainingLine.RESET();
        TrainingLine.SETRANGE("Document No.", "No.");
        if TrainingLine.FINDFIRST() then
            if CONFIRM(Text004Lbl) then
                TrainingLine.DELETEALL(true);

        CLEAR(TempLineNo);
        TrainingLine.RESET();
        TrainingLine.SETRANGE("Document No.", "No.");
        if TrainingLine.FINDLAST() then
            TempLineNo := TrainingLine."Line No.";

        EmployeeTrainingNeedIden.RESET();
        EmployeeTrainingNeedIden.SETRANGE("Training Topic", "Training Topic");
        EmployeeTrainingNeedIden.SetRange("Type of Training", "Type of Training");
        if EmployeeTrainingNeedIden.FINDFIRST() then
            repeat
                if not (("Global Dimension 1 Code" <> '') and
                   ((Employee.GET(EmployeeTrainingNeedIden."Employee Code") and
                    (Employee."Global Dimension 1 Code" <> "Global Dimension 1 Code")))) then begin
                    EmpTrainingNeedHeader.SETRANGE("Employee No.", EmployeeTrainingNeedIden."Employee Code");
                    if not EmpTrainingNeedHeader.IsEmpty() then begin
                        TempLineNo += 10000;
                        TrainingLine.INIT();
                        TrainingLine."Document No." := "No.";
                        TrainingLine."Line No." := TempLineNo;
                        TrainingLine.VALIDATE("Employee Code", EmployeeTrainingNeedIden."Employee Code");
                        TrainingLine.Period := EmployeeTrainingNeedIden.Period;
                        TrainingLine.INSERT();
                    end;
                end;
            until EmployeeTrainingNeedIden.NEXT() = 0
        else
            ERROR(Text001Lbl, "Training Topic");
        CurrPage.UPDATE(false);
    end;

    procedure OpenTrainingPlan();
    var
        TrainingPlan: Record "Training Schedule Plan B2B";
        TempDate: Date;
        TempLineNo: Integer;
    begin
        TESTFIELD(Period);
        TESTFIELD("Training Starting Date");
        TESTFIELD(Frequency);

        TrainingPlan.RESET();
        TrainingPlan.SETRANGE(Type, TrainingPlan.Type::Dates);
        TrainingPlan.SETRANGE("Document No.", "No.");
        if not TrainingPlan.FINDFIRST() then
            TempDate := "Training Starting Date";
        repeat
            TrainingPlan.INIT();
            TrainingPlan.Type := TrainingPlan.Type::Dates;
            TrainingPlan."Document No." := "No.";
            TempLineNo += 10000;
            TrainingPlan."Line No." := TempLineNo;
            TrainingPlan."Training Date" := TempDate;
            TrainingPlan.INSERT();
            TempDate := CALCDATE(Frequency, TempDate);
        until TempDate > "To Date";


        TrainingPlan.RESET();
        TrainingPlan.SETRANGE("Document No.", "No.");
        TrainingPlan.SETRANGE(Type, TrainingPlan.Type::Dates);
        PAGE.RUN(33001474, TrainingPlan);
    end;

    procedure CreateTraining();
    var
        TrainingPlanLine: Record "Training Schedule Line B2B";
        EmployeeTrainingNeedIden: Record "Emp. Train Need Iden. Line B2B";
        TrainingHeader: Record "Training Header B2B";
        TrainingLine: Record "Training Line B2B";
        TrainingPlan: Record "Training Schedule Plan B2B";
        TrainingPlan1: Record "Training Schedule Plan B2B";
        TempDuration: Decimal;
        FromNo: Code[20];
        TempLineNo: Integer;
    // Month: Integer;
    // Year: Integer;
    // StartDate: Date;
    // EndDate: Date;
    begin
        TESTFIELD(Status, Status::Released);
        TrainingPlan.RESET();
        TrainingPlan.SETRANGE(Type, TrainingPlan.Type::Dates);
        TrainingPlan.SETRANGE("Document No.", "No.");
        if TrainingPlan.FINDFIRST() then begin
            repeat
                TempLineNo := 10000;
                TrainingHeader.INIT();
                TrainingHeader."No." := '';
                TrainingHeader.INSERT(true);
                TrainingHeader.VALIDATE("Course Name", Description);
                TrainingHeader.VALIDATE("Training Type", "Type of Training");
                TrainingHeader.VALIDATE("Need  for Training", "Training Topic");
                TrainingHeader.VALIDATE(Department, TrainingPlanLine."Department Code");
                TrainingHeader.VALIDATE(Duration, "Training Duration");
                TrainingHeader.VALIDATE("Duration UOM", "Duration UOM");
                TrainingHeader.VALIDATE("Actual Starting Date", TrainingPlan."Training Date");
                if "Duration UOM" = "Duration UOM"::Hours then
                    TempDuration := "Training Duration" div 8
                else
                    TempDuration := "Training Duration" - 1;
                TrainingHeader."Training Schedule No." := "No.";
                TrainingHeader.MODIFY(true);
                if FromNo = '' then
                    FromNo := TrainingHeader."No.";
                TrainingPlanLine.RESET();
                TrainingPlanLine.SETRANGE("Document No.", "No.");
                if TrainingPlanLine.FINDFIRST() then
                    repeat
                        TrainingLine.INIT();
                        TrainingLine."Training Header No." := TrainingHeader."No.";
                        TrainingLine."Training Line No." := TempLineNo;
                        TempLineNo += 10000;
                        TrainingLine.VALIDATE("Employee No.", TrainingPlanLine."Employee Code");
                        TrainingLine."From Date" := "From Date";
                        TrainingLine."To Date" := "To Date";
                        TrainingLine.INSERT(true);
                        EmployeeTrainingNeedIden.RESET();
                        EmployeeTrainingNeedIden.SETRANGE("Training Topic", "Training Topic");
                        EmployeeTrainingNeedIden.SETRANGE("Employee Code", TrainingPlanLine."Employee Code");
                        EmployeeTrainingNeedIden.SETRANGE(Period, TrainingPlanLine.Period);
                        if EmployeeTrainingNeedIden.FINDFIRST() then begin
                            EmployeeTrainingNeedIden."Training Created" := true;
                            EmployeeTrainingNeedIden.MODIFY();
                        end;
                    until TrainingPlanLine.NEXT() = 0;
            until TrainingPlan.NEXT() = 0;
            if FromNo <> '' then begin
                "Training Created" := true;
                MODIFY();
            end;
            MESSAGE(Text002Lbl, FromNo, TrainingHeader."No.");
        end else
            ERROR(Text003Lbl);
    end;

    procedure ReleaseDocument();
    begin
        if Status = Status::Open then begin
            TESTFIELD(Frequency);
            TESTFIELD("Training Starting Date");
            TESTFIELD(Period);
            TESTFIELD("Type of Training");
            TESTFIELD("Training Topic");
            Status := Status::Released;
            Evaluate("Released By", USERID());
            "Released Date" := workdate();
            MODIFY();
        end;
    end;

    procedure ReopenDocument();
    begin
        if Status = Status::Released then begin
            Status := Status::Open;
            MODIFY();
        end;
    end;
}

