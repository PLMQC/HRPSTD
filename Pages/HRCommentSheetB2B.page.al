page 33001197 "HR Comment Sheet B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'HR Comment Sheet';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "HR Comment Line B2B";
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
                    ToolTip = 'Specifies the comments date on an specified date';
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ToolTip = 'Specifies the comment written';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    // trigger OnNewRecord(BelowxRec: Boolean);
    // begin
    //     SetUpNewLine;
    // end;
}

