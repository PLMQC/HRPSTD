page 33001487 "Employee Qualifications B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Qualifications';
    DataCaptionFields = "Employee No.";
    PageType = List;
    SourceTable = "Employee Qualification B2B";
    UsageCategory = Lists;

    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Qualification Code"; "Qualification Code")
                {
                    ToolTip = 'Enter Qualifaction code of the employee.';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Enter the Qualfication Course Start date.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Enter the Qualfication Course End date.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Select the Type from drop down which defined.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Employee Qualification Description.';
                    ApplicationArea = all;
                }
                field("Institution/Company"; "Institution/Company")
                {
                    ToolTip = 'Select Employee Studied Institution.';
                    ApplicationArea = all;
                }
                field(Cost; Cost)
                {
                    ToolTip = 'Course Fee for obtaining Qualification.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Course Grade"; "Course Grade")
                {
                    ToolTip = 'Grade obtained for Qualification.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ToolTip = 'Enter comments if any.';
                    ApplicationArea = all;
                }
                field("Skill Type"; "Skill Type")
                {
                    ToolTip = 'Select the Skills having by employee.';
                    ApplicationArea = all;

                }
            }
        }
        area(factboxes)
        {
            systempart(RecordLinks; Links)
            {
                Caption = 'RecordLinks';
                Visible = false;
                ApplicationArea = all;
            }
            systempart(Notes; Notes)
            {
                Caption = 'Notes';
                Visible = true;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Employee Qualification B2B"),
                                  "No." = FIELD("Employee No."),
                                  "Table Line No." = FIELD("Line No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Qualification Comment Details';
                }
                separator(Separator23)
                {
                }
                action("Q&ualification Overview")
                {
                    ToolTip = 'Specifies the Employee Qualification overview.';
                    Caption = 'Q&ualification Overview';
                    Image = QualificationOverview;
                    RunObject = Page "Qualification Overview B2B";
                    ApplicationArea = all;
                }
            }
        }
    }
}

