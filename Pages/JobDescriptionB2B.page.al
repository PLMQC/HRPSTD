page 33001495 "Job Description B2B"
{
    // version B2BHR1.00.00

    Caption = 'Job Description';
    PageType = Document;
    SourceTable = "Job Description Header(RO) B2B";
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
                    ToolTip = 'Choose the Unique No. sereis for Job Description';
                    Lookup = false;
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE()
                    end;

                    trigger OnValidate();
                    begin
                        "Date Of Creation" := workdate();
                    end;
                }
                field("Job Description"; "Job Description")
                {
                    ToolTip = 'Enter the Job Description.';
                    ApplicationArea = all;
                }
                field("Date Of Creation"; "Date Of Creation")
                {
                    ToolTip = 'Choose the Date.';
                    ApplicationArea = all;
                }
                field("Reports To"; "Reports To")
                {
                    ToolTip = 'Choose the Employee to whom to Report.';
                    ApplicationArea = all;
                }
                field("Reports To Designation"; "Reports To Designation")
                {
                    ToolTip = 'Designation of the Reporting Person.';
                    ApplicationArea = all;
                }
                field("Job Designation"; "Job Designation")
                {
                    ToolTip = 'Choose the Designation of the job.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1"; "Global Dimension 1")
                {
                    ToolTip = 'Choose the Dimension value.';
                    Caption = 'Publication';
                    TableRelation = "Dimension Value" WHERE("Dimension Code" = CONST('PUBLICATION'));
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ToolTip = 'Choose the Department from dropdown.';
                    ApplicationArea = all;
                }
                field(Experience; Experience)
                {
                    ToolTip = 'Choose the Experience required for the job.';
                    ApplicationArea = all;
                }
                field("Organization Chart Ref."; "Organization Chart Ref.")
                {
                    ToolTip = 'Shows the Organization chart Reference code. ';
                    ApplicationArea = all;
                }
                field("No. of Reportee"; "No. of Reportee")
                {
                    ToolTip = 'Shows the No. of Employees Reporting.';
                    ApplicationArea = all;
                }
                field("Type of Position"; "Type of Position")
                {
                    ToolTip = 'Shows the Postion type as permanent or contract etc. ';
                    ApplicationArea = all;
                }
                field("Release Status"; "Release Status")
                {
                    ToolTip = 'Show the Satus of Document whether open/Release.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Salary Range"; "Salary Range")
                {
                    ToolTip = 'Choose the Salary Range for job description.';
                    ApplicationArea = all;
                }
            }
            group(Responsibilities)
            {
                Caption = 'Responsibilities';
                part(Control1102154020; "Job Des. Respon Subform B2B")
                {
                    SubPageLink = "Job Code" = FIELD("No.");
                    ApplicationArea = all;
                }
            }
            group(Requirements)
            {
                Caption = 'Requirements';
                part(Control1102152002; "Job Des. Req. Subform B2B")
                {
                    SubPageLink = "Job Code" = FIELD("No.");
                    ApplicationArea = all;
                }
            }
            group(Competences)
            {
                Caption = 'Competences';
                part(Control1102152003; "Job Des. Compet. Subform B2B")
                {
                    SubPageLink = "Job Code" = FIELD("No.");
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
                    ToolTip = 'Specifies the Skillsof employee.';
                    Caption = 'Skills';
                    Image = Skills;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Skills B2B";
                    RunPageLink = "Document No." = FIELD("No."), "Document Type" = filter(Jobs);
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
                    ToolTip = 'Shows the Document is Released or not.';
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
                Caption = 'Print';
                Image = Print;
                action("&Print")
                {
                    ToolTip = 'Prints the document.';
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        JobDesHeadRO.RESET();
                        JobDesHeadRO.SETRANGE("No.", "No.");
                        REPORT.RUNMODAL(REPORT::"Job Description RO Report B2B", true, true, JobDesHeadRO);
                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        "Date Of Creation" := workdate();
    end;

    trigger OnOpenPage();
    begin
        "Date Of Creation" := workdate();
    end;

    var
        JobDesHeadRO: Record "Job Description Header(RO) B2B";
}

