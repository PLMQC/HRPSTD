table 33001230 "Loan Repayments B2B"
{
    // version B2BHR1.00.00
    Caption = 'Loan Repayments';
    DrillDownPageID = "Loan Repayment List B2B";
    LookupPageID = "Loan Repayment List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Loan Id"; Code[20])
        {
            Caption = 'Loan Id';
            TableRelation = Loan_B2B.Id;
            DataClassification = CustomerContent;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B"."No.";
            DataClassification = CustomerContent;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(6; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
        }
        field(7; Paid; Boolean)
        {
            Caption = 'Paid';
            DataClassification = CustomerContent;
        }
        field(8; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(40; "Loan Repayment Type"; Option)
        {
            Caption = 'Loan Repayment Type';
            OptionCaption = ' ,Same EMI,Same Installments';
            OptionMembers = " ","Same EMI","Same Installments";
            DataClassification = CustomerContent;
        }
        field(41; "Account Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,"G/L Account","Bank Account";
            OptionCaption = ' ,G/L Account,Bank Account';
        }
        field(42; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(43; "Loan Repayment Template Name"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name;
            DataClassification = CustomerContent;
        }
        field(44; "Loan Repayment Batch Name"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Loan Repayment Template Name"));
            DataClassification = CustomerContent;
        }
        field(45; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(Key1; "Loan Id", "Employee No.", "Line No.", "Payment Date")
        {
        }
        key(Key2; "Loan Id", "Employee No.", Month, Year, Paid)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        LoanDetails3: Record "Loan Details B2B";
        Balanceafterrepay: Decimal;
        RemainingInstalments: Integer;
        InterestPerMonth: Decimal;
        EMIValue2: Decimal;
        EMIValue3: Decimal;
        J: Integer;

    procedure LoanRescheduleForIF(LoanDetails: Record "Loan Details B2B"; Loan: Record Loan_B2B; Amount: Decimal);
    var
        TempKnockoffAmount: Decimal;
    begin
        TempKnockoffAmount := Amount;
        LoanDetails.RESET();
        LoanDetails.SETRANGE("Loan Id", Loan.Id);
        LoanDetails.SETRANGE("Employee No.", Loan."Employee Code");
        LoanDetails.SETRANGE("Knocked Off ag lumsum", false);
        if LoanDetails.FINDLAST() then
            repeat
                if LoanDetails."EMI Amount" <= TempKnockoffAmount then begin
                    LoanDetails."knocked Off Amount" := LoanDetails."EMI Amount";
                    LoanDetails."Knocked Off ag lumsum" := true;
                    LoanDetails."EMI Amount" := 0;
                    LoanDetails.MODIFY();
                    TempKnockoffAmount := TempKnockoffAmount - LoanDetails."knocked Off Amount";
                end else
                    if LoanDetails."EMI Amount" > TempKnockoffAmount then begin
                        LoanDetails."knocked Off Amount" := TempKnockoffAmount;
                        LoanDetails."EMI Amount" := (LoanDetails."EMI Amount" - TempKnockoffAmount);
                        if ROUND((LoanDetails."EMI Amount"), 0.01) = 0 then
                            LoanDetails."Knocked Off ag lumsum" := true;
                        LoanDetails.MODIFY();
                        TempKnockoffAmount := TempKnockoffAmount - LoanDetails."knocked Off Amount";
                    end;
                LoanDetails.NEXT(-1);
            until TempKnockoffAmount = 0;
    end;

    procedure LoanRescheduleForFR(LoanDetails: Record "Loan Details B2B"; Loan: Record Loan_B2B; Amount: Decimal);
    var
        TempKnockoffAmount: Decimal;
        CurrentInterest: Decimal;
        IntRateperMonth: Decimal;
    begin
        TempKnockoffAmount := Amount;
        LoanDetails.RESET();
        LoanDetails.SETRANGE("Loan Id", Loan.Id);
        LoanDetails.SETRANGE("Employee No.", Loan."Employee Code");
        LoanDetails.SETRANGE("Knocked Off ag lumsum", false);
        if LoanDetails.FINDLAST() then
            repeat
                if LoanDetails.Principal <= TempKnockoffAmount then begin
                    LoanDetails."knocked Off Amount" := LoanDetails.Principal;
                    LoanDetails.Principal := 0;
                    if LoanDetails.Principal = 0 then begin
                        LoanDetails."EMI Amount" := 0;
                        LoanDetails.Interest := 0;
                        LoanDetails."Knocked Off ag lumsum" := true;
                        LoanDetails.MODIFY();
                    end;
                    TempKnockoffAmount := TempKnockoffAmount - LoanDetails."knocked Off Amount";
                end else
                    if LoanDetails.Principal > TempKnockoffAmount then begin
                        LoanDetails."knocked Off Amount" := TempKnockoffAmount;
                        LoanDetails.Principal := (LoanDetails.Principal - TempKnockoffAmount);
                        IntRateperMonth := Loan."Interest Rate" / 12;
                        CurrentInterest := ROUND((LoanDetails.Principal * IntRateperMonth) / 100, 0.1);
                        LoanDetails.Interest := CurrentInterest;
                        LoanDetails."EMI Amount" := LoanDetails.Principal + LoanDetails.Interest;
                        if ROUND((LoanDetails."EMI Amount"), 0.1) = 0 then
                            LoanDetails."Knocked Off ag lumsum" := true;
                        LoanDetails.MODIFY();
                        TempKnockoffAmount := TempKnockoffAmount - LoanDetails."knocked Off Amount";
                    end;
                LoanDetails.NEXT(-1);
            until TempKnockoffAmount = 0;
        CLEAR(Balanceafterrepay);
        LoanDetails3.RESET();
        LoanDetails3.SETRANGE("Loan Id", Loan.Id);
        LoanDetails3.SETRANGE("Employee No.", Loan."Employee Code");
        LoanDetails3.SETFILTER("EMI Deducted", '=%1', 0);
        LoanDetails3.SETRANGE("Knocked Off ag lumsum", false);
        if LoanDetails3.FINDFIRST() then
            repeat
                Balanceafterrepay := Balanceafterrepay + LoanDetails3."EMI Amount";
            until LoanDetails3.NEXT() = 0;
        Loan."Loan Balance" := Balanceafterrepay;
        Loan.MODIFY();
    end;

    procedure LoanRescheduleForDim(LoanDetails: Record "Loan Details B2B"; Loan: Record Loan_B2B; Amount: Decimal);
    var
        EMIAmt: Decimal;
        Balance: Decimal;
        TempKnockoffAmount: Decimal;
        CurrentInterest: Decimal;
        IntRateperMonth: Decimal;
    begin
        if "Loan Repayment Type" = "Loan Repayment Type"::"Same EMI" then begin
            TempKnockoffAmount := Amount;
            LoanDetails.RESET();
            LoanDetails.SETRANGE("Loan Id", Loan.Id);
            LoanDetails.SETRANGE("Employee No.", Loan."Employee Code");
            LoanDetails.SETRANGE("Knocked Off ag lumsum", false);
            if LoanDetails.FINDLAST() then
                repeat
                    if LoanDetails.Principal <= TempKnockoffAmount then begin
                        LoanDetails."knocked Off Amount" := LoanDetails.Principal;
                        LoanDetails.Principal := 0;
                        if LoanDetails.Principal = 0 then begin
                            LoanDetails."EMI Amount" := 0;
                            LoanDetails.Interest := 0;
                            LoanDetails."Knocked Off ag lumsum" := true;
                            LoanDetails.MODIFY();
                        end;
                        TempKnockoffAmount := TempKnockoffAmount - LoanDetails."knocked Off Amount";
                    end else
                        if LoanDetails.Principal > TempKnockoffAmount then begin
                            LoanDetails."knocked Off Amount" := TempKnockoffAmount;
                            LoanDetails.Principal := (LoanDetails.Principal - TempKnockoffAmount);
                            IntRateperMonth := (1200 + Loan."Interest Rate") / 1200;
                            CurrentInterest := ROUND((LoanDetails.Principal * IntRateperMonth) / 100, 0.1);
                            LoanDetails.Interest := CurrentInterest;
                            LoanDetails."EMI Amount" := LoanDetails.Principal + LoanDetails.Interest;
                            if ROUND((LoanDetails."EMI Amount"), 0.1) = 0 then
                                LoanDetails."Knocked Off ag lumsum" := true;
                            LoanDetails.MODIFY();
                            TempKnockoffAmount := TempKnockoffAmount - LoanDetails."knocked Off Amount";
                        end;
                    LoanDetails.NEXT(-1);
                until TempKnockoffAmount = 0;
            CLEAR(Balanceafterrepay);
            LoanDetails3.RESET();
            LoanDetails3.SETRANGE("Loan Id", Loan.Id);
            LoanDetails3.SETRANGE("Employee No.", Loan."Employee Code");
            LoanDetails3.SETFILTER("EMI Deducted", '=%1', 0);
            LoanDetails3.SETRANGE("Knocked Off ag lumsum", false);
            if LoanDetails3.FINDFIRST() then
                repeat
                    Balanceafterrepay := Balanceafterrepay + LoanDetails3."EMI Amount";
                until LoanDetails3.NEXT() = 0;
            Loan."Loan Balance" := Balanceafterrepay;
            Loan.MODIFY();
            LoanDetails3.RESET();
            LoanDetails3.SETRANGE("Loan Id", Loan.Id);
            LoanDetails3.SETRANGE("Employee No.", Loan."Employee Code");
            LoanDetails3.SETFILTER("EMI Deducted", '=%1', 0);
            LoanDetails3.SETRANGE("Knocked Off ag lumsum", false);
            if LoanDetails3.FINDFIRST() then
                repeat
                    LoanDetails3."Balance (Base)" := Balanceafterrepay;
                    LoanDetails3.MODIFY();
                    Balanceafterrepay := Balanceafterrepay - (LoanDetails3.Principal + LoanDetails3.Interest);
                until LoanDetails3.NEXT() = 0;
        end else
            if "Loan Repayment Type" = "Loan Repayment Type"::"Same Installments" then begin
                CLEAR(Balanceafterrepay);
                Balanceafterrepay := Loan."Loan Balance";
                LoanDetails3.RESET();
                LoanDetails3.SETRANGE("Loan Id", Loan.Id);
                LoanDetails3.SETRANGE("Employee No.", Loan."Employee Code");
                LoanDetails3.SETFILTER("EMI Deducted", '=%1', 0);
                LoanDetails3.SETRANGE("Knocked Off ag lumsum", false);
                RemainingInstalments := LoanDetails3.COUNT();
                if RemainingInstalments > 0 then begin
                    InterestPerMonth := (1200 + Loan."Interest Rate") / 1200;
                    EMIValue2 := Balanceafterrepay * POWER(InterestPerMonth, RemainingInstalments);
                    EMIValue3 := 0;
                    for J := 0 to (RemainingInstalments - 1) do
                        EMIValue3 := EMIValue3 + POWER(InterestPerMonth, J);
                    EMIAmt := ROUND((EMIValue2 / EMIValue3), 0.1, '=');
                    Balance := Balanceafterrepay;
                    if LoanDetails3.FINDFIRST() then
                        repeat
                            LoanDetails3."EMI Amount" := EMIAmt;
                            LoanDetails3.Interest := ROUND(((Balance * Loan."Interest Rate") / (1200)), 0.1, '=');
                            LoanDetails3.Principal := EMIAmt - LoanDetails3.Interest;
                            LoanDetails3."Balance (Base)" := Balance;
                            Balance := Balance - LoanDetails3.Principal;
                            LoanDetails3.MODIFY();
                        until LoanDetails3.NEXT() = 0;
                end;
                LoanDetails3.RESET();
                LoanDetails3.SETRANGE("Loan Id", Loan.Id);
                LoanDetails3.SETRANGE("Employee No.", Loan."Employee Code");
                LoanDetails3.SETFILTER("EMI Deducted", '=%1', 0);
                LoanDetails3.SETRANGE("Knocked Off ag lumsum", false);
                if LoanDetails3.FINDFIRST() then begin
                    Loan."Effective Amount" := LoanDetails3."EMI Amount";
                    Loan.MODIFY();
                end;
            end
    end;
}

