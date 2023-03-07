page 33001200 "Resume Database List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resume Database List';
    CardPageID = "Resume Database Card B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Resume Database B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("No."; "No.")
                {
                    ToolTip = 'Specifies the Resume Card  number series of the involved entry or record, according to the specified number series.';
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ToolTip = 'Specifies the Applicant''s First Name';
                    ApplicationArea = all;
                }
                field(Surname; Surname)
                {
                    ToolTip = 'Specifies the Applicant''s Surname Name';
                    ApplicationArea = all;
                }
                field(Selected; Selected)
                {
                    ToolTip = 'Specifies whether the Applicant is "Selected / Rejected"';
                    ApplicationArea = all;
                }
                field("Phone No."; "Phone No.")
                {
                    ToolTip = 'Specifies the Applicant''s Phone Number.';
                    ApplicationArea = all;
                }
                field("Release Status"; "Release Status")
                {
                    ToolTip = 'Specifies the Resume Database document status.';
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    ToolTip = 'Specifies the Applicant''s Mobile No.';
                    ApplicationArea = all;
                }
                field("E-Mail1"; "E-Mail1")
                {
                    ToolTip = 'Specifies the Applicant''s Email Address';
                    ApplicationArea = all;
                }
                field("E-Mail2"; "E-Mail2")
                {
                    ToolTip = 'Specifies the Applicant''s Email Address';
                    ApplicationArea = all;
                }
                field("Experience(Years)"; "Experience(Years)")
                {
                    ToolTip = 'Specifies the Applicant''s Experience Years.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Resume DB")
            {
                Caption = '&Resume DB';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Resume Database Card B2B";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Resume database card details.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Resume Database"),
                                  "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the candiate comment details.';
                }
                action(Skills)
                {
                    Caption = 'Skills';
                    Image = Skills;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Credentials B2B";
                    RunPageLink = "Document No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Resume skill details.';
                }
                separator(Separator1102152010)
                {
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the attachment';

                    trigger OnAction();
                    var
                        DocumentDetails: Record "Document Attachment";
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentDetails.Reset();
                        DocumentDetails.SetRange("No.", "No.");
                        DocumentDetails.SetRange("Table ID", RecRef.Number());
                        DocumentAttachmentDetails.SetTableView(DocumentDetails);
                        DocumentAttachmentDetails.RUNMODAL();
                    end;
                }
            }
        }
        area(processing)
        {
        }
    }

    var
    // Year: Decimal;
    // Date: Integer;
    // Days: Integer;
    // Month: Integer;
    // Months2: Integer;
    // Month3: Integer;
    // Month2: Integer;
    // Year2: Integer;
}

