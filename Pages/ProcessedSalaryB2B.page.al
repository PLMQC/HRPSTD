page 33001243 "Processed Salary B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Processed Salary';
    PageType = Worksheet;
    SourceTable = "Processed Salary B2B";
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
                    ToolTip = 'specifies the current employee no for the processed one';
                    ApplicationArea = all;
                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            CurrentEmpNo := Employee."No.";
                            Name := Employee."First Name";
                        end;
                        SelectEmployee();
                        GetSalary();
                    end;

                    trigger OnValidate();
                    begin
                        if Employee.GET(CurrentEmpNo) then
                            Name := Employee."First Name";
                        if CurrentEmpNo = '' then
                            Name := '';
                        CurrentEmpNoOnAfterValidate();
                    end;
                }
                field(Name1; Name)
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ToolTip = 'Specify the name of the processed employee';
                    ApplicationArea = all;
                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ToolTip = 'specifies the processed salary yearto calculate';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ToolTip = 'specifies processed salary month to calcualte';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102152000)
            {
                Editable = false;
                FreezeColumn = "Add/Deduct";
                field("Add/Deduct Code"; "Add/Deduct Code")
                {
                    ToolTip = 'specifies the add and decuction code for the processed salary';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Specified teh year of teh processed salary';
                    ApplicationArea = all;
                }
                field("Pay Slip Month"; "Pay Slip Month")
                {
                    Caption = 'Month';
                    ToolTip = 'Specified teh payslip month of the processed salary';
                    ApplicationArea = all;
                }
                field(Days; Days)
                {
                    ToolTip = 'Specifies thenumber of  days of the processed salary';
                    ApplicationArea = all;
                }
                field(Attendance; Attendance)
                {
                    ToolTip = 'specifies the attendance of the processed salary';
                    ApplicationArea = all;
                }
                field("Add/Deduct"; "Add/Deduct")
                {
                    ToolTip = 'Specifies the add and deduction for the porcessed salary';
                    ApplicationArea = all;
                }
                field("Computation Type"; "Computation Type")
                {
                    ToolTip = 'Specifies the computation type for the processed salary';
                    ApplicationArea = all;
                }
                field("Earned Amount"; "Earned Amount")
                {
                    ToolTip = 'Specifies the processed salary earned amount';
                    ApplicationArea = all;
                }
            }
            fixed(Control1102152001)
            {
                group("Gross Salary")
                {
                    Caption = 'Gross Salary';
                    field(GrossSalary1; GrossSalary)
                    {
                        Caption = 'Gross Salary';
                        Editable = false;
                        ToolTip = 'Specifies the gross salary for the processed period';
                        ApplicationArea = all;
                    }
                }
                group("Net Salary")
                {
                    Caption = 'Net Salary';
                    field(NetSalary1; NetSalary)
                    {
                        Caption = 'Net Salary';
                        Editable = false;
                        ToolTip = 'specifies the net salary for the processed salary';
                        ApplicationArea = all;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Pay Slip")
            {
                Caption = '&Pay Slip';
                Image = UserCertificate;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specify the Pay slip of the Employee';
                trigger OnAction();
                begin
                    Monthattendance.RESET();
                    Monthattendance.SETRANGE("Employee Code", "Employee Code");
                    Monthattendance.SETRANGE("Pay Slip Month", "Pay Slip Month");
                    Monthattendance.SETRANGE(Year, Year);
                    REPORT.RUNMODAL(33001215, true, false, Monthattendance);
                end;
            }
        }
    }

    trigger OnOpenPage();
    var
        PayrollUsers: Record "Payroll Location Users B2B";
    begin
        SETCURRENTKEY("Add/Deduct", "Add/Deduct Code");
        if HRSetup.FINDFIRST() then begin
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        end;
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());

        SelectEmployee();
        SelectYear();
        SelectMonth();
        GetSalary();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        Monthattendance: Record "Monthly Attendance B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        GrossSalary: Decimal;
        NetSalary: Decimal;
        CurrentEmpNo: Code[20];
        Name: Text[50];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text19043354Lbl: Label 'EDLI CHARGES';
        Text19043355Lbl: Label 'PF CHARGES';

    procedure SelectYear();
    begin
        SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        SETRANGE("Pay Slip Month", CurrentMonth);
        CurrPage.UPDATE(false);
    end;

    procedure SelectEmployee();
    begin
        SETRANGE("Employee Code", CurrentEmpNo);
        SETFILTER("Add/Deduct Code", '<>%1 & <>%2', Text19043354Lbl, Text19043355Lbl);
        SETFILTER(Check, 'No');
        CurrPage.UPDATE(false);
    end;

    procedure GetSalary();
    begin
        GrossSalary := 0;
        NetSalary := 0;
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", CurrentEmpNo);
        ProcessedSalary.SETRANGE("Pay Slip Month", CurrentMonth);
        ProcessedSalary.SETRANGE(Year, CurrentYear);
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
        if ProcessedSalary.FINDFIRST() then
            repeat
                GrossSalary := GrossSalary + ProcessedSalary."Earned Amount";
            until ProcessedSalary.NEXT() = 0;
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", CurrentEmpNo);
        ProcessedSalary.SETRANGE("Pay Slip Month", CurrentMonth);
        ProcessedSalary.SETRANGE(Year, CurrentYear);
        if ProcessedSalary.FINDFIRST() then
            repeat
                if ProcessedSalary."Add/Deduct" = ProcessedSalary."Add/Deduct"::Addition then
                    NetSalary := NetSalary + ProcessedSalary."Earned Amount"
                else
                    if ProcessedSalary."Add/Deduct" = ProcessedSalary."Add/Deduct"::Deduction then
                        NetSalary := NetSalary - ProcessedSalary."Earned Amount";
            until ProcessedSalary.NEXT() = 0;
    end;

    local procedure CurrentEmpNoOnAfterValidate();
    begin
        SelectEmployee();
        GetSalary();
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        SelectYear();
        GetSalary();
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        SelectMonth();
        GetSalary();
    end;
}

