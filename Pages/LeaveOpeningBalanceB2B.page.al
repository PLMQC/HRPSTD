page 33001390 "Leave Opening Balance B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Leave Opening Balance';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = Worksheet;
    SourceTable = "Leave Journal B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave document posting date details';
                }
                field("Entry Type"; "Entry Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave entry type details';
                    trigger OnValidate();
                    begin
                        if not ("Entry Type" = "Entry Type"::"Opening Balance") then
                            ERROR(Text001Lbl);
                    end;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee No';
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Leave code';
                    trigger OnValidate();
                    begin
                        LeaveMaster.RESET();
                        LeaveMaster.SETRANGE("Leave Code", "Leave Code");
                        LeaveMaster.SETRANGE("Type of Leave", LeaveMaster."Type of Leave"::Sick);
                        if LeaveMaster.FINDFIRST() then
                            ERROR(Text002Lbl);
                    end;
                }
                field("Leave Description"; "Leave Description")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Leave description';
                }
                field("No.of Leaves"; "No.of Leaves")
                {
                    MinValue = 0;
                    ApplicationArea = all;
                    ToolTip = 'Specify the no.of leaves  detail';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&ost")
            {
                Caption = 'P&ost';
                Image = Post;
                action(Post)
                {
                    Caption = 'Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specify the document post  details';
                    trigger OnAction();
                    begin
                        if CONFIRM(Text000Lbl, true) then
                            PostOpeningBalance();
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Entry Type" := "Entry Type"::"Opening Balance";
        "Posting Date" := workdate();
    end;

    trigger OnOpenPage();
    begin
        SETRANGE("Entry Type", "Entry Type"::"Opening Balance");
        "Entry Type" := "Entry Type"::"Opening Balance";
        "Posting Date" := workdate();
    end;

    var
        LeaveMaster: Record "Leave Master B2B";
        Text000Lbl: Label 'Do you want to post?';

        Text001Lbl: Label 'Entry Type Should be Opening Balance';
        Text002Lbl: Label 'You should not select sick leave in advance';

    procedure OpeningBalance();
    begin
    end;
}

