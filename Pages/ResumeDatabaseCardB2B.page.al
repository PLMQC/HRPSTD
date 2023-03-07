page 33001199 "Resume Database Card B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resume Database Card';
    PageType = Card;
    SourceTable = "Resume Database B2B";
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
                    ToolTip = 'Specifies the Resume Card  number series of the involved entry or record, according to the specified number series.';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("First Name"; "First Name")
                {
                    ToolTip = 'Specifies the Applicant''s First Name';
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    ToolTip = '"Specifies Applicant;s Middle Name"';
                    ApplicationArea = all;
                }
                field(Surname; Surname)
                {
                    ToolTip = 'Specifies Applicant''s Surname';
                    ApplicationArea = all;
                }
                /* field(Address; Address1)
                 {
                     ToolTip = 'Specifies Applicants Address';
                     //ApplicationArea = all;
                 }*/
                field(Address1; Address1)
                {
                    ToolTip = 'Specifies Applicants Address';
                    ApplicationArea = all;
                }
                field(Address2; Address2)
                {
                    ToolTip = 'Specifies Applicants Address';
                    ApplicationArea = all;
                }
                field("Post Code"; "Post Code")
                {
                    Caption = 'Post Code/City';
                    ToolTip = 'Specifies Applicants Post Code';
                    ApplicationArea = all;
                }
                field(City; City)
                {
                    ToolTip = 'Specifies Applicants City';
                    ApplicationArea = all;
                }
                field(State; State)
                {
                    ToolTip = 'Specifies Applicants Sate code/Name';
                    ApplicationArea = all;
                }
                field("Country code"; "Country code")
                {
                    ToolTip = 'Specifies Applicant''s Country code.';
                    ApplicationArea = all;
                }
                field(DOB; DOB)
                {
                    ToolTip = 'Specifies Applicant''s Date of Birth.';
                    ApplicationArea = all;
                }
                field(Gender; Gender)
                {
                    ToolTip = 'Specifies Applicant''s Gender - Male,Female,Anyone';
                    ApplicationArea = all;
                }
                field("Marital Status"; "Marital Status")
                {
                    ToolTip = 'Specifies Applicant''s Marital status - Married, Single';
                    ApplicationArea = all;
                }
                field("Phone No."; "Phone No.")
                {
                    ToolTip = 'Specifies Applicants Phone Number';
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    ToolTip = 'Specifies Applicants Mobile No.';
                    ApplicationArea = all;
                }
                field("E-Mail1"; "E-Mail1")
                {
                    ToolTip = 'Specifies Applicants Email id';
                    ApplicationArea = all;
                }
                field("E-Mail2"; "E-Mail2")
                {
                    ToolTip = 'Specifies Applicants Email ID';
                    ApplicationArea = all;
                }
                field(Blocked; Blocked)
                {
                    ToolTip = 'Specifies whether the said Resume data should be blocked';
                    ApplicationArea = all;
                }
                field("Release Status"; "Release Status")
                {
                    Editable = false;
                    ToolTip = 'Specifies the document release status';
                    ApplicationArea = all;
                }
                field("Released Date"; "Released Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Resume Database relase date.';
                    ApplicationArea = all;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field(Status; Status)
                {
                    ToolTip = 'Specifies Applicants Resume status - Selected,Rejected,On Hold';
                    ApplicationArea = all;
                }
                field("Experience Type"; "Experience Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Resume experience type details.';
                }
                field("Experience(Years)"; "Experience(Years)")
                {
                    ToolTip = 'Specifies Applicants Experience in number of years.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Months; Months)
                {
                    ToolTip = 'Specifies Applicants Experience in number of month';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Date of Receipt of Resume"; "Date of Receipt of Resume")
                {
                    ToolTip = 'Specifies Applicants Resume Received / rececipt date.';
                    ApplicationArea = all;
                }
                field("Last Updated"; "Last Updated")
                {
                    Editable = false;
                    ToolTip = 'Specifies if the Resume data has been modified if Yes the last modified / last updated date.';
                    ApplicationArea = all;
                }
                field(Selected; Selected)
                {
                    ToolTip = 'Specifies whether the applicant is selected ''YES / NO"';
                    ApplicationArea = all;
                }
                field(Source; Source)
                {
                    ToolTip = 'Specifies the sources from the Resume database is received.';
                    ApplicationArea = all;
                }
                field(Reference; Reference)
                {
                    ToolTip = 'Specifies if the applicanant resume is received via A Reference.';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Specifies any general remarks to be noted.';
                    ApplicationArea = all;
                }
                field("Source of Hiring"; "Source of Hiring")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the source of hiring details.';
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
                    ToolTip = 'Specifies the Resume database comment details.';
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
                    ToolTip = 'Specifies the skills details.';
                }
                separator(Separator1102152044)
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document status Release details.';

                    trigger OnAction();
                    begin
                        TESTFIELD(DOB);
                        Release();
                        "Released Date" := TODAY();
                        MODIFY();
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document status Reopen details.';


                    trigger OnAction();
                    begin
                        Reopen();
                    end;
                }
                /*action(Comment)
                {
                    Caption = 'Comment';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Resume Database"),
                                  "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Resume Database comment  details.';
                }*/
            }
            group("History Details")
            {
                Caption = 'Details';

                action("Employee Job History")
                {
                    Caption = 'Employee Job History';
                    Image = ViewDetails;
                    RunObject = Page "Job History List B2B";
                    RunPageLink = "SNo." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Job History details.';

                }
                action("Languages")
                {
                    Caption = 'Languages';
                    RunObject = page "Employee Languages B2B";
                    RunPageLink = "Line Type" = const("Language"),
                                  "Employee No." = field("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Languages details.';
                    image = Language;
                }
                action("&Family Details")
                {
                    Caption = '&Family Details';
                    Image = Relatives;
                    RunObject = Page "Family Details & Relation B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee family details.';
                }
            }
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

