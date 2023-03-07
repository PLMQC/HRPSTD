page 33001370 "LookUp List For Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'LookUp List For Leaves';
    DataCaptionFields = "Lookup Id";
    Editable = false;
    PageType = List;
    SourceTable = Lookup_B2B;
    SourceTableView = SORTING("Lookup Name")
                      ORDER(Ascending)
                      WHERE("Lookup Type" = CONST(22));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                Editable = false;
                field("Lookup Name"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The lookup name';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The description';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Image = Start;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                ToolTip = 'OK';

                trigger OnAction();
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    GetPayrollYearRec(PayrollYearRec);
                    InsertForAllGrades(Rec, LeaveMasterRec);
                    CurrPage.CLOSE();
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(0);
        MARKEDONLY(true);
        FILTERGROUP(2);
    end;

    var
        LeaveMasterRec: Record "Leave Master B2B";
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        PayrollYearRec: Record "Payroll Year B2B";
        Text001Lbl: Label 'Leaves are Sucessfully Updated';
        Text002Lbl: Label 'LEAVE YEAR';

    procedure SetData(LeaveRecPar: Record "Leave Master B2B");
    begin
        LeaveMasterRec := LeaveRecPar;
    end;

    procedure GetPayrollYearRec(PayrollYearPar: Record "Payroll Year B2B");
    begin
        PayrollYearPar.RESET();
        PayrollYearPar.SETRANGE("Year Type", Text002Lbl);
        PayrollYearPar.SETRANGE(Closed, false);
        PayrollYearPar.FINDFIRST();
        PayrollYearRec := PayrollYearPar;
    end;

    procedure InsertForAllGrades(GradeRecPar: Record Lookup_B2B; LeaveRecPar: Record "Leave Master B2B");
    begin
        if Rec.FINDFIRST() then
            repeat
                GradeWiseLeaves.INIT();
                GradeWiseLeaves."Leave Code" := LeaveMasterRec."Leave Code";
                GradeWiseLeaves."Leave Pay Cadre" := Rec."Lookup Name";
                GradeWiseLeaves."Location Code" := LeaveMasterRec."Location Code";
                GradeWiseLeaves."Leave Description" := LeaveRecPar.Description;
                GradeWiseLeaves."Start Date" := PayrollYearRec."Year Start Date";
                GradeWiseLeaves."End Date" := PayrollYearRec."Year End Date";
                GradeWiseLeaves."Applicable Date" := LeaveMasterRec."Applicable Date";
                GradeWiseLeaves."No. of Leaves in Year" := LeaveMasterRec."No. of Leaves in Year";
                GradeWiseLeaves."Crediting Interval" := LeaveMasterRec."Crediting Interval";
                GradeWiseLeaves."Crediting Type" := LeaveMasterRec."Crediting Type";
                GradeWiseLeaves."Minimum Allowed" := LeaveMasterRec."Minimum Allowed";
                GradeWiseLeaves."Maximum Allowed" := LeaveMasterRec."Maximum Allowed";
                GradeWiseLeaves."Carry Forward" := LeaveMasterRec."Carry Forward";
                GradeWiseLeaves."Max.Leaves to Carry Forward" := LeaveMasterRec."Max.Leaves to Carry Forward";
                GradeWiseLeaves."Applicable During Probation" := LeaveMasterRec."Applicable During Probation";
                GradeWiseLeaves."No.of Leaves During Probation" := LeaveMasterRec."No.of Leaves During Probation";
                GradeWiseLeaves.Encashable := LeaveMasterRec.Encashable;
                GradeWiseLeaves."Min. Encashable" := LeaveMasterRec."Min. Encashable";
                GradeWiseLeaves."Max. Encashable" := LeaveMasterRec."Max. Encashable";
                GradeWiseLeaves."Encashment in excess of." := LeaveMasterRec."Encashment in excess of.";
                GradeWiseLeaves."Leaves in Crediting Interval" := LeaveMasterRec."Leaves in Crediting Interval";
                GradeWiseLeaves."Off Days b/w Leaves" := LeaveMasterRec."Off Days b/w Leaves";
                GradeWiseLeaves.INSERT();
            until Rec.NEXT() = 0;
        MESSAGE(Text001Lbl);
    end;
}

