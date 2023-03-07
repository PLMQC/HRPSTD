page 33001515 "Posted Leave Plan2 B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Leave Plan2';
    DeleteAllowed = false;
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
                    ToolTip = 'Leave code';
                }
                field("Leave Date"; "Leave Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Leave Date';
                }
                field("Leave Type"; "Leave Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Leave Type';
                }
                field("Session Time"; "Session Time")
                {
                    Editable = true;
                    ApplicationArea = all;
                    ToolTip = 'Session Time';

                    trigger OnValidate();
                    begin
                        NextDay := CALCDATE(Text33001Lbl, "Leave Date");
                        PrevDay := CALCDATE(Text33002Lbl, "Leave Date");

                        if "Session Time" = 2 then begin
                            DailyAttend.SETRANGE("Employee No.", "Employee No");
                            DailyAttend.SETRANGE(Date, PrevDay);
                            DailyAttend.SETRANGE("Non-Working", true);
                            if DailyAttend.FINDFIRST() then begin
                                LeavePlan.RESET();
                                LeavePlan.SETRANGE("Employee No", "Employee No");
                                LeavePlan.SETRANGE("Approved Status", LeavePlan."Approved Status"::Cancelled);
                                if LeavePlan.FINDFIRST() then
                                    repeat
                                        DailyAttend.RESET();
                                        DailyAttend.SETRANGE("Employee No.", LeavePlan."Employee No");
                                        DailyAttend.SETRANGE(Date, LeavePlan."Leave Date");
                                        DailyAttend.SETRANGE("Non-Working", true);
                                        if not DailyAttend.IsEmpty() then begin
                                            LeavePlan.VALIDATE(Cancel, false);
                                            LeavePlan.MODIFY();
                                        end;
                                    until LeavePlan.NEXT() = 0;

                            end;
                        end;


                        if "Session Time" = 1 then begin
                            DailyAttend.SETRANGE("Employee No.", "Employee No");
                            DailyAttend.SETRANGE(Date, NextDay);
                            DailyAttend.SETRANGE("Non-Working", true);
                            if DailyAttend.FINDFIRST() then begin
                                LeavePlan.RESET();
                                LeavePlan.SETRANGE("Employee No", "Employee No");
                                LeavePlan.SETRANGE("Approved Status", LeavePlan."Approved Status"::Cancelled);
                                if LeavePlan.FINDFIRST() then
                                    repeat
                                        DailyAttend.RESET();
                                        DailyAttend.SETRANGE("Employee No.", LeavePlan."Employee No");
                                        DailyAttend.SETRANGE(Date, LeavePlan."Leave Date");
                                        DailyAttend.SETRANGE("Non-Working", true);
                                        if not DailyAttend.IsEmpty() then begin
                                            LeavePlan.VALIDATE(Cancel, false);
                                            LeavePlan.MODIFY();
                                        end;
                                    until LeavePlan.NEXT() = 0;

                            end;
                        end;
                        SessionTimeOnAfterValidate();
                    end;
                }
                field("Approved Status"; "Approved Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Approved status';
                }
                field(Cancel; Cancel)
                {
                    ApplicationArea = all;
                    ToolTip = 'Cancel';
                    trigger OnValidate();
                    begin
                        CancelOnAfterValidate();
                    end;
                }
            }
            group(Control1102154007)
            {
                field(RejAll; RejectAll)
                {
                    Caption = 'Cancel All';
                    ApplicationArea = all;
                    ToolTip = 'Cancel All';

                    trigger OnValidate();
                    begin
                        RejectAllOnAfterValidate();
                    end;
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
        NextDay: Date;
        PrevDay: Date;
        Text33001Lbl: Label '<1D>';
        Text33002Lbl: Label '<-1D>';

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
                    LeavePlan."Approved Status" := LeavePlan."Approved Status"::Cancelled;
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

    procedure Approve1(ApprovedLPar: Boolean);
    begin
        if ApprovedLPar then begin
            ApproveAll := true;
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
            ApproveAll := false;
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

    local procedure SessionTimeOnAfterValidate();
    begin
        Cancel := false;
    end;

    local procedure CancelOnAfterValidate();
    begin
        if Cancel then begin
            NextDay := CALCDATE(Text33001Lbl, "Leave Date");
            PrevDay := CALCDATE(Text33002Lbl, "Leave Date");
            if ("Session Time" = 2) or ("Session Time" = 0) then begin
                DailyAttend.SETRANGE("Employee No.", "Employee No");
                DailyAttend.SETRANGE(Date, NextDay);
                DailyAttend.SETRANGE("Non-Working", true);
                if DailyAttend.FINDFIRST() then begin
                    LeavePlan.RESET();
                    LeavePlan.SETRANGE("Employee No", "Employee No");
                    LeavePlan.SETRANGE("Approved Status", LeavePlan."Approved Status"::Approved);
                    if LeavePlan.FINDFIRST() then
                        repeat
                            DailyAttend.RESET();
                            DailyAttend.SETRANGE("Employee No.", LeavePlan."Employee No");
                            DailyAttend.SETRANGE(Date, LeavePlan."Leave Date");
                            DailyAttend.SETRANGE("Non-Working", true);
                            if not DailyAttend.IsEmpty() then begin
                                LeavePlan.VALIDATE(Cancel, true);
                                LeavePlan.MODIFY();
                            end;
                        until LeavePlan.NEXT() = 0;

                end;
                CurrPage.UPDATE();
            end;
            if ("Session Time" = 1) or ("Session Time" = 0) then begin
                DailyAttend.RESET();
                DailyAttend.SETRANGE("Employee No.", "Employee No");
                DailyAttend.SETRANGE(Date, PrevDay);
                DailyAttend.SETRANGE("Non-Working", true);
                if DailyAttend.FINDFIRST() then begin
                    LeavePlan.RESET();
                    LeavePlan.SETRANGE("Employee No", "Employee No");
                    if LeavePlan.FINDLAST() then
                        repeat
                            DailyAttend.RESET();
                            DailyAttend.SETRANGE("Employee No.", LeavePlan."Employee No");
                            DailyAttend.SETRANGE(Date, LeavePlan."Leave Date");
                            DailyAttend.SETRANGE("Non-Working", true);
                            if not DailyAttend.IsEmpty() then begin
                                LeavePlan.VALIDATE(Cancel, true);
                                LeavePlan.MODIFY();
                            end;
                        until LeavePlan.NEXT(-1) = 0;

                end;
                CurrPage.UPDATE();
            end;
        end;
    end;

    local procedure RejectAllOnAfterValidate();
    begin
        Reject();
    end;

    local procedure LeaveDateOnFormat();
    begin
        DailyAttend.RESET();
        DailyAttend.SETRANGE(Date, "Leave Date");
        if DailyAttend.FINDFIRST() then
            if DailyAttend."Non-Working" then;

    end;
}

