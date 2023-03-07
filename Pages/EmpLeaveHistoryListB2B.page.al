page 33001372 "Emp Leave History List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Leaves History List';
    Editable = false;
    PageType = List;
    SourceTable = "Detailed Leave Records B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the entry type details';
                }
                field("Entry Date"; "Entry Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave entry date details';
                }
                field("Leave Description"; "Leave Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave description';
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave month details';
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave all details';
                }
                field("No. of Leaves"; "No. of Leaves")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the no of leave details';
                }
            }
        }
    }

    actions
    {
    }
}

