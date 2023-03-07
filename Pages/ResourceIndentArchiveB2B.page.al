page 33001333 "Resource Indent Archive B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resource Indent Archive Card';
    PageType = Card;
    SourceTable = "Recruitment Header Archive B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Recruitment Policy No."; "Recruitment Policy No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Policy Number';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Policy Description';
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Indenting Department';
                }
                field("Required Dept."; "Required Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Rquired Department Name';
                }
                field("Required Position"; "Required Position")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Required Postion details';
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Resource Number';
                }
                field("Experience Type"; "Experience Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Experience Type Policy';
                }
                field(Experience; Experience)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Experience';
                }
                field(Position; Position)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Position';
                }
                field("Salary Period"; "Salary Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritments Salary period';
                }
                field("Reporting To"; "Reporting To")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Reporting to Person Name';
                }
                // field("Physaical Location"; "Physaical Location")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Recuritment Physical Location Details';
                // }
                // field("Expected Target"; "Expected Target")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Recuritment closure Expected Date';
                // }
                // field("Source of Getting Manpower"; "Source of Getting Manpower")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Recuritment Source of getting Manpower';
                // }
                field(Comments; Comments)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remarks / Comments if any';
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Date of Recuritment';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Priority';
                }
                field("Age Group"; "Age Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Age Group towards Recruitment';
                }
                field(Division; Division)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment made of which Division';
                }
                field("Gender Preference"; "Gender Preference")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Gender Preference towards Recuritment ';
                }
                field("Salary Range"; "Salary Range")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Salary Range in the Recuritment';
                }
                field("Salary Type"; "Salary Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Salary Type in Recuritment';
                }
                field(Approved; Approved)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the whether the Recruitment Document is Approved';
                }
                field("Nature of Position"; "Nature of Position")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Position in the Recuritment';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Recuritment Document Status = Released / Open';
                }
                // field("Training/Probation Period"; "Training/Probation Period")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Probation Period';
                // }
                // field("Thrid Party"; "Thrid Party")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Third Party name';
                // }
                // field(Reason; Reason)
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Reason for Rejection';
                // }
                // field("Days Limit"; "Days Limit")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Days Limit';
                // }
                // field("Reason for Rejection"; "Reason for Rejection")
                // {
                //     Visible = "Reason for RejectionVisible";
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Reason for Rejection';
                // }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Help)
            {
                Caption = 'Help';
                Image = Help;                
                ApplicationArea = all;
                ToolTip = 'Help';

                trigger OnAction();
                begin
                    RecruitmentHeadGRec.RESET();
                    RecruitmentHeadGRec.SETRANGE("Recruitment Policy No.", "Recruitment Policy No.");
                    REPORT.RUNMODAL(33001300, true, false, RecruitmentHeadGRec);
                end;
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = ViewComments;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ApplicationArea = all;
                RunObject = Page "HR Comment Sheet B2B";
                RunPageLink = "Table Name" = CONST("Recruitment Header"),
                              "No." = FIELD("Recruitment Policy No.");
                ToolTip = 'Comment';
            }
        }
    }

    trigger OnInit();
    begin
        "Reason for RejectionVisible" := true;
    end;

    trigger OnOpenPage();
    begin
        if Status = Status::Rejected then
            "Reason for RejectionVisible" := true
        else
            "Reason for RejectionVisible" := false;
    end;

    var

        RecruitmentHeadGRec: Record "Recruitment Header B2B";

        [InDataSet]
        "Reason for RejectionVisible": Boolean;

}

