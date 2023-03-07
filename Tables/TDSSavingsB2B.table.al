table 33001338 "TDS Savings B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Savings_B2B';
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
                CLEAR(ProcessesAmt);
                if "Exemption Group Id" = EnpsTextLbl then
                    exit;
                ExepDedGr.GET("Exemption Group Id");
                ProcessedSal.RESET();
                ProcessedSal.SETRANGE("Document Type", ProcessedSal."Document Type"::Payroll);
                ProcessedSal.SETRANGE("Employee Code", "Emp ID");
                ProcessedSal.SETRANGE("Add/Deduct Code", ExepDedGr."Pay Element Code");
                if ProcessedSal.FINDFIRST() then
                    repeat
                        ProcessesAmt += ProcessedSal."Earned Amount";
                    until ProcessedSal.NEXT() = 0;

                VALIDATE("Actual Paid", ProcessesAmt);
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
                PayRollYears.SETRANGE("Year Type", FinancialYearTextLbl);
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
            var
                EndDate: Date;
                LimitAmt: Decimal;
                CheckDate: Date;
                LastDate: Date;
                NoofDays: Integer;
                Mondays: Integer;
            begin
                CLEAR(ALLBasicDA);
                CLEAR(Limit3);
                CLEAR(Limit2);
                CLEAR(Limit1);
                CLEAR("Limit1%");
                CLEAR("Limit2%");
                CLEAR(ProcessesAmt);

                if "Exemption Group Id" = EnpsTextLbl then begin
                    HRSetup.GET();
                    ExepDedGr.GET("Exemption Group Id");
                    EMPTDSGrossSalary.RESET();
                    EMPTDSGrossSalary.SETRANGE("Emp ID", "Emp ID");
                    EMPTDSGrossSalary.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                    EMPTDSGrossSalary.SETFILTER(Amount, '<>%1', 0);
                    EMPTDSGrossSalary.SETRANGE("Pay Element Code", ExepDedGr."Pay Element Code");
                    if EMPTDSGrossSalary.FINDSET() then begin
                        EMPTDSGrossSalary.CALCSUMS(Amount);
                        ProcessesAmt += EMPTDSGrossSalary.Amount;
                    end;
                    ProcessesAmt := ProcessesAmt * (HRSetup."Employer National Pension %" / 100);
                    if "Actual Paid" > ProcessesAmt then
                        Limit := ProcessesAmt
                    else
                        Limit := "Actual Paid";
                    exit;
                end;
                TDSDeductions.RESET();
                TDSDeductions.SETRANGE("Emp ID", "Emp ID");
                TDSDeductions.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                if TDSDeductions.FINDFIRST() then
                    PayElements.RESET();
                PayElements.SETRANGE("Employee Code", "Emp ID");
                PayElements.SETRANGE(PF, true);
                if PayElements.FINDSET() then
                    repeat
                        Payelement += PayElements."Pay Element Code" + '|';
                    until PayElements.NEXT() = 0;


                LengthCode := STRLEN(Payelement);

                if LengthCode <> 0 then
                    PayelementNew := DELSTR(Payelement, LengthCode, 1);

                ExepDedGroups.GET("Exemption Group Id");
                if ExepDedGroups."Section ID" = Text33000Lbl then begin
                    EMPTDSGross.RESET();
                    EMPTDSGross.SETRANGE("Emp ID", "Emp ID");
                    EMPTDSGross.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                    EMPTDSGross.SETFILTER("Pay Element Code", PayelementNew);
                    if EMPTDSGross.FINDFIRST() then
                        repeat
                            ALLBasicDA += EMPTDSGross.Amount;
                        until EMPTDSGross.NEXT() = 0;

                    EMPTDSGross.RESET();
                    EMPTDSGross.SETRANGE("Emp ID", "Emp ID");
                    EMPTDSGross.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                    EMPTDSGross.SETFILTER("Pay Element Code", HraTextLbl);
                    if EMPTDSGross.FINDFIRST() then
                        repeat
                            ALLHRA += EMPTDSGross.Amount;
                        until EMPTDSGross.NEXT() = 0;
                    HRASetup.RESET();
                    if HRASetup.FINDFIRST() then begin
                        "Limit1%" := (HRASetup."Limit 1 %" / 100);
                        "Limit2%" := (HRASetup."Limit 2 %" / 100);
                    end;

                    Limit1 := ROUND((ALLBasicDA * "Limit1%"), 1.0, '=');
                    Limit2 := ROUND(("Actual Paid" - (ALLBasicDA * "Limit2%")), 1.0, '=');
                    Limit3 := ROUND(ALLHRA, 1.0, '=');
                    if Limit1 < Limit2 then
                        if Limit1 < Limit3 then
                            Limit := Limit1
                        else
                            Limit := Limit3
                    else
                        if Limit2 < Limit3 then
                            Limit := Limit2
                        else
                            Limit := Limit3;

                end else
                    if ExepDedLimits.GET("Exemption Group Id", "Financial Year Start Date") then begin
                        if "Exemption Group Id" <> TransportTextLbl then
                            if ExepDedLimits."Exemption Limit" <> 0 then
                                if "Actual Paid" > ExepDedLimits."Exemption Limit" then
                                    Limit := ExepDedLimits."Exemption Limit"
                                else
                                    Limit := "Actual Paid"
                            else
                                Limit := "Actual Paid";

                    end else
                        Limit := "Actual Paid";


                if Employee.GET("Emp ID") then;
                if Employee."Resignation Date" <> 0D then
                    EndDate := Employee."Resignation Date"
                else
                    EndDate := "Financial Year End Date";

                if "Exemption Group Id" = TransportTextLbl then
                    if ExepDedLimits.GET("Exemption Group Id", "Financial Year Start Date") then begin
                        Employee.RESET();
                        if Employee.GET("Emp ID") then
                            if ((Employee."Employment Date" >= "Financial Year Start Date") and
                                 (Employee."Employment Date" <= "Financial Year End Date")) then begin
                                Days := (EndDate - Employee."Employment Date");
                                if ExepDedLimits."Exemption Limit" <> 0 then begin
                                    DayWiseLimit := ExepDedLimits."Exemption Limit" / 365;
                                    if "Actual Paid" > ExepDedLimits."Exemption Limit" then
                                        Limit := ROUND(DayWiseLimit * Days, 1, '=')
                                    else
                                        Limit := "Actual Paid";
                                end else
                                    Limit := "Actual Paid";

                            end else begin
                                if EndDate <> "Financial Year End Date" then begin
                                    CheckDate := "Financial Year Start Date";
                                    repeat
                                        CheckDate := CALCDATE(MonthTextLbl, CheckDate);
                                        LimitAmt += ROUND(ExepDedLimits."Exemption Limit" / 12, 1, '=');
                                    until CheckDate > EndDate;
                                    CheckDate := CALCDATE(OneMonthTextLbl, CheckDate);
                                    LimitAmt -= ExepDedLimits."Exemption Limit" / 12;
                                    LastDate := CALCDATE(Text330002Lbl, EndDate);
                                    NoofDays := DATE2DMY(LastDate, 1);
                                    Mondays := DATE2DMY(EndDate, 1);
                                    LimitAmt += ROUND(((ExepDedLimits."Exemption Limit" / 12) / NoofDays) * Mondays, 1, '=');
                                end else
                                    LimitAmt := ExepDedLimits."Exemption Limit";
                                if ExepDedLimits."Exemption Limit" <> 0 then begin
                                    if "Actual Paid" > LimitAmt then
                                        Limit := LimitAmt
                                    else
                                        Limit := "Actual Paid";
                                end else
                                    Limit := "Actual Paid";

                            end;
                    end;
            end;
        }
        field(11; Limit; Decimal)
        {
            Caption = 'Limit';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Emp ID", "Financial Year Start Date", "Exemption Group Id")
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
        ExepDedGr: Record "Exep/Ded Groups B2B";
        Employee: Record "Employee B2B";
        ProcessedSal: Record "Processed Salary B2B";
        PayElements: Record "Pay Elements B2B";
        EMPTDSGrossSalary: Record "EMP TDS Gross Salary B2B";
        HRSetup: Record "HR Setup B2B";
        Limit1: Decimal;
        Limit2: Decimal;
        Limit3: Decimal;
        ALLBasicDA: Decimal;
        ALLHRA: Decimal;
        "Limit1%": Decimal;
        "Limit2%": Decimal;

        ProcessesAmt: Decimal;


        Days: Decimal;
        DayWiseLimit: Decimal;

        Payelement: Code[50];
        LengthCode: Integer;
        PayelementNew: Code[50];

        EnpsTextLbl: Label 'ENPS';
        FinancialYearTextLbl: Label 'FINANCIAL YEAR';
        Text33000Lbl: Label '10 (13A)';
        HraTextLbl: Label 'HRA';
        TransportTextLbl: Label 'TRANSPORT EXEMP';
        MonthTextLbl: Label '<1M>';
        OneMonthTextLbl: Label '<-1M>';
        Text330002Lbl: Label '<CM>';
}

