page 33001509 "Goals Budget Approval B2B"
{
    // version B2BHR1.00.00

    Caption = 'Goals Budget Approval';
    PageType = Worksheet;
    SourceTable = "Employee Goals B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Approvar ID"; "Approvar ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the approvar id';
                }
                field(Quarter; Quarter)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Quarter';
                }
                field("Goals Description"; "Goals Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Goals Description';
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the serial No';
                }
                field("Budget Weightage"; "Budget Weightage")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Budget Weightage';
                }
                field(Select; Select)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Select';
                }
                field("Actual Weightage"; "Actual Weightage")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Actual weightage';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Approve")
            {
                Caption = '&Approve';
                Image = Approve;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Approve';
                trigger OnAction();
                begin
                    EmployeeGoals.RESET();
                    EmployeeGoals.SETRANGE("Approvar ID", USERID());
                    EmployeeGoals.SETRANGE(Select, true);
                    if EmployeeGoals.FINDFIRST() then
                        repeat
                            if EmployeeGoals."Weightage Status" <> EmployeeGoals."Weightage Status"::"Approved" then begin
                                EmployeeGoals."Weightage Status" := EmployeeGoals."Weightage Status"::"Approved";
                                EmployeeGoals.MODIFY();
                            end;
                        until EmployeeGoals.NEXT() = 0;

                end;
            }
            action("&Reject")
            {
                Caption = '&Reject';
                Image = Reject;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Reject';
                trigger OnAction();
                begin
                    EmployeeGoals.RESET();
                    EmployeeGoals.SETRANGE("Approvar ID", USERID());
                    EmployeeGoals.SETFILTER("Weightage Status", '<>%1', EmployeeGoals."Weightage Status"::"Approved");
                    if EmployeeGoals.FINDFIRST() then
                        repeat
                            EmployeeGoals."Weightage Status" := EmployeeGoals."Weightage Status"::Open;
                            EmployeeGoals.MODIFY();
                        until EmployeeGoals.NEXT() = 0;

                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        SETRANGE("Approvar ID", USERID());
        SETFILTER("Weightage Status", '%1', "Weightage Status"::"Pending Approval");
    end;

    var
        EmployeeGoals: Record "Employee Goals B2B";
}

