report 33001194 "Resume Database B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Resume Database.rdlc';
    Caption = 'Resume Database';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Resume Database"; "Resume Database B2B")
        {
            column(Resume_Database__No__; "No.")
            {
            }
            column(First_Name___Middle_Name__Surname; "First Name" + "Middle Name" + Surname)
            {
            }
            column(Resume_Database__Experience_Years__; "Experience(Years)")
            {
            }
            column(Resume_Database__Date_of_Receipt_of_Resume_; "Date of Receipt of Resume")
            {
            }
            column(Resume_Database_Months; Months)
            {
            }
            column(Resume_DatabaseCaption; Resume_DatabaseCaptionLbl)
            {
            }
            column(Resume_Database__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(ExperienceCaption; ExperienceCaptionLbl)
            {
            }
            column(Resume_Database__Date_of_Receipt_of_Resume_Caption; FIELDCAPTION("Date of Receipt of Resume"))
            {
            }
            column(yrs_Caption; yrs_CaptionLbl)
            {
            }
            column(MonthsCaption; MonthsCaptionLbl)
            {
            }
            dataitem(Credentials; "Credentials B2B")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Skill Type", "Line No.", Designation) ORDER(Ascending) WHERE("Resume Database" = FILTER(true));
                column(Credentials__Skill_Type_; "Skill Type")
                {
                }
                column(Credentials__Credential_Code_; "Credential Code")
                {
                }
                column(Credentials_Description; Description)
                {
                }
                column(Credentials_Percentage; Percentage)
                {
                }
                column(Credentials__Skill_Type_Caption; FIELDCAPTION("Skill Type"))
                {
                }
                column(Credentials__Credential_Code_Caption; FIELDCAPTION("Credential Code"))
                {
                }
                column(Credentials_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Credentials_PercentageCaption; FIELDCAPTION(Percentage))
                {
                }
                column(Credentials_Document_No_; "Document No.")
                {
                }
                column(Credentials_Document_Type; "Document Type")
                {
                }
                column(Credentials_Line_No_; "Line No.")
                {
                }
            }
        }
    }

    requestpage
    {
        Caption = 'Resume Database';

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
        Resume_DatabaseCaptionLbl: Label 'Resume Database';
        NameCaptionLbl: Label 'Name';
        ExperienceCaptionLbl: Label 'Experience';
        yrs_CaptionLbl: Label 'yrs.';
        MonthsCaptionLbl: Label 'Months';
}

