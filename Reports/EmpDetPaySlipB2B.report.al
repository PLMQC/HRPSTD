report 33001225 "EmpDet_Pay Slip B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\EmpDet_Pay Slip.rdlc';
    Caption = 'EmpDet_Pay Slip';
    ShowPrintStatus = false;
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
            column(Monthly_Attendance__Monthly_Attendance__PayCadre; "Monthly Attendance".PayCadre)
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
            column(PFNum; PFNum)
            {
            }
            column(ESINum; ESINum)
            {
            }
            column(BankAccNo; BankAccNo)
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
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152077; EmptyStringCaption_Control1102152077Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152078; EmptyStringCaption_Control1102152078Lbl)
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
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(ESI_No_Caption; ESI_No_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152086; EmptyStringCaption_Control1102152086Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152087; EmptyStringCaption_Control1102152087Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152088; EmptyStringCaption_Control1102152088Lbl)
            {
            }
            column(Bank_Acc_No_Caption; Bank_Acc_No_CaptionLbl)
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
                column(Basic; Basic)
                {
                }
                column(DA; DA)
                {
                }
                column(HRA; HRA)
                {
                }
                column(CCA; CCA)
                {
                }
                column(VDA; VDA)
                {
                }
                column(CA; CA)
                {
                }
                column(WA; WA)
                {
                }
                column(Spl_All__; "Spl.All.")
                {
                }
                column(Others; Others)
                {
                }
                column(OT; OT)
                {
                }
                column(IT; IT)
                {
                }
                column(PT; PT)
                {
                }
                column(Canteen; Canteen)
                {
                }
                column(Salary_Adv__; "Salary Adv.")
                {
                }
                column(Staff_Adv__; "Staff Adv.")
                {
                }
                column(Vehicle_Loan_; "Vehicle Loan")
                {
                }
                column(Medical_Loan_; "Medical Loan")
                {
                }
                column(Other_Ded__; "Other Ded.")
                {
                }
                column(Hire_Charges_; "Hire Charges")
                {
                }
                column(Inst__Loan_; "Inst. Loan")
                {
                }
                column(PF; PF)
                {
                }
                column(ESI; ESI)
                {
                }
                column(PayBasic; PayBasic)
                {
                }
                column(PayFDA; PayFDA)
                {
                }
                column(PayVDA; PayVDA)
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
                column(PayWA; PayWA)
                {
                }
                column(PaySpl_All__; "PaySpl.All.")
                {
                }
                column(PayOthers; PayOthers)
                {
                }
                column(AttReg; AttReg)
                {
                }
                column(Monthly_Attendance___Gross_Salary_; "Monthly Attendance"."Gross Salary")
                {
                }
                column(Monthly_Attendance___Net_Salary_; "Monthly Attendance"."Net Salary")
                {
                }
                column(Monthly_Attendance__Deductions; "Monthly Attendance".Deductions)
                {
                }
                column(Monthly_Attendance___Net_Salary__Control1102152089; "Monthly Attendance"."Net Salary")
                {
                }
                column(PayGrandTotal; PayGrandTotal)
                {
                }
                column(EarningsCaption; EarningsCaptionLbl)
                {
                }
                column(BasicCaption; BasicCaptionLbl)
                {
                }
                column(FDACaption; FDACaptionLbl)
                {
                }
                column(HRACaption; HRACaptionLbl)
                {
                }
                column(DeductionsCaption; DeductionsCaptionLbl)
                {
                }
                column(PFCaption; PFCaptionLbl)
                {
                }
                column(ESICaption; ESICaptionLbl)
                {
                }
                column(CCACaption; CCACaptionLbl)
                {
                }
                column(VDACaption; VDACaptionLbl)
                {
                }
                column(CACaption; CACaptionLbl)
                {
                }
                column(WACaption; WACaptionLbl)
                {
                }
                column(Spl_All_Caption; Spl_All_CaptionLbl)
                {
                }
                column(OthersCaption; OthersCaptionLbl)
                {
                }
                column(OTCaption; OTCaptionLbl)
                {
                }
                column(ITCaption; ITCaptionLbl)
                {
                }
                column(PTCaption; PTCaptionLbl)
                {
                }
                column(CanteenCaption; CanteenCaptionLbl)
                {
                }
                column(Salary_Adv_Caption; Salary_Adv_CaptionLbl)
                {
                }
                column(Staff_Adv_Caption; Staff_Adv_CaptionLbl)
                {
                }
                column(Vehicle_LoanCaption; Vehicle_LoanCaptionLbl)
                {
                }
                column(Medical_LoanCaption; Medical_LoanCaptionLbl)
                {
                }
                column(Other_Ded_Caption; Other_Ded_CaptionLbl)
                {
                }
                column(Hire_ChargesCaption; Hire_ChargesCaptionLbl)
                {
                }
                column(Inst__LoanCaption; Inst__LoanCaptionLbl)
                {
                }
                column(RateCaption; RateCaptionLbl)
                {
                }
                column(BasicCaption_Control1102152099; BasicCaption_Control1102152099Lbl)
                {
                }
                column(FDACaption_Control1102152100; FDACaption_Control1102152100Lbl)
                {
                }
                column(VDACaption_Control1102152103; VDACaption_Control1102152103Lbl)
                {
                }
                column(HRACaption_Control1102152104; HRACaption_Control1102152104Lbl)
                {
                }
                column(CACaption_Control1102152105; CACaption_Control1102152105Lbl)
                {
                }
                column(CCACaption_Control1102152106; CCACaption_Control1102152106Lbl)
                {
                }
                column(WACaption_Control1102152107; WACaption_Control1102152107Lbl)
                {
                }
                column(Spl_All_Caption_Control1102152108; Spl_All_Caption_Control1102152108Lbl)
                {
                }
                column(OthersCaption_Control1102152109; OthersCaption_Control1102152109Lbl)
                {
                }
                column(Att_Reg_Caption; Att_Reg_CaptionLbl)
                {
                }
                column(Rs_Caption; Rs_CaptionLbl)
                {
                }
                column(Rs_Caption_Control1102152124; Rs_Caption_Control1102152124Lbl)
                {
                }
                column(Rs_Caption_Control1102152125; Rs_Caption_Control1102152125Lbl)
                {
                }
                column(Gross_SalaryCaption; Gross_SalaryCaptionLbl)
                {
                }
                column(Net_SalaryCaption; Net_SalaryCaptionLbl)
                {
                }
                column(DeductionsCaption_Control1102152066; DeductionsCaption_Control1102152066Lbl)
                {
                }
                column(Net_pay_Rs_Caption; Net_pay_Rs_CaptionLbl)
                {
                }
                column(has_been_Credited_to_your_above_Bank_AccountCaption; has_been_Credited_to_your_above_Bank_AccountCaptionLbl)
                {
                }
                column(Employee_SignatureCaption; Employee_SignatureCaptionLbl)
                {
                }
                column(OthersCaption_Control1102152120; OthersCaption_Control1102152120Lbl)
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
                        FDATxt:
                            DA := "Earned Amount";
                        VDATxt:
                            VDA := "Earned Amount";
                        HRATxt:
                            HRA := "Earned Amount";
                        CATxt:
                            CA := "Earned Amount";
                        CCATxt:
                            CCA := "Earned Amount";
                        WATxt:
                            WA := "Earned Amount";
                        SPELALLTxt:
                            "Spl.All." := "Earned Amount";
                        LeaveEncashmentTxt:
                            Others := "Earned Amount";
                        PFTxt:
                            PF := "Earned Amount";
                        ESITxt:
                            ESI := "Earned Amount";
                        OTTxt:
                            OT := "Earned Amount";
                        PTTxt:
                            PT := "Earned Amount";
                        VLTxt:
                            "Vehicle Loan" := "Earned Amount";
                        CANTDEDTxt:
                            Canteen := "Earned Amount";
                        HCTxt:
                            "Hire Charges" := "Earned Amount";
                        STFLOANTxt:
                            "Staff Adv." := "Earned Amount";
                        SALADVTxt:
                            "Salary Adv." := "Earned Amount";
                        MLTxt:
                            "Medical Loan" := "Earned Amount";
                        TDSTxt:
                            IT := "Earned Amount";
                        VLINSTxt:
                            INS := "Earned Amount";
                        LCDTxt:
                            AttReg := "Earned Amount";
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
                        PayWA := 0;
                        PayFDA := 0;
                        PayVDA := 0;
                        "PaySpl.All." := 0;
                        PayOthers := 0;
                        CalcPayElements(Employee, "Monthly Attendance"."Period End Date");
                    end;

                    Basic := 0;
                    DA := 0;
                    VDA := 0;
                    HRA := 0;
                    CA := 0;
                    CCA := 0;
                    WA := 0;
                    "Spl.All." := 0;
                    Others := 0;
                    OT := 0;
                    PF := 0;
                    ESI := 0;
                    PT := 0;
                    "Vehicle Loan" := 0;
                    Canteen := 0;
                    "Hire Charges" := 0;
                    "Staff Adv." := 0;
                    "Salary Adv." := 0;
                    "Medical Loan" := 0;
                    IT := 0;
                    INS := 0;
                    AttReg := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
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
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'EmpDet_Pay Slip';

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

    trigger OnPreReport();
    begin

        Year := "Processed Salary".Year;
    end;

    var
        Employee: Record "Employee B2B";
        PayElements: Record "Pay Elements B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Month: Text[30];
        Year: Integer;
        Basic: Decimal;
        DA: Decimal;
        HRA: Decimal;
        CCA: Decimal;
        VDA: Decimal;
        CA: Decimal;
        WA: Decimal;
        "Spl.All.": Decimal;
        OT: Decimal;
        Others: Decimal;
        ESI: Decimal;
        PF: Decimal;
        IT: Decimal;
        PT: Decimal;
        Canteen: Decimal;
        "Salary Adv.": Decimal;
        "Staff Adv.": Decimal;
        "Vehicle Loan": Decimal;
        "Medical Loan": Decimal;
        "Other Ded.": Decimal;
        "Hire Charges": Decimal;
        "Inst. Loan": Decimal;
        INS: Decimal;
        DaysPresent: Decimal;
        Designation: Code[50];
        Department: Code[30];
        PFNum: Text[20];
        ESINum: Text[20];
        BankAccNo: Code[30];
        PayBasic: Decimal;
        PayFDA: Decimal;
        PayVDA: Decimal;
        PayHRA: Decimal;
        PayCA: Decimal;
        PayCCA: Decimal;
        PayWA: Decimal;
        "PaySpl.All.": Decimal;
        PayOthers: Decimal;
        PayGrandTotal: Decimal;

        AttReg: Decimal;

        AttendanceCaptionLbl: Label 'Attendance';
        GradeCaptionLbl: Label 'Grade';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102152077Lbl: Label ':';
        EmptyStringCaption_Control1102152078Lbl: Label ':';
        EmptyStringCaption_Control1102152012Lbl: Label ':';
        DesignationCaptionLbl: Label 'Designation';
        EmptyStringCaption_Control1102152039Lbl: Label ':';
        DepartmentCaptionLbl: Label 'Department';
        EmptyStringCaption_Control1102152082Lbl: Label ':';
        PF_No_CaptionLbl: Label 'PF No.';
        ESI_No_CaptionLbl: Label 'ESI No.';
        EmptyStringCaption_Control1102152086Lbl: Label ':';
        EmptyStringCaption_Control1102152087Lbl: Label ':';
        EmptyStringCaption_Control1102152088Lbl: Label ':';
        Bank_Acc_No_CaptionLbl: Label 'Bank Acc.No.';
        EarningsCaptionLbl: Label 'Earnings';
        BasicCaptionLbl: Label 'Basic';
        FDACaptionLbl: Label 'FDA';
        HRACaptionLbl: Label 'HRA';
        DeductionsCaptionLbl: Label 'Deductions';
        PFCaptionLbl: Label 'PF';
        ESICaptionLbl: Label 'ESI';
        CCACaptionLbl: Label 'CCA';
        VDACaptionLbl: Label 'VDA';
        CACaptionLbl: Label 'CA';
        WACaptionLbl: Label 'WA';
        Spl_All_CaptionLbl: Label 'Spl All.';
        OthersCaptionLbl: Label 'Others';
        OTCaptionLbl: Label 'OT';
        ITCaptionLbl: Label 'IT';
        PTCaptionLbl: Label 'PT';
        CanteenCaptionLbl: Label 'Canteen';
        Salary_Adv_CaptionLbl: Label 'Salary Adv.';
        Staff_Adv_CaptionLbl: Label 'Staff Adv.';
        Vehicle_LoanCaptionLbl: Label 'Vehicle Loan';
        Medical_LoanCaptionLbl: Label 'Medical Loan';
        Other_Ded_CaptionLbl: Label 'Other Ded.';
        Hire_ChargesCaptionLbl: Label 'Hire Charges';
        Inst__LoanCaptionLbl: Label 'Inst. Loan';
        RateCaptionLbl: Label 'Rate';
        BasicCaption_Control1102152099Lbl: Label 'Basic';
        FDACaption_Control1102152100Lbl: Label 'FDA';
        VDACaption_Control1102152103Lbl: Label 'VDA';
        HRACaption_Control1102152104Lbl: Label 'HRA';
        CACaption_Control1102152105Lbl: Label 'CA';
        CCACaption_Control1102152106Lbl: Label 'CCA';
        WACaption_Control1102152107Lbl: Label 'WA';
        Spl_All_Caption_Control1102152108Lbl: Label 'Spl All.';
        OthersCaption_Control1102152109Lbl: Label 'Others';
        Att_Reg_CaptionLbl: Label 'Att.Reg.';
        Rs_CaptionLbl: Label 'Rs.';
        Rs_Caption_Control1102152124Lbl: Label 'Rs.';
        Rs_Caption_Control1102152125Lbl: Label 'Rs.';
        Gross_SalaryCaptionLbl: Label 'Gross Salary';
        Net_SalaryCaptionLbl: Label 'Net Salary';
        DeductionsCaption_Control1102152066Lbl: Label 'Deductions';
        Net_pay_Rs_CaptionLbl: Label 'Net pay Rs.';
        has_been_Credited_to_your_above_Bank_AccountCaptionLbl: Label 'has been Credited to your above Bank Account';
        Employee_SignatureCaptionLbl: Label 'Employee Signature';
        OthersCaption_Control1102152120Lbl: Label 'Others';
        FDATxt: Label 'FDA';
        HRATxt: Label 'HRA';
        CATxt: Label 'CA';
        CCATxt: Label 'CCA';
        WATxt: Label 'WA';
        SPELALLTxt: Label 'SPELALL';
        LeaveEncashmentTxt: Label 'Leave Encashment';
        BasicTxt: Label 'BASIC';

        PFTxt: Label 'PF';
        ESITxt: Label 'ESI';
        PTTxt: Label 'PT';
        SALADVTxt: Label 'SALADV';
        TDSTxt: Label 'TDS';
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
        VDATxt: Label 'VDA';
        OTTxt: Label 'OT';
        LCDTxt: Label 'LCD';
        HCTxt: Label 'HC';
        STFLOANTxt: Label 'STFLOAN';
        MLTxt: Label 'ML';
        VLTxt: Label 'VL';
        CANTDEDTxt: Label 'CANTDED';
        VLINSTxt: Label 'VLINS';

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

                                WATxt:

                                    PayWA := PayElements2."Amount / Percent";

                                FDATxt:

                                    PayFDA := PayElements2."Amount / Percent";

                                VDATxt:

                                    PayVDA := PayElements2."Amount / Percent";

                                SPELALLTxt:

                                    "PaySpl.All." := PayElements2."Amount / Percent";

                                LeaveEncashmentTxt:

                                    PayOthers := PayElements2."Amount / Percent";

                            end;
                            PayGrandTotal := PayBasic + PayHRA + PayCA + PayCCA + PayWA + PayFDA + PayVDA + "PaySpl.All." + PayOthers;
                        end;
                    until PayElements2.NEXT() = 0;
            until PayElements.NEXT() = 0;
    end;
}

