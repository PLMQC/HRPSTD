page 33001530 "Job Des. Compet. Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Job Des. Competences Subform';
    PageType = ListPart;
    SourceTable = "Job Description Line B2B";
    SourceTableView = WHERE (Type = CONST (Competences));


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Competences; Competences)
                {
                    ToolTip = 'Enter the competences for job description.';
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
        Type := Type::Competences;
    end;
}

