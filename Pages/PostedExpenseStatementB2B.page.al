page 33001566 "Posted Expense Statement B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Expense Statement';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "Posted Expense Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel  posting details in general  ';
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel employee no';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel employee name';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel employee designation';
                }
                field("Travel Req. No."; "Travel Req. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel requisition.no';
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the shortcut dimension 1 code  while posting travel document';
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the shortcut dimension 2 code  while posting travel document';
                }
            }
            part("Posted Expense Subform"; "Posted Expense Subform B2B")
            {
                Caption = 'Posted Expense Subform';
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;

            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel journal template posting no.series';
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel journal batch name';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel  document posting date';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                field("Time Stamp"; "Time Stamp")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel document approval details';
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel document create user details';
                }
                field("Approved By"; "Approved By")
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
                ToolTip = 'Specify the navigate details';

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
                ToolTip = 'Specify the dimensions while posting the document';

                trigger OnAction();
                begin
                    ShowDimensions();
                end;
            }

            group(Print)
            {
                Caption = 'Print';
                action(Action3)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel document print details';

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

