report 33001260 "Pay Register requried B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Pay Register requried.rdlc';
    Caption = 'Pay Register requried';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            RequestFilterFields = "No.";
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo__Post_Code_; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(INDIACaption; INDIACaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Pay_RegisterCaption; Pay_RegisterCaptionLbl)
            {
            }
            column(BasicCaption; BasicCaptionLbl)
            {
            }
            column(HRACaption; HRACaptionLbl)
            {
            }
            column(DACaption; DACaptionLbl)
            {
            }
            column(CCACaption; CCACaptionLbl)
            {
            }
            column(Misc_AdditionsCaption; Misc_AdditionsCaptionLbl)
            {
            }
            column(Gross_PayCaption; Gross_PayCaptionLbl)
            {
            }
            column(PFCaption; PFCaptionLbl)
            {
            }
            column(ESICaption; ESICaptionLbl)
            {
            }
            column(PTCaption; PTCaptionLbl)
            {
            }
            column(LoansCaption; LoansCaptionLbl)
            {
            }
            column(Misc_DeductionsCaption; Misc_DeductionsCaptionLbl)
            {
            }
            column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
            {
            }
            column(Net_PayCaption; Net_PayCaptionLbl)
            {
            }
            column(Emp_NoCaption; Emp_NoCaptionLbl)
            {
            }
            column(Emp__NameCaption; Emp__NameCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
            dataitem("Processed Salary"; "Processed Salary B2B")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.") ORDER(Ascending);
                RequestFilterFields = Year;
                column(GrossPay; GrossPay)
                {
                }
                column(ESI; ESI)
                {
                }
                column(PF; PF)
                {
                }
                column(PT; PT)
                {
                }
                column(IncTax; IncTax)
                {
                }
                column(MissDedu; "Miss.Dedu")
                {
                }
                column(Loan; Loan)
                {
                }
                column(TestVar; ESI + PF + PT + IncTax + "Miss.Dedu" + Loan)
                {
                }
                column(NetDedu; NetDedu)
                {
                }
                column(TotalBasic; TotalBasic)
                {
                }
                column(TotalDA; TotalDA)
                {
                }
                column(TotalCCA; TotalCCA)
                {
                }
                column(TotalOtherAdditions; TotalOtherAdditions)
                {
                }
                column(TotalBonus; TotalBonus)
                {
                }
                column(TotalEXGratia; "TotalEX-Gratia")
                {
                }
                column(TotalGratuity; TotalGratuity)
                {
                }
                column(TotalOT; TotalOT)
                {
                }
                column(TotalCompOff; TotalCompOff)
                {
                }
                column(TotalGrossPay; TotalGrossPay)
                {
                }
                column(TotalIncTax; TotalIncTax)
                {
                }
                column(TotalPF; TotalPF)
                {
                }
                column(TotalESI; TotalESI)
                {
                }
                column(TotalPT; TotalPT)
                {
                }
                column(TotalLoan; TotalLoan)
                {
                }
                column(TotalMiss_Dedu_; "TotalMiss.Dedu")
                {
                }
                column(ToalNetDedu; ToalNetDedu)
                {
                }
                column(TotalNetSal; TotalNetSal)
                {
                }
                column(TotalHRA; TotalHRA)
                {
                }
                column(Processed_Salary__Employee_Name_; "Employee Name")
                {
                }
                column(Processed_Salary__Employee_Code_; "Employee Code")
                {
                }
                column(Processed_Salary_Document_Type; "Document Type")
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
                    SerialNo += 1;
                    case "Add/Deduct Code" of
                        Text0033Txt:
                            begin
                                Basic := "Earned Amount";
                                TotalBasic := TotalBasic + Basic;
                            end;
                        Text0034Txt:
                            begin
                                Bonus := "Earned Amount";
                                TotalBonus := TotalBonus + Bonus;
                            end;
                        Text0035Txt:
                            begin
                                DA := "Earned Amount";
                                TotalDA := TotalDA + DA;
                            end;
                        Text0036Txt:
                            begin
                                EA := "Earned Amount";
                                TotalEA := TotalEA + EA;
                            end;
                        Text0037Txt:
                            begin
                                HRA := "Earned Amount";
                                TotalHRA := TotalHRA + HRA;
                            end;
                        Text0038Txt:
                            begin
                                ESI := "Earned Amount";
                                TotalESI := TotalESI + ESI;
                                CoESI := "Co. Contributions" + "Co. Contribution2";
                                TotalCoESI := TotalCoESI + CoESI;
                            end;
                        Text0039Txt:
                            begin
                                "EX-Gratia" := "Earned Amount";
                                "TotalEX-Gratia" := "TotalEX-Gratia" + "EX-Gratia";
                            end;
                        Text0040Txt:
                            begin
                                Gratuity := "Earned Amount";
                                TotalGratuity := TotalGratuity + Gratuity;
                            end;
                        Text0041Txt:
                            begin
                                Loan := "Earned Amount";
                                TotalLoan := TotalLoan + Loan;
                            end;
                        Text0042Txt:
                            begin
                                OT := "Earned Amount";
                                TotalOT := TotalOT + OT;
                            end;
                        Text0043Txt:
                            begin
                                PF := "Earned Amount";
                                TotalPF := TotalPF + PF;
                                CoPF := "Co. Contributions" + "Co. Contribution2";
                                TotalCoPF := TotalCoPF + CoPF;
                            end;
                        Text0044Txt:
                            begin
                                PT := "Earned Amount";
                                TotalPT := TotalPT + PT;
                            end;
                        Text0045Txt:
                            begin
                                IncTax := "Earned Amount";
                                TotalIncTax := TotalIncTax + IncTax;
                            end;
                        Text0046Txt:
                            begin
                                HRA := "Earned Amount";
                                TotalHRA := TotalHRA + HRA;
                            end;
                        Text0047Txt:
                            begin
                                CCA := "Earned Amount";
                                TotalCCA := TotalCCA + CCA;
                            end;
                        Text0048Txt:
                            begin
                                INS := "Earned Amount";
                                TotalINS := TotalINS + INS;
                            end;
                        Text0049Txt:
                            begin
                                CompOff := "Earned Amount";
                                TotalCompOff := TotalCompOff + CompOff;
                            end;
                        Text0050Txt:
                            begin
                                CA := "Earned Amount";
                                TotalCA := TotalCA + CA;
                            end;
                        Text0051Txt:
                            begin
                                LTA := "Earned Amount";
                                TotalLta := TotalLta + LTA;
                            end;
                        Text0052Txt:
                            begin
                                OtherAdditions := "Earned Amount";
                                TotalOtherAdditions := TotalOtherAdditions + CompOff;
                            end;
                        Text0053Txt:
                            begin
                                FVA := "Earned Amount";
                                TotalFVA := TotalFVA + FVA;
                            end;
                        Text0054Txt:
                            begin
                                SA := "Earned Amount";
                                TotalSA := TotalSA + SA;
                            end;
                        Text0055Txt:
                            begin
                                PI := "Earned Amount";
                                TotalPI := TotalPI + PI;
                            end;
                        Text0056Txt:
                            begin
                                Medical := "Earned Amount";
                                TotalMedical := TotalMedical + Medical;
                            end;
                        Text0057Txt:
                            begin
                                IT := "Earned Amount";
                                TotalIT := TotalIT + IT;
                            end;
                        Text0058Txt:
                            begin
                                ADV := "Earned Amount";
                                TotalADv := TotalADv + ADV;
                            end;
                    end;

                    MonthlyAttendance.RESET();
                    MonthlyAttendance.SETRANGE("Employee Code", "Employee B2B"."No.");
                    MonthlyAttendance.SETRANGE("Pay Slip Month", "Pay Slip Month");
                    MonthlyAttendance.SETRANGE(Year, "Processed Salary".Year);
                    if MonthlyAttendance.FINDFIRST() then;
                    StartingDay := DMY2DATE(1, "Processed Salary"."Pay Slip Month", "Processed Salary".Year);
                    EnddingDay := CALCDATE(Text0059Txt, StartingDay);

                    if PrintToExcel then begin
                        RowNo := RowNo + 1;
                        EnterCell(RowNo, 1, FORMAT(SerialNo), false, false, false);
                        EnterCell(RowNo, 2, FORMAT("Employee B2B"."No."), false, false, false);
                        EnterCell(RowNo, 3, "Processed Salary"."Employee Name", false, false, false);
                        EnterCell(RowNo, 4, FORMAT("Employee B2B"."Employment Date"), false, false, false);
                        EnterCell(RowNo, 5, "Employee B2B".Designation, false, false, false);
                        EnterCell(RowNo, 6, "Employee B2B"."Department Code", false, false, false);
                        EnterCell(RowNo, 7, FORMAT(MonthlyAttendance.Days), false, false, false);
                        EnterCell(RowNo, 8, FORMAT(StartingDay - EnddingDay), false, false, false);
                        EnterCell(RowNo, 9, FORMAT(MonthlyAttendance."Loss Of Pay"), false, false, false);
                        EnterCell(RowNo, 10, FORMAT(MonthlyAttendance.Leaves), false, false, false);
                        EnterCell(RowNo, 11, FORMAT(MonthlyAttendance.Days + MonthlyAttendance.Leaves - MonthlyAttendance."Loss Of Pay"), false, false, false);
                        EnterCell(RowNo, 12, FORMAT(TotalBasic), false, false, false);
                        EnterCell(RowNo, 13, FORMAT(TotalHRA), false, false, false);
                        EnterCell(RowNo, 14, FORMAT(TotalCA), false, false, false);
                        EnterCell(RowNo, 15, FORMAT(TotalEA), false, false, false);
                        EnterCell(RowNo, 16, FORMAT(TotalCCA), false, false, false);
                        EnterCell(RowNo, 17, FORMAT(TotalLta), false, false, false);
                        EnterCell(RowNo, 18, FORMAT(TotalMedical), false, false, false);
                        EnterCell(RowNo, 19, FORMAT(TotalFVA), false, false, false);
                        EnterCell(RowNo, 20, FORMAT(TotalSA), false, false, false);
                        EnterCell(RowNo, 21, FORMAT(TotalPI), false, false, false);
                        TotalSum := TotalBasic + TotalHRA + TotalCA + TotalCA + TotalEA + TotalCCA + TotalLta + TotalMedical + TotalFVA + TotalSA + TotalPI;
                        EnterCell(RowNo, 22, FORMAT(TotalSum), false, false, false);
                        EnterCell(RowNo, 23, FORMAT((TotalBasic / MonthlyAttendance.Days) * (StartingDay - EnddingDay)), false, false, false);
                        EnterCell(RowNo, 24, FORMAT(((TotalSum) / MonthlyAttendance.Days) * (StartingDay - EnddingDay)), false, false, false);
                        EnterCell(RowNo, 25, FORMAT(((TotalBasic / MonthlyAttendance.Days) * (StartingDay - EnddingDay) * 0.12)), false, false, false);
                        EnterCell(RowNo, 26, FORMAT(TotalIT), false, false, false);
                        if (TotalSum) < 5000 then
                            PT := 0
                        else
                            if (TotalSum) < 6000 then
                                PT := 60
                            else
                                if (TotalSum) < 10000 then
                                    PT := 80
                                else
                                    if (TotalSum) < 15000 then
                                        PT := 100
                                    else
                                        if (TotalSum) < 20000 then
                                            PT := 150
                                        else
                                            if (TotalSum) >= 20000 then
                                                PT := 200;
                        EnterCell(RowNo, 27, FORMAT(PT), false, false, false);
                        EnterCell(RowNo, 28, FORMAT(TotalINS), false, false, false);
                        EnterCell(RowNo, 29, FORMAT(TotalADv), false, false, false);
                        TotalDedSum := ((TotalBasic / MonthlyAttendance.Days) * (StartingDay - EnddingDay)) * 0.12 + TotalIT + PT + TotalINS + TotalADv;
                        EnterCell(RowNo, 30, FORMAT(TotalDedSum), false, false, false);
                        NetPayTot := (TotalSum / MonthlyAttendance.Days) * (StartingDay - EnddingDay) - TotalDedSum;
                        EnterCell(RowNo, 31, FORMAT(NetPayTot), false, false, false);
                    end;
                end;

                trigger OnPostDataItem();
                begin
                    GrossPay := TotalBonus + TotalDA + TotalHRA + TotalCCA + TotalBonus + "TotalEX-Gratia" +
                                TotalGratuity + TotalOT + TotalCompOff + TotalOtherAdditions;
                    NetDedu := TotalESI + TotalPF + TotalPT + TotalIncTax + "Miss.Dedu" + TotalLoan;
                    NetSalary := GrossPay - NetDedu;
                    TotalGrossPay := TotalGrossPay + GrossPay;
                    ToalNetDedu := ToalNetDedu + NetDedu;
                    TotalNetSal := TotalNetSal + NetSalary;
                end;

                trigger OnPreDataItem();
                begin
                    "Processed Salary".SETRANGE("Employee Code", "Employee B2B"."No.");
                    TotalBasic := 0;
                    TotalBonus := 0;
                    TotalDA := 0;
                    TotalESI := 0;
                    "TotalEX-Gratia" := 0;
                    TotalGratuity := 0;
                    TotalLoan := 0;
                    TotalOT := 0;
                    TotalPF := 0;
                    TotalPT := 0;
                    TotalIncTax := 0;
                    TotalHRA := 0;
                    TotalCCA := 0;
                    "TotalMiss.Dedu" := 0;
                    TotalCompOff := 0;
                    TotalOtherAdditions := 0;
                    TotalGrossPay := 0;
                    ToalNetDedu := 0;
                    TotalNetSal := 0;
                end;
            }

            trigger OnPostDataItem();
            begin
                if PrintToExcel then begin
                    TempExcelBuffer.CreateNewBook(Pay_RegisterCaptionLbl);
                    TempExcelBuffer.WriteSheet(Pay_RegisterCaptionLbl, COMPANYNAME(), USERID());
                    TempExcelBuffer.CloseBook();
                    TempExcelBuffer.OpenExcel();
                end;
            end;

            trigger OnPreDataItem();
            var
                CompanyInfo: record 79;
            begin
                companyinfo.get();
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                CLEAR(ColumnNo);
                CLEAR(RowNo);
                CLEAR(TempExcelBuffer);

                RowNo := 0;
                if PrintToExcel then begin
                    EnterCell(1, 6, CompanyInfo.Name, true, false, false);
                    EnterCell(2, 6, Pay_RegisterCaptionLbl, true, false, false);
                    RowNo := 2;
                end;

                if PrintToExcel then begin
                    RowNo := RowNo + 1;
                    EnterCell(RowNo, 1, Text000Txt, true, false, false);
                    EnterCell(RowNo, 2, Text001Txt, true, false, false);
                    EnterCell(RowNo, 4, Text002Txt, true, false, false);
                    EnterCell(RowNo, 3, Text003Txt, true, false, false);
                    EnterCell(RowNo, 5, Text004Txt, true, false, false);
                    EnterCell(RowNo, 6, Text005Txt, true, false, false);
                    EnterCell(RowNo, 7, Text006Txt, true, false, false);
                    EnterCell(RowNo, 8, Text007Txt, true, false, false);
                    EnterCell(RowNo, 9, Text008Txt, true, false, false);
                    EnterCell(RowNo, 10, Text009Txt, true, false, false);
                    EnterCell(RowNo, 11, Text0010Txt, true, false, false);
                    EnterCell(RowNo, 12, Text0011Txt, true, false, false);
                    EnterCell(RowNo, 13, Text0012Txt, true, false, false);
                    EnterCell(RowNo, 14, Text0013Txt, true, false, false);
                    EnterCell(RowNo, 15, Text0014Txt, true, false, false);
                    EnterCell(RowNo, 16, Text0015Txt, true, false, false);
                    EnterCell(RowNo, 17, Text0016Txt, true, false, false);
                    EnterCell(RowNo, 18, Text0017Txt, true, false, false);
                    EnterCell(RowNo, 19, Text0018Txt, true, false, false);
                    EnterCell(RowNo, 20, Text0019Txt, true, false, false);
                    EnterCell(RowNo, 21, Text0020Txt, true, false, false);
                    EnterCell(RowNo, 22, Text0021Txt, true, false, false);
                    EnterCell(RowNo, 23, Text0022Txt, true, false, false);
                    EnterCell(RowNo, 24, Text0023Txt, true, false, false);
                    EnterCell(RowNo, 25, Text0024Txt, true, false, false);
                    EnterCell(RowNo, 26, Text0025Txt, true, false, false);
                    EnterCell(RowNo, 27, Text0026Txt, true, false, false);
                    EnterCell(RowNo, 28, Text0027Txt, true, false, false);
                    EnterCell(RowNo, 29, Text0028Txt, true, false, false);
                    EnterCell(RowNo, 30, Text0029Txt, true, false, false);
                    EnterCell(RowNo, 31, Text0030Txt, true, false, false);
                    EnterCell(RowNo, 32, Text0031Txt, true, false, false);
                    EnterCell(RowNo, 33, Text0032Txt, true, false, false);
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Print To Excel"; PrintToExcel)
                {
                    ToolTip = 'check mark the feild to print in the excel';
                    Caption = 'Print To Excel';
                    ApplicationArea = all;
                }
            }
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
        CLEAR(TempExcelBuffer);
        TempExcelBuffer.DELETEALL();
        CLEAR(RowNo);
    end;

    var

        TempExcelBuffer: Record "Excel Buffer";
        CompanyInfo: Record "Company Information";
        MonthlyAttendance: Record "Monthly Attendance B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Basic: Decimal;
        HRA: Decimal;
        CCA: Decimal;
        CA: Decimal;
        ESI: Decimal;
        PF: Decimal;
        IT: Decimal;
        PT: Decimal;
        IncTax: Decimal;
        GrossPay: Decimal;
        NetSalary: Decimal;
        TotalBasic: Decimal;
        TotalHRA: Decimal;
        TotalOT: Decimal;
        TotalCCA: Decimal;
        TotalCA: Decimal;
        OT: Decimal;
        NetDedu: Decimal;
        TotalPF: Decimal;
        TotalESI: Decimal;
        TotalPT: Decimal;
        TotalIncTax: Decimal;
        ToalNetDedu: Decimal;
        TotalNetSal: Decimal;
        TotalGrossPay: Decimal;
        CoPF: Decimal;
        CoESI: Decimal;
        TotalCoPF: Decimal;
        TotalCoESI: Decimal;
        SerialNo: Integer;

        Bonus: Decimal;
        DA: Decimal;
        "EX-Gratia": Decimal;
        Gratuity: Decimal;
        Loan: Decimal;
        "Miss.Dedu": Decimal;
        CompOff: Decimal;
        TotalBonus: Decimal;
        TotalDA: Decimal;
        "TotalEX-Gratia": Decimal;
        TotalGratuity: Decimal;
        TotalLoan: Decimal;
        "TotalMiss.Dedu": Decimal;
        TotalCompOff: Decimal;
        OtherAdditions: Decimal;
        TotalOtherAdditions: Decimal;
        PrintToExcel: Boolean;
        ColumnNo: Integer;
        RowNo: Integer;
        StartingDay: Date;
        EnddingDay: Date;
        EA: Decimal;
        TotalEA: Decimal;
        LTA: Decimal;
        TotalLta: Decimal;
        TotalMedical: Decimal;
        TotalFVA: Decimal;
        TotalSA: Decimal;
        TotalPI: Integer;
        FVA: Decimal;
        PI: Decimal;
        SA: Decimal;
        Medical: Decimal;
        TotalIT: Decimal;
        INS: Decimal;
        TotalINS: Decimal;
        ADV: Decimal;
        TotalADv: Decimal;
        TotalDedSum: Decimal;
        TotalSum: Decimal;
        NetPayTot: Decimal;
        INDIACaptionLbl: Label 'INDIA';
        EmptyStringCaptionLbl: Label '.';
        Pay_RegisterCaptionLbl: Label 'Pay Register';
        BasicCaptionLbl: Label 'Basic';
        HRACaptionLbl: Label 'HRA';
        DACaptionLbl: Label 'DA';
        CCACaptionLbl: Label 'CCA';
        Misc_AdditionsCaptionLbl: Label 'Misc Additions';
        Gross_PayCaptionLbl: Label 'Gross Pay';
        PFCaptionLbl: Label 'PF';
        ESICaptionLbl: Label 'ESI';
        PTCaptionLbl: Label 'PT';
        LoansCaptionLbl: Label 'Loans';
        Misc_DeductionsCaptionLbl: Label 'Misc Deductions';
        Total_DeductionsCaptionLbl: Label 'Total Deductions';
        Net_PayCaptionLbl: Label 'Net Pay';
        Emp_NoCaptionLbl: Label 'Emp.No';
        Emp__NameCaptionLbl: Label 'Emp. Name';
        Text000Txt: Label 'S.No';
        Text001Txt: Label 'Emp Code';
        Text002Txt: Label 'Date of Joining';
        Text003Txt: Label 'EMP Name';
        Text004Txt: Label 'Designation';
        Text005Txt: Label 'Grade';
        Text006Txt: Label 'Department';
        Text007Txt: Label 'Work Days in a Month';
        Text008Txt: Label 'Days Present';
        Text009Txt: Label 'Days LOP';
        Text0010Txt: Label 'LWP';
        Text0011Txt: Label 'Payable Days';
        Text0012Txt: Label 'BASIC';
        Text0013Txt: Label 'HRA';
        Text0014Txt: Label 'CON. ALL';
        Text0015Txt: Label 'EA';
        Text0016Txt: Label 'CCA';
        Text0017Txt: Label 'LTA';
        Text0018Txt: Label 'Medical';
        Text0019Txt: Label 'FVA';
        Text0020Txt: Label 'SA';
        Text0021Txt: Label 'PI';
        Text0022Txt: Label 'Total Gross- MG2';
        Text0023Txt: Label 'Earned Basic';
        Text0024Txt: Label 'Total Earned';
        Text0025Txt: Label 'PF @12%';
        Text0026Txt: Label 'IT';
        Text0027Txt: Label 'PT';
        Text0028Txt: Label 'INS';
        Text0029Txt: Label 'Adv';
        Text0030Txt: Label 'TOT DENS';
        Text0031Txt: Label 'NET PAY';
        Text0032Txt: Label 'PAY SLIP';
        Text0033Txt: Label 'BASIC';
        Text0034Txt: Label 'BONUS';
        Text0035Txt: Label 'DA';
        Text0036Txt: Label 'EA';
        Text0037Txt: Label 'HRA';
        Text0038Txt: Label 'ESI';
        Text0039Txt: Label 'EX-GRATIA';
        Text0040Txt: Label 'GRATUITY';
        Text0041Txt: Label 'SALARY ADVANCE';
        Text0042Txt: Label 'OT';
        Text0043Txt: Label 'PF';
        Text0044Txt: Label 'PT';
        Text0045Txt: Label 'TDS';
        Text0046Txt: Label 'HRA';
        Text0047Txt: Label 'CCA';
        Text0048Txt: Label 'INS';
        Text0049Txt: Label 'C OFF';
        Text0050Txt: Label 'CA';
        Text0051Txt: Label 'LTA';
        Text0052Txt: Label 'OTHER ADDITIONS';
        Text0053Txt: Label 'FVA';
        Text0054Txt: Label 'SPL. All';
        Text0055Txt: Label 'PI';
        Text0056Txt: Label 'Medical';
        Text0057Txt: Label 'TDS';
        Text0058Txt: Label 'ADV';
        Text0059Txt: Label '<+1M>';

    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean);
    begin
        TempExcelBuffer.INIT();
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.INSERT();
    end;
}

