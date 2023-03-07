page 33001242 "Other PayElements B2B"
{
    // version B2BHR1.00.00

    Caption = 'Other PayElements';
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Other PayElements B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(SalesCodeFilterCtrl; CurrentPayElement)
                {
                    Caption = 'Pay Element Code';
                    Enabled = SalesCodeFilterCtrlEnable;
                    ToolTip = 'Specify the pay element code from drill down';
                    ApplicationArea = all;
                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, PayDeduct) = ACTION::LookupOK then begin
                            CurrentPayElement := PayDeduct."Pay Element code";
                            CurrentDescription := PayDeduct.Description;
                            Priority := PayDeduct.Priority;
                        end;
                        CurrPage.SAVERECORD();
                        SetRecFilters();
                    end;

                    trigger OnValidate();
                    begin
                        CurrentPayElementOnAfterValida();
                    end;
                }
                field(CurrentDescription1; CurrentDescription)
                {
                    Caption = 'Description';
                    Editable = false;
                    ToolTip = 'Specify the discription of the pay element';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        CurrentDescriptionOnAfterValid();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ToolTip = 'specify the month of the paylement';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ToolTip = 'specify the year of the pay element';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
            }
            repeater(Control1)
            {
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'specify the employee number from drill down';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specify the name of the employee';
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ToolTip = 'Specify the amount of the pay element';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get &Employees")
                {
                    Caption = 'Get &Employees';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Get Employees';
                    trigger OnAction();
                    begin
                        Employee.RESET();
                        Employee.SETRANGE(Blocked, false);
                        if Employee.FINDFIRST() then
                            repeat
                                OtherPayElements.INIT();
                                OtherPayElements."Employee No." := Employee."No.";
                                OtherPayElements."Employee Name" := CopyStr(Employee."First Name" + Employee."Middle Name", 1, 50);
                                OtherPayElements.Month := CurrentMonth;
                                OtherPayElements.Year := CurrentYear;
                                OtherPayElements."Pay Element Code" := CurrentPayElement;
                                if PayDeduct.GET(OtherPayElements."Pay Element Code") then begin
                                    OtherPayElements.Description := PayDeduct.Description;
                                    OtherPayElements."Add/Deduct" := PayDeduct."Add/Deduct";
                                    OtherPayElements.Type := PayDeduct.Type;
                                end;
                                OtherPayElements.INSERT()
                            until Employee.NEXT() = 0;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
            }
            action("P&ost")
            {
                Caption = 'P&ost';
                Image = Post;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ApplicationArea = all;
                ToolTip = 'Specifies The Post';
                trigger OnAction();
                begin
                    if CONFIRM(Text001Lbl, true) then begin
                        OtherAddDed.RESET();
                        OtherAddDed.SETRANGE(Month, CurrentMonth);
                        OtherAddDed.SETRANGE(Year, CurrentYear);
                        OtherAddDed.SETRANGE("Pay Element Code", CurrentPayElement);
                        if OtherAddDed.FINDFIRST() then begin
                            repeat
                                MonthlyAtt.RESET();
                                MonthlyAtt.SETRANGE("Pay Slip Month", OtherAddDed.Month);
                                MonthlyAtt.SETRANGE(Year, OtherAddDed.Year);
                                MonthlyAtt.SETRANGE(MonthlyAtt."Employee Code", OtherAddDed."Employee No.");
                                MonthlyAtt.SETRANGE(Posted, true);
                                if MonthlyAtt.FINDFIRST() then
                                    ERROR(Text002Lbl, CurrentMonth, CurrentYear)
                                else
                                    UpdateProcSalary(OtherAddDed);
                            until OtherAddDed.NEXT() = 0;
                            MESSAGE(Text000Lbl);
                        end;
                    end;

                    OtherPayElements.RESET();
                    OtherPayElements.SETRANGE("Pay Element Code", CurrentPayElement);
                    OtherPayElements.SETRANGE(Month, CurrentMonth);
                    OtherPayElements.SETRANGE(Year, CurrentYear);
                    OtherPayElements.DELETEALL();
                    CurrentPayElement := '';
                    CurrentDescription := '';
                end;
            }
        }
    }

    trigger OnInit();
    begin
        SalesCodeFilterCtrlEnable := true;
    end;

    trigger OnOpenPage();
    begin
        if HRSetup.FINDFIRST() then begin
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        end;
        GetRecFilters();
        SetRecFilters();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        OtherPayElements: Record "Other PayElements B2B";
        PayDeduct: Record "Pay Deductions B2B";
        MonthlyAtt: Record "Monthly Attendance B2B";
        OtherAddDed: Record "Other PayElements B2B";
        CurrentPayElement: Code[30];
        CurrentDescription: Text[250];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text000Lbl: Label 'Records are posted.';
        Text001Lbl: Label 'Do you want to post?';
        [InDataSet]
        SalesCodeFilterCtrlEnable: Boolean;
        Text002Lbl: Label 'Salary posted for this  Month %1 and Year %2', Comment = '%1 =  month ; %2 = year';

    procedure GetRecFilters();
    begin
        if GETFILTERS() <> '' then
            evaluate(CurrentPayElement, GETFILTER("Pay Element Code"));
    end;

    procedure SetRecFilters();
    begin
        SalesCodeFilterCtrlEnable := true;
        SETRANGE("Pay Element Code", CurrentPayElement);
        SETRANGE(Month, CurrentMonth);
        SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(false);
    end;

    local procedure CurrentPayElementOnAfterValida();
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure CurrentDescriptionOnAfterValid();
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;
}

