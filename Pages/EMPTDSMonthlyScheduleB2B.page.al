page 33001436 "EMP TDS Monthly Schedule B2B"
{
    // version B2BHR1.00.00

    Caption = 'EMP TDS Monthly Schedule';
    Editable = true;
    PageType = Worksheet;
    SourceTable = "EMP TDS Monthly Schedule B2B";
    SourceTableView = SORTING("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month")
                      ORDER(Ascending);
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Emp ID"; "Emp ID")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee id details';
                }
                field("Payslip Month"; "Payslip Month")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the payslip month details';
                }
                field("Payslip Year"; "Payslip Year")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Payslip year details';
                }
                field("Financial Year Start Date"; "Financial Year Start Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Financial year start date';
                }
                field("Financial Year End Date"; "Financial Year End Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Financial year end date';
                }
                field("TDS Amount"; "TDS Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the TDS amount details';
                }
                field("TDS Amount Deducted"; "TDS Amount Deducted")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the TDS amount deducted details';
                }
            }
        }
    }

    actions
    {
    }

    var
        Text001Lbl: Label 'TDS Amount already deducted';
        Text002Lbl: Label 'TDS Amount cannot be changed for the month %1 in the year %2', Comment = '%1 =  PaySlip Month; %2 = PaySlip Year';

    procedure ValidateTDSAmount();
    var
        EMPTDSMonthlySchedule: Record "EMP TDS Monthly Schedule B2B";
        DiffAmount: Decimal;
        TotalAmount: Decimal;
        PreviousAmount: Decimal;
        i: Integer;
        TDSMonth: Integer;
    begin
        if "TDS Amount Deducted" <> 0 then
            ERROR(Text001Lbl);

        EMPTDSMonthlySchedule.RESET();
        EMPTDSMonthlySchedule.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMonthlySchedule.SETRANGE("Emp ID", "Emp ID");
        EMPTDSMonthlySchedule.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
        if EMPTDSMonthlySchedule.FINDLAST() then
            if DMY2DATE(1, EMPTDSMonthlySchedule."Payslip Month", EMPTDSMonthlySchedule."Payslip Year") =
               DMY2DATE(1, "Payslip Month", "Payslip Year") then
                ERROR(Text002Lbl, EMPTDSMonthlySchedule."Payslip Month"
                       , EMPTDSMonthlySchedule."Payslip Year");



        CLEAR(DiffAmount);

        EMPTDSMonthlySchedule.RESET();
        EMPTDSMonthlySchedule.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMonthlySchedule.SETRANGE("Emp ID", "Emp ID");
        EMPTDSMonthlySchedule.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
        EMPTDSMonthlySchedule.SETFILTER("TDS Amount Deducted", '<>%1', 0);
        if EMPTDSMonthlySchedule.FINDLAST() then begin
            if DMY2DATE(1, EMPTDSMonthlySchedule."Payslip Month", EMPTDSMonthlySchedule."Payslip Year") >
               DMY2DATE(1, "Payslip Month", "Payslip Year") then
                ERROR(Text002Lbl, EMPTDSMonthlySchedule."Payslip Month"
                       , EMPTDSMonthlySchedule."Payslip Year");

            if DMY2DATE(1, EMPTDSMonthlySchedule."Payslip Month", EMPTDSMonthlySchedule."Payslip Year") =
               DMY2DATE(1, "Payslip Month", "Payslip Year") then
                ERROR(Text002Lbl, EMPTDSMonthlySchedule."Payslip Month"
                       , EMPTDSMonthlySchedule."Payslip Year");


        end;

        CLEAR(PreviousAmount);
        CLEAR(TotalAmount);
        CLEAR(TDSMonth);
        CLEAR(i);

        PreviousAmount := xRec."TDS Amount";
        TDSMonth := "Payslip Month";
        MESSAGE('%1', TDSMonth);

        DiffAmount := xRec."TDS Amount" - "TDS Amount";

        EMPTDSMonthlySchedule.RESET();
        EMPTDSMonthlySchedule.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMonthlySchedule.SETRANGE("Emp ID", "Emp ID");
        EMPTDSMonthlySchedule.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
        EMPTDSMonthlySchedule.SETFILTER("TDS Amount Deducted", '%1', 0);
        if EMPTDSMonthlySchedule.FINDFIRST() then
            repeat
                if EMPTDSMonthlySchedule."Payslip Month" <> TDSMonth then begin
                    TotalAmount += EMPTDSMonthlySchedule."TDS Amount";
                    i += 1;
                end;
            until EMPTDSMonthlySchedule.NEXT() = 0;

        MESSAGE('%1', i);

        TotalAmount += DiffAmount;

        MESSAGE('%1', TotalAmount);

        EMPTDSMonthlySchedule.RESET();
        EMPTDSMonthlySchedule.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMonthlySchedule.SETRANGE("Emp ID", "Emp ID");
        EMPTDSMonthlySchedule.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
        EMPTDSMonthlySchedule.SETFILTER("TDS Amount Deducted", '%1', 0);
        if EMPTDSMonthlySchedule.FINDFIRST() then
            repeat
                if EMPTDSMonthlySchedule."Payslip Month" <> TDSMonth then begin
                    EMPTDSMonthlySchedule."TDS Amount" := (TotalAmount / i);
                    EMPTDSMonthlySchedule.MODIFY();
                end;
            until EMPTDSMonthlySchedule.NEXT() = 0;

    end;

    local procedure TDSAmountOnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    local procedure TDSAmountOnDeactivate();
    begin
        CurrPage.EDITABLE := false;
    end;

    local procedure TDSAmountOnActivate();
    begin
        CurrPage.EDITABLE := true;
    end;
}

