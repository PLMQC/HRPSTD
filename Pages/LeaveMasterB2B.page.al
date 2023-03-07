page 33001233 "Leave Master B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Master';
    PageType = Card;
    SourceTable = "Leave Master B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Location Code in Leave Master';
                }
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Code Details in Leave Master';
                }
                field("Type of Leave"; "Type of Leave")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Type of Leave details ';

                    trigger OnValidate();
                    begin
                        if "Type of Leave" = "Type of Leave"::Sick then
                            "Advance Leaves" := false
                        else
                            "Advance Leaves" := true;
                        MODIFY();
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Description in Leave Master';
                }
                field("No. of Leaves in Year"; "No. of Leaves in Year")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the No.Of Leaves in Year in Leave Master';
                }
                field("Leaves in Crediting Interval"; "Leaves in Crediting Interval")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leaves in crediting Interval in Leave Master';
                }
                field("Crediting Interval"; "Crediting Interval")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Crediting Interval Details in Leave Master';
                }
                field("Crediting Type"; "Crediting Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Crediting Type in Leave Master';
                }
                field("Applicable Date"; "Applicable Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Applicable Date';
                }
                field("Carry Forward"; "Carry Forward")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Carry Forward details in Leave Master';

                    trigger OnValidate();
                    begin
                        CarryForwardOnAfterValidate();
                    end;
                }
                field("Max.Leaves to Carry Forward"; "Max.Leaves to Carry Forward")
                {
                    Editable = MaxLeavestoCarryForwardEditabl;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Max.Leaves to carry Forward in Leave Master';
                }
                field("All Cadres"; "All Cadres")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The all cadres';
                }
                field("Off Days b/w Leaves"; "Off Days b/w Leaves")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Off Days b/w Leaves in Leaves Master';
                }
                field("Minimum Working Days"; "Minimum Working Days")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Minimum Working Days in Leave Master';
                }
                field("Min. Retaining Leaves"; "Min. Retaining Leaves")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Min.Retaining Leaves in Leave Master';
                }
                field("Update Leaves On Salary Post"; "Update Leaves On Salary Post")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Update Leaves On Salary Post In Leave Master';
                }
                field("Advance Leaves"; "Advance Leaves")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Advance Leaves in Leaves Master';
                }
                field(Encashable; Encashable)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Encashable in Leave Master';
                }
                field("Lapse Period"; "Lapse Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Lapse Period';

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Lea&ve")
            {
                Caption = 'Lea&ve';
                action("Grade Wise Leaves")
                {
                    Caption = 'Grade Wise Leaves';
                    Image = AbsenceCalendar;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Grade Wise Leaves in Leave Master';

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
                    ToolTip = 'Specicfies the Update cadre leaves in Leave Master';

                    trigger OnAction();
                    begin
                        UpdateCadreLeaves();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if "Carry Forward" then
            MaxLeavestoCarryForwardEditabl := true
        else
            MaxLeavestoCarryForwardEditabl := false;
        SETRANGE("Leave Code");
    end;

    trigger OnInit();
    begin
        MaxLeavestoCarryForwardEditabl := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        PayrollLocationUsers.GET(USERID());
        VALIDATE("Location Code", PayrollLocationUsers."Location Code");
    end;

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        FILTERGROUP(0);
    end;

    var
        LookUpRec: Record Lookup_B2B;
        Lookup_B2B: Record Lookup_B2B;
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        PayrollYearRec: Record "Payroll Year B2B";
        PayrollLocationUsers: Record "Payroll Location Users B2B";
        LookUpListForLeaves: Page "LookUp List For Leaves B2B";
        [InDataSet]
        MaxLeavestoCarryForwardEditabl: Boolean;
        Text001Lbl: Label 'Updated For all Leave Grades';
        Text002Lbl: Label 'No Grade Wise Leaves Found';


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
            Lookup_B2B.RESET();
            Lookup_B2B.SETRANGE("Lookup Type", 22);
            if Lookup_B2B.FINDFIRST() then
                repeat
                    Lookup_B2B.MARK(false);
                    GradeWiseLeaves.RESET();
                    GradeWiseLeaves.SETRANGE("Leave Code", "Leave Code");
                    GradeWiseLeaves.SETRANGE("Leave Pay Cadre", Lookup_B2B."Lookup Name");
                    GradeWiseLeaves.SETRANGE("Location Code", "Location Code");
                    if GradeWiseLeaves.IsEmpty() then
                        Lookup_B2B.MARK(true);

                until Lookup_B2B.NEXT() = 0;
            Lookup_B2B.MARKEDONLY(true);
            CLEAR(LookUpListForLeaves);
            LookUpListForLeaves.SetData(Rec);
            LookUpListForLeaves.SETTABLEVIEW(Lookup_B2B);
            LookUpListForLeaves.RUNMODAL();
        end;
    end;

    procedure InsertForAllGrades(GradeRecPar: Record Lookup_B2B; LeaveRecPar: Record "Leave Master B2B");
    begin
        GradeRecPar.RESET();
        GradeRecPar.SETRANGE(GradeRecPar."Lookup Type", 22);
        GetPayrollYearRec(PayrollYearRec);
        if GradeRecPar.FINDFIRST() then
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

