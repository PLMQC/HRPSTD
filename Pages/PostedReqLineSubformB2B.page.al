page 33001564 "Posted Req. Line Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Req. Line Subform';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Posted Travel Req. Line B2B";
    

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
                    ToolTip = 'Specify the Travel component type like local transport or other transport';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel component description';
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Traveling  employee quantity';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel amount total';
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Travel currency details';
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Travel currency code';
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

