page 33001496 "Job Des. Respon Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Job Des. Responsibilty Subform';
    PageType = ListPart;
    SourceTable = "Job Description Line B2B";
    SourceTableView = WHERE(Type = CONST(Responsibilities));


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field(Responsibilities; Responsibilities)
                {
                    ToolTip = 'Enter the Responsibility for job.';
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
        Type := Type::Responsibilities;
    end;
}

