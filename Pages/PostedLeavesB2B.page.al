page 33001388 "Posted Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Leaves';
    PageType = Worksheet;
    SourceTable = "Posted Leave App Line B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentEmpNo1; CurrentEmpNo)

                {
                    ToolTip = 'Choose the Employee Number.';
                    Caption = 'Employee Code';
                    ApplicationArea = all;
                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            CurrentEmpNo := Employee."No.";
                            Name := Employee."First Name";
                            Cadre := Employee."Pay Cadre";
                        end;
                        SelectEmployee();
                    end;

                    trigger OnValidate();
                    begin
                        if Employee.GET(CurrentEmpNo) then begin
                            Name := Employee."First Name";
                            Cadre := Employee."Pay Cadre";
                        end else begin
                            Name := '';
                            Cadre := '';
                        end;

                        if CurrentEmpNo = '' then begin
                            Name := '';
                            Cadre := '';
                        end;
                        CurrentEmpNoOnAfterValidate();
                    end;
                }
                field(Name1; Name)
                {
                    ToolTip = 'Specifies the Employee name.';
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Cadre1; Cadre)
                {
                    ToolTip = 'Specifies the Employee Cadre.';
                    Caption = 'Employee Cadre';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(CurrentApplicationNo1; CurrentApplicationNo)
                {
                    ToolTip = 'Specifies the Application Number.';
                    Caption = 'Leave Application No.';
                    ApplicationArea = all;
                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PostLeaveApp.RESET();
                        PostLeaveApp.SETRANGE("Employee No.", "Employee No.");
                        if PAGE.RUNMODAL(0, PostLeaveApp) = ACTION::LookupOK then
                            CurrentApplicationNo := PostLeaveApp."Document No.";


                        SelectEmployee();
                    end;
                }
            }
            repeater(Control1102154001)
            {
                Editable = false;
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Shows unique Document No.';
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee Number.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Specifies the Employee name.';
                    ApplicationArea = all;
                }
                field("Leave Code"; "Leave Code")
                {
                    ToolTip = 'Shows the leave code.';
                    ApplicationArea = all;
                }
                field("Leave Duration"; "Leave Duration")
                {
                    ToolTip = 'Shows the Leave Duration.';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Shows the Start Date of leaves.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Shows the End date of the Leave.';
                    ApplicationArea = all;
                }
                field("Approved Leaves"; "Approved Leaves")
                {
                    ToolTip = 'Shows the Approved leaves.';
                    ApplicationArea = all;
                }
                field("Rejected Leaves"; "Rejected Leaves")
                {
                    ToolTip = 'Shows the Rejected leaves of Employee.';
                    ApplicationArea = all;
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    ToolTip = 'Shows the Reason for leave.';
                    ApplicationArea = all;
                }
                field("No.of Days"; "No.of Days")
                {
                    ToolTip = 'Shows the No. of Days taken leave.';
                    ApplicationArea = all;
                }
                field("Processed Status"; "Processed Status")
                {
                    ToolTip = 'Show the processed Status.';
                    ApplicationArea = all;
                }
            }
            part(LeaveplanSubfrm1; "Posted Leave Plan B2B")
            {
                Caption = 'LeaveplanSubfrm';
                SubPageLink = "Employee No" = FIELD("Employee No."),
                              "Leave Code" = FIELD("Leave Code"),
                              "Leave Application No." = FIELD("Document No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        CurrentEmpNo := '';
        Name := '';
        SelectEmployee();
    end;

    var
        Employee: Record "Employee B2B";
        PostLeaveApp: Record "Posted Leave App Header B2B";
        CurrentEmpNo: Code[20];
        Cadre: Code[30];
        Name: Text[50];
        CurrentApplicationNo: Code[20];

    procedure SelectEmployee();
    begin
        RESET();
        SETRANGE("Employee No.", CurrentEmpNo);
        SETFILTER("Document No.", CurrentApplicationNo);
        CurrPage.UPDATE(false);
    end;

    local procedure CurrentEmpNoOnAfterValidate();
    begin
        SelectEmployee();
    end;
}

