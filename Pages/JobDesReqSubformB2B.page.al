page 33001529 "Job Des. Req. Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Job Desc. Requirements Subform';
    PageType = ListPart;
    SourceTable = "Job Description Line B2B";
    SourceTableView = WHERE (Type = CONST (Requirements));


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Requirements; Requirements)
                {
                    ToolTip = 'Enter the Job Description Requirements.';
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
        Type := Type::Requirements;
    end;
}

