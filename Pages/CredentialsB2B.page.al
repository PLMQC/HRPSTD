page 33001216 "Credentials B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Credentials';
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
                field("Skill Type"; "Skill Type")
                {
                    ToolTip = 'Specifies the list of credentials defined "Qualification, Certification etc.." are tagged to Applicants or Employees';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        Type := FORMAT("Skill Type");
                        "Resume Database" := true;
                    end;
                }
                field("Credential Code"; "Credential Code")
                {
                    ToolTip = 'Specifies the creation of Skill Code e.g. " B.com - Bachelor of Commerce" etc..';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        Credential.SETRANGE("Document No.", "Document No.");
                        if Credential.FINDFIRST() then
                            Employee := false;
                    end;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the creation of Skill Name with associated Skill Code e.g. " B.com - Bachelor of Commerce" etc..';
                    ApplicationArea = all;
                }
                field(Percentage; Percentage)
                {
                    ToolTip = 'Specifies the education marks obtained and assigned to Applicant or Employee''s';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Credential: Record "Credentials B2B";
}

