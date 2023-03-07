page 33001259 "Pay Revision Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Pay Revision Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Pay Revision Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Pay Element"; "Pay Element")
                {
                    ToolTip = 'Specifies the pay element like basic, hra , da etc in the pay revision sub form';
                    ApplicationArea = all;
                }
                field("Starting Date"; "Starting Date")
                {
                    Editable = true;
                    ToolTip = 'Specifies the pay revision starting date in th epayrevison sub form';
                    ApplicationArea = all;
                }
                field("Fixed / Percent"; "Fixed / Percent")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Fixed or Percentage against pay element';
                    ApplicationArea = all;
                }
                field("Amount / Percent"; "Amount / Percent")
                {
                    Editable = false;
                    ToolTip = 'Specifies the amount or perncetage against pay element';
                    ApplicationArea = all;
                }
                field("Computation Type"; "Computation Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the computation type in the revison sub form';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies thepay revision  effective date of the pay revision sub form';
                    ApplicationArea = all;
                }
                field("Revised Fixed / Percent"; "Revised Fixed / Percent")
                {
                    ToolTip = 'Specifies the revised fixed or revised percenta against pay element';
                    ApplicationArea = all;
                }
                field("Revised Amount / Percent"; "Revised Amount / Percent")
                {
                    ToolTip = 'Specifies the revised amount or revised percent against pay element';
                    ApplicationArea = all;
                }
                field("Revised Computation Type"; "Revised Computation Type")
                {
                    ToolTip = 'Specified the revised computaion type against pay element';
                    ApplicationArea = all;
                }
                field("Arrear Amount"; "Arrear Amount")
                {
                    Editable = false;
                    ToolTip = 'speficies the arrear amount if any due';
                    ApplicationArea = all;
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
                Caption = 'Line';
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption='Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Dimension of the Pay revision';

                    trigger OnAction();
                    begin

                        ShowDimensions();
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        PayRevisionHeadGRec.RESET();
        PayRevisionHeadGRec.SETRANGE("Id.", "Header No.");
        IF PayRevisionHeadGRec.FINDFIRST() then;
        "Effective Date" := PayRevisionHeadGRec."Effective Date";
        Type := PayRevisionHeadGRec.Type;
        "No." := PayRevisionHeadGRec."No.";
    end;

    var
        PayRevisionHeadGRec: Record "Pay Revision Header B2B";

    procedure ShowDimensionsPa();
    begin
        ShowDimensions();
    end;
}

