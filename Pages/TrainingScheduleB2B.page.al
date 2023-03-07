page 33001471 "Training Schedule B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Schedule';
    PageType = Document;
    SourceTable = "Training Schedule Header B2B";
    SourceTableView = WHERE("Training Created" = CONST(false));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ToolTip = 'Choose the unique Number for Training Schedule.';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit() then
                            CurrPage.UPDATE();
                    end;
                }
                field(Description; Description)
                {
                    ToolTip = 'Select the Description of the Training.';
                    ApplicationArea = all;
                }
                field(Period; Period)
                {
                    ToolTip = 'Choose the Period for the Training.';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Select the Department code for Training.';
                    ApplicationArea = all;
                    //Visible = false;
                }
                field("Training Topic"; "Training Topic")
                {
                    ToolTip = 'Choose the Training Topic to be given.';
                    ApplicationArea = all;
                }
                field("Training Topic Description"; "Training Topic Description")
                {
                    ToolTip = 'Specified the Training Topic Description.';
                    ApplicationArea = all;
                }
                field("Type of Training"; "Type of Training")
                {
                    ToolTip = 'Displays the type of training to be given.';
                    ApplicationArea = all;
                }
                field("Training Starting Date"; "Training Starting Date")
                {
                    ToolTip = 'Shows the Training the Start date.';
                    ApplicationArea = all;
                }
                field(Frequency; Frequency)
                {
                    ToolTip = 'Specifies the Frequency of Training.';
                    ApplicationArea = all;
                }
                field("Duration UOM"; "Duration UOM")
                {
                    ToolTip = 'Choose the Duration of the Training unit of measure Ex. 1hr,dayor week etc..';
                    ApplicationArea = all;
                }
                field("Training Duration"; "Training Duration")
                {
                    ToolTip = 'Choose the Duration of Training.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the Document type status open/Released.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Choose the Dimenision Value.';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Choose the Dimenision Value.';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Physical Location"; "Physical Location")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Physical Location for which the training is being provided';
                }
            }
            part(Control1102154020; "Training Schedule Subform B2B")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Training")
            {
                Caption = '&Training';
                Image = Salutation;
                action("Training Plan")
                {
                    ToolTip = 'Specifies the Training.';
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
                ToolTip = 'Specifies the Functions.';
                Caption = 'F&unctions';
                Image = "Action";
                action("Get Employees")
                {
                    ToolTip = 'Specifies the Get Employees for Training.';
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
                separator(Separator1102154009)
                {
                }
                action("Create Training")
                {
                    ToolTip = ' Shows the Create Training Schedule.';
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
                separator(Separator1102154024)
                {
                }
                action("Re&lease")
                {
                    ToolTip = 'Show the Document in Release state.';
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
                    ToolTip = 'Shows the Document can Re-open.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        ReopenDocument();
                    end;
                }
            }
        }
    }

    var
        Text001Lbl: Label 'Training Need Identification is not defined for %1 %2.', Comment = '%1 = Training Topic caption ; %2 = Trainning Topic';
        Text002Lbl: Label 'Trainings %1 to %2 created', Comment = '%1 =  ; %2 = ';
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
        TESTFIELD("Training Topic");  //B2BDNROn22Feb2023
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
        EmployeeTrainingNeedIden.SetRange("Type of Training", "Type of Training");//B2BMMOn21Feb2023
        if EmployeeTrainingNeedIden.FindFirst() then//B2BMMOn21Feb2023
            repeat
                //B2BDNROn22Feb2023>>
                // if not (("Global Dimension 1 Code" <> '') and      
                //((Employee.GET(EmployeeTrainingNeedIden."Employee Code") and
                //(Employee."Global Dimension 1 Code" <> "Global Dimension 1 Code")))) then begin
                EmpTrainingNeedHeader.SETRANGE("Employee No.", EmployeeTrainingNeedIden."Employee Code");
                // if not EmpTrainingNeedHeader.IsEmpty() then begin  
                //B2BDNROn22Feb2023<<  
                TempLineNo += 10000;
                TrainingLine.INIT();
                TrainingLine."Document No." := "No.";
                TrainingLine."Line No." := TempLineNo;
                TrainingLine.VALIDATE("Employee Code", EmployeeTrainingNeedIden."Employee Code");
                TrainingLine.Period := EmployeeTrainingNeedIden.Period;
                TrainingLine.INSERT();
            // end;
            //end;
            until EmployeeTrainingNeedIden.NEXT() = 0
        else
            ERROR(Text001Lbl, FIELDCAPTION("Training Topic"), "Training Topic");
        CurrPage.UPDATE(false);
    end;

    procedure OpenTrainingPlan();
    var
        TrainingPlan: Record "Training Schedule Plan B2B";
        TempDate: Date;
        TempLineNo: Integer;
        TrainingSchHdr: Record "Training Schedule Header B2B";
        I: Decimal;
        StartDate: Date;
    begin
        TESTFIELD(Period);
        TESTFIELD("Training Starting Date");
        TESTFIELD(Frequency);

        TrainingPlan.RESET();
        TrainingPlan.SETRANGE(Type, TrainingPlan.Type::Dates);
        TrainingPlan.SETRANGE("Document No.", "No.");
        if not TrainingPlan.FINDFIRST() then begin
            TempDate := "Training Starting Date";

            repeat
                StartDate := TempDate;
                FOR I := 1 TO "Training Duration" DO BEGIN
                    TrainingPlan.INIT();
                    TrainingPlan.Type := TrainingPlan.Type::Dates;
                    TrainingPlan."Document No." := "No.";
                    TempLineNo += 10000;
                    TrainingPlan."Line No." := TempLineNo;
                    TrainingPlan."Training Date" := TempDate;
                    TempDate := TempDate + 1;
                    TrainingPlan.INSERT();
                end;
                TempDate := CALCDATE(Frequency, StartDate);
            until TempDate > "To Date";
        end;

        TrainingPlan.RESET();
        TrainingPlan.SETRANGE("Document No.", "No.");
        TrainingPlan.SETRANGE(Type, TrainingPlan.Type::Dates);
        PAGE.RUN(33001474, TrainingPlan);
    end;

    procedure CreateTraining();
    var
        TrainingHeader: Record "Training Header B2B";
        TrainingPlanLine: Record "Training Schedule Line B2B";
        TrainingLine: Record "Training Line B2B";
        TrainingPlan: Record "Training Schedule Plan B2B";
        EmployeeTrainingNeedIden: Record "Emp. Train Need Iden. Line B2B";
        TempLineNo: Integer;
        FromNo: Code[20];
        TempDuration: Decimal;
        Month: Integer;
        Year: Integer;
        StartDate: Date;
        EndDate: Date;
        TrainingPlan1: Record "Training Schedule Plan B2B";
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
                Month := Date2DMY(TrainingPlan."Training Date", 2);
                Year := Date2DMY(TrainingPlan."Training Date", 3);
                StartDate := DMY2Date(01, Month, Year);
                EndDate := CalcDate('CM', StartDate);
                TrainingPlan1.Reset();
                TrainingPlan1.SETRANGE(Type, TrainingPlan.Type::Dates);
                TrainingPlan1.SETRANGE("Document No.", "No.");
                TrainingPlan1.SetRange("Training Date", StartDate, EndDate);
                TrainingPlan1.SetCurrentKey("Training Date");
                if TrainingPlan1.FindLast() then
                    TrainingHeader.VALIDATE("Actual Ending Date", TrainingPlan1."Training Date");
                //TrainingHeader.VALIDATE("Actual Ending Date", CALCDATE(FORMAT(TempDuration) + 'D', TrainingPlan."Training Date"));
                TrainingHeader."Training Schedule No." := "No.";
                TrainingHeader."Global Dimension 1" := "Global Dimension 1 Code";
                TrainingHeader."Global Dimension 2" := "Global Dimension 2 Code";
                TrainingHeader."Physical Location" := "Physical Location";
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

