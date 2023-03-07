report 33001211 "Form-6_B2B B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Form-6.rdl';
    Caption = 'Form-6';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            column(StartingDate; StartingDate)
            {
            }
            column(EndingDate; EndingDate)
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(GrandTotalWages1; GrandTotalWages1)
            {
            }
            column(GrandEmployeesContribution1; GrandEmployeesContribution1)
            {
            }
            column(GrandEmployeesContribution1_GrandTotalWages1; GrandEmployeesContribution1 + GrandTotalWages1)
            {
            }
            column(MonGross_1_; MonGross[1])
            {
            }
            column(MonGross_2_; MonGross[2])
            {
            }
            column(MonGross_3_; MonGross[3])
            {
            }
            column(MonGross_4_; MonGross[4])
            {
            }
            column(MonGross_5_; MonGross[5])
            {
            }
            column(MonGross_6_; MonGross[6])
            {
            }
            column(Attendance; Attendance)
            {
            }
            column(GrossSal; GrossSal)
            {
            }
            column(EmpCon; EmpCon)
            {
            }
            column(DailyWages; DailyWages)
            {
            }
            column(TempForNewEmp; TempForNewEmp)
            {
            }
            column(Employee_B2B__ESI_No_; "ESI No")
            {
            }
            column(UPPERCASE__First_Name___________Last_Name__; UPPERCASE("First Name" + ' ' + "Last Name"))
            {
            }
            column(SlNo__; "SlNo.")
            {
            }
            column(Employee_B2B__ESI_Dispensary_; "ESI Dispensary")
            {
            }
            column(GrandTotalWages; GrandTotalWages)
            {
            }
            column(GrandEmployeesContribution; GrandEmployeesContribution)
            {
            }
            column(FORM_6Caption; FORM_6CaptionLbl)
            {
            }
            column(EMPLOYEE_S_STATE_INSURANCE_CORPORATIONCaption; EMPLOYEE_S_STATE_INSURANCE_CORPORATIONCaptionLbl)
            {
            }
            column(Name___Adress_Of_Factory_or_EstablishmentCaption; Name___Adress_Of_Factory_or_EstablishmentCaptionLbl)
            {
            }
            column(Particulars_Of_Principal_EmployerCaption; Particulars_Of_Principal_EmployerCaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Residential_Address__Caption; Residential_Address__CaptionLbl)
            {
            }
            column(Period_FROMCaption; Period_FROMCaptionLbl)
            {
            }
            column(TOCaption; TOCaptionLbl)
            {
            }
            column(DataItem1102152010; I_furnish_below_the_detailsLbl)
            {
            }
            column(Regulation_____26Caption; Regulation_____26CaptionLbl)
            {
            }
            column(Total_Contribution_Amount_Rs_Caption; Total_Contribution_Amount_Rs_CaptionLbl)
            {
            }
            column(Comprising__of_Rs__Caption; Comprising__of_Rs__CaptionLbl)
            {
            }
            column(As_Employee_s_Share_and_Rs___Caption; As_Employee_s_Share_and_Rs___CaptionLbl)
            {
            }
            column(V1__Challan_DatedCaption; V1__Challan_DatedCaptionLbl)
            {
            }
            column(V2__Challan_DatedCaption; V2__Challan_DatedCaptionLbl)
            {
            }
            column(V3__Challan_DatedCaption; V3__Challan_DatedCaptionLbl)
            {
            }
            column(V4__Challan_DatedCaption; V4__Challan_DatedCaptionLbl)
            {
            }
            column(V5__Challan_DatedCaption; V5__Challan_DatedCaptionLbl)
            {
            }
            column(V6__Challan_DatedCaption; V6__Challan_DatedCaptionLbl)
            {
            }
            column(as_Employer_s_Share_Total_of_col__6_of_the_return__Paid_as_under_Caption; as_Employer_s_Share_Total_of_col__6_of_the_return__Paid_as_under_CaptionLbl)
            {
            }
            column(For_Rs_Caption; For_Rs_CaptionLbl)
            {
            }
            column(For_Rs_Caption_Control1102152024; For_Rs_Caption_Control1102152024Lbl)
            {
            }
            column(For_Rs_Caption_Control1102152025; For_Rs_Caption_Control1102152025Lbl)
            {
            }
            column(For_Rs_Caption_Control1102152026; For_Rs_Caption_Control1102152026Lbl)
            {
            }
            column(For_Rs_Caption_Control1102152027; For_Rs_Caption_Control1102152027Lbl)
            {
            }
            column(For_Rs_Caption_Control1102152028; For_Rs_Caption_Control1102152028Lbl)
            {
            }
            column(PLACE_Caption; PLACE_CaptionLbl)
            {
            }
            column(DATE_Caption; DATE_CaptionLbl)
            {
            }
            column(Signature__Caption; Signature__CaptionLbl)
            {
            }
            column(Designation__Caption; Designation__CaptionLbl)
            {
            }
            column(IMPORTANT_INSTRUCTIONS__Caption; IMPORTANT_INSTRUCTIONS__CaptionLbl)
            {
            }
            column(V1__Information_to_be_given_in__Remarks_Column_No__8__Caption; V1__Information_to_be_given_in__Remarks_Column_No__8__CaptionLbl)
            {
            }
            column(DataItem1102152035; i__If_any_Insured_person_isLbl)
            {
            }
            column(ii__Please_indicate_the_name_of_Dispensary_to_which_the_insured_person_is_attached__to_be_furnished_only_once_Caption; ii__Please_indicate_the_name_of_Dispensary_to_which_the_insured_person_is_attached__to_be_furnished_only_once_CaptionLbl)
            {
            }
            column(iii__Please_indicate_name_of_Dispensary_to_which_insured_person_is_attached_in_case_of_New_entrant_Caption; iii__Please_indicate_name_of_Dispensary_to_which_insured_person_is_attached_in_case_of_New_entrant_CaptionLbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(DataItem1102152039; iv__In_case_thereLbl)
            {
            }
            column(V2__Please_indicate_Insurance_Number_in_chronological__ascending___OrderCaption; V2__Please_indicate_Insurance_Number_in_chronological__ascending___OrderCaptionLbl)
            {
            }
            column(V3__Figures_in_column_4_5___6_shall_be_in_respect_of_wage_period_ended_during_the_contribution_period_Caption; V3__Figures_in_column_4_5___6_shall_be_in_respect_of_wage_period_ended_during_the_contribution_period_CaptionLbl)
            {
            }
            column(V4__In_variable_strike_total_of_column_4_5___6_of_the_Return_Caption; V4__In_variable_strike_total_of_column_4_5___6_of_the_Return_CaptionLbl)
            {
            }
            column(V6__Every_page_of_the_return_should_bear_full_signature___rubber_stamp_of_the_employer_Caption; V6__Every_page_of_the_return_should_bear_full_signature___rubber_stamp_of_the_employer_CaptionLbl)
            {
            }
            column(V5__No_over_writings_shall_be_made__Any_corrections_should_be_signed_by_the_employer_Caption; V5__No_over_writings_shall_be_made__Any_corrections_should_be_signed_by_the_employer_CaptionLbl)
            {
            }
            column(DataItem1102152045; V7___Dialy_wagesLbl)
            {
            }
            column(DataItem1102152046; I_hereby_declareLbl)
            {
            }
            column(DataItem1102152047; the_work_of_the_factoryLbl)
            {
            }
            column(DataItem1102152048; of_raw__materialsLbl)
            {
            }
            column(DataItem1102152049; that_the_contributionsLbl)
            {
            }
            column(of_the_Act_and_Regulations_relating_to_the_payment_of_contributions_vide_challans_detailed_below_________Caption; of_the_Act_and_Regulations_relating_to_the_payment_of_contributions_vide_challans_detailed_below_________CaptionLbl)
            {
            }
            column(Whether_still_continues_working_and_drawing_wages_within_Insurable_wage_ceiling__Caption; Whether_still_continues_working_and_drawing_wages_within_Insurable_wage_ceiling__CaptionLbl)
            {
            }
            column(Remarks__DispensaryCaption; Remarks__DispensaryCaptionLbl)
            {
            }
            column(Daily_WagesCaption; Daily_WagesCaptionLbl)
            {
            }
            column(Employees_ContributionCaption; Employees_ContributionCaptionLbl)
            {
            }
            column(Total_WagesCaption; Total_WagesCaptionLbl)
            {
            }
            column(No__of_Days_For_which_wages_PaidCaption; No__of_Days_For_which_wages_PaidCaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(ESI_No_Caption; ESI_No_CaptionLbl)
            {
            }
            column(Sl_No_Caption; Sl_No_CaptionLbl)
            {
            }
            column(Whether_still_continues_working_and_drawing_wages_within_Insurable_wage_ceiling__Caption_Control1102152085; Whether_still_continues_working_and_drawing_wages_within_Insurable_wage_ceiling__Caption_Control1102152085Lbl)
            {
            }
            column(Remarks__DispensaryCaption_Control1102152086; Remarks__DispensaryCaption_Control1102152086Lbl)
            {
            }
            column(Daily_WagesCaption_Control1102152089; Daily_WagesCaption_Control1102152089Lbl)
            {
            }
            column(Employees_ContributionCaption_Control1102152090; Employees_ContributionCaption_Control1102152090Lbl)
            {
            }
            column(Total_WagesCaption_Control1102152092; Total_WagesCaption_Control1102152092Lbl)
            {
            }
            column(No__of_Days_For_which_wages_PaidCaption_Control1102152094; No__of_Days_For_which_wages_PaidCaption_Control1102152094Lbl)
            {
            }
            column(Employee_NameCaption_Control1102152096; Employee_NameCaption_Control1102152096Lbl)
            {
            }
            column(ESI_No_Caption_Control1102152099; ESI_No_Caption_Control1102152099Lbl)
            {
            }
            column(Sl_No_Caption_Control1102152101; Sl_No_Caption_Control1102152101Lbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(For_Use_In_Regional_Of_E_S_I_Corporation_Caption; For_Use_In_Regional_Of_E_S_I_Corporation_CaptionLbl)
            {
            }
            column(SIGNATURECaption; SIGNATURECaptionLbl)
            {
            }
            column(Entitlement_position_marked_Caption; Entitlement_position_marked_CaptionLbl)
            {
            }
            column(U_D_CCaption; U_D_CCaptionLbl)
            {
            }
            column(COUNTERSIGNEDCaption; COUNTERSIGNEDCaptionLbl)
            {
            }
            column(Branch_OfficerCaption; Branch_OfficerCaptionLbl)
            {
            }
            column(Total_of_col__5_of_return_checked_and_found_correct_Correct_Amount_is_indicatedCaption; Total_of_col__5_of_return_checked_and_found_correct_Correct_Amount_is_indicatedCaptionLbl)
            {
            }
            column(Checked_the_amount_of_Employer_s_Employee_s_contribution_Paid_which_is_in_order_observation_memo_encloser__Caption; Checked_the_amount_of_Employer_s_Employee_s_contribution_Paid_which_is_in_order_observation_memo_encloser__CaptionLbl)
            {
            }
            column(U_D_CCaption_Control1102152158; U_D_CCaption_Control1102152158Lbl)
            {
            }
            column(COUNTERSIGNEDCaption_Control1102152159; COUNTERSIGNEDCaption_Control1102152159Lbl)
            {
            }
            column(Branch_OfficeCaption; Branch_OfficeCaptionLbl)
            {
            }
            column(HEAD_CLERKCaption; HEAD_CLERKCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                DT := StartingDate;
                Attendance := 0;
                EmpCon := 0;
                DailyWages := 0;
                GrossSal := 0;
                TempForNewEmp := '';
                for I := 1 to 6 do begin
                    Monthvalue := DATE2DMY(DT, 2);
                    YearValue := DATE2DMY(DT, 3);
                    PayrevisionLine.SETRANGE("No.", "No.");
                    PayrevisionLine.SETRANGE(Month, Monthvalue);
                    PayrevisionLine.SETRANGE(Year, YearValue);
                    if PayrevisionLine.FINDFIRST() then
                        repeat
                            if PayrevisionLine."Add/Deduct" = PayrevisionLine."Add/Deduct"::Addition then
                                GrossSal += PayrevisionLine."Arrear Amount"
                            else
                                if PayrevisionLine."Pay Element" = ESITxt then
                                    EmpCon += PayrevisionLine."Arrear Amount";
                        until PayrevisionLine.NEXT() = 0;

                    Processedsalary.RESET();
                    Processedsalary.SETRANGE("Employee Code", "No.");
                    Processedsalary.SETRANGE("Pay Slip Month", Monthvalue);
                    Processedsalary.SETRANGE(Year, YearValue);
                    Processedsalary.SETRANGE("Add/Deduct Code", ESITxt);
                    if Processedsalary.FINDFIRST() then begin
                        EmpCon += Processedsalary."Earned Amount";
                        GrossSal += Processedsalary.Salary;
                        Attendance := Processedsalary.Attendance;
                        if Attendance <> 0 then
                            DailyWages := GrossSal / Attendance;
                    end;
                    DT := CALCDATE(MonthTxt, DT);
                    if (DATE2DMY("Employment Date", 2) = Monthvalue) and (DATE2DMY("Employment Date", 3) = YearValue) then
                        TempForNewEmp := Text330001Txt + FORMAT("Employment Date")
                    else
                        if "Resignation Date" <> 0D then
                            if (DATE2DMY("Resignation Date", 2) = Monthvalue) and (DATE2DMY("Resignation Date", 3) = YearValue) then
                                TempForNewEmp := Text330002Txt + FORMAT("Resignation Date");
                end;
                GrandTotalWages += GrossSal;
                GrandEmployeesContribution += EmpCon;
                "SlNo." += 1;
            end;

            trigger OnPreDataItem();
            begin
                GrandTotalWages := 0;
                GrandEmployeesContribution := 0;
                SETRANGE("ESI Applicable", true);
                GrandTotalWages1 := 0;
                GrandEmployeesContribution1 := 0;
                CLEAR(MonGross);
                "SlNo." := 1;
                CompanyInfo.GET();
                Employee.SETRANGE("ESI Applicable", true);
                if Employee.FINDFIRST() then
                    repeat
                        EachEmp := 0;
                        DT := StartingDate;
                        Attendance := 0;
                        EmpCon := 0;
                        DailyWages := 0;
                        GrossSal := 0;
                        for I := 1 to 6 do begin
                            Monthvalue := DATE2DMY(DT, 2);
                            YearValue := DATE2DMY(DT, 3);
                            EachEmp := 0;

                            PayrevisionLine.SETRANGE("No.", Employee."No.");
                            PayrevisionLine.SETRANGE(Month, Monthvalue);
                            PayrevisionLine.SETRANGE(Year, YearValue);
                            if PayrevisionLine.FINDFIRST() then
                                repeat
                                    if PayrevisionLine."Add/Deduct" = PayrevisionLine."Add/Deduct"::Addition then
                                        GrossSal += PayrevisionLine."Arrear Amount"
                                    else
                                        if PayrevisionLine."Pay Element" = ESITxt then begin
                                            EmpCon += PayrevisionLine."Arrear Amount";
                                            EachEmp += PayrevisionLine."Arrear Amount";
                                        end;
                                until PayrevisionLine.NEXT() = 0;

                            Processedsalary.RESET();
                            Processedsalary.SETRANGE("Employee Code", Employee."No.");
                            Processedsalary.SETRANGE("Pay Slip Month", Monthvalue);
                            Processedsalary.SETRANGE(Year, YearValue);
                            Processedsalary.SETRANGE("Add/Deduct Code", ESITxt);
                            if Processedsalary.FINDFIRST() then begin
                                EmpCon += Processedsalary."Earned Amount";
                                EachEmp += Processedsalary."Earned Amount";
                                GrossSal += Processedsalary.Salary;
                                Attendance := Processedsalary.Attendance;
                                if Attendance <> 0 then
                                    DailyWages := GrossSal / Attendance;
                            end;
                            DT := CALCDATE(MonthTxt, DT);
                            MonGross["SlNo."] += EachEmp;
                            "SlNo." += 1;
                        end;
                        GrandEmployeesContribution1 += EmpCon;
                        "SlNo." := 1;
                    until Employee.NEXT() = 0;
                ESIRec.RESET();
                ESIRec.SETFILTER("Effective Date", '<=%1', TODAY());
                if ESIRec.FINDLAST() then;
                GrandTotalWages1 := GrandEmployeesContribution1 * ESIRec."Employer %" / ESIRec."Employee %";
                for "SlNo." := 1 to 6 do
                    MonGross["SlNo."] := MonGross["SlNo."] * (ESIRec."Employer %" + ESIRec."Employee %") / ESIRec."Employee %";
                "SlNo." := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ESIYear; ESIYearGVar)
                    {
                        ToolTip = 'Choose the ESI Year from the drop down.';
                        Caption = 'ESI Year';
                        ApplicationArea = all;

                        trigger OnLookup(var Text: Text): Boolean;
                        begin
                            PayrollYear.SETRANGE("Year Type", ESIYEARTxt);
                            if PAGE.RUNMODAL(33001218, PayrollYear) = ACTION::LookupOK then begin
                                ESIYearGVar := PayrollYear."Year Type";
                                StartingDate := PayrollYear."Year Start Date";
                                EndingDate := PayrollYear."Year End Date";
                            end;
                        end;
                    }
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
        Processedsalary: Record "Processed Salary B2B";
        PayrollYear: Record "Payroll Year B2B";
        CompanyInfo: Record "Company Information";
        PayrevisionLine: Record "Pay Revision Line B2B";
        Employee: Record "Employee B2B";
        ESIRec: Record ESI_B2B;
        ESIYearGVar: Code[50];
        StartingDate: Date;
        EndingDate: Date;
        DT: Date;
        DailyWages: Decimal;
        I: Integer;

        "SlNo.": Integer;
        Attendance: Decimal;
        GrossSal: Decimal;
        EmpCon: Decimal;
        Monthvalue: Integer;
        YearValue: Integer;
        GrandTotalWages: Decimal;
        GrandTotalWages1: Decimal;
        GrandEmployeesContribution: Decimal;
        GrandEmployeesContribution1: Decimal;
        EachEmp: Decimal;
        TempForNewEmp: Text[50];

        MonGross: array[6] of Decimal;


        FORM_6CaptionLbl: Label 'FORM-6';
        EMPLOYEE_S_STATE_INSURANCE_CORPORATIONCaptionLbl: Label 'EMPLOYEE''S STATE INSURANCE CORPORATION';
        Name___Adress_Of_Factory_or_EstablishmentCaptionLbl: Label 'Name & Adress Of Factory or Establishment';
        Particulars_Of_Principal_EmployerCaptionLbl: Label 'Particulars Of Principal Employer';
        Name_CaptionLbl: Label 'Name:';
        Residential_Address__CaptionLbl: Label 'Residential Address :';
        Period_FROMCaptionLbl: Label 'Period FROM';
        TOCaptionLbl: Label 'TO';
        I_furnish_below_the_detailsLbl: Label 'I furnish below the details of the employer''s and employee''s share of contributions in respect of the under mentioned insured persons.';
        Regulation_____26CaptionLbl: Label 'Regulation  -  26';
        Total_Contribution_Amount_Rs_CaptionLbl: Label 'Total Contribution Amount Rs.';
        Comprising__of_Rs__CaptionLbl: Label '"Comprising  of Rs. "';
        As_Employee_s_Share_and_Rs___CaptionLbl: Label '"As Employee''s Share and Rs.  "';
        V1__Challan_DatedCaptionLbl: Label '1. Challan Dated';
        V2__Challan_DatedCaptionLbl: Label '2. Challan Dated';
        V3__Challan_DatedCaptionLbl: Label '3. Challan Dated';
        V4__Challan_DatedCaptionLbl: Label '4. Challan Dated';
        V5__Challan_DatedCaptionLbl: Label '5. Challan Dated';
        V6__Challan_DatedCaptionLbl: Label '6. Challan Dated';
        as_Employer_s_Share_Total_of_col__6_of_the_return__Paid_as_under_CaptionLbl: Label '"as Employer''s Share(Total of col. 6 of the return) Paid as under "';
        For_Rs_CaptionLbl: Label 'For Rs.';
        For_Rs_Caption_Control1102152024Lbl: Label 'For Rs.';
        For_Rs_Caption_Control1102152025Lbl: Label 'For Rs.';
        For_Rs_Caption_Control1102152026Lbl: Label 'For Rs.';
        For_Rs_Caption_Control1102152027Lbl: Label 'For Rs.';
        For_Rs_Caption_Control1102152028Lbl: Label 'For Rs.';
        PLACE_CaptionLbl: Label 'PLACE:';
        DATE_CaptionLbl: Label 'DATE:';
        Signature__CaptionLbl: Label 'Signature :';
        Designation__CaptionLbl: Label 'Designation :';
        IMPORTANT_INSTRUCTIONS__CaptionLbl: Label 'IMPORTANT INSTRUCTIONS :';
        V1__Information_to_be_given_in__Remarks_Column_No__8__CaptionLbl: Label '1. Information to be given in "Remarks Column(No. 8)"';
        i__If_any_Insured_person_isLbl: Label '"i) If any Insured person is appointed for the first time and /or leaves service during the contribution period, indicate  ""A"" (Date) and /or  ""L"" (Date) in remarks olumn (no. 8).   "';
        ii__Please_indicate_the_name_of_Dispensary_to_which_the_insured_person_is_attached__to_be_furnished_only_once_CaptionLbl: Label 'ii) Please indicate the name of Dispensary to which the insured person is attached (to be furnished only once)';
        iii__Please_indicate_name_of_Dispensary_to_which_insured_person_is_attached_in_case_of_New_entrant_CaptionLbl: Label 'iii) Please indicate name of Dispensary to which insured person is attached in case of New entrant.';
        DesignationCaptionLbl: Label 'Designation';
        iv__In_case_thereLbl: Label 'iv) In case there is charge in the name of Dispensary, please indicate the name and new dispensary in the remarks column.';
        V2__Please_indicate_Insurance_Number_in_chronological__ascending___OrderCaptionLbl: Label '2. Please indicate Insurance Number in chronological (ascending ) Order';
        V3__Figures_in_column_4_5___6_shall_be_in_respect_of_wage_period_ended_during_the_contribution_period_CaptionLbl: Label '3. Figures in column 4,5 & 6 shall be in respect of wage period ended during the contribution period.';
        V4__In_variable_strike_total_of_column_4_5___6_of_the_Return_CaptionLbl: Label '4. In variable strike total of column 4,5 & 6 of the Return.';
        V6__Every_page_of_the_return_should_bear_full_signature___rubber_stamp_of_the_employer_CaptionLbl: Label '6. Every page of the return should bear full signature & rubber stamp of the employer.';
        V5__No_over_writings_shall_be_made__Any_corrections_should_be_signed_by_the_employer_CaptionLbl: Label '5. No over-writings shall be made. Any corrections should be signed by the employer.';
        V7___Dialy_wagesLbl: Label '7. "Dialy wages" in Col.7 of the return shall be calculated by dividing figures in Col.5 by figures in col.4 to two decimal places.';
        I_hereby_declareLbl: Label 'I hereby declare that the return includes every employee, employed directly or thorough an immediate employer or inconnection with';
        the_work_of_the_factoryLbl: Label '"the work of the factory/establishment on any work connected with the work of administration of the factory/establishment or purchase "';
        of_raw__materialsLbl: Label 'of raw  materials, sale distribution of finished productsetc. to whom, the contribution period to which this return relates, applies and';
        that_the_contributionsLbl: Label 'that the contributions in respect of employer''s and employee''s share have been correctly paid in accordance with the provisions';
        of_the_Act_and_Regulations_relating_to_the_payment_of_contributions_vide_challans_detailed_below_________CaptionLbl: Label '"of the Act and Regulations relating to the payment of contributions vide challans detailed below:        "';
        Whether_still_continues_working_and_drawing_wages_within_Insurable_wage_ceiling__CaptionLbl: Label '"Whether still continues working and drawing wages within Insurable wage ceiling  "';
        Remarks__DispensaryCaptionLbl: Label 'Remarks/ Dispensary';
        Daily_WagesCaptionLbl: Label 'Daily Wages';
        Employees_ContributionCaptionLbl: Label 'Employees Contribution';
        Total_WagesCaptionLbl: Label 'Total Wages';
        No__of_Days_For_which_wages_PaidCaptionLbl: Label 'No. of Days For which wages Paid';
        Employee_NameCaptionLbl: Label 'Employee Name';
        ESI_No_CaptionLbl: Label 'ESI No.';
        Sl_No_CaptionLbl: Label 'Sl No.';
        Whether_still_continues_working_and_drawing_wages_within_Insurable_wage_ceiling__Caption_Control1102152085Lbl: Label '"Whether still continues working and drawing wages within Insurable wage ceiling  "';
        Remarks__DispensaryCaption_Control1102152086Lbl: Label 'Remarks/ Dispensary';
        Daily_WagesCaption_Control1102152089Lbl: Label 'Daily Wages';
        Employees_ContributionCaption_Control1102152090Lbl: Label 'Employees Contribution';
        Total_WagesCaption_Control1102152092Lbl: Label 'Total Wages';
        No__of_Days_For_which_wages_PaidCaption_Control1102152094Lbl: Label 'No. of Days For which wages Paid';
        Employee_NameCaption_Control1102152096Lbl: Label 'Employee Name';
        ESI_No_Caption_Control1102152099Lbl: Label 'ESI No.';
        Sl_No_Caption_Control1102152101Lbl: Label 'Sl No.';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        For_Use_In_Regional_Of_E_S_I_Corporation_CaptionLbl: Label '(For Use In Regional Of E.S.I Corporation)';
        SIGNATURECaptionLbl: Label 'SIGNATURE';
        Entitlement_position_marked_CaptionLbl: Label 'Entitlement position marked.';
        U_D_CCaptionLbl: Label 'U.D.C';
        COUNTERSIGNEDCaptionLbl: Label 'COUNTERSIGNED';
        Branch_OfficerCaptionLbl: Label 'Branch Officer';
        Total_of_col__5_of_return_checked_and_found_correct_Correct_Amount_is_indicatedCaptionLbl: Label 'Total of col. 5 of return checked and found correct/Correct Amount is indicated';
        Checked_the_amount_of_Employer_s_Employee_s_contribution_Paid_which_is_in_order_observation_memo_encloser__CaptionLbl: Label '"Checked the amount of Employer''s/Employee''s contribution Paid which is in order/observation memo encloser. "';
        U_D_CCaption_Control1102152158Lbl: Label 'U.D.C';
        COUNTERSIGNEDCaption_Control1102152159Lbl: Label 'COUNTERSIGNED';
        Branch_OfficeCaptionLbl: Label 'Branch Office';
        HEAD_CLERKCaptionLbl: Label 'HEAD CLERK';
        ESITxt: Label 'ESI';
        MonthTxt: Label '<1M>';
        Text330001Txt: Label '"A  -- "';
        Text330002Txt: Label '"L  -- "';
        ESIYEARTxt: Label 'ESI YEAR';
}

