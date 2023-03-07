page 33001264 "Bonus List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Bonus List';
    CardPageID = "Bonus B2B";
    Editable = false;
    PageType = List;
    SourceTable = Bonus_B2B;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Id; Id)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee ID in bonus list';
                }
                field("Effective Date"; "Effective Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Effective Date of Employee';
                }
                field("Bonus%"; "Bonus%")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee bonus% in bonus list ';
                }
                field("Ex-gratia%"; "Ex-gratia%")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee ex-gratia% in bonus list';
                }
                field("Min.Bonusable Salary"; "Min.Bonusable Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee minimum bonusable salary details';
                }
                field("Bonus Amount"; "Bonus Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee bonus amount in bonus list';
                }
            }
        }
    }

    actions
    {
    }
}

