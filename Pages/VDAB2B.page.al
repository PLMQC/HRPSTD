page 33001402 "VDA B2B"
{
    // version B2BHR1.00.00

    Caption = 'VDA';
    PageType = Document;
    SourceTable = "VDA Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Quarter; Quarter)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the quarter details';
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the year details';
                }
            }
            part(Control1102154004; "VDA Subform B2B")
            {
                SubPageLink = Quarter = FIELD(Quarter),
                              Year = FIELD(Year);
                ApplicationArea = all;

            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("<Action1102154007>")
                {
                    Caption = 'Update &VDA';
                    Image = Apply;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'specify the update VDA details';
                    trigger OnAction();
                    begin
                        UpdatePayElements();
                    end;
                }
                action("Update &FDA")
                {
                    Caption = 'Update &FDA';
                    Image = Completed;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "FDA Calculation B2B";
                    ApplicationArea = all;
                    ToolTip = 'specify the update FDA details';
                }
            }
        }
    }
}

