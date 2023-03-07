page 33001253 "Prof.Tax B2B"
{
    // version B2BHR1.00.00

    Caption = 'Prof. Tax';
    PageType = Document;
    SourceTable = "Professional Tax Header B2B";
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
                    ToolTip = 'Specifies the branck code for professional tax card';
                    ApplicationArea = all;

                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specifies the effective date of teh professsinal tax applicability';
                    ApplicationArea = all;

                }
                field(Description; Description)
                {
                    ToolTip = 'specifies the discription in professional tax card';
                    ApplicationArea = all;

                }
            }
            part(Control1102152008; "Prof.Tax Subform B2B")
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

