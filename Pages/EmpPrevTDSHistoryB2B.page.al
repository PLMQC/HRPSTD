page 33001440 "Emp. Prev. TDS History B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Prev. TDS History List';

    PageType = ListPart;
    SourceTable = "Emp. Previous TDS History B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
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
                field("TDS Amount Paid"; "TDS Amount Paid")
                {
                    ToolTip = 'Shows the TDS Amount paid By Employee.';
                    ApplicationArea = all;
                }
                field("Challan Date"; "Challan Date")
                {
                    ToolTip = 'Specifies the Challan date of TDS.';
                    ApplicationArea = all;
                }
                field("Challan Number"; "Challan Number")
                {
                    ToolTip = 'Specfies the Challan number';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

