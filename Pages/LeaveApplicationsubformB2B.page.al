page 33001380 "Leave Application subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Leave Application Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Leave Application Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Leave Code"; "Leave Code")
                {
                    ToolTip = 'choose the leave code.';
                    ApplicationArea = all;
                }
                field("Leave Duration"; "Leave Duration")
                {
                    ToolTip = 'Specifies the leave duration of the employee.';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        LeaveDurationOnAfterValidate();
                    end;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Specifies the start date.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Specifies the end date.';
                    ApplicationArea = all;
                }
                field("Session Time"; "Session Time")
                {
                    ToolTip = 'shows the session time.';
                    ApplicationArea = all;
                    Editable = "Session TimeEditable";
                }
                field("No.of Days"; "No.of Days")
                {
                    ToolTip = 'Specifies the No. of the Days.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Provisional Leaves Avail"; "Provisional Leaves Avail")
                {
                    ToolTip = 'Specifies the provisional leave available.';
                    ApplicationArea = all;

                    trigger OnDrillDown();
                    var
                        ProvisionalLeaves: Record "Provisional Leaves B2B";
                        ProvisionalLeavesRec: Record "Provisional Leaves B2B" temporary;
                        Text000Lbl: Label 'You dont have provisional leaves of type %1.', Comment = '%1 = LeaveCode';
                    begin
                        ProvisionalLeavesRec.DELETEALL();
                        ProvisionalLeaves.RESET();
                        ProvisionalLeaves.SETRANGE("Employee No.", "Employee No.");
                        ProvisionalLeaves.SETRANGE("Leave Code", "Leave Code");
                        ProvisionalLeaves.SETRANGE(Status, ProvisionalLeaves.Status::Open);
                        ProvisionalLeaves.SETFILTER("Remaining Leaves", '<>%1', 0);
                        ProvisionalLeaves.SETFILTER("Period Start Date", '<=%1', "To Date");
                        if ProvisionalLeaves.FINDFIRST() then begin
                            repeat
                                ProvisionalLeavesRec.INIT();
                                ProvisionalLeavesRec.TRANSFERFIELDS(ProvisionalLeaves);
                                ProvisionalLeavesRec.INSERT();
                            until ProvisionalLeaves.NEXT() = 0;
                            PAGE.RUN(33001386, ProvisionalLeavesRec);
                        end else
                            MESSAGE(Text000Lbl, "Leave Code");
                    end;
                }
                field("Applied Leaves History"; "Applied Leaves History")
                {
                    ToolTip = 'Specifies the Applied leaves history.';
                    ApplicationArea = all;

                    trigger OnDrillDown();
                    var
                        PayrollYear: Record "Payroll Year B2B";
                        LeavePlan: Record "Leave Plan B2B";
                        TempLeavePlan: Record "Leave Plan B2B" temporary;
                        YearStartDate: Date;
                        YearEndDate: Date;
                    begin
                        PayrollYear.RESET();
                        PayrollYear.SETRANGE("Year Type", Text001Lbl);
                        PayrollYear.SETRANGE(Closed, false);
                        if PayrollYear.FINDFIRST() then begin
                            YearStartDate := PayrollYear."Year Start Date";
                            YearEndDate := PayrollYear."Year End Date";
                        end;

                        TempLeavePlan.DELETEALL();

                        LeavePlan.RESET();
                        LeavePlan.SETRANGE("Employee No", "Employee No.");
                        LeavePlan.SETRANGE("Leave Code", "Leave Code");
                        LeavePlan.SETRANGE("Approved Status", LeavePlan."Approved Status"::Applied);
                        LeavePlan.SETFILTER("Leave Date", '>=%1&<=%2', YearStartDate, YearEndDate);
                        if LeavePlan.FINDFIRST() then begin
                            repeat
                                TempLeavePlan.INIT();
                                TempLeavePlan.TRANSFERFIELDS(LeavePlan);
                                TempLeavePlan.INSERT();
                            until LeavePlan.NEXT() = 0;
                            PAGE.RUN(33001393, TempLeavePlan);
                        end;
                    end;
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    ToolTip = 'Enter the Reason for leave.';
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
        if "Leave Duration" = "Leave Duration"::"Half Day" then
            "Session TimeEditable" := true
        else
            "Session TimeEditable" := false;
    end;

    trigger OnInit();
    begin
        "Session TimeEditable" := true;
    end;

    trigger OnOpenPage();
    begin
        if "Leave Duration" = "Leave Duration"::"Half Day" then
            "Session TimeEditable" := true
        else
            "Session TimeEditable" := false;
    end;

    var
        [InDataSet]
        "Session TimeEditable": Boolean;
        Text001Lbl: Label 'LEAVE YEAR';

    local procedure LeaveDurationOnAfterValidate();
    begin
        if "Leave Duration" = "Leave Duration"::"Half Day" then
            "Session TimeEditable" := true
        else
            "Session TimeEditable" := false;
    end;
}

