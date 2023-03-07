page 33001589 "Resource Planning B2B"
{
    PageType = Card;
    //ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Resource Planning B2B";
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            Group(Control1)
            {
                field("Document No."; "Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the document no';
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;

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
                    ToolTip = 'Specifies the position';

                }
                field("Job Description No."; "Job Description No.")
                {
                    Caption = 'Job Description No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the job description no.';

                }
                field("Total No.s"; "Total No.s")
                {
                    Caption = 'Total No.s"';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the total No.';
                    trigger OnValidate()
                    begin
                        CalcFields("Avaiable Resource Count");
                        "Required  Resources" := "Total No.s" - "Avaiable Resource Count";
                    end;

                }
                field("Avaiable Resource Count"; "Avaiable Resource Count")
                {
                    Caption = 'Available Resource No.s';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Available resources';

                }
                field("Required  Resources"; "Required  Resources")
                {
                    Caption = 'Required  Resources';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Required resource';

                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the status';

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Skills)
            {
                Caption = 'Skills';
                Image = Skills;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Credentials B2B";
                RunPageView = sorting("Document No.", "Document Type", "Line No.") where("Document Type" = const(Jobs));
                RunPageLink = "Document No." = field("Document No.");
                Visible = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the skills';
            }

            action("Create Indent")
            {
                Caption = 'Create Indent';
                Image = Indent;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the create indent';
                trigger OnAction()
                begin
                    //Testfield("Indent Created", false);
                    //B2BMMOn18012023>>
                    if "Required  Resources" = 0 then
                        Error(' Required Resource not equal 0');
                    if Status = Status::Open then
                        Error('Status should be Released')
                    else
                        CreateNewIndent();
                    //B2BMMOn18012023<<
                    "Indent Created" := true;

                    MODIFY();
                end;

            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the release';

                    trigger OnAction();
                    begin
                        Release();
                        MODIFY();
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the reopen';

                    trigger OnAction();
                    begin
                        Reopen();
                    end;
                }
            }
        }

    }

    trigger OnModifyRecord(): Boolean
    begin
        TestStatusOpen();
    end;

    procedure CreateNewIndent()
    var
        RecruitmentHeader: Record "Recruitment Header B2B";
        credintials: Record "Credentials B2B";
        credintials2: Record "Credentials B2B";
        Text001Lbl: Label 'Indent Document %1 created successfully', Comment = '%1 = Policy No';
    begin
        RecruitmentHeader.Init();
        RecruitmentHeader."Resource Planning" := true;
        RecruitmentHeader."Recruitment Policy No." := '';
        RecruitmentHeader.Insert(true);
        RecruitmentHeader."Document Type" := RecruitmentHeader."Document Type"::"Resource Indent";
        RecruitmentHeader."Indenting Dept." := "Department  code";
        RecruitmentHeader."Required Dept." := "Department  code";
        RecruitmentHeader."Required Position" := Position;
        RecruitmentHeader."Physaical Location" := "Location Code";
        RecruitmentHeader."No. of Resources" := "Required  Resources";
        RecruitmentHeader.Createddate := "Creation Date";
        RecruitmentHeader."Job Description No." := "Job Description No.";

        RecruitmentHeader."Resource Planning No." := "Document No.";
        RecruitmentHeader.Modify();
        /*
                credintials3.Reset();
                credintials3.SetRange("Document No.", "Document No.");
                if credintials3.FINDLAST() then
                    LineNoGVar := credintials3."Line No." + 10000
                else
                    LineNoGVar := 10000;
        */
        credintials.Reset();
        credintials.SetRange("Document No.", "Job Description No.");
        credintials.SetRange("Document Type", credintials."Document Type"::Jobs);
        if credintials.FINDSET() then
            repeat
                credintials2.Init();
                credintials2.TransferFields(credintials);
                credintials2."Document No." := RecruitmentHeader."Recruitment Policy No.";
                credintials2."Document Type" := credintials2."Document Type"::"Resource Indent";
                credintials2.Recruitment := true;
                credintials2.INSERT();
            until credintials.NEXT() = 0;
        Message(Text001Lbl, RecruitmentHeader."Recruitment Policy No.");
    end;




}