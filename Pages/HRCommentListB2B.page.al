page 33001198 "HR Comment List B2B"
{
    // version B2BHR1.00.00

    Caption = 'HR Comment List';
    CardPageID = "HR Comment Sheet B2B";
    Editable = false;
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
                field("No."; "No.")
                {
                    ToolTip = 'Employee code relationship with comment';
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ToolTip = 'Specifies the comment date';
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ToolTip = 'Specifies the comment made';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

