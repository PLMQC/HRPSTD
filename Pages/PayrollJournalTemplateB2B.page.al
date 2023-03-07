page 33001272 "Payroll Journal Template B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Journal Template';
    PageType = Worksheet;
    SourceTable = "Payroll Journal Template B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Type; Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Type of Payroll Batch e.g.Pay Payment, Payroll posting';
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Payroll Journal Template Name';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable Template Name';
                }
                field("Form ID"; "Form ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Ofrm ID is auto picked based on the Type of document';
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'The source general batch name is picked based on form ID';
                }
                field("Form Name"; "Form Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Applicable form Name';
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the number series applicable';
                }
                field("Posting No. Series"; "Posting No. Series")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the posting number applicable';
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
                    ToolTip = 'Specify the Batches of Payroll Journal';
                }
            }
        }
    }
}

