page 33001210 "Employee Qualification B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Qualifications B2B';
    DataCaptionFields = "Employee No.";
    PageType = List;
    SourceTable = "Employee Qualification B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Qualification Code"; "Qualification Code")
                {
                    ToolTip = 'Specifies the Employee''s Qualification code applicable';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Specifies the Employee''s Qualification From date';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Specifies the Employee''s Qualification To date';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Type';
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the Desciption applicable for the said training';
                    ApplicationArea = all;
                }
                field("Expiration Date"; "Expiration Date")
                {
                    ToolTip = 'Specifies the course expiration date';
                    ApplicationArea = all;
                }
                field("Institution/Company"; "Institution/Company")
                {
                    ToolTip = '"Specifies the Institution / Company name "';
                    ApplicationArea = all;
                }
                field(Cost; Cost)
                {
                    ToolTip = 'Specifies the cost involved';
                    ApplicationArea = all;
                }
                field("Course Grade"; "Course Grade")
                {
                    ToolTip = 'Specifies the Course Grade applicable';
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ToolTip = 'Specifies any general comments';
                    ApplicationArea = all;
                }
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
                Image = Certificate;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Employee Qualification B2B"),
                                  "No." = FIELD("Employee No."),
                                  "Table Line No." = FIELD("Line No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Qualification of Employee';
                }
            }
        }
    }
}

