page 33001585 "Job History List B2B"
{
    PageType = List;
    Caption = 'Job History List';
    SourceTable = "Job History B2B";
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
            repeater("JobHistory")
            {
                Caption = 'JobHistory';

                field("Name of the Company"; "Name of the Company")
                {
                    ApplicationArea = all;
                    ToolTip = 'Name of the company';
                }
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Starting Date';
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'End Date';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Designation';
                }
                field("Roles and Responsibility"; "Roles and Responsibility")
                {
                    ApplicationArea = All;
                    ToolTip = 'Roles and Responsibility';
                }
                field("Last Salary Drawn"; "Last Salary Drawn")
                {
                    ApplicationArea = all;
                    ToolTip = 'Last Salary Drawn';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {

        }
    }
}