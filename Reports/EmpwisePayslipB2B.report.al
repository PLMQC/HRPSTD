report 33001248 "Empwise Payslip B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Empwise Payslip.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Monthly Attendance"; "Monthly Attendance B2B")
        {
            DataItemTableView = SORTING("Employee Code", "Pay Slip Month", Year) ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(Monthly_Attendance__Employee_Code_; "Employee Code")
            {
            }
            column(Monthly_Attendance__Employee_Name_; "Employee Name")
            {
            }
            column(Monthly_Attendance__Monthly_Attendance__Attendance; "Monthly Attendance".Attendance)
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(FORMAT__Pay_Slip_For_The_Month_of_______Month_____FORMAT_Year__; FORMAT('Pay Slip For The Month of' + '  ' + Month + ' ' + FORMAT(Year)))
            {
            }
            column(Designation; Designation)
            {
            }
            column(Department_; Department)
            {
            }
            column(BankAccNo; BankAccNo)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(WorkingDays; WorkingDays)
            {
            }
            column(PFNum; PFNum)
            {
            }
            column(ESINum; ESINum)
            {
            }
            column(Monthly_Attendance__Employee_Code_Caption; FIELDCAPTION("Employee Code"))
            {
            }
            column(Monthly_Attendance__Employee_Name_Caption; FIELDCAPTION("Employee Name"))
            {
            }
            column(AttendanceCaption; AttendanceCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152077; EmptyStringCaption_Control1102152077Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152012; EmptyStringCaption_Control1102152012Lbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152039; EmptyStringCaption_Control1102152039Lbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152082; EmptyStringCaption_Control1102152082Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152088; EmptyStringCaption_Control1102152088Lbl)
            {
            }
            column(Bank_Acc_No_Caption; Bank_Acc_No_CaptionLbl)
            {
            }
            column(Working_DaysCaption; Working_DaysCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154101; EmptyStringCaption_Control1102154101Lbl)
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152086; EmptyStringCaption_Control1102152086Lbl)
            {
            }
            column(ESI_No_Caption; ESI_No_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152087; EmptyStringCaption_Control1102152087Lbl)
            {
            }
            column(Monthly_Attendance_Pay_Slip_Month; "Pay Slip Month")
            {
            }
            column(Monthly_Attendance_Year; Year)
            {
            }
            column(Monthly_Attendance_Line_No_; "Line No.")
            {
            }
            dataitem("Processed Salary"; "Processed Salary B2B")
            {
                DataItemLink = "Employee Code" = FIELD("Employee Code"), "Pay Slip Month" = FIELD("Pay Slip Month"), Year = FIELD(Year);
                DataItemTableView = SORTING("Employee Code", "Add/Deduct Code", "Pay Slip Month", Year, "Add/Deduct");
                column(PayGrandTotal; PayGrandTotal)
                {
                }
                column(Monthly_Attendance___Gross_Salary_; "Monthly Attendance"."Gross Salary")
                {
                }
                column(Others; Others)
                {
                }
                column(PayOthers; PayOthers)
                {
                }
                column(Others_Control1102154008; Others)
                {
                }
                column(PaySpl_All__; "PaySpl.All.")
                {
                }
                column(Spl_All__; "Spl.All.")
                {
                }
                column(PCF; PCF)
                {
                }
                column(WF; WF)
                {
                }
                column(PayCCA; PayCCA)
                {
                }
                column(CCA; CCA)
                {
                }
                column(Canteen; Canteen)
                {
                }
                column(PayMedical; PayMedical)
                {
                }
                column(Medical; Medical)
                {
                }
                column(CD; CD)
                {
                }
                column(PayCA; PayCA)
                {
                }
                column(CA; CA)
                {
                }
                column(TDS; TDS)
                {
                }
                column(PayHRA; PayHRA)
                {
                }
                column(HRA; HRA)
                {
                }
                column(PT; PT)
                {
                }
                column(PayBasic; PayBasic)
                {
                }
                column(Basic; Basic)
                {
                }
                column(ESI; ESI)
                {
                }
                column(PF; PF)
                {
                }
                column(Monthly_Attendance__Deductions; "Monthly Attendance".Deductions)
                {
                }
                column(PLAvail; PLAvail)
                {
                }
                column(CLAvail; CLAvail)
                {
                }
                column(PLUsed; PLUsed)
                {
                }
                column(CLUsed; CLUsed)
                {
                }
                column(PLRem; PLRem)
                {
                }
                column(CLRem; CLRem)
                {
                }
                column(Monthly_Attendance___Net_Salary_; "Monthly Attendance"."Net Salary")
                {
                }
                column(SLRem; SLRem)
                {
                }
                column(SLUsed; SLUsed)
                {
                }
                column(SLAvail; SLAvail)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Gross_SalaryCaption; Gross_SalaryCaptionLbl)
                {
                }
                column(OthersCaption; OthersCaptionLbl)
                {
                }
                column(OthersCaption_Control1102154031; OthersCaption_Control1102154031Lbl)
                {
                }
                column(Spl_AllowanceCaption; Spl_AllowanceCaptionLbl)
                {
                }
                column(PCFCaption; PCFCaptionLbl)
                {
                }
                column(Wel_FundCaption; Wel_FundCaptionLbl)
                {
                }
                column(CCACaption; CCACaptionLbl)
                {
                }
                column(CanteenCaption; CanteenCaptionLbl)
                {
                }
                column(MedicalCaption; MedicalCaptionLbl)
                {
                }
                column(CDCaption; CDCaptionLbl)
                {
                }
                column(ConveyanceCaption; ConveyanceCaptionLbl)
                {
                }
                column(TDSCaption; TDSCaptionLbl)
                {
                }
                column(HRACaption; HRACaptionLbl)
                {
                }
                column(PTCaption; PTCaptionLbl)
                {
                }
                column(BasicCaption; BasicCaptionLbl)
                {
                }
                column(ESICaption; ESICaptionLbl)
                {
                }
                column(ActualsCaption; ActualsCaptionLbl)
                {
                }
                column(ComponentsCaption; ComponentsCaptionLbl)
                {
                }
                column(EarningsCaption; EarningsCaptionLbl)
                {
                }
                column(DeductionsCaption; DeductionsCaptionLbl)
                {
                }
                column(PFCaption; PFCaptionLbl)
                {
                }
                column(Leave_TypeCaption; Leave_TypeCaptionLbl)
                {
                }
                column(PLCaption; PLCaptionLbl)
                {
                }
                column(CLCaption; CLCaptionLbl)
                {
                }
                column(AvailableCaption; AvailableCaptionLbl)
                {
                }
                column(UsedCaption; UsedCaptionLbl)
                {
                }
                column(RemainingCaption; RemainingCaptionLbl)
                {
                }
                column(Net_SalaryCaption; Net_SalaryCaptionLbl)
                {
                }
                column(SLCaption; SLCaptionLbl)
                {
                }
                column(Authorized_signatureCaption; Authorized_signatureCaptionLbl)
                {
                }
                column(Processed_Salary_Document_Type; "Document Type")
                {
                }
                column(Processed_Salary_Employee_Code; "Employee Code")
                {
                }
                column(Processed_Salary_Pay_Slip_Month; "Pay Slip Month")
                {
                }
                column(Processed_Salary_Year; Year)
                {
                }
                column(Processed_Salary_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    case "Add/Deduct Code" of
                        BasicTxt:
                            Basic := "Earned Amount";
                        DATxt:
                            DA := "Earned Amount";
                        HRATxt:
                            HRA := "Earned Amount";
                        CATxt:
                            CA := "Earned Amount";
                        CCATxt:
                            CCA := "Earned Amount";
                        SPLALLTxt:
                            "Spl.All." := "Earned Amount";
                        LeaveEncashmentTxt:
                            Others := "Earned Amount";
                        PFTxt:
                            PF := "Earned Amount";
                        ESITxt:
                            ESI := "Earned Amount";
                        PTTxt:
                            PT := "Earned Amount";
                        CANDEDTxt:
                            Canteen := "Earned Amount";
                        SALADVTxt:
                            "Salary Adv." := "Earned Amount";
                        MLTxt:
                            "Medical Loan" := "Earned Amount";
                        TDSTxt:
                            IT := "Earned Amount";
                        LCDTxt:
                            AttReg := "Earned Amount";
                        WFTxt:
                            WF := "Earned Amount";
                        PCFTxt:
                            PCF := "Earned Amount";
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    PayElements.RESET();
                    if PayElements.FINDFIRST() then
                        repeat
                            PayElements.Processed := false;
                            PayElements.MODIFY();
                        until PayElements.NEXT() = 0;

                    SETRANGE("Employee Code", "Monthly Attendance"."Employee Code");
                    SETRANGE("Pay Slip Month", "Monthly Attendance"."Pay Slip Month");
                    SETRANGE(Year, "Monthly Attendance".Year);

                    Employee.RESET();
                    Employee.SETRANGE("No.", "Monthly Attendance"."Employee Code");
                    if Employee.FINDFIRST() then begin
                        PayBasic := 0;
                        PayHRA := 0;
                        PayCA := 0;
                        PayCCA := 0;
                        "PaySpl.All." := 0;
                        PayOthers := 0;
                        PayWF := 0;
                        PayPCF := 0;
                        CalcPayElements(Employee, "Monthly Attendance"."Period End Date");
                    end;

                    Basic := 0;
                    DA := 0;
                    HRA := 0;
                    CA := 0;
                    CCA := 0;
                    "Spl.All." := 0;
                    Others := 0;
                    PF := 0;
                    ESI := 0;
                    PT := 0;
                    Canteen := 0;
                    "Salary Adv." := 0;
                    "Medical Loan" := 0;
                    IT := 0;
                    AttReg := 0;
                    WF := 0;
                    PCF := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                "Monthly Attendance".CALCFIELDS(Days);
                WorkingDays := "Monthly Attendance".Days;

                Employee.RESET();
                Employee.SETRANGE(Blocked, false);
                Employee.SETRANGE("No.", "Monthly Attendance"."Employee Code");
                if Employee.FINDFIRST() then begin
                    Designation := Employee.Designation;
                    Department := Employee."Department Code";
                    PFNum := Employee."PF No";
                    ESINum := Employee."ESI No";
                    BankAccNo := Employee."Account No";
                end;

                "Monthly Attendance".CALCFIELDS("Gross Salary");
                "Monthly Attendance".CALCFIELDS(Deductions);

                case "Pay Slip Month" of
                    1:
                        Month := JanuaryTxt;
                    2:
                        Month := FebruaryTxt;
                    3:
                        Month := MarchTxt;
                    4:
                        Month := AprilTxt;
                    5:
                        Month := MayTxt;
                    6:
                        Month := JuneTxt;
                    7:
                        Month := JulyTxt;
                    8:
                        Month := AugustTxt;
                    9:
                        Month := SeptemberTxt;
                    10:
                        Month := OctoberTxt;
                    11:
                        Month := NovemberTxt;
                    12:
                        Month := DecemberTxt;
                end;

                DaysPresent := (Attendance + "Weekly Off" + Holidays + Leaves) - "Loss Of Pay";
            end;
        }
    }

    requestpage
    {
        Caption = 'Empwise Payslip';

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPreReport();
    begin
        Year := "Processed Salary".Year;
    end;

    var
        Employee: Record "Employee B2B";
        CompanyInfo: Record "Company Information";
        PayElements: Record "Pay Elements B2B";
        Month: Text[30];
        Year: Integer;
        Basic: Decimal;
        DA: Decimal;
        HRA: Decimal;
        CCA: Decimal;
        CA: Decimal;
        "Spl.All.": Decimal;
        Others: Decimal;
        ESI: Decimal;
        PF: Decimal;
        IT: Decimal;
        PT: Decimal;
        TDS: Decimal;
        Canteen: Decimal;
        "Salary Adv.": Decimal;
        "Medical Loan": Decimal;
        WF: Decimal;
        PCF: Decimal;
        DaysPresent: Decimal;
        Designation: Code[50];
        Department: Code[30];
        PFNum: Text[20];
        ESINum: Text[20];
        BankAccNo: Code[30];
        PayBasic: Decimal;
        PayHRA: Decimal;
        PayCA: Decimal;
        PayCCA: Decimal;
        "PaySpl.All.": Decimal;
        PayOthers: Decimal;
        PayGrandTotal: Decimal;
        PayWF: Decimal;
        PayPCF: Decimal;
        AttReg: Decimal;
        PayMedical: Decimal;
        Medical: Decimal;
        CD: Decimal;
        PLAvail: Decimal;
        PLUsed: Decimal;
        PLRem: Decimal;
        CLAvail: Decimal;
        CLUsed: Decimal;
        CLRem: Decimal;
        SLAvail: Decimal;
        SLUsed: Decimal;
        SLRem: Decimal;
        WorkingDays: Decimal;
        AttendanceCaptionLbl: Label 'Attendance';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102152077Lbl: Label ':';
        EmptyStringCaption_Control1102152012Lbl: Label ':';
        DesignationCaptionLbl: Label 'Designation';
        EmptyStringCaption_Control1102152039Lbl: Label ':';
        DepartmentCaptionLbl: Label 'Department';
        EmptyStringCaption_Control1102152082Lbl: Label ':';
        EmptyStringCaption_Control1102152088Lbl: Label ':';
        Bank_Acc_No_CaptionLbl: Label 'Bank Acc No.';
        Working_DaysCaptionLbl: Label 'Working Days';
        EmptyStringCaption_Control1102154101Lbl: Label ':';
        PF_No_CaptionLbl: Label 'PF No.';
        EmptyStringCaption_Control1102152086Lbl: Label ':';
        ESI_No_CaptionLbl: Label 'ESI No.';
        EmptyStringCaption_Control1102152087Lbl: Label ':';
        TotalCaptionLbl: Label 'Total';
        Gross_SalaryCaptionLbl: Label 'Gross Salary';
        OthersCaptionLbl: Label 'Others';
        OthersCaption_Control1102154031Lbl: Label 'Others';
        Spl_AllowanceCaptionLbl: Label 'Spl Allowance';
        PCFCaptionLbl: Label 'PCF';
        Wel_FundCaptionLbl: Label 'Wel Fund';
        CCACaptionLbl: Label 'CCA';
        CanteenCaptionLbl: Label 'Canteen';
        MedicalCaptionLbl: Label 'Medical';
        CDCaptionLbl: Label 'CD';
        ConveyanceCaptionLbl: Label 'Conveyance';
        TDSCaptionLbl: Label 'TDS';
        HRACaptionLbl: Label 'HRA';
        PTCaptionLbl: Label 'PT';
        BasicCaptionLbl: Label 'Basic';
        ESICaptionLbl: Label 'ESI';
        ActualsCaptionLbl: Label 'Actuals';
        ComponentsCaptionLbl: Label 'Components';
        EarningsCaptionLbl: Label 'Earnings';
        DeductionsCaptionLbl: Label 'Deductions';
        PFCaptionLbl: Label 'PF';
        Leave_TypeCaptionLbl: Label 'Leave Type';
        PLCaptionLbl: Label 'PL';
        CLCaptionLbl: Label 'CL';
        AvailableCaptionLbl: Label 'Available';
        UsedCaptionLbl: Label 'Used';
        RemainingCaptionLbl: Label 'Remaining';
        Net_SalaryCaptionLbl: Label 'Net Salary';
        SLCaptionLbl: Label 'SL';
        Authorized_signatureCaptionLbl: Label 'Authorized signature';
        JanuaryTxt: Label 'January';
        FebruaryTxt: Label 'February';
        MarchTxt: Label 'March';
        AprilTxt: Label 'April';
        MayTxt: Label 'May';
        JuneTxt: Label 'June';
        JulyTxt: Label 'July';
        AugustTxt: Label 'August';
        SeptemberTxt: Label 'September';
        OctoberTxt: Label 'October';
        NovemberTxt: Label 'November';
        DecemberTxt: Label 'December';
        HRATxt: Label 'HRA';
        CATxt: Label 'CA';
        CCATxt: Label 'CCA';
        LeaveEncashmentTxt: Label 'Leave Encashment';
        BasicTxt: Label 'BASIC';
        DATxt: Label 'DA';
        SPLALLTxt: Label 'SPL ALL';
        PFTxt: Label 'PF';
        ESITxt: Label 'ESI';
        PTTxt: Label 'PT';
        CANDEDTxt: Label 'CANDED';
        SALADVTxt: Label 'SALADV';
        TDSTxt: Label 'TDS';
        WFTxt: Label 'WF';
        PCFTxt: Label 'PCF';
        PLTxt: Label 'PL';
        CLTxt: Label 'CL';
        SLTxt: Label 'SL';
        MLTxt: Label 'ML';
        LCDTxt: Label 'LCD';

    procedure CalcPayElements(Emp: Record "Employee B2B"; ProcessingDate: Date);
    var

        PayElements2: Record "Pay Elements B2B";
    begin
        PayElements.SETFILTER("Employee Code", Emp."No.");
        PayElements.SETRANGE(Processed, false);
        if PayElements.FINDFIRST() then
            repeat
                PayElements2.SETRANGE("Employee Code", PayElements."Employee Code");
                PayElements2.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                if PayElements2.FINDFIRST() then
                    repeat
                        PayElements2.Processed := true;
                        PayElements2.MODIFY();
                        if PayElements2."Effective Start Date" <= ProcessingDate then begin
                            case PayElements2."Pay Element Code" of
                                BasicTxt:

                                    PayBasic := PayElements2."Amount / Percent";

                                HRATxt:

                                    PayHRA := PayElements2."Amount / Percent";

                                CATxt:

                                    PayCA := PayElements2."Amount / Percent";

                                CCATxt:

                                    PayCCA := PayElements2."Amount / Percent";

                                SPLALLTxt:

                                    "PaySpl.All." := PayElements2."Amount / Percent";

                                LeaveEncashmentTxt:

                                    PayOthers := PayElements2."Amount / Percent";

                                WFTxt:

                                    PayWF := PayElements2."Amount / Percent";

                                PCFTxt:

                                    PayPCF := PayElements2."Amount / Percent";

                            end;
                            PayGrandTotal := PayBasic + PayHRA + PayCA + PayCCA + "PaySpl.All." + PayOthers + PayWF + PayPCF;
                        end;
                    until PayElements2.NEXT() = 0;
            until PayElements.NEXT() = 0;
    end;

    procedure CalcLeaves();
    var
        EmployeeLeaves: Record "Employee Leaves B2B";
        DetailedLeaves: Record "Detailed Leave Records B2B";
    begin
        PLAvail := 0;
        PLUsed := 0;
        PLRem := 0;
        CLAvail := 0;
        CLUsed := 0;
        CLRem := 0;
        SLAvail := 0;
        SLUsed := 0;
        SLRem := 0;

        DetailedLeaves.RESET();
        DetailedLeaves.SETRANGE("Employee No.", "Monthly Attendance"."Employee Code");
        DetailedLeaves.SETRANGE("Leave Code", PLTxt);
        DetailedLeaves.SETRANGE(Month, "Monthly Attendance"."Pay Slip Month");
        DetailedLeaves.SETRANGE(Year, "Monthly Attendance".Year);
        DetailedLeaves.SETRANGE("Entry Type", DetailedLeaves."Entry Type"::Utilization);
        if DetailedLeaves.FINDFIRST() then
            repeat
                PLUsed := PLUsed + ABS(DetailedLeaves."No. of Leaves");
            until DetailedLeaves.NEXT() = 0;

        EmployeeLeaves.RESET();
        EmployeeLeaves.SETRANGE("No.", "Monthly Attendance"."Employee Code");
        EmployeeLeaves.SETRANGE("Leave Code", PLTxt);
        if EmployeeLeaves.FINDFIRST() then begin
            EmployeeLeaves.CALCFIELDS("No. of Available Leaves");
            PLRem := EmployeeLeaves."No. of Available Leaves";
        end;

        PLAvail := PLRem + PLUsed;

        DetailedLeaves.RESET();
        DetailedLeaves.SETRANGE("Employee No.", "Monthly Attendance"."Employee Code");
        DetailedLeaves.SETRANGE("Leave Code", CLTxt);
        DetailedLeaves.SETRANGE(Month, "Monthly Attendance"."Pay Slip Month");
        DetailedLeaves.SETRANGE(Year, "Monthly Attendance".Year);
        DetailedLeaves.SETRANGE("Entry Type", DetailedLeaves."Entry Type"::Utilization);
        if DetailedLeaves.FINDFIRST() then
            repeat
                CLUsed := CLUsed + ABS(DetailedLeaves."No. of Leaves");
            until DetailedLeaves.NEXT() = 0;

        EmployeeLeaves.RESET();
        EmployeeLeaves.SETRANGE("No.", "Monthly Attendance"."Employee Code");
        EmployeeLeaves.SETRANGE("Leave Code", CLTxt);
        if EmployeeLeaves.FINDFIRST() then begin
            EmployeeLeaves.CALCFIELDS("No. of Available Leaves");
            CLRem := EmployeeLeaves."No. of Available Leaves";
        end;

        CLAvail := CLRem + CLUsed;

        DetailedLeaves.RESET();
        DetailedLeaves.SETRANGE("Employee No.", "Monthly Attendance"."Employee Code");
        DetailedLeaves.SETRANGE("Leave Code", SLTxt);
        DetailedLeaves.SETRANGE(Month, "Monthly Attendance"."Pay Slip Month");
        DetailedLeaves.SETRANGE(Year, "Monthly Attendance".Year);
        DetailedLeaves.SETRANGE("Entry Type", DetailedLeaves."Entry Type"::Utilization);
        if DetailedLeaves.FINDFIRST() then
            repeat
                SLUsed := SLUsed + ABS(DetailedLeaves."No. of Leaves");
            until DetailedLeaves.NEXT() = 0;

        EmployeeLeaves.RESET();
        EmployeeLeaves.SETRANGE("No.", "Monthly Attendance"."Employee Code");
        EmployeeLeaves.SETRANGE("Leave Code", PLTxt);
        if EmployeeLeaves.FINDFIRST() then begin
            EmployeeLeaves.CALCFIELDS("No. of Available Leaves");
            SLRem := EmployeeLeaves."No. of Available Leaves";
        end;

        SLAvail := SLRem + SLUsed;
    end;
}

