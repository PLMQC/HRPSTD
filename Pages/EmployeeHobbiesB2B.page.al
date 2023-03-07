page 33001306 "Employee Hobbies B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Hobbies';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Employee Hobbies & Lang. B2B";
    SourceTableView = SORTING("Employee No.", "Line Type", "Line No.")
                      ORDER(Ascending)
                      WHERE("Line Type" = CONST(Hobby));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Hobby; Hobby)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Hobby Code eg. Music, Cricket etc';
                }
                field("Hobby Description"; "Hobby Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Hobby Description';
                }
            }
        }
    }

    actions
    {
    }
}

