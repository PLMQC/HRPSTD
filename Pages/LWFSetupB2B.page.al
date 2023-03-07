page 33001549 "LWF Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'LWF Setup';
    PageType = List;
    SourceTable = "LWF Setup B2B";
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Enter the effective start date of Labour Welfare Fund.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Choose Type Employee or Employer.';
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ToolTip = 'Enter the Amount to Deducted for LWF.';
                    ApplicationArea = all;
                }
                field("Pay Element Code"; "Pay Element Code")
                {
                    ToolTip = 'Choose the Pay Element Code for LWF.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

