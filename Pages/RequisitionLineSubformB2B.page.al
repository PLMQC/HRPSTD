page 33001559 "Requisition Line Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Requisition Line Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Travel Requisition Line B2B";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Component Type"; "Component Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the component type in group';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the description';
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the quantity';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the amount';
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the currency amount';
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the currency code';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                Caption='Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = all;
                ToolTip = 'Specify the dimensions while posting document';

                trigger OnAction();
                begin
                    ShowDimensions();
                    CurrPage.SAVERECORD();
                end;
            }
        }
    }
}

