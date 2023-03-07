codeunit 33001195 "Loan Calculations B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        PayElements: Record "Pay Elements B2B";
        PayElements2: Record "Pay Elements B2B";
        EMILimitAmount: Decimal;
        InstallmentsInserted: Boolean;
        Text002Txt: Label 'Installments Created';
        Text33001Txt: Label '<1M>';
        Text33002Txt: Label 'BASIC';
        Text33003Txt: Label 'DA';
        Text33004Txt: Label 'AFTER BASIC';
        Text33005Txt: Label 'AFTER BASIC AND DA';

    procedure LoanInstallments(Loan: Record Loan_B2B);
    var
    begin
        case Loan."Interest Method" of
            Loan."Interest Method"::"Interest Free":
                InterestFree(Loan);
            Loan."Interest Method"::"Flat Rate":
                FlatRate(Loan);
            Loan."Interest Method"::"Dimnishing Rate":
                Dimnishing(Loan);
        end;
    end;

    procedure InterestFree(Loan: Record Loan_B2B);
    var
        LoanDetails: Record "Loan Details B2B";
        PaymentDate: Date;
        I: Integer;
    begin
        CLEAR(InstallmentsInserted);
        CLEAR(EMILimitAmount);
        PaymentDate := Loan."Loan Start Date";
        if Loan."Interest Method" = Loan."Interest Method"::"Interest Free" then begin
            for I := 1 to Loan."No of Installments" do begin
                LoanDetails.INIT();
                LoanDetails."Line No" := LoanDetails."Line No" + 1;
                LoanDetails."Employee No." := Loan."Employee Code";
                LoanDetails."Loan Id" := Loan.Id;
                LoanDetails."Loan Code" := Loan."Loan Type";
                LoanDetails."Pay Date" := PaymentDate;
                LoanDetails."EMI Amount" := (Loan."Loan Amount" / Loan."No of Installments");
                LoanDetails.Principal := (Loan."Loan Amount" / Loan."No of Installments");
                LoanDetails.Month := DATE2DMY(LoanDetails."Pay Date", 2);
                LoanDetails.Year := DATE2DMY(LoanDetails."Pay Date", 3);
                LoanDetails."Loan Amount" := Loan."Loan Amount";
                if LoanDetails.INSERT() then
                    InstallmentsInserted := true;
                PaymentDate := CALCDATE(Text33001Txt, PaymentDate);
            end;

            Loan."Effective Amount" := LoanDetails."EMI Amount";
            Loan.MODIFY()
        end;
        if InstallmentsInserted then
            MESSAGE(Text002Txt);
    end;

    procedure FlatRate(Loan: Record Loan_B2B);
    var
        LoanDetails: Record "Loan Details B2B";
        PaymentDate: Date;
        InterestAmt: Decimal;
        MonthlyInterest: Decimal;
        IntRateperMonth: Decimal;
        EMIAmt: Decimal;
        I: Integer;
    begin
        CLEAR(InstallmentsInserted);
        IntRateperMonth := Loan."Interest Rate" / 12;
        MonthlyInterest := ROUND((Loan."Loan Amount" * IntRateperMonth) / 100, 0.01);
        InterestAmt := ROUND((MonthlyInterest * Loan."No of Installments"), 0.01);
        PaymentDate := Loan."Loan Start Date";
        EMIAmt := ROUND(((Loan."Loan Amount" + InterestAmt) / Loan."No of Installments"), 0.01);

        for I := 1 to Loan."No of Installments" do begin
            LoanDetails.INIT();
            LoanDetails."Line No" := LoanDetails."Line No" + 1;
            LoanDetails."Employee No." := Loan."Employee Code";
            LoanDetails."Loan Id" := Loan.Id;
            LoanDetails."Loan Code" := Loan."Loan Type";
            LoanDetails."Pay Date" := PaymentDate;
            LoanDetails."EMI Amount" := EMIAmt;
            LoanDetails.Interest := MonthlyInterest;
            LoanDetails.Principal := EMIAmt - MonthlyInterest;
            LoanDetails.Month := DATE2DMY(LoanDetails."Pay Date", 2);
            LoanDetails.Year := DATE2DMY(LoanDetails."Pay Date", 3);
            LoanDetails."Loan Amount" := Loan."Loan Amount";
            if LoanDetails.INSERT() then
                InstallmentsInserted := true;
            PaymentDate := CALCDATE(Text33001Txt, PaymentDate);
        end;

        Loan."Total Loan Payable" := Loan."Loan Amount" + InterestAmt;
        Loan."Total Interest Amount" := InterestAmt;
        Loan."Effective Amount" := LoanDetails."EMI Amount";
        Loan.MODIFY();
        if InstallmentsInserted then
            MESSAGE(Text002Txt);
    end;

    procedure Dimnishing(Loan: Record Loan_B2B);
    var
        LoanDetails: Record "Loan Details B2B";
        EMIAmt: Decimal;
        InterestPerMonth: Decimal;
        EMIValue2: Decimal;
        EMIValue3: Decimal;
        Balance: Decimal;
        J: Integer;
        I: Integer;
        PaymentDate: Date;
        TempDate: Date;
    begin
        CLEAR(InstallmentsInserted);
        Loan.TESTFIELD(Loan."No of Installments");
        PaymentDate := Loan."Loan Start Date";
        InterestPerMonth := (1200 + Loan."Interest Rate") / 1200;
        EMIValue2 := Loan."Loan Amount" * POWER(InterestPerMonth, Loan."No of Installments");
        EMIValue3 := 0;
        for J := 0 to (Loan."No of Installments" - 1) do
            EMIValue3 := EMIValue3 + POWER(InterestPerMonth, J);
        EMIAmt := ROUND((EMIValue2 / EMIValue3), 0.1, '=');
        Balance := Loan."Loan Amount";

        for I := 1 to Loan."No of Installments" do begin
            TempDate := PaymentDate;
            LoanDetails.INIT();
            LoanDetails."Line No" := LoanDetails."Line No" + 1;
            LoanDetails."Employee No." := Loan."Employee Code";
            LoanDetails."Loan Id" := Loan.Id;
            LoanDetails."Loan Code" := Loan."Loan Type";
            LoanDetails."Pay Date" := PaymentDate;
            LoanDetails."EMI Amount" := EMIAmt;
            LoanDetails.Interest := ROUND(((Balance * Loan."Interest Rate") / (1200)), 0.1, '=');
            LoanDetails.Principal := EMIAmt - LoanDetails.Interest;
            LoanDetails.Month := DATE2DMY(LoanDetails."Pay Date", 2);
            LoanDetails.Year := DATE2DMY(LoanDetails."Pay Date", 3);
            LoanDetails."Loan Amount" := Loan."Loan Amount";
            LoanDetails."Balance (Base)" := Balance;
            Balance := Balance - LoanDetails.Principal;
            if LoanDetails.INSERT() then
                InstallmentsInserted := true;
            PaymentDate := CALCDATE(Text33001Txt, PaymentDate);
        end;

        Loan."Effective Amount" := LoanDetails."EMI Amount";
        Loan.MODIFY();
        if InstallmentsInserted then
            MESSAGE(Text002Txt);
    end;

    procedure LoanInstallmentsAll();
    var
        Loan: Record Loan_B2B;
        Text000Txt: Label 'Loan Id..........#1###########\Employee code....#2###############\', Comment = '%1 = Loan ID;%2 = Employee';
        Window: Dialog;
    begin
        Window.OPEN(Text000Txt);
        Loan.RESET();
        if Loan.FINDFIRST() then
            repeat
                Window.UPDATE(1, Loan.Id);
                Window.UPDATE(2, Loan."Employee Code");
                LoanInstallments(Loan);
            until Loan.NEXT() = 0;

        Window.CLOSE();
    end;

    procedure ExistingLoanInstallments(Loan: Record Loan_B2B);
    var
        LoanDetails: Record "Loan Details B2B";
        PaymentDate: Date;
        I: Integer;
    begin
        PaymentDate := Loan."Loan Start Date";
        if Loan."Interest Method" = Loan."Interest Method"::"Interest Free" then begin
            for I := 1 to Loan."No of Installments" do begin
                LoanDetails.INIT();
                LoanDetails."Line No" := LoanDetails."Line No" + 1;
                LoanDetails."Employee No." := Loan."Employee Code";
                LoanDetails."Loan Id" := Loan.Id;
                LoanDetails."Loan Code" := Loan."Loan Type";
                LoanDetails."Pay Date" := PaymentDate;
                LoanDetails."EMI Amount" := Loan."Installment Amount";
                LoanDetails.Month := DATE2DMY(LoanDetails."Pay Date", 2);
                LoanDetails.Year := DATE2DMY(LoanDetails."Pay Date", 3);
                LoanDetails."Loan Amount" := Loan."Loan Amount";
                LoanDetails.INSERT();
                PaymentDate := CALCDATE(Text33001Txt, PaymentDate);
            end;
            Loan."Effective Amount" := LoanDetails."EMI Amount";
            Loan.MODIFY();
        end;
    end;

    procedure ExistingLoanInstallmentsAll();
    var
        Loan: Record Loan_B2B;
        Text000Txt: Label 'Loan Id..........#1###########\Employee code....#2###############\', Comment = '%1 = Loan ID;%2 = Employee';
        Window: Dialog;
    begin
        Window.OPEN(Text000Txt);
        Loan.RESET();
        if Loan.FINDFIRST() then
            repeat
                Window.UPDATE(1, Loan.Id);
                Window.UPDATE(2, Loan."Employee Code");
                ExistingLoanInstallments(Loan);
            until Loan.NEXT() = 0;
        Window.CLOSE();
    end;

    procedure CalcGrossAmount(Employee: Record "Employee B2B"): Decimal;
    var

        Total: Decimal;
        TotalAmt: Decimal;
        Basic: Decimal;
        DA: Decimal;
    begin
        TotalAmt := 0;
        Total := 0;
        PayElements.SETRANGE("Employee Code", Employee."No.");
        PayElements.SETRANGE("Add/Deduct", PayElements."Add/Deduct"::Addition);
        PayElements.SETRANGE(Processed, false);
        if PayElements.FINDFIRST() then begin
            repeat
                PayElements2.SETRANGE("Employee Code", PayElements."Employee Code");
                PayElements2.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                if PayElements2.FINDFIRST() then
                    repeat
                        PayElements2.Processed := true;
                        PayElements2.MODIFY();
                        if PayElements2."Effective Start Date" <= TODAY() then
                            if (PayElements2."Fixed/Percent" = PayElements2."Fixed/Percent"::Fixed) then begin
                                Total := PayElements2."Amount / Percent";
                                if PayElements2."Pay Element Code" = Text33002Txt then
                                    Basic := Total
                                else
                                    if PayElements2."Pay Element Code" = Text33003Txt then
                                        DA := Total;
                            end else
                                if (PayElements2."Fixed/Percent" = PayElements2."Fixed/Percent"::Percent) and
                                   (PayElements2."Computation Type" = Text33004Txt)
                       then
                                    Total := (PayElements2."Amount / Percent" * Basic) / 100
                                else
                                    if (PayElements2."Fixed/Percent" = PayElements2."Fixed/Percent"::Percent) and
                                       (PayElements2."Computation Type" = Text33005Txt)
                               then
                                        Total := (PayElements2."Amount / Percent" * (Basic + DA)) / 100;
                    until PayElements2.NEXT() = 0;
                TotalAmt := TotalAmt + Total;
            until PayElements.NEXT() = 0;
            exit(TotalAmt);
        end;
    end;
}

