page 33001361 "Monthly TDS Schedule Summ B2B"
{
    // version B2BHR1.00.00

    Caption = 'Monthly TDS Schedule Summary';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Emp TDS Schedule B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentMonth1; CurrentMonth)
                {
                    BlankZero = true;
                    Caption = 'Month';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The month';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field(CurrentYear1; CurrentYear)
                {
                    BlankZero = true;
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The year';

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(EmployeeNo1; EmployeeNo)
                {
                    Caption = 'Employee No.';
                    TableRelation = "Employee B2B";
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee no';

                    trigger OnValidate();
                    begin
                        EmployeeNoOnAfterValidate();
                    end;
                }
                field(PayrollYearType1; PayrollYearType)
                {
                    Caption = 'Financial Year';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The finanacial year';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PayrollYear.RESET();
                        PayrollYear.SETRANGE("Year Type", Text001Lbl);
                        if PAGE.RUNMODAL(0, PayrollYear) = ACTION::LookupOK then begin
                            PayrollYearType := PayrollYear."Year Type";
                            PayrollYearStDate := PayrollYear."Year Start Date";
                            PayrollYearEndDate := PayrollYear."Year End Date";
                        end;
                        UpdateValues();
                    end;

                    trigger OnValidate();
                    begin
                        PayrollYearTypeOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102154007)
            {
                field("Employee No."; "Employee No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee no.';
                }
                field("Year Starting Date"; "Year Starting Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The year starting date';
                }
                field("Year Ending Date"; "Year Ending Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The year ending date';
                }
                field(Month; Month)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The month';
                }
                field("TDS Amount"; "TDS Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The TDS amount';
                }
                field("TDS Amount Deducted"; "TDS Amount Deducted")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The tds amount deducted';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        HRSetup.GET();
        CurrentMonth := HRSetup."Salary Processing month";
        CurrentYear := HRSetup."Salary Processing Year";
        UpdateValues();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        PayrollYear: Record "Payroll Year B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        EmployeeNo: Code[20];
        PayrollYearStDate: Date;
        PayrollYearEndDate: Date;
        PayrollYearType: Code[50];
        Text001Lbl: Label 'FINANCIAL YEAR';

    procedure UpdateValues();
    begin
        RESET();
        if PayrollYearType = '' then begin
            if (CurrentMonth = 0) and (CurrentYear = 0) then begin
                CurrentMonth := HRSetup."Salary Processing month";
                CurrentYear := HRSetup."Salary Processing Year";
            end;
        end else begin
            CurrentMonth := 0;
            CurrentYear := 0;
            SETRANGE("Year Starting Date", PayrollYearStDate);
            SETRANGE("Year Ending Date", PayrollYearEndDate);
        end;
        if CurrentYear <> 0 then
            SETRANGE(Year, CurrentYear);
        if CurrentMonth <> 0 then
            SETRANGE(Month, CurrentMonth);
        SETFILTER("Employee No.", EmployeeNo);
        CurrPage.UPDATE(false);
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        PayrollYearType := '';
        UpdateValues();
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        PayrollYearType := '';
        UpdateValues();
    end;

    local procedure EmployeeNoOnAfterValidate();
    begin
        UpdateValues();
    end;

    local procedure PayrollYearTypeOnAfterValidate();
    begin
        UpdateValues();
    end;
}

