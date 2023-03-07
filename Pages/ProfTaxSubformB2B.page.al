page 33001254 "Prof.Tax Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Prof. Tax Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Professional Tax Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Income From"; "Income From")
                {
                    Editable = false;
                    ToolTip = 'Specifies in the Pf subform income  limit from value';
                    ApplicationArea = all;

                }
                field("Income To"; "Income To")
                {
                    ToolTip = 'Specifies in the PF subform income limit to in the card';
                    ApplicationArea = all;

                }
                field("Tax Amount"; "Tax Amount")
                {
                    ToolTip = 'spefcifies teh tax applicable rate against the amoun from & to';
                    ApplicationArea = all;

                }
                field("Spl. Case"; "Spl. Case")
                {
                    ToolTip = 'Specifies if any special deduction needed any specific period need to menthion the same';
                    ApplicationArea = all;


                    trigger OnValidate();
                    begin
                        SplCaseOnAfterValidate();
                    end;
                }
                field("Spl. Month"; "Spl. Month")
                {
                    Editable = "Spl. MonthEditable";
                    ToolTip = 'Specifies any adjuctements needed in speific month need to define';
                    ApplicationArea = all;

                }
                field("Spl. Value"; "Spl. Value")
                {
                    Editable = "Spl. ValueEditable";
                    ToolTip = 'Specificif any special value need to be decuted from specif period';
                    ApplicationArea = all;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        "Spl. ValueEditable" := true;
        "Spl. MonthEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        PTHead.RESET();
        PTHead.SETRANGE("Branch Code", "Branch Code");
        PTHead.SETRANGE("Effective Date", "Effective Date");
        if PTHead.FINDFIRST() then begin
            PT.RESET();
            PT.SETRANGE("Branch Code", "Branch Code");
            PT.SETRANGE("Effective Date", "Effective Date");
            if PT.FINDLAST() then
                "Income From" := PT."Income To" + 1
            else
                "Income From" := 0.01;
        end else
            "Income From" := 0.01;
    end;

    trigger OnOpenPage();
    begin
        if "Spl. Case" then begin
            "Spl. MonthEditable" := true;
            "Spl. ValueEditable" := true;
        end else begin
            "Spl. MonthEditable" := false;
            "Spl. ValueEditable" := false;
        end;
    end;

    var
        PT: Record "Professional Tax Line B2B";
        PTHead: Record "Professional Tax Header B2B";
        [InDataSet]
        "Spl. MonthEditable": Boolean;
        [InDataSet]
        "Spl. ValueEditable": Boolean;

    local procedure SplCaseOnAfterValidate();
    begin
        if "Spl. Case" then begin
            "Spl. MonthEditable" := true;
            "Spl. ValueEditable" := true;
        end else begin
            "Spl. MonthEditable" := false;
            "Spl. ValueEditable" := false;
        end;
    end;
}

