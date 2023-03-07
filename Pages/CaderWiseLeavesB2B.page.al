page 33001389 "Cader Wise Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Cadre Wise Leaves';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Worksheet;
    SourceTable = "Grade Wise Leaves B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Control1102154050; '')
                {
                    CaptionClass = Text19001559Lbl;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Pay cadre';
                }
                field(PayCadre1; PayCadre)
                {
                    ToolTip = 'Choose the Pay cadre for leaves.';
                    Caption = 'PayCadre';
                    ApplicationArea = all;
                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Lookup_B2B.RESET();
                        Lookup_B2B.SETRANGE("Lookup Type", 20);
                        if PAGE.RUNMODAL(0, Lookup_B2B) = ACTION::LookupOK then
                            PayCadre := Lookup_B2B."Lookup Name";
                        SelectPayCadre();
                    end;

                    trigger OnValidate();
                    begin
                        PayCadreOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102154001)
            {
                field("Leave Code"; "Leave Code")
                {
                    ToolTip = 'Specifies the Leave code.';
                    ApplicationArea = all;
                }
                field("Leave Description"; "Leave Description")
                {
                    ToolTip = 'Specifies the Leave Description.';
                    ApplicationArea = all;
                }
                field("Leave Pay Cadre"; "Leave Pay Cadre")
                {
                    ToolTip = 'Choose the Leave Pay Cadre.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Choose the Start date of Cader wise leaves.';
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ToolTip = 'Specifies the End date of Cader wise leaves.';
                    ApplicationArea = all;
                }
                field("Applicable Date"; "Applicable Date")
                {
                    ToolTip = 'Specifies the Applicable Date.';
                    ApplicationArea = all;
                }
                field("No. of Leaves in Year"; "No. of Leaves in Year")
                {
                    ToolTip = 'Specifies the no. of leaves in the year.';
                    ApplicationArea = all;
                }
                field("Crediting Interval"; "Crediting Interval")
                {
                    ToolTip = 'Specifies the Credit interval of leaves.';
                    ApplicationArea = all;
                }
                field("Crediting Type"; "Crediting Type")
                {
                    ToolTip = 'Specifies the Crediting type.';
                    ApplicationArea = all;
                }
                field("Minimum Allowed"; "Minimum Allowed")
                {
                    ToolTip = 'Specfies the mimimum leaves allowed.';
                    ApplicationArea = all;
                }
                field("Maximum Allowed"; "Maximum Allowed")
                {
                    ToolTip = 'Specifies the maximum leaves allowed.';
                    ApplicationArea = all;
                }
                field("Carry Forward"; "Carry Forward")
                {
                    ToolTip = 'Sepicifies the Carry forward of leaves.';
                    ApplicationArea = all;
                }
                field("Max.Leaves to Carry Forward"; "Max.Leaves to Carry Forward")
                {
                    ToolTip = 'specifies the Maximum leaves To Carry forward.';
                    ApplicationArea = all;
                }
                field("Applicable During Probation"; "Applicable During Probation")
                {
                    ToolTip = 'Total Leaves applicable during the probation.';
                    ApplicationArea = all;
                }
                field("No.of Leaves During Probation"; "No.of Leaves During Probation")
                {
                    ToolTip = 'Shows No. of Leaves during the Probation of Employee.';
                    ApplicationArea = all;
                }
                field(Encashable; Encashable)
                {
                    ToolTip = 'Displays no. of leaves can be encashable.';
                    ApplicationArea = all;
                }
                field("Min. Encashable"; "Min. Encashable")
                {
                    ToolTip = 'Specifies the Minimum leaves to Encashable.';
                    ApplicationArea = all;
                }
                field("Off Days b/w Leaves"; "Off Days b/w Leaves")
                {
                    ToolTip = 'Sepecifies off days between the leaves.';
                    ApplicationArea = all;
                }
                field("Max. Encashable"; "Max. Encashable")
                {
                    ToolTip = 'Total maximum leaves to encashable.';
                    ApplicationArea = all;
                }
                field("Encashment in excess of."; "Encashment in excess of.")
                {
                    ToolTip = 'Specifies the Encashment in excess of leaves.';
                    ApplicationArea = all;
                }
                field("Leaves in Crediting Interval"; "Leaves in Crediting Interval")
                {
                    ToolTip = 'Specifies the Leaves crediting interval.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        SelectPayCadre();
    end;

    var
        Lookup_B2B: Record Lookup_B2B;
        PayCadre: Code[20];
        Text19001559Lbl: Label 'Pay Cadre';

    procedure SelectPayCadre();
    begin
        RESET();
        SETRANGE("Leave Pay Cadre", PayCadre);
        CurrPage.UPDATE();
    end;

    local procedure PayCadreOnAfterValidate();
    begin
        SelectPayCadre();
    end;
}

