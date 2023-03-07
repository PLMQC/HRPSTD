page 33001369 "Grade Wise Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Grade Wise Leaves';
    DelayedInsert = true;
    Editable = true;
    MultipleNewLines = true;
    PageType = Worksheet;
    SourceTable = "Grade Wise Leaves B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Leave Pay Cadre"; "Leave Pay Cadre")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Leave pay cadre';
                }
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the leave code';
                }
                field("Leave Description"; "Leave Description")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the leave description';
                }
                field("Applicable Date"; "Applicable Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Applicable Date';
                }
                field("Leaves in Crediting Interval"; "Leaves in Crediting Interval")
                {
                    ApplicationArea = all;
                    ToolTip = 'Leaves in crediting interval';
                }
                field("Off Days b/w Leaves"; "Off Days b/w Leaves")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Off days B/W Leaves';
                }
                field("Crediting Interval"; "Crediting Interval")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the crediting interval';
                }
                field("Crediting Type"; "Crediting Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the crediting type';
                }
                field("No. of Leaves in Year"; "No. of Leaves in Year")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the no. of leaves in year';
                }
                field("Carry Forward"; "Carry Forward")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the carry forward';
                }
                field("Max.Leaves to Carry Forward"; "Max.Leaves to Carry Forward")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Max leaves to carry forward';
                }
                field("No.of Leaves During Probation"; "No.of Leaves During Probation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the no of leave during probation';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Applicable Date" := LeaveMaster."Applicable Date";
    end;

    trigger OnOpenPage();
    var
        PayrollUsers: Record "Payroll Location Users B2B";
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
    end;

    var
        LeaveMaster: Record "Leave Master B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";

    procedure SetRecord(LeaveMasterRec: Record "Leave Master B2B");
    begin
        LeaveMaster := LeaveMasterRec;
    end;
}

