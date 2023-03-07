page 33001349 "Income Tax Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Income Tax Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Income Tax Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Income From"; "Income From")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income slab details';
                }
                field("Income To"; "Income To")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income slab details';
                }
                field("Tax Amount"; "Tax Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax amount details';
                }
            }
        }
    }

    actions
    {
    }
}

