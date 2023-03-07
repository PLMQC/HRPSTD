page 33001294 "EmpDet_Emp leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Details_Emp. leaves';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Employee Leaves B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Leave Code';
                }
                field("Leave Description"; "Leave Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Leave Description from the Leave Code';
                }
                field("No. of Available Leaves"; "No. of Available Leaves")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Number of Leaves available.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := true;
    end;

    procedure GetEmp(Month: Integer; Year: Integer; EmpCode: Code[20]);
    begin
        RESET();
        SETRANGE("No.", EmpCode);
        CurrPage.UPDATE(false);
    end;
}

