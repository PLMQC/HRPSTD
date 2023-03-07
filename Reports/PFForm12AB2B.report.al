report 33001232 "PF Form 12A B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PF Form 12A.rdlc';
    Caption = 'PF Form 12A';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            column(companyinfo_Name; companyinfo.Name)
            {
            }
            column(companyinfo_Address; companyinfo.Address)
            {
            }
            column(companyinfo__Address_2_; companyinfo."Address 2")
            {
            }
            column(companyinfo_City; companyinfo.City)
            {
            }
            column(Currency_Period_from__; 'Currency Period from ')
            {
            }
            column(YearStDate; YearStDate)
            {
            }
            column(YearEndDate; YearEndDate)
            {
            }
            column(To_; 'To')
            {
            }
            column(Statement_of_Contributions_for_the_month_of___MonthName; 'Statement of Contributions for the month of ' + MonthName)
            {
            }
            column(Statutory_rate_of_Contribution_; 'Statutory rate of Contribution')
            {
            }
            column(YearValue; YearValue)
            {
            }
            column(BasicAmt; BasicAmt)
            {
            }
            column(BasicAmt_Control1102152072; BasicAmt)
            {
            }
            column(BasicAmt_Control1102152073; BasicAmt)
            {
            }
            column(PFAmt; PFAmt)
            {
            }
            column(PFAmt_Control1102152075; PFAmt)
            {
            }
            column(PFAdminCharges; PFAdminCharges)
            {
            }
            column(PFAdminCharges_Control1102152077; PFAdminCharges)
            {
            }
            column(RIFACharges; RIFACharges)
            {
            }
            column(RIFACharges_Control1102152079; RIFACharges)
            {
            }
            column(EDLICharges; EDLICharges)
            {
            }
            column(EDLICharges_Control1102152081; EDLICharges)
            {
            }
            column(EPF; EPF)
            {
            }
            column(EPF_Control1102152083; EPF)
            {
            }
            column(EPS; EPS)
            {
            }
            column(EPS_Control1102152085; EPS)
            {
            }
            column(TotalNoofSubs; TotalNoofSubs)
            {
            }
            column(TotalNoofSubs_Control1102152093; TotalNoofSubs)
            {
            }
            column(NoofEmp; NoofEmp)
            {
            }
            column(NoofEmp_Control1102152116; NoofEmp)
            {
            }
            column(NoofEmp_Control1102152117; NoofEmp)
            {
            }
            column(NoofNewEmp; NoofNewEmp)
            {
            }
            column(NoofNewEmp_Control1102152119; NoofNewEmp)
            {
            }
            column(NoofNewEmp_Control1102152120; NoofNewEmp)
            {
            }
            column(NoofResEmp; NoofResEmp)
            {
            }
            column(NoofResEmp_Control1102152122; NoofResEmp)
            {
            }
            column(NoofResEmp_Control1102152123; NoofResEmp)
            {
            }
            column(TotalNoofSubs_Control1102152124; TotalNoofSubs)
            {
            }
            column(TotalNoofSubs_Control1102152125; TotalNoofSubs)
            {
            }
            column(TotalNoofSubs_Control1102152126; TotalNoofSubs)
            {
            }
            column(Form_12_A__R_Caption; Form_12_A__R_CaptionLbl)
            {
            }
            column(EMPLOYEE_S_PROVIDENT_FUNDS_AND_MISC__PROVISIONS_ACT__1952Caption; EMPLOYEE_S_PROVIDENT_FUNDS_AND_MISC__PROVISIONS_ACT__1952CaptionLbl)
            {
            }
            column(EMPLOYEE_S_PENSION_SCHEME__Para_20_4__Caption; EMPLOYEE_S_PENSION_SCHEME__Para_20_4__CaptionLbl)
            {
            }
            column(Name_and_Address_of_the_Estt_Caption; Name_and_Address_of_the_Estt_CaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(Establishment_StatusCaption; Establishment_StatusCaptionLbl)
            {
            }
            column(Group_CodeCaption; Group_CodeCaptionLbl)
            {
            }
            column(ParticularsCaption; ParticularsCaptionLbl)
            {
            }
            column(Wages_on_which_contributions_are_payableCaption; Wages_on_which_contributions_are_payableCaptionLbl)
            {
            }
            column(Amount_of_ContributionCaption; Amount_of_ContributionCaptionLbl)
            {
            }
            column(Recovered_from_the_WorkersCaption; Recovered_from_the_WorkersCaptionLbl)
            {
            }
            column(Payable_by_the_EmployerCaption; Payable_by_the_EmployerCaptionLbl)
            {
            }
            column(Amount_of_Contribution_RemittedCaption; Amount_of_Contribution_RemittedCaptionLbl)
            {
            }
            column(Worker_s_ShareCaption; Worker_s_ShareCaptionLbl)
            {
            }
            column(Employer_s_ShareCaption; Employer_s_ShareCaptionLbl)
            {
            }
            column(Amount_of_Admn__Charges_dueCaption; Amount_of_Admn__Charges_dueCaptionLbl)
            {
            }
            column(Amount_of_Admn__Charges_remittedCaption; Amount_of_Admn__Charges_remittedCaptionLbl)
            {
            }
            column(Date_of_Remittance__Enclose_triplicate_copies_of_Challan_Caption; Date_of_Remittance__Enclose_triplicate_copies_of_Challan_CaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column(V3Caption; V3CaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(V6Caption; V6CaptionLbl)
            {
            }
            column(V7Caption; V7CaptionLbl)
            {
            }
            column(E_P_F_A_c_No__01Caption; E_P_F_A_c_No__01CaptionLbl)
            {
            }
            column(Pension_Fund_A_c_No__10Caption; Pension_Fund_A_c_No__10CaptionLbl)
            {
            }
            column(E_D_L_I__A_c_No__21Caption; E_D_L_I__A_c_No__21CaptionLbl)
            {
            }
            column(NILCaption; NILCaptionLbl)
            {
            }
            column(NILCaption_Control1102152066; NILCaption_Control1102152066Lbl)
            {
            }
            column(NILCaption_Control1102152067; NILCaption_Control1102152067Lbl)
            {
            }
            column(NILCaption_Control1102152068; NILCaption_Control1102152068Lbl)
            {
            }
            column(NILCaption_Control1102152069; NILCaption_Control1102152069Lbl)
            {
            }
            column(NILCaption_Control1102152070; NILCaption_Control1102152070Lbl)
            {
            }
            column(Total_No_Of_EmployeesCaption; Total_No_Of_EmployeesCaptionLbl)
            {
            }
            column(a__ContractCaption; a__ContractCaptionLbl)
            {
            }
            column(b__RestCaption; b__RestCaptionLbl)
            {
            }
            column(c__TotalCaption; c__TotalCaptionLbl)
            {
            }
            column(Name_and_Address_of_the_Bank_in_which_the_amount_is_remittedCaption; Name_and_Address_of_the_Bank_in_which_the_amount_is_remittedCaptionLbl)
            {
            }
            column(Details_of_SubscribersCaption; Details_of_SubscribersCaptionLbl)
            {
            }
            column(EPFCaption; EPFCaptionLbl)
            {
            }
            column(Pension_FundCaption; Pension_FundCaptionLbl)
            {
            }
            column(EDLICaption; EDLICaptionLbl)
            {
            }
            column(No__of_Subscibers_as_per_the_last_monthCaption; No__of_Subscibers_as_per_the_last_monthCaptionLbl)
            {
            }
            column(No__of_new_Subscribers___Vide_Form_5_Caption; No__of_new_Subscribers___Vide_Form_5_CaptionLbl)
            {
            }
            column(No__of_Subscribers_left_Services__Vide_Form_10_Caption; No__of_Subscribers_left_Services__Vide_Form_10_CaptionLbl)
            {
            }
            column(Net_Total_No_Of_SubscribersCaption; Net_Total_No_Of_SubscribersCaptionLbl)
            {
            }
            column(Signature_of_the_Employer_with_Official__Seal_Caption; Signature_of_the_Employer_with_Official__Seal_CaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = WHERE(Number = CONST(1));

                trigger OnAfterGetRecord();
                begin
                    PF.FINDFIRST();
                    EmpCon := (BasicAmt * PF."Employee Contribution") / 100;
                    PFAdminCharges := (BasicAmt * PF."Admin Charges %") / 100;
                    EDLICharges := (BasicAmt * PF."EDLI %") / 100;
                    RIFACharges := (BasicAmt * PF."RIFA %") / 100;
                    MonthValue := MonthValue - 1;
                    if MonthValue = 0 then begin
                        MonthValue := 12;
                        YearValue := YearValue - 1;
                    end;

                    if PF.FINDFIRST() then
                        case PF."Rounding Method" of
                            PF."Rounding Method"::Nearest:
                                begin
                                    EPS := ROUND(EPS, PF."Rounding Amount", '=');
                                    EPF := ROUND(EPF, PF."Rounding Amount", '=');
                                    PFAdminCharges := ROUND(PFAdminCharges, PF."Rounding Amount", '=');
                                    EDLICharges := ROUND(EDLICharges, PF."Rounding Amount", '=');
                                    RIFACharges := ROUND(RIFACharges, PF."Rounding Amount", '=');
                                end;
                            PF."Rounding Method"::Up:
                                begin
                                    EPS := ROUND(EPS, PF."Rounding Amount", '>');
                                    EPF := ROUND(EPF, PF."Rounding Amount", '>');
                                    PFAdminCharges := ROUND(PFAdminCharges, PF."Rounding Amount", '=');
                                    EDLICharges := ROUND(EDLICharges, PF."Rounding Amount", '=');
                                    RIFACharges := ROUND(RIFACharges, PF."Rounding Amount", '=');
                                end;
                            else begin
                                    EPS := ROUND(EPS, PF."Rounding Amount", '<');
                                    EPF := ROUND(EPF, PF."Rounding Amount", '<');
                                    PFAdminCharges := ROUND(PFAdminCharges, PF."Rounding Amount", '=');
                                    EDLICharges := ROUND(EDLICharges, PF."Rounding Amount", '=');
                                    RIFACharges := ROUND(RIFACharges, PF."Rounding Amount", '=');
                                end;
                        end;
                    NoofEmp -= NoofNewEmp;
                    TotalNoofSubs := NoofEmp + NoofNewEmp - NoofResEmp;
                    PFAmt := EPS + EPF;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                TempBasicAmt := 0;

                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", "No.");
                ProcessedSalary.SETRANGE("Pay Slip Month", MonthValue);
                ProcessedSalary.SETRANGE(Year, YearValue);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        case ProcessedSalary."Add/Deduct Code" of
                            BASICTxt:
                                TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                            FDATxt:
                                TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                            DATxt:
                                TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                            VDATxt:
                                TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                            stipendTxt:
                                TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                            PFTxt:
                                PFAmt += ProcessedSalary."Earned Amount";
                        end;
                    until ProcessedSalary.NEXT() = 0;

                PayRevisionLine.RESET();
                PayRevisionLine.SETRANGE("No.", "No.");
                PayRevisionLine.SETRANGE(Month, MonthValue);
                PayRevisionLine.SETRANGE(Year, YearValue);
                if PayRevisionLine.FINDFIRST() then
                    repeat
                        case PayRevisionLine."Pay Element" of
                            BASICTxt:
                                TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                            FDATxt:
                                TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                            DATxt:
                                TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                            VDATxt:
                                TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                            stipendTxt:
                                TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                            PFTxt:
                                PFAmt += PayRevisionLine."Arrear Amount";
                        end;
                    until PayRevisionLine.NEXT() = 0;

                PF.FINDFIRST();

                if TempBasicAmt <= PF."PF Amount" then begin
                    EPS := EPS + (TempBasicAmt * PF."EPS %") / 100;
                    EPF := EPF + (TempBasicAmt * PF."Employer Contribution") / 100;
                end else begin
                    EPS := EPS + PF."PF Amount" * PF."EPS %" / 100;
                    EPF := EPF + (TempBasicAmt * PF."EPS %") / 100 + (TempBasicAmt * PF."Employer Contribution") / 100 - PF."PF Amount" * PF."EPS %" / 100;
                end;

                BasicAmt := BasicAmt + TempBasicAmt;

                if MonthValue = 1 then begin
                    YearValue1 := YearValue - 1;
                    MonthValue1 := 12;
                end else begin
                    YearValue1 := YearValue;
                    MonthValue1 := MonthValue - 1;
                end;
                if (DATE2DMY("Employment Date", 2) = MonthValue) and (DATE2DMY("Employment Date", 3) = YearValue) then
                    NoofNewEmp := NoofNewEmp + 1;
                if "Resignation Date" <> 0D then
                    if (DATE2DMY("Resignation Date", 2) = MonthValue) and (DATE2DMY("Resignation Date", 3) = YearValue) then
                        NoofResEmp := NoofResEmp + 1;
            end;

            trigger OnPreDataItem();
            begin
                companyinfo.GET();
                SETRANGE("PF Applicable", true);
                SETRANGE(Blocked, false);
                BasicAmt := 0;
                NoofEmp := "Employee B2B".COUNT();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Month; MonthValue)
                {
                    ToolTip = 'Enter the month for which you want generate.';
                    Caption = 'Month';
                    ApplicationArea = all;
                }
                field(Year; YearValue)
                {
                    ToolTip = 'Enter the year for which you want to generate.';
                    Caption = 'Year';
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

    var
        ProcessedSalary: Record "Processed Salary B2B";
        companyinfo: Record "Company Information";
        PayRevisionLine: Record "Pay Revision Line B2B";
        PF: Record PF_B2B;
        MonthValue: Integer;
        YearValue: Integer;
        BasicAmt: Decimal;

        YearStDate: Date;
        YearEndDate: Date;
        MonthName: Text[50];
        EmpCon: Decimal;
        EPF: Decimal;
        PFAdminCharges: Decimal;
        EPS: Decimal;
        EDLICharges: Decimal;
        RIFACharges: Decimal;
        TempBasicAmt: Decimal;
        NoofEmp: Integer;
        NoofNewEmp: Integer;
        NoofResEmp: Integer;
        TotalNoofSubs: Integer;

        PFAmt: Decimal;

        YearValue1: Decimal;
        MonthValue1: Decimal;
        Form_12_A__R_CaptionLbl: Label 'Form 12 A (R)';
        EMPLOYEE_S_PROVIDENT_FUNDS_AND_MISC__PROVISIONS_ACT__1952CaptionLbl: Label 'EMPLOYEE''S PROVIDENT FUNDS AND MISC. PROVISIONS ACT, 1952';
        EMPLOYEE_S_PENSION_SCHEME__Para_20_4__CaptionLbl: Label 'EMPLOYEE''S PENSION SCHEME [Para 20(4)]';
        Name_and_Address_of_the_Estt_CaptionLbl: Label 'Name and Address of the Estt.';
        CodeCaptionLbl: Label 'Code';
        Establishment_StatusCaptionLbl: Label 'Establishment Status';
        Group_CodeCaptionLbl: Label 'Group Code';
        ParticularsCaptionLbl: Label 'Particulars';
        Wages_on_which_contributions_are_payableCaptionLbl: Label 'Wages on which contributions are payable';
        Amount_of_ContributionCaptionLbl: Label 'Amount of Contribution';
        Recovered_from_the_WorkersCaptionLbl: Label 'Recovered from the Workers';
        Payable_by_the_EmployerCaptionLbl: Label 'Payable by the Employer';
        Amount_of_Contribution_RemittedCaptionLbl: Label 'Amount of Contribution Remitted';
        Worker_s_ShareCaptionLbl: Label 'Worker''s Share';
        Employer_s_ShareCaptionLbl: Label 'Employer''s Share';
        Amount_of_Admn__Charges_dueCaptionLbl: Label 'Amount of Admn. Charges due';
        Amount_of_Admn__Charges_remittedCaptionLbl: Label 'Amount of Admn. Charges remitted';
        Date_of_Remittance__Enclose_triplicate_copies_of_Challan_CaptionLbl: Label 'Date of Remittance (Enclose triplicate copies of Challan)';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        V4CaptionLbl: Label '4';
        V5CaptionLbl: Label '5';
        V6CaptionLbl: Label '6';
        V7CaptionLbl: Label '7';
        E_P_F_A_c_No__01CaptionLbl: Label 'E.P.F.A/c No. 01';
        Pension_Fund_A_c_No__10CaptionLbl: Label 'Pension Fund A/c No. 10';
        E_D_L_I__A_c_No__21CaptionLbl: Label 'E.D.L.I. A/c No. 21';
        NILCaptionLbl: Label 'NIL';
        NILCaption_Control1102152066Lbl: Label 'NIL';
        NILCaption_Control1102152067Lbl: Label 'NIL';
        NILCaption_Control1102152068Lbl: Label 'NIL';
        NILCaption_Control1102152069Lbl: Label 'NIL';
        NILCaption_Control1102152070Lbl: Label 'NIL';
        Total_No_Of_EmployeesCaptionLbl: Label 'Total No Of Employees';
        a__ContractCaptionLbl: Label '(a) Contract';
        b__RestCaptionLbl: Label '(b) Rest';
        c__TotalCaptionLbl: Label '(c) Total';
        Name_and_Address_of_the_Bank_in_which_the_amount_is_remittedCaptionLbl: Label 'Name and Address of the Bank in which the amount is remitted';
        Details_of_SubscribersCaptionLbl: Label 'Details of Subscribers';
        EPFCaptionLbl: Label 'EPF';
        Pension_FundCaptionLbl: Label 'Pension Fund';
        EDLICaptionLbl: Label 'EDLI';
        No__of_Subscibers_as_per_the_last_monthCaptionLbl: Label 'No. of Subscibers as per the last month';
        No__of_new_Subscribers___Vide_Form_5_CaptionLbl: Label 'No. of new Subscribers  (Vide Form 5)';
        No__of_Subscribers_left_Services__Vide_Form_10_CaptionLbl: Label 'No. of Subscribers left Services (Vide Form 10)';
        Net_Total_No_Of_SubscribersCaptionLbl: Label 'Net Total No Of Subscribers';
        Signature_of_the_Employer_with_Official__Seal_CaptionLbl: Label 'Signature of the Employer with Official (Seal)';
        BASICTxt: Label 'BASIC';
        FDATxt: Label 'FDA';
        DATxt: Label 'DA';
        VDATxt: Label 'VDA';
        stipendTxt: Label 'stipend';
        PFTxt: Label 'PF';
}

