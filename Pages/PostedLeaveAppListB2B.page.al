page 33001395 "Posted Leave App List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Leave Application List';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Posted Leave App Header B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Document No.";"Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the document no details';
                }
                field("Employee No.";"Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee no';
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
            }
        }
    }

    actions
    {
    }
}

