page 33001580 "Income Tax Rebate Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Income Tax Rebate Setup List';
    PageType = List;
    SourceTable = "Income Tax Rebate Setup B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Section ID"; "Section ID")
                {
                    ToolTip = 'Choose Section id as Per Income Tax ACT.';
                    ApplicationArea = all;
                }
                field("Rebate Year Starting Date"; "Rebate Year Starting Date")
                {
                    ToolTip = 'Choose the Start Date of Finacial year.';
                    Caption = 'Year Starting Date';
                    ApplicationArea = all;
                }
                field("Rebate Year Ending Date"; "Rebate Year Ending Date")
                {
                    ToolTip = 'Choose the End Date of Financial year.';
                    Caption = 'Year Ending Date';
                    ApplicationArea = all;
                }
                field("Max. Net Taxable Income"; "Max. Net Taxable Income")
                {
                    ToolTip = 'Enter the maximum net taxable income.';
                    Visible = not VisiableVar;
                    ApplicationArea = all;
                }
                field("Min. Net Taxable Income"; "Min. Net Taxable Income")
                {
                    ToolTip = 'Enter the Minimum net taxable income.';
                    Visible = not VisiableVar;
                    ApplicationArea = all;
                }
                field("Max. Rebate Amount"; "Max. Rebate Amount")
                {
                    ToolTip = 'Enter Maximum eligable Rebate amount.';
                    Visible = not VisiableVar;
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ToolTip = 'Check mark status to be active.';
                    Visible = not VisiableVar;
                    ApplicationArea = all;
                }
                field("Standard Deduction Amount"; "Standard Deduction Amount")
                {
                    ToolTip = 'Enter the Standard Deducation Amount Eligable for financal year.';
                    Visible = VisiableVar;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        if "Document Type" = "Document Type"::"Standard Deduction" then
            VisiableVar := true
        else
            VisiableVar := false;
    end;

    var
        VisiableVar: Boolean;
}

