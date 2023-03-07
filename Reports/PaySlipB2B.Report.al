report 33001215 "Pay Slip"
{
    // Project :
    // ***************************************************
    // SIGN
    // ***************************************************
    // B2B  : B2B Software Technologies Ltd.
    // ***************************************************
    // No.     sign     Date           UserId       Description
    // ***********************************************************
    // 400     B2B.SB     26-NOV-19       Bhavya      Report is Created to get data Dynamically for each Employee.
    // 412     HR7.2      25-AUG-20       Preetham    Multiple Locations code added.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PaySlipB2B.rdl';
    Caption = 'Pay Slips';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Monthly Attendance B2B"; "Monthly Attendance B2B")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Employee Code", "Pay Slip Month", Year;
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyCaption; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(SalaryDays_Caption; SalaryDays_CaptionLbl)
            {
            }
            column(Monthly_Attendance__Employee_Code_; "Employee Code")
            {
            }
            column(Monthly_Attendance__Employee_Name_; "Employee Name")
            {
            }
            column(Department_Caption; Department_CaptionLbl)
            {
            }
            column(DIM_Name; Employee."Department Code")
            {
            }
            column(WorkingDays; WorkingDays)
            {
            }
            column(PFNum; Employee."PF No")
            {
            }
            column(PresentDays; "Monthly Attendance b2b".Attendance)
            {
            }
            column(WorkingDaysCaption; WorkingDaysCaption)
            {
            }
            column(PaymentDetailCaption; PaymentDetailCaption)
            {
            }
            column(ModeofPaymentCaption; ModeofPaymentCaption)
            {
            }
            column(BankDetailCaption; BankDetailCaption)
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(BankAccnoCaption; BankAccnoCaption)
            {
            }
            column(BankName; Employee."Bank Name")
            {
            }
            column(AccountType; Employee."Payment Method")
            {
            }
            column(AccountNo; Employee."Account No")
            {
            }
            column(EmploymentDate; Employee."Employment Date")
            {
            }
            column(NetSalary; NetSalaryCaptionLbl)
            {
            }
            column(DtofJoining; DtofJoining)
            {
            }
            column(UANNoCaption; UANNoCaption)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT__Pay_Slip_For_The_Month_of_______Month_____FORMAT_Year__; FORMAT('Pay Slip For The Month of' + '  ' + Month + ' ' + FORMAT(Year)))
            {
            }
            column(UAN_No; Employee."UAN No.")
            {
            }
            column(Designation; Employee.Designation)
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
            column(Monthly_Attendance__Employee_Code_Caption; FIELDCAPTION("Employee Code"))
            {
            }
            column(Monthly_Attendance__Employee_Name_Caption; FIELDCAPTION("Employee Name"))
            {
            }
            column(AttendanceCaption; AttendanceCaptionLbl)
            {
            }
            column(Name; Name)
            {
            }
            column(Rs_Caption; Rs_CaptionLbl)
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
            column(EarningsCaption; EarningsCaptionLbl)
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
            column(DeductionsCaption; DeductionsCaptionLbl)
            {
            }
            column(Monthly_Attendance_Year; Year)
            {
            }
            column(ActualsCaption; ActualsCaptionLbl)
            {
            }
            column(Basic; BasicCaptionLbl)
            {
            }
            column(Description; Desc_CaptionLbl)
            {
            }
            column(Monthly_Attendance_Line_No_; "Line No.")
            {
            }
            column(GrossPayCaption; GrossPayablesCaption)
            {
            }
            column(Location_Address; Location.Address)
            {
            }
            column(Location_Address2; Location."Address 2")
            {
            }
            column(PayableDays; "Monthly Attendance b2b".Days)
            {
            }
            column(Holidays; "Monthly Attendance b2b".Holidays)
            {
            }
            column(HolidaysCaption; HolidaysCaptionLbl)
            {
            }
            column(Location; LocationEmp)
            {
            }
            column(LocationCaption; LocationCaptionLbl)
            {
            }
            column(Birth_Date; Employee."Birth Date")
            {
            }
            column(BirthDateCaption; BirthDateCaptionLbl)
            {
            }
            column(Weekly_Off; "Monthly Attendance b2b"."Weekly Off")
            {
            }
            column(WeeklyOffCaption; WeeklyOffCaptionLbl)
            {
            }
            column(Leaves; "Monthly Attendance b2b".Leaves)
            {
            }
            column(LeaveCaption; LeaveCaptionLbl)
            {
            }
            column(PAN_No; Employee."PAN No")
            {
            }
            column(PanNoCaption; PanNoCaptionLbl)
            {
            }
            column(ESINum; Employee."ESI No")
            {
            }
            column(PTCaption; PTCaptionLbl)
            {
            }
            column(TDSCaption; TDSCaptionLbl)
            {
            }
            column(SalaryAdvanceCaption; SalaryAdvanceCaptionLbl)
            {
            }
            column(GrossEarningsCaption; GrossEarningsCaptionLbl)
            {
            }
            column(GrossDeductionsCaption; GrossDeductionsCaptionLbl)
            {
            }
            column(HRACaption; HRACaptionLbl)
            {
            }
            column(TptCaption; TptCaptionLbl)
            {
            }
            column(OtherCaption; OtherCaptionLbl)
            {
            }
            column(LWPCaption; LWPCaptionLbl)
            {
            }
            column(NetSalaryWordCaption; NetSalaryWordCaptionLbl)
            {
            }
            column(FixedCaption; FixedCaptionLbl)
            {
            }
            column(PayDaysCaption; PayDays_CaptionLbl)
            {
            }
            column(MonthlyAttendance_Days; "Monthly Attendance b2b".Days)
            {
            }
            column(MedicalCaption; MedicalCaptionLbl)
            {
            }
            column(BankNameCaption; BankNameCaptionLbl)
            {
            }
            column(LopCaption; LOPCaptionLbl)
            {
            }
            column(LOP; "Monthly Attendance B2B"."Loss Of Pay")
            {
            }
            column(ArrearDaysCaption; ArrearDaysCaptionLbl)
            {
            }
            column(YTDCaption; YTDCaptionLbl)
            {
            }
            column(PFNOCaption; PFNOCaptionLbl)
            {
            }
            column(NumberText1; NumberText[1])
            {
            }
            dataitem("Employee Leaves B2B"; "Employee Leaves B2B")
            {
                DataItemLinkReference = "Monthly Attendance B2B";
                DataItemLink = "Leave Pay Cadre" = field("Leave Pay Cadre"),
                "No." = field("Employee Code");

                column(No_; "No.")
                { }
                column(Leave_Code; "Leave Code")
                { }
                column(No__of_Available_Leaves; "No. of Available Leaves")
                { }
                column(Used; Used)
                { }
                column(Remaining; Remaining)
                { }
                column(Available; Available)
                { }

                trigger OnAfterGetRecord()
                begin
                    Clear(Used);
                    Clear(Available);
                    Clear(Remaining);

                    DetailedLeaveRecordsB2B.Reset();
                    DetailedLeaveRecordsB2B.SetRange("Leave Code", "Leave Code");
                    DetailedLeaveRecordsB2B.SetRange("Employee No.", "Employee Leaves B2B"."No.");
                    DetailedLeaveRecordsB2B.SetRange("Leave Pay Cadre", "Leave Pay Cadre");
                    DetailedLeaveRecordsB2B.SetFilter("Entry Date", '<=%1', "Monthly Attendance B2B"."Period End Date");
                    if DetailedLeaveRecordsB2B.FindSet() then begin
                        DetailedLeaveRecordsB2B.CalcSums("No. of Leaves");
                        Available := DetailedLeaveRecordsB2B."No. of Leaves";
                    end;

                    DetailedLeaveRecordsB2B.Reset();
                    DetailedLeaveRecordsB2B.SetRange("Leave Pay Cadre", "Leave Pay Cadre");
                    DetailedLeaveRecordsB2B.SetRange("Employee No.", "No.");
                    DetailedLeaveRecordsB2B.SetRange("Leave Code", "Leave Code");
                    DetailedLeaveRecordsB2B.SetRange("Entry Date", "Monthly Attendance B2B"."Period Start Date", "Monthly Attendance B2B"."Period End Date");
                    DetailedLeaveRecordsB2B.SetFilter("Entry Type", '%1', DetailedLeaveRecordsB2B."Entry Type"::Utilization);
                    if DetailedLeaveRecordsB2B.FindSet() then begin
                        DetailedLeaveRecordsB2B.CalcSums("No. of Leaves");
                        Used := abs(DetailedLeaveRecordsB2B."No. of Leaves");
                    end;


                    IF Used <> 0 then
                        Remaining := Available - Used
                    else
                        Remaining := Available;
                end;


            }

            dataitem("Processed Salary"; "Processed Salary B2B")
            {
                DataItemLink = "Employee Code" = FIELD("Employee Code"),
                               "Pay Slip Month" = FIELD("Pay Slip Month"),
                               Year = FIELD(Year);
                column(ShowPriority; Lookup."Show Priority")
                {
                }
                column(EarnedAmount_ProcessedSalary; "Processed Salary"."Earned Amount")
                {
                }
                column(AmountPercentAct; AmountPercentAct)
                {
                }
                column(ShortcutDim2Code_ProcessedSalary; "Processed Salary"."Shortcut Dimension 2 Code")
                {
                }
                column(AddDeduct_ProcessedSalary; "Processed Salary"."Add/Deduct")
                {
                }
                column(AddDeductCode_ProcessedSalary; "Processed Salary"."Add/Deduct Code")
                {
                }
                column(Rs_Caption_Control1102152124; Rs_Caption_Control1102152124Lbl)
                {
                }
                column(Rs_Caption_Control1102152125; Rs_Caption_Control1102152125Lbl)
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
                column(SystemGeneratedMail_Caption; SystemGeneratedMail_CaptionLbl)
                {
                }
                column(Processed_Salary_Line_No_; "Line No.")
                {
                }


                trigger OnAfterGetRecord()
                begin
                    Lookup.RESET;
                    Lookup.SETFILTER("Lookup Type", '%1|%2', 16, 18);
                    Lookup.SETRANGE("Lookup Name", "Processed Salary"."Add/Deduct Code");
                    IF NOT Lookup.FINDFIRST THEN
                        CurrReport.SKIP
                    ELSE BEGIN
                        CASE Lookup."Lookup Type" OF
                            16:
                                BEGIN
                                    IF NOT Lookup."Print in Payslip" THEN
                                        CurrReport.SKIP;
                                END;
                        END;
                    END;

                    IF "Processed Salary"."Add/Deduct" = "Processed Salary"."Add/Deduct"::Addition THEN
                        TotAdditions += "Processed Salary"."Earned Amount"
                    ELSE
                        TotDeduction += "Processed Salary"."Earned Amount";

                    PayElements.RESET;
                    PayElements.SETFILTER("Employee Code", "Processed Salary"."Employee Code");
                    PayElements.SETFILTER("Effective Start Date", '<=%1', "Monthly Attendance b2b"."Period End Date");
                    PayElements.SETRANGE("Pay Element Code", "Add/Deduct Code");
                    PayElements.SETRANGE("Add/Deduct", PayElements."Add/Deduct"::Addition);
                    IF PayElements.FINDLAST THEN BEGIN
                        AmountPercentAct := PayElements."Amount / Percent";
                        TotAmt += AmountPercentAct;
                    END;

                    PostedOtherPayElements.RESET;
                    PostedOtherPayElements.SETRANGE("Employee No.", "Processed Salary"."Employee Code");
                    PostedOtherPayElements.SETRANGE("Pay Element Code", "Processed Salary"."Add/Deduct Code");
                    PostedOtherPayElements.SETRANGE(Month, "Processed Salary"."Pay Slip Month");
                    PostedOtherPayElements.SETRANGE(Year, "Processed Salary".Year);
                    PostedOtherPayElements.SETRANGE("Add/Deduct", PostedOtherPayElements."Add/Deduct"::Addition);
                    IF PostedOtherPayElements.FINDFIRST THEN BEGIN
                        TotAmt += PostedOtherPayElements.Amount;
                        AmountPercentAct := PostedOtherPayElements.Amount;
                    END;



                    CLEAR(NumberText);
                    CheckGRec.InitTextVariable;
                    CheckGRec.FormatNoText(NumberText, ROUND(ABS(TotAdditions - TotDeduction), 1, '='), '');
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(TotAmt);
                    CLEAR(AmountPercentAct);
                    CLEAR(TotAdditions);
                    CLEAR(TotDeduction);
                    CLEAR(TotaFixedAdditions);

                    PayElements.RESET;
                    IF PayElements.FIND('-') THEN
                        REPEAT
                            PayElements.Processed := FALSE;
                            PayElements.MODIFY;
                        UNTIL PayElements.NEXT = 0;
                end;
            }
            dataitem(Integer; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(Monthly_Attendance___Gross_Salary_; "Monthly Attendance b2b"."Gross Salary")
                {
                }
                column(Monthly_Attendance___Net_Salary_; "Monthly Attendance b2b"."Net Salary")
                {
                }
                column(Monthly_Attendance__Deductions; "Monthly Attendance b2b".Deductions)
                {
                }
                column(Gross_SalaryCaption; Gross_SalaryCaptionLbl)
                {
                }
                column(DeductionsCaption_Control1102152066; DeductionsCaption_Control1102152066Lbl)
                {
                }
                column(Authorized_signatureCaption; Authorized_signatureCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
                column(TotAdditions; TotAdditions)
                {
                }
                column(TotDeduction; TotDeduction)
                {
                }
                column(TotAmt; TotAmt)
                {
                }
                column(ProcessedSalary_HA; HA)
                {
                }
                column(ProcessedSalary_Basic; Basic)
                {
                }
                column(ProcessedSalary_TDS; Tds)
                {
                }
                column(ProcessedSalary_PT; PT)
                {
                }
                column(ProcessedSalary_ESI; ESI)
                {
                }
                column(ProcessedSalary_PF; PF)
                {
                }
                column(PayElements_BonusFixed; BonusFixed)
                {
                }
                column(PayElements_BasicFixed; BasicFixed)
                {
                }
                column(PayElements_HRAFixed; HRAFixed)
                {
                }
                column(ProcessedSalary_SPEAL; SpecialAllowances)
                {
                }
                column(ProcessedSalary_SalAdv; SalAdv)
                {
                }
                column(ProcessedSalary_CA; CA)
                {
                }
                column(Payelements_SpeAlFixed; SpeAlFixed)
                {
                }
                column(Payelements_CAFixed; CAFixed)
                {
                }
                column(ProcessedSalary_Medical; Medical)
                {
                }
                column(Payelements_MedicalFixed; MedicalFixed)
                {
                }
                column(TotFixedAdditions; TotaFixedAdditions)
                {
                }
                column(TotBasic; TotBasic)
                {
                }
                //Balance Leaves added>>
                column(AvailableCaption; AvailableCaptionLbl)
                { }
                column(UsedCaption; UsedCaptionLbl)
                { }
                column(RemainingCaption; RemainingCaptionLbl)
                { }
                column(PLRem; PLRem)
                {
                }
                column(CLRem; CLRem)
                {
                }
                column(SLRem; SLRem)
                {
                }
                column(PLUsed; PLUsed)
                {
                }
                column(CLUsed; CLUsed)
                {
                }
                column(SLUsed; SLUsed)
                {
                }
                column(PLAvail; PLAvail)
                {
                }
                column(CLAvail; CLAvail)
                {
                }
                column(SLAvail; SLAvail)
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
                column(SLCaption; SLCaptionLbl)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CalcLeaves();
                end;

            }


            trigger OnAfterGetRecord()
            begin
                CLEAR(WorkingDays);
                CLEAR(PresentDays);
                CLEAR(TotAmt);

                PayrollLocationUsers.GET(USERID);
                Employee.RESET;
                Employee.SETRANGE(Blocked, FALSE);
                Employee.SETRANGE("No.", "Monthly Attendance b2b"."Employee Code");
                IF PayrollLocationUsers."Multiple Locations" <> '' THEN
                    Employee.SETFILTER("Location Code", PayrollLocationUsers."Multiple Locations")
                ELSE
                    Employee.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                IF Employee.FIND('-') THEN BEGIN
                    PFNum := Employee."PF No";
                    ESINum := Employee."ESI No";
                    BankAccNo := Employee."Account No";
                    Name := Employee.FullName;
                    UAN := Employee."UAN No.";
                    LocationEmp := Employee."Physical Location";
                    Department := Employee."Department Code";
                END;


                CALCFIELDS(Days, "Loss Of Pay", Leaves, "C Off Hours", "Weekly Off", Holidays);

                // WorkingDays := Days - "Weekly Off";
                WorkingDays := Days - "Loss Of Pay";//cbs1.0

                IF "Pay Slip Month" = 1 THEN
                    Month := 'January'
                ELSE
                    IF "Pay Slip Month" = 2 THEN
                        Month := 'February'
                    ELSE
                        IF "Pay Slip Month" = 3 THEN
                            Month := 'March'
                        ELSE
                            IF "Pay Slip Month" = 4 THEN
                                Month := 'April'
                            ELSE
                                IF "Pay Slip Month" = 5 THEN
                                    Month := 'May'
                                ELSE
                                    IF "Pay Slip Month" = 6 THEN
                                        Month := 'June'
                                    ELSE
                                        IF "Pay Slip Month" = 7 THEN
                                            Month := 'July'
                                        ELSE
                                            IF "Pay Slip Month" = 8 THEN
                                                Month := 'August'
                                            ELSE
                                                IF "Pay Slip Month" = 9 THEN
                                                    Month := 'September'
                                                ELSE
                                                    IF "Pay Slip Month" = 10 THEN
                                                        Month := 'October'
                                                    ELSE
                                                        IF "Pay Slip Month" = 11 THEN
                                                            Month := 'November'
                                                        ELSE
                                                            IF "Pay Slip Month" = 12 THEN
                                                                Month := 'December';
            end;


            trigger OnPreDataItem()
            begin
                CLEAR(WorkingDays);
                CLEAR(PresentDays);
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

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        Year := "Processed Salary".Year;

        Lookup.RESET;
        Lookup.SETRANGE("Lookup Type", 16);
        Lookup.SETRANGE("Print in Payslip", TRUE);
        IF NOT Lookup.FINDFIRST THEN
            ERROR('Mark atleast 1 payelement as "Print in Payslip" in lookup');


        Year := "Processed Salary".Year;
    end;

    var





        Employee: Record "Employee B2B";
        Month: Text[30];
        Year: Integer;
        PayMonth: Integer;
        DaysPresent: Decimal;
        Designation: Code[50];
        Department: Code[30];
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        PFNum: Text[20];
        ESINum: Text[20];
        BankAccNo: Code[30];
        PayElements: Record "Pay Elements B2B";
        CompanyInfo: Record "Company Information";
        ProcessedSalary2: Record "Processed Salary B2B";
        Lookup: Record Lookup_B2B;
        PayElements2: Record "Pay Elements B2B";
        PayElementsGRec: Record "Pay Elements B2B";
        TotAdditions: Decimal;
        TotDeduction: Decimal;
        AmountPercentAct: Decimal;
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
        PF_No_CaptionLbl: Label 'PF';
        ESI_No_CaptionLbl: Label 'ESI';
        EmptyStringCaption_Control1102152086Lbl: Label ':';
        EmptyStringCaption_Control1102152087Lbl: Label ':';
        EmptyStringCaption_Control1102152088Lbl: Label ':';
        BasicCaptionLbl: Label 'Basic';
        EarningsCaptionLbl: Label 'Earnings';
        HRACaptionLbl: Label 'HRA';
        Bank_Acc_No_CaptionLbl: Label 'Bank Acc.No.';
        DeductionsCaptionLbl: Label 'Gross Deductions';
        ActualsCaptionLbl: Label 'AMOUNT';
        Rs_CaptionLbl: Label 'Rs.';
        Desc_CaptionLbl: Label 'Description';
        Rs_Caption_Control1102152124Lbl: Label 'Rs.';
        Rs_Caption_Control1102152125Lbl: Label 'Rs.';
        Gross_SalaryCaptionLbl: Label 'Gross Salary';
        Net_SalaryCaptionLbl: Label 'Net Pay:';
        DeductionsCaption_Control1102152066Lbl: Label 'Deductions';
        Authorized_signatureCaptionLbl: Label 'Authorized signature';
        TotalCaptionLbl: Label 'Total';
        UANNoCaption: Label 'UAN No.';
        DtofJoining: Label 'Dt. of Joining:';
        GrossPayablesCaption: Label 'GrossPayables';
        PaymentDetailCaption: Label 'Payment Details:-';
        ModeofPaymentCaption: Label 'Mode of Payment';
        BankDetailCaption: Label 'Bank Details';
        BankAccnoCaption: Label 'Bank Acc.No.';
        AmountCaption: Label 'Amount';
        NetSalaryCaption: Label 'Net Salary';
        WorkingDaysCaption: Label 'Working Days';
        SystemGeneratedMail_CaptionLbl: Label 'This is a system generated document, hence no signature is required.';
        SalaryDays_CaptionLbl: Label 'Payable Days';
        TotAmt: Decimal;
        PresentDays: Decimal;
        WorkingDays: Decimal;
        PostedOtherPayElements: Record "Posted Other PayElements B2B";
        Department_CaptionLbl: Label 'Department';
        DIMValue: Record "Dimension Value";
        DimName: Text[80];
        DimValueName: Text[80];
        Name: Text;
        Location: Record Location;
        HolidaysCaptionLbl: Label 'Holidays';
        LocationCaptionLbl: Label 'Location';
        BirthDateCaptionLbl: Label 'Birth Date';
        WeeklyOffCaptionLbl: Label 'Weekly Off';
        LeaveCaptionLbl: Label 'Leave';
        PanNoCaptionLbl: Label 'PAN No';
        PTCaptionLbl: Label 'PROF.TAX';
        TDSCaptionLbl: Label 'TDS';
        SalaryAdvanceCaptionLbl: Label 'Salary Advance';
        GrossEarningsCaptionLbl: Label 'Gross Earnings ';
        GrossDeductionsCaptionLbl: Label 'Gross Deductions';
        TptCaptionLbl: Label 'CA';
        OtherCaptionLbl: Label 'Other/Spl. Allowance';
        LWPCaptionLbl: Label 'LWP';
        NetSalaryWordCaptionLbl: Label 'In Words ';
        FixedCaptionLbl: Label 'ACTUAL';
        Basic: Decimal;
        Tds: Decimal;

        HA: Decimal;

        Bonus: Decimal;
        PayDays_CaptionLbl: Label 'Total Pay Days';
        NetSalaryCaptionLbl: Label 'Net Pay:';
        UAN: Code[20];
        BasicFixed: Decimal;
        HRAFixed: Decimal;
        TptFixed: Decimal;
        BonusFixed: Decimal;
        PayCadre: Code[20];
        LocationEmp: Code[20];
        SpecialAllowances: Decimal;
        SalAdv: Decimal;

        SpeAlFixed: Decimal;
        CAFixed: Decimal;
        MedicalFixed: Decimal;
        Medical: Decimal;
        MedicalCaptionLbl: Label 'Medical Reimbursement';
        TotaFixedAdditions: Decimal;
        PayrollLocationUsers: Record "Payroll Location Users B2B";
        BankNameCaptionLbl: Label 'Bank Name';
        LOPCaptionLbl: Label 'Total LOP Days';
        ArrearDaysCaptionLbl: Label 'Arrear Days';
        YTDCaptionLbl: Label 'YTD';
        PFNOCaptionLbl: Label 'PF Account No.';
        ProcessedSalary3: Record "Processed Salary B2B";
        TotBasic: Decimal;
        CheckGRec: Codeunit "Approval Mgmt B2B";

        NumberText: array[2] of Text;
        //Balance Leaves added>>
        Leave_TypeCaptionLbl: Label 'Leave Type';
        AvailableCaptionLbl: Label 'Available';
        UsedCaptionLbl: Label 'Used';
        RemainingCaptionLbl: Label 'Remaining';
        Used: Decimal;
        Remaining: Decimal;
        PLAvail: Decimal;
        PLUsed: Decimal;
        PLRem: Decimal;
        CLAvail: Decimal;
        CLUsed: Decimal;
        CLRem: Decimal;
        SLAvail: Decimal;
        SLUsed: Decimal;
        SLRem: Decimal;

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
        "Other Ded.": Decimal;
        WF: Decimal;
        PCF: Decimal;

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
        CD: Decimal;
        PFCaptionLbl: Label 'PF';
        ESICaptionLbl: Label 'ESI';
        CCACaptionLbl: Label 'CCA';
        CACaptionLbl: Label 'CA';
        WFCaptionLbl: Label 'WF';
        Spl_All_CaptionLbl: Label 'Spl All.';
        OthersCaptionLbl: Label 'Others';
        CanteenCaptionLbl: Label 'Canteen';
        Other_Ded_CaptionLbl: Label 'Other Ded.';
        BasicCaption_Control1102152099Lbl: Label 'Basic';
        HRACaption_Control1102152104Lbl: Label 'HRA';
        CACaption_Control1102152105Lbl: Label 'CA';
        CCACaption_Control1102152106Lbl: Label 'CCA';
        Spl_All_Caption_Control1102152108Lbl: Label 'Spl All.';
        OthersCaption_Control1102152109Lbl: Label 'Others';
        CDCaptionLbl: Label 'CD';
        PCFCaptionLbl: Label 'PCF';
        Medical_CaptionLbl: Label '"Medical "';
        Medical_Caption_Control1102154003Lbl: Label '"Medical "';
        PLCaptionLbl: Label 'PL';
        CLCaptionLbl: Label 'CL';
        SLCaptionLbl: Label 'SL';
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
        MEDALLTxt: Label 'MED. ALL';
        TDSTxt: Label 'TDS';
        CDTxt: Label 'CD';
        WFTxt: Label 'WF';
        PCFTxt: Label 'PCF';
        TELEPHONETxt: Label 'TELEPHONE';
        SALARYADVANCETxt: Label 'SALARY ADVANCE';
        PLTxt: Label 'PL';
        CLTxt: Label 'CL';
        SLTxt: Label 'SL';
        DetailedLeaveRecordsB2B: Record "Detailed Leave Records B2B";
        No_of_Leaves: Decimal;
        Available: Decimal;








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

                                MEDALLTxt:

                                    PayMedical := PayElements2."Amount / Percent";

                            end;
                            PayGrandTotal := PayBasic + PayHRA + PayCA + PayCCA + "PaySpl.All." + PayOthers + PayMedical;
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
        DetailedLeaves.SETRANGE("Employee No.", "Monthly Attendance B2B"."Employee Code");
        DetailedLeaves.SETRANGE("Leave Code", PLTxt);
        DetailedLeaves.SETRANGE(Month, "Monthly Attendance B2B"."Pay Slip Month");
        DetailedLeaves.SETRANGE(Year, "Monthly Attendance B2B".Year);
        DetailedLeaves.SETRANGE("Entry Type", DetailedLeaves."Entry Type"::Utilization);
        if DetailedLeaves.FINDFIRST() then
            repeat
                PLUsed := PLUsed + ABS(DetailedLeaves."No. of Leaves");
            until DetailedLeaves.NEXT() = 0;

        EmployeeLeaves.RESET();
        EmployeeLeaves.SETRANGE("No.", "Monthly Attendance B2B"."Employee Code");
        EmployeeLeaves.SETRANGE("Leave Code", PLTxt);
        if EmployeeLeaves.FINDFIRST() then begin
            EmployeeLeaves.CALCFIELDS("No. of Available Leaves");
            PLRem := EmployeeLeaves."No. of Available Leaves";
        end;

        PLAvail := PLRem + PLUsed;

        DetailedLeaves.RESET();
        DetailedLeaves.SETRANGE("Employee No.", "Monthly Attendance B2B"."Employee Code");
        DetailedLeaves.SETRANGE("Leave Code", CLTxt);
        DetailedLeaves.SETRANGE(Month, "Monthly Attendance B2B"."Pay Slip Month");
        DetailedLeaves.SETRANGE(Year, "Monthly Attendance B2B".Year);
        DetailedLeaves.SETRANGE("Entry Type", DetailedLeaves."Entry Type"::Utilization);
        if DetailedLeaves.FINDFIRST() then
            repeat
                CLUsed := CLUsed + ABS(DetailedLeaves."No. of Leaves");
            until DetailedLeaves.NEXT() = 0;

        EmployeeLeaves.RESET();
        EmployeeLeaves.SETRANGE("No.", "Monthly Attendance B2B"."Employee Code");
        EmployeeLeaves.SETRANGE("Leave Code", CLTxt);
        if EmployeeLeaves.FINDFIRST() then begin
            EmployeeLeaves.CALCFIELDS("No. of Available Leaves");
            CLRem := EmployeeLeaves."No. of Available Leaves";
        end;

        CLAvail := CLRem + CLUsed;

        DetailedLeaves.RESET();
        DetailedLeaves.SETRANGE("Employee No.", "Monthly Attendance B2B"."Employee Code");
        DetailedLeaves.SETRANGE("Leave Code", SLTxt);
        DetailedLeaves.SETRANGE(Month, "Monthly Attendance B2B"."Pay Slip Month");
        DetailedLeaves.SETRANGE(Year, "Monthly Attendance B2B".Year);
        DetailedLeaves.SETRANGE("Entry Type", DetailedLeaves."Entry Type"::Utilization);
        if DetailedLeaves.FINDFIRST() then
            repeat
                SLUsed := SLUsed + ABS(DetailedLeaves."No. of Leaves");
            until DetailedLeaves.NEXT() = 0;

        EmployeeLeaves.RESET();
        EmployeeLeaves.SETRANGE("No.", "Monthly Attendance B2B"."Employee Code");
        EmployeeLeaves.SETRANGE("Leave Code", PLTxt);
        if EmployeeLeaves.FINDFIRST() then begin
            EmployeeLeaves.CALCFIELDS("No. of Available Leaves");
            SLRem := EmployeeLeaves."No. of Available Leaves";
        end;

        SLAvail := SLRem + SLUsed;
    end;

    procedure CalcPF();
    begin
        ProcessedSalary2.RESET();
        ProcessedSalary2.SETRANGE("Employee Code", "Monthly Attendance B2B"."Employee Code");
        ProcessedSalary2.SETRANGE("Pay Slip Month", "Monthly Attendance B2B"."Pay Slip Month");
        ProcessedSalary2.SETRANGE(Year, "Monthly Attendance B2B".Year);
        if ProcessedSalary2.FINDFIRST() then
            repeat
                case ProcessedSalary2."Add/Deduct Code" of
                    PFTxt:
                        PF := ProcessedSalary2."Earned Amount";
                    BasicTxt:
                        Basic := ProcessedSalary2."Earned Amount";
                    DATxt:
                        DA := ProcessedSalary2."Earned Amount";
                    HRATxt:
                        HRA := ProcessedSalary2."Earned Amount";
                    CATxt:
                        CA := ProcessedSalary2."Earned Amount";
                    CCATxt:
                        CCA := ProcessedSalary2."Earned Amount";
                    SPLALLTxt:
                        "Spl.All." := ProcessedSalary2."Earned Amount";
                    LeaveEncashmentTxt:
                        Others := ProcessedSalary2."Earned Amount";
                    ESITxt:
                        ESI := ProcessedSalary2."Earned Amount";
                    PTTxt:
                        PT := ProcessedSalary2."Earned Amount";
                    CANDEDTxt:
                        Canteen := ProcessedSalary2."Earned Amount";
                    SALADVTxt:
                        "Salary Adv." := ProcessedSalary2."Earned Amount";
                    MEDALLTxt:
                        "Medical Loan" := ProcessedSalary2."Earned Amount";
                    TDSTxt:
                        IT := ProcessedSalary2."Earned Amount";
                    CDTxt:
                        CD := ProcessedSalary2."Earned Amount";
                    WFTxt:
                        WF := ProcessedSalary2."Earned Amount";
                    PCFTxt:
                        PCF := ProcessedSalary2."Earned Amount";
                    TELEPHONETxt:
                        "Other Ded." += ProcessedSalary2."Earned Amount";
                    SALARYADVANCETxt:
                        "Other Ded." += ProcessedSalary2."Earned Amount";
                end
            until ProcessedSalary2.NEXT() = 0;
    end;
}
