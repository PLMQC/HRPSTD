page 33001474 "Training Schedule Plan B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Training Schedule Plan';
    PageType = Worksheet;
    SourceTable = "Training Schedule Plan B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Training Date"; "Training Date")
                {
                    ToolTip = 'Choose the Employee Training Schedule date.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

