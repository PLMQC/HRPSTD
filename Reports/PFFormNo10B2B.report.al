report 33001208 "PF Form No.10 B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PF Form No.10.rdl';
    Caption = 'PF Form No.10';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.");
            column(SlNo; SlNo)
            {
            }
            column(Employee_B2B_Employee_B2B__Account_No_;
            "Employee B2B"."Account No")
            {
            }
            column(Employee_B2B_FullName; "Employee B2B".FullName())
            {
            }
            column(Employee_B2B_Employee_B2B__Father_Husband_;
            "Employee B2B"."Father/Husband")
            {
            }
            column(Employee_B2B_Employee_B2B__Termination_Date_;
            "Employee B2B"."Termination Date")
            {
            }
            column(companyinfo_Name; companyinfo.Name)
            {
            }
            column(companyinfo_Address; companyinfo.Address)
            {
            }
            column(companyinfo__Address_2_; companyinfo."Address 2")
            {
            }
            column(Employee_B2B_Employee_B2B__Grounds_for_Term__Code_;
            "Employee B2B"."Grounds for Term. Code")
            {
            }
            column(PFMonthGVar; PFMonthGVar)
            {
            }
            column(PFYearGVar; PFYearGVar)
            {
            }
            column(Show; Show)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(Signature_of_the_employer_or_other_authorised_OfficerCaption; Signature_of_the_employer_or_other_authorised_OfficerCaptionLbl)
            {
            }
            column(Please_state_whether_the_member_is__a__retiring_according_to_part_69__1___a__or__b__of_the_scheme_Caption; Please_state_whether_the_member_is__a__retiring_according_to_part_69__1___a__or__b__of_the_scheme_CaptionLbl)
            {
            }
            column(b__leaving_India_for_permanent_settlement_aboard_Caption; b__leaving_India_for_permanent_settlement_aboard_CaptionLbl)
            {
            }
            column(c__refrenched_Caption; c__refrenched_CaptionLbl)
            {
            }
            column(d__ordinarily_dismissed_dismissed_for_serious_and_wilful_misconduct_Caption; d__ordinarily_dismissed_dismissed_for_serious_and_wilful_misconduct_CaptionLbl)
            {
            }
            column(e__discharged__f__resigning_from_or_leaving_serviceCaption; e__discharged__f__resigning_from_or_leaving_serviceCaptionLbl)
            {
            }
            column(f__taking_up_employement_elsewhere__the_name_address_of_new_employer_should_be_stated_Caption; f__taking_up_employement_elsewhere__the_name_address_of_new_employer_should_be_stated_CaptionLbl)
            {
            }
            column(h__dead_Caption; h__dead_CaptionLbl)
            {
            }
            column(A_request_for_deduction; A_request_for_deductionLbl)
            {
            }
            column(Certified_that_the_member_mentioned_at_serial_NoCaption; Certified_that_the_member_mentioned_at_serial_NoCaptionLbl)
            {
            }
            column(ShriCaption; ShriCaptionLbl)
            {
            }
            column(was_dismissed_for_serious_and_wilful_misconduct_Caption; was_dismissed_for_serious_and_wilful_misconduct_CaptionLbl)
            {
            }
            column(I_recommend_that_the_employer_s_contribution_forCaption; I_recommend_that_the_employer_s_contribution_forCaptionLbl)
            {
            }
            column(Sl_No_Caption; Sl_No_CaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
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
            column(Father_s_name_or_husband_s_name_in_case_of_married_woman_Caption; Father_s_name_or_husband_s_name_in_case_of_married_woman_CaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(Date_of_leaving_serviceCaption; Date_of_leaving_serviceCaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(Reasons_for_leaving_ServiceCaption; Reasons_for_leaving_ServiceCaptionLbl)
            {
            }
            column(V6Caption; V6CaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(V7Caption; V7CaptionLbl)
            {
            }
            column(DataItem1102152099; THE_EMPLOYEES_PROVIDENTCaptionLbl)
            {
            }
            column(FORM_NO__10Caption; FORM_NO__10CaptionLbl)
            {
            }
            column(Return_of_the_members_leaving_service_during_the_month_of_Caption; Return_of_the_members_leaving_service_during_the_month_of_CaptionLbl)
            {
            }
            column(Name_and_address_of_the_Factory_Esst__Caption; Name_and_address_of_the_Factory_Esst__CaptionLbl)
            {
            }
            column(Code_No__Caption; Code_No__CaptionLbl)
            {
            }
            column(should_be_forfeited_from_his_account_in_the_Fund_A_copy_of_the_order_of_dismissal_is_enclosedCaption; should_be_forfeited_from_his_account_in_the_Fund_A_copy_of_the_order_of_dismissal_is_enclosedCaptionLbl)
            {
            }
            column(in_case_of_discharge_from_service_the_following_certificate_should_be_completed_Caption; in_case_of_discharge_from_service_the_following_certificate_should_be_completed_CaptionLbl)
            {
            }
            column(Certified_that_the_member_mentioned_at_S_No_Caption; Certified_that_the_member_mentioned_at_S_No_CaptionLbl)
            {
            }
            column(ShriCaption_Control1102152003; ShriCaption_Control1102152003Lbl)
            {
            }
            column(was_paid_net_paid_retrenchment_compensation_ofCaption; was_paid_net_paid_retrenchment_compensation_ofCaptionLbl)
            {
            }
            column(RsCaption; RsCaptionLbl)
            {
            }
            column(under_the_Industrial_Disputes_Act___1947_Caption; under_the_Industrial_Disputes_Act___1947_CaptionLbl)
            {
            }
            column(Signature_of_the_employer_Caption; Signature_of_the_employer_CaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                SlNo := SlNo + 1;
                if (DATE2DMY("Resignation Date", 2) <> PFMonthGVar) or (DATE2DMY("Resignation Date", 3) <> PFYearGVar) then
                    Show := false
                else
                    Show := true;
            end;

            trigger OnPreDataItem();
            begin
                SETFILTER("Resignation Date", '<>%1', 0D);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                //Caption = 'Options';//Phani
                group(Control1102152003)
                {
                    field(PFMonth; PFMonthGVar)
                    {
                        ToolTip = 'Select the Month for which report need to generate.';
                        Caption = 'Month';
                        OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
                        ApplicationArea = all;
                    }
                    field(PFYear; PFYearGVar)
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
        case PFMonthGVar of
            1:
                PFMonthNo := 1;
            2:
                PFMonthNo := 2;
            3:
                PFMonthNo := 3;
            4:
                PFMonthNo := 4;
            5:
                PFMonthNo := 5;
            6:
                PFMonthNo := 6;
            7:
                PFMonthNo := 7;
            8:
                PFMonthNo := 8;
            9:
                PFMonthNo := 9;
            10:
                PFMonthNo := 10;
            11:
                PFMonthNo := 11;
            12:
                PFMonthNo := 12;
        end;
    end;

    var
        companyinfo: Record "Company Information";
        SlNo: Integer;
        PFMonthGVar: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        PFYearGVar: Integer;
        PFMonthNo: Integer;
        Show: Boolean;
        Date__CaptionLbl: Label 'Date :';
        Signature_of_the_employer_or_other_authorised_OfficerCaptionLbl: Label 'Signature of the employer or other authorised Officer';
        Please_state_whether_the_member_is__a__retiring_according_to_part_69__1___a__or__b__of_the_scheme_CaptionLbl: Label 'Please state whether the member is (a) retiring according to part 69 (1) (a) or (b) of the scheme,';
        b__leaving_India_for_permanent_settlement_aboard_CaptionLbl: Label '(b) leaving India for permanent settlement aboard,';
        c__refrenched_CaptionLbl: Label '(c) refrenched,';
        d__ordinarily_dismissed_dismissed_for_serious_and_wilful_misconduct_CaptionLbl: Label '(d) ordinarily dismissed,dismissed for serious and wilful misconduct,';
        e__discharged__f__resigning_from_or_leaving_serviceCaptionLbl: Label '(e) discharged (f) resigning from or leaving service';
        f__taking_up_employement_elsewhere__the_name_address_of_new_employer_should_be_stated_CaptionLbl: Label '(f) taking up employement elsewhere,(the name address of new employer should be stated,';
        h__dead_CaptionLbl: Label '(h) dead,';
        A_request_for_deductionLbl: Label 'A request for deduction from the Account member dismissed for serious and wilful misconduct should be reported by following Certificate';
        Certified_that_the_member_mentioned_at_serial_NoCaptionLbl: Label '"""Certified that the member mentioned at serial No"';
        ShriCaptionLbl: Label 'Shri';
        was_dismissed_for_serious_and_wilful_misconduct_CaptionLbl: Label 'was dismissed for serious and wilful misconduct"';
        I_recommend_that_the_employer_s_contribution_forCaptionLbl: Label 'I recommend that the employer''s contribution for';
        Sl_No_CaptionLbl: Label 'Sl.No.';
        V1CaptionLbl: Label '1';
        Account_No_CaptionLbl: Label 'Account No.';
        V2CaptionLbl: Label '2';
        Name_of_the_Employee__in_block_letters_CaptionLbl: Label 'Name of the Employee (in block letters)';
        V3CaptionLbl: Label '3';
        Father_s_name_or_husband_s_name_in_case_of_married_woman_CaptionLbl: Label 'Father''s name(or husband''s name in case of married woman)';
        V4CaptionLbl: Label '4';
        Date_of_leaving_serviceCaptionLbl: Label 'Date of leaving service';
        V5CaptionLbl: Label '5';
        Reasons_for_leaving_ServiceCaptionLbl: Label 'Reasons for leaving Service';
        V6CaptionLbl: Label '6';
        RemarksCaptionLbl: Label 'Remarks';
        V7CaptionLbl: Label '7';
        THE_EMPLOYEES_PROVIDENTCaptionLbl: Label 'THE EMPLOYEES PROVIDENT FUNDS SCHEME ,1952 [Paragraph 36(2)(a)&(b)] AND THE EMPLOYEES PENSION SCHEME 1995 [Para 20(2)]';
        FORM_NO__10CaptionLbl: Label 'FORM NO. 10';
        Return_of_the_members_leaving_service_during_the_month_of_CaptionLbl: Label '"Return of the members leaving service during the month of "';
        Name_and_address_of_the_Factory_Esst__CaptionLbl: Label 'Name and address of the Factory/Esst :';
        Code_No__CaptionLbl: Label 'Code No :';
        should_be_forfeited_from_his_account_in_the_Fund_A_copy_of_the_order_of_dismissal_is_enclosedCaptionLbl: Label 'should be forfeited from his account in the Fund.A copy of the order of dismissal is enclosed';
        in_case_of_discharge_from_service_the_following_certificate_should_be_completed_CaptionLbl: Label '"""in case of discharge from service,the following certificate should be completed:"';
        Certified_that_the_member_mentioned_at_S_No_CaptionLbl: Label '"Certified that the member mentioned at S.No "';
        ShriCaption_Control1102152003Lbl: Label 'Shri';
        was_paid_net_paid_retrenchment_compensation_ofCaptionLbl: Label 'was paid/net paid retrenchment compensation of';
        RsCaptionLbl: Label 'Rs';
        under_the_Industrial_Disputes_Act___1947_CaptionLbl: Label 'under the Industrial Disputes Act., 1947"';
        Signature_of_the_employer_CaptionLbl: Label '"Signature of the employer "';
}

