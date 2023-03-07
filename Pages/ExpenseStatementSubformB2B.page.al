page 33001562 "Expense Statement Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Expense Statement Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Expense Line B2B";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Expense Date"; "Expense Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the expense date in Travel group';
                }
                field("Component Type"; "Component Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel component type local or other';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel description details';
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the traveling member quantity';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel amount';
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the amount local currency or foregin currency';
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the currency code';
                }
                field("Amount Limits"; "Amount Limits")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel budget limits';
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the approved amount for travel';
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
                Caption= 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = all;
                ToolTip = 'Specify the dimension while posting travel document';

                trigger OnAction();
                begin
                    ShowDimensions();
                    CurrPage.SAVERECORD();
                end;
            }
        }
    }
}

