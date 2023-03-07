page 33001250 "PF List B2B"
{
    // version B2BHR1.00.00

    Caption = 'PF List';
    CardPageID = "PF B2B";
    Editable = false;
    PageType = List;
    SourceTable = PF_B2B;
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
                    ToolTip = 'Specifies the ID number in th ePF list';
                    ApplicationArea = all;

                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specifies the effective date infomration from PF card';
                    ApplicationArea = all;

                }
                field("Employer Contribution"; "Employer Contribution")
                {
                    ToolTip = 'Specifies the employer contribution information from the PF card';
                    ApplicationArea = all;

                }
                field("Employee Contribution"; "Employee Contribution")
                {
                    ToolTip = 'Specifies the employee contribution information from the PF card';
                    ApplicationArea = all;

                }
                field("Rounding Amount"; "Rounding Amount")
                {
                    ToolTip = 'Specifies the rounding amount from the PF crad';
                    ApplicationArea = all;

                }
                field("Rounding Method"; "Rounding Method")
                {
                    ToolTip = 'Specifies the rounding method information from PF card';
                    ApplicationArea = all;

                }
                field("EPS %"; "EPS %")
                {
                    ToolTip = 'Specifies the EPS% in the Pf Lsit';
                    ApplicationArea = all;

                }
                field("Admin Charges %"; "Admin Charges %")
                {
                    ToolTip = 'Specifies the admin charges % in the PF list';
                    ApplicationArea = all;

                }
                field("EDLI %"; "EDLI %")
                {
                    ToolTip = 'Specifies the EDLI % is the PF list';
                    ApplicationArea = all;

                }
                field("RIFA %"; "RIFA %")
                {
                    ToolTip = 'Specifeis the RIFA % information in PF list';
                    ApplicationArea = all;

                }
            }
        }
    }

    actions
    {
    }
}

