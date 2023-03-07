page 33001207 "Closed Recruitment Headers B2B"
{
    // version B2BHR1.00.00

    Caption = 'Closed Recruitments';
    CardPageID = "Closed Recruitment B2B";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Recruitment Header B2B";
    SourceTableView = WHERE(Approved = CONST(true),
                            Close = CONST(true),
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
                    ToolTip = 'Specifies the Recruitment Policy number series of the involved entry or record, according to the specified number series';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the Training description';
                    ApplicationArea = all;
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    ToolTip = 'Specifies the department initiating the training';
                    ApplicationArea = all;
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ToolTip = 'Specifies the Employee''s to whom the training is being imparted';
                    ApplicationArea = all;
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ToolTip = 'Specifies the Training requirement date';
                    ApplicationArea = all;
                }
                field(Comments; Comments)
                {
                    ToolTip = 'Specifies the Training comments if any';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Comment)
            {
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Comment Sheet B2B";
                RunPageLink = "Table Name" = CONST("Recruitment Header"),
                              "No." = FIELD("Recruitment Policy No.");
                ToolTip = 'Comment';
                ApplicationArea = all;
            }
        }
    }

    var
        RecruitmentLine: Record "Recruitment Line B2B";
        //Lookup_B2B: Record Lookup_B2B;
        RecruitmentHeadGRec: Record "Recruitment Header B2B";
        ResumeDB: Record "Resume Database B2B";
        //RecruitmentClosed: Boolean;
        EmployeedCount: Integer;
        Text001Lbl: Label 'Recruitment is already closed';
        Text002Lbl: Label 'Recruitment can not be closed, No. of required resources are not Employeed';
        Text003Lbl: Label 'Do you want to close the recruitment';
        Text004Lbl: Label 'Do you want to Short close the recruitment';

    procedure CloseRecruitment();
    begin
        RecruitmentHeadGRec.RESET();
        if RecruitmentHeadGRec.GET("Recruitment Policy No.") then
            if RecruitmentHeadGRec.Close then
                ERROR(Text001Lbl);
        EmployeedCount := 0;
        if CONFIRM(Text003Lbl, false) then begin
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
                    ERROR(Text002Lbl);
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

