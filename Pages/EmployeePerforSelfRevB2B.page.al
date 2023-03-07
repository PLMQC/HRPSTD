page 33001467 "Employee Perfor. SelfRev B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Performance Self Rev';
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
                    ToolTip = 'Choose the Employee name.';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Serial No."; "Serial No.")
                {
                    ToolTip = 'shows the Unique Squence Number.';
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
                    Editable = SelfRatingEditable;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;

                    trigger OnValidate()
                    Begin
                        "Total Self Rating" := "Self Rating" * Weightage;
                    end;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if "KRA Type" = "KRA Type"::Answer then begin
                            LookUpGrec.RESET();
                            LookUpGrec.SETRANGE("Lookup Type", 9);
                            if PAGE.RUNMODAL(33001193, LookUpGrec) = ACTION::LookupOK then begin
                                "Self Rating" := LookUpGrec."Performance Scale Value";
                                "Total Self Rating" := "Self Rating" * Weightage;
                            end
                        end;
                    end;
                }
                field("Total Self Rating"; "Total Self Rating")
                {
                    ToolTip = 'Shows the total Self rating for the performance.';
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
                action("&Self Rating")
                {
                    Caption = '&Self Rating';
                    Image = Reminder;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Self Rating Update Details ';

                    trigger OnAction();
                    begin
                        SelfRatingTotal := 0;
                        TotalRating := 0;
                        EmpPerforLineGrec.RESET();
                        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Appraisal No.");
                        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
                        EmpPerforLineGrec.SETRANGE(Period, Period);
                        EmpPerforLineGrec.SETRANGE("KRA Type", "KRA Type"::Answer);
                        if EmpPerforLineGrec.FINDFIRST() then
                            repeat
                                SelfRatingTotal += EmpPerforLineGrec."Self Rating";
                                TotalRating += EmpPerforLineGrec."Total Self Rating";
                            until EmpPerforLineGrec.NEXT() = 0;

                        EmpPerforLineGrec.RESET();
                        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Appraisal No.");
                        EmpPerforLineGrec.SETRANGE("KRA Type", "KRA Type"::"End");
                        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
                        EmpPerforLineGrec.SETRANGE(Period, Period);
                        if EmpPerforLineGrec.FINDFIRST() then begin
                            EmpPerforLineGrec."Self Rating" := SelfRatingTotal;
                            EmpPerforLineGrec.MODIFY();
                        end;

                        EmpPerforHeaderGRec.GET("Appraisal No.");
                        EmpPerforHeaderGRec."Total Self Rating" := TotalRating;
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
        SelfRatingTotal := 0;
        TotalRating := 0;
        EmpPerforLineGrec.RESET();
        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Appraisal No.");
        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
        EmpPerforLineGrec.SETRANGE(Period, Period);
        EmpPerforLineGrec.SETRANGE("KRA Type", "KRA Type"::Answer);
        if EmpPerforLineGrec.FINDFIRST() then
            repeat
                SelfRatingTotal += EmpPerforLineGrec."Self Rating";
                TotalRating += EmpPerforLineGrec."Total Self Rating";
            until EmpPerforLineGrec.NEXT() = 0;

        EmpPerforLineGrec.RESET();
        EmpPerforLineGrec.SETRANGE("Appraisal No.", "Appraisal No.");
        EmpPerforLineGrec.SETRANGE("KRA Type", "KRA Type"::"End");
        EmpPerforLineGrec.SETRANGE("Employee No.", "Employee No.");
        EmpPerforLineGrec.SETRANGE(Period, Period);
        if EmpPerforLineGrec.FINDFIRST() then begin
            EmpPerforLineGrec."Self Rating" := SelfRatingTotal;
            EmpPerforLineGrec.MODIFY();
        end;

        EmpPerforHeaderGRec.GET("Appraisal No.");
        EmpPerforHeaderGRec."Total Self Rating" := TotalRating;
        EmpPerforHeaderGRec.MODIFY();
    end;

    trigger OnInit();
    begin
        SelfRatingEditable := true;
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
        SelfRatingEditable: Boolean;

        [InDataSet]
        "KRA PointsEditable": Boolean;
        SelfRatingTotal: Decimal;
        TotalRating: Decimal;
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
            SelfRatingEditable := false;
            "KRA PointsEditable" := false;
        end else begin
            SelfRatingEditable := true;
            "KRA PointsEditable" := true;
        end;
    end;
}

