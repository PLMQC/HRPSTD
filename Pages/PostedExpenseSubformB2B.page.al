page 33001567 "Posted Expense Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Expense Subform';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Posted Expense Line B2B";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Expense Date"; "Expense Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the expense date in travel group';
                }
                field("Component Type"; "Component Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the travel component like local transport details';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Travel component description';
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Travling staff  quantity';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Travling total amount';
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the travling curreny local or foregin';
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the travling currency code';
                }
                field("Amount Limits"; "Amount Limits")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the travling budget amount';
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the travel approved amount';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            /*
            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                  Promoted = true;
PromotedOnly=true;
                PromotedOnly=true;
                PromotedCategory = Process;
                ApplicationArea = all;
                ToolTip = 'Specify the travel attachments to import the refrence documnets';

                trigger OnAction();
                var
                    Attachment: Record "HR Attachment-B2B";
                    AttachmentsDocumentPage: Page HRAttachments_B2B;
                begin
                    CLEAR(AttachmentsDocumentPage);
                    Attachment.RESET();
                    Attachment.FILTERGROUP(2);
                    Attachment.SETRANGE("Table ID", DATABASE::"Travel Requisition");
                    Attachment.SETRANGE("Document No.", "Document No.");
                    Attachment.SETRANGE("Document Line No.", "Line No.");
                    Attachment.FILTERGROUP(0);
                    AttachmentsDocumentPage.SETTABLEVIEW(Attachment);
                    AttachmentsDocumentPage.CAPTION(CurrPage.CAPTION);
                    AttachmentsDocumentPage.EDITABLE(false);
                    AttachmentsDocumentPage.RUNMODAL;
                end;
            }
            */
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = all;
                ToolTip = 'Specify the dimension while posting travel document';

                trigger OnAction();
                begin
                    ShowDimensions();
                    CurrPage.SAVERECORD();
                end;
            }
        }
    }
}

