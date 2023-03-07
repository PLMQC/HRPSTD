page 33001497 "Job Description List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Job Description List';
    CardPageID = "Job Description B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Job Description Header(RO) B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("No."; "No.")
                {
                    ToolTip = 'Choose the Unique No. sereis for Job Description';
                    ApplicationArea = all;
                }
                field("Job Description"; "Job Description")
                {
                    ToolTip = 'Enter the Job Description.';
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ToolTip = 'Choose the Department from dropdown.';
                    ApplicationArea = all;
                }
                field(Section; Section)
                {
                    ToolTip = 'Choose the Section of the Department.';
                    ApplicationArea = all;
                }
                field("Date Of Creation"; "Date Of Creation")
                {
                    ToolTip = 'Choose the Date.';
                    ApplicationArea = all;
                }
                field("Date Of Modification"; "Date Of Modification")
                {
                    ToolTip = 'Choose the date of modification for job description.';
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ToolTip = 'Enter the comments for job description.';
                    ApplicationArea = all;
                }
                field("Release Status"; "Release Status")
                {
                    ToolTip = 'Show the Satus of Document whether open/Release.';
                    ApplicationArea = all;
                }
                field("Salary Range"; "Salary Range")
                {
                    ToolTip = 'Choose the Salary Range for job description.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Details")
            {
                Caption = '&Details';
                action(Skills)
                {
                    ToolTip = 'Shows the skills required for job.';
                    Caption = 'Skills';
                    Image = Skills;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Skills B2B";
                    RunPageLink = "Document No." = FIELD("No.");
                    ApplicationArea = all;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Release)
                {
                    ToolTip = 'Shows the Document is in released.';
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        TESTFIELD("No.");
                        Release();
                        MODIFY();
                    end;
                }
                action("Re&open")
                {
                    ToolTip = ' Re- opens the Document which is in released.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Reopen();
                    end;
                }
            }
            group(Print)
            {
                ToolTip = 'Prints the document.';
                Caption = 'Print';
                Image = Print;
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Print job description report';

                    trigger OnAction();
                    begin
                        JobDesHeadRO.RESET();
                        JobDesHeadRO.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Job Description RO Report B2B", true, false, JobDesHeadRO);
                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := true;
    end;

    var
        JobDesHeadRO: Record "Job Description Header(RO) B2B";
}

