report 33001209 "PF Form No.5 B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PF Form No.5.rdlc';
    Caption = 'PF Form No.5';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.");
            column(companyinfo__Address_2_; companyinfo."Address 2")
            {
            }
            column(companyinfo_Address; companyinfo.Address)
            {
            }
            column(companyinfo_Name; companyinfo.Name)
            {
            }
            column(PFMonth; PFMonth)
            {
            }
            column(PFYear; PFYear)
            {
            }
            column(companyinfo__Address_2__Control1102152013; companyinfo."Address 2")
            {
            }
            column(SlNo; SlNo)
            {
            }
            column(Employee_B2B_Employee_B2B__PF_No_;
            "Employee B2B"."PF No")
            {
            }
            column(Employee_B2B_FullName; "Employee B2B".FullName())
            {
            }
            column(Employee_B2B_Employee_B2B__Father_Husband_;
            "Employee B2B"."Father/Husband")
            {
            }
            column(Employee_B2B_Employee_B2B__Birth_Date_;
            "Employee B2B"."Birth Date")
            {
            }
            column(Employee_B2B_Employee_B2B_Gender;
            "Employee B2B".Gender)
            {
            }
            column(Employee_B2B_Employee_B2B__Employment_Date_;
            "Employee B2B"."Employment Date")
            {
            }
            column(Show; Show)
            {
            }
            column(Code_NoCaption; Code_NoCaptionLbl)
            {
            }
            column(Name_and_address_of_the_Factory_EstablishmentCaption; Name_and_address_of_the_Factory_EstablishmentCaptionLbl)
            {
            }
            column(To_be_sent_to_the_Commissioner_with_Form_2_EPF_and__EPS_Caption; To_be_sent_to_the_Commissioner_with_Form_2_EPF_and__EPS_CaptionLbl)
            {
            }
            column(time_during_month_ofCaption; time_during_month_ofCaptionLbl)
            {
            }
            column(Return_of_Employees; Return_of_EmployeesLbl)
            {
            }
            column(THE_EMPLOYEES_PROVIDENT_FUNDS; THE_EMPLOYEES_PROVIDENT_FUNDSLbl)
            {
            }
            column(FORM_NO__5Caption; FORM_NO__5CaptionLbl)
            {
            }
            column(Sl_No_Caption; Sl_No_CaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column(Name_of_the_Employee__in_block_letters_Caption; Name_of_the_Employee__in_block_letters_CaptionLbl)
            {
            }
            column(V3Caption; V3CaptionLbl)
            {
            }
            column(Father_s_Name___________________or_husband_s_name_in_the_case_of_married_woman_Caption; Father_s_Name___________________or_husband_s_name_in_the_case_of_married_woman_CaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(Date_of_BirthCaption; Date_of_BirthCaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(SEXCaption; SEXCaptionLbl)
            {
            }
            column(V6Caption; V6CaptionLbl)
            {
            }
            column(Date_of_joining_the_FundCaption; Date_of_joining_the_FundCaptionLbl)
            {
            }
            column(V7Caption; V7CaptionLbl)
            {
            }
            column(Enclose_scheme_certificate_if_applicableCaption; Enclose_scheme_certificate_if_applicableCaptionLbl)
            {
            }
            column(Total_Period_of_previous_serviceas_on_the_date_of_joining_the_fund_Caption; Total_Period_of_previous_serviceas_on_the_date_of_joining_the_fund_CaptionLbl)
            {
            }
            column(V8Caption; V8CaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(V9Caption; V9CaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(Signature_of_the_employer_or_other_authorised_Officer_Stamp_of_the_Factory_establishment_Caption; Signature_of_the_employer_or_other_authorised_Officer_Stamp_of_the_Factory_establishment_CaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                if "Employment Date" <> 0D then
                    if (DATE2DMY("Employment Date", 2) <> PFMonth) or (DATE2DMY("Employment Date", 3) <> PFYear) then
                        Show := false
                    else begin
                        SlNo := SlNo + 1;
                        Show := true;
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
                //Caption = '<Control1900000001>';//Phani
                group(Options)
                {
                    Caption = 'Options';
                    field("<Control1102152000>"; PFMonth)
                    {
                        ToolTip = 'Select the Month for which report need to generate.';
                        Caption = 'Month';
                        OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
                        ApplicationArea = all;
                    }
                    field("<Control1102152001>"; PFYear)
                    {
                        ToolTip = 'Select the year for which report need to be generate.';
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
        companyinfo.GET();
        case PFMonth of
            1:
                "PFMonthNo." := 1;
            2:
                "PFMonthNo." := 2;
            3:
                "PFMonthNo." := 3;
            4:
                "PFMonthNo." := 4;
            5:
                "PFMonthNo." := 5;
            6:
                "PFMonthNo." := 6;
            7:
                "PFMonthNo." := 7;
            8:
                "PFMonthNo." := 8;
            9:
                "PFMonthNo." := 9;
            10:
                "PFMonthNo." := 10;
            11:
                "PFMonthNo." := 11;
            12:
                "PFMonthNo." := 12;
        end;
    end;

    var
        companyinfo: Record "Company Information";
        SlNo: Integer;
        PFMonth: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        PFYear: Integer;
        "PFMonthNo.": Integer;
        Show: Boolean;
        Code_NoCaptionLbl: Label 'Code No';
        Name_and_address_of_the_Factory_EstablishmentCaptionLbl: Label 'Name and address of the Factory/Establishment';
        To_be_sent_to_the_Commissioner_with_Form_2_EPF_and__EPS_CaptionLbl: Label 'To be sent to the Commissioner with Form 2(EPF and  EPS)';
        time_during_month_ofCaptionLbl: Label 'time during month of';
        Return_of_EmployeesLbl: Label 'Return of Employees qualifying for membership of the Employee''s Provident Fund,Employees Pension find and Employees Deposit Linked Insurance Fund for the first';
        THE_EMPLOYEES_PROVIDENT_FUNDSLbl: Label 'THE EMPLOYEES PROVIDENT FUNDS SCHEME ,1952 [Paragraph 36(2)(a)] AND THE EMPLOYEES PENSION SCHEME 1995 [Para 20(4)]';
        FORM_NO__5CaptionLbl: Label 'FORM NO. 5';
        Sl_No_CaptionLbl: Label 'Sl.No.';
        Account_No_CaptionLbl: Label 'Account No.';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        Name_of_the_Employee__in_block_letters_CaptionLbl: Label 'Name of the Employee (in block letters)';
        V3CaptionLbl: Label '3';
        Father_s_Name___________________or_husband_s_name_in_the_case_of_married_woman_CaptionLbl: Label 'Father''s Name                  (or husband''s name in the case of married woman)';
        V4CaptionLbl: Label '4';
        Date_of_BirthCaptionLbl: Label 'Date of Birth';
        V5CaptionLbl: Label '5';
        SEXCaptionLbl: Label 'SEX';
        V6CaptionLbl: Label '6';
        Date_of_joining_the_FundCaptionLbl: Label 'Date of joining the Fund';
        V7CaptionLbl: Label '7';
        Enclose_scheme_certificate_if_applicableCaptionLbl: Label 'Enclose scheme certificate if applicable';
        Total_Period_of_previous_serviceas_on_the_date_of_joining_the_fund_CaptionLbl: Label '"Total Period of previous serviceas on the date of joining the fund "';
        V8CaptionLbl: Label '8';
        RemarksCaptionLbl: Label 'Remarks';
        V9CaptionLbl: Label '9';
        Date__CaptionLbl: Label 'Date :';
        Signature_of_the_employer_or_other_authorised_Officer_Stamp_of_the_Factory_establishment_CaptionLbl: Label 'Signature of the employer or other authorised Officer(Stamp of the Factory/establishment)';
}

