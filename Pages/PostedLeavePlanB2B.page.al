page 33001385 "Posted Leave Plan B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Leave Plan';
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
                field("Leave Code";"Leave Code")
                {
                  ToolTip = 'Specifies the leave code.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave Date";"Leave Date")
                {
                  ToolTip = 'Specifies the Leave code.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave Type";"Leave Type")
                {
                  ToolTip = 'Specifies the leave type.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Session Time";"Session Time")
                {
                  ToolTip = 'Shows the Session time.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Approved Status";"Approved Status")
                {
                  ToolTip = 'Specifies the Approved status.';
                  ApplicationArea = all;
                }
                field("Compensatory Leave";"Compensatory Leave")
                {
                  ToolTip = 'Specifies the Compensatory leave.';
                    Caption = 'Comp Leave';
                    ApplicationArea = all;
                }
            }
            group(Control1102152001)
            {
                field(AppAll;ApproveAll)
                {
                  ToolTip = 'Specifies the Leave approval all.';
                    Caption = 'Approve ALL';
                    Editable = AppAllEditable;
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        ApproveAllOnAfterValidate();
                    end;
                }
                field(RejAll;RejectAll)
                {
                  ToolTip = 'Specifies the leave is Reject All.';
                    Caption = 'Reject ALL';
                    Editable = RejAllEditable;
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        RejectAllOnAfterValidate();
                    end;
                }
                field(ComALL;CompAll)
                {
                  ToolTip = 'choose the compensate all.';
                    Caption = 'Compensate ALL';
                    Editable = ComALLEditable;
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        CompAllOnAfterValidate();
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
        AppAllEditable := true;
        RejAllEditable := true;
        ComALLEditable := true;
        LeaveDateOnFormat();
    end;

    trigger OnInit();
    begin
        ComALLEditable := true;
        RejAllEditable := true;
        AppAllEditable := true;
    end;

    trigger OnOpenPage();
    begin
        AppAllEditable := false;
        RejAllEditable := false;
        ComALLEditable := false;
    end;

    var
        DailyAttend : Record "Daily Attendance B2B";
        LeavePlan : Record "Leave Plan B2B";
        ApproveAll : Boolean;
        RejectAll : Boolean;
        CompAll : Boolean;
        [InDataSet]
        AppAllEditable : Boolean;
        [InDataSet]
        RejAllEditable : Boolean;
        [InDataSet]
        ComALLEditable : Boolean;

    procedure Approve();
    begin
        if ApproveAll then begin
          RejectAll := false;
          CompAll := false;
          LeavePlan.RESET();
          LeavePlan.SETRANGE("Leave Application No.","Leave Application No.");
          LeavePlan.SETRANGE("Employee No","Employee No");
          LeavePlan.SETRANGE("Leave Code","Leave Code");
          if LeavePlan.FINDFIRST() then
            repeat
              LeavePlan."Approved Status" := LeavePlan."Approved Status" ::Approved;
              LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0;
        end else begin
          LeavePlan.RESET();
          LeavePlan.SETRANGE("Leave Application No.","Leave Application No.");
          LeavePlan.SETRANGE("Employee No","Employee No");
          LeavePlan.SETRANGE("Leave Code","Leave Code");
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
          LeavePlan.SETRANGE("Leave Application No.","Leave Application No.");
          LeavePlan.SETRANGE("Employee No","Employee No");
          LeavePlan.SETRANGE("Leave Code","Leave Code");
          if LeavePlan.FINDFIRST() then
            repeat
              LeavePlan."Approved Status" := LeavePlan."Approved Status" ::Rejected;
              LeavePlan."Posted Status" := LeavePlan."Posted Status" :: Cancelled;
              LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0;
        end else begin
          LeavePlan.RESET();
          LeavePlan.SETRANGE("Leave Application No.","Leave Application No.");
          LeavePlan.SETRANGE("Employee No","Employee No");
          LeavePlan.SETRANGE("Leave Code","Leave Code");
          if LeavePlan.FINDFIRST() then
            repeat
              LeavePlan."Approved Status" := LeavePlan."Approved Status" ::Applied;
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
          LeavePlan.SETRANGE("Leave Application No.","Leave Application No.");
          LeavePlan.SETRANGE("Employee No","Employee No");
          LeavePlan.SETRANGE("Leave Code","Leave Code");
          LeavePlan.SETRANGE("Leave Type","Leave Type"::LOP);
          LeavePlan.SETRANGE("Approved Status","Approved Status" :: Approved);
          if LeavePlan.FINDFIRST() then
            repeat
              LeavePlan."Compensatory Leave" := true;
              LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0;
        end else begin
          LeavePlan.RESET();
          LeavePlan.SETRANGE("Leave Application No.","Leave Application No.");
          LeavePlan.SETRANGE("Employee No","Employee No");
          LeavePlan.SETRANGE("Leave Code","Leave Code");
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

    procedure UpdateValues(PostedLeaveApp : Record "Posted Leave App Line B2B");
    begin
        SETRANGE("Leave Application No.","Leave Application No.");
    end;

    procedure AutomaticApprove(ApprovedLPar : Boolean;LeaveApplicationRecLPar : Record "Posted Leave App Line B2B");
    begin

        if ApprovedLPar then begin
          ApproveAll := true;
          RejectAll := false;
          CompAll := false;
          LeavePlan.RESET();
          LeavePlan.SETRANGE("Leave Application No.",LeaveApplicationRecLPar."Document No.");
          LeavePlan.SETRANGE("Employee No",LeaveApplicationRecLPar."Employee No.");
          LeavePlan.SETRANGE("Leave Code",LeaveApplicationRecLPar."Leave Code");
          if LeavePlan.FINDFIRST() then
            repeat
              LeavePlan."Approved Status" := LeavePlan."Approved Status" ::Approved;
              LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0;
        end else begin
          ApproveAll := false;
          LeavePlan.RESET();
          LeavePlan.SETRANGE("Leave Application No.",LeaveApplicationRecLPar."Document No.");
          LeavePlan.SETRANGE("Employee No",LeaveApplicationRecLPar."Employee No.");
          LeavePlan.SETRANGE("Leave Code",LeaveApplicationRecLPar."Leave Code");
          if LeavePlan.FINDFIRST() then
            repeat
              LeavePlan."Approved Status" := LeavePlan."Approved Status" ::Applied;
              LeavePlan.MODIFY();
            until LeavePlan.NEXT() = 0;
        end;
    end;

    local procedure ApproveAllOnAfterValidate();
    begin
        Approve();
    end;

    local procedure RejectAllOnAfterValidate();
    begin
        Reject();
    end;

    local procedure CompAllOnAfterValidate();
    begin
        Compensate();
    end;

    local procedure LeaveDateOnFormat();
    begin
        DailyAttend.RESET();
        DailyAttend.SETRANGE(Date,"Leave Date");
        if DailyAttend.FINDFIRST() then 
          if DailyAttend."Non-Working" then;
        
    end;
}

