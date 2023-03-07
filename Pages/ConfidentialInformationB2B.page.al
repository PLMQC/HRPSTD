page 33001479 "Confidential Information B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Confidential Information';
    DataCaptionFields = "Employee No.";
    PageType = List;
    SourceTable = "Confidential Information B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Confidential Code"; "Confidential Code")
                {
                    ToolTip = 'Choose the Unquie Confidential code.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Enter the Descripion of the Confidential information.';
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ToolTip = 'Enter the Comments if Any.';
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
            group("&Confidential")
            {
                ToolTip = 'Specifies the Confidential information of employee.';
                Caption = '&Confidential';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Confidential Comment Sheet";
                    RunPageLink = "Table Name" = filter('Confidential Information_b2b'),
                                  "No." = FIELD("Employee No."),
                                  Code = FIELD("Confidential Code"),
                                  "Table Line No." = FIELD("Line No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Confidential Comment Details';
                }
            }
        }
    }
}

