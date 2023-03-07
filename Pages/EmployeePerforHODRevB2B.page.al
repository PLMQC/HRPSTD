page 33001468 "Employee Perfor. HODRev B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Performance HOD Rev';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Employee Performance Line B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Specifies the Employee name.';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Serial No."; "Serial No.")
                {
                    ToolTip = 'Shows the Sequence Numbers.';
                    Editable = false;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field("KRA Type"; "KRA Type")
                {
                    ToolTip = 'Choose the KRA Type.';
                    Editable = false;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field("KRA Points"; "KRA Points")
                {
                    ToolTip = 'Specifies the KRA Points.';
                    Editable = "KRA PointsEditable";
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field("Total Target"; "Total Target")
                {
                    ToolTip = 'Shows the Total Target of performance.';
                    Editable = false;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field(Weightage; Weightage)
                {
                    ToolTip = 'Specifies the Weightage of performance.';
                    Editable = false;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field("Self Rating"; "Self Rating")
                {
                    ToolTip = 'Shows the Self rating for the performance.';
                    Editable = false;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field("HOD Rating"; "HOD Rating")
                {
                    ToolTip = 'Choose the Head of department rating for performance.';
                    Editable = HODRatingEditable;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                    trigger OnValidate()
                    Begin
                        "Total HOD Rating" := "HOD Rating" * Weightage;
                    end;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin

                        if "KRA Type" = "KRA Type"::Answer then begin
                            LookUpGrec.RESET();
                            LookUpGrec.SETRANGE("Lookup Type", 9);
                            if PAGE.RUNMODAL(33001193, LookUpGrec) = ACTION::LookupOK then begin
                                "HOD Rating" := LookUpGrec."Performance Scale Value";
                                "Total HOD Rating" := "HOD Rating" * Weightage;
                            end;
                        end;
                    end;
                }
                field("Total HOD Rating"; "Total HOD Rating")
                {
                    ToolTip = 'Specfies the Total of Head of Department Rating.';
                    Editable = false;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Update")
            {
                Caption = '&Update';
                action("&HOD Rating")
                {
                    ToolTip = 'Specifies the Head of Department rating.';
                    Caption = '&HOD Rating';
                    Image = Reminder;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        HodRatingTotal := 0;
                        RatingTotal := 0;
                        EmpPerforLineGrec.RESET();
                        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Appraisal No.");
                        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
                        EmpPerforLineGrec.SETRANGE(Period, Period);
                        EmpPerforLineGrec.SETRANGE("KRA Type", "KRA Type"::Answer);
                        if EmpPerforLineGrec.FINDFIRST() then
                            repeat
                                HodRatingTotal += EmpPerforLineGrec."HOD Rating";
                                RatingTotal += EmpPerforLineGrec."Total HOD Rating";
                            until EmpPerforLineGrec.NEXT() = 0;

                        EmpPerforLineGrec.RESET();
                        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Appraisal No.");
                        EmpPerforLineGrec.SETRANGE("KRA Type", "KRA Type"::"End");
                        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
                        EmpPerforLineGrec.SETRANGE(Period, Period);
                        if EmpPerforLineGrec.FINDFIRST() then begin
                            EmpPerforLineGrec."HOD Rating" := HodRatingTotal;
                            EmpPerforLineGrec.MODIFY();
                        end;

                        EmpPerforHeaderGRec.GET("Appraisal No.");
                        EmpPerforHeaderGRec."Total HOD Rating" := RatingTotal;
                        EmpPerforHeaderGRec.MODIFY();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        OnAfterGetCurrRecordCust();
        Getbold();
    end;

    trigger OnClosePage();
    begin
        HodRatingTotal := 0;
        RatingTotal := 0;
        EmpPerforLineGrec.RESET();
        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Appraisal No.");
        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
        EmpPerforLineGrec.SETRANGE(Period, Period);
        EmpPerforLineGrec.SETRANGE("KRA Type", "KRA Type"::Answer);
        if EmpPerforLineGrec.FINDFIRST() then
            repeat
                HodRatingTotal += EmpPerforLineGrec."HOD Rating";
                RatingTotal += EmpPerforLineGrec."Total HOD Rating";
            until EmpPerforLineGrec.NEXT() = 0;

        EmpPerforLineGrec.RESET();
        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Appraisal No.");
        EmpPerforLineGrec.SETRANGE("KRA Type", "KRA Type"::"End");
        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
        EmpPerforLineGrec.SETRANGE(Period, Period);
        if EmpPerforLineGrec.FINDFIRST() then begin
            EmpPerforLineGrec."HOD Rating" := HodRatingTotal;
            EmpPerforLineGrec.MODIFY();
        end;

        EmpPerforHeaderGRec.GET("Appraisal No.");
        EmpPerforHeaderGRec."Total HOD Rating" := RatingTotal;
        EmpPerforHeaderGRec.MODIFY();
    end;

    trigger OnInit();
    begin
        HODRatingEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        OnAfterGetCurrRecordCust();
        Getbold();
    end;

    var
        EmpPerforHeaderGRec: Record "Employee PerformanceHeader B2B";
        EmpPerforLineGrec: Record "Employee Performance Line B2B";
        LookUpGrec: Record Lookup_B2B;
        [InDataSet]
        HODRatingEditable: Boolean;
        [InDataSet]
        "KRA PointsEditable": Boolean;

        HodRatingTotal: Decimal;
        RatingTotal: Decimal;
        [InDataSet]
        MakeBold: Boolean;

    procedure Getbold(): Boolean;
    begin
        if ("KRA Type" = "KRA Type"::"Begin") or ("KRA Type" = "KRA Type"::"End") or ("KRA Type" = "KRA Type"::Question) then
            MakeBold := true
        else
            MakeBold := false;
    end;

    local procedure OnAfterGetCurrRecordCust();
    begin
        xRec := Rec;

        if ("KRA Type" = "KRA Type"::"Begin") or ("KRA Type" = "KRA Type"::"End") or ("KRA Type" = "KRA Type"::Question) then begin
            HODRatingEditable := false;
            "KRA PointsEditable" := false;
        end else begin
            HODRatingEditable := true;
            "KRA PointsEditable" := true;
        end;
    end;
}

