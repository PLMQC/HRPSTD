page 33001262 "Final Settlement Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Final Settlement Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Final Settlement Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Pay Element Code"; "Pay Element Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the pay element code either addition or deduction';

                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the pay element description';
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the dimension code for department purpose';
                }
                field("Bonus Days"; "Bonus Days")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee wise bonus pay days';
                }
                field("From date"; "From date")
                {
                    Editable = "From dateEditable";
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee resignation date';
                }
                field("To date"; "To date")
                {
                    Editable = "To dateEditable";
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee resignation date';
                }
                field(Posted; Posted)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee final settlement posted status';
                }
                field("Addition/Deduction"; "Addition/Deduction")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the pay element code addition or deductionss';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Amount';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1102152004>")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = '&Dimensions';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Dimensions of Final Settlement';
                    Image = Dimensions;
                    trigger OnAction();
                    begin
                        ShowDimensions1();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if Posted then
            CurrPage.EDITABLE(false)
        else
            CurrPage.EDITABLE(true);

    end;

    trigger OnOpenPage();
    begin
        if Posted then
            CurrPage.EDITABLE(false)
        else
            CurrPage.EDITABLE(true);

    end;

    var
        [InDataSet]
        "To dateEditable": Boolean;
        [InDataSet]
        "From dateEditable": Boolean;

    procedure ShowDimensions1();
    begin
        ShowDimensions();
    end;
}

