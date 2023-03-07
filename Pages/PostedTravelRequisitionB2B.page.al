page 33001563 "Posted Travel Requisition B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Travel Requisition';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "Posted Travel Requisition B2B";
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
                    ToolTip = 'Specify the Travel require details in general';
                }
                field("Travel Requisition Date"; "Travel Requisition Date")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Travel requisition date ';
                }
                field("Category Code"; "Category Code")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel category code';
                }
                field("City Type"; "City Type")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel city type details';
                }
                field("Travel From"; "Travel From")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the traveling city details';
                }
                field("Travel To"; "Travel To")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the traveling place details';
                }
                field("Travel From Date"; "Travel From Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the traveling schedule dates';
                }
                field("Travel To Date"; "Travel To Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel dates';
                }
            }
            part("Posted Req. Line Subform"; "Posted Req. Line Subform B2B")
            {
                Caption = 'Posted Req. Line Subform';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                ApplicationArea = all;

            }
            group("Travel Tickets Details")
            {
                Caption = 'Travel Tickets Details';
                field("Mode of Travel"; "Mode of Travel")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the mode of Travel ticket details';
                }
                field("Coach Type"; "Coach Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the coach type of travel';
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel Employee No';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel Employee name';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel Employee designation';
                }
                field(Age; Age)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel employee age details';
                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel Employee gender details';
                }
                field("Boarding at"; "Boarding at")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel employee boarding place';
                }
                field(Destination; Destination)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel Employee destination details';
                }
                field("Customer / Client No."; "Customer / Client No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel client no details';
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel customer name';
                }
                field("Customer Name 2"; "Customer Name 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel customer 2 details';
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel document account no posting details';
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the bank account no details';
                }
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the journal template name to post the travel document';
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Journal batch name for travel document';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the travel document posting details';
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
                ToolTip = 'Go thorugh navigate and to view the Travel ledger entries';

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
                ToolTip = 'Specify the dimension while posting travel document';

                trigger OnAction();
                begin
                    ShowDimensions();
                end;
            }

            group(ActionGroup2)
            {
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Option the print document';

                    trigger OnAction();
                    begin
                        TravelRequisition.SETRANGE("No.", "No.");
                        REPORT.RUNMODAL(REPORT::"Posted Travel Requisition B2B", true, false, TravelRequisition);
                    end;
                }
            }
        }
    }

    var
        TravelRequisition: Record "Posted Travel Requisition B2B";
}

