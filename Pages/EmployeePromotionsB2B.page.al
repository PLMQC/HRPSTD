page 33001490 "Employee Promotions B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Promotion List';
    CardPageID = "Employee Promotion B2B";
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Change in Cadre B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Emp No."; "Emp No.")
                {
                    ToolTip = 'Specifies the employee number of the involved entry or record, according to the specified number series';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Specify Employee''s Department Code';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ToolTip = 'Specify Designation of the Employee';
                    ApplicationArea = all;
                }
                field("New Department Code"; "New Department Code")
                {
                    ToolTip = 'Specify Employee''s Department Code';
                    ApplicationArea = all;
                }
                field("Physical Location Code"; "Physical Location Code")
                {
                    ToolTip = 'Specify the Physcial Code of the Employee';
                    ApplicationArea = all;
                }
                field("New Designation"; "New Designation")
                {
                    ToolTip = 'Specify Designation of the Employee';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specify the effictive date from which it applicable';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Promotion")
            {
                Caption = '&Promotion';
                action(Card)
                {
                    ToolTip = 'Specifies the Promotion card.';
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Employee Promotion B2B";
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = all;
                }
            }
        }
    }

    var
}

