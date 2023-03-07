report 33001302 "PF Form 13 B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PF Form 13.rdlc';
    Caption = 'PF Form 13';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Text001; Text001Lbl)
            {
            }
            column(Text003; Text003Lbl)
            {
            }
            column(Text002; Text002Lbl)
            {
            }
            column(FOR_OFFICE_USE_ONLYCaption; FOR_OFFICE_USE_ONLYCaptionLbl)
            {
            }
            column(Form_13__REVISED_Caption; Form_13__REVISED_CaptionLbl)
            {
            }
            column(THE_EMPLOYEE_S_PROVIDENT_FUND_SCHEME__1952Caption; THE_EMPLOYEE_S_PROVIDENT_FUND_SCHEME__1952CaptionLbl)
            {
            }
            column(Date_Seal___Reg__No_Caption; Date_Seal___Reg__No_CaptionLbl)
            {
            }
            column(Para_57__Caption; Para_57__CaptionLbl)
            {
            }
            column(APPLICATION_FOR_TRANSFER_OF_EPF_ACCOUNTCaption; APPLICATION_FOR_TRANSFER_OF_EPF_ACCOUNTCaptionLbl)
            {
            }
            column(Note_Caption; Note_CaptionLbl)
            {
            }
            column(ToCaption; ToCaptionLbl)
            {
            }
            column(The_CommissionerCaption; The_CommissionerCaptionLbl)
            {
            }
            column(Employee_s_Prvident_FundsCaption; Employee_s_Prvident_FundsCaptionLbl)
            {
            }
            column(ToCaption_Control1102152092; ToCaption_Control1102152092Lbl)
            {
            }
            column(M_sCaption; M_sCaptionLbl)
            {
            }
            column(Sir_Caption; Sir_CaptionLbl)
            {
            }
            column(To_be_filled_in_if_note__ii__above_is_applicable_Caption; To_be_filled_in_if_note__ii__above_is_applicable_CaptionLbl)
            {
            }
            column(V1__NameCaption; V1__NameCaptionLbl)
            {
            }
            column(V2__Father_s_Husband_s_name_in_case_of_married_womenCaption; V2__Father_s_Husband_s_name_in_case_of_married_womenCaptionLbl)
            {
            }
            column(V3__Name___Address_of_the_previous_employerCaption; V3__Name___Address_of_the_previous_employerCaptionLbl)
            {
            }
            column(V4__EPF_account_Number_with_the_previous_employerCaption; V4__EPF_account_Number_with_the_previous_employerCaptionLbl)
            {
            }
            column(V5__By_whom_the_PF_account_of_the_previous_estt__is_keptCaption; V5__By_whom_the_PF_account_of_the_previous_estt__is_keptCaptionLbl)
            {
            }
            column(V6__FPF_Account_Number_with_the_previous_employerCaption; V6__FPF_Account_Number_with_the_previous_employerCaptionLbl)
            {
            }
            column(V7__Date_of_leaving_service_with_previous_employerCaption; V7__Date_of_leaving_service_with_previous_employerCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152006; EmptyStringCaption_Control1102152006Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152007; EmptyStringCaption_Control1102152007Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152013; EmptyStringCaption_Control1102152013Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152091; EmptyStringCaption_Control1102152091Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152101; EmptyStringCaption_Control1102152101Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152102; EmptyStringCaption_Control1102152102Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152104; EmptyStringCaption_Control1102152104Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152106; EmptyStringCaption_Control1102152106Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152107; EmptyStringCaption_Control1102152107Lbl)
            {
            }
            column(Regional_PF______________________Name_of_the_PF_Trust_Commissioner_atCaption; Regional_PF______________________Name_of_the_PF_Trust_Commissioner_atCaptionLbl)
            {
            }
            column(If_allotted_a_separate_one__Caption; If_allotted_a_separate_one__CaptionLbl)
            {
            }
            column(V8__Date_of_joining_the_present_employerCaption; V8__Date_of_joining_the_present_employerCaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Signature__Left_Hand_Thumb_impression_of_the_MemberCaption; Signature__Left_Hand_Thumb_impression_of_the_MemberCaptionLbl)
            {
            }
            column(TO_BE_FILLED_IN_BY_THE_PRESENT_EMPLOYERCaption; TO_BE_FILLED_IN_BY_THE_PRESENT_EMPLOYERCaptionLbl)
            {
            }
            column(V9__Name_and_address_of_establishmentCaption; V9__Name_and_address_of_establishmentCaptionLbl)
            {
            }
            column(V10__EPF_Code___Account_No__allotted_to_the_memberCaption; V10__EPF_Code___Account_No__allotted_to_the_memberCaptionLbl)
            {
            }
            column(V11__FPF_Account_Number_allotted_to_the_member_seperatelyCaption; V11__FPF_Account_Number_allotted_to_the_member_seperatelyCaptionLbl)
            {
            }
            column(If_anyCaption; If_anyCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
        }
    }

    requestpage
    {
        Caption = 'PF Form 13';

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

        Text001Lbl: Label '(i) To be submitted by the member of the present employer for onward transmission to the Commissioner EPF by whom the transfer is to be effected.';
        Text002Lbl: Label '(ii) In case the P.F transfer is due from the P.F. Trust of an exempted establishment, the application should be sent direct by the employer to the P.F. Trust of the exempted establishment, with a copy to the RPF concerned for details of the Family Pension/Employees Pension Scheme membership.';
        Text003Lbl: Label '"                   I requst that my Provident Fund balance along with the Membership details in Family Pension Funds may please be transferred to my present account under intimation to me. Necessary particulars are furnished below."';
        FOR_OFFICE_USE_ONLYCaptionLbl: Label 'FOR OFFICE USE ONLY';
        Form_13__REVISED_CaptionLbl: Label 'Form 13 (REVISED)';
        THE_EMPLOYEE_S_PROVIDENT_FUND_SCHEME__1952CaptionLbl: Label 'THE EMPLOYEE''S PROVIDENT FUND SCHEME, 1952';
        Date_Seal___Reg__No_CaptionLbl: Label 'Date Seal / Reg. No.';
        Para_57__CaptionLbl: Label '( Para 57 )';
        APPLICATION_FOR_TRANSFER_OF_EPF_ACCOUNTCaptionLbl: Label 'APPLICATION FOR TRANSFER OF EPF ACCOUNT';
        Note_CaptionLbl: Label 'Note:';
        ToCaptionLbl: Label 'To';
        The_CommissionerCaptionLbl: Label 'The Commissioner';
        Employee_s_Prvident_FundsCaptionLbl: Label 'Employee''s Prvident Funds';
        ToCaption_Control1102152092Lbl: Label 'To';
        M_sCaptionLbl: Label 'M/s';
        Sir_CaptionLbl: Label 'Sir,';
        To_be_filled_in_if_note__ii__above_is_applicable_CaptionLbl: Label '( To be filled in if note (ii) above is applicable)';
        V1__NameCaptionLbl: Label '1. Name';
        V2__Father_s_Husband_s_name_in_case_of_married_womenCaptionLbl: Label '2. Father''s/Husband''s name in case of married women';
        V3__Name___Address_of_the_previous_employerCaptionLbl: Label '3. Name & Address of the previous employer';
        V4__EPF_account_Number_with_the_previous_employerCaptionLbl: Label '4. EPF account Number with the previous employer';
        V5__By_whom_the_PF_account_of_the_previous_estt__is_keptCaptionLbl: Label '5. By whom the PF account of the previous estt. is kept';
        V6__FPF_Account_Number_with_the_previous_employerCaptionLbl: Label '6. FPF Account Number with the previous employer';
        V7__Date_of_leaving_service_with_previous_employerCaptionLbl: Label '7. Date of leaving service with previous employer';
        EmptyStringCaptionLbl: Label '" :"';
        EmptyStringCaption_Control1102152006Lbl: Label '" :"';
        EmptyStringCaption_Control1102152007Lbl: Label '" :"';
        EmptyStringCaption_Control1102152013Lbl: Label '" :"';
        EmptyStringCaption_Control1102152091Lbl: Label '" :"';
        EmptyStringCaption_Control1102152101Lbl: Label '" :"';
        EmptyStringCaption_Control1102152102Lbl: Label '" :"';
        EmptyStringCaption_Control1102152104Lbl: Label '" :"';
        EmptyStringCaption_Control1102152106Lbl: Label '" :"';
        EmptyStringCaption_Control1102152107Lbl: Label '" :"';
        Regional_PF______________________Name_of_the_PF_Trust_Commissioner_atCaptionLbl: Label 'Regional PF                      Name of the PF Trust Commissioner at';
        If_allotted_a_separate_one__CaptionLbl: Label '"     ( If allotted a separate one )"';
        V8__Date_of_joining_the_present_employerCaptionLbl: Label '8. Date of joining the present employer';
        Date_CaptionLbl: Label 'Date:';
        Signature__Left_Hand_Thumb_impression_of_the_MemberCaptionLbl: Label 'Signature, Left Hand Thumb impression of the Member';
        TO_BE_FILLED_IN_BY_THE_PRESENT_EMPLOYERCaptionLbl: Label 'TO BE FILLED IN BY THE PRESENT EMPLOYER';
        V9__Name_and_address_of_establishmentCaptionLbl: Label '9. Name and address of establishment';
        V10__EPF_Code___Account_No__allotted_to_the_memberCaptionLbl: Label '10. EPF Code & Account No. allotted to the member';
        V11__FPF_Account_Number_allotted_to_the_member_seperatelyCaptionLbl: Label '11. FPF Account Number allotted to the member seperately';
        If_anyCaptionLbl: Label '"    If any"';
}

