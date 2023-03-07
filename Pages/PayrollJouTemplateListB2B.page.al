page 33001273 "Payroll Jou Template List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Journal Template List';
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Journal Template B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Name; Name)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Name for the Payroll Journal Template';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Description for the template';
                }
                field("Reason Code"; "Reason Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable reason code';
                }
                field("Force Doc. Balance"; "Force Doc. Balance")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable form name';
                }
                field("Form ID"; "Form ID")
                {
                    LookupPageID = Objects;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable form ID';
                }
                field("Form Name"; "Form Name")
                {
                    DrillDown = false;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Form Name';
                }
                field("Test Report ID"; "Test Report ID")
                {
                    LookupPageID = Objects;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Test Report ID';
                }
                field("Test Report Name"; "Test Report Name")
                {
                    DrillDown = false;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Test Report Name';
                }
                field("Posting Report ID"; "Posting Report ID")
                {
                    LookupPageID = Objects;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Posting Report ID';
                }
                field("Posting Report Name"; "Posting Report Name")
                {
                    DrillDown = false;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Posting Report Name';
                }
                field("Force Posting Report"; "Force Posting Report")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the applicable posting name';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Te&mplates")
            {
                Caption = 'Te&mplates';
                action(Batches)
                {
                    Caption = 'Batches';
                    Image = Description;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Payroll Journal Batch B2B";
                    RunPageLink = "Journal Template Name" = FIELD(Name);
                    ApplicationArea = all;
                    ToolTip = 'Batches';
                }
            }
        }
    }
}

