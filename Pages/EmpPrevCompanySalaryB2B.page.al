page 33001439 "Emp. Prev. Company Salary. B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Prev. Company Sal. List';
    Editable = true;
    PageType = ListPart;
    SourceTable = "Emp. Previous Company Sal B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("List Part")
            {
                //B2BMSOn05Nov2022>>
                field("Financial Year Start Date"; "Financial Year Start Date")
                {
                    ApplicationArea = all;
                }
                field("Financial Year End Date"; "Financial Year End Date")
                {
                    ApplicationArea = all;
                }
                //B2BMSOn05Nov2022<<
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specifies the Month of TDS.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Specifies the Year of TDS.';
                    ApplicationArea = all;
                }
                field("Pay Element Code"; "Pay Element Code")
                {
                    ToolTip = 'Choose the Pay Element code.';
                    ApplicationArea = all;
                }
                field("Addition/Deduction"; "Addition/Deduction")
                {
                    ToolTip = 'Specifies the Choosen pay element as Deducation /Addition.';
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ToolTip = 'Spcifies the Amount.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

