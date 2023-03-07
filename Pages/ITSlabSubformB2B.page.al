page 33001432 "IT Slab Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'IT Slab Subform';
    DelayedInsert = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "IT Slab Line B2B";

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Income From"; "Income From")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the IT slab income from details';
                }
                field("Income To"; "Income To")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the IT slab income to details';
                }
                field("Total Income"; "Total Income")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the IT slab total income details';
                }
                field("Tax Rate %"; "Tax Rate %")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the IT slab tax reate% details';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        ITSlabLine.RESET();
        ITSlabLine.SETRANGE(SlabType, SlabType);
        ITSlabLine.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
        if ITSlabLine.FINDLAST() then 
            "Income From" := ITSlabLine."Income To" + 1;
        
    end;

    var
        ITSlabLine: Record "IT Slab Line B2B";
}

