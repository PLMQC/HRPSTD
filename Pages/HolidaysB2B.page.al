page 33001220 "Holidays B2B"
{
    // version B2BHR1.00.00

    Caption = 'Holidays';
    MultipleNewLines = false;
    PageType = Worksheet;
    SourceTable = Holiday_B2B;
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Location Code"; "Location Code")
                {
                    ToolTip = 'A work location is the place or building where you run your organisation. If your business has offices in different locations, it is important that you add all your work locations. The location classify your employees and affect the contributions towards the Professional Tax and Labour Welfare Fund.';
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Date details.';
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the Location name associated with Location code and Location description and define the location type based on city location and attach the location in charge user id. Also act as profit center concept';
                    ApplicationArea = all;
                }
                field("No."; "No.")
                {
                    ToolTip = 'Specifies Location Number';
                    ApplicationArea = all;
                }
                field(Updated; Updated)
                {
                    ToolTip = 'Specifies whether the location values are updated.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Update Attendance")
                {
                    Caption = 'Update Attendance';
                    Image = UpdateUnitCost;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Update attendance details in functions.';

                    trigger OnAction();
                    begin
                        UpdateAttendance();
                    end;
                }
                action("Remove Holiday")
                {
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    Tooltip = 'Specifies the Update Holiday Details';
                    trigger OnAction()
                    var
                        DailyAttendance: Record "Daily Attendance B2B";
                        HRSetup: Record "HR Setup B2B";
                        Text0120Lbl: Label 'Do you want to Remove Holiday ?';
                        Text0121Lbl: Label 'Daily Attendance updated';
                    begin
                        if not Confirm(Text0120Lbl, true) then
                            exit;
                        HRSetup.Get();
                        DailyAttendance.Reset();
                        DailyAttendance.SetRange(Date, Date);
                        DailyAttendance.SetRange("Location Code", "Location Code");
                        if DailyAttendance.FindSet() then
                            repeat

                                if HRSetup."Default Attendance Type" = HRSetup."Default Attendance Type"::Present then begin
                                    DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Present;
                                    DailyAttendance.Validate(Present, 1);
                                    DailyAttendance.Validate(Absent, 0);
                                end else begin
                                    DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Absent;
                                    DailyAttendance.Validate(Present, 0);
                                    DailyAttendance.Validate(Absent, 1);
                                end;
                                DailyAttendance.Validate("Non-Working", false);
                                DailyAttendance.Validate("Non-Working Type", DailyAttendance."Non-Working Type"::" ");
                                DailyAttendance.Validate(Holiday, 0);
                                DailyAttendance.Modify(true);
                            until DailyAttendance.Next() = 0;

                        Delete();
                        Message(Text0121Lbl);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        SetLocEdit();
    end;

    var
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";

        [InDataSet]
        Editablegroup: Boolean;
        [InDataSet]
        NonEditableGroup: Boolean;

    procedure SetLocEdit();
    begin
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then begin
            Editablegroup := true;
            NonEditableGroup := false;
        end else begin
            Editablegroup := false;
            NonEditableGroup := true;
        end;
        CurrPage.UPDATE();
    end;
}

