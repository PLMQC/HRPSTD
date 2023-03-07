page 33001237 "Leave Application - san B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Application - Sanc.';
    DelayedInsert = true;
    PageType = worksheet;
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
                    ToolTip = 'Specifies The emplyee no';
                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            CurrEmpno := Employee."No.";
                            Name := Employee."First Name";
                        end;
                        SelectEmployee();
                    end;

                    trigger OnValidate();
                    begin
                        CurrEmpnoOnAfterValidate();
                    end;
                }
                field(Name1; Name)
                {
                    Caption = 'Employee Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The name';
                }
            }
            repeater(Control1102152000)
            {
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Leave Code';
                    trigger OnValidate();
                    begin
                        if CurrEmpno = '' then
                            ERROR(Text000Lbl);
                    end;
                }
                field("Leave Duration"; "Leave Duration")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave dration';
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The from date';
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The To date';
                }
                field("No.of Days"; "No.of Days")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The no of days';
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Reason for leave';
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The status';
                }
                field(Sanctioned; Sanctioned)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Sanctioned';
                }
                field("Sanctioning Incharge"; "Sanctioning Incharge")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The sanction incharge';
                }
                field("Date of Sanction"; "Date of Sanction")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The date of sanction';
                }
                field("Date of Cancellation"; "Date of Cancellation")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The date of cancellation';
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
                Image = "Action";
                action("Update &Leaves")
                {
                    Caption = 'Update &Leaves';
                    Image = Absence;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The update leave';
                    
                    trigger OnAction();
                    begin
                        UpdateAbsent();
                        LeaveConvertion();
                        MESSAGE(Text001Lbl);
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
                    ToolTip = 'Specifies The cancel leave';
                    trigger OnAction();
                    begin
                        CancelLeaves(Rec);
                    end;
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
        Text001Lbl: Label 'Leaves updated Successfully';

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

    local procedure CurrEmpnoOnAfterValidate();
    begin
        SelectEmployee();
    end;

    local procedure CurrYearOnAfterValidate();
    begin
        SelectYear();
    end;
}

