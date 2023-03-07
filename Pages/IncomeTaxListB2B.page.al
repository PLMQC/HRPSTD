page 33001350 "IncomeTax List B2B"
{
    // version B2BHR1.00.00

    Caption = 'IncomeTax List';
    CardPageID = "Income Tax B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Income Tax Header B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the branch code details';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the branch description details';
                }
                field("Effective Date"; "Effective Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Tax effective date details';
                }
                field("Finalcial Year"; "Finalcial Year")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Financial year details';
                }
            }
        }
    }

    actions
    {
    }
}

