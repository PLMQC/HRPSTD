page 33001393 "Leave Plan Posted B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Plan Posted';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Leave Plan B2B";

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Leave Application No."; "Leave Application No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave application no details';
                }
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave code details';
                }
                field("Leave Date"; "Leave Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave date details';
                }
                field("Session Time"; "Session Time")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave session time';
                }
                field("Leave Type"; "Leave Type")
                {
                    Editable = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave type details';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        LeaveDateOnFormat();
    end;

    var
        DailyAttend: Record "Daily Attendance B2B";

    local procedure LeaveDateOnFormat();
    begin
        DailyAttend.RESET();
        DailyAttend.SETRANGE(Date, "Leave Date");
        if DailyAttend.FINDFIRST() then
            if DailyAttend."Non-Working" then;

    end;
}

