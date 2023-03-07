page 33001379 "Leave Application List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Application List';
    CardPageID = "Leave Application B2B";
    PageType = List;
    SourceTable = "Leave Application Header B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                Editable = false;
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the document No';
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee No';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the application date';
                }
            }
        }
    }

    actions
    {
    }
}

