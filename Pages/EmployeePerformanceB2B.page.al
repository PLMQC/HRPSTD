page 33001465 "Employee Performance B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Performance';
    PageType = Document;
    SourceTable = "Employee PerformanceHeader B2B";
    SourceTableView = WHERE(Type = CONST("Performance Appraisal"));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Apprisal No"; "Apprisal No")
                {
                    ToolTip = 'Unique Number Series for Apprisal.';
                    ApplicationArea = all;
                    trigger OnAssistEdit();
                    begin
                        AssistEdit(xRec);
                        CurrPage.UPDATE();
                    end;
                }
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee Number.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Specifies the Employee Name.';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Choose the Department code of employee.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Choose the Physical location of the Employee.';
                    ApplicationArea = all;
                }
                field("Total Defined Weightage"; "Total Defined Weightage")
                {
                    ToolTip = 'Specifies the Total Defined weightage for Employee Performance.';
                    ApplicationArea = all;
                }
                field("Total Self Rating"; "Total Self Rating")
                {
                    ToolTip = 'Specifies total of self rating in performance.';
                    ApplicationArea = all;
                }
                field("Total HOD Rating"; "Total HOD Rating")
                {
                    ToolTip = 'Specifies Total of HOD Rating for the performance.';
                    ApplicationArea = all;
                }
                field("Period Type"; "Period Type")
                {
                    ToolTip = 'SPcifies the Period Type.';

                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        if "Period Type" = "Period Type"::Yearly then begin
                            "From DateEditable" := false;
                            "To DateEditable" := false;
                            PeriodEditable := true;
                        end else begin
                            "From DateEditable" := true;
                            "To DateEditable" := true;
                            PeriodEditable := false;
                        end;
                    end;
                }
                field(Period; Period)
                {
                    ToolTip = 'Specifies the period.';
                    Editable = PeriodEditable;
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Specifies the Start Date.';
                    Editable = "From DateEditable";
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Specifies the End Date.';
                    Editable = "To DateEditable";
                    ApplicationArea = all;
                }
                field("Date of Joining"; "Date of Joining")
                {
                    ToolTip = 'Spcifies the Date of joining of the Employee.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Shows the status of the Document is open/Released.';
                    ApplicationArea = all;
                }
                field("Apprisar ID"; "Apprisar ID")
                {
                    ToolTip = 'Choose Apprisar ID. ';
                    ApplicationArea = all;
                }
                field("Total Achivements"; "Total Achivements")
                {
                    ToolTip = 'Specifies the Total Achivements of the employee.';
                    Caption = 'Total Achivements';
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Question ID"; "Question ID")
                {
                    ToolTip = 'Choose the Question ID.';
                    ApplicationArea = all;
                }
                field("Auto Generate Appraisal doc"; "Auto Generate Appraisal doc")
                {
                    ToolTip = 'Generate Appraisal Document of the Employee.';
                    Visible = false;
                    ApplicationArea = all;
                }

                field("Apprisal Posting Date"; "Apprisal Posting Date")
                {
                    ToolTip = 'Choose Apprisal posting date.';
                    Caption = 'Apprisal Posting Date';
                    ApplicationArea = all;
                }

                field(Designation; Designation)
                {
                    ToolTip = 'Choose the Designation of the Employee.';
                    Caption = 'Designation';
                    Editable = false;
                    ApplicationArea = all;
                }

                field("New Designtion"; "New Designtion")
                {
                    ToolTip = 'Choose the New Designation of the Employee.';
                    Caption = 'New Designtion';
                    ApplicationArea = all;
                }

            }
            part("Employee Performance Subform"; "Employee Perfor. Subform B2B")
            {

                Caption = 'Employee Performance Subform';
                SubPageLink = "Appraisal No." = FIELD("Apprisal No");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Performance")
            {
                Caption = '&Performance';
                Image = Capacity;
                action(Log)
                {
                    ToolTip = 'Specifies the Performance.';
                    Caption = 'Log';
                    Image = Log;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Emp Performance Log B2B";
                    RunPageLink = "Employee Code" = FIELD("Employee No."),
                                  Period = FIELD(Period),
                                  "Appraisal No." = FIELD("Apprisal No");
                    RunPageMode = Edit;
                    ApplicationArea = all;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document Status Release';

                    trigger OnAction();
                    begin
                        rec.TestField(Status, rec.Status::Open);
                        EmpPerformanceRelease.ReleaseDocument(Rec);
                    end;
                }
                action("Re&open")
                {
                    Tooltip = 'Re-opens the document.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        rec.TestField(Status, rec.Status::Released);
                        EmpPerformanceRelease.ReopenDocument(Rec);
                    end;
                }
                separator(Separator1102154026)
                {
                }
                action("Calculate Weightages")
                {
                    Tooltip = 'calculates the weightage of Employee.';
                    Caption = 'Calculate Weightages';
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        rec.TestField(Status, rec.Status::Open);
                        SelfRatingTotal := 0;
                        HodRatingTotal := 0;
                        TotalAchivement := 0;
                        EmpPerforLineGrec.RESET();
                        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Apprisal No");
                        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
                        EmpPerforLineGrec.SETRANGE(Period, Period);
                        EmpPerforLineGrec.SETRANGE(EmpPerforLineGrec."KRA Type", EmpPerforLineGrec."KRA Type"::Answer);
                        if EmpPerforLineGrec.FINDFIRST() then
                            repeat
                                SelfRatingTotal += EmpPerforLineGrec."Total Self Rating";
                                HodRatingTotal += EmpPerforLineGrec."Total HOD Rating";
                                TotalAchivement += EmpPerforLineGrec."Total Target Achived";
                            until EmpPerforLineGrec.NEXT() = 0;

                        EmpPerforLineGrec.RESET();
                        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Apprisal No");
                        EmpPerforLineGrec.SETRANGE(EmpPerforLineGrec."KRA Type", EmpPerforLineGrec."KRA Type"::"End");
                        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
                        EmpPerforLineGrec.SETRANGE(Period, Period);
                        if EmpPerforLineGrec.FINDFIRST() then begin
                            EmpPerforLineGrec."Total Self Rating" := SelfRatingTotal;
                            EmpPerforLineGrec."Total HOD Rating" := HodRatingTotal;
                            EmpPerforLineGrec."Total Target Achived" := TotalAchivement;
                            EmpPerforLineGrec.MODIFY();
                        end;
                        "Total Self Rating" := SelfRatingTotal;
                        "Total HOD Rating" := HodRatingTotal;
                        MODIFY();
                        CurrPage.UPDATE();
                    end;
                }
                separator(Separator1102154029)
                {
                }
                action("Self Rating")
                {
                    Tooltip = 'Specifies the Self rating given by employee.';
                    Caption = 'Self Rating';
                    Image = User;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        rec.TestField(Status, rec.Status::Open);
                        EmpPerformLineGRec.RESET();
                        EmpPerformLineGRec.SETRANGE("Appraisal No.", "Apprisal No");
                        EmpPerformLineGRec.SETRANGE("Employee No.", "Employee No.");
                        EmpPerformLineGRec.SETRANGE(Period, Period);
                        if EmpPerformLineGRec.FINDFIRST() then
                            PAGE.RUNMODAL(PAGE::"Employee Perfor. SelfRev B2B", EmpPerformLineGRec);
                    end;
                }
                action("HOD Rating")
                {
                    Tooltip = 'Spcifies the HOD Rating given to employee.';
                    Caption = 'HOD Rating';
                    Image = SalesPerson;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        rec.TestField(Status, rec.Status::Open);
                        EmpPerformLineGRec.RESET();
                        EmpPerformLineGRec.SETRANGE("Appraisal No.", "Apprisal No");
                        EmpPerformLineGRec.SETRANGE("Employee No.", "Employee No.");
                        EmpPerformLineGRec.SETRANGE(Period, Period);
                        if EmpPerformLineGRec.FINDFIRST() then
                            PAGE.RUNMODAL(PAGE::"Employee Perfor. HODRev B2B", EmpPerformLineGRec);
                    end;
                }
                action("Get Questionarie")
                {
                    ToolTip = 'It brings the questionarie for employee performance.';
                    Caption = 'Get Questionarie';
                    Image = Questionaire;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        rec.TestField(Status, rec.Status::Open);
                        EmpPerformLineGRec.SETRANGE("Appraisal No.", "Apprisal No");
                        if EmpPerformLineGRec.FINDLAST() then
                            LineNum := EmpPerformLineGRec."Line No."
                        else
                            LineNum := 10000;
                        SNum := 0;
                        EmpPerformLineGRec.INIT();
                        EmpPerformLineGRec."Appraisal No." := "Apprisal No";
                        EmpPerformLineGRec.VALIDATE("Serial No.", SNum);
                        EmpPerformLineGRec."Line No." := LineNum;
                        EmpPerformLineGRec."KRA Type" := EmpPerformLineGRec."KRA Type"::"Begin";
                        EmpPerformLineGRec.INSERT();

                        SNum := 1;
                        QuestLineRec.RESET();
                        QuestLineRec.SETRANGE("Profile Questionnaire Code", "Question ID");
                        if QuestLineRec.FINDFIRST() then begin
                            repeat
                                EmpPerformLineGRec.INIT();
                                EmpPerformLineGRec."Appraisal No." := "Apprisal No";
                                EmpPerformLineGRec.VALIDATE("Serial No.", SNum);
                                EmpPerformLineGRec."Line No." := LineNum + 10000;
                                EmpPerformLineGRec."Employee No." := "Employee No.";
                                EmpPerformLineGRec."KRA Type" := QuestLineRec.Type;
                                EmpPerformLineGRec."KRA Points" := QuestLineRec.Description;
                                SNum += 1;
                                EmpPerformLineGRec.INSERT();

                                LineNum += 10000;
                            until QuestLineRec.NEXT() = 0;
                            EmpPerformLineGRec.INIT();
                            EmpPerformLineGRec."Appraisal No." := "Apprisal No";
                            EmpPerformLineGRec.VALIDATE("Serial No.", SNum);
                            EmpPerformLineGRec."Line No." := LineNum + 10000;
                            EmpPerformLineGRec."KRA Type" := EmpPerformLineGRec."KRA Type"::"End";
                            EmpPerformLineGRec.INSERT();

                        end else
                            ERROR(Text001Lbl);
                    end;
                }
                action(Post)
                {
                    ToolTip = 'post the document.';
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        if "Apprisal Posting Date" <> 0D then
                            Error('Already Posted') else
                            "Apprisal Posting Date" := TODAY();
                        if "Apprisal Posting Date" <> 0D then
                            if EmployeeB2BGRec.Get("Employee No.") then begin
                                EmployeeB2BGRec."Last Appraisal Date" := "Apprisal Posting Date";
                                EmployeeB2BGRec."Last Appraisal Date" := EmployeeB2BGRec."Last Appraisal Date";
                                if EmployeeB2BGRec."Period Type" = EmployeeB2BGRec."Period Type"::Quarterly then
                                    EmployeeB2BGRec."Next Appraisal Date" := CalcDate('<3M>', "Apprisal Posting Date");
                                if EmployeeB2BGRec."Period Type" = EmployeeB2BGRec."Period Type"::"Half Yearly" then
                                    EmployeeB2BGRec."Next Appraisal Date" := CalcDate('<6M>', "Apprisal Posting Date");
                                if EmployeeB2BGRec."Period Type" = EmployeeB2BGRec."Period Type"::Yearly then
                                    EmployeeB2BGRec."Next Appraisal Date" := CalcDate('<12M>', "Apprisal Posting Date");
                                IF "New Designtion" <> '' then
                                    EmployeeB2BGRec.Designation := "New Designtion";

                                EmployeeB2BGRec.Modify();
                                rec.Status := rec.status::Posted;
                                rec.Modify();
                                Message(Text002Lbl);

                            end;




                    end;
                }
            }
            group("&Print")
            {
                ToolTip = 'Print the Document.';
                Caption = '&Print';
                Image = Print;
                action("Performance &Apprisal")
                {
                    ToolTip = 'specifies the performance and apprisal.';
                    Caption = 'Performance &Apprisal';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        EmpPerfoHeaderGRec.RESET();
                        EmpPerfoHeaderGRec.SETRANGE("Employee No.", "Employee No.");
                        EmpPerfoHeaderGRec.SETRANGE("Apprisal No", "Apprisal No");
                        REPORT.RUNMODAL(33001283, true, false, EmpPerfoHeaderGRec);
                    end;
                }
                action("Process Completed")
                {
                    ToolTip = 'Shows the process completed.';
                    Caption = 'Process Completed';
                    Image = Process;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction();
                    begin
                        if EmployeeGRec.Get("Employee No.") then begin
                            EmployeeGRec."Last Appraisal Date" := TODAY();
                            if EmployeeGRec."Period Type" = EmployeeGRec."Period Type"::Quarterly then
                                EmployeeGRec."Next Appraisal Date" := CalcDate('<3M>', TODAY());

                            if EmployeeGRec."Period Type" = EmployeeGRec."Period Type"::"Half Yearly" then
                                EmployeeGRec."Next Appraisal Date" := CalcDate('<6M>', TODAY());

                            if EmployeeGRec."Period Type" = EmployeeGRec."Period Type"::Yearly then
                                EmployeeGRec."Next Appraisal Date" := CalcDate('<1Y>', TODAY());
                            EmployeeGRec.Modify();

                        end;

                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        PeriodEditable := true;
        "To DateEditable" := true;
        "From DateEditable" := true;
    end;

    trigger OnOpenPage();
    begin
        if "Period Type" = "Period Type"::Yearly then begin
            "From DateEditable" := false;
            "To DateEditable" := false;
            PeriodEditable := true;
        end else begin
            "From DateEditable" := true;
            "To DateEditable" := true;
            PeriodEditable := false;
        end;
    end;

    trigger OnAfterGetRecord()
    begin

    end;

    var
        EmpPerformLineGRec: Record "Employee Performance Line B2B";
        EmpPerforLineGrec: Record "Employee Performance Line B2B";
        EmpPerfoHeaderGRec: Record "Employee PerformanceHeader B2B";
        EmployeeGRec: Record "Employee B2B";
        EmployeeB2BGRec: Record "Employee B2B";
        QuestLineRec: Record "Questionnaire Line B2B";
        EmpPerformanceRelease: Codeunit "Emp Performance Release B2B";
        LineNum: Integer;
        SNum: Integer;
        [InDataSet]
        "From DateEditable": Boolean;
        [InDataSet]
        "To DateEditable": Boolean;
        [InDataSet]
        PeriodEditable: Boolean;
        SelfRatingTotal: Decimal;
        HodRatingTotal: Decimal;
        TotalAchivement: Decimal;
        Text001Lbl: Label 'Please Define Question ID';
        Text002Lbl: Label 'Document Posted Successfully.';
}

