page 33001251 "ESI B2B"
{
    // version B2BHR1.00.00

    Caption = 'ESI';
    PageType = Card;
    SourceTable = ESI_B2B;
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
                    ToolTip = 'Specifies the effective date of the ESI to be applciatble';
                    ApplicationArea = all;

                }
                field("Employer %"; "Employer %")
                {
                    ToolTip = 'Specifies the employer % of ESI in the lsit';
                    ApplicationArea = all;

                }
                field("Employee %"; "Employee %")
                {
                    ToolTip = 'Specifies the employee % of ESI  in the list';
                    ApplicationArea = all;

                }
                field("ESI Salary Amount"; "ESI Salary Amount")
                {
                    ToolTip = 'Specifiees ESI salary amount in the ESI card';
                    ApplicationArea = all;

                }
                field("Rounding Amount"; "Rounding Amount")
                {
                    ToolTip = 'Specifies the rounding amount in the ESI card';
                    ApplicationArea = all;

                }
                field("Rounding Method"; "Rounding Method")
                {
                    ToolTip = 'Specifies th eroundingg method in the ESI card';
                    ApplicationArea = all;

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&ESI")
            {
                Caption = '&ESI';
                action("&List")
                {
                    Caption = '&List';
                    Image = List;
                    RunObject = Page "ESI List B2B";
                    ShortCutKey = 'F5';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Esi List ';

                }
            }
        }
    }
}

