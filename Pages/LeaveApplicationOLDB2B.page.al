page 33001282 "Leave Application OLD B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Application OLD';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Leave Application B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrEmpno1; CurrEmpno)
                {
                    Caption = 'Employee No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies employee no in leave application';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            CurrEmpno := Employee."No.";
                            Name := Employee."First Name";
                        end;
                        SelectEmployee();
                    end;
                }
                field(Name1; Name)
                {
                    Caption = 'Employee Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee name in leave application';
                }
            }
            repeater(Control1102152000)
            {
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave code  in leave application';

                    trigger OnValidate();
                    begin
                        if CurrEmpno = '' then
                            ERROR(Text000Lbl);
                    end;
                }
                field("Leave Duration"; "Leave Duration")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee leave duration in leave application';
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave from date   in leave application';
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave to date in leave application';
                }
                field("No.of Days"; "No.of Days")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee leave no.of days details  in leave application';
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee reason for leave  details  in leave application';
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee leave status  in leave application';
                }
                field(Sanctioned; Sanctioned)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave sactioned  details  in leave appilication';
                }
                field("Date of Sanction"; "Date of Sanction")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee leave date of sanction details  in leave application';
                }
                field("Date of Cancellation"; "Date of Cancellation")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee leave cancellation  details  in leave application';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Update &Leaves")
                {
                    Caption = 'Update &Leaves';
                    Image = Absence;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies employee loan piad details  in loan master';

                    trigger OnAction();
                    begin
                        UpdateAbsent();
                        LeaveConvertion();
                    end;
                }
                action("&Cancel Leave")
                {
                    Caption = '&Cancel Leave';
                    Image = Cancel;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies employee loan piad details  in loan master';

                    trigger OnAction();
                    begin
                        CancelLeaves(Rec);
                    end;
                }
                action("Sanction Details")
                {
                    Caption = 'Sanction Details';
                    Image = User;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Saction Details B2B";
                    RunPageLink = "Employee Code" = FIELD("Employee No."),
                                  "Leave Code" = FIELD("Leave Code"),
                                  "From Date" = FIELD("From Date"),
                                  "To Date" = FIELD("To Date");
                    ApplicationArea = all;
                    ToolTip = 'Specifies employee loan piad details  in loan master';
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        if CurrEmpno = '' then
            ERROR(Text000Lbl);
    end;

    trigger OnOpenPage();
    begin
        CurrEmpno := '';
        Name := '';
        if Hrsetup.FINDFIRST() then begin
            CurrYear := Hrsetup."Salary Processing Year";
            CurrMonth := Hrsetup."Salary Processing month";
        end;
        SelectEmployee();
    end;

    var
        Hrsetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        CurrEmpno: Code[20];
        Name: Text[50];
        Text000Lbl: Label 'Employee No. should  be selected';
        CurrYear: Integer;
        CurrMonth: Integer;

    procedure SelectEmployee();
    begin
        SETRANGE("Employee No.", CurrEmpno);
        CurrPage.UPDATE(false);
    end;

    procedure SelectYear();
    begin
        SETRANGE(Year, CurrYear);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        SETRANGE(Month, CurrMonth);
        CurrPage.UPDATE(false);
    end;

    local procedure CurrYearOnAfterValidate();
    begin
        SelectYear();
    end;
}

