codeunit 33001200 "Final Settlement Posting B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        Employee: Record "Employee B2B";
        DimSetEntry: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        CrPayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        FinalSettlementLine: Record "Final Settlement Line B2B";
        DedFinalSettlementLine: Record "Final Settlement Line B2B";
        AddFinalSettlementLine: Record "Final Settlement Line B2B";
        EmployerPostingGroupEmp: Record "Employer Stat. Post. Group B2B";
        MonthlyAttendance: Record "Monthly Attendance B2B";
        PayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        Lookup: Record Lookup_b2b;
        Lookup2: Record Lookup_b2b;
        AddLookup: Record Lookup_b2b;
        DedLookup: Record Lookup_b2b;
        CrLookup: Record Lookup_b2b;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Text000Txt: Label 'Account  in General posting group should be defined for pay element %1.', Comment = '%1 = Payelement';
        Text001Txt: Label 'Pay Product Posting group/PayElement  is not defined for the pay element %1 in Lookup.', Comment = '%1 = Payelement';
        Text003Txt: Label 'Processed Pay Element %1 is not defined  in the Lookup.', Comment = '%1 = Payelement';
        Text004Txt: Label 'Business  Posting Group not defined to Employee %1.', Comment = '%1 = Employee';
        BusinessPosting: Code[20];
        ProductPosting: Code[20];
        PayBusiness: Code[20];
        PayElement: Code[20];
        Text005Txt: Label 'Records are Posted';
        BonusAmt: Decimal;
        Text33001Txt: Label 'ADDITIONS AND DEDUCTIONS';
        Text33002Txt: Label 'LOAN';
        Text33003Txt: Label 'Loan';
        Text33004Txt: Label 'ESI';
        Text33005Txt: Label 'PF';
        Text33006Txt: Label 'PT';
        Text33007Txt: Label 'TDS';
        Text33008Txt: Label 'BONUS';
        Text33009Txt: Label 'GENJNL';

    procedure ProcessPosting(FinalSettleHeader: Record "Final Settlement Header B2B");
    var

        PayrollBusinessPosting: Record "Payroll Bus. Post Group B2B";
        CrPayBusinessPosting: Record "Payroll Bus. Post Group B2B";
        PayrollProductPosting: Record "Payroll Prod. Post. Group B2B";
        CrPayrollProductPosting: Record "Payroll Prod. Post. Group B2B";
        AddPayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        AddPayrollBusinessPosting: Record "Payroll Bus. Post Group B2B";
        DedPayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        DedPayrollBusinessPosting: Record "Payroll Bus. Post Group B2B";

        "AccountNo.": Code[20];
        AccountType: Option "G/L Account";

    begin
        OnBeforeProcessPosting(FinalSettleHeader);
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        if FinalSettlementLine.FINDFIRST() then begin
            FinalSettlementLine.TESTFIELD("Document No.");
            FinalSettlementLine.TESTFIELD("Posting Date");
            FinalSettlementLine.TESTFIELD("Journal Batch Name");
        end;

        AddFinalSettlementLine.RESET();
        AddFinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        AddFinalSettlementLine.SETRANGE("Addition/Deduction", AddFinalSettlementLine."Addition/Deduction"::Addition);
        if AddFinalSettlementLine.FINDFIRST() then
            repeat
                AddLookup.RESET();
                if AddLookup.FINDFIRST() then
                    repeat
                        AddLookup.SETRANGE("LookupType Name", Text33001Txt);
                        AddLookup.SETRANGE("Add/Deduct", AddLookup."Add/Deduct"::Addition);
                        AddLookup.SETRANGE(AddLookup."Lookup Name", AddFinalSettlementLine."Pay Element Code");
                        if not AddLookup.FINDFIRST() then
                            ERROR(Text001Txt, AddFinalSettlementLine."Pay Element Code");
                    until AddLookup.NEXT() = 0;
            until AddFinalSettlementLine.NEXT() = 0;


        DedFinalSettlementLine.RESET();
        DedFinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        DedFinalSettlementLine.SETRANGE("Addition/Deduction", DedFinalSettlementLine."Addition/Deduction"::Deduction);
        if DedFinalSettlementLine.FINDFIRST() then
            repeat
                DedLookup.RESET();
                if DedLookup.FINDFIRST() then
                    repeat
                        DedLookup.SETRANGE("LookupType Name", Text33001Txt);
                        DedLookup.SETRANGE("Add/Deduct", DedLookup."Add/Deduct"::Deduction);
                        DedLookup.SETRANGE("Lookup Name", DedFinalSettlementLine."Pay Element Code");
                        if not DedLookup.FINDFIRST() then
                            ERROR(Text001Txt, DedFinalSettlementLine."Pay Element Code");
                    until DedLookup.NEXT() = 0;
            until DedFinalSettlementLine.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        if Employee.FINDFIRST() then
            AddFinalSettlementLine.RESET();
        AddFinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        AddFinalSettlementLine.SETRANGE("Addition/Deduction", AddFinalSettlementLine."Addition/Deduction"::Addition);
        if AddFinalSettlementLine.FINDFIRST() then
            repeat
                if AddPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then begin
                    AddPayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", AddPayrollBusinessPosting.Code);
                    if AddPayrollGeneralPosting.FINDFIRST() then
                        PayBusiness := AddPayrollGeneralPosting."Payroll Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", Text33001Txt);
                    Lookup2.SETRANGE("Lookup Name", AddFinalSettlementLine."Pay Element Code");
                    Lookup2.SETRANGE("Add/Deduct", Lookup2."Add/Deduct"::Addition);
                    if Lookup2.FINDFIRST() then begin
                        Lookup2.TESTFIELD("Payroll Prod. Posting Group");
                        PayElement := Lookup2."Payroll Prod. Posting Group"
                    end else
                        ERROR(Text003Txt, Lookup2."Lookup Name");

                    AddPayrollGeneralPosting.SETRANGE("Payroll Prod. Posting Group", PayElement);
                    if AddPayrollGeneralPosting.IsEmpty() then
                        ERROR(Text000Txt, PayElement);
                end else
                    ERROR(Text004Txt, Employee."No.");
            until AddFinalSettlementLine.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        if Employee.FINDFIRST() then
            DedFinalSettlementLine.RESET();
        DedFinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        DedFinalSettlementLine.SETRANGE("Addition/Deduction", DedFinalSettlementLine."Addition/Deduction"::Deduction);
        DedFinalSettlementLine.SETFILTER("Computation Type", '<>%1', Text33002Txt);
        if DedFinalSettlementLine.FINDFIRST() then
            repeat
                if (DedFinalSettlementLine."Pay Element Code" <> Text33004Txt) and (DedFinalSettlementLine."Pay Element Code" <> Text33005Txt) and
                   (DedFinalSettlementLine."Pay Element Code" <> Text33006Txt) and (DedFinalSettlementLine."Pay Element Code" <> Text33003Txt) and
                   (DedFinalSettlementLine."Pay Element Code" <> Text33007Txt)
                then begin
                    if DedPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then
                        DedPayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", DedPayrollBusinessPosting.Code);
                    if DedPayrollGeneralPosting.FINDFIRST() then
                        PayBusiness := DedPayrollGeneralPosting."Payroll Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", Text33001Txt);
                    Lookup2.SETRANGE("Lookup Name", DedFinalSettlementLine."Pay Element Code");
                    Lookup2.SETRANGE("Add/Deduct", Lookup2."Add/Deduct"::Deduction);
                    if Lookup2.FINDFIRST() then begin
                        Lookup2.TESTFIELD("Payroll Prod. Posting Group");
                        PayElement := Lookup2."Payroll Prod. Posting Group";
                    end else
                        ERROR(Text003Txt, Lookup2."Lookup Name");

                    DedPayrollGeneralPosting.SETRANGE("Payroll Prod. Posting Group", PayElement);
                    if DedPayrollGeneralPosting.IsEmpty() then
                        ERROR(Text000Txt, PayElement);
                end;
            until DedFinalSettlementLine.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        if Employee.FINDFIRST() then
            repeat
                if PayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then;
                BusinessPosting := PayrollBusinessPosting.Code;
                FinalSettlementLine.RESET();
                FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
                FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Addition);
                if FinalSettlementLine.FINDFIRST() then
                    repeat
                        Lookup.SETFILTER("LookupType Name", Text33001Txt);
                        Lookup.SETRANGE("Lookup Name", FinalSettlementLine."Pay Element Code");
                        if Lookup.FINDFIRST() then begin
                            if PayrollProductPosting.GET(Lookup."Payroll Prod. Posting Group") then;
                            ProductPosting := PayrollProductPosting.Code;
                            PayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", BusinessPosting);
                            PayrollGeneralPosting.SETRANGE("Payroll Prod. Posting Group", ProductPosting);
                            if PayrollGeneralPosting.FINDFIRST() then begin
                                "AccountNo." := PayrollGeneralPosting."G/L Code";
                                AccountType := AccountType::"G/L Account";
                            end;
                            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, FinalSettlementLine.Amount);
                        end;
                    until FinalSettlementLine.NEXT() = 0;

            until Employee.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        if Employee.FINDFIRST() then
            repeat
                if CrPayBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then;
                BusinessPosting := PayrollBusinessPosting.Code;
                FinalSettlementLine.RESET();
                FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
                FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
                FinalSettlementLine.SETFILTER("Computation Type", '%1', Text33002Txt);
                if FinalSettlementLine.FINDFIRST() then
                    repeat
                        if (FinalSettlementLine."Pay Element Code" <> Text33004Txt) and (FinalSettlementLine."Pay Element Code" <> Text33005Txt) and
                           (FinalSettlementLine."Pay Element Code" <> Text33006Txt) and (FinalSettlementLine."Pay Element Code" <> Text33003Txt) and
                           (FinalSettlementLine."Pay Element Code" <> Text33007Txt)
                        then begin
                            CrLookup.SETFILTER("LookupType Name", Text33001Txt);
                            CrLookup.SETRANGE("Lookup Name", FinalSettlementLine."Pay Element Code");
                            if CrLookup.FINDFIRST() then begin
                                if CrPayrollProductPosting.GET(CrLookup."Payroll Prod. Posting Group") then;
                                ProductPosting := CrPayrollProductPosting.Code;
                                CrPayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", BusinessPosting);
                                CrPayrollGeneralPosting.SETRANGE("Payroll Prod. Posting Group", ProductPosting);
                                if CrPayrollGeneralPosting.FINDFIRST() then begin
                                    "AccountNo." := CrPayrollGeneralPosting."G/L Code";
                                    AccountType := AccountType::"G/L Account";
                                end;
                            end;
                            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, -FinalSettlementLine.Amount);
                        end;
                    until FinalSettlementLine.NEXT() = 0;

            until Employee.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        if Employee.FINDFIRST() then;

        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."Employer ESI";

        AccountType := AccountType::"G/L Account";

        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", Text33004Txt);
        if FinalSettlementLine.FINDFIRST() then
            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, FinalSettlementLine."Co. Contribution");

        Employee.RESET();
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        if Employee.FINDFIRST() then;

        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."Employer PF";

        AccountType := AccountType::"G/L Account";

        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", Text33005Txt);
        if FinalSettlementLine.FINDFIRST() then
            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, FinalSettlementLine."Co. Contribution");

        Employee.RESET();
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        if Employee.FINDFIRST() then;

        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."Employer EPS";

        AccountType := AccountType::"G/L Account";

        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", Text33005Txt);
        if FinalSettlementLine.FINDFIRST() then
            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, FinalSettlementLine."Co. Contribution2");

        DeductionPosting(FinalSettleHeader);

        Employee.RESET();
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        if Employee.FINDFIRST() then begin
            Employee.Blocked := true;
            Employee."Blocked Date" := FinalSettleHeader."Date of Leaving";
            MonthlyAttendance.RESET();
            MonthlyAttendance.SETRANGE("Employee Code", Employee."No.");
            if MonthlyAttendance.FINDFIRST() then
                repeat
                    if (MonthlyAttendance.Year > DATE2DMY(Employee."Blocked Date", 3)) or
                       ((MonthlyAttendance.Year = DATE2DMY(Employee."Blocked Date", 3)) and
                       (MonthlyAttendance."Pay Slip Month" >= DATE2DMY(Employee."Blocked Date", 2)))
                    then begin
                        OnBeforeMonthlyAttendanceModify(MonthlyAttendance);
                        MonthlyAttendance.Blocked := true;
                        MonthlyAttendance.MODIFY();
                    end;
                until MonthlyAttendance.NEXT() = 0;
            OnBeforeEmployeeModify(Employee);
            Employee.MODIFY();
            MESSAGE(Text005Txt);
        end;

        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        if FinalSettlementLine.FINDFIRST() then
            repeat
                FinalSettlementLine.Posted := true;
                OnBeforeFinalSettlementHeadModify(FinalSettleHeader);
                FinalSettlementLine.MODIFY();
            until FinalSettlementLine.NEXT() = 0;
        FinalSettleHeader.posted := true;
        FinalSettleHeader.Modify();
        OnAfterProcessPosting(FinalSettleHeader);
    end;

    procedure DeductionPosting(FinalSettlementHeader: Record "Final Settlement Header B2B");
    var


        "AccountNo.": Code[20];
        AccountType: Option "G/L Account";
        ESIAmt: Decimal;
        PFAmt: Decimal;
        Additions: Decimal;
        Deductions: Decimal;

    begin
        OnBeforeDeduction(FinalSettlementHeader);
        if EmpPostingGroup.FINDFIRST() then;
        "AccountNo." := EmpPostingGroup."Bonus Payable Acc.";
        AccountType := AccountType::"G/L Account";
        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Addition);
        FinalSettlementLine.SETFILTER("Pay Element Code", Text33008Txt);
        if FinalSettlementLine.FINDFIRST() then
            repeat
                InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, -FinalSettlementLine.Amount);
            until FinalSettlementLine.NEXT() = 0;


        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        if Employee.FINDFIRST() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        if EmpPostingGroup.FINDFIRST() then
            "AccountNo." := EmpPostingGroup."ESI Payable Acc.";
        AccountType := AccountType::"G/L Account";
        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", Text33004Txt);
        if FinalSettlementLine.FINDFIRST() then
            repeat
                ESIAmt := FinalSettlementLine.Amount;
                InitGenJnlLine(
                  FinalSettlementLine, "AccountNo.", AccountType,
                  -(FinalSettlementLine.Amount + FinalSettlementLine."Co. Contribution"));
            until FinalSettlementLine.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        if Employee.FINDFIRST() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        if EmpPostingGroup.FINDFIRST() then
            "AccountNo." := EmpPostingGroup."PF Payable Acc.";

        AccountType := AccountType::"G/L Account";
        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE(FinalSettlementLine."Pay Element Code", Text33005Txt);
        if FinalSettlementLine.FINDFIRST() then
            repeat
                PFAmt := FinalSettlementLine.Amount;
                InitGenJnlLine(
                  FinalSettlementLine, "AccountNo.", AccountType,
                  -(FinalSettlementLine.Amount + FinalSettlementLine."Co. Contribution"));
            until FinalSettlementLine.NEXT() = 0;


        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        if Employee.FINDFIRST() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        if EmpPostingGroup.FINDFIRST() then
            "AccountNo." := EmpPostingGroup."EPS Payable Acc.";
        AccountType := AccountType::"G/L Account";

        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementLine."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", Text33005Txt);
        if FinalSettlementLine.FINDFIRST() then
            InitGenJnlLine(
              FinalSettlementLine, "AccountNo.", AccountType, -(FinalSettlementLine."Co. Contribution2"));


        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        if Employee.FINDFIRST() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        if EmpPostingGroup.FINDFIRST() then
            "AccountNo." := EmpPostingGroup."PT Payable Account";
        AccountType := AccountType::"G/L Account";
        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementLine."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", Text33006Txt);
        if FinalSettlementLine.FINDFIRST() then
            InitGenJnlLine(
              FinalSettlementLine, "AccountNo.", AccountType, -FinalSettlementLine.Amount);


        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        if Employee.FINDFIRST() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        if EmpPostingGroup.FINDFIRST() then
            "AccountNo." := EmpPostingGroup."TDS Payable Acc.";
        AccountType := AccountType::"G/L Account";
        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementLine."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", Text33007Txt);
        if FinalSettlementLine.FINDFIRST() then
            InitGenJnlLine(
              FinalSettlementLine, "AccountNo.", AccountType, -FinalSettlementLine.Amount);


        Additions := 0;
        Deductions := 0;
        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        if Employee.FINDFIRST() then begin
            Employee.TESTFIELD(Employee."Emp Posting Group");
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
            if EmpPostingGroup.FINDFIRST() then
                "AccountNo." := EmpPostingGroup."Arrear Salary Payable Acc.";
            AccountType := AccountType::"G/L Account";
            FinalSettlementLine.RESET();
            FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
            FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Addition);
            if FinalSettlementLine.FINDFIRST() then
                repeat
                    Additions := Additions + FinalSettlementLine.Amount;
                until FinalSettlementLine.NEXT() = 0;


            FinalSettlementLine.RESET();
            FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
            FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
            if FinalSettlementLine.FINDFIRST() then
                repeat
                    Deductions := Deductions + FinalSettlementLine.Amount;
                until FinalSettlementLine.NEXT() = 0;


            FinalSettlementLine.RESET();
            FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
            FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Addition);
            FinalSettlementLine.SETFILTER("Pay Element Code", Text33008Txt);
            if FinalSettlementLine.FINDFIRST() then
                repeat
                    BonusAmt := BonusAmt + FinalSettlementLine.Amount;
                until FinalSettlementLine.NEXT() = 0;

            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, -(Additions - Deductions - BonusAmt));
        end;
        OnAfterDeduction(FinalSettlementHeader);
    end;

    procedure InitGenJnlLine(var FinalSettlementLine: Record "Final Settlement Line B2B"; "AccountNo.": Code[20]; AccountType: Option "G/L Account","Bank Account"; Amount: Decimal);
    var
    begin
        if Amount <> 0 then begin
            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := FinalSettlementLine."Journal Template Name";
            GenJnlLine."Journal Batch Name" := FinalSettlementLine."Journal Batch Name";
            GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
            if AccountType = AccountType::"Bank Account" then
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account"
            else
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := "AccountNo.";
            GenJnlLine.VALIDATE("Account No.");
            GenJnlLine."Document No." := FinalSettlementLine."Document No.";
            GenJnlLine."Posting Date" := FinalSettlementLine."Posting Date";
            if AccountType = AccountType::"Bank Account" then
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account"
            else
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine.Amount := Amount;
            GenJnlLine.VALIDATE(Amount);
            GenJnlLine."Source Code" := Text33009Txt;
            //GenJnlLine."Source Type" := GenJnlLine."Source Type"::"10";//Phani
            GenJnlLine."Source No." := FinalSettlementLine."Employee No.";
            GenJnlLine."Dimension Set ID" := FinalSettlementLine."Dimension Set ID";
            GenJnlLine."Shortcut Dimension 1 Code" := FinalSettlementLine."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := FinalSettlementLine."Shortcut Dimension 2 Code";
            OnBeforePostJnl(GenJnlLine);
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            OnAfterPostJnl(GenJnlLine);
        end;
    end;

    procedure GetDimensionSet(var TempDimSetEntry: Record "Dimension Set Entry" temporary; DimSetID: Integer);
    var

    begin
        TempDimSetEntry.DELETEALL();
        with DimSetEntry2 do begin
            SETRANGE("Dimension Set ID", DimSetID);
            if FINDSET() then
                repeat
                    TempDimSetEntry := DimSetEntry2;
                    TempDimSetEntry.INSERT();
                until NEXT() = 0;
        end;
    end;

    procedure GetDimensionSetID(var DimSetEntry2: Record "Dimension Set Entry"): Integer;
    begin
        exit(DimSetEntry.GetDimensionSetID(DimSetEntry2));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeProcessPosting(var FinalSettlement: Record "Final Settlement Header B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterProcessPosting(var FinalSettlement: Record "Final Settlement Header B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeDeduction(var FinalSettlement: Record "Final Settlement Header B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterDeduction(var FinalSettlement: Record "Final Settlement Header B2B")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforePostJnl(var GenJnl: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterPostJnl(var GenJnl: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeFinalSettlementHeadModify(var FinalSettlement: Record "Final Settlement Header B2B")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeMonthlyAttendanceModify(var MonthlyAttendance: Record "Monthly Attendance B2B")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeEmployeeModify(var Employee: Record "Employee B2B")
    begin
    end;
}

