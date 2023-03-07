page 33001217 "Recruitment Credentials B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Recruitment Credentials';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = Worksheet;
    SourceTable = "Credentials B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Type; Type)
                {
                    Editable = false;
                    ToolTip = 'Specifies the different type of Recruitment Credentials " Qualification, Skills, Certification"';
                    ApplicationArea = all;
                }
                field("Credential Code"; "Credential Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Recruitment credentials which are helpful in selecting the applicants during recruitment Process " Qualification, Skill, Certification"';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of description associated with recruitment credentials';
                    ApplicationArea = all;
                }
                field(Recruitment; Recruitment)
                {
                    ToolTip = 'Specifies the document origin as part of Recruitment moudle';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Insert)
            {
                Caption = '&Insert';
                Image = Insert;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the Resume Credential Insert details.';

                trigger OnAction();
                var
                begin
                    Ok := DIALOG.CONFIRM(Text001Lbl, true);
                    if Ok then begin
                        UpdateExp.RUN();
                        InsertResumeRecords1("Document No.", Type, "Credential Code", Recruitment);
                        Flag := true;
                        CurrPage.CLOSE();
                    end else
                        Flag := false;
                end;
            }
        }
    }

    var
        UpdateExp: Report "Update Experience B2B";
        Flag: Boolean;
        Ok: Boolean;
        Text001Lbl: Label 'Do you want to Insert Records';
}

