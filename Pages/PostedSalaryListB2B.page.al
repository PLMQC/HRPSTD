page 33001278 "Posted Salary List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Salary List';
    Editable = false;
    PageType = List;
    SourceTable = "Posted Salary Details B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = ' The field displayes the Posting date';
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displayes the Posted document number';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displayes the Posted document description';
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displayes the Posted month';
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displayes the Posted year';
                }
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displayes the Employee Code';
                }
                field("Total Additions"; "Total Additions")
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displayes the Posted Additions Amount';
                }
                field("Total Deductions"; "Total Deductions")
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displayes the Posted Decutions Amount';
                }
                field("Net Salary"; "Net Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displayes the Posted Net Salary Amount';
                }
                field("Salary Paid"; "Salary Paid")
                {
                    ApplicationArea = all;
                    ToolTip = 'The field displayes the Posted Salary as True';
                }
            }
        }
    }

    actions
    {
    }
}

