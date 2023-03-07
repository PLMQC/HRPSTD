table 33001228 Loan_B2B
{
    // version B2BHR1.00.00

    Caption = 'Loan';
    DrillDownPageID = "Loan List B2B";
    LookupPageID = "Loan List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Code[20])
        {
            Caption = 'Id';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckInstallments();
            end;
        }
        field(3; "Loan Type"; Code[50])
        {
            Caption = 'Loan Type';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                Lookup3.DELETEALL();

                Employee.SETRANGE("No.", "Employee Code");
                if Employee.FINDFIRST() then begin
                    Lookup2.RESET();
                    Lookup2.SETRANGE("LookupType Name", LOANTYPESTxt);
                    if Lookup2.FINDFIRST() then
                        repeat
                            if (Lookup2.Grade = Employee."Pay Cadre") or (Lookup2."All Grades" = true) then begin
                                Lookup3.INIT();
                                Lookup3.TRANSFERFIELDS(Lookup2);
                                Lookup3.INSERT();
                            end;
                        until Lookup2.NEXT() = 0;

                end;

                if Lookup3.FINDFIRST() then begin
                    if PAGE.RUNMODAL(0, Lookup3) = ACTION::LookupOK then begin
                        CheckInstallments();
                        "Loan Type" := Lookup3."Lookup Name";
                        "No of Installments" := Lookup3."Max.No. of instalments";
                        "Loan Priority No" := Lookup3."Loan Priority No.";
                    end;
                end else
                    ERROR(Text000Lbl);
            end;

            trigger OnValidate();
            begin
                CheckInstallments();
                Lookup3.DELETEALL();

                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE("LookupType Name", LOANTYPESTxt);
                Lookup_B2B.SETRANGE("Lookup Name", "Loan Type");
                if Lookup_B2B.FINDFIRST() then
                    "Loan Priority No" := Lookup_B2B."Loan Priority No.";
            end;
        }
        field(4; "Loan Amount"; Decimal)
        {
            Caption = 'Loan Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                GrossAmount: Decimal;
            begin
                CheckInstallments();
                PayElements.RESET();
                if PayElements.FINDFIRST() then
                    repeat
                        PayElements.Processed := false;
                        PayElements.MODIFY();
                    until PayElements.NEXT() = 0;

                Employee.RESET();
                Employee.SETRANGE("No.", "Employee Code");
                if Employee.FINDFIRST() then begin
                    Lookup_B2B.RESET();
                    Lookup_B2B.SETRANGE("LookupType Name", LOANTYPESTxt);
                    Lookup_B2B.SETRANGE("Lookup Name", "Loan Type");
                    if Lookup_B2B.FINDFIRST() then
                        if Lookup_B2B."Max.Amt.Type" = Lookup_B2B."Max.Amt.Type"::Amount then
                            if "Loan Amount" > Lookup_B2B."Max.Amt" then
                                ERROR(Text001Lbl, Lookup_B2B."Max.Amt")
                            else
                                if Lookup_B2B."Max.Amt.Type" = Lookup_B2B."Max.Amt.Type"::"Gross Salary" then begin
                                    GrossAmount := CalcGrossAmount(Employee) * Lookup_B2B."Max.Amt";
                                    if "Loan Amount" > GrossAmount then
                                        ERROR(Text001Lbl, GrossAmount);
                                end;

                end;
                "Loan Balance" := "Loan Amount";
            end;
        }
        field(5; "Loan Balance"; Decimal)
        {
            Caption = 'Loan Balance';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(6; "Interest Method"; Option)
        {
            Caption = 'Interest Method';
            OptionCaption = 'Interest Free,Flat Rate,Dimnishing Rate';
            OptionMembers = "Interest Free","Flat Rate","Dimnishing Rate";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckInstallments();
            end;
        }
        field(7; "Loan Start Date"; Date)
        {
            Caption = 'Loan Start Date';
            DataClassification = CustomerContent;
            trigger OnValidate();
            var
                Months: DateFormula;
                MonthinText: Text[30];
                EndDate: Date;
            begin
                CheckDateAvail();
                CheckInstallments();
                MonthinText := FORMAT("No of Installments");
                EVALUATE(Months, MonthinText + 'M');
                if "Loan Start Date" <> 0D then
                    if "No of Installments" = 0 then
                        "Loan End Date" := "Loan Start Date"
                    else begin
                        EndDate := CALCDATE(Months, "Loan Start Date");
                        "Loan End Date" := CALCDATE(OneMonthLessExprLbl, EndDate);
                    end;

            end;
        }
        field(8; "No Deduction Request"; Boolean)
        {
            Caption = 'No Deduction Request';
            DataClassification = CustomerContent;
        }
        field(9; "Carry Over"; Boolean)
        {
            Caption = 'Carry Over';
            DataClassification = CustomerContent;
        }
        field(10; "Partial Deduction"; Boolean)
        {
            Caption = 'Partial Deduction';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if not "Partial Deduction" then
                    "Partial Dedecting Amount" := 0;
            end;
        }
        field(11; "Is it in Carry"; Boolean)
        {
            Caption = 'Is it in Carry';
            DataClassification = CustomerContent;
        }
        field(12; "Loan Priority No"; Integer)
        {
            Caption = 'Loan Priority No';
            DataClassification = CustomerContent;
        }
        field(13; "Loan From"; Text[50])
        {
            Caption = 'Loan From';
            DataClassification = CustomerContent;
        }
        field(14; "Loan Ref No."; Code[50])
        {
            Caption = 'Loan Ref No.';
            DataClassification = CustomerContent;
        }
        field(15; "Loan Ref Date"; Date)
        {
            Caption = 'Loan Ref Date';
            DataClassification = CustomerContent;
        }
        field(16; "Effective Amount"; Decimal)
        {
            Caption = 'Effective Amount';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;

            trigger OnValidate();
            begin
                if "Effective Amount" > "Loan Balance" then
                    ERROR(Text004Lbl);
            end;
        }
        field(17; "Actual Amount"; Decimal)
        {
            CalcFormula = Sum("Loan Details B2B"."EMI Amount" WHERE("Employee No." = FIELD("Employee Code"),
                                                                 "Loan Code" = FIELD("Loan Type"),
                                                                 Month = FIELD(Month),
                                                                 Year = FIELD(Year)));
            Caption = 'Actual Amount';
            FieldClass = FlowField;
        }
        field(19; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(20; "Installment Amount"; Decimal)
        {
            Caption = 'Installment Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(22; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Loan';
            OptionMembers = " ",Loan;
            DataClassification = CustomerContent;
        }
        field(23; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate';
            DataClassification = CustomerContent;
        }
        field(24; "No of Installments"; Integer)
        {
            Caption = 'No of Installments';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Months: DateFormula;
                MoninText: Text[30];
                EndDate: Date;
            begin
                CheckInstallments();
                Employee.RESET();
                Employee.SETRANGE("No.", "Employee Code");
                if Employee.FINDFIRST() then begin
                    Lookup_B2B.RESET();
                    Lookup_B2B.SETRANGE("LookupType Name", LOANTYPESTxt);
                    Lookup_B2B.SETRANGE("Lookup Name", "Loan Type");
                    if Lookup_B2B.FINDFIRST() then
                        if "No of Installments" > Lookup_B2B."Max.No. of instalments" then
                            ERROR(Text002Lbl, Lookup_B2B."Max.No. of instalments");

                end;

                MoninText := FORMAT("No of Installments");
                EVALUATE(Months, MoninText + 'M');
                if "Loan Start Date" <> 0D then begin
                    EndDate := CALCDATE(Months, "Loan Start Date");
                    "Loan End Date" := CALCDATE(OneMonthLessExprLbl, EndDate);
                end;
            end;
        }
        field(25; "Loan End Date"; Date)
        {
            Caption = 'Loan End Date';
            DataClassification = CustomerContent;
        }
        field(26; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
        }
        field(27; "Total Loan Payable"; Decimal)
        {
            Caption = 'Total Loan Payable';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(28; "Total Interest Amount"; Decimal)
        {
            Caption = 'Total Interest Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(29; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(30; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(31; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }
        field(32; "Loan Posting Group"; Code[20])
        {
            Caption = 'Loan Posting Group';
            TableRelation = "Loan Posting Groups B2B";
            DataClassification = CustomerContent;
        }
        field(33; "Continuous Deduction"; Boolean)
        {
            Caption = 'Continuous Deduction';
            DataClassification = CustomerContent;
        }
        field(40; "Premium Paid"; Decimal)
        {
            CalcFormula = Sum("Processed Salary B2B"."Earned Amount" WHERE("Loan Id" = FIELD(Id),
                                                                        "Employee Code" = FIELD("Employee Code")));
            Caption = 'Premium Paid';
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Loan Status"; Option)
        {
            Caption = 'Loan Status';
            Editable = false;
            OptionCaption = ' ,Open,Stopped,Re-Activated,Closed';
            OptionMembers = " ",Open,Stopped,"Re-Activated",Closed;
            DataClassification = CustomerContent;
        }
        field(50; "Partial Dedecting Amount"; Decimal)
        {
            Caption = 'Partial Dedecting Amount';
            DataClassification = CustomerContent;
        }

        field(51; "Lumpsum Paid"; Decimal)
        {
            CalcFormula = sum("Loan Repayments B2B".Amount where("Loan Id" = field("Id")));
            Caption = 'Lumpsum Paid';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Loan Id", Id);
        ProcessedSalary.SETRANGE(Posted, true);
        if ProcessedSalary.FINDFIRST() then
            ERROR(Text003Lbl);

        LoanDetails.RESET();
        LoanDetails.SETRANGE("Loan Id", Id);
        if LoanDetails.FINDFIRST() then
            LoanDetails.DELETEALL();
    end;

    trigger OnInsert();
    begin
        if Id = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Loan Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Loan Nos.", xRec."No. Series", 0D, Id, "No. Series");
        end;

        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETRANGE("Lookup Name", LoanTxt);
        if Lookup_B2B.FINDFIRST() then
            Priority := Lookup_B2B.Priority;
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Lookup_B2B: Record Lookup_B2B;
        Lookup2: Record Lookup_B2B;
        Lookup3: Record Lookup_B2B temporary;
        Employee: Record "Employee B2B";
        PayElements: Record "Pay Elements B2B";
        LoanDetails: Record "Loan Details B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        NoSeriesMgt: Codeunit 396;
        Text000Lbl: Label 'There are no  loan types for this Pay Cadre.';
        Text001Lbl: Label 'Loan amount should not be greater than %1', Comment = '%1 = GrossAmt';
        Text002Lbl: Label 'Loan installments should not be greater than %1', Comment = '%1 = No of Installments';
        Text003Lbl: Label 'One or More Installments deducted for this Loan';
        Text004Lbl: Label 'You can''''t enter more than Loan Balance';
        Text005Lbl: Label 'You can''''t modify, Already Loan installments are created.';
        Text006Lbl: Label 'Already salary posted for the month %1 for the Employee %2', Comment = '%1 =  Month; %2 =EmployeCode ';
        Text007Lbl: Label 'Attendance is not generated for the month %1 year %2', Comment = '%1 = Month ; %2 = Year';
        AddDedTxt: Label 'ADDITIONS AND DEDUCTIONS';
        LoanTxt: Label 'Loan';
        LOANTYPESTxt: Label 'LOAN TYPES';
        OneMonthLessExprLbl: Label '<-1M>';
        BASICTxt: Label 'BASIC';
        DATxt: Label 'DA';
        AFTERBASICTxt: Label 'AFTER BASIC';
        AFTERBASICANDDATxt: Label 'AFTER BASIC AND DA';

    procedure AssistEdit(OldLoan: Record Loan_B2B): Boolean;
    var
        Loan: Record Loan_B2B;
    begin
        with Loan do begin
            Loan := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Loan Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Loan Nos.", OldLoan."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Loan Nos.");
                NoSeriesMgt.SetSeries(Id);
                Rec := Loan;
                exit(true);
            end;
        end;
    end;

    procedure CalcGrossAmount(Employee: Record "Employee B2B"): Decimal;
    var
        PayElements2: Record "Pay Elements B2B";
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
                                if PayElements2."Pay Element Code" = BASICTxt then
                                    Basic := Total
                                else
                                    if PayElements2."Pay Element Code" = DATxt then
                                        DA := Total;
                            end else
                                if (PayElements2."Fixed/Percent" = PayElements2."Fixed/Percent"::Percent) and
                                   (PayElements2."Computation Type" = AFTERBASICTxt)
                       then
                                    Total := (PayElements2."Amount / Percent" * Basic) / 100
                                else
                                    if (PayElements2."Fixed/Percent" = PayElements2."Fixed/Percent"::Percent) and
                                       (PayElements2."Computation Type" = AFTERBASICANDDATxt)
                               then
                                        Total := (PayElements2."Amount / Percent" * (Basic + DA)) / 100;

                    until PayElements2.NEXT() = 0;
                TotalAmt := TotalAmt + Total;

            until PayElements.NEXT() = 0;
            exit(TotalAmt);
        end;
    end;

    procedure CheckInstallments();
    begin
        LoanDetails.RESET();
        LoanDetails.SETRANGE("Loan Id", Id);
        if LoanDetails.FINDFIRST() then
            ERROR(Text005Lbl);
    end;

    procedure CheckDateAvail();
    var
        MonthlyAttendance: Record "Monthly Attendance B2B";
    begin
        MonthlyAttendance.RESET();
        MonthlyAttendance.SETRANGE("Employee Code", "Employee Code");
        MonthlyAttendance.SETRANGE("Pay Slip Month", DATE2DMY("Loan Start Date", 2));
        MonthlyAttendance.SETRANGE(Year, DATE2DMY("Loan Start Date", 3));
        MonthlyAttendance.SETRANGE(Posted, true);
        if MonthlyAttendance.FINDFIRST() then
            ERROR(Text006Lbl, DATE2DMY("Loan Start Date", 2), "Employee Code")
        else begin
            MonthlyAttendance.SETRANGE(Posted, false);
            if not MonthlyAttendance.IsEmpty() then
                Message('')
            else
                ERROR(Text007Lbl, DATE2DMY("Loan Start Date", 2), DATE2DMY("Loan Start Date", 3));

        end;
    end;
}

