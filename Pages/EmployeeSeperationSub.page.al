page 33001484 "Employee Seperation Sub B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Seperation Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Employee Separation Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Type; Type)
                {
                    ToolTip = 'Choose the Type as Question/Answer.';
                    ApplicationArea = all;
                }
                field(Question; Question)
                {
                    ToolTip = 'Shows the Question to be answered by Employee.';
                    ApplicationArea = all;
                }
                field("Multiple Answers"; "Multiple Answers")
                {
                    ToolTip = 'Check mark if there is multiple answers.';
                    ApplicationArea = all;
                }
                field(Set; Set)
                {
                    ToolTip = 'Choose the Check mark if needed.';
                    ApplicationArea = all;
                }
                field("Hierarchy No."; "Hierarchy No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        TypeOnFormat();
        QuestionOnFormat();
    end;

    var
        [InDataSet]
        TypeEmphasize: Boolean;
        [InDataSet]
        QuestionEmphasize: Boolean;

    local procedure TypeOnFormat();
    begin
        if Type = Type::Question then
            TypeEmphasize := true;
        if Type = Type::Heading then
            TypeEmphasize := true;
    end;

    local procedure QuestionOnFormat();
    begin
        if Type = Type::Question then
            QuestionEmphasize := true;
        if Type = Type::Heading then
            QuestionEmphasize := true;
    end;
}

