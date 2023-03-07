page 33001478 "Misc. Article Information B2B"
{
    // version B2BHR1.00.00

    Caption='Misc. Article Information';
    DataCaptionFields = "Employee No.";
    PageType = List;
    SourceTable = "Misc. Article Information B2B";
    UsageCategory = Lists;

    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Specifies the employee number of the involved entry or record, according to the specified number series';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Misc. Article Code"; "Misc. Article Code")
                {
                    ToolTip = 'Specifies the misllenous article code.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Enter the Description.';
                    ApplicationArea = all;
                }
                field("Serial No."; "Serial No.")
                {
                    ToolTip = 'Unquie Serial number.';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Choose the Start date.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Choose the End date.';
                    ApplicationArea = all;
                }
                field("In Use"; "In Use")
                {
                    ToolTip = 'Specifies the inuse of Article information.';
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
            group("Mi&sc. Article")
            {
                Caption='Mi&sc. Article';
                action("Co&mments")
                {
                    ToolTip = 'Specifies the misllenous article information.';
                    Caption='Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST ("Misc. Article Information B2B"),
                                  "No." = FIELD ("Employee No.");
                    ApplicationArea = all;
                }
            }
        }
    }
}

