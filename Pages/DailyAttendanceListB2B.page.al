page 33001230 "Daily Attendance List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Daily Attendance List';
    CardPageID = "Daily Attendance B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Daily Attendance B2B";
    SourceTableView = SORTING("Employee No.", Date);
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the daily attendance employee no from employee list';
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the date employee wise in daily records';
                }
                field("Attendance Type"; "Attendance Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise Present,absent and leave in  daily attendance';
                }
                field("Hours Worked"; "Hours Worked")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the hours in daily attendance  ';
                }
                field("Late Hrs"; "Late Hrs")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee late hrs in daily attendance ';
                }
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise leave code like CL,SL, and EL in daily attendnace ';
                }
                field("OT Approved Hrs"; "OT Approved Hrs")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee OT details in daiy attendance ';
                }
                field("Non-Working"; "Non-Working")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee lacation wise nonworking status like holidays and off days ';
                }
                field("Time In"; "Time In")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise biomatric time in  details ';
                }
                field("Time Out"; "Time Out")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise biomatric time out details';
                }
                field(WeeklyOff; WeeklyOff)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise weeklyoff details in daily attendance ';
                }
                field("Halfday Status"; "Halfday Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise halfday status for leave,present and absent';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        DateOnFormat();
    end;

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
    end;

    var
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";



    local procedure DateOnFormat();
    begin
        if "Non-Working" then;
        if (Holiday = 1.0) then;
    end;
}

