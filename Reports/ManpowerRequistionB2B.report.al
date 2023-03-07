report 33001300 "Manpower Requistion B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Manpower Requistion.rdl';
    Caption = 'Manpower Requistion';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Recruitment Header"; "Recruitment Header B2B")
        {
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Recruitment_Header__Required_Position_; "Required Position")
            {
            }
            column(Recruitment_Header__No__of_Resources_; "No. of Resources")
            {
            }
            column(Recruitment_Header__Required_Dept__; "Required Dept.")
            {
            }
            column(Recruitment_Header__Age_Group_; "Age Group")
            {
            }
            column(Recruitment_Header__Salary_Range_; "Salary Range")
            {
            }
            column(Recruitment_Header__Required_Position__Control1102152103; "Required Position")
            {
            }
            column(EmpRec__First_Name_______EmpRec__Middle_Name_______EmpRec__Last_Name_; EmpRec."First Name" + '  ' + EmpRec."Middle Name" + '  ' + EmpRec."Last Name")
            {
            }
            column(Recruitment_Header__Date_of_Requirement_; "Date of Requirement")
            {
            }
            column(Recruitment_Header__Source_of_Getting_Manpower_; "Source of Getting Manpower")
            {
            }
            column(Recruitment_Header__Training_Probation_Period_; "Training/Probation Period")
            {
            }
            column(Recruitment_Header__Nature_of_Position_; "Nature of Position")
            {
            }
            column(QualificationVar; QualificationVar)
            {
            }
            column(Recruitment_Header_Experience; Experience)
            {
            }
            column(Recruitment_Header__Physaical_Location_; "Physaical Location")
            {
            }
            column(EmpRec2__First_Name_______EmpRec2__Middle_Name_______EmpRec2__Last_Name_; EmpRec2."First Name" + '  ' + EmpRec2."Middle Name" + '  ' + EmpRec2."Last Name")
            {
            }
            column(Recruitment_Header__Recruitment_Header___Expected_Target_; "Recruitment Header"."Expected Target")
            {
            }
            column(Recruitment_Header__Recruitment_Header__Reason; "Recruitment Header".Reason)
            {
            }
            column(Recruitment_Header__Days_Limit_; "Days Limit")
            {
            }
            column(Recruitment_Header__Recruitment_Policy_No__; "Recruitment Policy No.")
            {
            }
            column(MANPOWER_REQUISTIONCaption; MANPOWER_REQUISTIONCaptionLbl)
            {
            }
            column(S_NOCaption; S_NOCaptionLbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(INFORMATIONCaption; INFORMATIONCaptionLbl)
            {
            }
            column(For_the_Post_ofCaption; For_the_Post_ofCaptionLbl)
            {
            }
            column(No_of_VacanciesCaption; No_of_VacanciesCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(For_the_RegionCaption; For_the_RegionCaptionLbl)
            {
            }
            column(QualificationsCaption; QualificationsCaptionLbl)
            {
            }
            column(ExperienceCaption; ExperienceCaptionLbl)
            {
            }
            column(Age_groupCaption; Age_groupCaptionLbl)
            {
            }
            column(Gross_Salary_RangeCaption; Gross_Salary_RangeCaptionLbl)
            {
            }
            column(Suggested_GradeCaption; Suggested_GradeCaptionLbl)
            {
            }
            column(Temporary_Permanent_VacanyCaption; Temporary_Permanent_VacanyCaptionLbl)
            {
            }
            column(Will_be_reporting_toCaption; Will_be_reporting_toCaptionLbl)
            {
            }
            column(Reason_for_filling___up_this_vacancyCaption; Reason_for_filling___up_this_vacancyCaptionLbl)
            {
            }
            column(Time_Limit_for_appointmentCaption; Time_Limit_for_appointmentCaptionLbl)
            {
            }
            column(Source_of_Getting_ManpowerCaption; Source_of_Getting_ManpowerCaptionLbl)
            {
            }
            column(Training_Probation_periodCaption; Training_Probation_periodCaptionLbl)
            {
            }
            column(Responsible_person_for_the_development_of_this_new_appointeeCaption; Responsible_person_for_the_development_of_this_new_appointeeCaptionLbl)
            {
            }
            column(Expected_TragetCaption; Expected_TragetCaptionLbl)
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
            column(V9Caption; V9CaptionLbl)
            {
            }
            column(V10Caption; V10CaptionLbl)
            {
            }
            column(V11Caption; V11CaptionLbl)
            {
            }
            column(V12Caption; V12CaptionLbl)
            {
            }
            column(V13Caption; V13CaptionLbl)
            {
            }
            column(V14Caption; V14CaptionLbl)
            {
            }
            column(V15Caption; V15CaptionLbl)
            {
            }
            column(V16Caption; V16CaptionLbl)
            {
            }
            column(V17Caption; V17CaptionLbl)
            {
            }
            column(orCaption; orCaptionLbl)
            {
            }
            column(MPR_No_Caption; MPR_No_CaptionLbl)
            {
            }
            column(Signature_of_HODCaption; Signature_of_HODCaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Managing_DirectorCaption; Managing_DirectorCaptionLbl)
            {
            }
            column(Date_Caption_Control1102152016; Date_Caption_Control1102152016Lbl)
            {
            }
            column(SalRange; SalRange)
            { }
            trigger OnAfterGetRecord();
            begin
                Clear(QualificationVar);
                Sno += 1;
                CredentialRec.RESET();
                CredentialRec.SETRANGE("Document No.", "Recruitment Policy No.");
                CredentialRec.SETRANGE(CredentialRec."Skill Type", CredentialRec."Skill Type"::QUALIFICATION);
                if CredentialRec.FINDFIRST() then
                    if CredentialRec.COUNT() = 1 then
                        repeat
                            QualificationVar := CredentialRec."Credential Code";
                        until CredentialRec.NEXT() = 0
                    else
                        if CredentialRec.COUNT() > 1 then
                            repeat
                                if QualificationVar = '' then
                                    QualificationVar := CredentialRec."Credential Code"
                                else
                                    QualificationVar := CopyStr(QualificationVar + ',' + CredentialRec."Credential Code", 1, 100);
                            until CredentialRec.NEXT() = 0;

                EmpRec.RESET();
                EmpRec.SETRANGE("No.", "Reporting To");
                if EmpRec.FINDFIRST() then;

                EmpRec2.RESET();
                EmpRec2.SETRANGE("No.", "Thrid Party");
                if EmpRec2.FINDFIRST() then;

                JobDeshdr.Reset();
                JobDeshdr.SetRange("No.", "Job Description No.");
                if JobDeshdr.FindFirst() then begin
                    SalRange := JobDeshdr."Salary Range";
                end;




            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(Picture);

            end;
        }
    }

    requestpage
    {
        Caption = 'Manpower Requistion';

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

        JobDeshdr: Record "Job Description Header(RO) B2B";
        SalRange: Option " ","3000-5000","5000-8000","8000-10000","10000-15000","15000-25000","25000-30000","30000-50000";
        CredentialRec: Record "Credentials B2B";
        CompanyInfo: Record "Company Information";
        EmpRec2: Record "Employee B2B";
        EmpRec: Record "Employee B2B";
        Sno: Integer;
        QualificationVar: Code[100];
        MANPOWER_REQUISTIONCaptionLbl: Label 'MANPOWER REQUISTION';
        S_NOCaptionLbl: Label 'S.NO';
        DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
        INFORMATIONCaptionLbl: Label 'INFORMATION';
        For_the_Post_ofCaptionLbl: Label 'For the Post of';
        No_of_VacanciesCaptionLbl: Label 'No of Vacancies';
        DepartmentCaptionLbl: Label 'Department';
        For_the_RegionCaptionLbl: Label 'For the Region';
        QualificationsCaptionLbl: Label 'Qualifications';
        ExperienceCaptionLbl: Label 'Experience';
        Age_groupCaptionLbl: Label 'Age group';
        Gross_Salary_RangeCaptionLbl: Label 'Gross Salary Range';
        Suggested_GradeCaptionLbl: Label 'Suggested Grade';
        Temporary_Permanent_VacanyCaptionLbl: Label 'Temporary/Permanent Vacany';
        Will_be_reporting_toCaptionLbl: Label 'Will be reporting to';
        Reason_for_filling___up_this_vacancyCaptionLbl: Label 'Reason for filling - up this vacancy';
        Time_Limit_for_appointmentCaptionLbl: Label 'Time Limit for appointment';
        Source_of_Getting_ManpowerCaptionLbl: Label 'Source of Getting Manpower';
        Training_Probation_periodCaptionLbl: Label 'Training/Probation period';
        Responsible_person_for_the_development_of_this_new_appointeeCaptionLbl: Label 'Responsible person for the development of this new appointee';
        Expected_TragetCaptionLbl: Label 'Expected Traget';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        V4CaptionLbl: Label '4';
        V5CaptionLbl: Label '5';
        V6CaptionLbl: Label '6';
        V7CaptionLbl: Label '7';
        V8CaptionLbl: Label '8';
        V9CaptionLbl: Label '9';
        V10CaptionLbl: Label '10';
        V11CaptionLbl: Label '11';
        V12CaptionLbl: Label '12';
        V13CaptionLbl: Label '13';
        V14CaptionLbl: Label '14';
        V15CaptionLbl: Label '15';
        V16CaptionLbl: Label '16';
        V17CaptionLbl: Label '17';
        orCaptionLbl: Label 'or';
        MPR_No_CaptionLbl: Label 'MPR No.';
        Signature_of_HODCaptionLbl: Label 'Signature of HOD';
        Date_CaptionLbl: Label 'Date:';
        Managing_DirectorCaptionLbl: Label 'Managing Director';
        Date_Caption_Control1102152016Lbl: Label 'Date:';
}

