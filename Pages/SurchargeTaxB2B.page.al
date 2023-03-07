page 33001464 "Surcharge Tax B2B"
{
    // version B2BHR1.00.00

    Caption = 'Surcharge Tax';
    PageType = Document;
    SourceTable = "Surcharge Tax Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Branch Code"; "Branch Code")
                {
                    ToolTip = 'Enter the Branch code.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Choose the Description.';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Choose the Effective Date.';
                    ApplicationArea = all;
                }
            }
            part(Control1102152008; "Surcharge Tax Subform B2B")
            {

                SubPageLink = "Branch Code" = FIELD("Branch Code"),
                              "Effective Date" = FIELD("Effective Date");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }
}

