page 33001457 "Questionnaires B2B"
{
    // version B2BHR1.00.00

    Caption = 'Questionnaires';
    PageType = Worksheet;
    SourceTable = "Questionnaire Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Code"; Code)
                {
                    ToolTip = 'Choose the Code';
                    ApplicationArea = all;
                }
                field("Questionnaire Type"; "Questionnaire Type")
                {
                    ToolTip = 'Specifies the type of Questionnaire.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the Desription of the Questionnaire.';
                    ApplicationArea = all;
                }
                field("Employee Status"; "Employee Status")
                {
                    ToolTip = 'Specifies the Status of Employee. like permanent or contract etc.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

