page 33001203 "Recruitment Header List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Recruitment Header List';
    CardPageID = "Recruitment B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Recruitment Header B2B";
    SourceTableView = WHERE(Approved = CONST(true),
                            CLOSE = CONST(false),
                            Blocked = CONST(false));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Recruitment Policy No."; "Recruitment Policy No.")
                {
                    ToolTip = 'Specifies the Recruitment Policy number series';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies Applicant''s Description';
                    ApplicationArea = all;
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    ToolTip = 'Specifies Applicant''s Indenting department';
                    ApplicationArea = all;
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ToolTip = 'Specifies number os Applicant''s needed';
                    ApplicationArea = all;
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ToolTip = 'Specifies the date of requirement';
                    ApplicationArea = all;
                }
                field(Comments; Comments)
                {
                    ToolTip = 'Specifies any comments marked';
                    ApplicationArea = all;
                }
                field("Reporting To";"Reporting To")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies any Reporting To';
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
                Image = "Action";

                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'To know the Document Status Release';


                    trigger OnAction();
                    begin

                        if not CONFIRM(Text010Lbl, false) then
                            exit;
                        TESTFIELD(Status, Status::Open);
                        Status := Status::Release;
                        MODIFY();
                        MESSAGE(Text012Lbl);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'To know the Document Status Re-Open';

                    trigger OnAction();
                    begin
                        if not CONFIRM(Text011Lbl, false) then
                            exit;

                        TESTFIELD(Status, Status::Release);
                        Status := Status::Open;
                        MODIFY();
                    end;
                }
                action("Close Recruitment")
                {
                    Caption = 'Close Recruitment';
                    Image = Close;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'To know the Document Status Release';

                    trigger OnAction();
                    begin
                        CloseRecruitment();
                    end;
                }
                action("Short Close Recruitment")
                {
                    Caption = 'Short Close Recruitment';
                    Image = Stop;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the short close Recruitment details';

                    trigger OnAction();
                    begin
                        ShortCloseRecruitment();
                    end;
                }
            }
        }
        area(navigation)
        {
            group("<Action19>")
            {
                Caption = '&Line';
                action("<Action25>")
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Recruitment B2B";
                    RunPageLink = "Recruitment Policy No." = FIELD("Recruitment Policy No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recruitment Card details';
                }
            }
        }
    }

    var
        RecruitmentLine: Record "Recruitment Line B2B";
        RecruitmentHeadGRec: Record "Recruitment Header B2B";
        ResumeDB: Record "Resume Database B2B";
        EmployeedCount: Integer;
        //RecruitmentClosed: Boolean;
        Text001Lbl: Label 'Recruitment is already closed.';
        Text002Lbl: Label 'Do you want to close the recruitment.';
        Text003Lbl: Label 'Recruitment cannot be closed, No. of required resources has not been employeed yet.';
        Text004Lbl: Label 'Do you want to short close the recruitment.';
        Text010Lbl: Label 'Do you want to Release?';
        Text011Lbl: Label 'Do you want to Reopen?';
        Text012Lbl: Label 'Status is Released';

    procedure CloseRecruitment();
    begin
        RecruitmentHeadGRec.RESET();
        if RecruitmentHeadGRec.GET("Recruitment Policy No.") then
            if RecruitmentHeadGRec.Close then
                ERROR(Text001Lbl);
        EmployeedCount := 0;
        if CONFIRM(Text002Lbl, false) then begin
            RecruitmentHeadGRec.RESET();
            if RecruitmentHeadGRec.GET("Recruitment Policy No.") then begin
                RecruitmentLine.RESET();
                RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Policy No.");
                if RecruitmentLine.FINDFIRST() then
                    repeat
                        if RecruitmentLine.Employed then
                            EmployeedCount += 1;
                    until RecruitmentLine.NEXT() = 0;

                if EmployeedCount = RecruitmentHeadGRec."No. of Resources" then begin
                    RecruitmentHeadGRec.Close := true;
                    if RecruitmentHeadGRec.MODIFY() then begin
                        RecruitmentLine.RESET();
                        RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Policy No.");
                        if RecruitmentLine.FINDFIRST() then
                            repeat
                                if ResumeDB.GET(RecruitmentLine."Resume Reference No.") then begin
                                    ResumeDB."In Process of Recruitment" := false;
                                    ResumeDB.MODIFY();
                                end;
                            until RecruitmentLine.NEXT() = 0;

                    end;
                end else
                    ERROR(Text003Lbl);
            end;
        end;
    end;

    procedure ShortCloseRecruitment();
    begin
        RecruitmentHeadGRec.RESET();
        if RecruitmentHeadGRec.GET("Recruitment Policy No.") then
            if RecruitmentHeadGRec.Close then
                ERROR(Text001Lbl);

        if CONFIRM(Text004Lbl, false) then begin
            RecruitmentHeadGRec.RESET();
            if RecruitmentHeadGRec.GET("Recruitment Policy No.") then begin
                RecruitmentHeadGRec.Close := true;
                if RecruitmentHeadGRec.MODIFY() then begin
                    RecruitmentLine.RESET();
                    RecruitmentLine.SETRANGE("Recruitment Header No", "Recruitment Policy No.");
                    if RecruitmentLine.FINDFIRST() then
                        repeat
                            if ResumeDB.GET(RecruitmentLine."Resume Reference No.") then begin
                                ResumeDB."In Process of Recruitment" := false;
                                ResumeDB.MODIFY();
                            end;
                        until RecruitmentLine.NEXT() = 0;

                end;
            end;
        end;
    end;
}

