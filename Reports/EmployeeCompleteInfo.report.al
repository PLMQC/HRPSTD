report 33001287 "Employee Complete Info B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Employee Complete Information.rdlc';
    Caption = 'Employee Complete Information';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            RequestFilterFields = "No.";
            column(Employee_B2B_FirstName; "Employee B2B"."First Name")
            {
            }
            column(Employee_B2B_MiddleName; "Employee B2B"."Middle Name")
            {
            }
            column(Employee_B2B_LastName; "Employee B2B"."Last Name")
            {
            }
            column(Employee_B2B_No; "Employee B2B"."No.")
            {
            }
            column(Employee_B2B_EmploymentDate; "Employee B2B"."Employment Date")
            {
            }
            column(Employee_B2B_Designation; "Employee B2B".Designation)
            {
            }
            column(Employee_B2B_DepartmentCode; "Employee B2B"."Department Code")
            {
            }
            column(Employee_B2B_FatherHusband; "Employee B2B"."Father/Husband")
            {
            }
            column(Employee_B2B_Address; "Employee B2B".Address)
            {
            }
            column(Employee_B2B_Address2; "Employee B2B"."Address 2")
            {
            }
            column(Employee_B2B_PresentAddress; "Employee B2B"."Present  Address")
            {
            }
            column(Employee_B2B_PresentAddress2; "Employee B2B"."Present Address 2")
            {
            }
            column(Employee_B2B_MobilePhoneNo; "Employee B2B"."Mobile Phone No.")
            {
            }
            column(Employee_B2B_EMail; "Employee B2B"."E-Mail")
            {
            }
            column(Employee_B2B_PhoneNo; "Employee B2B"."Phone No.")
            {
            }
            column(Employee_B2B_Weight; "Employee B2B".Weight)
            {
            }
            column(Employee_B2B_Hieght; "Employee B2B".Hieght)
            {
            }
            column(Employee_B2B_Gender; "Employee B2B".Gender)
            {
            }
            column(AgeVar; AgeVar)
            {
            }
            column(Employee_B2B_BirthDate; "Employee B2B"."Birth Date")
            {
            }
            column(Employee_B2B_PlaceofBirth; "Employee B2B"."Place of Birth")
            {
            }
            column(Employee_B2B_BloodGroup; "Employee B2B"."Blood Group")
            {
            }
            column(Employee_B2B_Nationality; "Employee B2B".Nationality)
            {
            }
            column(Employee_B2B_Martialstatus; "Employee B2B"."Martial status")
            {
            }
            column(Employee_B2B_PANNo; "Employee B2B"."PAN No")
            {
            }
            column(Employee_B2B_PFNo; "Employee B2B"."PF No")
            {
            }
            column(Employee_B2B_ESINo; "Employee B2B"."ESI No")
            {
            }
            column(EmpHobbies_HobbyDescription; EmpHobbies."Hobby Description")
            {
            }
            column(Employee_B2B_Picture; "Employee B2B".Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(EmployeeInfoLbl; EmployeeInfoLbl)
            {
            }
            column(EmpName; EmpNameLbl)
            {
            }
            column(EmpNumb; EmpNumbLbl)
            {
            }
            column(DateofJoin; DateofJoinLbl)
            {
            }
            column(Designation; DesignationLbl)
            {
            }
            column(Department; DepartmentLbl)
            {
            }
            column(FatherName; FatherNameLbl)
            {
            }
            column(PermenantAddrs; PermenantAddrsLbl)
            {
            }
            column(PresentAddr; PresentAddrLbl)
            {
            }
            column(ContactDet; ContactDetLbl)
            {
            }
            column(Mobile; MobileLbl)
            {
            }
            column(Email; EmailLbl)
            {
            }
            column(ResPhoneNo; ResPhoneNoLbl)
            {
            }
            column(Weight; WeightLbl)
            {
            }
            column(Kg; KgLbl)
            {
            }
            column(Height; HeightLbl)
            {
            }
            column(cms; cmsLbl)
            {
            }
            column(Sex; SexLbl)
            {
            }
            column(Age; AgeLbl)
            {
            }
            column(DateofBirth; DateofBirthLbl)
            {
            }
            column(PlaceofBirth; PlaceofBirthLbl)
            {
            }
            column(BloodGroup; BloodGroupLbl)
            {
            }
            column(Nationality; NationalityLbl)
            {
            }
            column(Marital; MaritalLbl)
            {
            }
            column(PANNo; PANNoLbl)
            {
            }
            column(PFNo; PFNoLbl)
            {
            }
            column(ESICNo; ESICNoLbl)
            {
            }
            column(Hobbies; HobbiesLbl)
            {
            }
            column(Colon; ColonLbl)
            {
            }
            column(BankInfo; BankInfoLbl)
            {
            }
            column(NameofBank; NameofBankLbl)
            {
            }
            column(AccNum; AccNumLbl)
            {
            }
            column(IFSCode; IFSCodeLbl)
            {
            }
            column(Branch; BranchLbl)
            {
            }
            column(Employee_B2B_BankName; "Employee B2B"."Bank Name")
            {
            }
            column(Employee_B2B_AccountNo; "Employee B2B"."Account No")
            {
            }
            column(Employee_B2B_BankIFCSCode; "Employee B2B"."Bank IFCS Code")
            {
            }
            column(Employee_B2B_BankBranch; "Employee B2B"."Bank Branch")
            {
            }
            column(FamilyComposition; FamilyCompositionLbl)
            {
            }
            column(Name; NameLbl)
            {
            }
            column(Relation; RelationLbl)
            {
            }
            column(Age2; AgeLbl)
            {
            }
            column(Occupation; OccupationLbl)
            {
            }
            column(AcademicRecord; AcademicRecordLbl)
            {
            }
            column(ExamPass; ExamPassLbl)
            {
            }
            column(SchoolLbl; SchoolLbl)
            {
            }
            column(PassingYear; PassingYearLbl)
            {
            }
            column(Class; ClassLbl)
            {
            }
            column(PreviousEmpRecord; PreviousEmpRecordLbl)
            {
            }
            column(Organization; OrganizationLbl)
            {
            }
            column(Working; WorkingLbl)
            {
            }
            column(GrossSalary; GrossSalaryLbl)
            {
            }
            column(SpecialAchivements; SpecialAchivementsLbl)
            {
            }
            column(Refernces; ReferncesLbl)
            {
            }
            column(NameAddress; NameAddressLbl)
            {
            }
            column(Years; YearsLbl)
            {
            }
            column(FamilyComp; FamilyCompLbl)
            {
            }
            column(QualiCode; QualiCode)
            {
            }
            column(InstituionCompany; InstituionCompany)
            {
            }
            column(ClassVar; ClassVar)
            {
            }
            column(PassingYearVar; PassingYearVar)
            {
            }
            column(SignatureofEmp; SignatureofEmpLbl)
            {
            }
            column(HRManager; HRManagerLbl)
            {
            }
            dataitem("Employee Hobbies & Lang."; "Employee Hobbies & Lang. B2B")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Line Type", "Line No.") ORDER(Ascending);
                column(LanguagesKonwn; LanguagesKonwnLbl)
                {
                }
                column(Speak; SpeakLbl)
                {
                }
                column(Read; ReadLbl)
                {
                }
                column(Write; WriteLbl)
                {
                }
                column(Employee_Hobbies_EmployeeNo; "Employee Hobbies & Lang."."Employee No.")
                {
                }
                column(Employee_Hobbies_LanguageName; "Employee Hobbies & Lang."."Language Name")
                {
                }
                column(Employee_Hobbies_ToSpeak; "Employee Hobbies & Lang."."To Speak")
                {
                }
                column(Employee_Hobbies_ToRead; "Employee Hobbies & Lang."."To Read")
                {
                }
                column(Employee_Hobbies_ToWrite; "Employee Hobbies & Lang."."To Write")
                {
                }
            }
            dataitem("Employee B2B2"; "Employee B2B")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.") ORDER(Ascending);
            }
            dataitem("Employee Relative"; "Employee Relative B2B")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Line No.") ORDER(Ascending) WHERE("Relative Type" = CONST(Relative));
                column(Employee_Relative_EmployeeNo; "Employee Relative"."Employee No.")
                {
                }
                column(Employee_Relative_FirstName; "Employee Relative"."First Name")
                {
                }
                column(Employee_Relative_RelativeCode; "Employee Relative"."Relative Code")
                {
                }
                column(Employee_Relative_AgeinYears; "Employee Relative"."Age in Years")
                {
                }
                column(Employee_Relative_Occupation; "Employee Relative".Occupation)
                {
                }
                column(Employee_Relative_RelativeType; "Employee Relative"."Relative Type")
                {
                }
            }
            dataitem("Employee Qualification"; "Employee Qualification B2B")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Line No.") WHERE("Qualification Type" = CONST(Qualification));
                column(Employee_Qualification_EmployeeNo; "Employee Qualification"."Employee No.")
                {
                }
                column(Employee_Qualification_QualificationCode; "Employee Qualification"."Qualification Code")
                {
                }
                column(Employee_Qualification_InstitutionCompany; "Employee Qualification"."Institution/Company")
                {
                }
                column(Employee_Qualification_YearofPassing; "Employee Qualification"."Year of Passing")
                {
                }
                column(Employee_Qualification_Class; "Employee Qualification".Class)
                {
                }
            }
            dataitem("Previous Employment Record"; "Employee Qualification B2B")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Line No.") WHERE("Qualification Type" = CONST(Experience));
                column(HRComentLine_Comment; HRComentLine.Comment)
                {
                }
                column(HRComentLine_No; HRComentLine."No.")
                {
                }
                column(CommentVar; CommentVar)
                {
                }
                column(PreviousEmploymentRecord_EmployeeNo; "Previous Employment Record"."Employee No.")
                {
                }
                column(PreviousEmploymentRecord_InstitutionCompany; "Previous Employment Record"."Institution/Company")
                {
                }
                column(PreviousEmploymentRecord_Designation; "Previous Employment Record".Designation)
                {
                }
                column(PreviousEmploymentRecord_FromDate; "Previous Employment Record"."From Date")
                {
                }
                column(PreviousEmploymentRecord_ToDate; "Previous Employment Record"."To Date")
                {
                }
                column(PreviousEmploymentRecord_GrossSalary; "Previous Employment Record"."Gross Salary")
                {
                }
                column(PreviousEmploymentRecord_Occupation; "Previous Employment Record".Occupation)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    HRComentLine.RESET();
                    HRComentLine.SETRANGE("No.", "Employee B2B"."No.");
                    if HRComentLine.FINDFIRST() then;
                end;
            }
            dataitem("Relative referances"; "Employee Relative B2B")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Line No.") WHERE("Relative Type" = CONST("Other than Relative"));
                column(Relativereferances_EmployeeNo; "Relative referances"."Employee No.")
                {
                }
                column(Relativereferances_ReferenceName; "Relative referances"."Reference Name")
                {
                }
                column(Relativereferances_Address1; "Relative referances".Address1)
                {
                }
                column(Relativereferances_ContactNumber; "Relative referances"."Contact Number")
                {
                }
                column(Relativereferances_Occupation; "Relative referances".Occupation)
                {
                }
                column(Relativereferances_YearsKnown; "Relative referances"."Years Known")
                {
                }
            }
            dataitem("Special Achievements"; "Employee B2B")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                column(SpecialAchievements_No; "Special Achievements"."No.")
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                EmpRelative.RESET();
                EmpRelative.SETRANGE("Employee No.", "No.");
                if EmpRelative.FINDFIRST() then;

                EmpHobbies.RESET();
                EmpHobbies.SETRANGE("Employee No.", "No.");
                if EmpHobbies.FINDFIRST() then;
                CLEAR(DateVar);
                CLEAR(DateVar1);
                CLEAR(AgeVar);
                if "Employee B2B"."Birth Date" <> 0D then begin
                    DateVar := DATE2DMY("Employee B2B"."Birth Date", 3);
                    DateVar1 := DATE2DMY(TODAY(), 3);
                    AgeVar := DateVar1 - DateVar;
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
        Caption = 'Employee Complete Information';

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
        CompanyInfo: Record "Company Information";
        HRComentLine: Record "HR Comment Line B2B";
        EmpRelative: Record "Employee Relative B2B";
        EmpHobbies: Record "Employee Hobbies & Lang. B2B";
        DateVar: Integer;
        DateVar1: Integer;
        AgeVar: Integer;

        EmployeeInfoLbl: Label 'EMPLOYEE INFORMATION FORM';
        EmpNameLbl: Label 'Employee Name';
        EmpNumbLbl: Label 'Employee Number';
        DateofJoinLbl: Label 'Date of joining';
        DesignationLbl: Label 'Designation';
        DepartmentLbl: Label 'Department';
        FatherNameLbl: Label 'Father/Husband';
        PermenantAddrsLbl: Label 'Permenant Address';
        PresentAddrLbl: Label 'Present Address';
        ContactDetLbl: Label 'Contact Details';
        MobileLbl: Label 'Mobile No.';
        EmailLbl: Label 'Email ID';
        ResPhoneNoLbl: Label 'Res. phone No';
        WeightLbl: Label 'Weight';
        KgLbl: Label 'Kg';
        HeightLbl: Label 'Height';
        cmsLbl: Label 'cms';
        SexLbl: Label 'Sex';
        AgeLbl: Label 'Age';
        DateofBirthLbl: Label 'Date of Birth';
        PlaceofBirthLbl: Label 'Plase of Birth';
        BloodGroupLbl: Label 'Blood Group';
        NationalityLbl: Label 'Nationality';
        MaritalLbl: Label 'Marital Status';
        PANNoLbl: Label 'PAN No';
        PFNoLbl: Label 'PF No';
        ESICNoLbl: Label 'ESIC No';
        HobbiesLbl: Label 'Hobbies';
        ColonLbl: Label ':';
        LanguagesKonwnLbl: Label '"Languges Known "';
        SpeakLbl: Label 'Speak';
        ReadLbl: Label 'Read';
        WriteLbl: Label 'Write';
        BankInfoLbl: Label 'Bank Information';
        NameofBankLbl: Label 'Name of the Bank';
        AccNumLbl: Label 'Account Number';
        IFSCodeLbl: Label 'IFS Code';
        BranchLbl: Label 'Branch';
        FamilyCompositionLbl: Label 'Family Composition';
        NameLbl: Label 'Name';
        RelationLbl: Label 'Relation';
        OccupationLbl: Label 'Occupation';
        AcademicRecordLbl: Label 'Academic Record';
        ExamPassLbl: Label 'Examination Passed';
        SchoolLbl: Label 'School/University';
        PassingYearLbl: Label 'Passing Year';
        ClassLbl: Label 'Class';
        PreviousEmpRecordLbl: Label 'Previous Employment Record';
        OrganizationLbl: Label 'Organization';
        WorkingLbl: Label 'Working Period';
        GrossSalaryLbl: Label 'Gross Salary';
        SpecialAchivementsLbl: Label 'Special Achivements';
        ReferncesLbl: Label 'References (Other than Relatives)';
        NameAddressLbl: Label 'Name Address';
        YearsLbl: Label 'Years Known';
        FamilyCompLbl: Label 'Family Composition';

        QualiCode: Code[20];
        InstituionCompany: Text[50];
        PassingYearVar: Integer;
        ClassVar: Text[20];
        SignatureofEmpLbl: Label 'Signature of the Employee';
        HRManagerLbl: Label 'HR MANAGER';
        CommentVar: Text[1024];
}

