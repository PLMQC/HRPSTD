report 33001363 "Auto Shift Rotation B2B"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
        }

    }

    var
        Employee: Record "Employee B2B";
        Shift: Record "Shift Master B2B";
        ShiftRotation: Record "Shift Rotation B2B";
        DailyAttendance: Record "Daily Attendance B2B";   
        
    trigger OnPostReport()
    begin
        UpdateShift();
    end;

    procedure UpdateShift()
    var

        ByEmployee: Boolean;
        
    begin
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
                                DailyAttendance.Validate("Actual Time In", Shift."Starting Time");
                                DailyAttendance.Validate("Actual Time Out", Shift."Ending Time");
                                DailyAttendance.Validate(DailyAttendance."Revised Shift Code", Shift."Shift Code");
                                DailyAttendance.Modify(true);
                            until DailyAttendance.Next() = 0;
                    until ShiftRotation.Next() = 0;
            until Employee.Next() = 0;
            ShiftRotation.Reset();
            ShiftRotation.SetRange(Updated, false);
            if ShiftRotation.FindSet() then
                ShiftRotation.ModifyAll(Updated, true, true);
        end;
    end;
}