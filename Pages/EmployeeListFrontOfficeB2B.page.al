page 33001287 "Employee List Front Office B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee List_B2B Front Office';
    Editable = false;
    PageType = List;
    SourceTable = "Employee B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee No details in Employee list';
                }
                field(FullName; FullName())
                {
                    Caption = 'Full Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee full name  in Employee list';
                }
                field(Division; Division)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee division details in Employee list';
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Pay cadre details  in Employee list';
                }
                field("First Name"; "First Name")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee first name in employee list';
                }
                field("Middle Name"; "Middle Name")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee middle name in employee list';
                }
                field("Last Name"; "Last Name")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee last name in employee master';
                }
            }
        }
    }

    actions
    {
    }
}

