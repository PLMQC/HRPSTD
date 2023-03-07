page 33001249 "PF B2B"
{
    // version B2BHR1.00.00

    Caption = 'PF';
    DataCaptionFields = "Effective Date";
    PageType = Card;
    SourceTable = PF_B2B;
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = '"Specifies the effictive date of the PF "';
                    ApplicationArea = all;

                }
                field("Employer Contribution"; "Employer Contribution")
                {
                    ToolTip = 'Specifies the employer contruction in the PF';
                    ApplicationArea = all;

                }
                field("EPS %"; "EPS %")
                {
                    ToolTip = 'Specifies the EPS % in the PF';
                    ApplicationArea = all;

                }
                field("Employee Contribution"; "Employee Contribution")
                {
                    ToolTip = 'Specifies the Employee contribution in the PF';
                    ApplicationArea = all;

                }
                field("PF Amount"; "PF Amount")
                {
                    ToolTip = '"Specifies the PF amount "';
                    ApplicationArea = all;

                }
                field("Admin Charges %"; "Admin Charges %")
                {
                    ToolTip = 'specifies the admin chargres % in the PF';
                    ApplicationArea = all;

                }
                field("EDLI %"; "EDLI %")
                {
                    ToolTip = 'specifies the EDLI % in the PF';
                    ApplicationArea = all;

                }
                field("RIFA %"; "RIFA %")
                {
                    ToolTip = 'Specifies RIFA % in the PF card';
                    ApplicationArea = all;

                }
                field("Rounding Amount"; "Rounding Amount")
                {
                    ToolTip = 'Specifies the rounding amount upper or lower in PF card';
                    ApplicationArea = all;

                }
                field("Rounding Method"; "Rounding Method")
                {
                    ToolTip = 'Specifies the rounding method like "Up" . "Down" " Neares" ect in PF card';
                    ApplicationArea = all;

                }
            }
        }
    }

    actions
    {
    }
}

