page 33001387 "Employee Provision Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Provisional Leaves';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "Provisional Leaves B2B";
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
                    ToolTip = 'Choose the Employee number.';
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
                    ToolTip = 'Specifies the Eployee name.';
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
            }
            repeater(Control1102154001)
            {
                Editable = false;
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
                field("Leave Descriptioon"; "Leave Descriptioon")
                {
                    ToolTip = 'Specifies theleave description.';
                    ApplicationArea = all;
                }
                field("No.of Leaves"; "No.of Leaves")
                {
                    ToolTip = 'Specifies the no. of Leaves.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specifies the Month.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Specifies the Year.';
                    ApplicationArea = all;
                }
                field("Applied Leaves"; "Applied Leaves")
                {
                    ToolTip = 'Shows the Number of Applied leaves.';
                    ApplicationArea = all;
                }
                field("Remaining Leaves"; "Remaining Leaves")
                {
                    ToolTip = 'Specifies the Remaining leaves avaliable for employee.';
                    ApplicationArea = all;
                }
                field("Period Start Date"; "Period Start Date")
                {
                    ToolTip = 'Specifies the period start date.';
                    ApplicationArea = all;
                }
                field("Period End Date"; "Period End Date")
                {
                    ToolTip = 'Specifies the period End date.';
                    ApplicationArea = all;
                }
                field("Prev. Month  Balance"; "Prev. Month  Balance")
                {
                    ToolTip = 'Specifies the leaves of previous month balance.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Shows the document status of Open/Released.';
                    ApplicationArea = all;
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
        Name := '';
        SelectEmployee();
    end;

    var
        Employee: Record "Employee B2B";
        CurrentEmpNo: Code[20];
        Cadre: Code[30];
        Name: Text[50];


    procedure SelectEmployee();
    begin
        SETRANGE("Employee No.", CurrentEmpNo);
        CurrPage.UPDATE(false);
    end;

    local procedure CurrentEmpNoOnAfterValidate();
    begin
        SelectEmployee();
    end;
}

