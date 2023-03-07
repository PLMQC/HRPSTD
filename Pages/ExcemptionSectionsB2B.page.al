page 33001352 "Excemption Sections B2B"
{
    // version B2BHR1.00.00

    Caption = 'Excemption Sections';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Excemption Sections B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Section ID"; "Section ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax section id details';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax section id description';
                }
                field("Chapter ID"; "Chapter ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax chapter id details';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1102152001>")
            {
                Caption = '&Section';
                action("<Action1102152002>")
                {
                    Caption = '&Rebate';
                    Image = GetLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Income tax rebate details';

                    trigger OnAction();
                    begin
                        Rec.ShowRebateDetails();
                    end;
                }
            }
        }
    }
}

