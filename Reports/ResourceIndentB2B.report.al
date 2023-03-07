report 33001277 "Resource Indent B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Resource Indent.rdlc';
    Caption = 'Resource Indent';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Recruitment Header"; "Recruitment Header B2B")
        {
            RequestFilterFields = "Recruitment Policy No.";
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(Companyinfo_Name; Companyinfo.Name)
            {
            }
            column(Recruitment_Header__Recruitment_Header__Position; "Recruitment Header".Position)
            {
            }
            column(Recruitment_Header__Recruitment_Header__Division; "Recruitment Header".Division)
            {
            }
            column(Recruitment_Header__Recruitment_Header___No__of_Resources_; "Recruitment Header"."No. of Resources")
            {
            }
            column(Recruitment_Header__Recruitment_Header__Qualification; "Recruitment Header".Qualification)
            {
            }
            column(Recruitment_Header__Recruitment_Header__Experience; "Recruitment Header".Experience)
            {
            }
            column(Recruitment_Header__Recruitment_Header__Expertise; "Recruitment Header".Expertise)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Managerial_Expertise_; "Recruitment Header"."Managerial Expertise")
            {
            }
            column(Recruitment_Header__Recruitment_Header___Skill_Set_; "Recruitment Header"."Skill Set")
            {
            }
            column(Recruitment_Header__Recruitment_Header___Job_Description2_; "Recruitment Header"."Job Description2")
            {
            }
            column(Recruitment_Header__Recruitment_Header___Age_Group_; "Recruitment Header"."Age Group")
            {
            }
            column(Recruitment_Header__Recruitment_Header___Salary_Range_; "Recruitment Header"."Salary Range")
            {
            }
            column(Recruitment_Header__Recruitment_Header___Date_of_Requirement_; "Recruitment Header"."Date of Requirement")
            {
            }
            column(Recruitment_Header__Recruitment_Header__Createddate; "Recruitment Header".Createddate)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Future_Growth_; "Recruitment Header"."Future Growth")
            {
            }
            column(Recruitment_Header__Recruitment_Header__Position_Control1102154044; "Recruitment Header".Position)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Nature_of_Position_; "Recruitment Header"."Nature of Position")
            {
            }
            column(Recruitment_Header__Recruitment_Header___Within_Budget_; "Recruitment Header"."Within Budget")
            {
            }
            column(USERID; USERID())
            {
            }
            column(Human_Resource_IndentCaption; Human_Resource_IndentCaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header__PositionCaption; Recruitment_Header__Recruitment_Header__PositionCaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header__DivisionCaption; Recruitment_Header__Recruitment_Header__DivisionCaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___No__of_Resources_Caption; Recruitment_Header__Recruitment_Header___No__of_Resources_CaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header__QualificationCaption; Recruitment_Header__Recruitment_Header__QualificationCaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header__ExperienceCaption; Recruitment_Header__Recruitment_Header__ExperienceCaptionLbl)
            {
            }
            column(Technical_Area_of_ExpertiseCaption; Technical_Area_of_ExpertiseCaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Managerial_Expertise_Caption; Recruitment_Header__Recruitment_Header___Managerial_Expertise_CaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Skill_Set_Caption; Recruitment_Header__Recruitment_Header___Skill_Set_CaptionLbl)
            {
            }
            column(Managerial_SupervisoryCaption; Managerial_SupervisoryCaptionLbl)
            {
            }
            column(High_Moderate_LowCaption; High_Moderate_LowCaptionLbl)
            {
            }
            column(High_Moderate_LowCaption_Control1102154022; High_Moderate_LowCaption_Control1102154022Lbl)
            {
            }
            column(High_Moderate_LowCaption_Control1102154023; High_Moderate_LowCaption_Control1102154023Lbl)
            {
            }
            column(High_Moderate_LowCaption_Control1102154024; High_Moderate_LowCaption_Control1102154024Lbl)
            {
            }
            column(High_Moderate_LowCaption_Control1102154025; High_Moderate_LowCaption_Control1102154025Lbl)
            {
            }
            column(High_Moderate_LowCaption_Control1102154026; High_Moderate_LowCaption_Control1102154026Lbl)
            {
            }
            column(CommunicationCaption; CommunicationCaptionLbl)
            {
            }
            column(LeadershipCaption; LeadershipCaptionLbl)
            {
            }
            column(ComputerCaption; ComputerCaptionLbl)
            {
            }
            column(Any_other_skillsCaption; Any_other_skillsCaptionLbl)
            {
            }
            column(V1_Caption; V1_CaptionLbl)
            {
            }
            column(V2_Caption; V2_CaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Job_Description2_Caption; Recruitment_Header__Recruitment_Header___Job_Description2_CaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Age_Group_Caption; Recruitment_Header__Recruitment_Header___Age_Group_CaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Salary_Range_Caption; Recruitment_Header__Recruitment_Header___Salary_Range_CaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Date_of_Requirement_Caption; Recruitment_Header__Recruitment_Header___Date_of_Requirement_CaptionLbl)
            {
            }
            column(Date_Sent_Caption; Date_Sent_CaptionLbl)
            {
            }
            column(To_be_given_by_Coord_Section_Caption; To_be_given_by_Coord_Section_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154070; EmptyStringCaption_Control1102154070Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154071; EmptyStringCaption_Control1102154071Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154072; EmptyStringCaption_Control1102154072Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154073; EmptyStringCaption_Control1102154073Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154074; EmptyStringCaption_Control1102154074Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154075; EmptyStringCaption_Control1102154075Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154076; EmptyStringCaption_Control1102154076Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154077; EmptyStringCaption_Control1102154077Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154078; EmptyStringCaption_Control1102154078Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154079; EmptyStringCaption_Control1102154079Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154081; EmptyStringCaption_Control1102154081Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154082; EmptyStringCaption_Control1102154082Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154083; EmptyStringCaption_Control1102154083Lbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Future_Growth_Caption; Recruitment_Header__Recruitment_Header___Future_Growth_CaptionLbl)
            {
            }
            column(Reason_for_RecruitmentCaption; Reason_for_RecruitmentCaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header__Position_Control1102154044Caption; Recruitment_Header__Recruitment_Header__Position_Control1102154044CaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Nature_of_Position_Caption; Recruitment_Header__Recruitment_Header___Nature_of_Position_CaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Header___Within_Budget_Caption; Recruitment_Header__Recruitment_Header___Within_Budget_CaptionLbl)
            {
            }
            column(Target_sourceCaption; Target_sourceCaptionLbl)
            {
            }
            column(USERIDCaption; USERIDCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(SignatureCaption; SignatureCaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Recommended_by_HODCaption; Recommended_by_HODCaptionLbl)
            {
            }
            column(NameCaption_Control1102154059; NameCaption_Control1102154059Lbl)
            {
            }
            column(DesignationCaption_Control1102154060; DesignationCaption_Control1102154060Lbl)
            {
            }
            column(Department_DivisionCaption; Department_DivisionCaptionLbl)
            {
            }
            column(Date_Caption_Control1102154062; Date_Caption_Control1102154062Lbl)
            {
            }
            column(SignatureCaption_Control1102154063; SignatureCaption_Control1102154063Lbl)
            {
            }
            column(Approved_byCaption; Approved_byCaptionLbl)
            {
            }
            column(DirectorCaption; DirectorCaptionLbl)
            {
            }
            column(SignatureCaption_Control1102154066; SignatureCaption_Control1102154066Lbl)
            {
            }
            column(Date_Caption_Control1102154067; Date_Caption_Control1102154067Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154086; EmptyStringCaption_Control1102154086Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154087; EmptyStringCaption_Control1102154087Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154088; EmptyStringCaption_Control1102154088Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154080; EmptyStringCaption_Control1102154080Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154084; EmptyStringCaption_Control1102154084Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154085; EmptyStringCaption_Control1102154085Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154091; EmptyStringCaption_Control1102154091Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154092; EmptyStringCaption_Control1102154092Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154094; EmptyStringCaption_Control1102154094Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154095; EmptyStringCaption_Control1102154095Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154096; EmptyStringCaption_Control1102154096Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154097; EmptyStringCaption_Control1102154097Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154098; EmptyStringCaption_Control1102154098Lbl)
            {
            }
            column(Recruitment_Header_Recruitment_Policy_No_; "Recruitment Policy No.")
            {
            }
        }
    }

    requestpage
    {
        Caption = 'Resource Indent';

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
        Companyinfo: Record "Company Information";
        Human_Resource_IndentCaptionLbl: Label 'Human Resource Indent';
        Recruitment_Header__Recruitment_Header__PositionCaptionLbl: Label 'Position';
        Recruitment_Header__Recruitment_Header__DivisionCaptionLbl: Label 'Project/Dept/Division';
        Recruitment_Header__Recruitment_Header___No__of_Resources_CaptionLbl: Label 'Number of Positions';
        Recruitment_Header__Recruitment_Header__QualificationCaptionLbl: Label 'Qualification/s';
        Recruitment_Header__Recruitment_Header__ExperienceCaptionLbl: Label 'Experience:';
        Technical_Area_of_ExpertiseCaptionLbl: Label 'Technical/Area of Expertise';
        Recruitment_Header__Recruitment_Header___Managerial_Expertise_CaptionLbl: Label 'Managerial Expertise';
        Recruitment_Header__Recruitment_Header___Skill_Set_CaptionLbl: Label 'Skill Sets';
        Managerial_SupervisoryCaptionLbl: Label 'Managerial/Supervisory';
        High_Moderate_LowCaptionLbl: Label 'High/Moderate/Low';
        High_Moderate_LowCaption_Control1102154022Lbl: Label 'High/Moderate/Low';
        High_Moderate_LowCaption_Control1102154023Lbl: Label 'High/Moderate/Low';
        High_Moderate_LowCaption_Control1102154024Lbl: Label 'High/Moderate/Low';
        High_Moderate_LowCaption_Control1102154025Lbl: Label 'High/Moderate/Low';
        High_Moderate_LowCaption_Control1102154026Lbl: Label 'High/Moderate/Low';
        CommunicationCaptionLbl: Label 'Communication';
        LeadershipCaptionLbl: Label 'Leadership';
        ComputerCaptionLbl: Label 'Computer';
        Any_other_skillsCaptionLbl: Label 'Any other skills';
        V1_CaptionLbl: Label '1.';
        V2_CaptionLbl: Label '2.';
        Recruitment_Header__Recruitment_Header___Job_Description2_CaptionLbl: Label 'Brief Job Description';
        Recruitment_Header__Recruitment_Header___Age_Group_CaptionLbl: Label 'Age ( Limitation, if any)';
        Recruitment_Header__Recruitment_Header___Salary_Range_CaptionLbl: Label 'Salary Range';
        Recruitment_Header__Recruitment_Header___Date_of_Requirement_CaptionLbl: Label 'Date Required by:';
        Date_Sent_CaptionLbl: Label 'Date Sent:';
        To_be_given_by_Coord_Section_CaptionLbl: Label '( To be given by Coord Section)';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102154070Lbl: Label ':';
        EmptyStringCaption_Control1102154071Lbl: Label ':';
        EmptyStringCaption_Control1102154072Lbl: Label ':';
        EmptyStringCaption_Control1102154073Lbl: Label ':';
        EmptyStringCaption_Control1102154074Lbl: Label ':';
        EmptyStringCaption_Control1102154075Lbl: Label ':';
        EmptyStringCaption_Control1102154076Lbl: Label ':';
        EmptyStringCaption_Control1102154077Lbl: Label ':';
        EmptyStringCaption_Control1102154078Lbl: Label ':';
        EmptyStringCaption_Control1102154079Lbl: Label ':';
        EmptyStringCaption_Control1102154081Lbl: Label ':';
        EmptyStringCaption_Control1102154082Lbl: Label ':';
        EmptyStringCaption_Control1102154083Lbl: Label ':';
        Recruitment_Header__Recruitment_Header___Future_Growth_CaptionLbl: Label 'Career Path/ Scope for future growth';
        Reason_for_RecruitmentCaptionLbl: Label 'Reason for Recruitment';
        Recruitment_Header__Recruitment_Header__Position_Control1102154044CaptionLbl: Label '1.Position';
        Recruitment_Header__Recruitment_Header___Nature_of_Position_CaptionLbl: Label '2.Nature of the position';
        Recruitment_Header__Recruitment_Header___Within_Budget_CaptionLbl: Label '3. Is the position within the budget headcount ?';
        Target_sourceCaptionLbl: Label 'Target source';
        USERIDCaptionLbl: Label 'Submitted by';
        NameCaptionLbl: Label 'Name';
        DesignationCaptionLbl: Label 'Designation';
        DepartmentCaptionLbl: Label 'Department';
        SignatureCaptionLbl: Label 'Signature';
        Date_CaptionLbl: Label 'Date:';
        Recommended_by_HODCaptionLbl: Label 'Recommended by HOD';
        NameCaption_Control1102154059Lbl: Label 'Name';
        DesignationCaption_Control1102154060Lbl: Label 'Designation';
        Department_DivisionCaptionLbl: Label 'Department/Division';
        Date_Caption_Control1102154062Lbl: Label 'Date:';
        SignatureCaption_Control1102154063Lbl: Label 'Signature';
        Approved_byCaptionLbl: Label 'Approved by';
        DirectorCaptionLbl: Label 'Director';
        SignatureCaption_Control1102154066Lbl: Label 'Signature';
        Date_Caption_Control1102154067Lbl: Label 'Date:';
        EmptyStringCaption_Control1102154086Lbl: Label ':';
        EmptyStringCaption_Control1102154087Lbl: Label ':';
        EmptyStringCaption_Control1102154088Lbl: Label ':';
        EmptyStringCaption_Control1102154080Lbl: Label ':';
        EmptyStringCaption_Control1102154084Lbl: Label ':';
        EmptyStringCaption_Control1102154085Lbl: Label ':';
        EmptyStringCaption_Control1102154091Lbl: Label ':';
        EmptyStringCaption_Control1102154092Lbl: Label ':';
        EmptyStringCaption_Control1102154094Lbl: Label ':';
        EmptyStringCaption_Control1102154095Lbl: Label ':';
        EmptyStringCaption_Control1102154096Lbl: Label ':';
        EmptyStringCaption_Control1102154097Lbl: Label ':';
        EmptyStringCaption_Control1102154098Lbl: Label ':';
}

