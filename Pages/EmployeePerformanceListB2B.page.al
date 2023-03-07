page 33001470 "Employee Performance List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Performance List';
    CardPageID = "Employee Performance B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Employee PerformanceHeader B2B";
    SourceTableView = SORTING("Apprisal No")
                      WHERE(Type = CONST("Performance Appraisal"));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Apprisal No"; "Apprisal No")
                {
                    ToolTip = 'Choose the unquie Number Series.';
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee Number.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Specifies the Type to be choosed from drop down.';
                    ApplicationArea = all;
                }
                field(Period; Period)
                {
                    ToolTip = 'Specifies the Period of Performance.';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Choose the Performance Start date.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Choose the End date.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Performance")
            {
                ToolTip = 'Specifies the performances of employee.';
                Caption = '&Performance';
                Image = Capacity;
                action(Log)
                {
                    Caption = 'Log';
                    Image = Log;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ToolTip = 'Specifies Log';
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
                    ToolTip = 'Shows the Status of document in release state.';
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
                        EmpPerformanceRelease.ReleaseDocument(Rec);
                    end;
                }
                action("Re&open")
                {
                    ToolTip = 'Specifies the Re-open of the document.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        EmpPerformanceRelease.ReopenDocument(Rec);
                    end;
                }
                separator(Separator1102152014)
                {
                }
                action("Calculate Weightages")
                {
                    ToolTip = 'Specifies the Calculate Weightages.';
                    Caption = 'Calculate Weightages';
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
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
                separator(Separator1102152012)
                {
                }
                action("Self Rating")
                {
                    ToolTip = 'Specifies the Performance of Self Rating.';
                    Caption = 'Self Rating';
                    Image = User;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
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
                    ToolTip = 'Specifies Employee peroformance for hod rating.';
                    Caption = 'HOD Rating';
                    Image = SalesPerson;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
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
                    ToolTip = ' Get Questionarie for performance.';
                    Caption = 'Get Questionarie';
                    Image = Questionaire;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
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
            }
            group("&Print")
            {
                ToolTip = 'Specifies the print document.';
                Caption = '&Print';
                Image = Print;
                action("Performance &Apprisal")
                {
                    ToolTip = 'Specifies the Performance or Apprisal.';
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
            }
        }
    }

    var

        EmpPerformLineGRec: Record "Employee Performance Line B2B";
        EmpPerforLineGrec: Record "Employee Performance Line B2B";
        EmpPerfoHeaderGRec: Record "Employee PerformanceHeader B2B";
        QuestLineRec: Record "Questionnaire Line B2B";
        EmpPerformanceRelease: Codeunit "Emp Performance Release B2B";
        LineNum: Integer;
        SNum: Integer;
        SelfRatingTotal: Decimal;
        HodRatingTotal: Decimal;
        TotalAchivement: Decimal;
        Text001Lbl: Label 'Please Define Question ID';
}

