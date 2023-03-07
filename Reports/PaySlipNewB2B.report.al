report 33001246 "Pay Slip New B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Pay Slip B2B New.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Monthly Attendance"; "Monthly Attendance B2B")
        {
            DataItemTableView = SORTING("Employee Code", "Pay Slip Month", Year) ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Employee Code", "Pay Slip Month", Year;
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address_CompanyInfo__Address_2______CompanyInfo_City; CompanyInfo.Address + CompanyInfo."Address 2" + ',' + CompanyInfo.City)
            {
            }
            column(District___State_Description_____CountryName___PIN___CompanyInfo__Post_Code_; 'District,' + CountryName + '.PIN:' + CompanyInfo."Post Code")
            {
            }
            column(Tel____CompanyInfo__Phone_No__; 'Tel :' + CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Monthly_Attendance__Employee_Code_; "Employee Name")
            {
            }
            column(Designation; Designation)
            {
            }
            column(Department_; LookUps.Description)
            {
            }
            column(WorkingDays; WorkingDays)
            {
            }
            column(Monthly_Attendance__Employee_Code__Control1102152006; "Employee Code")
            {
            }
            column(FORMAT__Pay_Slip_For_The_Month_of_______Month_____FORMAT_Year__; FORMAT('Pay Slip For The Month of' + '  ' + Month + ' ' + FORMAT(Year)))
            {
            }
            column(TotalDaysinaMonth; TotalDaysinaMonth)
            {
            }
            column(PAY_SLIPCaption; PAY_SLIPCaptionLbl)
            {
            }
            column(Monthly_Attendance__Employee_Code_Caption; Monthly_Attendance__Employee_Code_CaptionLbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(Employee_CodeCaption; Employee_CodeCaptionLbl)
            {
            }
            column(EARNINGSCaption; EARNINGSCaptionLbl)
            {
            }
            column(DEDUCTIONSCaption; DEDUCTIONSCaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(PARTICULARSCaption; PARTICULARSCaptionLbl)
            {
            }
            column(PARTICULARSCaption_Control1102152045; PARTICULARSCaption_Control1102152045Lbl)
            {
            }
            column(AMOUNTCaption_Control1102152046; AMOUNTCaption_Control1102152046Lbl)
            {
            }
            column(Payable_DaysCaption; Payable_DaysCaptionLbl)
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
                column(PayBasic; PayBasic)
                {
                }
                column(PayHRA; PayHRA)
                {
                }
                column(PayCA; PayCA)
                {
                }
                column(PayCCA; PayCCA)
                {
                }
                column(PaySpl_All__; "PaySpl.All.")
                {
                }
                column(PF; PF)
                {
                }
                column(PayEA; PayEA)
                {
                }
                column(PayPI; PayPI)
                {
                }
                column(PayLTA; PayLTA)
                {
                }
                column(PayFVA; PayFVA)
                {
                }
                column(PayMedical; PayMedical)
                {
                }
                column(PT; PT)
                {
                }
                column(INSUrance; INSUrance)
                {
                }
                column(IT; IT)
                {
                }
                column(Advance; Advance)
                {
                }
                column(TotalGross; TotalGross)
                {
                }
                column(PayGrandTotal_TotalDed; PayGrandTotal + TotalDed)
                {
                }
                column(TotalDed; TotalDed)
                {
                }
                column(PayGrandTotal; PayGrandTotal)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
                {
                }
                column(BasicCaption; BasicCaptionLbl)
                {
                }
                column(HRACaption; HRACaptionLbl)
                {
                }
                column(ConveyanceCaption; ConveyanceCaptionLbl)
                {
                }
                column(Children_Eduaction_AllowanceCaption; Children_Eduaction_AllowanceCaptionLbl)
                {
                }
                column(City_Compensatory_AllowanceCaption; City_Compensatory_AllowanceCaptionLbl)
                {
                }
                column(Special_AllowanceCaption; Special_AllowanceCaptionLbl)
                {
                }
                column(Performance_Linked_IncrementCaption; Performance_Linked_IncrementCaptionLbl)
                {
                }
                column(LTACaption; LTACaptionLbl)
                {
                }
                column(MedicalCaption; MedicalCaptionLbl)
                {
                }
                column(FVACaption; FVACaptionLbl)
                {
                }
                column(PF_Caption; PF_CaptionLbl)
                {
                }
                column(ProfessionTax_Caption; ProfessionTax_CaptionLbl)
                {
                }
                column(Insurance_Caption; Insurance_CaptionLbl)
                {
                }
                column(InsuranceTax_Caption; InsuranceTax_CaptionLbl)
                {
                }
                column(Advance_Caption; Advance_CaptionLbl)
                {
                }
                column(TotalGrossLBL; "Total Gross :Lbl")
                {
                }
                column(TotalEarnedLBL; "Total Earned :Lbl")
                {
                }
                column(NetPayableLBL; "Net Payable :Lbl")
                {
                }
                column(TotalDeductionsLBL; "Total Deductions :Lbl")
                {
                }
                column(MANAGERHR; "MANAGER-HRLbl")
                {
                }
                column(DateLBL; "Date :Lbl")
                {
                }
                column(This_is_computer_generated_slip_hence_signature_not_required_Caption; This_is_computer_generated_slip_hence_signature_not_required_CaptionLbl)
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
                        INSTxt:
                            INSUrance := "Earned Amount";
                        ADVTxt:
                            Advance := "Earned Amount";
                        PITxt:
                            PI := "Earned Amount";
                        EATxt:
                            EA := "Earned Amount";
                        LTATxt:
                            LTA := "Earned Amount";
                        FVATxt:
                            FVA := "Earned Amount";
                    end;
                    TotalGross := Basic + HRA + CA + CCA + "Spl.All." + +PI + EA + LTA + FVA;
                    TotalDed := PF + INSUrance + IT + PT + Advance;
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
                        PayEA := 0;
                        PayLTA := 0;
                        PayPI := 0;
                        PayFVA := 0;
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
                    INSUrance := 0;
                    Advance := 0;
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

            trigger OnPreDataItem();
            begin
                Employee.RESET();
                if EmpNo <> '' then
                    Employee.SETRANGE("No.", EmpNo);
                if PhyLoc <> '' then
                    Employee.SETRANGE("Physical Location", PhyLoc);
                if Dept <> '' then
                    Employee.SETRANGE("Department Code", Dept);
                Employee.SETRANGE(Blocked, false);
                if Employee.FINDFIRST() then
                    repeat
                        if "Monthly Attendance".GET(Employee."No.", CurrMon, CurrYear, 0) then
                            "Monthly Attendance".MARK(true);
                    until Employee.NEXT() = 0;

                "Monthly Attendance".MARKEDONLY(true);
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {

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
        CountryRegion.RESET();
        CountryRegion.SETRANGE(Code, CompanyInfo."Country/Region Code");
        if CountryRegion.FINDFIRST() then
            CountryName := CountryRegion.Name;
    end;

    trigger OnPreReport();
    begin
        Year := "Processed Salary".Year;
    end;

    var
        Employee: Record "Employee B2B";
        CountryRegion: Record "Country/Region";
        CompanyInfo: Record "Company Information";
        PayElements: Record "Pay Elements B2B";
        LookUps: Record Lookup_B2B;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
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
        TotalDed: Integer;
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
        PayEA: Decimal;
        PayLTA: Decimal;
        PayPI: Decimal;
        PayFVA: Decimal;
        INSUrance: Decimal;
        Advance: Decimal;
        TotalGross: Decimal;
        PI: Decimal;
        EA: Decimal;
        LTA: Decimal;
        FVA: Decimal;
        CountryName: Text[50];
        TotalDaysinaMonth: Integer;
        PhyLoc: Code[20];
        Dept: Code[20];
        EmpNo: Code[20];
        CurrMon: Integer;
        CurrYear: Integer;

        PAY_SLIPCaptionLbl: Label 'PAY SLIP';
        Monthly_Attendance__Employee_Code_CaptionLbl: Label 'Name of the Employee';
        DesignationCaptionLbl: Label 'Designation';
        DepartmentCaptionLbl: Label 'Department';
        Employee_CodeCaptionLbl: Label 'Employee Code';
        EARNINGSCaptionLbl: Label 'EARNINGS';
        DEDUCTIONSCaptionLbl: Label 'DEDUCTIONS';
        AMOUNTCaptionLbl: Label 'AMOUNT';
        PARTICULARSCaptionLbl: Label 'PARTICULARS';
        PARTICULARSCaption_Control1102152045Lbl: Label 'PARTICULARS';
        AMOUNTCaption_Control1102152046Lbl: Label 'AMOUNT';
        Payable_DaysCaptionLbl: Label 'Payable Days';
        BasicCaptionLbl: Label 'Basic';
        HRACaptionLbl: Label 'HRA';
        ConveyanceCaptionLbl: Label 'Conveyance Allowance';
        Children_Eduaction_AllowanceCaptionLbl: Label 'Children Eduaction Allowance';
        City_Compensatory_AllowanceCaptionLbl: Label 'City Compensatory Allowance';
        Special_AllowanceCaptionLbl: Label 'Special Allowance';
        Performance_Linked_IncrementCaptionLbl: Label 'Performance Linked Increment';
        LTACaptionLbl: Label 'LTA';
        MedicalCaptionLbl: Label 'Medical';
        FVACaptionLbl: Label 'FVA';
        PF_CaptionLbl: Label 'PF';
        ProfessionTax_CaptionLbl: Label 'Profession Tax';
        Insurance_CaptionLbl: Label 'Insurance';
        InsuranceTax_CaptionLbl: Label 'Insurance Tax';
        Advance_CaptionLbl: Label 'Advance';
        "Total Gross :Lbl": Label 'Total Gross :';
        "Total Earned :Lbl": Label 'Total Earned :';
        "Net Payable :Lbl": Label 'Net Payable :';
        "Total Deductions :Lbl": Label 'Total Deductions :';
        "MANAGER-HRLbl": Label 'MANAGER-HR';
        "Date :Lbl": Label 'Date :';
        This_is_computer_generated_slip_hence_signature_not_required_CaptionLbl: Label '* This is computer generated slip hence signature not required.';
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
        INSTxt: Label 'INS';
        ADVTxt: Label 'ADV';
        PITxt: Label 'PI';
        EATxt: Label 'EA';
        LTATxt: Label 'LTA';
        FVATxt: Label 'FVA';

    procedure CalcPayElements(Emp: Record "Employee B2B"; ProcessingDate: Date);
    var        
        PayElements2: Record "Pay Elements B2B";
    begin
        PayElements.reset();
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

                                EATxt:

                                    PayEA := PayElements2."Amount / Percent";

                                LTATxt:

                                    PayLTA := PayElements2."Amount / Percent";

                                PITxt:

                                    PayPI := PayElements2."Amount / Percent";

                                FVATxt:

                                    PayFVA := PayElements2."Amount / Percent";

                            end;
                            PayGrandTotal := PayBasic + PayHRA + PayCA + PayCCA + "PaySpl.All."
                                                      + PayOthers + PayEA + PayLTA + PayFVA + PayPI;
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

    procedure SetValues(PhysicalLocationLVar: Code[20]; DeptLvar: Code[20]; EmployeeNoLVar: Code[20]; CurrMonLVar: Integer; CurrYearLVar: Integer);
    begin
        PhyLoc := PhysicalLocationLVar;
        Dept := DeptLvar;
        EmpNo := EmployeeNoLVar;
        CurrMon := CurrMonLVar;
        CurrYear := CurrYearLVar;
    end;
}

