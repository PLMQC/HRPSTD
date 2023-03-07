page 33001297 "Emp Alternative Add List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp Alternative Address List';
    CardPageID = "Emp Alternative Add Card B2B";
    DataCaptionFields = "Employee No.";
    Editable = false;
    PageType = List;
    SourceTable = "Emp Alternative Address B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative Address code towards the employee';
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative Address Name towards the employee';
                }
                field("Name 2"; "Name 2")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative Address Name towards the employee';
                }
                field(Address; Address)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative Address code towards the employee';
                }
                field("Address 2"; "Address 2")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative Address code towards the employee';
                }
                field(City; City)
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative City Address code towards the employee';
                }
                field("Post Code"; "Post Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative Post code towards the employee';
                }
                field(County; County)
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative County code towards the employee';
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative Phone Number towards the employee';
                }
                field("Fax No."; "Fax No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative FAX Number towards the employee';
                }
                field("E-Mail"; "E-Mail")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Displays the Alternative Email Address code towards the employee';
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Comments if any towards the employee';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Address")
            {
                Caption = '&Address';
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page "Emp Alternative Add Card B2B";
                    RunPageLink = "Employee No." = FIELD("Employee No."),
                                  Code = FIELD(Code);
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Address Card of the Employee';
                }
            }
        }
    }
}

