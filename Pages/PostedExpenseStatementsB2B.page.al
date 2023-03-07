page 33001565 "Posted Expense Statements B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Expense Statements';
    CardPageID = "Posted Expense Statement B2B";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Posted Expense Header B2B";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel posted statements no details';
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel document Employee no details';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel document employee name';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel employee designation';
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel document approved user details';
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel document approved user details';
                }
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel document approved user details';
                }
                field("Travel Req. No."; "Travel Req. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel document approved user details';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Open the navigate';
                trigger OnAction();
                begin
                    Navigate();
                end;
            }
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                Caption = 'Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = all;
                ToolTip = 'open the dimension';
                trigger OnAction();
                begin
                    ShowDimensions();
                end;
            }

            group(Print)
            {
                Caption = 'Print';
                action(Action1)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Print';
                    trigger OnAction();
                    begin
                        ExpenseHeader.SETRANGE("No.", "No.");
                        ExpenseHeader.FINDFIRST();
                        REPORT.RUNMODAL(REPORT::"Posted Travel Exp. Stat B2b", true, false, ExpenseHeader);
                    end;
                }
            }
        }
    }

    var
        ExpenseHeader: Record "Posted Expense Header B2B";
}

