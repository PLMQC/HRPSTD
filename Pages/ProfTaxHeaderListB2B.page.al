page 33001255 "Prof.Tax Header List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Prof. Tax Header List';
    CardPageID = "Prof.Tax B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Professional Tax Header B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Branch Code"; "Branch Code")
                {
                    ToolTip = '"Specifies teh branch code in professional tax "';
                    ApplicationArea = all;

                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the description of teh branch conde in the professinal tax header list';
                    ApplicationArea = all;

                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'specifies the effective date of the professional tax in professional tax header list';
                    ApplicationArea = all;

                }
            }
        }
    }

    actions
    {
    }
}

