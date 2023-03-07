report 33001243 "Nomination & Decl. from B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Nomination & Declaration from.rdlc';
    Caption = 'Nomination & Declaration from';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            RequestFilterFields = "No.", "First Name";
            column(Name; Name)
            {
            }
            column(Employee_B2B__Father_Husband_; "Father/Husband")
            {
            }
            column(Employee_B2B_Employee_B2B__Birth_Date_;
            "Employee B2B"."Birth Date")
            {
            }
            column(Employee_B2B_Gender; Gender)
            {
            }
            column(Marital_Status; "Employee B2B"."Martial status")
            {
            }
            column(Employee_B2B_Employee_B2BEmployee_B2B__PF_No_; "Employee B2B"."PF No")
            {
            }
            column(Employee_B2B_Address; Address)
            {
            }
            column(Employee_B2B__Address_2_; "Address 2")
            {
            }
            column(Employee_B2B_City; City)
            {
            }
            column(Employee_B2B__Post_Code_; "Post Code")
            {
            }
            column(Employee_B2B_Country; Country)
            {
            }
            column(Employee_B2B__Phone_No__; "Phone No.")
            {
            }
            column(Employee_B2B__Mobile_Phone_No__; "Mobile Phone No.")
            {
            }
            column(Employee_B2B__Employment_Date_; "Employment Date")
            {
            }
            column(Employee_B2B__Employment_Date__Control1102152029; "Employment Date")
            {
            }
            column(Employee_B2B__Employment_Date__Control1102152031; "Employment Date")
            {
            }
            column(Declaration_and_nomination_Form_under_the_Employees__Provident_fund___Employees__pension_SchemeCaption; Declaration_and_nomination_Form_under_the_Employees__Provident_fund___Employees__pension_SchemeCaptionLbl)
            {
            }
            column(V5003_EPF_RO_C_T_D_DUN_04Caption; V5003_EPF_RO_C_T_D_DUN_04CaptionLbl)
            {
            }
            column(Form_Without_Payment_Caption; Form_Without_Payment_CaptionLbl)
            {
            }
            column(NOMINATION_AND_DECLARATION_OF_FORMCaption; NOMINATION_AND_DECLARATION_OF_FORMCaptionLbl)
            {
            }
            column(FOR_UNEXEMPTED_EXEMPTED_ESTABLISHMENTSCaption; FOR_UNEXEMPTED_EXEMPTED_ESTABLISHMENTSCaptionLbl)
            {
            }
            column(paragraph_33___61_1__of_the_Employees__provident_Fund_Scheme_1952___Paragraph_18_of_the_Employees__Caption; paragraph_33___61_1__of_the_Employees__provident_Fund_Scheme_1952___Paragraph_18_of_the_Employees__CaptionLbl)
            {
            }
            column(pension_Scheme__1995Caption; pension_Scheme__1995CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Employee_B2B__Father_Husband_Caption; FIELDCAPTION("Father/Husband"))
            {
            }
            column(Employee_B2B_Employee_B2B__Birth_Date_Caption;
            Employee_B2B_Employee_B2B__Birth_Date_CaptionLbl)
            {
            }
            column(Employee_B2B_GenderCaption; Employee_B2B_GenderCaptionLbl)
            {
            }
            column(Marital_StatusCaption; Marital_StatusCaptionLbl)
            {
            }
            column(Employee_B2B_Employee_B2B__PF_No_Caption; Employee_B2B_Employee_B2B__PF_No_CaptionLbl)
            {
            }
            column(Address_Permanent_Temp_Caption; Address_Permanent_Temp_CaptionLbl)
            {
            }
            column(Date_of_Joining_EPF_Scheme_1952_Caption; Date_of_Joining_EPF_Scheme_1952_CaptionLbl)
            {
            }
            column(Date_of_Joining_EPF_Scheme_1971_Caption; Date_of_Joining_EPF_Scheme_1971_CaptionLbl)
            {
            }
            column(Date_of_Joining_EPF_Scheme_1995_Caption; Date_of_Joining_EPF_Scheme_1995_CaptionLbl)
            {
            }
            column(Form__2_RevisedCaption; Form__2_RevisedCaptionLbl)
            {
            }
            column(please_Affix_recent_passport_size_photograph_of_the_member_Caption; please_Affix_recent_passport_size_photograph_of_the_member_CaptionLbl)
            {
            }
            column(PART___A___EPF_Caption; PART___A___EPF_CaptionLbl)
            {
            }
            column(DataItem1102152070; I_hereby_nominate_the_personLbl)
            {
            }
            column(Name_of_the_nominee__nomineesCaption; Name_of_the_nominee__nomineesCaptionLbl)
            {
            }
            column(AddressCaption; AddressCaptionLbl)
            {
            }
            column(Nominees__relationship_with_the_memberCaption; Nominees__relationship_with_the_memberCaptionLbl)
            {
            }
            column(Tot__amt__or_share_of_accumulations_in_Provident_Fund_to_be_paid_to_each_nomineeCaption; Tot__amt__or_share_of_accumulations_in_Provident_Fund_to_be_paid_to_each_nomineeCaptionLbl)
            {
            }
            column(DataItem1102152075; If_the_Nominee_is_a_minorLbl)
            {
            }
            column(Date_of_BirthCaption; Date_of_BirthCaptionLbl)
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
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(V6Caption; V6CaptionLbl)
            {
            }
            column(DataItem1102152089; V1____Certified_that_I_haveLbl)
            {
            }
            column(V2____Certified_that_my_father_mother_is_are_dependent_upon_me_Caption; V2____Certified_that_my_father_mother_is_are_dependent_upon_me_CaptionLbl)
            {
            }
            column(Strike_out_which_ever_is_not_applicableCaption; Strike_out_which_ever_is_not_applicableCaptionLbl)
            {
            }
            column(Signature_or_thumb_impression_of_the_subscriberCaption; Signature_or_thumb_impression_of_the_subscriberCaptionLbl)
            {
            }
            column(V1Caption_Control1102152103; V1Caption_Control1102152103Lbl)
            {
            }
            column(V4Caption_Control1102152104; V4Caption_Control1102152104Lbl)
            {
            }
            column(V2Caption_Control1102152105; V2Caption_Control1102152105Lbl)
            {
            }
            column(V3Caption_Control1102152106; V3Caption_Control1102152106Lbl)
            {
            }
            column(V5Caption_Control1102152107; V5Caption_Control1102152107Lbl)
            {
            }
            column(Date_of_BirthCaption_Control1102152109; Date_of_BirthCaption_Control1102152109Lbl)
            {
            }
            column(Name___Address_of_the__family_membersCaption; Name___Address_of_the__family_membersCaptionLbl)
            {
            }
            column(Relationship_with_the_menberCaption; Relationship_with_the_menberCaptionLbl)
            {
            }
            column(S__No_Caption; S__No_CaptionLbl)
            {
            }
            column(DataItem1102152114; I_hereby_furnish_belowLbl)
            {
            }
            column(PART___A___EPF_Caption_Control1102152115; PART___A___EPF_Caption_Control1102152115Lbl)
            {
            }
            column(PART_18_Caption; PART_18_CaptionLbl)
            {
            }
            column(AddressCaption_Control1102152117; AddressCaption_Control1102152117Lbl)
            {
            }
            column(DataItem1102152118; Certified_that_I_haveLbl)
            {
            }
            column(DataItem1102152119; I_hereby_nominate_the_followingLbl)
            {
            }
            column(Name___Address_of_the_nomineeCaption; Name___Address_of_the_nomineeCaptionLbl)
            {
            }
            column(V1Caption_Control1102152123; V1Caption_Control1102152123Lbl)
            {
            }
            column(V2Caption_Control1102152126; V2Caption_Control1102152126Lbl)
            {
            }
            column(Date_of_BirthCaption_Control1102152128; Date_of_BirthCaption_Control1102152128Lbl)
            {
            }
            column(V3Caption_Control1102152130; V3Caption_Control1102152130Lbl)
            {
            }
            column(Relationship_with_the_menberCaption_Control1102152131; Relationship_with_the_menberCaption_Control1102152131Lbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Signature_or_thumb_impression_of_the_subscriberCaption_Control1102152035; Signature_or_thumb_impression_of_the_subscriberCaption_Control1102152035Lbl)
            {
            }
            column(strike_out_whichever_is_not_applicableCaption; strike_out_whichever_is_not_applicableCaptionLbl)
            {
            }
            column(CERTIFICATE_BY_EMPLOYERCaption; CERTIFICATE_BY_EMPLOYERCaptionLbl)
            {
            }
            column(DataItem1102152039; Certificate_that_the_above_declaration_andLbl)
            {
            }
            column(EmptyStringCaption_Control1102152041; EmptyStringCaption_Control1102152041Lbl)
            {
            }
            column(DateCaption_Control1102152042; DateCaption_Control1102152042Lbl)
            {
            }
            column(placeCaption; placeCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152044; EmptyStringCaption_Control1102152044Lbl)
            {
            }
            column(Signature_Of_the_Employer_or_other_Authorised_officers_of_the_establishmentCaption; Signature_Of_the_Employer_or_other_Authorised_officers_of_the_establishmentCaptionLbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152048; EmptyStringCaption_Control1102152048Lbl)
            {
            }
            column(Name___Address_of_the_Factory_Establishment_of_Rubber_stamp_there_ofCaption; Name___Address_of_the_Factory_Establishment_of_Rubber_stamp_there_ofCaptionLbl)
            {
            }
            column(The_entries_have_been_read_over_to_him_her_by_me_and_got_confirmed_by_him_her_Caption; The_entries_have_been_read_over_to_him_her_by_me_and_got_confirmed_by_him_her_CaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                Name := COPYSTR("Employee B2B"."First Name", 1, MAXSTRLEN("Employee B2B"."Middle Name"));
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Nomination & Declaration from';

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
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Name: Code[60];

        Declaration_and_nomination_Form_under_the_Employees__Provident_fund___Employees__pension_SchemeCaptionLbl: Label 'Declaration and nomination Form under the Employees'' Provident fund & Employees'' pension Scheme';
        V5003_EPF_RO_C_T_D_DUN_04CaptionLbl: Label '5003/EPF/RO/C.T/D.DUN/04';
        Form_Without_Payment_CaptionLbl: Label '"""Form Without Payment"""';
        NOMINATION_AND_DECLARATION_OF_FORMCaptionLbl: Label 'NOMINATION AND DECLARATION OF FORM';
        FOR_UNEXEMPTED_EXEMPTED_ESTABLISHMENTSCaptionLbl: Label 'FOR UNEXEMPTED/EXEMPTED ESTABLISHMENTS';
        paragraph_33___61_1__of_the_Employees__provident_Fund_Scheme_1952___Paragraph_18_of_the_Employees__CaptionLbl: Label '(paragraph 33 & 61(1) of the Employees'' provident Fund Scheme,1952 & Paragraph 18 of the Employees'')';
        pension_Scheme__1995CaptionLbl: Label 'pension Scheme, 1995';
        NameCaptionLbl: Label 'Name(in block letters) :';
        Employee_B2B_Employee_B2B__Birth_Date_CaptionLbl: Label 'Date of Birth';
        Employee_B2B_GenderCaptionLbl: Label 'sex';
        Marital_StatusCaptionLbl: Label 'Marital Status';
        Employee_B2B_Employee_B2B__PF_No_CaptionLbl: Label 'Account No.';
        Address_Permanent_Temp_CaptionLbl: Label 'Address Permanent/Temp.';
        Date_of_Joining_EPF_Scheme_1952_CaptionLbl: Label 'Date of Joining EPF Scheme 1952:';
        Date_of_Joining_EPF_Scheme_1971_CaptionLbl: Label 'Date of Joining EPF Scheme 1971:';
        Date_of_Joining_EPF_Scheme_1995_CaptionLbl: Label 'Date of Joining EPF Scheme 1995:';
        Form__2_RevisedCaptionLbl: Label 'Form- 2 Revised';
        please_Affix_recent_passport_size_photograph_of_the_member_CaptionLbl: Label '"please Affix recent passport size photograph of the member "';
        PART___A___EPF_CaptionLbl: Label 'PART - A  (EPF)';
        I_hereby_nominate_the_personLbl: Label 'I hereby nominate the person(s)/concel the nominationmade by me previsouly and nominate the person(s), mentioned below to recieve the amount standing to my crredit in the employee''s Provident Fund, in the event of my death.';
        Name_of_the_nominee__nomineesCaptionLbl: Label 'Name of the nominee/ nominees';
        AddressCaptionLbl: Label 'Address';
        Nominees__relationship_with_the_memberCaptionLbl: Label 'Nominees'' relationship with the member';
        Tot__amt__or_share_of_accumulations_in_Provident_Fund_to_be_paid_to_each_nomineeCaptionLbl: Label 'Tot. amt. or share of accumulations in Provident Fund to be paid to each nominee';
        If_the_Nominee_is_a_minorLbl: Label 'If the Nominee is a minor, name & relationship & address of the guardian who may receive the amount during the minority of nominee';
        Date_of_BirthCaptionLbl: Label 'Date of Birth';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        V5CaptionLbl: Label '5';
        V4CaptionLbl: Label '4';
        V6CaptionLbl: Label '6';
        V1____Certified_that_I_haveLbl: Label '1.  *Certified that I have no family as defined in para(2)(g) of the Employees'' Provident Fund Scheme,1952 and sholud I acquire a family hereafter the above nomination should be deemed as cancelled.';
        V2____Certified_that_my_father_mother_is_are_dependent_upon_me_CaptionLbl: Label '2.  *Certified that my father/mother is/are dependent upon me.';
        Strike_out_which_ever_is_not_applicableCaptionLbl: Label '*Strike out which ever is not applicable';
        Signature_or_thumb_impression_of_the_subscriberCaptionLbl: Label 'Signature or thumb impression of the subscriber';
        V1Caption_Control1102152103Lbl: Label '1';
        V4Caption_Control1102152104Lbl: Label '4';
        V2Caption_Control1102152105Lbl: Label '2';
        V3Caption_Control1102152106Lbl: Label '3';
        V5Caption_Control1102152107Lbl: Label '5';
        Date_of_BirthCaption_Control1102152109Lbl: Label 'Date of Birth';
        Name___Address_of_the__family_membersCaptionLbl: Label 'Name & Address of the  family members';
        Relationship_with_the_menberCaptionLbl: Label 'Relationship with the menber';
        S__No_CaptionLbl: Label 'S. No.';
        I_hereby_furnish_belowLbl: Label 'I hereby furnish below particulars of the members of my family who wuold be eligible to receive widow/childern pension in the event of my death .';
        PART___A___EPF_Caption_Control1102152115Lbl: Label 'PART - A  (EPF)';
        PART_18_CaptionLbl: Label '(PART 18)';
        AddressCaption_Control1102152117Lbl: Label '" Address"';
        Certified_that_I_haveLbl: Label 'Certified that I have no family as defined in para 2 (vii)of Employees'' Pension Scheme 1995 and should acquire a family there after I shall furnish particulars thereon in the above form.';
        I_hereby_nominate_the_followingLbl: Label 'I hereby nominate the following person for receiving the monthly pension admissible under para 16(2) (a)(i) &(ii) in the event of my death without leaving any eligible family member for receiving pension';
        Name___Address_of_the_nomineeCaptionLbl: Label 'Name & Address of the nominee';
        V1Caption_Control1102152123Lbl: Label '1';
        V2Caption_Control1102152126Lbl: Label '2';
        Date_of_BirthCaption_Control1102152128Lbl: Label 'Date of Birth';
        V3Caption_Control1102152130Lbl: Label '3';
        Relationship_with_the_menberCaption_Control1102152131Lbl: Label 'Relationship with the menber';
        DateCaptionLbl: Label 'Date';
        EmptyStringCaptionLbl: Label '................................';
        Signature_or_thumb_impression_of_the_subscriberCaption_Control1102152035Lbl: Label 'Signature or thumb impression of the subscriber';
        strike_out_whichever_is_not_applicableCaptionLbl: Label '**strike out whichever is not applicable';
        CERTIFICATE_BY_EMPLOYERCaptionLbl: Label 'CERTIFICATE BY EMPLOYER';
        Certificate_that_the_above_declaration_andLbl: Label 'Certificate that the above declaration and nomination has been signed/thumb impressed before me by Shri/Smt/Km............................................................................employed in my establishment after he/she has read the entries .';
        EmptyStringCaption_Control1102152041Lbl: Label '................................';
        DateCaption_Control1102152042Lbl: Label 'Date';
        placeCaptionLbl: Label 'place';
        EmptyStringCaption_Control1102152044Lbl: Label '................................';
        Signature_Of_the_Employer_or_other_Authorised_officers_of_the_establishmentCaptionLbl: Label 'Signature Of the Employer or other Authorised officers of the establishment';
        DesignationCaptionLbl: Label 'Designation';
        EmptyStringCaption_Control1102152048Lbl: Label '........................................................';
        Name___Address_of_the_Factory_Establishment_of_Rubber_stamp_there_ofCaptionLbl: Label 'Name & Address of the Factory/Establishment of Rubber stamp there of';
        The_entries_have_been_read_over_to_him_her_by_me_and_got_confirmed_by_him_her_CaptionLbl: Label 'The entries have been read over to him/her by me and got confirmed by him/her.';
}

