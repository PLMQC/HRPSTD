page 33001459 "Questionnaire line List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Questionnaire Line List';
    CardPageID = "Questionnaire Card B2B";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Questionnaire Line B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Profile Questionnaire Code"; "Profile Questionnaire Code")
                {
                    ToolTip = 'Select the profile questionnaire code.';
                    ApplicationArea = all;
                }
                field("Line No."; "Line No.")
                {
                    ToolTip = 'shows the squence numbers.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Shows the type question / answered.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the description of the Question.';
                    ApplicationArea = all;
                }
                field("Multiple Answers"; "Multiple Answers")
                {
                    ToolTip = 'Choose the Check mark for multiple answer.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

