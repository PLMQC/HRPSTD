page 33001557 "Posted Travel Requisitions B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Travel Requisitions';
    CardPageID = "Posted Travel Requisition B2B";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Posted Travel Requisition B2B";
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
                    ToolTip = 'Specify the No. in group';
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee no';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee designation details';
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the customer name';
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the shortcut dimension 1 details';
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the shortcut dimension 2 details';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the document posting date';
                }
                field("Time Stamp"; "Time Stamp")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Time stamp details';
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the created by user details';
                }
                field("Approved By"; "Approved By")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the approved details';
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
                    Navigate(Rec);
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
                ToolTip = 'Specify the dimension details while posting documnet';

                trigger OnAction();
                begin
                    ShowDimensions();
                end;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortCutKey = 'Ctrl+P';
                ApplicationArea = all;
                ToolTip = 'Specify the option to choose print details';

                trigger OnAction();
                begin
                    TravelRequisition.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(REPORT::"Posted Travel Requisition B2B", true, false, TravelRequisition);
                end;
            }
        }
    }

    var
        TravelRequisition: Record "Posted Travel Requisition B2B";
}

