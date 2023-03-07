report 33001292 "ESI Monthly Statement B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\ESI Monthly Statement.rdlc';
    Caption = 'ESI Monthly Statement';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("ESI Applicable" = CONST(true), Blocked = CONST(false));
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            /*
             column(CurrReport_PAGENO; CurrReport.PAGENO)
             {
             }*/
            column(USERID; USERID())
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(ESIYear; ESIYear)
            {
            }
            column(ESIMonth; ESIMonth)
            {
            }
            column(TotalBASIC; TotalBASIC)
            {
            }
            column(TotalHRA; TotalHRA)
            {
            }
            column(TotalSpecialAllowances; TotalSpecialAllowances)
            {
            }
            column(TotalConveyance; TotalConveyance)
            {
            }
            column(TotalWages; TotalWages)
            {
            }
            column(TotalAttendance; TotalAttendance)
            {
            }
            column(TotalEmployerContri; TotalEmployerContri)
            {
            }
            column(TotalEmployeeContri; TotalEmployeeContri)
            {
            }
            column(GrandESITotal; GrandESITotal)
            {
            }
            column(ESI_ContributionCaption; ESI_ContributionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Month__Caption; Month__CaptionLbl)
            {
            }
            column(Year__Caption; Year__CaptionLbl)
            {
            }
            column(BasicCaption; BasicCaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(HRACaption; HRACaptionLbl)
            {
            }
            column(MedicalCaption; MedicalCaptionLbl)
            {
            }
            column(Food_CopCaption; Food_CopCaptionLbl)
            {
            }
            column(Spl_AllCaption; Spl_AllCaptionLbl)
            {
            }
            column(ConveyanceCaption; ConveyanceCaptionLbl)
            {
            }
            column(WagesCaption; WagesCaptionLbl)
            {
            }
            column(Payable_daysCaption; Payable_daysCaptionLbl)
            {
            }
            column(EMP_ER__CONTCaption; EMP_ER__CONTCaptionLbl)
            {
            }
            column(EMP_EE__CONTCaption; EMP_EE__CONTCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
            column(EmployeeGRec_FirstName; EmployeeGRec."First Name")
            {
            }
            column(EmployeeGRec_MiddleName; EmployeeGRec."Middle Name")
            {
            }
            column(EmployeeGRec_Initials; EmployeeGRec.Initials)
            {
            }
            dataitem("Processed Salary"; "Processed Salary B2B")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = SORTING("Employee Code", Year, "Pay Slip Month", "Add/Deduct") ORDER(Ascending);
                column(Processed_Salary__Employee_Code_; "Employee Code")
                {
                }
                column(EmployeeGRec__First_Name______EmployeeGRec__Middle_Name______EmployeeGRec_Initials; EmployeeGRec."First Name" + ' ' + EmployeeGRec."Middle Name" + ' ' + EmployeeGRec.Initials)
                {
                }
                column(PayelementEarned_1_; PayelementEarned[1])
                {
                }
                column(PayelementEarned_2_; PayelementEarned[2])
                {
                }
                column(PayelementEarned_3_; PayelementEarned[3])
                {
                }
                column(PayelementEarned_4_; PayelementEarned[4])
                {
                }
                column(PayelementEarned_1__PayelementEarned_2__PayelementEarned_3__PayelementEarned_4_; PayelementEarned[1] + PayelementEarned[2] + PayelementEarned[3] + PayelementEarned[4])
                {
                }
                column(ProcessedsalaryGrec_Attendance; ProcessedsalaryGrec.Attendance)
                {
                }
                column(EmployerContri; EmployerContri)
                {
                }
                column(EmployeeContri; EmployeeContri)
                {
                }
                column(TotalESIConti; TotalESIConti)
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
                    if "Processed Salary"."Add/Deduct Code" = Text002Txt then begin
                        PayelementEarned[1] := "Processed Salary"."Earned Amount";
                        TotalBASIC := TotalBASIC + "Processed Salary"."Earned Amount";
                    end else
                        if "Processed Salary"."Add/Deduct Code" = HRACaptionLbl then begin
                            PayelementEarned[2] := "Processed Salary"."Earned Amount";
                            TotalHRA := TotalHRA + "Processed Salary"."Earned Amount";
                        end else
                            if ("Processed Salary"."Add/Deduct Code" = Text004Txt) or ("Processed Salary"."Add/Deduct Code" = Text005Txt) then begin
                                PayelementEarned[3] := "Processed Salary"."Earned Amount";
                                TotalSpecialAllowances := TotalSpecialAllowances + "Processed Salary"."Earned Amount";
                            end else
                                if "Processed Salary"."Add/Deduct Code" = Text006Txt then begin
                                    PayelementEarned[4] := "Processed Salary"."Earned Amount";
                                    TotalConveyance := TotalConveyance + "Processed Salary"."Earned Amount";
                                end;


                    TotalEarnedAmount := TotalEarnedAmount + "Processed Salary"."Earned Amount";
                    TotalWages := TotalWages + "Processed Salary"."Earned Amount";
                    EmployeeGRec.GET("Processed Salary"."Employee Code");

                    CLEAR(EmployeeContri);
                    CLEAR(EmployerContri);
                    CLEAR(TotalESIConti);

                    ProcessedsalaryGrec.RESET();
                    ProcessedsalaryGrec.SETRANGE("Employee Code", "Processed Salary"."Employee Code");
                    ProcessedsalaryGrec.SETRANGE("Pay Slip Month", "Processed Salary"."Pay Slip Month");
                    ProcessedsalaryGrec.SETRANGE(Year, "Processed Salary".Year);
                    ProcessedsalaryGrec.SETRANGE("Add/Deduct Code", Text007Txt);
                    if ProcessedsalaryGrec.FINDFIRST() then
                        EmployeeContri := ProcessedsalaryGrec."Earned Amount";

                    EmployerContri := ROUND((TotalEarnedAmount * 4.75) / 100, 1);
                    TotalESIConti := EmployeeContri + EmployerContri;
                end;

                trigger OnPostDataItem();
                begin
                    TotalEmployeeContri += EmployeeContri;
                    TotalAttendance := TotalAttendance + ProcessedsalaryGrec.Attendance;
                    TotalEmployerContri := TotalEmployerContri + EmployerContri;
                    GrandESITotal := GrandESITotal + TotalESIConti;
                end;

                trigger OnPreDataItem();
                begin
                    CompanyInfo.GET();
                    "Processed Salary".SETRANGE("Pay Slip Month", ESIMonth);
                    "Processed Salary".SETRANGE(Year, ESIYear);
                    "Processed Salary".SETRANGE("Processed Salary"."Add/Deduct", "Processed Salary"."Add/Deduct"::Addition);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if "Employee B2B".Blocked then
                    if "Employee B2B"."Blocked Date" < CheckDate then
                        CurrReport.SKIP();
                CLEAR(TotalEarnedAmount);
            end;

            trigger OnPostDataItem();
            begin
                CLEAR(CmpName);
                CmpName := COPYSTR(CompanyInfo.Name, 1, MAXSTRLEN(CmpName) - 1);
            end;

            trigger OnPreDataItem();
            begin
                CheckDate := DMY2DATE(1, ESIMonth, ESIYear);


                TotalBASIC := 0;
                TotalHRA := 0;
                TotalSpecialAllowances := 0;
                TotalConveyance := 0;
                TotalWages := 0;
                TotalAttendance := 0;
                TotalEmployerContri := 0;
                TotalEmployeeContri := 0;
                GrandESITotal := 0;
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
                    field(Month; ESIMonth)
                    {
                        ToolTip = 'Choose the Month.';
                        Caption = 'Month';
                        ApplicationArea = all;
                    }
                    field(Year; ESIYear)
                    {
                        ToolTip = 'Enter the Year.';
                        Caption = 'Year';
                        ApplicationArea = all;
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

    trigger OnPreReport();
    begin
        if (ESIYear = 0) or (ESIMonth = 0) or (ESIMonth > 12) then
            ERROR(Text001Txt);
    end;

    var
        CompanyInfo: Record "Company Information";
        ProcessedsalaryGrec: Record "Processed Salary B2B";
        EmployeeGRec: Record "Employee B2B";
        ESIYear: Integer;
        ESIMonth: Integer;
        CheckDate: Date;
        TotalEarnedAmount: Decimal;
        EmployerContri: Decimal;
        EmployeeContri: Decimal;
        TotalESIConti: Decimal;
        PayelementEarned: array[33] of Decimal;

        TotalBASIC: Decimal;
        TotalHRA: Decimal;
        TotalSpecialAllowances: Decimal;
        TotalConveyance: Decimal;
        TotalWages: Decimal;
        TotalAttendance: Decimal;
        TotalEmployerContri: Decimal;
        TotalEmployeeContri: Decimal;
        GrandESITotal: Decimal;
        CmpName: Text;
        ESI_ContributionCaptionLbl: Label 'ESI Monthly Statement';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Month__CaptionLbl: Label 'Month :';
        Year__CaptionLbl: Label 'Year :';
        BasicCaptionLbl: Label 'Basic';
        Employee_No_CaptionLbl: Label 'Employee No.';
        NameCaptionLbl: Label 'Name';
        HRACaptionLbl: Label 'HRA';
        MedicalCaptionLbl: Label 'Medical';
        Food_CopCaptionLbl: Label 'Food Cop';
        Spl_AllCaptionLbl: Label 'Spl All';
        ConveyanceCaptionLbl: Label 'Conveyance';
        WagesCaptionLbl: Label 'Wages';
        Payable_daysCaptionLbl: Label 'Payable days';
        EMP_ER__CONTCaptionLbl: Label 'EMP''ER/ CONT';
        EMP_EE__CONTCaptionLbl: Label 'EMP''EE/ CONT';
        TotalCaptionLbl: Label 'Total';
        Text001Txt: Label 'Enter a valid month and year';
        Text002Txt: Label 'BASIC';
        Text004Txt: Label 'CCA';
        Text005Txt: Label 'SPL ALL';
        Text006Txt: Label 'CA';
        Text007Txt: Label 'ESI';
}

