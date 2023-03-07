page 33001499 "HR Confid. Comment List B2B"
{
    // version B2BHR1.00.00

    Caption='Comment List';
    DataCaptionExpression = Caption(Rec);
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "HR Confide Comment Line B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    ToolTip = 'Enter the Number.';
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ToolTip = 'Enter the Date.';
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ToolTip = 'Enter the comments in Hr confidential.';
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ToolTip = 'Choose the Code.';
                    Visible = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Employee: Record Employee;
        ConfidentialInfo: Record "Confidential Information B2B";
        Text000Lbl: Label 'it is a caption for empty page';

    procedure Caption(HRCommentLine: Record "HR Confide Comment Line B2B"): Text[110];
    begin
        if ConfidentialInfo.GET(HRCommentLine."No.", HRCommentLine.Code, HRCommentLine."Table Line No.") and
           Employee.GET(HRCommentLine."No.")
        then
            exit(CopyStr(HRCommentLine."No." + ' ' + Employee.FullName() + ' ' +
              ConfidentialInfo."Confidential Code", 1, 110));
        exit(CopyStr(Text000Lbl, 1, 110));
    end;
}

