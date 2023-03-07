codeunit 33001199 "Arrear Posting B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        Employee: Record "Employee B2B";
        Lookup: Record Lookup_b2b;
        Lookup2: Record Lookup_b2b;
        AddLookup: Record Lookup_b2b;
        DedLookup: Record Lookup_b2b;
        EmpPostingGroup: Record "Employee Posting Group B2B";
        CrLookup: Record Lookup_b2b;
        CrPayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        AddPayRevisionLine: Record "Pay Revision Line B2B";
        DedPayRevisionLine: Record "Pay Revision Line B2B";
        EmployerPostingGroupEmp: Record "Employer Stat. Post. Group B2B";
        PayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Text000Txt: Label 'Account  in General posting group should be defined for pay element %1.', Comment = '%1 = Payelement';
        Text001Txt: Label 'Pay Product Posting group/PayElement  is not defined for the pay element %1 in Lookup.', Comment = '%1 = Payelement';
        Text003Txt: Label 'Processed Pay Element is not defined  in the Lookup %1.', Comment = '%1 = Payelement';
        Text004Txt: Label 'Business  Posting Group not defined to Employee %1.', Comment = '%1 = Employee';
        BusinessPosting: Code[20];
        ProductPosting: Code[20];
        PayBusiness: Code[20];
        PayElement: Code[20];
        Text33001Txt: Label 'ADDITIONS AND DEDUCTIONS';
        Text33002Txt: Label 'ESI';
        Text33003Txt: Label 'PF';
        Text33004Txt: Label 'PT';
        Text33005Txt: Label 'Loan';
        Text33006Txt: Label 'TDS';
        Text33007Txt: Label 'GENJNL';

    procedure ProcessPosting(PayRevisionHeader: Record "Pay Revision Header B2B");
    var

        PayrollBusinessPosting: Record "Payroll Bus. Post Group B2B";
        CrPayBusinessPosting: Record "Payroll Bus. Post Group B2B";
        PayrollProductPosting: Record "Payroll Prod. Post. Group B2B";
        CrPayrollProductPosting: Record "Payroll Prod. Post. Group B2B";

        AddPayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        AddPayrollBusinessPosting: Record "Payroll Bus. Post Group B2B";
        DedPayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        DedPayrollBusinessPosting: Record "Payroll Bus. Post Group B2B";

        PayRevisionLine: Record "Pay Revision Line B2B";
        "AccountNo.": Code[20];
        AccountType: Option "G/L Account";

    begin
        OnBeforeProcessPosting(PayRevisionHeader);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                PayRevisionLine.TESTFIELD("Document No.");
                PayRevisionLine.TESTFIELD("Posting Date");
                PayRevisionLine.TESTFIELD("Journal Batch Name");
            until PayRevisionLine.NEXT() = 0;

        AddPayRevisionLine.RESET();
        AddPayRevisionLine.SETCURRENTKEY("Add/Deduct", "Pay Element");
        AddPayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        AddPayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        AddPayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        AddPayRevisionLine.SETRANGE("Add/Deduct", AddPayRevisionLine."Add/Deduct"::Addition);
        if AddPayRevisionLine.FINDFIRST() then
            repeat
                AddLookup.RESET();
                if AddLookup.FINDFIRST() then
                    repeat
                        AddLookup.SETRANGE("LookupType Name", Text33001Txt);
                        AddLookup.SETRANGE("Add/Deduct", AddLookup."Add/Deduct"::Addition);
                        AddLookup.SETRANGE(AddLookup."Lookup Name", AddPayRevisionLine."Pay Element");
                        if not AddLookup.FINDFIRST() then
                            ERROR(Text001Txt, PayRevisionLine."Pay Element");
                    until AddLookup.NEXT() = 0;
            until AddPayRevisionLine.NEXT() = 0;



        DedPayRevisionLine.RESET();
        DedPayRevisionLine.SETCURRENTKEY("Add/Deduct", "Pay Element");
        DedPayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        DedPayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        DedPayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        DedPayRevisionLine.SETRANGE("Add/Deduct", DedPayRevisionLine."Add/Deduct"::Deduction);
        if DedPayRevisionLine.FINDFIRST() then
            repeat
                DedLookup.RESET();
                if DedLookup.FINDFIRST() then
                    repeat
                        DedLookup.SETRANGE("LookupType Name", Text33001Txt);
                        DedLookup.SETRANGE("Add/Deduct", DedLookup."Add/Deduct"::Deduction);
                        DedLookup.SETRANGE("Lookup Name", DedPayRevisionLine."Pay Element");
                        if not DedLookup.FINDFIRST() then
                            ERROR(Text001Txt, PayRevisionLine."Pay Element");
                    until DedLookup.NEXT() = 0;
            until DedPayRevisionLine.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        if Employee.FINDFIRST() then
            AddPayRevisionLine.RESET();
        AddPayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        AddPayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        AddPayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        AddPayRevisionLine.SETRANGE("Add/Deduct", AddPayRevisionLine."Add/Deduct"::Addition);
        if AddPayRevisionLine.FINDFIRST() then
            repeat
                if AddPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then begin
                    AddPayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", AddPayrollBusinessPosting.Code);
                    if AddPayrollGeneralPosting.FINDFIRST() then
                        PayBusiness := AddPayrollGeneralPosting."Payroll Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", Text33001Txt);
                    Lookup2.SETRANGE("Lookup Name", AddPayRevisionLine."Pay Element");
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
            until AddPayRevisionLine.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        if Employee.FINDFIRST() then
            DedPayRevisionLine.RESET();
        DedPayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        DedPayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        DedPayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        DedPayRevisionLine.SETRANGE("Add/Deduct", DedPayRevisionLine."Add/Deduct"::Deduction);
        if DedPayRevisionLine.FINDFIRST() then
            repeat
                if (DedPayRevisionLine."Pay Element" <> Text33002Txt) and (DedPayRevisionLine."Pay Element" <> Text33003Txt) and
                   (DedPayRevisionLine."Pay Element" <> Text33004Txt) and (DedPayRevisionLine."Pay Element" <> Text33005Txt) and
                   (DedPayRevisionLine."Pay Element" <> Text33006Txt)
                then begin
                    if DedPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then
                        DedPayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", DedPayrollBusinessPosting.Code);
                    if DedPayrollGeneralPosting.FINDFIRST() then
                        PayBusiness := DedPayrollGeneralPosting."Payroll Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", Text33001Txt);
                    Lookup2.SETRANGE("Lookup Name", DedPayRevisionLine."Pay Element");
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
            until DedPayRevisionLine.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        if Employee.FINDFIRST() then
            repeat
                if PayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then;
                BusinessPosting := PayrollBusinessPosting.Code;
                PayRevisionLine.RESET();
                PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
                PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
                PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
                PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Addition);
                if PayRevisionLine.FINDFIRST() then
                    repeat
                        Lookup.SETFILTER("LookupType Name", Text33001Txt);
                        Lookup.SETRANGE("Lookup Name", PayRevisionLine."Pay Element");
                        if Lookup.FINDFIRST() then begin
                            if PayrollProductPosting.GET(Lookup."Payroll Prod. Posting Group") then;
                            ProductPosting := PayrollProductPosting.Code;
                            PayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", BusinessPosting);
                            PayrollGeneralPosting.SETRANGE("Payroll Prod. Posting Group", ProductPosting);
                            if PayrollGeneralPosting.FINDFIRST() then begin
                                "AccountNo." := PayrollGeneralPosting."G/L Code";
                                AccountType := AccountType::"G/L Account";
                            end;
                            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, PayRevisionLine."Arrear Amount");
                        end;
                    until PayRevisionLine.NEXT() = 0;

            until Employee.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        if Employee.FINDFIRST() then
            repeat
                if CrPayBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then;
                BusinessPosting := PayrollBusinessPosting.Code;
                PayRevisionLine.RESET();
                PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
                PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
                PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
                PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
                if PayRevisionLine.FINDFIRST() then
                    repeat
                        if (PayRevisionLine."Pay Element" <> Text33002Txt) and (PayRevisionLine."Pay Element" <> Text33003Txt) and
                           (PayRevisionLine."Pay Element" <> Text33004Txt) and (PayRevisionLine."Pay Element" <> Text33005Txt) and
                           (PayRevisionLine."Pay Element" <> Text33006Txt)
                        then begin
                            CrLookup.SETFILTER("LookupType Name", Text33001Txt);
                            CrLookup.SETRANGE("Lookup Name", PayRevisionLine."Pay Element");
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
                            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, -PayRevisionLine."Arrear Amount");
                        end;
                    until PayRevisionLine.NEXT() = 0;

            until Employee.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", PayRevisionHeader."Employee No.");
        if Employee.FINDFIRST() then;

        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."Employer ESI";

        AccountType := AccountType::"G/L Account";

        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", Text33002Txt);
        if PayRevisionLine.FINDFIRST() then
            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, PayRevisionLine."Arrear Co. Contribution");

        Employee.RESET();
        Employee.SETRANGE("No.", PayRevisionHeader."Employee No.");
        if Employee.FINDFIRST() then;

        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."Employer PF";


        AccountType := AccountType::"G/L Account";

        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", Text33003Txt);
        if PayRevisionLine.FINDFIRST() then
            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, PayRevisionLine."Arrear Co. Contribution");

        Employee.RESET();
        Employee.SETRANGE("No.", PayRevisionHeader."Employee No.");
        if Employee.FINDFIRST() then;

        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."Employer EPS";

        AccountType := AccountType::"G/L Account";

        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", Text33003Txt);
        if PayRevisionLine.FINDFIRST() then
            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, PayRevisionLine."Arrear Co. Contribution2");
        OnAfterProcessPosting(PayRevisionHeader);
        DeductionPosting(PayRevisionHeader);

        PayRevisionHeader.Posted := true;
        OnBeforePayRevHeadModify(PayRevisionHeader);
        PayRevisionHeader.MODIFY();
    end;

    procedure DeductionPosting(PayRevisionHeader: Record "Pay Revision Header B2B");
    var
        PayRevisionLine: Record "Pay Revision Line B2B";
        "AccountNo.": Code[20];
        AccountType: Option "G/L Account";
        ESIAmt: Decimal;
        PFAmt: Decimal;
        Additions: Decimal;
        Deductions: Decimal;

    begin
        OnBeforeDeduction(PayRevisionHeader);
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        if Employee.FINDFIRST() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        if EmpPostingGroup.FINDFIRST() then
            "AccountNo." := EmpPostingGroup."ESI Payable Acc.";
        AccountType := AccountType::"G/L Account";
        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", Text33002Txt);
        if PayRevisionLine.FINDFIRST() then
            repeat
                ESIAmt := PayRevisionLine."Arrear Amount";
                InitGenJnlLine(
                  PayRevisionLine, "AccountNo.", AccountType,
                  -(PayRevisionLine."Arrear Amount" + PayRevisionLine."Arrear Co. Contribution"));
            until PayRevisionLine.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        if Employee.FINDFIRST() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        if EmpPostingGroup.FINDFIRST() then
            "AccountNo." := EmpPostingGroup."PF Payable Acc.";

        AccountType := AccountType::"G/L Account";
        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", Text33003Txt);
        if PayRevisionLine.FINDFIRST() then
            repeat
                PFAmt := PayRevisionLine."Arrear Amount";
                InitGenJnlLine(
                  PayRevisionLine, "AccountNo.", AccountType,
                  -(PayRevisionLine."Arrear Amount" + PayRevisionLine."Arrear Co. Contribution"));
            until PayRevisionLine.NEXT() = 0;


        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        if Employee.FINDFIRST() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        if EmpPostingGroup.FINDFIRST() then
            "AccountNo." := EmpPostingGroup."EPS Payable Acc.";
        AccountType := AccountType::"G/L Account";

        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", Text33003Txt);
        if PayRevisionLine.FINDFIRST() then
            InitGenJnlLine(
                PayRevisionLine, "AccountNo.", AccountType, -(PayRevisionLine."Arrear Co. Contribution2"));



        Additions := 0;
        Deductions := 0;
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        if Employee.FINDFIRST() then begin
            Employee.TESTFIELD(Employee."Emp Posting Group");
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
            if EmpPostingGroup.FINDFIRST() then
                "AccountNo." := EmpPostingGroup."Arrear Salary Payable Acc.";
            AccountType := AccountType::"G/L Account";
            PayRevisionLine.RESET();
            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
            PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
            PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
            PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Addition);
            if PayRevisionLine.FINDFIRST() then
                repeat
                    Additions := Additions + PayRevisionLine."Arrear Amount";
                until PayRevisionLine.NEXT() = 0;


            PayRevisionLine.RESET();
            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
            PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
            PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
            PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
            if PayRevisionLine.FINDFIRST() then
                repeat
                    Deductions := Deductions + PayRevisionLine."Arrear Amount";
                until PayRevisionLine.NEXT() = 0;

            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, -(Additions - Deductions));
        end;
        OnAfterDeduction(PayRevisionHeader);
    end;

    procedure InitGenJnlLine(var PayRevisionLine: Record "Pay Revision Line B2B"; "AccountNo.": Code[20]; AccountType: Option "G/L Account","Bank Account"; Amount: Decimal);
    var
    begin
        if Amount <> 0 then begin
            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := PayRevisionLine."Journal Template Name";
            GenJnlLine."Journal Batch Name" := PayRevisionLine."Journal Batch Name";
            GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
            if AccountType = AccountType::"Bank Account" then
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account"
            else
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := "AccountNo.";
            GenJnlLine.VALIDATE("Account No.");
            GenJnlLine."Document No." := PayRevisionLine."Document No.";
            GenJnlLine."Posting Date" := PayRevisionLine."Posting Date";
            if AccountType = AccountType::"Bank Account" then
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account"
            else
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine.Amount := Amount;
            GenJnlLine.VALIDATE(Amount);
            GenJnlLine."Source Code" := Text33007Txt;
            //GenJnlLine."Source Type" := GenJnlLine."Source Type"::"10";//Phani
            GenJnlLine."Source No." := PayRevisionLine."No.";
            GenJnlLine."Dimension Set ID" := PayRevisionLine."Dimension Set ID";
            GenJnlLine."Shortcut Dimension 1 Code" := PayRevisionLine."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := PayRevisionLine."Shortcut Dimension 2 Code";
            OnBeforePostJnl(GenJnlLine);
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            OnAfterPostJnl(GenJnlLine);
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeProcessPosting(var PayRevisionHead: Record "Pay Revision Header B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterProcessPosting(var PayRevisionHead: Record "Pay Revision Header B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeDeduction(var PayRevisionHead: Record "Pay Revision Header B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterDeduction(var PayRevisionHead: Record "Pay Revision Header B2B")
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
    procedure OnBeforePayRevHeadModify(var PayRevisionHead: Record "Pay Revision Header B2B")
    begin
    end;
}

