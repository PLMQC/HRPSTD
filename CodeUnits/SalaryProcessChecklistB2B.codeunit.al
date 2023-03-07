codeunit 33001204 "Salary Process Checklist B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        B2BEmpGRec: Record "Employee B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        Window: Dialog;
        Text001Txt: Label 'Process Check List       #1###########', Comment = '%1 = ProList';
        Text002Txt: Label 'Process Check List       #1########### \ Employee                 #2###########', Comment = '%1 = ProList ; %2 = No';
        Text003Txt: Label 'not defined for the Year';
        Text004Txt: Label '1001';
        Text005Txt: Label 'Lookup';
        Text006Txt: Label 'Employee                 #2###########', Comment = '%2 = No';
        Text007Txt: Label '<1M>';
        Text008Txt: Label '"Employment Date not defined for Employee : "';
        Text009Txt: Label 'Pay Elements not defined for Employee :';
        Text0010Txt: Label 'Pay Cadre not defined for Employee :';
        Text0012Txt: Label '2001';
        Text0013Txt: Label 'Employee';
        Text0014Txt: Label '2002';
        Text0015Txt: Label '2003';
        Text0016Txt: Label '2004';
        Text0017Txt: Label '2005';
        Text0018Txt: Label '2006';
        Text0019Txt: Label '2007';
        Text0020Txt: Label '2008';
        Text0021Txt: Label '2009';
        Text0022Txt: Label '2010';
        Text0023Txt: Label '2011';
        Text0024Txt: Label '2012';
        Text0025Txt: Label '2013';
        Text0026Txt: Label '2014';
        Text0028Txt: Label '2016';
        Text0029Txt: Label 'Employee Posting Group not defined for Employee :';
        Text0030Txt: Label 'Business Posting Group not defined for Employee :';
        Text0031Txt: Label 'PT Branch Code not defined for Employee :';
        Text0032Txt: Label 'OT Calculation Rate is 1 for Employee :';
        Text0033Txt: Label 'ESI is not applicable for Employee :';
        Text0034Txt: Label 'PF is not applicable for Employee :';
        Text0035Txt: Label 'VDA is not applicable for Employee :';
        Text0036Txt: Label 'Attendance not generated for Employee :';
        Text0037Txt: Label 'Leaves not generated for Employee :';
        Text0038Txt: Label 'Department Code not defined for Employee :';
        Text0039Txt: Label '"Cash/Bank Account not defined for Employee : "';
        Text0040Txt: Label '"Leave Pay Cadre not defined for Employee : "';
        Text0041Txt: Label 'Installments not created for Loan Code :';
        Text0042Txt: Label 'for Employee :';
        Text0043Txt: Label '3001';
        Text0044Txt: Label 'Loan';
        Text0045Txt: Label 'TDS Schedule has not been computed for Employee No :';
        Text0046Txt: Label '4001';
        Text0047Txt: Label 'TDS Deduction';
        Text0048Txt: Label 'Other Pay Elements are not posted';
        Text0049Txt: Label '5001';
        Text0050Txt: Label 'Other Pay Elements';
        Text0051Txt: Label '<1M>';
        Text0053Txt: Label 'Pay Revision has not been posted for Type :';
        Text0055Txt: Label 'Pay Revision';
        Text0056Txt: Label '<1M-1D>';
        Text0057Txt: Label 'Leave applied but not posted:';
        Text0058Txt: Label '7001';
        Text0060Txt: Label 'Leave Application Cancelled but not posted:';
        Text0061Txt: Label 'Leave Application posted but not Approved:';
        Text0063Txt: Label 'Leaves';
        Text0064Txt: Label '7002';
        Text0065Txt: Label '7003';
        Text0066Txt: Label 'for ID :';
        Text0067Txt: Label '7004';
        Text0068Txt: Label '"Leave Application Cancelled but not Approved: "';

    procedure CheckPayrollYears(ChkListID: Code[20]; ProcessMonth: Integer; ProcessYear: Integer; ChkListDesc: Text[50]);
    var
        PayrollYear: Record "Payroll Year B2B";
        Lookup: Record Lookup_b2b;
        RefDate: Date;
        Remarks: Text[250];
    begin
        Window.OPEN(Text001Txt);
        Window.UPDATE(1, ChkListDesc);
        RefDate := DMY2DATE(1, ProcessMonth, ProcessYear);

        Lookup.RESET();
        Lookup.SETRANGE("Lookup Id", 19);
        if Lookup.FINDFIRST() then
            repeat
                PayrollYear.SETRANGE("Year Type", Lookup."Lookup Name");
                PayrollYear.SETRANGE(Closed, false);
                if not PayrollYear.FINDFIRST() then begin
                    Remarks := Lookup."Lookup Name" + Text003Txt + FORMAT(ProcessYear);
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text004Txt, Remarks, Text005Txt, FORMAT(19));
                end else
                    if not ((RefDate >= PayrollYear."Year Start Date") and (RefDate < PayrollYear."Year End Date")) then begin
                        Remarks := Lookup."Lookup Name" + Text003Txt + FORMAT(ProcessYear);
                        InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text004Txt, Remarks, Text005Txt, FORMAT(19));
                    end;

            until Lookup.NEXT() = 0;
        UpdateErrorStatus(ChkListID, ProcessMonth, ProcessYear);
        Window.CLOSE();
    end;

    procedure CheckNewEmployee(ChkListID: Code[20]; ProcessMonth: Integer; ProcessYear: Integer; ChkListDesc: Text[50]);
    var
        Employee: Record "Employee B2B";
        PayElements: Record "Pay Elements B2B";
        Remarks: Text[250];
    begin
        Window.OPEN(Text001Txt + '\' +
                    Text006Txt);
        Window.UPDATE(1, ChkListDesc);

        PeriodStartDate := DMY2DATE(1, ProcessMonth, ProcessYear);
        PeriodEndDate := CALCDATE(Text007Txt, PeriodStartDate);

        Employee.RESET();
        Employee.SETRANGE(Blocked, false);
        Employee.SETRANGE("Employment Date", PeriodStartDate, PeriodEndDate);
        Employee.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if Employee.FINDFIRST() then
            repeat
                Window.UPDATE(2, Employee."No.");

                if Employee."Employment Date" = 0D then begin
                    Remarks := Text008Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0012Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                PayElements.RESET();
                PayElements.SETRANGE("Employee Code", Employee."No.");
                if PayElements.IsEmpty() then begin
                    Remarks := Text009Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0014Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if Employee."Pay Cadre" = '' then begin
                    Remarks := Text0010Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0015Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if Employee."Emp Posting Group" = '' then begin
                    Remarks := Text0029Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0016Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if Employee."Payroll Bus. Posting Group" = '' then begin
                    Remarks := Text0030Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0017Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if (Employee."PT Applicable") and (Employee."PT Branch Code" = '') then begin
                    Remarks := Text0031Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0018Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if (Employee."OT Applicable") and (Employee."OT Calculation Rate" = 1) then begin
                    Remarks := Text0032Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0019Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if not Employee."ESI Applicable" then begin
                    Remarks := Text0033Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0020Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if not Employee."PF Applicable" then begin
                    Remarks := Text0034Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0021Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if not Employee."VDA Applicable" then begin
                    Remarks := Text0035Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0022Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if Employee."Attendance Not Generated" then begin
                    Remarks := Text0036Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0023Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if Employee."Leaves Not Generated" then begin
                    Remarks := Text0037Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0024Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if Employee."Department Code" = '' then begin
                    Remarks := Text0038Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0025Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if Employee."Bank/Cash Account" = '' then begin
                    Remarks := Text0039Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0026Txt, Remarks, Text0013Txt, Employee."No.");
                end;

                if Employee."Leave Pay Cadre" = '' then begin
                    Remarks := Text0040Txt + Employee."No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0028Txt, Remarks, Text0013Txt, Employee."No.");
                end;
            until Employee.NEXT() = 0;
        Window.CLOSE();
        UpdateErrorStatus(ChkListID, ProcessMonth, ProcessYear);
    end;

    procedure CheckLoanDetails(ChkListID: Code[20]; ProcessMonth: Integer; ProcessYear: Integer; ChkListDesc: Text[50]);
    var
        Loan: Record Loan_B2B;
        LoanDetails: Record "Loan Details B2B";

        Remarks: Text[250];
    begin
        Window.OPEN(Text002Txt);
        Window.UPDATE(1, ChkListDesc);
        B2BEmpGRec.RESET();
        B2BEmpGRec.SETRANGE(Blocked, false);
        B2BEmpGRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if B2BEmpGRec.FINDFIRST() then
            repeat
                Loan.RESET();
                Loan.SETRANGE(Closed, false);
                Loan.SETRANGE("Employee Code", B2BEmpGRec."No.");
                if Loan.FINDFIRST() then
                    repeat
                        Window.UPDATE(2, Loan."Employee Code");
                        LoanDetails.SETRANGE("Loan Id", Loan.Id);
                        if LoanDetails.IsEmpty() then begin
                            Remarks := Text0041Txt + Loan.Id + Text0042Txt + Loan."Employee Code";
                            InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0043Txt, Remarks, Text0044Txt, Loan.Id);
                        end;
                    until Loan.NEXT() = 0;
            until B2BEmpGRec.NEXT() = 0;
        Window.CLOSE();
        UpdateErrorStatus(ChkListID, ProcessMonth, ProcessYear);
    end;

    procedure CheckTDSDetails(ChkListID: Code[20]; ProcessMonth: Integer; ProcessYear: Integer; ChkListDesc: Text[50]);
    var
        EmpTDSDeduction: Record "Emp TDS Deduction B2B";
        EmpTDSSchedule: Record "Emp TDS Schedule B2B";
        Remarks: Text[250];
    begin
        Window.OPEN(Text002Txt);
        Window.UPDATE(1, ChkListDesc);

        B2BEmpGRec.RESET();
        B2BEmpGRec.SETRANGE(Blocked, false);
        B2BEmpGRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if B2BEmpGRec.FINDFIRST() then
            repeat
                EmpTDSDeduction.RESET();
                EmpTDSDeduction.SETFILTER("Tax Liability after savings", '>%1', 0);
                EmpTDSDeduction.SETRANGE("Employee No.", B2BEmpGRec."No.");
                if EmpTDSDeduction.FINDFIRST() then
                    repeat
                        EmpTDSSchedule.SETRANGE("Employee No.", EmpTDSDeduction."Employee No.");
                        if EmpTDSSchedule.IsEmpty() then begin
                            Remarks := Text0045Txt + EmpTDSDeduction."Employee No.";
                            InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0046Txt, Remarks,
                           Text0047Txt, EmpTDSDeduction."Employee No.");
                        end;
                    until EmpTDSDeduction.NEXT() = 0;
            until B2BEmpGRec.NEXT() = 0;
        Window.CLOSE();
        UpdateErrorStatus(ChkListID, ProcessMonth, ProcessYear);
    end;

    procedure CheckOtherPayElements(ChkListID: Code[20]; ProcessMonth: Integer; ProcessYear: Integer; ChkListDesc: Text[50]);
    var
        OtherPayElements: Record "Other PayElements B2B";
        Remarks: Text[250];
    begin
        Window.OPEN(Text001Txt);
        Window.UPDATE(1, ChkListDesc);

        B2BEmpGRec.RESET();
        B2BEmpGRec.SETRANGE(Blocked, false);
        B2BEmpGRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if B2BEmpGRec.FINDFIRST() then
            repeat
                OtherPayElements.RESET();
                OtherPayElements.SETRANGE(Month, ProcessMonth);
                OtherPayElements.SETRANGE(Year, ProcessYear);
                OtherPayElements.SETFILTER(Amount, '<>%1', 0);
                OtherPayElements.SETRANGE("Employee No.", B2BEmpGRec."No.");
                if OtherPayElements.FINDFIRST() then
                    repeat
                        Remarks := Text0048Txt;
                        InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0049Txt, Remarks, Text0050Txt, '');
                    until OtherPayElements.NEXT() = 0;
            until B2BEmpGRec.NEXT() = 0;
        Window.CLOSE();
        UpdateErrorStatus(ChkListID, ProcessMonth, ProcessYear);
    end;

    procedure CheckPayRevisions(ChkListID: Code[20]; ProcessMonth: Integer; ProcessYear: Integer; ChkListDesc: Text[50]);
    var
        PayRevision: Record "Pay Revision Header B2B";
        Remarks: Text[250];
        PeriodStartDateLVar: Date;
        PeriodEndDateLVar: Date;
    begin
        Window.OPEN(Text002Txt);
        Window.UPDATE(1, ChkListDesc);
        PeriodStartDateLVar := DMY2DATE(1, ProcessMonth, ProcessYear);
        PeriodEndDateLVar := CALCDATE(Text0051Txt, PeriodStartDateLVar);

        B2BEmpGRec.RESET();
        B2BEmpGRec.SETRANGE(Blocked, false);
        B2BEmpGRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if B2BEmpGRec.FINDFIRST() then
            repeat
                PayRevision.RESET();
                PayRevision.SETRANGE("Effective Date", PeriodStartDateLVar, PeriodEndDateLVar);
                PayRevision.SETFILTER("Posting Date", '=%1', 0D);
                PayRevision.SETRANGE("Employee No.", B2BEmpGRec."No.");
                if PayRevision.FINDFIRST() then
                    repeat
                        Remarks := Text0053Txt + FORMAT(PayRevision.Type) + Text0066Txt + PayRevision."Id.";
                        InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0051Txt, Remarks, Text0055Txt, PayRevision."Id.");
                    until PayRevision.NEXT() = 0;
            until B2BEmpGRec.NEXT() = 0;
        Window.CLOSE();
        UpdateErrorStatus(ChkListID, ProcessMonth, ProcessYear);
    end;

    procedure CheckLeaves(ChkListID: Code[20]; ProcessMonth: Integer; ProcessYear: Integer; ChkListDesc: Text[50]);
    var
        PostedLeaveAppLine: Record "Posted Leave App Line B2B";
        LeaveAppLine: Record "Leave Application Line B2B";
        Remarks: Text[250];
        FromDate: Date;
        ToDate: Date;

    begin
        Window.OPEN(Text002Txt);
        Window.UPDATE(1, ChkListDesc);

        FromDate := DMY2DATE(1, ProcessMonth, ProcessYear);
        ToDate := CALCDATE(Text0056Txt, FromDate);

        LeaveAppLine.RESET();
        LeaveAppLine.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if LeaveAppLine.FINDFIRST() then
            repeat
                if ((LeaveAppLine."From Date" >= FromDate) and (LeaveAppLine."From Date" <= ToDate))
                  or
                  ((LeaveAppLine."To Date" >= FromDate) and (LeaveAppLine."To Date" <= ToDate)) then begin
                    Remarks := Text0057Txt + Text0066Txt + LeaveAppLine."Document No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0058Txt, Remarks, Text0063Txt,
                    LeaveAppLine."Document No.");
                end;
            until PostedLeaveAppLine.NEXT() = 0;

        PostedLeaveAppLine.RESET();
        PostedLeaveAppLine.SETRANGE("Set For Approval", true);
        PostedLeaveAppLine.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if PostedLeaveAppLine.FINDFIRST() then
            repeat
                if ((PostedLeaveAppLine."From Date" >= FromDate) and (PostedLeaveAppLine."From Date" <= ToDate))
                  or
                  ((PostedLeaveAppLine."To Date" >= FromDate) and (PostedLeaveAppLine."To Date" <= ToDate)) then begin
                    Remarks := Text0061Txt + Text0066Txt + PostedLeaveAppLine."Document No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0064Txt, Remarks, Text0063Txt,
                    PostedLeaveAppLine."Document No.");
                end;
            until PostedLeaveAppLine.NEXT() = 0;

        PostedLeaveAppLine.RESET();
        PostedLeaveAppLine.SETRANGE(Cancel, true);
        PostedLeaveAppLine.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if PostedLeaveAppLine.FINDFIRST() then
            repeat
                if ((PostedLeaveAppLine."From Date" >= FromDate) and (PostedLeaveAppLine."From Date" <= ToDate))
                  or
                  ((PostedLeaveAppLine."To Date" >= FromDate) and (PostedLeaveAppLine."To Date" <= ToDate)) then begin
                    Remarks := Text0060Txt + Text0066Txt + PostedLeaveAppLine."Document No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0065Txt, Remarks, Text0063Txt,
                    PostedLeaveAppLine."Document No.");
                end;
            until PostedLeaveAppLine.NEXT() = 0;

        PostedLeaveAppLine.RESET();
        PostedLeaveAppLine.SETRANGE("Pending For Cancellation", true);
        PostedLeaveAppLine.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if PostedLeaveAppLine.FINDFIRST() then
            repeat
                if ((PostedLeaveAppLine."From Date" >= FromDate) and (PostedLeaveAppLine."From Date" <= ToDate))
                  or
                  ((PostedLeaveAppLine."To Date" >= FromDate) and (PostedLeaveAppLine."To Date" <= ToDate)) then begin
                    Remarks := Text0068Txt + Text0066Txt + PostedLeaveAppLine."Document No.";
                    InsertLogDetails(ChkListID, ProcessMonth, ProcessYear, ChkListDesc, Text0067Txt, Remarks, Text0063Txt,
                    PostedLeaveAppLine."Document No.");
                end;
            until PostedLeaveAppLine.NEXT() = 0;
        Window.CLOSE();
        UpdateErrorStatus(ChkListID, ProcessMonth, ProcessYear);
    end;

    procedure InsertLogDetails(ChkListID: Code[20]; ProcessMonth: Integer; ProcessYear: Integer; ChkListDesc: Text[50]; ChkListSubID: Code[20]; ProcessRemarks: Text[250]; ProcessType: Text[50]; ProcessNo: Code[20]);
    var
        ProcErrorLog: Record "Salary Process Error Log B2B";
        ProcessErrorLog: Record "Salary Process Error Log B2B";
        ProcessLineNo: Integer;
    begin
        ProcessErrorLog.RESET();
        ProcessErrorLog.SETRANGE(Month, ProcessMonth);
        ProcessErrorLog.SETRANGE(Year, ProcessYear);
        ProcessErrorLog.SETRANGE("Checklist ID", ChkListID);
        if ProcessErrorLog.FINDLAST() then
            ProcessLineNo := ProcessErrorLog."Line No"
        else
            ProcessLineNo := 0;

        ProcErrorLog.Month := ProcessMonth;
        ProcErrorLog.Year := ProcessYear;
        ProcErrorLog."Checklist ID" := ChkListID;
        ProcErrorLog.Description := ChkListDesc;
        ProcErrorLog."Checklist Sub ID" := ChkListSubID;
        ProcErrorLog."Line No" := ProcessLineNo + 10000;
        ProcErrorLog.Remarks := ProcessRemarks;
        ProcErrorLog.Type := ProcessType;
        ProcErrorLog.No := ProcessNo;
        ProcErrorLog."Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();
        ProcErrorLog.INSERT();
    end;

    procedure UpdateErrorStatus(ChkListID: Code[20]; ProcessMonth: Integer; ProcessYear: Integer);
    var
        ProcessErrorLog: Record "Salary Process Error Log B2B";
        CheckList: Record "Salary Process Check List B2B";
        ErrorCount: Integer;
    begin
        CLEAR(ErrorCount);
        CheckList.RESET();
        CheckList.SETRANGE(Year, ProcessYear);
        CheckList.SETRANGE(Month, ProcessMonth);
        CheckList.SETRANGE(ID, ChkListID);
        CheckList.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if CheckList.FINDFIRST() then
            repeat
                ProcessErrorLog.RESET();
                ProcessErrorLog.SETRANGE(Year, ProcessYear);
                ProcessErrorLog.SETRANGE(Month, ProcessMonth);
                ProcessErrorLog.SETRANGE("Checklist ID", ChkListID);
                ProcessErrorLog.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                if ProcessErrorLog.FINDFIRST() then
                    repeat
                        ErrorCount += 1;
                    until ProcessErrorLog.NEXT() = 0;
                if ErrorCount > 0 then begin
                    CheckList.Status := CheckList.Status::ErrorLog;
                    CheckList.LogCount := ErrorCount;
                    CheckList.MODIFY();
                end else begin
                    CheckList.Status := CheckList.Status::"Not Started";
                    CheckList.LogCount := ErrorCount;
                    CheckList.MODIFY();
                end;
            until CheckList.NEXT() = 0;
    end;

    procedure UpdateLogCount(ProcessYear: Integer; ProcessMonth: Integer);
    var
        CheckList: Record "Salary Process Check List B2B";
        SubCheckList: Record "Salary Process Check List B2B";
        ProcErrorLog: Record "Salary Process Error Log B2B";
        ErrorCount: Integer;
    begin
        CheckList.RESET();
        CheckList.SETRANGE(Year, ProcessYear);
        CheckList.SETRANGE(Month, ProcessMonth);
        CheckList.SETRANGE(Level, 0);
        CheckList.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if CheckList.FINDFIRST() then
            repeat
                SubCheckList.RESET();
                SubCheckList.SETRANGE(Year, ProcessYear);
                SubCheckList.SETRANGE(Month, ProcessMonth);
                SubCheckList.SETRANGE("Parent Ref ID", CheckList.ID);
                SubCheckList.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                if SubCheckList.FINDFIRST() then
                    repeat
                        CLEAR(ErrorCount);
                        ProcErrorLog.RESET();
                        ProcErrorLog.SETRANGE(Year, ProcessYear);
                        ProcErrorLog.SETRANGE(Month, ProcessMonth);
                        ProcErrorLog.SETRANGE("Checklist ID", SubCheckList."Parent Ref ID");
                        ProcErrorLog.SETRANGE("Checklist Sub ID", SubCheckList."Sub ID");
                        ProcErrorLog.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                        if ProcErrorLog.FINDFIRST() then
                            repeat
                                ErrorCount += 1;
                            until ProcErrorLog.NEXT() = 0;
                        SubCheckList.LogCount := ErrorCount;
                        SubCheckList.MODIFY();
                    until SubCheckList.NEXT() = 0;
            until CheckList.NEXT() = 0;
    end;
}

