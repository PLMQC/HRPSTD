page 33001592 "Resource Planning List B2B"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Resource Planning B2B";
    Editable = false;
    CardPageId = 33001589;
    // 
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Document No."; "Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document No';


                }
                field("Effective date"; "Effective date")
                {
                    Caption = 'Effective date';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the effective date';

                }

                field("Location Code"; "Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the location code';

                }
                field("Department  code"; "Department  code")
                {
                    Caption = 'Department  code';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the department code';

                }
                field(Position; Position)
                {
                    Caption = 'Position';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the postition';

                }
                field("Job Description No."; "Job Description No.")
                {
                    Caption = 'Job Description No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the job description no';

                }
                field("Total No.s"; "Total No.s")
                {
                    Caption = 'Total No.s"';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Total no';
                    trigger OnValidate()
                    begin
                        CalcFields("Avaiable Resource Count");
                        "Required  Resources" := "Total No.s" - "Avaiable Resource Count";
                    end;

                }
                field("Avaiable Resource Count"; "Avaiable Resource Count")
                {
                    Caption = 'Avaiable Resource No.s';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the available resorce count';

                }
                field("Required  Resources"; "Required  Resources")
                {
                    Caption = 'Required  Resources';
                    ApplicationArea = all;
                    ToolTip = 'Requirec resource';
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Status';
                }

            }
        }
    }
    trigger OnModifyRecord(): Boolean
    begin

    end;

    trigger OnOpenPage()
    var
        ResourcePlanning: Record "Resource Planning B2B";
    begin
        ResourcePlanning.RESET();
        if ResourcePlanning.FINDSET() then
            repeat
                ResourcePlanning.CalcFields("Avaiable Resource Count");
                ResourcePlanning."Required  Resources" := (ResourcePlanning."Total No.s" - ResourcePlanning."Avaiable Resource Count");
                ResourcePlanning.MODIFY();
            until ResourcePlanning.NEXT() = 0;

    end;
}