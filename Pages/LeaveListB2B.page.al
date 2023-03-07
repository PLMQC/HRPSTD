page 33001234 "Leave List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave List';
    CardPageID = "Leave Master B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Leave Master B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Code In Leave Master';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Description In Leave Master';

                }
                field("No. of Leaves in Year"; "No. of Leaves in Year")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the No. Of Leaves in Year in Leave Master';
                }
                field("Crediting Interval"; "Crediting Interval")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Crediting Interval In Leave Master';
                }
                field("Crediting Type"; "Crediting Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Crediting Type  In Leave Master';
                }
                field("Carry Forward"; "Carry Forward")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Carry Forward In Leave Master';
                }
                field("Applicable Date"; "Applicable Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Applicable Date In Leave Master';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Grade Wise Leaves")
            {
                Caption = 'Grade Wise Leaves';
                Image = AbsenceCalendar;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ApplicationArea = all;
                ToolTip = 'Specicfies the Grade Wise Leaves In Leave Master';

                trigger OnAction();
                begin
                    GradeWiseLeaves.RESET();
                    GradeWiseLeaves.SETRANGE("Leave Code", "Leave Code");
                    GradeWiseLeaves.SETRANGE("Location Code", "Location Code");
                    if GradeWiseLeaves.FINDFIRST() then
                        PAGE.RUNMODAL(33001369, GradeWiseLeaves)
                    else
                        ERROR(Text002Lbl);
                end;
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Update &Cadre Leaves")
                {
                    Caption = 'Update &Cadre Leaves';
                    Image = Absence;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Update Cadre Leaves In Leave Master';

                    trigger OnAction();
                    begin
                        UpdateCadreLeaves();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        FILTERGROUP(0);
    end;

    var
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        LookUpRec: Record Lookup_B2B;
        Lookup: Record Lookup_B2B;
        PayrollYearRec: Record "Payroll Year B2B";
        LookUpListForLeaves: Page "LookUp List For Leaves B2B";
        Text001Lbl: Label 'Updated For all Leave Grades';
        Text002Lbl: Label 'No Grade Wise Leaves Found';
        [InDataSet]
        MaxLeavestoCarryForwardEditabl: Boolean;
        Text003Lbl: Label 'Leaves are Successfully Updated For the Leave Code';
        Text004Lbl: Label 'LEAVE YEAR';

    procedure UpdateCadreLeaves();
    begin
        TESTFIELD("Crediting Interval");
        TESTFIELD("Applicable Date");
        TESTFIELD("Leaves in Crediting Interval");
        if "All Cadres" then begin
            GradeWiseLeaves.RESET();
            GradeWiseLeaves.SETRANGE("Leave Code", "Leave Code");
            GradeWiseLeaves.SETRANGE("Location Code", "Location Code");
            if not GradeWiseLeaves.FINDFIRST() then begin
                InsertForAllGrades(LookUpRec, Rec);
                MESSAGE(Text001Lbl);
            end;
        end else begin
            Lookup.RESET();
            Lookup.SETRANGE("Lookup Type", 22);
            if Lookup.FINDFIRST() then
                repeat
                    Lookup.MARK(false);
                    GradeWiseLeaves.RESET();
                    GradeWiseLeaves.SETRANGE("Leave Code", "Leave Code");
                    GradeWiseLeaves.SETRANGE("Leave Pay Cadre", Lookup."Lookup Name");
                    GradeWiseLeaves.SETRANGE("Location Code", "Location Code");
                    if GradeWiseLeaves.IsEmpty() then
                        Lookup.MARK(true);

                until Lookup.NEXT() = 0;
            Lookup.MARKEDONLY(true);
            CLEAR(LookUpListForLeaves);
            LookUpListForLeaves.SetData(Rec);
            LookUpListForLeaves.SETTABLEVIEW(Lookup);
            LookUpListForLeaves.RUNMODAL();
        end;
    end;

    procedure InsertForAllGrades(GradeRecPar: Record Lookup_B2B; LeaveRecPar: Record "Leave Master B2B");
    begin
        GradeRecPar.RESET();
        GradeRecPar.SETRANGE(GradeRecPar."Lookup Type", 22);
        GetPayrollYearRec(PayrollYearRec);
        if GradeRecPar.FINDFIRST() then begin
            repeat
                GradeWiseLeaves.INIT();
                GradeWiseLeaves."Leave Code" := LeaveRecPar."Leave Code";
                GradeWiseLeaves."Leave Pay Cadre" := GradeRecPar."Lookup Name";
                GradeWiseLeaves."Location Code" := LeaveRecPar."Location Code";
                GradeWiseLeaves."Leave Description" := LeaveRecPar.Description;
                GradeWiseLeaves."Start Date" := PayrollYearRec."Year Start Date";
                GradeWiseLeaves."End Date" := PayrollYearRec."Year End Date";
                GradeWiseLeaves."Applicable Date" := LeaveRecPar."Applicable Date";
                GradeWiseLeaves."No. of Leaves in Year" := LeaveRecPar."No. of Leaves in Year";
                GradeWiseLeaves."Crediting Interval" := LeaveRecPar."Crediting Interval";
                GradeWiseLeaves."Crediting Type" := LeaveRecPar."Crediting Type";
                GradeWiseLeaves."Minimum Allowed" := LeaveRecPar."Minimum Allowed";
                GradeWiseLeaves."Maximum Allowed" := LeaveRecPar."Maximum Allowed";
                GradeWiseLeaves."Carry Forward" := LeaveRecPar."Carry Forward";
                GradeWiseLeaves."Max.Leaves to Carry Forward" := LeaveRecPar."Max.Leaves to Carry Forward";
                GradeWiseLeaves."Applicable During Probation" := LeaveRecPar."Applicable During Probation";
                GradeWiseLeaves."No.of Leaves During Probation" := LeaveRecPar."No.of Leaves During Probation";
                GradeWiseLeaves.Encashable := LeaveRecPar.Encashable;
                GradeWiseLeaves."Min. Encashable" := LeaveRecPar."Min. Encashable";
                GradeWiseLeaves."Max. Encashable" := LeaveRecPar."Max. Encashable";
                GradeWiseLeaves."Encashment in excess of." := LeaveRecPar."Encashment in excess of.";
                GradeWiseLeaves."Leaves in Crediting Interval" := LeaveRecPar."Leaves in Crediting Interval";
                GradeWiseLeaves."Off Days b/w Leaves" := LeaveRecPar."Off Days b/w Leaves";
                GradeWiseLeaves.INSERT();
            until GradeRecPar.NEXT() = 0;
            MESSAGE(Text003Lbl + ' ' + LeaveRecPar."Leave Code");
        end;
    end;

    procedure GetPayrollYearRec(PayrollYearPar: Record "Payroll Year B2B");
    begin
        PayrollYearPar.RESET();
        PayrollYearPar.SETRANGE("Year Type", Text004Lbl);
        PayrollYearPar.SETRANGE(Closed, false);
        PayrollYearPar.FINDFIRST();
        PayrollYearRec := PayrollYearPar;
    end;

    local procedure CarryForwardOnAfterValidate();
    begin
        if "Carry Forward" then
            MaxLeavestoCarryForwardEditabl := true
        else
            MaxLeavestoCarryForwardEditabl := false;

    end;
}

