page 33001252 "ESI List B2B"
{
    // version B2BHR1.00.00

    Caption = 'ESI List';
    CardPageID = "ESI B2B";
    Editable = false;
    PageType = List;
    SourceTable = ESI_B2B;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Id; Id)
                {
                    ToolTip = 'Specifies the ID number from ESI card';
                    ApplicationArea = all;

                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specifies the effective date in the ESI list';
                    ApplicationArea = all;

                }
                field("Employer %"; "Employer %")
                {
                    ToolTip = 'Specifies the employer %  in the ESI lsit';
                    ApplicationArea = all;

                }
                field("Employee %"; "Employee %")
                {
                    ToolTip = 'Specifies the employee % in the ESI lsit';
                    ApplicationArea = all;

                }
                field("Rounding Amount"; "Rounding Amount")
                {
                    ToolTip = 'Specifies the rounding amount in the ESI list';
                    ApplicationArea = all;

                }
                field("Rounding Method"; "Rounding Method")
                {
                    ToolTip = 'Specifies the rounding method in the ESI list';
                    ApplicationArea = all;

                }
            }
        }
    }

    actions
    {
    }
}

