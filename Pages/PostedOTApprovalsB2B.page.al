page 33001542 "Posted OT Approvals B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted OT Approvals';
    Editable = false;
    PageType = List;
    SourceTable = "OT Approval B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Employee No."; "Employee No.")
                {
                    Tooltip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ToolTip = 'Select the Date.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Select the Year.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Select the month.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Choose the Employee name.';
                    ApplicationArea = all;
                }
                field("OT Hrs"; "OT Hrs")
                {
                    ToolTip = 'Shows the Over time hours worked.';
                    ApplicationArea = all;
                }
                field("OT Approved Hrs"; "OT Approved Hrs")
                {
                    ToolTip = 'Shows the over time hours Approved';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Remarks to be given.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

