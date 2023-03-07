report 33001236 "ESI Form 6A B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\ESI Form 6A.rdl';
    Caption = 'ESI Form 6A';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Processed Salary"; "Processed Salary B2B")
        {
            DataItemTableView = SORTING("Employee Code");
            column(SlNo__; "SlNo.")
            {
            }
            column(Employee__ESI_No_; Employee."ESI No")
            {
            }
            column(Employee__First_Name__Employee__Middle_Name_; Employee."First Name" + Employee."Middle Name")
            {
            }
            column(Processed_Salary_Attendance; Attendance)
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
            column(Employee__ESI_Dispensary_; Employee."ESI Dispensary")
            {
            }
            column(Employee__No__; Employee."No.")
            {
            }
            column(TempForNewEmp; TempForNewEmp)
            {
            }
            /*
             column(CurrReport_PAGENO; CurrReport.PAGENO)
             {
             }*///B2BBP

            column(Employees__State_Insurance_CorporationCaption; Employees__State_Insurance_CorporationCaptionLbl)
            {
            }
            column(Employer_s_Code_No_Caption; Employer_s_Code_No_CaptionLbl)
            {
            }
            column(FORM_6ACaption; FORM_6ACaptionLbl)
            {
            }
            column(Sl_No_Caption; Sl_No_CaptionLbl)
            {
            }
            column(Insurance_No_Caption; Insurance_No_CaptionLbl)
            {
            }
            column(Name_of_the_Insured_PersonCaption; Name_of_the_Insured_PersonCaptionLbl)
            {
            }
            column(No__Of_Days_for_which_Wages_PaidCaption; No__Of_Days_for_which_Wages_PaidCaptionLbl)
            {
            }
            column(Total_amount_of_Wages_PaidCaption; Total_amount_of_Wages_PaidCaptionLbl)
            {
            }
            column(Employee_s_Contribution_DeductedCaption; Employee_s_Contribution_DeductedCaptionLbl)
            {
            }
            column(Daily_Wages__5_4Caption; Daily_Wages__5_4CaptionLbl)
            {
            }
            column(Whether_still_continues_working_and_drawing_wages_with_insurable_wage_ceilingCaption; Whether_still_continues_working_and_drawing_wages_with_insurable_wage_ceilingCaptionLbl)
            {
            }
            column(Remarks___Name_of_the_DispensaryCaption; Remarks___Name_of_the_DispensaryCaptionLbl)
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
            column(V8Caption; V8CaptionLbl)
            {
            }
            column(V7ACaption; V7ACaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(SIGNATURE_OF_THE_EMPLOYERCaption; SIGNATURE_OF_THE_EMPLOYERCaptionLbl)
            {
            }
            column(FOR_USE_IN_REGIONAL_OF_E_S_I_CORPORATION__Caption; FOR_USE_IN_REGIONAL_OF_E_S_I_CORPORATION__CaptionLbl)
            {
            }
            column(Entitlement_Position_MarkedCaption; Entitlement_Position_MarkedCaptionLbl)
            {
            }
            column(U_D_CCaption; U_D_CCaptionLbl)
            {
            }
            column(CountersignedCaption; CountersignedCaptionLbl)
            {
            }
            column(BRANCH_OFFICERCaption; BRANCH_OFFICERCaptionLbl)
            {
            }
            column(Total_of_col__5__of_the_Return_checked_and_found_correct_correct_amount_indicated_in_PenCaption; Total_of_col__5__of_the_Return_checked_and_found_correct_correct_amount_indicated_in_PenCaptionLbl)
            {
            }
            column(Checked_the_amount_of_employers___employees_contribution_paid_which_is_in_order___obervation_memo_inclosedCaption; Checked_the_amount_of_employers___employees_contribution_paid_which_is_in_order___obervation_memo_inclosedCaptionLbl)
            {
            }
            column(U_D_CCaption_Control1102152061; U_D_CCaption_Control1102152061Lbl)
            {
            }
            column(COUNTERSIGNEDCaption_Control1102152062; COUNTERSIGNEDCaption_Control1102152062Lbl)
            {
            }
            column(HEAD_CLERKCaption; HEAD_CLERKCaptionLbl)
            {
            }
            column(BRANCH_OFFICERCaption_Control1102152064; BRANCH_OFFICERCaption_Control1102152064Lbl)
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
                if PrevEmpCode <> "Processed Salary"."Employee Code" then begin
                    Attendance1 := 0;
                    GrossSal := 0;
                    EmpCon := 0;
                    DailyWages := 0;
                    ShowOutput := true;
                    TempForNewEmp := '';
                end;

                EmpCode := "Processed Salary"."Employee Code";

                if DATE2DMY(StartDate, 3) <> DATE2DMY(EndDate, 3) then begin
                    if ("Processed Salary"."Pay Slip Month" >= DATE2DMY(StartDate, 2)) and ("Processed Salary".Year = DATE2DMY(StartDate, 3)) or
                       ("Processed Salary"."Pay Slip Month" <= DATE2DMY(EndDate, 2)) and ("Processed Salary".Year = DATE2DMY(EndDate, 3)) then
                        Take := true;
                end else
                    if ("Processed Salary"."Pay Slip Month" >= DATE2DMY(StartDate, 2)) and
                   ("Processed Salary"."Pay Slip Month" <= DATE2DMY(EndDate, 2)) then
                        Take := true
                    else
                        Take := false;
                if Take then begin
                    if Employee.GET(EmpCode) then
                        if (DATE2DMY(Employee."Employment Date", 2) = "Processed Salary"."Pay Slip Month") and
                           (DATE2DMY(Employee."Employment Date", 3) = "Processed Salary".Year) then
                            TempForNewEmp := Text330001Txt + FORMAT(Employee."Employment Date")
                        else
                            if Employee."Resignation Date" <> 0D then
                                if (DATE2DMY(Employee."Resignation Date", 2) = "Processed Salary"."Pay Slip Month") and
                                   (DATE2DMY(Employee."Resignation Date", 3) = "Processed Salary".Year) then
                                    TempForNewEmp := Text330002Txt + FORMAT(Employee."Employment Date");
                    if ShowOutput then begin
                        Attendance1 := "Processed Salary".Attendance;
                        GrossSal += "Processed Salary".Salary;
                        PayRevisionLine.SETRANGE("No.", "Processed Salary"."Employee Code");
                        PayRevisionLine.SETRANGE(Month, "Processed Salary"."Pay Slip Month");
                        PayRevisionLine.SETRANGE(Year, "Processed Salary".Year);
                        PayRevisionLine.SETRANGE("Pay Element", esiTxt);
                        if PayRevisionLine.FINDFIRST() then
                            repeat
                                GrossSal += PayRevisionLine."Arrear Amount";
                            until PayRevisionLine.NEXT() = 0;
                        ESI.RESET();
                        ESI.SETFILTER("Effective Date", '<%1', TODAY());
                        if ESI.FINDLAST() then
                            if "Processed Salary".Attendance <> 0 then
                                EmpCon += (GrossSal * ESI."Employee %") / 100;
                        if "Processed Salary".Attendance <> 0 then
                            DailyWages += GrossSal / Attendance1;
                    end;
                    GrossTotal += GrossSal;
                end;
                PrevEmpCode := "Processed Salary"."Employee Code";
                if ShowOutput then "SlNo." := "SlNo." + 1;
            end;

            trigger OnPreDataItem();
            begin
                Company.GET();
                TempCount := 0;
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                SETRANGE("Processed Salary"."Add/Deduct Code", esiTxt);
                Attendance1 := 0;
                GrossSal := 0;
                EmpCon := 0;
                DailyWages := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ESIYear; ESIYearGVar)
                {
                    ToolTip = 'Choose the ESI Year.';
                    Caption = 'Year';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PayrollYears.SETRANGE(PayrollYears."Year Type", ESIYEARTxt);
                        if PAGE.RUNMODAL(0, PayrollYears) = ACTION::LookupOK then begin
                            ESIYearGVar := PayrollYears."Year Type";
                            StartDate := PayrollYears."Year Start Date";
                            EndDate := PayrollYears."Year End Date";
                        end;
                    end;
                }
            }
        }

        actions
        {
        }
    }

    var
        Company: Record "Company Information";
        ESI: Record ESI_B2B;
        PayRevisionLine: Record "Pay Revision Line B2B";
        PayrollYears: Record "Payroll Year B2B";
        Employee: Record "Employee B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        "SlNo.": Integer;
        Attendance1: Decimal;
        GrossSal: Decimal;
        EmpCon: Decimal;
        DailyWages: Decimal;

        ShowOutput: Boolean;

        StartDate: Date;
        EndDate: Date;
        ESIYearGVar: Code[50];
        Take: Boolean;
        GrossTotal: Decimal;
        PrevEmpCode: Code[20];
        TempForNewEmp: Text[50];
        TempCount: Integer;
        EmpCode: Code[20];

        Employees__State_Insurance_CorporationCaptionLbl: Label 'Employees'' State Insurance Corporation';
        Employer_s_Code_No_CaptionLbl: Label 'Employer''s Code No.';
        FORM_6ACaptionLbl: Label 'FORM-6A';
        Sl_No_CaptionLbl: Label 'Sl No.';
        Insurance_No_CaptionLbl: Label 'Insurance No.';
        Name_of_the_Insured_PersonCaptionLbl: Label 'Name of the Insured Person';
        No__Of_Days_for_which_Wages_PaidCaptionLbl: Label 'No. Of Days for which Wages Paid';
        Total_amount_of_Wages_PaidCaptionLbl: Label 'Total amount of Wages Paid';
        Employee_s_Contribution_DeductedCaptionLbl: Label 'Employee''s Contribution Deducted';
        Daily_Wages__5_4CaptionLbl: Label 'Daily Wages  5/4';
        Whether_still_continues_working_and_drawing_wages_with_insurable_wage_ceilingCaptionLbl: Label 'Whether still continues working and drawing wages with insurable wage ceiling';
        Remarks___Name_of_the_DispensaryCaptionLbl: Label 'Remarks / Name of the Dispensary';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        V4CaptionLbl: Label '4';
        V5CaptionLbl: Label '5';
        V6CaptionLbl: Label '6';
        V7CaptionLbl: Label '7';
        V8CaptionLbl: Label '8';
        V7ACaptionLbl: Label '7A';
        Page_No_CaptionLbl: Label 'Page No.';
        SIGNATURE_OF_THE_EMPLOYERCaptionLbl: Label 'SIGNATURE OF THE EMPLOYER';
        FOR_USE_IN_REGIONAL_OF_E_S_I_CORPORATION__CaptionLbl: Label '( FOR USE IN REGIONAL OF E.S.I CORPORATION )';
        Entitlement_Position_MarkedCaptionLbl: Label 'Entitlement Position Marked';
        U_D_CCaptionLbl: Label 'U.D.C';
        CountersignedCaptionLbl: Label 'Countersigned';
        BRANCH_OFFICERCaptionLbl: Label 'BRANCH OFFICER';
        Total_of_col__5__of_the_Return_checked_and_found_correct_correct_amount_indicated_in_PenCaptionLbl: Label 'Total of col (5) of the Return checked and found correct"correct amount indicated in Pen';
        Checked_the_amount_of_employers___employees_contribution_paid_which_is_in_order___obervation_memo_inclosedCaptionLbl: Label 'Checked the amount of employers / employees contribution paid which is in order / obervation memo inclosed';
        U_D_CCaption_Control1102152061Lbl: Label 'U.D.C';
        COUNTERSIGNEDCaption_Control1102152062Lbl: Label 'COUNTERSIGNED';
        HEAD_CLERKCaptionLbl: Label 'HEAD CLERK';
        BRANCH_OFFICERCaption_Control1102152064Lbl: Label 'BRANCH OFFICER';
        esiTxt: Label 'esi';
        Text330001Txt: Label '"A  -- "';
        Text330002Txt: Label '"L  -- "';
        ESIYEARTxt: Label 'ESI YEAR';
}

