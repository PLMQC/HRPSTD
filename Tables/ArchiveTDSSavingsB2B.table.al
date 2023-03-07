table 33001352 "Archive TDS Savings B2B"
{
    // version B2BHR1.00.00

    Caption = 'Archive TDS Savings';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Emp ID"; Code[20])
        {
            Caption = 'Emp ID';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Exemption Group Id"; Code[20])
        {
            Caption = 'Exemption Group Id';
            TableRelation = "Exep/Ded Groups B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TDSDeductions.RESET();
                TDSDeductions.SETRANGE("Emp ID", "Emp ID");
                TDSDeductions.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                if TDSDeductions.FINDFIRST() then
                    TDSDeductions.TESTFIELD("Total Tax Liability", 0);
            end;
        }
        field(3; "Financial Year Start Date"; Date)
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
                    "Financial Year End Date" := PayRollYears."Year End Date";
            end;
        }
        field(4; "Financial Year End Date"; Date)
        {
            Caption = 'Financial Year End Date';
            Editable = false;
            TableRelation = "Payroll Year B2B"."Year End Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                  Closed = CONST(false));
            DataClassification = CustomerContent;
        }
        field(9; "Actual Paid"; Decimal)
        {
            Caption = 'Actual Paid';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CLEAR(ALLBasicDA);
                CLEAR(Limit3);
                CLEAR(Limit2);
                CLEAR(Limit1);
                CLEAR("Limit1%");
                CLEAR("Limit2%");

                TDSDeductions.RESET();
                TDSDeductions.SETRANGE("Emp ID", "Emp ID");
                TDSDeductions.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                if TDSDeductions.FINDFIRST() then
                    TDSDeductions.TESTFIELD("Total Tax Liability", 0);

                ExepDedGroups.GET("Exemption Group Id");
                if ExepDedGroups."Section ID" = Text330001Lbl then begin
                    EMPTDSGross.RESET();
                    EMPTDSGross.SETRANGE("Emp ID", "Emp ID");
                    EMPTDSGross.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                    EMPTDSGross.SETFILTER("Pay Element Code", BasicTextLbl + '|' + DaTextLbl);
                    if EMPTDSGross.FINDFIRST() then
                        repeat
                            ALLBasicDA += EMPTDSGross.Amount;
                        until EMPTDSGross.NEXT() = 0;

                    EMPTDSGross.RESET();
                    EMPTDSGross.SETRANGE("Emp ID", "Emp ID");
                    EMPTDSGross.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                    EMPTDSGross.SETFILTER("Pay Element Code", HRATextLbl);
                    if EMPTDSGross.FINDFIRST() then
                        repeat
                            ALLHRA += EMPTDSGross.Amount;
                        until EMPTDSGross.NEXT() = 0;
                    HRASetup.RESET();
                    HRASetup.SETRANGE("Location Type", HRASetup."Location Type"::Metro);
                    if HRASetup.FINDFIRST() then begin
                        "Limit1%" := (HRASetup."Limit 1 %" / 100);
                        "Limit2%" := (HRASetup."Limit 2 %" / 100);
                    end;

                    Limit1 := ALLBasicDA * "Limit1%";
                    Limit2 := "Actual Paid" - (ALLBasicDA * "Limit2%");
                    Limit3 := ALLHRA;
                    if Limit1 < Limit2 then begin
                        if Limit1 < Limit3 then
                            Limit := Limit1
                        else
                            Limit := Limit3;
                    end else
                        if Limit2 < Limit3 then
                            Limit := Limit2
                        else
                            Limit := Limit3;

                end else
                    if ExepDedLimits.GET("Exemption Group Id", "Financial Year Start Date") then
                        if ExepDedLimits."Exemption Limit" <> 0 then
                            if "Actual Paid" > ExepDedLimits."Exemption Limit" then
                                Limit := ExepDedLimits."Exemption Limit"
                            else
                                Limit := "Actual Paid"
                        else
                            Limit := "Actual Paid"

                    else
                        Limit := "Actual Paid";

            end;
        }
        field(11; Limit; Decimal)
        {
            Caption = 'Limit';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(12; "Archived Date"; Date)
        {
            Caption = 'Archived Date';
            DataClassification = CustomerContent;
        }
        field(13; "Archived Version"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Archived Version';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Archived Date", "Emp ID", "Financial Year Start Date", "Exemption Group Id", "Archived Version")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PayRollYears: Record "Payroll Year B2B";
        HRASetup: Record "HRA Setup B2B";
        ExepDedLimits: Record "Exep/Ded Limits B2B";
        ExepDedGroups: Record "Exep/Ded Groups B2B";
        EMPTDSGross: Record "EMP TDS Gross Salary B2B";
        TDSDeductions: Record "TDS Deductions B2B";
        Limit1: Decimal;
        Limit2: Decimal;
        Limit3: Decimal;
        ALLBasicDA: Decimal;
        ALLHRA: Decimal;
        "Limit1%": Decimal;
        "Limit2%": Decimal;
        FinanceYearTextLbl: Label 'FINANCIAL YEAR';
        Text330001Lbl: Label '10(13A)';
        HRATextLbl: Label 'HRA';
        BasicTextLbl: Label 'Basic';
        DaTextLbl: Label 'DA';
}

