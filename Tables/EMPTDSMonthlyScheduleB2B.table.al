table 33001344 "EMP TDS Monthly Schedule B2B"
{
    // version B2BHR1.00.00

    Caption = 'EMP TDS Monthly Schedule';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Emp ID"; Code[20])
        {
            Caption = 'Emp ID';
            DataClassification = CustomerContent;
        }
        field(2; "Payslip Month"; Integer)
        {
            Caption = 'Payslip Month';
            DataClassification = CustomerContent;
        }
        field(3; "Payslip Year"; Integer)
        {
            Caption = 'Payslip Year';
            DataClassification = CustomerContent;
        }
        field(4; "Financial Year Start Date"; Date)
        {
            Caption = 'Financial Year Start Date';
            TableRelation = "Payroll Year B2B"."Year Start Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                    Closed = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PayRollYears.RESET();
                PayRollYears.SETRANGE("Year Type", FinanceYearTextLbl);
                PayRollYears.SETRANGE("Year Start Date", "Financial Year Start Date");
                if PayRollYears.FINDFIRST() then
                    "Financial Year Start Date" := PayRollYears."Year Start Date";
            end;
        }
        field(5; "Financial Year End Date"; Date)
        {
            Caption = 'Financial Year End Date';
            Editable = false;
            TableRelation = "Payroll Year B2B"."Year End Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                  Closed = CONST(false));
            DataClassification = CustomerContent;
        }
        field(6; "TDS Amount"; Decimal)
        {
            Caption = 'TDS Amount';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                ValidateTDSRemainingAmount();
            end;
        }
        field(7; "TDS Amount Deducted"; Decimal)
        {
            Caption = 'TDS Amount Deducted';
            DataClassification = CustomerContent;
        }
        field(8; Processes; Boolean)
        {
            Caption = 'Processes';
            DataClassification = CustomerContent;
        }
        field(9; "TDS Remaining Amount"; Decimal)
        {
            Caption = 'TDS Remaining Amount';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(10; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Emp ID", "Payslip Month", "Payslip Year", "Financial Year Start Date")
        {
        }
        key(Key2; "Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month")
        {
        }
        key(Key3; "TDS Amount", "Emp ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify();
    begin
        if Posted then
            ERROR(Text001Lbl);
    end;

    var
        PayRollYears: Record "Payroll Year B2B";
        Text001Lbl: Label 'You cannot modify the record';
        Text002Lbl: Label 'TDS Amount already deducted';
        Text003Lbl: Label 'TDS Amount canot be changed for the month %1 in the year %2', Comment = '%1 = PaySlip Month ; %2 = PaySlip Year';
        Text004Lbl: Label 'TDS already posted for the month %1 in the year %2', Comment = '%1 = PaySlip Month ; %2 = PaySlip Year';
        Text005Lbl: Label 'TDS Amount cannot be changed for the month %1 in the year %2', Comment = '%1 = PaySlip Month ; %2 = PaySlip Year';
        FinanceYearTextLbl: Label 'FINANCIAL YEAR';

    procedure ValidateTDSRemainingAmount();
    var
        EMPTDSMonthlySchedule: Record "EMP TDS Monthly Schedule B2B";
        DiffAmount: Decimal;
        TotalAmount: Decimal;
        PreviousAmount: Decimal;
        i: Integer;
        TDSMonth: Integer;
    begin
        if Posted then
            ERROR(Text001Lbl);
        if "TDS Amount Deducted" <> 0 then
            ERROR(Text002Lbl);

        EMPTDSMonthlySchedule.RESET();
        EMPTDSMonthlySchedule.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMonthlySchedule.SETRANGE("Emp ID", "Emp ID");
        EMPTDSMonthlySchedule.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
        if EMPTDSMonthlySchedule.FINDLAST() then
            if DMY2DATE(1, EMPTDSMonthlySchedule."Payslip Month", EMPTDSMonthlySchedule."Payslip Year") =
               DMY2DATE(1, "Payslip Month", "Payslip Year") then
                ERROR(Text003Lbl, EMPTDSMonthlySchedule."Payslip Month"
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
                ERROR(Text004Lbl, EMPTDSMonthlySchedule."Payslip Month"
                       , EMPTDSMonthlySchedule."Payslip Year");
            if DMY2DATE(1, EMPTDSMonthlySchedule."Payslip Month", EMPTDSMonthlySchedule."Payslip Year") =
               DMY2DATE(1, "Payslip Month", "Payslip Year") then
                ERROR(Text005Lbl, EMPTDSMonthlySchedule."Payslip Month"
                       , EMPTDSMonthlySchedule."Payslip Year");
        end;

        CLEAR(PreviousAmount);
        CLEAR(TotalAmount);
        CLEAR(TDSMonth);
        CLEAR(i);

        PreviousAmount := xRec."TDS Amount";
        TDSMonth := "Payslip Month";
        DiffAmount := xRec."TDS Amount" - "TDS Amount";

        EMPTDSMonthlySchedule.RESET();
        EMPTDSMonthlySchedule.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMonthlySchedule.SETRANGE("Emp ID", "Emp ID");
        EMPTDSMonthlySchedule.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
        EMPTDSMonthlySchedule.SETRANGE(Processes, false);
        if EMPTDSMonthlySchedule.FINDFIRST() then
            repeat
                if EMPTDSMonthlySchedule."Payslip Month" <> TDSMonth then begin
                    TotalAmount += EMPTDSMonthlySchedule."TDS Amount";
                    i += 1;
                end;
            until EMPTDSMonthlySchedule.NEXT() = 0;


        TotalAmount += DiffAmount;

        EMPTDSMonthlySchedule.RESET();
        EMPTDSMonthlySchedule.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMonthlySchedule.SETRANGE("Emp ID", "Emp ID");
        EMPTDSMonthlySchedule.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
        EMPTDSMonthlySchedule.SETRANGE(Processes, false);
        if EMPTDSMonthlySchedule.FINDFIRST() then
            repeat
                if EMPTDSMonthlySchedule."Payslip Month" <> TDSMonth then begin
                    EMPTDSMonthlySchedule."TDS Amount" := ROUND((TotalAmount / i), 1, '=');
                    EMPTDSMonthlySchedule.MODIFY();
                end;
            until EMPTDSMonthlySchedule.NEXT() = 0;

    end;
}

