page 33001401 "Family Details & Relation B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Family Details & Relation';
    PageType = Worksheet;
    SourceTable = "Employee Relative B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Relative Code"; "Relative Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the relative code details';
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the first name';
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the middle name';
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the last name';
                }
                field("Birth Date"; "Birth Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the birth date';
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify enter the  phone number ';
                }
                field("Relatives Employee No."; "Relatives Employee No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the relative employee no';
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the any comments';
                }
                field(Relative; Relative)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the relative details';
                }
                field("Reference Name"; "Reference Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the reference name';
                }
                field(Address1; Address1)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the address1 details';
                }
                field(Address2; Address2)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the address2 details';
                }

                field(Occupation; Occupation)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the Occupation details';
                }
                field("Relative Type"; "Relative Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the relative type details';
                }
            }
        }

    }

    actions
    {
        area(navigation)
        {
            group("<Action25>")
            {
                Caption='Relative';
                action("<Action26>")
                {
                    Caption= 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST ("Employee Relative B2B"),
                                  "No." = FIELD ("Employee No."),
                                  "Table Line No." = FIELD ("Line No.");
                    ApplicationArea = all;
                    ToolTip = 'specify the comment sheet details';
                }
            }
        }
    }
}

