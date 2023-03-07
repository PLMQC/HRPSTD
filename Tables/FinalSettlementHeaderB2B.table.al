table 33001239 "Final Settlement Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Final Settlement Header';
    DrillDownPageID = "Final Settlement List B2B";
    LookupPageID = "Final Settlement List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B" WHERE(Status = filter(<> Active));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Employee No.") then begin
                    "Employee Name" := Employee."First Name";
                    "Pay Cadre" := Employee."Pay Cadre";
                    "Date of Leaving" := Employee."Last Working Day";
                    if "Date of Leaving" <> 0D then begin
                        Month := Date2DMY("Date of Leaving", 2);
                        Year := Date2DMY("Date of Leaving", 3);

                    end;
                    "Notice Period Last Date" := Employee."Notice Period Last Date";
                    if Employee.Resigned then
                        Type := Type::Resignation
                    else
                        if employee."Termination Date" <> 0D then
                            Type := Type::Termination;

                    CreateDim(DATABASE::"Employee B2B", "Employee No.");
                end
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; "Pay Cadre"; Code[30])
        {
            Caption = 'Pay Cadre';
            DataClassification = CustomerContent;
        }
        field(4; "Date of Leaving"; Date)
        {
            Caption = 'Date of Leaving';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CurrMonth := DATE2DMY("Date of Leaving", 2);
                CurrYear := DATE2DMY("Date of Leaving", 3);
                DailyAttendance.RESET();
                DailyAttendance.SETRANGE("Employee No.", "Employee No.");
                DailyAttendance.SETRANGE(Month, CurrMonth);
                DailyAttendance.SETRANGE(Year, CurrYear);
                DailyAttendance.SETFILTER(Date, '<=%1', "Date of Leaving");
                DailyAttendance.SETFILTER(DailyAttendance."Attendance Type", '<>%1', DailyAttendance."Attendance Type"::Absent);
                if DailyAttendance.FINDFIRST() then
                    "Attended Days" := DailyAttendance.COUNT();

            end;
        }
        field(5; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(7; "Attended Days"; Decimal)
        {
            Caption = 'Attended Days';
            DataClassification = CustomerContent;
        }
        field(11; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(12; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(13; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(14; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(15; "Gross Salary"; Decimal)
        {
            CalcFormula = Sum ("Final Settlement Line B2B".Amount WHERE("Employee No." = FIELD("Employee No."),
                                                                    Month = FIELD(Month),
                                                                    Year = FIELD(Year)));
            Caption = 'Gross Salary';
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50; Paid; Boolean)
        {
            Caption = 'Paid';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(53; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                ShowDocDim();
            end;
        }
        field(54; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Termination,Resignation;
            OptionCaption = 'Termination,Resignation';
            DataClassification = CustomerContent;
        }
        field(60; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            OptionMembers = Open,Released,"Pending Approval";
            OptionCaption = 'Open,Released,Pending Approval';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(76; "Notice Period Last Date"; Date)
        {
            Caption = 'Notice Period Last Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        if FinalSettleLine.FINDFIRST() then
            FinalSettleLine.DELETEALL();
    end;

    var
        Employee: Record "Employee B2B";
        FinalSettleLine: Record "Final Settlement Line B2B";

        PSalary: Record "Processed Salary B2B";
        DailyAttendance: Record "Daily Attendance B2B";

        DimMgt: Codeunit DimensionManagement;
        NotProcessedDays: Decimal;
        CurrMonth: Integer;
        CurrYear: Integer;
        SkipConfirmation: Boolean;
        AddDedTxt: Label 'ADDITIONS AND DEDUCTIONS';
        BASICTxt: Label 'BASIC';
        AFTERBASICTxt: Label 'AFTER BASIC';
        AFTERBASICANDDATxt: Label 'AFTER BASIC AND DA';
        DATxt: Label 'DA';
        OnAttTxt: Label 'ON ATTENDANCE';
        LOANTxt: Label 'LOAN';
        GRATUITYTxt: Label 'GRATUITY';
        TDSTxt: Label 'TDS';
        ESIYEARTxt: Label 'ESI YEAR';
        ESITxt: Label 'ESI';
        PTTxt: Label 'PT';
        OTTxt: Label 'OT';
        LETxt: Label 'LE';
        ITTxt: Label 'IT';
        BONUSTxt: Label 'BONUS';
        PFTxt: Label 'PF';

    procedure GetPayElements();
    var
        Lookup_B2B: Record Lookup_B2B;
        FinalLine: Record "Final Settlement Line B2B";
    begin
        FinalLine.SETRANGE("Employee No.", "Employee No.");
        FinalLine.SETRANGE(Month, Month);
        FinalLine.SETRANGE(Year, Year);
        if FinalLine.FINDFIRST() then
            FinalLine.DELETEALL();

        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        if Lookup_B2B.FINDFIRST() then
            repeat
                FinalLine.INIT();
                FinalLine.VALIDATE("Employee No.", "Employee No.");
                FinalLine.Month := Month;
                FinalLine.Year := Year;
                FinalLine."Document Type" := FinalLine."Document Type"::Payroll;
                FinalLine."Document No." := "Document No.";
                FinalLine."Journal Template Name" := "Journal Template Name";
                FinalLine."Journal Batch Name" := "Journal Batch Name";
                FinalLine."Posting Date" := "Posting Date";
                FinalLine."Line No." := FinalLine."Line No." + 10000;
                FinalLine."Pay Element Code" := Lookup_B2B."Lookup Name";
                FinalLine.Description := copystr(Lookup_B2B.Description, 1, 50);
                FinalLine."Addition/Deduction" := Lookup_B2B."Add/Deduct";
                Employee.GET("Employee No.");
                FinalLine."Dimension Set ID" := "Dimension Set ID";
                FinalLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                FinalLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                FinalLine.INSERT();
            until Lookup_B2B.NEXT() = 0;
    end;

    procedure CalculateSalary();
    var
        PayElements: Record "Pay Elements B2B";

        MonthlyAttendance: Record "Monthly Attendance B2B";
        CheckMonth: Integer;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        Days: Decimal;


    begin
        DA := 0;
        CheckMonth := DATE2DMY("Date of Leaving", 2);
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        if not FinalSettleLine.IsEmpty() then begin
            MonthlyAttendance.RESET();
            MonthlyAttendance.SETRANGE("Employee Code", "Employee No.");
            MonthlyAttendance.SETRANGE("Pay Slip Month", Month);
            MonthlyAttendance.SETRANGE(Year, Year);
            MonthlyAttendance.SETRANGE(Posted, true);
            if MonthlyAttendance.IsEmpty() then begin
                Total := 0;
                repeat
                    PayElements.SETRANGE("Employee Code", "Employee No.");
                    PayElements.SETRANGE("Pay Element Code", FinalSettleLine."Pay Element Code");
                    PayElements.SETFILTER("Effective Start Date", '<=%1', "Date of Leaving");
                    if PayElements.FINDLAST() then begin
                        Days := MonthDays(CheckMonth);
                        if PayElements."Pay Element Code" = BASICTxt then begin
                            Total := PayElements."Amount / Percent";
                            Basic := Total;
                        end else
                            if (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Fixed) then
                                Total := PayElements."Amount / Percent"
                            else
                                if ((PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) and
                                   (PayElements."Computation Type" = AFTERBASICTxt))
                       then
                                    Total := (((PayElements."Amount / Percent" * Basic) / 100) * "Attended Days") / Days
                                else
                                    if (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) and
                                       (PayElements."Computation Type" = AFTERBASICANDDATxt)
                               then
                                        Total := ((PayElements."Amount / Percent" * (((Basic * "Attended Days") / Days) + DA)) / 100 * "Attended Days") / Days;


                        if PayElements."Pay Element Code" = DATxt then
                            DA := Total;
                        if PayElements."Computation Type" = OnAttTxt then
                            FinalSettleLine.Amount := ROUND((Total * "Attended Days") / Days, 1, '=')
                        else
                            FinalSettleLine.Amount := ROUND(Total, 1, '=');
                        FinalSettleLine.MODIFY();
                    end;
                until FinalSettleLine.NEXT() = 0;
                OTAmount();
                ESIAmount();
                PFAmount();
                PTAmount();
            end;
            LoanAmount1();
            GratuityAmount1();
            TDSAmount1();
            LeaveAmount();
            DeleteRecordswithZeroAmt();
        end;
    end;

    procedure MonthDays(MonthNum: Integer): Integer ;
    begin
        if (MonthNum = 1) or (MonthNum = 3) or (MonthNum = 5) or (MonthNum = 7) or (MonthNum = 8) or (MonthNum = 10) or (MonthNum = 12)
        then
            exit(31)
        else
            if MonthNum = 2 then
                exit(28)
            else
                exit(30);
    end;

    procedure LoanAmount1();
    var
        Loan: Record Loan_B2B;
        LoanAmount: Decimal;
    begin
        Loan.SETRANGE("Employee Code", "Employee No.");
        Loan.SETRANGE(Closed, false);
        Loan.SETFILTER("Loan Balance", '<>0');
        if Loan.FINDFIRST() then
            repeat
                LoanAmount := LoanAmount + Loan."Loan Balance";
            until Loan.NEXT() = 0;

        FinalSettleLine.RESET();
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", LOANTxt);
        if FinalSettleLine.FINDFIRST() then begin
            FinalSettleLine.Amount := LoanAmount;
            FinalSettleLine."Computation Type" := LOANTxt;
            FinalSettleLine.MODIFY();
        end;
    end;

    procedure GratuityAmount1();
    var
        HRSetup: Record "HR Setup B2B";
        Lookup_B2B: Record Lookup_B2B;
        Payelements: Record "Pay Elements B2B";
        GrossAmount: Decimal;
        GratuityAmount: Decimal;
        Days: Decimal;
        NoofDays: Decimal;
        ServiceYears: Decimal;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        CheckMonth: Integer;
    begin
        CheckMonth := DATE2DMY("Date of Leaving", 2);
        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETRANGE(Gratuity, true);
        if Lookup_B2B.FINDFIRST() then
            repeat
                Total := 0;
                Payelements.RESET();
                Payelements.SETRANGE("Employee Code", "Employee No.");
                Payelements.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                Payelements.SETFILTER("Effective Start Date", '<=%1', "Date of Leaving");
                if Payelements.FINDLAST() then begin
                    if (Payelements."Fixed/Percent" = Payelements."Fixed/Percent"::Fixed) then begin
                        Total := Payelements."Amount / Percent";
                        if Payelements."Pay Element Code" = BASICTxt then
                            Basic := Total
                        else
                            if Payelements."Pay Element Code" = DATxt then
                                DA := Total;
                    end else
                        if (Payelements."Fixed/Percent" = Payelements."Fixed/Percent"::Percent) and
                                        (Payelements."Computation Type" = AFTERBASICTxt)
               then
                            Total := (Payelements."Amount / Percent" * Basic) / 100
                        else
                            if (Payelements."Fixed/Percent" = Payelements."Fixed/Percent"::Percent) and
                                            (Payelements."Computation Type" = AFTERBASICANDDATxt)
                       then
                                Total := (Payelements."Amount / Percent" * (Basic + DA)) / 100;
                    if Payelements."Pay Element Code" = DATxt then
                        DA := Total;

                end;
                if Payelements."Add/Deduct" = Payelements."Add/Deduct"::Addition then
                    GrossAmount := GrossAmount + Total
                else
                    if Payelements."Add/Deduct" = Payelements."Add/Deduct"::Deduction then
                        GrossAmount := GrossAmount - Total;
            until Lookup_B2B.NEXT() = 0;
        Employee.RESET();
        Employee.SETRANGE("No.", "Employee No.");
        if Employee.FINDFIRST() then begin
            NoofDays := "Date of Leaving" - Employee."Employment Date";
            ServiceYears := ROUND((NoofDays / 365), 0.01, '>');
        end;

        if HRSetup.FINDFIRST() then begin
            Days := HRSetup."Paid Days Per Month";
            if ServiceYears >= HRSetup."Min. No.of Years" then
                GratuityAmount := (GrossAmount * HRSetup."No.of Days Salary" * ServiceYears) / HRSetup."No.of Days in Month";
            FinalSettleLine.RESET();
            FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
            FinalSettleLine.SETRANGE(Month, Month);
            FinalSettleLine.SETRANGE(Year, Year);
            FinalSettleLine.SETRANGE("Pay Element Code", GRATUITYTxt);
            if FinalSettleLine.FINDFIRST() then begin
                FinalSettleLine.Amount := GratuityAmount;
                FinalSettleLine.MODIFY();
            end;
        end
    end;

    procedure TDSAmount1();
    var
        TDSSchedule: Record "Emp TDS Schedule B2B";
        TDSAmount: Decimal;
    begin
        TDSSchedule.SETRANGE("Employee No.", "Employee No.");
        TDSSchedule.SETRANGE(Month, Month);
        TDSSchedule.SETRANGE(Year, Year);
        TDSSchedule.SETRANGE(Processes, false);
        if TDSSchedule.FINDFIRST() then
            TDSAmount := TDSSchedule."TDS Amount";

        FinalSettleLine.RESET();
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", TDSTxt);
        if FinalSettleLine.FINDFIRST() then begin
            FinalSettleLine.Amount := TDSAmount;
            FinalSettleLine.MODIFY();
        end;
    end;

    procedure ESIAmount();
    var
        Lookup_B2B: Record Lookup_B2B;
        ESI: Record ESI_B2B;
        PayYear: Record "Payroll Year B2B";
        ProcSalary: Record "Processed Salary B2B";
        GrossESIAmt: Decimal;
        GrossSalary: Decimal;
        EmployeeContribution: Decimal;
        EmployerContribution: Decimal;
        CheckDate: Date;
        ESIStartDate: Date;
        ESIEndDate: Date;
        Flag: Boolean;
    begin

        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETRANGE(Lookup_B2B.ESI, Lookup_B2B.ESI::"Regular Element");
        if Lookup_B2B.FINDFIRST() then
            repeat
                FinalSettleLine.RESET();
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                if FinalSettleLine.FINDFIRST() then
                    if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Addition then
                        GrossESIAmt := GrossESIAmt + FinalSettleLine.Amount
                    else
                        if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Deduction then
                            GrossESIAmt := GrossESIAmt - FinalSettleLine.Amount;

            until Lookup_B2B.NEXT() = 0;
        Lookup_B2B.RESET();
        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETFILTER(ESI, '<>%1', Lookup_B2B.ESI::" ");
        if Lookup_B2B.FINDFIRST() then
            repeat
                FinalSettleLine.RESET();
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                if FinalSettleLine.FINDFIRST() then
                    if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Addition then
                        GrossSalary := GrossSalary + FinalSettleLine.Amount
                    else
                        if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Deduction then
                            GrossSalary := GrossSalary - FinalSettleLine.Amount;

            until Lookup_B2B.NEXT() = 0;



        if ESI.FINDFIRST() then
            repeat
                if GrossESIAmt < ESI."ESI Salary Amount" then begin
                    Flag := true;
                    if ESI."Effective Date" <= "Date of Leaving" then
                        case ESI."Rounding Method" of
                            ESI."Rounding Method"::Nearest:
                                begin
                                    EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '=');
                                    EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '=');
                                end;
                            ESI."Rounding Method"::Up:
                                begin
                                    EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '>');
                                    EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '>');
                                end;
                            ESI."Rounding Method"::Down:
                                begin
                                    EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '<');
                                    EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '<');
                                end;
                        end;
                end;

            until ESI.NEXT() = 0;


        if not Flag then begin
            PayYear.SETRANGE("Year Type", ESIYEARTxt);
            PayYear.SETRANGE(Closed, false);
            if PayYear.FINDFIRST() then
                repeat
                    if ("Date of Leaving" >= PayYear."Year Start Date") and
                       ("Date of Leaving" <= PayYear."Year End Date")
                    then begin
                        ESIStartDate := PayYear."Year Start Date";
                        ESIEndDate := PayYear."Year End Date";
                    end;
                until PayYear.NEXT() = 0;

            ProcSalary.RESET();
            ProcSalary.SETRANGE("Employee Code", "Employee No.");
            ProcSalary.SETRANGE(Year, Year);
            ProcSalary.SETRANGE("Add/Deduct Code", ESITxt);
            if ProcSalary.FINDLAST() then begin
                CheckDate := DMY2DATE(1, ProcSalary."Pay Slip Month", ProcSalary.Year);
                if (CheckDate >= ESIStartDate) and (CheckDate <= ESIEndDate) then
                    case ESI."Rounding Method" of
                        ESI."Rounding Method"::Nearest:
                            begin
                                EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '=');
                                EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '=');
                            end;
                        ESI."Rounding Method"::Up:
                            begin
                                EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '>');
                                EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '>');
                            end;
                        ESI."Rounding Method"::Down:
                            begin
                                EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '<');
                                EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '<');
                            end;
                    end;

            end;
        end;

        FinalSettleLine.RESET();
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", ESITxt);
        if FinalSettleLine.FINDFIRST() then begin
            FinalSettleLine.Amount := EmployeeContribution;
            FinalSettleLine.Salary := GrossSalary;
            FinalSettleLine."Co. Contribution" := EmployerContribution;
            Employee.RESET();
            Employee.SETRANGE("No.", "Employee No.");
            Employee.SETRANGE("ESI Applicable", true);
            if Employee.FINDFIRST() then
                FinalSettleLine.MODIFY();
        end;
    end;

    procedure PTAmount();
    var
        Lookup_B2B: Record Lookup_B2B;
        PT: Record "Professional Tax Line B2B";

        GrossAmount: Decimal;
        PTAmount1: Decimal;
    begin
        Lookup_B2B.RESET();
        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETRANGE(PT, true);
        if Lookup_B2B.FINDFIRST() then
            repeat
                FinalSettleLine.RESET();
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                if FinalSettleLine.FINDFIRST() then
                    if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Addition then
                        GrossAmount := GrossAmount + FinalSettleLine.Amount
                    else
                        if FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Deduction then
                            GrossAmount := GrossAmount - FinalSettleLine.Amount;

            until Lookup_B2B.NEXT() = 0;

        if PT.FINDFIRST() then
            repeat
                PT.TESTFIELD("Income From");
                PT.TESTFIELD("Income To");
                if (PT."Income From" <= GrossAmount) and (PT."Income To" >= GrossAmount) then
                    if PT."Effective Date" <= "Date of Leaving" then
                        PTAmount1 := PT."Tax Amount";

            until PT.NEXT() = 0;


        FinalSettleLine.RESET();
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", PTTxt);
        if FinalSettleLine.FINDFIRST() then begin
            FinalSettleLine.Amount := PTAmount1;
            Employee.RESET();
            Employee.SETRANGE("No.", "Employee No.");
            Employee.SETRANGE("PT Applicable", true);
            if Employee.FINDFIRST() then
                if Employee."PT Branch Code" <> '' then
                    FinalSettleLine.MODIFY();
        end;
    end;

    procedure PFAmount();
    var
        Lookup_B2B: Record Lookup_B2B;
        EmployeeLocal: Record "Employee B2B";
        PF: Record PF_B2B;
        GrossAmount: Decimal;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        EPSAmount: Decimal;
        PFAdminCharges: Decimal;
        EDLICharges: Decimal;
        RIFACharges: Decimal;
        NewGrossAmount: Decimal;

    begin
        GrossAmount := 0;
        Lookup_B2B.RESET();
        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETRANGE(PF, true);
        if Lookup_B2B.FINDFIRST() then
            repeat
                FinalSettleLine.RESET();
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                FinalSettleLine.SETRANGE("Addition/Deduction", FinalSettleLine."Addition/Deduction"::Addition);
                if FinalSettleLine.FINDFIRST() then
                    GrossAmount := GrossAmount + FinalSettleLine.Amount;

            until Lookup_B2B.NEXT() = 0;

        if PF.FINDFIRST() then begin
            if EmployeeLocal.GET("Employee No.") then begin
                if EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::"Actual Salary" then
                    NewGrossAmount := GrossAmount;

                if EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::"Employee Specific" then
                    NewGrossAmount := EmployeeLocal."PF Amount";

                if EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::Statutory then
                    NewGrossAmount := PF."PF Amount";
            end;
            GrossAmount := NewGrossAmount;

            repeat
                if EmployeeLocal."PF Applicability" <> EmployeeLocal."PF Applicability"::"Employee Specific" then begin
                    if GrossAmount < PF."PF Amount" then begin
                        if PF."Effective Date" <= "Date of Leaving" then
                            case PF."Rounding Method" of
                                PF."Rounding Method"::Nearest:
                                    begin
                                        EmployerContribution := ROUND((GrossAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '=');
                                        EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                                        EPSAmount := ROUND((GrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                    end;
                                PF."Rounding Method"::Up:
                                    begin
                                        EmployerContribution := ROUND((GrossAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '>');
                                        EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                                        EPSAmount := ROUND((GrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                    end;
                                PF."Rounding Method"::Down:
                                    begin
                                        EmployerContribution := ROUND((GrossAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '<');
                                        EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                                        EPSAmount := ROUND((GrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                    end;

                            end;

                    end else
                        if PF."Effective Date" <= "Date of Leaving" then
                            case PF."Rounding Method" of
                                PF."Rounding Method"::Nearest:
                                    begin
                                        EPSAmount := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                        EmployerContribution := ROUND((GrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '=')
                                                                  - EPSAmount;
                                        EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                                    end;
                                PF."Rounding Method"::Up:
                                    begin
                                        EPSAmount := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                        EmployerContribution := ROUND((GrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '>')
                                                                  - EPSAmount;
                                        EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                                    end;
                                PF."Rounding Method"::Down:
                                    begin
                                        EPSAmount := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                        EmployerContribution := ROUND((GrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '<')
                                                                  - EPSAmount;
                                        EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                                    end;
                            end;
                end else
                    EmployeeContribution := GrossAmount;

            until PF.NEXT() = 0;

            PFAdminCharges := (GrossAmount * PF."Admin Charges %") / 100;
            EDLICharges := (GrossAmount * PF."EDLI %") / 100;
            RIFACharges := (GrossAmount * PF."RIFA %") / 100;
        end;


        FinalSettleLine.RESET();
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", PFTxt);
        if FinalSettleLine.FINDFIRST() then begin
            FinalSettleLine.Amount := EmployeeContribution;
            FinalSettleLine.Salary := GrossAmount;
            FinalSettleLine."Co. Contribution" := EmployerContribution;
            FinalSettleLine."Co. Contribution2" := EPSAmount;
            FinalSettleLine."PF Admin Charges" := PFAdminCharges;
            FinalSettleLine."EDLI Charges" := EDLICharges;
            FinalSettleLine."RIFA Charges" := RIFACharges;

            Employee.RESET();
            Employee.SETRANGE("No.", "Employee No.");
            Employee.SETRANGE("PF Applicable", true);
            if Employee.FINDFIRST() then
                FinalSettleLine.MODIFY();
        end;
    end;

    procedure OTAmount();
    var
        Lookup_B2B: Record Lookup_B2B;
        CheckMonth: Integer;
        CheckYear: Integer;
        OTHrs: Decimal;
        NoofHrs: Decimal;
        OTDay: Decimal;
        OTHrsAmount: Decimal;
        OTTotal: Decimal;
    begin
        CheckMonth := DATE2DMY("Date of Leaving", 2);
        CheckYear := DATE2DMY("Date of Leaving", 3);

        DailyAttendance.SETRANGE("Employee No.", "Employee No.");
        DailyAttendance.SETRANGE(Month, CheckMonth);
        DailyAttendance.SETRANGE(Year, CheckYear);
        DailyAttendance.SETFILTER(Date, '<=%1', "Date of Leaving");
        if DailyAttendance.FINDFIRST() then begin
            NoofHrs := DailyAttendance."Actual Hrs";
            repeat
                OTHrs := OTHrs + DailyAttendance."OT Approved Hrs";
            until DailyAttendance.NEXT() = 0;
        end;

        if OTHrs <> 0 then begin
            Lookup_B2B.RESET();
            Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
            Lookup_B2B.SETRANGE("Applicable for OT", true);
            if Lookup_B2B.FINDFIRST() then
                repeat
                    FinalSettleLine.RESET();
                    FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                    FinalSettleLine.SETRANGE(Month, Month);
                    FinalSettleLine.SETRANGE(Year, Year);
                    FinalSettleLine.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                    if FinalSettleLine.FINDFIRST() then begin
                        OTDay := FinalSettleLine.Amount / "Attended Days";
                        OTHrsAmount := (OTDay * OTHrs) / NoofHrs;
                    end;
                    OTTotal := OTTotal + OTHrsAmount;
                until Lookup_B2B.NEXT() = 0;

            FinalSettleLine.RESET();
            FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
            FinalSettleLine.SETRANGE(Month, Month);
            FinalSettleLine.SETRANGE(Year, Year);
            FinalSettleLine.SETRANGE("Pay Element Code", OTTxt);
            if FinalSettleLine.FINDFIRST() then begin
                FinalSettleLine.Amount := OTTotal;
                FinalSettleLine.MODIFY();
            end;
        end;
    end;

    procedure LeaveAmount();
    var
        PayElements: Record "Pay Elements B2B";
        EmployeeLeaves: Record "Employee Leaves B2B";
        GradewiseLeaves: Record "Grade Wise Leaves B2B";
        Lookup_B2B: Record Lookup_B2B;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        GrossAmount: Decimal;
        TotalAdditions: Decimal;
    begin
        Lookup_B2B.RESET();
        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETRANGE("Leave Encashment", true);
        if Lookup_B2B.FINDFIRST() then
            repeat
                Total := 0;
                PayElements.RESET();
                PayElements.SETRANGE("Employee Code", "Employee No.");
                PayElements.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                PayElements.SETFILTER("Effective Start Date", '<=%1', "Date of Leaving");
                if PayElements.FINDLAST() then begin
                    if (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Fixed) then begin
                        Total := PayElements."Amount / Percent";
                        if PayElements."Pay Element Code" = BASICTxt then
                            Basic := Total
                        else
                            if PayElements."Pay Element Code" = DATxt then
                                DA := Total;
                    end else
                        if (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) and
                                        (PayElements."Computation Type" = AFTERBASICTxt)
               then
                            Total := (PayElements."Amount / Percent" * Basic) / 100
                        else
                            if (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) and
                                            (PayElements."Computation Type" = AFTERBASICANDDATxt)
                       then
                                Total := (PayElements."Amount / Percent" * (Basic + DA)) / 100;
                    if PayElements."Pay Element Code" = DATxt then
                        DA := Total;
                end;
                if PayElements."Add/Deduct" = PayElements."Add/Deduct"::Addition then
                    GrossAmount := GrossAmount + Total
                else
                    if PayElements."Add/Deduct" = PayElements."Add/Deduct"::Deduction then
                        GrossAmount := GrossAmount - Total;
            until Lookup_B2B.NEXT() = 0;
        CLEAR(TotalAdditions);

        EmployeeLeaves.RESET();
        EmployeeLeaves.SETRANGE("No.", "Employee No.");
        if EmployeeLeaves.FINDFIRST() then
            repeat
                EmployeeLeaves.CALCFIELDS("No. of Available Leaves");
                GradewiseLeaves.RESET();
                GradewiseLeaves.SETRANGE("Leave Code", EmployeeLeaves."Leave Code");
                GradewiseLeaves.SETRANGE("Leave Pay Cadre", EmployeeLeaves."Leave Pay Cadre");
                if GradewiseLeaves.FINDFIRST() and GradewiseLeaves."Final Settlement Encashable" then
                    TotalAdditions += EmployeeLeaves."No. of Available Leaves" * GrossAmount * 12 / 312;
            until EmployeeLeaves.NEXT() = 0;

        FinalSettleLine.RESET();
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", LETxt);
        if FinalSettleLine.FINDFIRST() then begin
            FinalSettleLine.Amount := ROUND(TotalAdditions, 1, '=');
            FinalSettleLine.MODIFY();
        end;
    end;

    procedure DeleteRecordswithZeroAmt();
    begin
        FinalSettleLine.RESET();
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETFILTER("Pay Element Code", '<>%1', ESITxt);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE(Amount, 0);
        if FinalSettleLine.FINDSET() then
            repeat
                if (FinalSettleLine."Pay Element Code" <> ITTxt) then
                    FinalSettleLine.DELETE(true);
            until FinalSettleLine.NEXT() = 0;
    end;

    procedure BonusCal();
    var
        LookupRe: Record Lookup_B2B;
        Lookup2: Record Lookup_B2B;
        PayElementRec: Record "Pay Elements B2B";
        PostOTHPlmRec: Record "Posted Other PayElements B2B";
        HRSetup: Record "HR Setup B2B";
        FinalLine2: Record "Final Settlement Line B2B";
        Monthlyatt: Record "Monthly Attendance B2B";
        Bonus: Record Bonus_B2B;
        BonusAmt: Decimal;
        GrossAmt: Decimal;
        VdaAmt: Decimal;
        RoundedAmt: Decimal;
        TotalDays: Decimal;
        WithInrange: Boolean;
    begin
        FinalLine2.RESET();
        FinalLine2.SETRANGE("Employee No.", "Employee No.");
        FinalLine2.SETRANGE("Pay Element Code", BONUSTxt);
        if FinalLine2.FINDSET() then
            repeat
                CLEAR(GrossAmt);
                CLEAR(TotalDays);
                CLEAR(RoundedAmt);
                CLEAR(VdaAmt);
                CLEAR(WithInrange);

                LookupRe.RESET();
                LookupRe.SETRANGE("Lookup Type", 20);
                if LookupRe.FINDFIRST() then
                    if LookupRe."Incentive Applicable" = LookupRe."Incentive Applicable"::Bonus then begin
                        Lookup2.RESET();
                        Lookup2.SETRANGE("Lookup Type", 16);
                        Lookup2.SETRANGE("Bonus/Exgratia", Lookup2."Bonus/Exgratia"::Bonus);
                        if Lookup2.FINDSET() then
                            repeat
                                PayElementRec.RESET();
                                PayElementRec.SETRANGE("Employee Code", "Employee No.");
                                PayElementRec.SETRANGE("Pay Element Code", Lookup2."Lookup Name");
                                PayElementRec.SETRANGE("Effective Start Date", FinalLine2."From date", FinalLine2."To date");
                                if PayElementRec.FINDLAST() then begin
                                    GrossAmt += PayElementRec."Amount / Percent";
                                    WithInrange := true;
                                end;
                                if not WithInrange then begin
                                    PayElementRec.RESET();
                                    PayElementRec.SETRANGE("Employee Code", "Employee No.");
                                    PayElementRec.SETRANGE("Pay Element Code", Lookup2."Lookup Name");
                                    if PayElementRec.FINDLAST() then
                                        GrossAmt += PayElementRec."Amount / Percent";

                                end;
                                PostOTHPlmRec.RESET();
                                PostOTHPlmRec.SETRANGE("Employee No.", "Employee No.");
                                PostOTHPlmRec.SETRANGE("Pay Element Code", Lookup2."Lookup Name");
                                if PostOTHPlmRec.FINDLAST() then
                                    VdaAmt := PostOTHPlmRec.Amount;
                            until Lookup2.NEXT() = 0;

                    end;


                HRSetup.GET();
                Bonus.RESET();
                if Bonus.FINDLAST() then begin
                    Bonus.TESTFIELD(Bonus."Bouns Amount 8.33%");
                    if (GrossAmt + VdaAmt) > Bonus."Min.Bonusable Salary" then
                        RoundedAmt := Bonus."Min.Bonusable Salary"
                    else
                        RoundedAmt := (GrossAmt + VdaAmt);
                    BonusAmt := (RoundedAmt * Bonus."Bouns Amount 8.33%") / (100 * 26);
                end;

                Monthlyatt.RESET();
                Monthlyatt.SETRANGE("Employee Code", "Employee No.");
                Monthlyatt.SETRANGE("Period Start Date", FinalLine2."From date", FinalLine2."To date");
                if Monthlyatt.FINDSET() then
                    repeat
                        Monthlyatt.CALCFIELDS("Loss Of Pay", "LOP Adj Days");
                        TotalDays += HRSetup."Paid Days Per Month" - Monthlyatt."Loss Of Pay" + Monthlyatt."LOP Adj Days";
                    until Monthlyatt.NEXT() = 0;
                if (FinalLine2."From date" <= "Date of Leaving") and (FinalLine2."To date" >= "Date of Leaving") then begin
                    CLEAR(NotProcessedDays);
                    PSalary.RESET();
                    PSalary.SETRANGE("Employee Code", "Employee No.");
                    PSalary.SETRANGE("Pay Slip Month", Month);
                    PSalary.SETRANGE(Year, Year);
                    if not PSalary.FINDFIRST() then
                        NotProcessedDays := "Attended Days";
                end;
                FinalLine2.Amount := ROUND((TotalDays + NotProcessedDays) * BonusAmt, 1, '=');
                FinalLine2."Bonus Days" := (TotalDays + NotProcessedDays);
                FinalLine2.MODIFY();
            until FinalLine2.NEXT() = 0;
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]);
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.GET();
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(TableID, No, '', "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Dimension Set ID", DATABASE::"Employee B2B");
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if (OldDimSetID <> "Dimension Set ID") and LinesExist() then begin
            MODIFY();
            SkipConfirmationDialog(true);
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "Employee No." <> '' then
            MODIFY();

        if OldDimSetID <> "Dimension Set ID" then begin
            MODIFY();
            if LinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        FinalSettlementLine: Record "Final Settlement Line B2B";
        DimChangeTxt: Label 'You may have changed a dimension.\\Do you want to update the lines?';
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not SkipConfirmation then
            if not CONFIRM(DimChangeTxt) then
                exit;

        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettlementLine.LOCKTABLE();
        if FinalSettlementLine.FINDFIRST() then
            repeat
                if FinalSettlementLine."Dimension Set ID" <> NewParentDimSetID then begin
                    FinalSettlementLine."Dimension Set ID" := NewParentDimSetID;

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      FinalSettlementLine."Dimension Set ID", FinalSettlementLine."Shortcut Dimension 1 Code", FinalSettlementLine."Shortcut Dimension 2 Code");
                    FinalSettlementLine.MODIFY();
                end;
            until FinalSettlementLine.NEXT() = 0;
    end;

    procedure LinesExist(): Boolean;
    var
        FinalSettlementLine: Record "Final Settlement Line B2B";
    begin
        FinalSettlementLine.RESET();
        FinalSettlementLine.SETRANGE("Employee No.", "Employee No.");
        exit(not FinalSettlementLine.IsEmpty());
    end;

    procedure SkipConfirmationDialog(Flag: Boolean);
    begin
        SkipConfirmation := Flag;
    end;

    procedure ShowDocDim();
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1', "Employee No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then begin
            MODIFY();
            if LinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;



    procedure ReleaseDocument();
    var
        ApprovalMgmtCust: Codeunit "Approval Mgmt B2B";
        ReleaseTxt: Label 'Do you want to release the Document?';
        NoWorkflowEnabledErr: Label 'This document can only be released when the approval process is complete.';
    begin

        if ApprovalMgmtCust.IsFinalsettlementApprovalsWorkflowEnabled(Rec) then
            Error(NoWorkflowEnabledErr);
        IF NOT CONFIRM(ReleaseTxt, FALSE) THEN
            EXIT;

        "Approval Status" := "Approval Status"::Released;
        MODIFY();
    end;

    procedure ReopenDocument();
    var
        ApprovalMgmtCust: Codeunit "Approval Mgmt B2B";
        ReopenTextLbl: Label 'Do you want to reopen the Document?';
        NoWorkflowEnabledErr: Label 'This document can only be open when the approval process is complete.';
        CancelErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    begin
        if ApprovalMgmtCust.IsFinalsettlementApprovalsWorkflowEnabled(Rec) then
            Error(NoWorkflowEnabledErr);


        IF NOT CONFIRM(ReopenTextLbl, FALSE) THEN
            EXIT;
        IF "Approval Status" = "Approval Status"::"Pending Approval" THEN
            ERROR(CancelErr);


        "Approval Status" := "Approval Status"::Open;
        MODIFY();
    end;
}

