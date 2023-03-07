page 33001469 "Emp Performance Log B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp Performance Log';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Emp Performance Log B2B";
    SourceTableView = SORTING("Line No.");
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Action"; Action)
                {
                    Tooltip = 'Specifies the Action';
                    ApplicationArea = all;
                }
                field("Action By"; "Action By")
                {
                    Tooltip = 'specifies the Action by';
                    ApplicationArea = all;
                }
                field("Action Date"; "Action Date")
                {
                    Tooltip = 'specifies the action date performed.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

