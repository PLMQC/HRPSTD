page 33001591 "Shift Rotation B2B"
{
    PageType = List;
    SourceTable = "Shift Rotation B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the type';
                }
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the No';
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the location code';
                }
                field("Shift Code"; "Shift Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the shift code';
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the start date';
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the end date';
                }
                field(Updated; Updated)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the updated';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Shift Rotation")
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = UpdateDescription;
                ApplicationArea = all;
                ToolTip = 'Specifies the shift rotation';

                trigger OnAction();
                var
                    Employee: Record "Employee B2B";
                    Shift: Record "Shift Master B2B";
                    ShiftRotation: Record "Shift Rotation B2B";
                    DailyAttendance: Record "Daily Attendance B2B";
                    Date: Record Date;
                    WeeklyOffs: Record "Shiftwise Offday B2B";
                    Text001Lbl: Label 'Do you want to Update Shift ?';
                    Text002Lbl: Label 'Shift updation Sucessfully Completed.';
                    ByEmployee: Boolean;
                begin
                    if not Confirm(Text001Lbl, true) then
                        exit;

                    Employee.Reset();
                    Employee.SetRange(Blocked, false);
                    if Employee.FindSet() then begin
                        repeat
                            Clear(ByEmployee);
                            ShiftRotation.Reset();
                            ShiftRotation.SetRange(Type, ShiftRotation.Type::Employee);
                            ShiftRotation.SetRange("No.", Employee."No.");
                            ShiftRotation.SetRange(Updated, false);
                            if ShiftRotation.FindFirst() then
                                ByEmployee := true;


                            ShiftRotation.Reset();
                            if ByEmployee then begin
                                ShiftRotation.SetRange(Type, ShiftRotation.Type::Employee);
                                ShiftRotation.SetRange("No.", Employee."No.");
                            end else begin
                                ShiftRotation.SetRange(Type, ShiftRotation.Type::"Pay Cadre");
                                ShiftRotation.SetRange("No.", Employee."Pay Cadre");
                                ShiftRotation.SetRange("Location Code", Employee."Location Code");
                            end;
                            ShiftRotation.SetRange(Updated, false);
                            if ShiftRotation.FindSet() then
                                repeat
                                    Shift.Get(ShiftRotation."Shift Code", ShiftRotation."Location Code");
                                    DailyAttendance.Reset();
                                    DailyAttendance.SetRange("Employee No.", Employee."No.");
                                    DailyAttendance.SetRange(Date, ShiftRotation."Start Date", ShiftRotation."End Date");
                                    DailyAttendance.SetFilter("Time In", '%1', 0T);
                                    DailyAttendance.SetFilter("Time Out", '%1', 0T);
                                    if DailyAttendance.FindSet() then
                                        repeat
                                            if DailyAttendance.WeeklyOff = 1 then begin
                                                DailyAttendance.WeeklyOff := 0;
                                                DailyAttendance."Non-Working" := false;
                                                DailyAttendance."Non-Working Type" := DailyAttendance."Non-Working Type"::" ";
                                            end;
                                            DailyAttendance.Validate("Actual Time In", Shift."Starting Time");
                                            DailyAttendance.Validate("Actual Time Out", Shift."Ending Time");
                                            DailyAttendance.Validate(DailyAttendance."Revised Shift Code", Shift."Shift Code");
                                            Date.Reset();
                                            Date.SetRange("Period Type", Date."Period Type"::Date);
                                            Date.SetRange("Period Start", DailyAttendance.Date);
                                            if Date.FindFirst() then begin
                                                WeeklyOffs.Reset();
                                                WeeklyOffs.SetRange("Shift Code", Shift."Shift Code");
                                                if WeeklyOffs.FindSet() then
                                                    repeat
                                                        if Date."Period Name" = Format(WeeklyOffs.Day) then begin
                                                            DailyAttendance.WeeklyOff := 1;
                                                            DailyAttendance."Non-Working" := true;
                                                            DailyAttendance."Non-Working Type" := DailyAttendance."Non-Working Type"::OffDay;
                                                        end;
                                                    until WeeklyOffs.Next() = 0;

                                            end;
                                            DailyAttendance.Modify(true);
                                        until DailyAttendance.Next() = 0;

                                until ShiftRotation.Next() = 0;

                        until Employee.Next() = 0;
                        ShiftRotation.Reset();
                        ShiftRotation.SetRange(Updated, false);
                        if ShiftRotation.FindSet() then
                            ShiftRotation.ModifyAll(Updated, true, true);
                    end;
                    Message(Text002Lbl);
                end;
            }
        }
    }
}