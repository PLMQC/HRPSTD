table 33001236 "Emp TDS Schedule B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp TDS Schedule';
    DrillDownPageID = "TDS Schedule B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Year Starting Date"; Date)
        {
            Caption = 'Year Starting Date';
            DataClassification = CustomerContent;
        }
        field(3; "Year Ending Date"; Date)
        {
            Caption = 'Year Ending Date';
            DataClassification = CustomerContent;
        }
        field(4; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(5; "TDS Amount"; Decimal)
        {
            Caption = 'TDS Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Processes = true then
                    ERROR(Text000Lbl);
                if Month = 0 then
                    ERROR(Text002Lbl);
            end;
        }
        field(6; "TDS Amount Deducted"; Decimal)
        {
            CalcFormula = Lookup ("Processed Salary B2B"."Earned Amount" WHERE("Employee Code" = FIELD("Employee No."),
                                                                           "Add/Deduct Code" = CONST('TDS'),
                                                                           "Pay Slip Month" = FIELD(Month),
                                                                           Year = FIELD(Year)));
            Caption = 'TDS Amount Deducted';
            FieldClass = FlowField;
        }
        field(7; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(8; Processes; Boolean)
        {
            Caption = 'Processes';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Year, Month, "Year Starting Date", "Year Ending Date")
        {
            SumIndexFields = "TDS Amount";
        }
    }

    fieldgroups
    {
    }

    var
        Text000Lbl: Label '"TDS Amount is already processed , so you can''t modify "';
        Text001Lbl: Label 'Total TDS Amount must be equal to %1 for the employee %2', Comment = '%1 = Liability After Saving ; %2 = Employee No';
        Text002Lbl: Label '"You are not allowed to define the TDS Amount "';

    procedure TDSTotalCheck();
    var
        TDSSchedule: Record "Emp TDS Schedule B2B";
        TDSDeduction: Record "Emp TDS Deduction B2B";
        TotalAmount: Decimal;
    begin
        if TDSDeduction.FINDFIRST() then
            repeat
                TDSSchedule.SETRANGE("Employee No.", TDSDeduction."Employee No.");
                TDSSchedule.SETRANGE("Year Starting Date", TDSDeduction."Year Starting Date");
                TDSSchedule.SETRANGE("Year Ending Date", TDSDeduction."Year Ending Date");
                if TDSSchedule.FINDFIRST() then
                    repeat
                        TotalAmount := TotalAmount + TDSSchedule."TDS Amount";
                    until TDSSchedule.NEXT() = 0;
                if TotalAmount <> TDSDeduction."Tax Liability after savings" then
                    ERROR(Text001Lbl, TDSDeduction."Tax Liability after savings", TDSDeduction."Employee No.");
            until TDSDeduction.NEXT() = 0;
    end;
}

