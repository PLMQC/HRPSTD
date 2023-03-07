page 33001288 "Daily Attend Front Office B2B"
{
    // version B2BHR1.00.00

    Caption = 'Daily Attendance Front Office';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Daily Attendance B2B";
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
                    ToolTip = 'Specifies the employee No in employee daily attendance ';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(33001287, Employee) = ACTION::LookupOK then begin
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
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee name in employee daily attendance';
                }
                field(Cadre1; Cadre)
                {
                    Caption = 'Pay Cadre';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee pay cadre  in employee daily attendance';
                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee middle name in employee daily attendance';

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee middle name in employee daily attendance';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102152000)
            {
                Editable = true;
                field(Date; Date)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee data editable false in employee daily attendance';
                }
                field("Time In"; "Time In")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee punch time-in in employee daily attendance';
                }
                field("Time Out"; "Time Out")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee punch time out in employee daily attendance';
                }
                field("Hours Worked"; "Hours Worked")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee hours worked in employee daily attendance';
                }
                field("Hrs Worked"; "Hrs Worked")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee hours worked in employee daily attendance';
                }
                field("OT Hrs"; "OT Hrs")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee OT hrs in employee daily attendance';
                }
                field("OT Approved Hrs"; "OT Approved Hrs")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee OT approved hrs in employee daily attendance';
                }
                field("Non-Working"; "Non-Working")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee non-working day in employee daily attendance';
                }
                field("Attendance Type"; "Attendance Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee attendnce type wether present,obsent and leave in employee daily attendance';
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee remarks in employee daily attendance';
                }
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee leve code in employee daily attendnce';
                }
                field(Activity; Activity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee activity in employee daily attendance';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Previous)
            {
                Caption = 'Previous';
                Image = PreviousSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                ApplicationArea = all;
                ToolTip = 'Specifies the employee previous daily attendance';

                trigger OnAction();
                var
                    Navigate: Record "Daily Attendance B2B";
                begin
                    if CurrentMonth = 1 then
                        Year := CurrentYear - 1
                    else
                        Year := CurrentYear;

                    if CurrentMonth = 1 then
                        Month := 12
                    else
                        Month := CurrentMonth - 1;

                    Navigate.SETRANGE(Year, Year);
                    Navigate.SETRANGE(Month, Month);
                    if not Navigate.IsEmpty() then begin
                        if CurrentEmpNo = '' then
                            ERROR(Text001Lbl);
                        CurrentYear := Year;
                        CurrentMonth := Month;
                        SelectYear();
                        SelectMonth();
                    end else
                        ERROR(Text000Lbl);
                end;
            }
            action(Next)
            {
                Caption = 'Next';
                Image = NextSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the Next Month daily Attendence Details';


                trigger OnAction();
                var
                    Navigate: Record "Daily Attendance B2B";
                begin
                    if CurrentMonth = 12 then
                        Year := CurrentYear + 1
                    else
                        Year := CurrentYear;

                    if CurrentMonth = 12 then
                        Month := 1
                    else
                        Month := CurrentMonth + 1;

                    Navigate.SETRANGE(Year, Year);
                    Navigate.SETRANGE(Month, Month);
                    if not Navigate.IsEmpty() then begin
                        if CurrentEmpNo = '' then
                            ERROR(Text001Lbl);
                        CurrentYear := Year;
                        CurrentMonth := Month;
                        SelectYear();
                        SelectMonth();
                    end else
                        ERROR(Text000Lbl);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        DateOnFormat();
    end;

    trigger OnOpenPage();
    begin
        CurrentEmpNo := '';
        Name := '';
        if HRSetup.FINDFIRST() then begin
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        end;
        SelectEmployee();
        SelectYear();
        SelectMonth();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        CurrentEmpNo: Code[20];
        Text000Lbl: Label 'There are no records with in these filters';
        Text001Lbl: Label '"Please, Select Employee "';
        Cadre: Code[30];
        Name: Text[50];
        CurrentMonth: Integer;
        CurrentYear: Integer;

    procedure SelectYear();
    begin
        SETRANGE("Not Joined", 0);
        SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        SETRANGE("Not Joined", 0);
        SETRANGE(Month, CurrentMonth);
        CurrPage.UPDATE(false);
    end;

    procedure SelectEmployee();
    begin
        SETRANGE("Not Joined", 0);
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

    local procedure DateOnFormat();
    begin
        if "Non-Working" then;
    end;
}

