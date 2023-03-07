page 33001384 "Leave Plan B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Plan';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Leave Plan B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Leave Code"; "Leave Code")
                {
                    ToolTip = 'Specifies the leave code.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave Date"; "Leave Date")
                {
                    ToolTip = 'Specifies the leave date.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Session Time"; "Session Time")
                {
                    ToolTip = 'Shows the Session time.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave Type"; "Leave Type")
                {
                    ToolTip = 'Specifies the Leave type.';
                    Editable = true;
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

