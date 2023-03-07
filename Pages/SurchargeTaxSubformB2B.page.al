page 33001462 "Surcharge Tax Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Surcharge Tax Subform';
    PageType = ListPart;
    SourceTable = "Surcharge Tax Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Income From"; "Income From")
                {
                    ToolTip = 'Specifies the start date income from.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Income To"; "Income To")
                {
                    ToolTip = 'Specifies the End date income from.';
                    ApplicationArea = all;
                }
                field("Tax %"; "Tax %")
                {
                    ToolTip = 'Specifies the Tax percentage.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    var
        SurchargeTaxLine: Record "Surcharge Tax Line B2B";
        SurchargeTaxHeader: Record "Surcharge Tax Header B2B";
    begin
        SurchargeTaxHeader.RESET();
        SurchargeTaxHeader.SETRANGE("Branch Code", "Branch Code");
        SurchargeTaxHeader.SETRANGE("Effective Date", "Effective Date");
        if not SurchargeTaxHeader.IsEmpty() then begin
            SurchargeTaxLine.RESET();
            SurchargeTaxLine.SETRANGE("Branch Code", "Branch Code");
            SurchargeTaxLine.SETRANGE("Effective Date", "Effective Date");
            if SurchargeTaxLine.FINDLAST() then 
                "Income From" := SurchargeTaxLine."Income To" + 1
            else
                "Income From" := 1;
        end else
            "Income From" := 1;
    end;
}

