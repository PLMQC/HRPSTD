page 33001466 "Employee Perfor. Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Performance Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Employee Performance Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Choose the Employee name.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Serial No."; "Serial No.")
                {
                    ToolTip = 'shows the Unique Squence Number.';
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field("KRA Type"; "KRA Type")
                {
                    ToolTip = 'Choose the KRA Type.';
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
                field(Weightage; Weightage)
                {
                    ToolTip = 'Specifies the Weightage of performance.';
                    Editable = WeightageEditable;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field(TarGET; Target)
                {
                    ToolTip = 'Shows the Target for performance.';
                    Editable = TargetEditable;
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field("Total Target"; "Total Target")
                {
                    ToolTip = 'Shows the Total Target of performance.';
                    Editable = "Total TargetEditable";
                    Style = Standard;
                    StyleExpr = MakeBold;
                    ApplicationArea = all;
                }
                field("Total Target Achived"; "Total Target Achived")
                {
                    ToolTip = 'Shows the Total Target Achived for performance.';
                    Editable = "Total Target AchivedEditable";
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
    }

    trigger OnAfterGetRecord();
    begin
        OnAfterGetCurrRecordCust();
        SerialNoOnFormat();
        KRATypeOnFormat();
        KRAPointsOnFormat();
        TargetOnFormat();
        TotalTargetOnFormat();
        TotalTargetAchivedOnFormat();
        SelfRatingOnFormat();
        HODRatingOnFormat();
        TotalSelfRatingOnFormat();
        TotalHODRatingOnFormat();
    end;

    trigger OnInit();
    begin
        "Total Target AchivedEditable" := true;
        "Total TargetEditable" := true;
        TargetEditable := true;
        "KRA PointsEditable" := true;
        WeightageEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        OnAfterGetCurrRecordCust();
    end;

    var
        [InDataSet]
        WeightageEditable: Boolean;
        [InDataSet]
        "KRA PointsEditable": Boolean;
        [InDataSet]
        TargetEditable: Boolean;
        [InDataSet]
        "Total TargetEditable": Boolean;
        [InDataSet]
        "Total Target AchivedEditable": Boolean;
        [InDataSet]
        "Serial No.Emphasize": Boolean;
        [InDataSet]
        "KRA TypeEmphasize": Boolean;
        [InDataSet]
        "KRA PointsEmphasize": Boolean;
        [InDataSet]
        TargetEmphasize: Boolean;
        [InDataSet]
        "Total TargetEmphasize": Boolean;
        [InDataSet]
        "Total Target AchivedEmphasize": Boolean;
        [InDataSet]
        "Self RatingEmphasize": Boolean;
        [InDataSet]
        "HOD RatingEmphasize": Boolean;
        [InDataSet]
        "Total Self RatingEmphasize": Boolean;
        [InDataSet]
        "Total HOD RatingEmphasize": Boolean;
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
            WeightageEditable := false;
            "KRA PointsEditable" := false;
            TargetEditable := false;
            "Total TargetEditable" := false;
            "Total Target AchivedEditable" := false;
        end else begin
            WeightageEditable := true;
            "KRA PointsEditable" := true;
            TargetEditable := true;
            "Total TargetEditable" := true;
            "Total Target AchivedEditable" := true;
        end;
    end;

    local procedure SerialNoOnFormat();
    begin
        "Serial No.Emphasize" := Getbold();
    end;

    local procedure KRATypeOnFormat();
    begin
        "KRA TypeEmphasize" := Getbold();

        if ("KRA Type" = "KRA Type"::"Begin") or ("KRA Type" = "KRA Type"::"End") or ("KRA Type" = "KRA Type"::Question) then begin
            WeightageEditable := false;
            "KRA PointsEditable" := false;
            TargetEditable := false;
            "Total TargetEditable" := false;
            "Total Target AchivedEditable" := false;
        end else begin
            WeightageEditable := true;
            "KRA PointsEditable" := true;
            TargetEditable := true;
            "Total TargetEditable" := true;
            "Total Target AchivedEditable" := true;
        end;
    end;

    local procedure KRAPointsOnFormat();
    begin
        "KRA PointsEmphasize" := Getbold();
    end;

    local procedure TargetOnFormat();
    begin
        TargetEmphasize := Getbold();
    end;

    local procedure TotalTargetOnFormat();
    begin
        "Total TargetEmphasize" := Getbold();
    end;

    local procedure TotalTargetAchivedOnFormat();
    begin
        "Total Target AchivedEmphasize" := Getbold();
    end;

    local procedure SelfRatingOnFormat();
    begin
        "Self RatingEmphasize" := Getbold();
    end;

    local procedure HODRatingOnFormat();
    begin
        "HOD RatingEmphasize" := Getbold();
    end;

    local procedure TotalSelfRatingOnFormat();
    begin
        "Total Self RatingEmphasize" := Getbold();
    end;

    local procedure TotalHODRatingOnFormat();
    begin
        "Total HOD RatingEmphasize" := Getbold();
    end;
}

