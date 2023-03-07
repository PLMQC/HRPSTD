report 33001218 Reconcilation_B2B
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Reconcilation.rdlc';
    Caption = 'Reconcilation';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Processed Salary"; "Processed Salary B2B")
        {
            RequestFilterFields = "Pay Slip Month", Year;
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(FORMAT__Reconcilation_For_The_Month_of_______Month_____FORMAT_Year__; FORMAT('Reconcilation For The Month of' + '  ' + Month + ' ' + FORMAT(Year)))
            {
            }
            column(TotalBasic; TotalBasic)
            {
            }
            column(TotalHRA; TotalHRA)
            {
            }
            column(TotalCA; TotalCA)
            {
            }
            column(TotalWA; TotalWA)
            {
            }
            column(TotalCCA; TotalCCA)
            {
            }
            column(TotalVDA; TotalVDA)
            {
            }
            column(TotalFDA; TotalFDA)
            {
            }
            column(TotalOT; TotalOT)
            {
            }
            column(TotalSPELALL; TotalSPELALL)
            {
            }
            column(TotalOtherall; TotalOtherall)
            {
            }
            column(TotalAttendRegu; TotalAttendRegu)
            {
            }
            column(NetAdditions; NetAdditions)
            {
            }
            column(TotalCoContrib; TotalCoContrib)
            {
            }
            column(TotalCoContrib2; TotalCoContrib2)
            {
            }
            column(TotalVDlI; TotalVDlI)
            {
            }
            column(TotalRIFA; TotalRIFA)
            {
            }
            column(TotalPFAdminChar; TotalPFAdminChar)
            {
            }
            column(TotalOfTheseFields; TotalOfTheseFields)
            {
            }
            column(TotalFromProcessedSal; TotalFromProcessedSal)
            {
            }
            column(Total_BasicCaption; Total_BasicCaptionLbl)
            {
            }
            column(Total_HRACaption; Total_HRACaptionLbl)
            {
            }
            column(Total_CACaption; Total_CACaptionLbl)
            {
            }
            column(Total_WACaption; Total_WACaptionLbl)
            {
            }
            column(Total_CCACaption; Total_CCACaptionLbl)
            {
            }
            column(Total_VDACaption; Total_VDACaptionLbl)
            {
            }
            column(Total_FDACaption; Total_FDACaptionLbl)
            {
            }
            column(Total_OTCaption; Total_OTCaptionLbl)
            {
            }
            column(Total_Spel_AllCaption; Total_Spel_AllCaptionLbl)
            {
            }
            column(Total_Other_AllCaption; Total_Other_AllCaptionLbl)
            {
            }
            column(Total_Attend_ReguCaption; Total_Attend_ReguCaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(Total_CoContributionsCaption; Total_CoContributionsCaptionLbl)
            {
            }
            column(Total_CoContributions2Caption; Total_CoContributions2CaptionLbl)
            {
            }
            column(Total_RIFACaption; Total_RIFACaptionLbl)
            {
            }
            column(Total_EDLI_ChargesCaption; Total_EDLI_ChargesCaptionLbl)
            {
            }
            column(Total_PF_Admin_ChargesCaption; Total_PF_Admin_ChargesCaptionLbl)
            {
            }
            column(TOTALCaption_Control1102152036; TOTALCaption_Control1102152036Lbl)
            {
            }
            column(GRAND_TOTALCaption; GRAND_TOTALCaptionLbl)
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
                SETRANGE(Posted, true);
                case "Add/Deduct Code" of
                    BasicTxt:
                        begin
                            TotalBasic := TotalBasic + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    HRATxt:
                        begin
                            TotalHRA := TotalHRA + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    WATxt:
                        begin
                            TotalWA := TotalWA + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    CATxt:
                        begin
                            TotalCA := TotalCA + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    VDATxt:
                        begin
                            TotalVDA := TotalVDA + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    FDATxt:
                        begin
                            TotalFDA := TotalFDA + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    OTTxt:
                        begin
                            TotalOT := TotalOT + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    SPELALLTxt:
                        begin
                            TotalSPELALL := TotalSPELALL + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    CCATxt:
                        begin
                            TotalCCA := TotalCCA + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    OTHALLTxt:
                        begin
                            TotalOtherall := TotalOtherall + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                    ATTDREGUTxt:
                        begin
                            TotalAttendRegu := TotalAttendRegu + "Earned Amount";
                            NetAdditions := NetAdditions + "Earned Amount";
                        end;
                end;
                TotalCoContrib := TotalCoContrib + "Co. Contributions";
                TotalCoContrib2 := TotalCoContrib2 + "Co. Contribution2";
                TotalPFAdminChar := TotalPFAdminChar + "PF Admin Charges";
                TotalVDlI := TotalVDlI + "EDLI Charges";
                TotalRIFA := TotalRIFA + "RIFA Charges";
                TotalOfTheseFields := TotalOfTheseFields + "Co. Contributions" + "Co. Contribution2" + "PF Admin Charges" +
                                                  "EDLI Charges" + "RIFA Charges";
                TotalFromProcessedSal := NetAdditions + TotalOfTheseFields;

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
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());

                TotalBasic := 0;
                TotalCA := 0;
                TotalHRA := 0;
                TotalWA := 0;
                TotalCCA := 0;
                TotalVDA := 0;
                TotalFDA := 0;
                TotalOT := 0;
                TotalSPELALL := 0;
                TotalOtherall := 0;
                TotalAttendRegu := 0;
                NetAdditions := 0;
                TotalOfTheseFields := 0;
                TotalFromProcessedSal := 0;
                MonthValue := "Pay Slip Month";
                YearValue := Year;
            end;
        }
        dataitem("Monthly Attendance"; "Monthly Attendance B2B")
        {
            DataItemTableView = SORTING ("Employee Code", Posted) ORDER(Ascending);
            column(TotalCredit; TotalCredit)
            {
            }
            column(Total_From_G_L_EntriesCaption; Total_From_G_L_EntriesCaptionLbl)
            {
            }
            column(Monthly_Attendance_Employee_Code; "Employee Code")
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

            trigger OnAfterGetRecord();
            begin
                GLEntry.SETRANGE("Document No.", "Monthly Attendance"."Document No.");
                if GLEntry.FINDFIRST() then
                    repeat
                        TotalCredit := TotalCredit + GLEntry."Credit Amount";
                    until GLEntry.NEXT() = 0;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                SETRANGE("Employee Code", Text330001Txt);
                SETRANGE("Pay Slip Month", "Processed Salary"."Pay Slip Month");
                SETRANGE(Year, "Processed Salary".Year);
                TotalCredit := 0;
                TempValue := 0;
                HRSetup.SETRANGE(HRSetup."Primary Key", '');
                if HRSetup.FINDFIRST() then begin
                    EmployerPF := HRSetup."Employer PF";
                    EmployerEPS := HRSetup."Employer EPS";
                    PTAdminCharges := HRSetup."PF Admin. Charges";
                    EDLICharges := HRSetup."EDLI Charges";
                    EmployerESI := HRSetup."Employer ESI";
                    RIFACharges := HRSetup."RIFA Charges";
                    CashAcc := HRSetup."Cash Account";
                    BankAcc := HRSetup."Bank Account";
                end;
            end;
        }
    }

    requestpage
    {
        Caption = 'Reconcilation';

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

    var

        GLEntry: Record "G/L Entry";
        HRSetup: Record "HR Setup B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        TotalBasic: Decimal;
        TotalHRA: Decimal;
        TotalCA: Decimal;
        TotalWA: Decimal;
        TotalCCA: Decimal;
        TotalVDA: Decimal;
        TotalFDA: Decimal;
        TotalOT: Decimal;
        TotalSPELALL: Decimal;
        TotalOtherall: Decimal;
        TotalAttendRegu: Decimal;
        NetAdditions: Decimal;
        TotalCoContrib: Decimal;
        TotalCoContrib2: Decimal;
        TotalPFAdminChar: Decimal;
        TotalVDlI: Decimal;
        TotalRIFA: Decimal;
        TotalCredit: Decimal;
        MonthValue: Integer;
        YearValue: Integer;
        TotalOfTheseFields: Decimal;
        TotalFromProcessedSal: Decimal;
        Month: Text[30];
        TempValue: Decimal;
        EmployerPF: Code[20];
        EmployerEPS: Code[20];
        PTAdminCharges: Code[20];
        EDLICharges: Code[20];
        EmployerESI: Code[20];
        RIFACharges: Code[20];
        CashAcc: Code[20];
        BankAcc: Code[20];

        Total_BasicCaptionLbl: Label 'Total Basic';
        Total_HRACaptionLbl: Label 'Total HRA';
        Total_CACaptionLbl: Label 'Total CA';
        Total_WACaptionLbl: Label 'Total WA';
        Total_CCACaptionLbl: Label 'Total CCA';
        Total_VDACaptionLbl: Label 'Total VDA';
        Total_FDACaptionLbl: Label 'Total FDA';
        Total_OTCaptionLbl: Label 'Total OT';
        Total_Spel_AllCaptionLbl: Label 'Total Spel All';
        Total_Other_AllCaptionLbl: Label 'Total Other All';
        Total_Attend_ReguCaptionLbl: Label 'Total Attend Regu';
        TOTALCaptionLbl: Label 'TOTAL';
        Total_CoContributionsCaptionLbl: Label 'Total CoContributions';
        Total_CoContributions2CaptionLbl: Label 'Total CoContributions2';
        Total_RIFACaptionLbl: Label 'Total RIFA';
        Total_EDLI_ChargesCaptionLbl: Label 'Total EDLI Charges';
        Total_PF_Admin_ChargesCaptionLbl: Label 'Total PF Admin Charges';
        TOTALCaption_Control1102152036Lbl: Label 'TOTAL';
        GRAND_TOTALCaptionLbl: Label 'GRAND TOTAL';
        Total_From_G_L_EntriesCaptionLbl: Label 'Total From G/L Entries';
        FDATxt: Label 'FDA';
        HRATxt: Label 'HRA';
        CATxt: Label 'CA';
        CCATxt: Label 'CCA';
        WATxt: Label 'WA';
        SPELALLTxt: Label 'SPELALL';
        BasicTxt: Label 'BASIC';
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
        Text330001Txt: Label '1004';
        VDATxt: Label 'VDA';
        OTTxt: Label 'OT';
        OTHALLTxt: Label 'OTHALL';
        ATTDREGUTxt: Label 'ATTD. REGU.';
}

