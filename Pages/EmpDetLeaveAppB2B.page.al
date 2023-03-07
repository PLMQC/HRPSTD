page 33001293 "EmpDet LeaveApp B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Details_Leave App.';
    DelayedInsert = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Posted Leave App Line B2B";
    SourceTableView = WHERE("Processed Status" = FILTER(= " "));


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Leave Application document number towards a employee';
                }
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Leave code appllied towards a employee';
                }
                field("Leave Duration"; "Leave Duration")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Leave Duration in number of days towards a employee';
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Leave to Avail date of a employee';
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Leave availed To Date of a employee';
                }
                field("No.of Days"; "No.of Days")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Number of Days for which the leave is applied for a employee';
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Reason Code Written towards a employee';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetEmp(Month: Integer; Year: Integer; EmpCode: Code[20]);
    begin
        RESET();
        SETRANGE("Employee No.", EmpCode);
        SETRANGE(Month, Month);
        SETRANGE(Year, Year);
        SETRANGE("Processed Status", "Processed Status"::" ");
        CurrPage.UPDATE(false);
    end;
}

