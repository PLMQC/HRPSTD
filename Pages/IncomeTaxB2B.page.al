page 33001348 "Income Tax B2B"
{
    // version B2BHR1.00.00

    Caption = 'Income Tax';
    DelayedInsert = true;
    PageType = Document;
    SourceTable = "Income Tax Header B2B";
    UsageCategory = Tasks;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Finalcial Year"; "Finalcial Year")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payroll income tax financial year';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the description details';
                }
                field("Effective Date"; "Effective Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax financial year effective date';
                }
                field(Surcharge; Surcharge)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payroll surcharge details';
                }
                field(Ecess; Ecess)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payroll ecess details';
                }
            }
            part(Control1102152008; "Income Tax Subform B2B")
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

