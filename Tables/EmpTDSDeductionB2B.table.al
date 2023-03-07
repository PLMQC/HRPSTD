table 33001235 "Emp TDS Deduction B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp TDS Deduction';
    DrillDownPageID = "TDS Deduction List B2B";
    LookupPageID = "TDS Deduction List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if PayYear.FINDSET() then begin
                    PayYear.SETRANGE("Year Type", FINANCIALYEARTxt);
                    PayYear.SETRANGE(Closed, false);
                    if PayYear.FINDSET() then begin
                        "Year Starting Date" := PayYear."Year Start Date";
                        "Year Ending Date" := PayYear."Year End Date";
                        Days := "Year Ending Date" - "Year Starting Date";
                        "Remaining Months" := Days div 30;
                    end;
                end;
            end;
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

            trigger OnValidate();
            begin
                Days := "Year Ending Date" - "Year Starting Date";
                "Remaining Months" := Days div 30;
            end;
        }
        field(4; "Gross Salary"; Decimal)
        {
            Caption = 'Gross Salary';
            DataClassification = CustomerContent;
        }
        field(5; "Professional Tax"; Decimal)
        {
            Caption = 'Professional Tax';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(6; "Gross Total Income"; Decimal)
        {
            Caption = 'Gross Total Income';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(7; "Tax Liability"; Decimal)
        {
            Caption = 'Tax Liability';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Tax Liability after savings" <> 0 then
                    if "Tax Liability after savings" > "Tax Liability" then
                        ERROR(Text000Lbl);

            end;
        }
        field(8; "Planned Savings"; Decimal)
        {
            Caption = 'Planned Savings';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(9; "Tax Liability after savings"; Decimal)
        {
            Caption = 'Tax Liability after savings';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Tax Liability" <> 0 then
                    if "Tax Liability after savings" > "Tax Liability" then
                        ERROR(Text000Lbl);


                if ("Tax Liability after savings" <> 0) and ("Remaining Months" <> 0) then
                    "Tax Per Month" := ("Tax Liability after savings" - "Tax Already Deducted") / "Remaining Months";
            end;
        }
        field(10; "Tax Already Deducted"; Decimal)
        {
            Caption = 'Tax Already Deducted';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Tax Liability after savings" <> 0) and ("Remaining Months" <> 0) then
                    "Tax Per Month" := ("Tax Liability after savings" - "Tax Already Deducted") / "Remaining Months";
            end;
        }
        field(11; "Remaining Months"; Decimal)
        {
            Caption = 'Remaining Months';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Tax Liability after savings" <> 0) and ("Remaining Months" <> 0) then
                    "Tax Per Month" := ("Tax Liability after savings" - "Tax Already Deducted") / "Remaining Months";
            end;
        }
        field(12; "Tax Per Month"; Decimal)
        {
            Caption = 'Tax Per Month';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(13; "Reported Savings"; Decimal)
        {
            Caption = 'Reported Savings';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(14; "Planned Deduction"; Decimal)
        {
            CalcFormula = Sum ("Emp TDS Schedule B2B"."TDS Amount" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Year Starting Date" = FIELD("Year Starting Date")));
            Caption = 'Planned Deduction';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Year Starting Date", "Year Ending Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TDSSchedule.SETRANGE("Employee No.", "Employee No.");
        if TDSSchedule.FINDSET() then
            TDSSchedule.DELETEALL(true);

        ExpSalaryComp.SETRANGE("Employee Code", "Employee No.");
        if ExpSalaryComp.FINDSET() then
            ExpSalaryComp.DELETEALL();
    end;

    var
        TDSSchedule: Record "Emp TDS Schedule B2B";
        ExpSalaryComp: Record "Expected Sal Computation B2B";
        PayYear: Record "Payroll Year B2B";
        Days: Decimal;
        Text000Lbl: Label 'Tax liability after savings should be less than Tax liability';
        FINANCIALYEARTxt: Label 'FINANCIAL YEAR';
}

