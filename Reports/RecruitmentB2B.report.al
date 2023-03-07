report 33001281 Recruitment_B2B
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Recruitment.rdlc';
    Caption = 'Recruitment';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Recruitment Header"; "Recruitment Header B2B")
        {
            DataItemTableView = SORTING ("Recruitment Policy No.");
            RequestFilterFields = "Recruitment Policy No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            /*
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }*/
            column(USERID; USERID())
            {
            }
            column(Recruitment_Header__Recruitment_Policy_No__; "Recruitment Policy No.")
            {
            }
            column(Recruitment_Header_Description; Description)
            {
            }
            column(Recruitment_Header__Indenting_Dept__; "Indenting Dept.")
            {
            }
            column(Recruitment_Header__No__of_Resources_; "No. of Resources")
            {
            }
            column(Recruitment_Header__Skill_Set_; "Skill Set")
            {
            }
            column(Recruitment_Header_Qualification; Qualification)
            {
            }
            column(Recruitment_Header__Date_of_Requirement_; "Date of Requirement")
            {
            }
            column(Recruitment_Header_Comments; Comments)
            {
            }
            column(Recruitment_Header__Required_Position_; "Required Position")
            {
            }
            column(Recruitment_Header__Required_Dept__; "Required Dept.")
            {
            }
            column(Recruitment_Header_Certification; Certification)
            {
            }
            column(Recruitment_DetailsCaption; Recruitment_DetailsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Recruitment_Header__Recruitment_Policy_No__Caption; FIELDCAPTION("Recruitment Policy No."))
            {
            }
            column(Recruitment_Header_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Recruitment_Header__Indenting_Dept__Caption; FIELDCAPTION("Indenting Dept."))
            {
            }
            column(Recruitment_Header__No__of_Resources_Caption; FIELDCAPTION("No. of Resources"))
            {
            }
            column(Recruitment_Header__Skill_Set_Caption; FIELDCAPTION("Skill Set"))
            {
            }
            column(Recruitment_Header_QualificationCaption; FIELDCAPTION(Qualification))
            {
            }
            column(Recruitment_Header__Date_of_Requirement_Caption; FIELDCAPTION("Date of Requirement"))
            {
            }
            column(Recruitment_Header_CommentsCaption; FIELDCAPTION(Comments))
            {
            }
            column(Recruitment_Header__Required_Position_Caption; FIELDCAPTION("Required Position"))
            {
            }
            column(Recruitment_Header__Required_Dept__Caption; FIELDCAPTION("Required Dept."))
            {
            }
            column(Recruitment_Header_CertificationCaption; FIELDCAPTION(Certification))
            {
            }

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("Recruitment Policy No.");
            end;
        }
    }

    requestpage
    {
        Caption = 'Recruitment';

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
        LastFieldNo: Integer;
        Recruitment_DetailsCaptionLbl: Label 'Recruitment Details';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

