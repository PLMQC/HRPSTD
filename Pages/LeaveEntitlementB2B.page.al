page 33001235 "Leave Entitlement B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Entitlement';
    PageType = worksheet;
    SourceTable = "Leave Entitlement B2B";
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
                    Caption = 'Employee No.';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee No in General ';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, EmployeeRec) = ACTION::LookupOK then begin
                            CurrentEmpNo := EmployeeRec."No.";
                            NameTxt := EmployeeRec."First Name";
                        end;
                        SelectEmployee();
                    end;

                    trigger OnValidate();
                    begin
                        CurrentEmpNoOnAfterValidate();
                    end;
                }
                field(Name1; NameTxt)
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Name';
                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Payroll Year';

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Payroll Month';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102152000)
            {
                Editable = false;
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Code In Leave Master';
                }
                field("Total Leaves"; "Total Leaves")
                {
                    Caption = 'Carry forward Leaves';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Carry forward leaves In Leave Master';
                }
                field("Leave Encashed"; "Leave Encashed")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Encashed In Leave Master';
                }
                field(Probation; Probation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Probation Leave Details';
                }
                field("Leave Year Closing Period"; "Leave Year Closing Period")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Year Closing Period';
                }
                field("Leaves Carried"; "Leaves Carried")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leaves Carried In Leave Master';
                }
                field("Leaves taken during Month"; "Leaves taken during Month")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave taken during month in Leave Application';
                }
                field("Leave Bal. at the Month End"; "Leave Bal. at the Month End")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Balance at the Month End';
                }
                field("Leaves Expired"; "Leaves Expired")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leaves Expired Details';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        CurrentEmpNo := '';
        NameTxt := '';
        if HRSetup.FINDFIRST() then begin
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        end;
        SelectEmployee();
        SelectYear();
        SelectMonth();
    end;

    var
        EmployeeRec: Record "Employee B2B";
        HRSetup: Record "HR Setup B2B";
        CurrentEmpNo: Code[20];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        NameTxt: Text[50];

    procedure SelectYear();
    begin
        SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        SETRANGE(Month, CurrentMonth);
        CurrPage.UPDATE(false);
    end;

    procedure SelectEmployee();
    begin
        SETRANGE("Employee No.", CurrentEmpNo);
        CurrPage.UPDATE(false);
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        SelectYear()
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        SelectMonth();
    end;

    local procedure CurrentEmpNoOnAfterValidate();
    begin
        SelectEmployee();
    end;
}

