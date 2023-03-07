page 33001312 "Employee Languages B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Languages';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Employee Hobbies & Lang. B2B";
    SourceTableView = SORTING ("Employee No.", "Line Type", "Line No.")
                      ORDER(Ascending)
                      WHERE ("Line Type" = CONST (Language));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Language Name"; "Language Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Sepcify the Language Known here';
                }
                field("To Read"; "To Read")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify whether the Employee can Read the Language';
                }
                field("To Write"; "To Write")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify whether the Employee can Write the Language';
                }
                field("To Speak"; "To Speak")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify whether the Employee can Speak the Language';
                }
            }
        }
    }

    actions
    {
    }
}

