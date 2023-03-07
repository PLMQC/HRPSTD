page 33001554 "Posted Other PayElements B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Other PayElements';
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Posted Other PayElements B2B";
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
                    ApplicationArea = all;
                    ToolTip = 'Specify the pay element code in group';

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
                    ApplicationArea = all;
                    ToolTip = 'Specify the description';

                    trigger OnValidate();
                    begin
                        CurrentDescriptionOnAfterValid();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    ToolTip = 'Specify the month details ';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Specify the year details';

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
            }
            repeater(Control1)
            {
                Editable = false;
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee No';
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }                
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the amount details';
                }
            }
        }
    }

    actions
    {
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
        PayDeduct: Record "Pay Deductions B2B";
        CurrentPayElement: Code[30];
        CurrentDescription: Text[250];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        [InDataSet]
        SalesCodeFilterCtrlEnable: Boolean;

    procedure GetRecFilters();
    begin
        if GETFILTERS() <> '' then
            CurrentPayElement := copystr((GETFILTER("Pay Element Code")), 1, 30);
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

