page 33001445 "Emp. Salary Adj. Limit B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Salary Adj. Limits List';
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Employee Sal Adj. Limits B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Employee Code"; "Employee Code")
                {
                     ToolTip = 'Choose the Employee Number.';
                    ApplicationArea = all;
                }
                field("Financial Year Start Date"; "Financial Year Start Date")
                {
                    ToolTip = 'Choose the Financial year Start Date.';
                    ApplicationArea = all;
                }
                field("Financial Year End Date"; "Financial Year End Date")
                {
                    ToolTip = 'Specfies the Financial year End Date.';
                    ApplicationArea = all;
                }
                field("Adjustment Element Code"; "Adjustment Element Code")
                {
                    ToolTip = 'Spcifies The Salary Adjustment Element Code.';
                    ApplicationArea = all;
                }
                field("Annual Limit"; "Annual Limit")
                {
                    ToolTip = 'Specifies the Limit.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

