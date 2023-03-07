page 33001263 "Bonus B2B"
{
    // version B2BHR1.00.00

    Caption = 'Bonus';
    PageType = Card;
    SourceTable = Bonus_B2B;
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Effective Date"; "Effective Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee effective date in bonus ';
                }
                field("Bonus%"; "Bonus%")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee bonus%  in bonus setup';
                }
                field("Ex-gratia%"; "Ex-gratia%")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee ex-gratia% in bonus setup';
                }
                field("Min.Bonusable Salary"; "Min.Bonusable Salary")
                {
                    Caption = 'Bonusable Salary';
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee bonus salary in bonus limit';
                }
                field("Bonus Amount"; "Bonus Amount")
                {
                    Caption = 'Bonus Limit';
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee bonus limit in bonus setup';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Bonus")
            {
                Caption = '&Bonus';
                action(List)
                {
                    Caption = 'List';
                    Image = ListPage;
                    RunObject = Page "Bonus List B2B";
                    ShortCutKey = 'F5';
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee bonus slab in bonus setup';
                }
            }
        }
    }
}

