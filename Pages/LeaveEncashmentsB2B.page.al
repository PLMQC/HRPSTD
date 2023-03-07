page 33001276 "Leave Encashments B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Encashments';
    CardPageID = "Leave Encashment B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Leave Encashment Header B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Encashment Code"; "Encashment Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the applicable Leave encashment code as defined in the Leave master for type ecashable';
                }
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the employee code to whom the Leave encashment process is being done';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'The employee is popluated as soon as the employee code is defined.';
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the month in which the encashment is to be done';
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  year in which the ecashment is to be done.';
                }
                field(PayCadre; PayCadre)
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / map  the Employee Grade applicable';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define / Enter the posting date of Leave encashment.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    Caption = 'Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Posting of Leave ';
                    trigger OnAction();
                    begin
                        PostEncashment();
                    end;
                }
            }
        }
    }
}

