page 33001301 "LOP Adjustment Entries B2B"
{
    // version B2BHR1.00.00

    Caption = 'LOP Adjustment Entries';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "LOP Adj. Entries B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Employee Code from the List displayed towards LOP Adjsutment Process';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Employee Name would be populated as soon as the Employee code is picked';
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Pay Gradre / Cadre of the Employee';
                }
                field("Adj. LOP Year"; "Adj. LOP Year")
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the LOP Adjustment Year';
                }
                field("Adj. LOP Month"; "Adj. LOP Month")
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the LOP Adjustment month';
                }
                field("LOP Year"; "LOP Year")
                {
                    ApplicationArea = all;
                    ToolTip = 'LOP Year will be populated as soon as the LOP day is picked from the List';
                }
                field("LOP Month"; "LOP Month")
                {
                    ApplicationArea = all;
                    ToolTip = 'LOP Month needs to be entered here';
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                    ToolTip = 'LOP Day against which the knock off needs to be done';
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'UserID is displayed';
                }
            }
        }
    }

    actions
    {
    }
}

