page 33001396 "Posted Leave Plan -Post B2B"
{
    // version B2BHR1.00.00

    Caption = 'Post. Leave Plan(Post. Leaves)';
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
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave code';
                }
                field("Leave Date"; "Leave Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave date';
                }
                field("Leave Type"; "Leave Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave type details';
                }
                field("Session Time"; "Session Time")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave session time';
                }
                field("Approved Status"; "Approved Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the approved status';
                }
                field("Compensatory Leave"; "Compensatory Leave")
                {
                    Caption = 'Comp Leave';
                    ApplicationArea = all;
                    ToolTip = 'Specify the comp leave details';
                }
                field("Posted Status"; "Posted Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the posted status details';
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
        LeavePlan: Record "Leave Plan B2B";
        ApproveAll: Boolean;
        RejectAll: Boolean;
        CompAll: Boolean;

    procedure Approve();
    begin
        if ApproveAll then begin
            RejectAll := false;
            CompAll := false;
            LeavePlan.RESET();
            LeavePlan.SETRANGE("Leave Application No.", "Leave Application No.");
            LeavePlan.SETRANGE("Employee No", "Employee No");
            LeavePlan.SETRANGE("Leave Code", "Leave Code");
            if LeavePlan.FINDFIRST() then
                repeat
                    LeavePlan."Approved Status" := LeavePlan."Approved Status"::Approved;
                    LeavePlan.MODIFY();
                until LeavePlan.NEXT() = 0;
        end else begin
            LeavePlan.RESET();
            LeavePlan.SETRANGE("Leave Application No.", "Leave Application No.");
            LeavePlan.SETRANGE("Employee No", "Employee No");
            LeavePlan.SETRANGE("Leave Code", "Leave Code");
            if LeavePlan.FINDFIRST() then
                repeat
                    LeavePlan."Approved Status" := LeavePlan."Approved Status"::Applied;
                    LeavePlan.MODIFY();
                until LeavePlan.NEXT() = 0;
        end;
        CurrPage.UPDATE();
    end;

    procedure Reject();
    begin
        if RejectAll then begin
            ApproveAll := false;
            CompAll := false;
            LeavePlan.RESET();
            LeavePlan.SETRANGE("Leave Application No.", "Leave Application No.");
            LeavePlan.SETRANGE("Employee No", "Employee No");
            LeavePlan.SETRANGE("Leave Code", "Leave Code");
            if LeavePlan.FINDFIRST() then
                repeat
                    LeavePlan."Approved Status" := LeavePlan."Approved Status"::Rejected;
                    LeavePlan.MODIFY();
                until LeavePlan.NEXT() = 0;
        end else begin
            LeavePlan.RESET();
            LeavePlan.SETRANGE("Leave Application No.", "Leave Application No.");
            LeavePlan.SETRANGE("Employee No", "Employee No");
            LeavePlan.SETRANGE("Leave Code", "Leave Code");
            if LeavePlan.FINDFIRST() then
                repeat
                    LeavePlan."Approved Status" := LeavePlan."Approved Status"::Applied;
                    LeavePlan.MODIFY();
                until LeavePlan.NEXT() = 0;
        end;
        CurrPage.UPDATE();
    end;

    procedure Compensate();
    begin
        if CompAll then begin
            ApproveAll := false;
            RejectAll := false;
            LeavePlan.RESET();
            LeavePlan.SETRANGE("Leave Application No.", "Leave Application No.");
            LeavePlan.SETRANGE("Employee No", "Employee No");
            LeavePlan.SETRANGE("Leave Code", "Leave Code");
            LeavePlan.SETRANGE("Leave Type", "Leave Type"::LOP);
            LeavePlan.SETRANGE("Approved Status", "Approved Status"::Approved);
            if LeavePlan.FINDFIRST() then
                repeat
                    LeavePlan."Compensatory Leave" := true;
                    LeavePlan.MODIFY();
                until LeavePlan.NEXT() = 0;
        end else begin
            LeavePlan.RESET();
            LeavePlan.SETRANGE("Leave Application No.", "Leave Application No.");
            LeavePlan.SETRANGE("Employee No", "Employee No");
            LeavePlan.SETRANGE("Leave Code", "Leave Code");
            if LeavePlan.FINDFIRST() then
                repeat
                    LeavePlan."Compensatory Leave" := false;
                    LeavePlan.MODIFY();
                until LeavePlan.NEXT() = 0;
        end;
        CurrPage.UPDATE();
    end;

    procedure IntiateValues();
    begin
        ApproveAll := false;
        RejectAll := false;
        CompAll := false;
    end;

    procedure UpdateValues(PostedLeaveApp: Record "Posted Leave App Line B2B");
    begin
        SETRANGE("Leave Application No.", "Leave Application No.");
    end;

    local procedure LeaveDateOnFormat();
    begin
        DailyAttend.RESET();
        DailyAttend.SETRANGE(Date, "Leave Date");
        if DailyAttend.FINDFIRST() then
            if DailyAttend."Non-Working" then;

    end;
}

