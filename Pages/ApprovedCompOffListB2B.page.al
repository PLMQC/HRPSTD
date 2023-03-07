page 33001548 "Approved CompOff List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Approved CompOff List';
    CardPageID = "Approved Comp Off B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE ("Document Type" = CONST ("Comp Off"),
                            Status = CONST (Approved));
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("No."; "No.")
                {
                    ToolTip = 'Select the No. given.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Shows the Month.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Shows the year.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Enter the start date of Com. off.';
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ToolTip = 'Enter the End date of Com. off.';
                    ApplicationArea = all;
                }
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Choose the Shift code of the Employee.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

