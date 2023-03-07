page 33001498 "HR Confi. Comment Sheet_ B2B"
{
    // version B2BHR1.00.00
    //B2BBPSTOP    
    AutoSplitKey = true;
    Caption='Confidential Comment Sheet';
    DataCaptionExpression = Caption(Rec);
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
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

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        SetUpNewLine();
    end;

    var

        Employee: Record "Employee B2B";
        ConfidentialInfo: Record "Confidential Information B2B";
        Text000Lbl: Label 'untitled';

    procedure Caption(HRCommentLine: Record "HR Confide Comment Line B2B"): Text[110];
    begin
        if ConfidentialInfo.GET(HRCommentLine."No.", HRCommentLine.Code, HRCommentLine."Table Line No.") and
          Employee.GET(HRCommentLine."No.")
          then
            exit(Copystr(HRCommentLine."No." + ' ' + Employee.FullName() + ' ' +
                 ConfidentialInfo."Confidential Code", 1, 110));
        exit(CopyStr(Text000Lbl, 1, 110));
    end;
}

