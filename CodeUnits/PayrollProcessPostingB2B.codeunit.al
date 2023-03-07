codeunit 33001198 "Payroll Process Posting B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        Employee: Record "Employee B2B";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        Lookup: Record Lookup_b2b;
        Lookup2: Record Lookup_b2b;
        AddLookup: Record Lookup_b2b;
        DedLookup: Record Lookup_b2b;
        CrLookup: Record Lookup_b2b;
        EmployerPostingGroupEmp: Record "Employer Stat. Post. Group B2B";
        CrPayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        AddProcSalary: Record "Processed Salary B2B";
        DedProcSalary: Record "Processed Salary B2B";
        AddProcessedSalary: Record "Processed Salary B2B";
        DedProcessedSalary: Record "Processed Salary B2B";
        CrProcSalary: Record "Processed Salary B2B";
        Loan: Record Loan_B2B;
        LoanPostingGroup: Record "Loan Posting Groups B2B";
        EMPTDSMonthlySchedule: Record "EMP TDS Monthly Schedule B2B";
        TDSSalDet: Record "TDS Salary Details B2B";
        PayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Text000Txt: Label 'Account  in General posting group should be defined for pay element %1.', Comment = '%1 = Payelement';
        Text001Txt: Label 'Pay Product Posting group/PayElement  is not defined for the pay element %1 in Lookup.', Comment = '%1 = Payelement';
        BusinessPosting: Code[20];
        ProductPosting: Code[20];
        Text003Txt: Label 'Processed Pay Element is not defined  in the Lookup %1.', Comment = '%1 = PayElement';
        PayBusiness: Code[20];
        PayElement: Code[20];
        Text004Txt: Label 'Business  Posting Group not defined to Employee %1.', Comment = '%1 = PayElement';
        Text33001Txt: Label 'ADDITIONS AND DEDUCTIONS';
        Text33002Txt: Label 'LOAN';
        Text33003Txt: Label 'Loan';
        Text33004Txt: Label 'ESI';
        Text33005Txt: Label 'PF';
        Text33006Txt: Label 'PT';
        Text33007Txt: Label 'TDS';
        Text33008Txt: Label 'VPF';
        Text33009Txt: Label 'BONUS';
        Text33010Txt: Label 'GENJNL';
        Text33011Txt: Label 'Jan';
        Text33012Txt: Label 'Febuary';
        Text33013Txt: Label 'March';
        Text33014Txt: Label 'April';
        Text33015Txt: Label 'May';
        Text33016Txt: Label 'June';
        Text33017Txt: Label 'July';
        Text33018Txt: Label 'August';
        Text33019Txt: Label 'Septmeber';
        Text33020Txt: Label 'October';
        Text33021Txt: Label 'November';
        Text33022Txt: Label 'December';

    procedure ProcessPosting(MonthlyAttendance: Record "Monthly Attendance B2B");
    var

        PayrollBusinessPosting: Record "Payroll Bus. Post Group B2B";
        CrPayBusinessPosting: Record "Payroll Bus. Post Group B2B";
        PayrollProductPosting: Record "Payroll Prod. Post. Group B2B";
        CrPayrollProductPosting: Record "Payroll Prod. Post. Group B2B";
        AddPayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        AddPayrollBusinessPosting: Record "Payroll Bus. Post Group B2B";
        DedPayrollGeneralPosting: Record "Payroll Gen. Posting Group B2B";
        DedPayrollBusinessPosting: Record "Payroll Bus. Post Group B2B";

        LWFSetupLRec: Record "LWF Setup B2B";
        "AccountNo.": Code[20];
        AccountType: Option "G/L Account";

    begin
        MonthlyAttendance.TESTFIELD("Document No.");
        MonthlyAttendance.TESTFIELD("Posting Date");
        MonthlyAttendance.TESTFIELD("Journal Batch Name");

        OnBeforeProcessPosting(MonthlyAttendance);

        AddProcSalary.SETCURRENTKEY("Add/Deduct", AddProcSalary."Add/Deduct Code");
        AddProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        AddProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        AddProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        AddProcSalary.SETRANGE("Add/Deduct", AddProcSalary."Add/Deduct"::Addition);
        if AddProcSalary.FINDSET() then
            repeat
                AddLookup.RESET();
                if AddLookup.FINDSET() then
                    repeat
                        AddLookup.SETRANGE("LookupType Name", Text33001Txt);
                        AddLookup.SETRANGE("Add/Deduct", AddLookup."Add/Deduct"::Addition);
                        AddLookup.SETRANGE(AddLookup."Lookup Name", AddProcSalary."Add/Deduct Code");
                        if not AddLookup.FINDSET() then
                            ERROR(Text001Txt, AddProcSalary."Add/Deduct Code");
                    until AddLookup.NEXT() = 0;
            until AddProcSalary.NEXT() = 0;


        DedProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        DedProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        DedProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        DedProcSalary.SETRANGE("Add/Deduct", DedProcSalary."Add/Deduct"::Deduction);
        DedProcSalary.SETFILTER("Computation Type", '<>%1', Text33002Txt);
        if DedProcSalary.FINDSET() then
            repeat
                if (DedProcSalary."Add/Deduct Code" <> Text33004Txt) and (DedProcSalary."Add/Deduct Code" <> Text33005Txt) and
                   (DedProcSalary."Add/Deduct Code" <> Text33006Txt) and (DedProcSalary."Add/Deduct Code" <> Text33003Txt) and
                   (DedProcSalary."Add/Deduct Code" <> Text33007Txt) and (DedProcSalary."Add/Deduct Code" <> Text33008Txt)
                then
                    if DedLookup.FINDSET() then
                        repeat
                            DedLookup.SETRANGE("LookupType Name", Text33001Txt);
                            DedLookup.SETRANGE("Add/Deduct", DedLookup."Add/Deduct"::Deduction);
                            DedLookup.SETRANGE("Lookup Name", DedProcSalary."Add/Deduct Code");
                            if not DedLookup.FINDSET() then
                                ERROR(Text001Txt, DedProcSalary."Add/Deduct Code");
                        until DedLookup.NEXT() = 0;

            until DedProcSalary.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            AddProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        AddProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        AddProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        AddProcessedSalary.SETRANGE("Add/Deduct", AddProcessedSalary."Add/Deduct"::Addition);
        if AddProcessedSalary.FINDSET() then
            repeat
                if AddPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then begin
                    AddPayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", AddPayrollBusinessPosting.Code);
                    if AddPayrollGeneralPosting.FINDSET() then
                        PayBusiness := AddPayrollGeneralPosting."Payroll Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", Text33001Txt);
                    Lookup2.SETRANGE("Lookup Name", AddProcessedSalary."Add/Deduct Code");
                    Lookup2.SETRANGE("Add/Deduct", Lookup2."Add/Deduct"::Addition);
                    if Lookup2.FINDSET() then begin
                        Lookup2.TESTFIELD("Payroll Prod. Posting Group");
                        PayElement := Lookup2."Payroll Prod. Posting Group"
                    end else
                        ERROR(Text003Txt, Lookup2."Lookup Name");
                    AddPayrollGeneralPosting.SETRANGE("Payroll Prod. Posting Group", PayElement);
                    if AddPayrollGeneralPosting.IsEmpty() then
                        ERROR(Text000Txt, PayElement);
                end else
                    ERROR(Text004Txt, Employee."No.");
            until AddProcessedSalary.NEXT() = 0;



        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            DedProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        DedProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        DedProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        DedProcessedSalary.SETRANGE("Add/Deduct", DedProcessedSalary."Add/Deduct"::Deduction);
        DedProcessedSalary.SETFILTER("Computation Type", '<>%1', Text33002Txt);
        if DedProcessedSalary.FINDSET() then
            repeat
                if (DedProcessedSalary."Add/Deduct Code" <> Text33004Txt) and (DedProcessedSalary."Add/Deduct Code" <> Text33005Txt) and
                 (DedProcessedSalary."Add/Deduct Code" <> Text33006Txt) and (DedProcessedSalary."Add/Deduct Code" <> Text33003Txt) and
                 (DedProcessedSalary."Add/Deduct Code" <> Text33007Txt) and (DedProcessedSalary."Add/Deduct Code" <> Text33008Txt)
                then begin

                    if DedPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then
                        DedPayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", DedPayrollBusinessPosting.Code);
                    if DedPayrollGeneralPosting.FINDSET() then
                        PayBusiness := DedPayrollGeneralPosting."Payroll Bus. Posting Group";
                    Lookup2.SETRANGE("LookupType Name", Text33001Txt);
                    Lookup2.SETRANGE("Lookup Name", DedProcessedSalary."Add/Deduct Code");
                    Lookup2.SETRANGE("Add/Deduct", Lookup2."Add/Deduct"::Deduction);
                    if Lookup2.FINDSET() then begin
                        Lookup2.TESTFIELD("Payroll Prod. Posting Group");
                        PayElement := Lookup2."Payroll Prod. Posting Group"
                    end else
                        ERROR(Text003Txt, Lookup2."Lookup Name");

                    DedPayrollGeneralPosting.SETRANGE("Payroll Prod. Posting Group", PayElement);
                    if DedPayrollGeneralPosting.IsEmpty() then
                        ERROR(Text000Txt, PayElement);
                end;
            until DedProcessedSalary.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            repeat
                if PayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then;
                BusinessPosting := PayrollBusinessPosting.Code;
                ProcessedSalary.Reset();
                ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
                ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
                ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                if ProcessedSalary.FINDSET() then
                    repeat
                        Lookup.SETFILTER("LookupType Name", Text33001Txt);
                        Lookup.SETRANGE("Lookup Name", ProcessedSalary."Add/Deduct Code");
                        if Lookup.FINDSET() then begin
                            "AccountNo." := '';
                            if PayrollProductPosting.GET(Lookup."Payroll Prod. Posting Group") then;
                            ProductPosting := PayrollProductPosting.Code;
                            PayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", BusinessPosting);
                            PayrollGeneralPosting.SETRANGE("Payroll Prod. Posting Group", ProductPosting);
                            if PayrollGeneralPosting.FINDSET() then begin
                                "AccountNo." := PayrollGeneralPosting."G/L Code";
                                AccountType := AccountType::"G/L Account";
                            end;
                            ProcessedSalary."Account No." := "AccountNo.";
                            ProcessedSalary.MODIFY();
                            InitGenJnlLine(
                              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                              "AccountNo.", AccountType, ProcessedSalary."Earned Amount");
                        end;
                    until ProcessedSalary.NEXT() = 0;

            until Employee.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            repeat
                if CrPayBusinessPosting.GET(Employee."Payroll Bus. Posting Group") then;
                BusinessPosting := PayrollBusinessPosting.Code;
                CrProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
                CrProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
                CrProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
                CrProcSalary.SETRANGE("Add/Deduct", CrProcSalary."Add/Deduct"::Deduction);
                CrProcSalary.SETFILTER("Computation Type", '<>%1', Text33002Txt);
                if CrProcSalary.FINDSET() then
                    repeat
                        if (CrProcSalary."Add/Deduct Code" <> Text33004Txt) and (CrProcSalary."Add/Deduct Code" <> Text33005Txt) and
                           (CrProcSalary."Add/Deduct Code" <> Text33006Txt) and (CrProcSalary."Add/Deduct Code" <> Text33003Txt) and
                           (CrProcSalary."Add/Deduct Code" <> Text33007Txt) and (CrProcSalary."Add/Deduct Code" <> Text33008Txt)
                        then begin
                            CrLookup.SETFILTER("LookupType Name", Text33001Txt);
                            CrLookup.SETRANGE("Lookup Name", CrProcSalary."Add/Deduct Code");
                            if CrLookup.FINDSET() then begin
                                "AccountNo." := '';
                                if CrPayrollProductPosting.GET(CrLookup."Payroll Prod. Posting Group") then;
                                ProductPosting := CrPayrollProductPosting.Code;
                                CrPayrollGeneralPosting.SETRANGE("Payroll Bus. Posting Group", BusinessPosting);
                                CrPayrollGeneralPosting.SETRANGE("Payroll Prod. Posting Group", ProductPosting);
                                if CrPayrollGeneralPosting.FINDSET() then begin
                                    "AccountNo." := CrPayrollGeneralPosting."G/L Code";
                                    AccountType := AccountType::"G/L Account";
                                end;
                                CrProcSalary."Account No." := "AccountNo.";
                                CrProcSalary.MODIFY();
                                InitGenJnlLine(
                                  CrProcSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                                  "AccountNo.", AccountType, -CrProcSalary."Earned Amount");
                            end;
                        end;
                    until CrProcSalary.NEXT() = 0;

            until Employee.NEXT() = 0;



        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDFIRST() then;
        "AccountNo." := '';
        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."Employer ESI";

        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33004Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, ProcessedSalary."Co. Contributions");
            until ProcessedSalary.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDFIRST() then;
        "AccountNo." := '';
        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."Employer PF";

        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, ProcessedSalary."Co. Contributions");
            until ProcessedSalary.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDFIRST() then;
        "AccountNo." := '';
        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."LWF Account";

        LWFSetupLRec.RESET();
        LWFSetupLRec.SETRANGE(Type, LWFSetupLRec.Type::Employee);
        LWFSetupLRec.SETFILTER("Effective Date", '<=%1', MonthlyAttendance."Period End Date");
        if LWFSetupLRec.FINDLAST() then
            LWFSetupLRec.TESTFIELD(LWFSetupLRec."Pay Element Code");

        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", LWFSetupLRec."Pay Element Code");
        if ProcessedSalary.FINDSET() then
            repeat
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, ProcessedSalary."Co. Contributions");
            until ProcessedSalary.NEXT() = 0;

        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDFIRST() then;
        "AccountNo." := '';
        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."Employer EPS";

        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, ProcessedSalary."Co. Contribution2");
            until ProcessedSalary.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDFIRST() then;
        "AccountNo." := '';
        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."PF Admin. Charges";

        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, ProcessedSalary."PF Admin Charges");
            until ProcessedSalary.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDFIRST() then;
        "AccountNo." := '';
        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."EDLI Charges";

        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, ProcessedSalary."EDLI Charges");
            until ProcessedSalary.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDFIRST() then;
        "AccountNo." := '';
        EmployerPostingGroupEmp.RESET();
        EmployerPostingGroupEmp.SETRANGE(Code, Employee."Employee StatutoryPostingGroup");
        if EmployerPostingGroupEmp.FINDFIRST() then
            "AccountNo." := EmployerPostingGroupEmp."RIFA Charges";

        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, ProcessedSalary."RIFA Charges");
            until ProcessedSalary.NEXT() = 0;

        OnAfterProcessPosting(MonthlyAttendance);

        Deductions(MonthlyAttendance);
    end;

    procedure Deductions(MonthlyAttendance: Record "Monthly Attendance B2B");
    var

        LWFSetupLRec: Record "LWF Setup B2B";
        "AccountNo.": Code[20];
        AccountType: Option "G/L Account";
        ESIAmt: Decimal;
        PFAmt: Decimal;
        PTAmt: Decimal;
        Additions: Decimal;
        DeductionsLVar: Decimal;

    begin
        OnBeforeDeduction(MonthlyAttendance);

        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."ESI Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33004Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                ESIAmt := ProcessedSalary."Earned Amount";
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -(ProcessedSalary."Earned Amount" + ProcessedSalary."Co. Contributions"));
            until ProcessedSalary.NEXT() = 0;


        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."PF Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                PFAmt := ProcessedSalary."Earned Amount";
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -(ProcessedSalary."Earned Amount" + ProcessedSalary."Co. Contributions"));
            until ProcessedSalary.NEXT() = 0;

        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."LWF Payable Acc.";
        AccountType := AccountType::"G/L Account";
        LWFSetupLRec.RESET();
        LWFSetupLRec.SETRANGE(Type, LWFSetupLRec.Type::Employee);
        LWFSetupLRec.SETFILTER("Effective Date", '<=%1', MonthlyAttendance."Period End Date");
        if LWFSetupLRec.FINDLAST() then
            LWFSetupLRec.TESTFIELD(LWFSetupLRec."Pay Element Code");

        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", LWFSetupLRec."Pay Element Code");
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -ProcessedSalary."Co. Contributions");
            until ProcessedSalary.NEXT() = 0;

        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."EPS Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -ProcessedSalary."Co. Contribution2");
            until ProcessedSalary.NEXT() = 0;


        Loan.SETRANGE(Loan."Employee Code", MonthlyAttendance."Employee Code");
        if Loan.FINDSET() then
            repeat
                Loan.TESTFIELD("Loan Posting Group");
                LoanPostingGroup.SETRANGE(Code, Loan."Loan Posting Group");
                LoanPostingGroup.FINDSET();
                LoanPostingGroup.TESTFIELD("Loan Refundable Acc.");
                "AccountNo." := LoanPostingGroup."Loan Refundable Acc.";
                AccountType := AccountType::"G/L Account";
                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
                ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
                ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
                ProcessedSalary.SETRANGE("Computation Type", Text33003Txt);
                ProcessedSalary.SETRANGE("Loan Id", Loan.Id);
                ProcessedSalary.SETRANGE("Add/Deduct Code", Loan."Loan Type");
                if ProcessedSalary.FINDSET() then
                    repeat
                        ProcessedSalary."Account No." := "AccountNo.";
                        ProcessedSalary.MODIFY();
                        InitGenJnlLine(
                          ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                          MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                          "AccountNo.", AccountType, -ProcessedSalary."Earned Amount");
                    until ProcessedSalary.NEXT() = 0;

            until Loan.NEXT() = 0;

        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."PT Payable Account";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33006Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                PTAmt := ProcessedSalary."Earned Amount";
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -ProcessedSalary."Earned Amount");
            until ProcessedSalary.NEXT() = 0;


        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then begin
            EmpPostingGroup.TESTFIELD("VPF Payable Acc.");
            "AccountNo." := EmpPostingGroup."VPF Payable Acc.";
        end;
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33008Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                PTAmt := ProcessedSalary."Earned Amount";
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -ProcessedSalary."Earned Amount");
            until ProcessedSalary.NEXT() = 0;


        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."TDS Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33007Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -ProcessedSalary."Earned Amount");


                EMPTDSMonthlySchedule.RESET();
                EMPTDSMonthlySchedule.SETRANGE("Emp ID", ProcessedSalary."Employee Code");
                EMPTDSMonthlySchedule.SETRANGE("Payslip Month", ProcessedSalary."Pay Slip Month");
                EMPTDSMonthlySchedule.SETRANGE("Payslip Year", ProcessedSalary.Year);
                if EMPTDSMonthlySchedule.FINDSET() then begin
                    EMPTDSMonthlySchedule."TDS Amount Deducted" := ProcessedSalary."Earned Amount";
                    EMPTDSMonthlySchedule.MODIFY();

                end;

                TDSSalDet.INIT();
                TDSSalDet."Employee Code" := ProcessedSalary."Employee Code";
                TDSSalDet.Month := ProcessedSalary."Pay Slip Month";
                TDSSalDet.Year := ProcessedSalary.Year;
                TDSSalDet."TDS Amount" := ProcessedSalary."Earned Amount";
                TDSSalDet."Location Code" := ProcessedSalary."Location Code";
                TDSSalDet."Sal. Posting Date" := MonthlyAttendance."Posting Date";
                TDSSalDet."Sal. Posting Document No." := MonthlyAttendance."Document No.";
                TDSSalDet.INSERT();
            until ProcessedSalary.NEXT() = 0;


        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."Bonus Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33009Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -ProcessedSalary."Earned Amount");
            until ProcessedSalary.NEXT() = 0;


        Additions := 0;
        DeductionsLVar := 0;
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then begin
            Employee.TESTFIELD(Employee."Emp Posting Group");
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
            "AccountNo." := '';
            if EmpPostingGroup.FINDSET() then
                "AccountNo." := EmpPostingGroup."Salary Payable Acc.";
            AccountType := AccountType::"G/L Account";
            ProcessedSalary.RESET();
            ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
            ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
            ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
            ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
            if ProcessedSalary.FINDSET() then
                repeat
                    Additions := Additions + ProcessedSalary."Earned Amount";
                until ProcessedSalary.NEXT() = 0;

            ProcessedSalary.RESET();
            ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
            ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
            ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
            ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
            if ProcessedSalary.FINDSET() then
                repeat
                    DeductionsLVar := DeductionsLVar + ProcessedSalary."Earned Amount";
                until ProcessedSalary.NEXT() = 0;

            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -(Additions - DeductionsLVar));

        end;

        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."PF Admin Charge Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -ProcessedSalary."PF Admin Charges");
            until ProcessedSalary.NEXT() = 0;



        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."EDLI Charges Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -ProcessedSalary."EDLI Charges");
            until ProcessedSalary.NEXT() = 0;


        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        if Employee.FINDSET() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        "AccountNo." := '';
        if EmpPostingGroup.FINDSET() then
            "AccountNo." := EmpPostingGroup."RIFA Charges Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", Text33005Txt);
        if ProcessedSalary.FINDSET() then
            repeat
                ProcessedSalary."Account No." := "AccountNo.";
                ProcessedSalary.MODIFY();
                InitGenJnlLine(
                  ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                  "AccountNo.", AccountType, -ProcessedSalary."RIFA Charges");
            until ProcessedSalary.NEXT() = 0;
        OnAfterDeduction(MonthlyAttendance);
    end;

    procedure InitGenJnlLine(var ProcessedSalary: Record "Processed Salary B2B"; JournalTemplate: Code[10]; JournalBatch: Code[10]; "DocumentNo.": Code[20]; PostDate: Date; "AccountNo.": Code[20];
                 AccountType: Option "G/L Account","Bank Account"; Amount: Decimal);
    var
        EmpLRec: Record "Employee B2B";

    begin
        if Amount <> 0 then begin
            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := JournalTemplate;
            GenJnlLine."Journal Batch Name" := JournalBatch;
            GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
            GenJnlLine.Insert(true);
            if AccountType = AccountType::"Bank Account" then
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account"
            else
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := "AccountNo.";
            GenJnlLine.VALIDATE("Account No.");
            GenJnlLine."Document No." := "DocumentNo.";
            if EmpLRec.GET(ProcessedSalary."Employee Code") then
                GenJnlLine."Currency Code" := EmpLRec."Currency Code";
            GenJnlLine."Posting Date" := PostDate;
            GenJnlLine.Description :=
               ProcessedSalary."Employee Code" + ' ' + COPYSTR(GenJnlLine.Description, 1, 20) + ' ' +
               ReturnMonth(ProcessedSalary."Pay Slip Month") + ' ' +
               FORMAT(ProcessedSalary.Year);
            if AccountType = AccountType::"Bank Account" then
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account"
            else
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine.Amount := Amount;
            GenJnlLine.VALIDATE(Amount);
            GenJnlLine."Source Code" := Text33010Txt;
            //GenJnlLine."Source Type" := GenJnlLine."Source Type"::"10";//Phani
            GenJnlLine."Source No." := EmpLRec."No.";
            GenJnlLine."Dimension Set ID" := ProcessedSalary."Dimension Set ID";
            GenJnlLine.Validate("Shortcut Dimension 1 Code", ProcessedSalary."Shortcut Dimension 1 Code");
            GenJnlLine.Validate("Shortcut Dimension 2 Code", ProcessedSalary."Shortcut Dimension 2 Code");
            GenJnlLine.Modify(true);
            OnBeforePostJnl(GenJnlLine);
            //GenJnlPostLine.RunWithCheck(GenJnlLine);
            OnAfterPostJnl(GenJnlLine);
            //OnAfterPostJnl
        end;
    end;

    procedure Rounding(Amount: Decimal) "Final Amount": Decimal;
    var
        HRSetup: Record "HR Setup B2B";
        "Rounding Precision": Decimal;
        "Rounding Direction": Text[30];
    begin
        if HRSetup.FINDLAST() then begin
            "Rounding Precision" := HRSetup."Rounding Precision";
            case HRSetup."Rounding Type" of
                0:
                    "Rounding Direction" := '=';
                1:
                    "Rounding Direction" := '>';
                2:
                    "Rounding Direction" := '<';
            end;
            "Final Amount" := ROUND(Amount, "Rounding Precision", "Rounding Direction");
        end;
    end;

    procedure ReturnMonth(Month: Integer): Code[20];
    begin
        case Month of
            1:
                exit(Text33011Txt);
            2:
                exit(Text33012Txt);
            3:
                exit(Text33013Txt);
            4:
                exit(Text33014Txt);
            5:
                exit(Text33015Txt);
            6:
                exit(Text33016Txt);
            7:
                exit(Text33017Txt);
            8:
                exit(Text33018Txt);
            9:
                exit(Text33019Txt);
            10:
                exit(Text33020Txt);
            11:
                exit(Text33021Txt);
            12:
                exit(Text33022Txt);
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeProcessPosting(var MonthlyAttedance: Record "Monthly Attendance B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterProcessPosting(var MonthlyAttedance: Record "Monthly Attendance B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeDeduction(var MonthlyAttedance: Record "Monthly Attendance B2B")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterDeduction(var MonthlyAttedance: Record "Monthly Attendance B2B")
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
}

