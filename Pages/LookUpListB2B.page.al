page 33001193 "LookUp List B2B"
{
    // version B2BHR1.00.00

    Caption = 'LookUp List';
    DataCaptionFields = "Lookup Id";
    Editable = false;
    PageType = List;
    SourceTable = Lookup_B2B;
    SourceTableView = SORTING("Lookup Name")
                      ORDER(Ascending);
    ApplicationArea = ALL;
    UsageCategory = Lists;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Lookup Name"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ToolTip = 'Displays all the existing Lookup defined.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Displays all the existing Lookup defined.';
                    ApplicationArea = all;
                }

                /*field("Print in Payslip"; "Print in Payslip")
                {
                    ApplicationArea = all;
                }
                field("Show Priority"; "Show Priority")
                {
                    ApplicationArea = all;
                }*/
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        EventHandlingCD: Codeunit "Event Handling B2B";
        ErrorLabel: Label 'Invalid License, Please Contact B2B Software Technologies.';
    begin
        EventHandlingCD.B2BLicenseValidate();
    end;
}

