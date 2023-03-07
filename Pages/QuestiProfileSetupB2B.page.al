page 33001456 "Questi. Profile Setup B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Questionnaire Profile Setup';
    DelayedInsert = true;
    DeleteAllowed = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Questionnaire Line B2B";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(CurrentQuestionsChecklistCode1; CurrentQuestionsChecklistCode)
            {
                ToolTip = 'Choose the Question check list Code from drop down.';
                Caption = 'Questions Checklist Code';
                ApplicationArea = all;

                trigger OnLookup(Var Text: Text): Boolean;
                begin
                    if PAGE.RUNMODAL(0, Qheader) = ACTION::LookupOK then
                        CurrentQuestionsChecklistCode := Qheader.Code;

                    SETRANGE("Profile Questionnaire Code", CurrentQuestionsChecklistCode);
                    CurrPage.UPDATE(false);
                end;
            }
            repeater(Control1102152000)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                field("Heirarchy No."; "Heirarchy No.")
                {
                    ToolTip = 'Specifies the Heirarchy number.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Choose the Field type as Question or Answer.';
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
                field(Set; Set)
                {
                    ToolTip = 'Check Mark the Set.';
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
        DescriptionIndent := 0;
        TypeOnFormat();
        DescriptionOnFormat();
    end;

    trigger OnOpenPage();
    begin
        RESET();
        SETRANGE("Profile Questionnaire Code", CurrentQuestionsChecklistCode);
    end;

    var
        Qheader: Record "Questionnaire Header B2B";
        CurrentQuestionsChecklistCode: Code[20];

        [InDataSet]
        TypeEmphasize: Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;

    local procedure TypeOnFormat();
    begin
        if Type = Type::Heading then
            TypeEmphasize := true;

        if Type = Type::Answer then
            TypeEmphasize := true;
    end;

    local procedure DescriptionOnFormat();
    begin
        if Type = Type::Heading then
            DescriptionEmphasize := true
        else
            DescriptionIndent := 1;

        if Type = Type::Answer then
            DescriptionEmphasize := true
        else
            DescriptionIndent := 1;
    end;
}

