page 33001213 "Employee Confirm. Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Confirmation Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Employee Confirmation Line B2B";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Pay Element"; "Pay Element")
                {
                    ToolTip = '"Specifies the pay element code applicable for the employee "';
                    ApplicationArea = all;
                }
                field("Starting Date"; "Starting Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the starting date of confirmation period';
                    ApplicationArea = all;
                }
                field("Fixed / Percent"; "Fixed / Percent")
                {
                    Editable = false;
                    ToolTip = 'Specifies fixed / percent for the pay element opted for change in salary';
                    ApplicationArea = all;
                }
                field("Amount / Percent"; "Amount / Percent")
                {
                    Editable = false;
                    ToolTip = 'Specifies the "Amount / Percent" against the pay element';
                    ApplicationArea = all;
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    ToolTip = 'Specifies the pay cadre applicable';
                    ApplicationArea = all;
                }
                field("Computation Type"; "Computation Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the computation type "After Basic, After Basic & DA". pay elements will be calculated on percentage, calculation will be done on the basic and DA amounts only';
                    ApplicationArea = all;
                }
                field("Confirmation Date"; "Confirmation Date")
                {
                    ToolTip = 'Sepcifies the confirmation date applicable for the employee being confirmed';
                    ApplicationArea = all;
                }
                field("Revised Pay Element"; "Revised Pay Element")
                {
                    ToolTip = 'Specifies the change in the pay element from old to new element / change in payelement value';
                    ApplicationArea = all;
                }
                field("Revised Amount / Percent"; "Revised Amount / Percent")
                {
                    ToolTip = 'Specifies whether the changes in pay element is "Amount / Percent" based';
                    ApplicationArea = all;
                }
                field("Revised Fixed / Percent"; "Revised Fixed / Percent")
                {
                    ToolTip = 'Specifies whether the Revised /changes in pay element is "Amount / Percent" based';
                    ApplicationArea = all;
                }
                field("Revised Computation Type"; "Revised Computation Type")
                {
                    ToolTip = 'Specifies Pay elements calcualtion based on "After Basic / After Basic and DA" will be calculated on percentage, calculation will be done on the basic and DA amounts only';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var

    procedure ShowDimensions();
    begin
        ShowDimensions();
    end;
}

