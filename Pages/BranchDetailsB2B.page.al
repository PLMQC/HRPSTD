page 33001280 "Branch Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Branch Details';
    PageType = Card;
    SourceTable = "Branch Details B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the branch code in employee master';

                }
                field("Branch Name"; "Branch Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the branch name  in employee master';
                }
                field(Address; Address)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the branch address in employee master';
                }
                field(Address2; Address2)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the branch address2 in employee master';
                }
                field("Post Code/City"; "Post Code/City")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the branch post code and city in employee master';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the communication related detils in employee master';
                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the fax no  in employee master';
                }
                field("Email Id"; "Email Id")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies email id  in employee master';
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field("ESI No."; "ESI No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the personal details  in employee master';
                }
                field("PF No."; "PF No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the PF no in employee master';
                }
                field("PAN No."; "PAN No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Pan No in employee master';
                }
            }
        }
    }

    actions
    {
    }
}

