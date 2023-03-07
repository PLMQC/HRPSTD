page 33001332 "Resouce Indent Archives B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resouce Indent Archive List';
    CardPageID = "Resource Indent Archive B2B";
    PageType = List;
    SourceTable = "Recruitment Header Archive B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152061)
            {
                field("Recruitment Policy No."; "Recruitment Policy No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Recruitment Policy Number as per Number Series Set';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Recruitment Policy Description';
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Recruitment Department Name.';
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the NUmber of Resources Needed towards Recruitment Indent.';
                }
                field("Skill Set"; "Skill Set")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Skill Set required towards the Recruitment Indent.';
                }
                field(Qualification; Qualification)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Qualification required towards the Recruitment Indent.';
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Job Date of Requirement for the  Recruitment Indent.';
                }
                field(Comments; Comments)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify any general remarks or notes towards the Recruitment Indent.';
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Number Series required towards the Recruitment Indent.';
                }
                field("Required Position"; "Required Position")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Postion Required towards the Recruitment Indent.';
                }
                field("Required Dept."; "Required Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Reuired Department Name towards the Recruitment Indent.';
                }
                field(Certification; Certification)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Certification required towards the Recruitment Indent.';
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Name in case of Reference towards the Recruitment Indent.';
                }
                field("Experience Type"; "Experience Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Experience Type - Experience / Fresher required towards the Recruitment Indent.';
                }
                field(Months; Months)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the month towards the Recruitment Indent.';
                }
                field(Expertise; Expertise)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Expertise required towards the Recruitment Indent.';
                }
                field("Job Description2"; "Job Description2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Job Description required towards the Recruitment Indent.';
                }
                field("Age Group"; "Age Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Age Group required towards the Recruitment Indent.';
                }
                field("Other Spec"; "Other Spec")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify any other specifications required towards the Recruitment Indent.';
                }
                field("Salary Range"; "Salary Range")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Salary Range required towards the Recruitment Indent.';
                }
                field("Future Growth"; "Future Growth")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Future Growth required towards the Recruitment Indent.';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Priority required towards the Recruitment Indent.';
                }
                field(Recuritment; Recuritment)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Recruitment required towards the Recruitment Indent.';
                }
                field(Division; Division)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Division towards which the Recruitment Indent is raised.';
                }
                field("Reason For Recruitment"; "Reason For Recruitment")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Reason for Recruitment towards the Recruitment Indent.';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Document Status as Released /Open towards the Recruitment Indent.';
                }
                field(Approved; Approved)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify whether the Recruitment Indent is approved?.';
                }
                field("Last Date of Modified"; "Last Date of Modified")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Last Date of Modified towards the Recruitment Indent.';
                }
                field("Type of Industry"; "Type of Industry")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Type of Industry required towards the Recruitment Indent.';
                }
                field(Docno; Docno)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the document no. towards the Recruitment Indent.';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Designation required towards the Recruitment Indent.';
                }
                field("Exp. in Related Designation"; "Exp. in Related Designation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Experience in Related Designation towards the Recruitment Indent.';
                }
                field("Gender Preference"; "Gender Preference")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Gender Preserence towards the Recruitment Indent.';
                }
                field(Justification; Justification)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Nature of Justification';
                }
                field(Available; Available)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Nature of Availbility ';
                }
                field(Required; Required)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Requirement';
                }
                field(Experience; Experience)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Experience';
                }
                field(Position; Position)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Nature of Position';
                }
                field("Nature of Position"; "Nature of Position")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Nature of Position';
                }
                field("Within Budget"; "Within Budget")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify Whether it is in Budget?.';
                }
                field("Managerial Expertise"; "Managerial Expertise")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify Whether the  Managerial Expertise is required for Recruitment.';
                }
                field(CLOSE; Close)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify Whether the  Recruitment Indent is Closed.';
                }
                // field(Blocked; Blocked)
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specify Whether the  Recruitment Indent is Blocked.';
                // }
                // field("Training/Probation Period"; "Training/Probation Period")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the Training / Probation Period required towards the Recruitment Indent.';
                // }
                // field("Source of Getting Manpower"; "Source of Getting Manpower")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the Source of Getting Manpower towards the Recruitment Indent.';
                // }
                // field(Reason; Reason)
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the Reason required towards the Recruitment Indent.';
                // }
                // field("Reason for Rejection"; "Reason for Rejection")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the Reason for Rejection required towards the Recruitment Indent.';
                // }
                // field("Archived By"; "Archived By")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the Last modified details towards the Recruitment Indent.';
                // }
                // field(Source; Source)
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the Source of Recruiting required towards the Recruitment Indent.';
                // }
                // field("No.Series"; "No.Series")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specify the Number Seried required towards the Recruitment Indent.';
                // }
                field(Createddate; Createddate)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Recruitment Indent created Date.';
                }
                field("Resource Indent No."; "Resource Indent No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Resource Indent number required towards the Recruitment Indent.';
                }
                field("Vacancy Since"; "Vacancy Since")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Vaccancy Period required towards the Recruitment Indent.';
                }
                field("Salary Type"; "Salary Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifes the Salary TYpe required towards the Recruitment Indent.';
                }
                field("Salary Period"; "Salary Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Salary Period required towards the Recruitment Indent.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(List)
            {
                Caption = 'List';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Resource Indent Archive B2B";
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = all;
                    ToolTip = 'Specify the List';
                }
            }
        }
    }
}

