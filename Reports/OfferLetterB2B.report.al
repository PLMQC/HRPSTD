report 33001279 "Offer Letter B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\OfferLetterB2B.rdl';
    Caption = 'Offer Letter';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Recruitment Line"; "Recruitment Line B2B")
        {
            DataItemTableView = ORDER(Ascending);
            RequestFilterFields = "Recruitment Header No", "Resume Reference No.";

            column(First_Name_Middle_Name_Surname; "First Name" + ' ' + "Middle Name" + ' ' + Surname)
            {
            }
            column(Recruitment_Line_Address1; Address1)
            {
            }
            column(Position_PositionName; Position)
            {
            }
            column(First_Name_; "First Name")
            {
            }
            column(offer_you_the_Post_of; 'offer you the Post of  ' + Position + '  in our Organization. A detailed letter of Appointment will be given to you on ')
            {
            }
            column(of_joining_i_e_; 'the date of joining i.e., ')
            {
            }
            column(Looking_forward_to_; 'Looking forward to associate with you for mutual benefit.')
            {
            }
            column(Note_This_Offer_Letter_is_valid; 'Note: - This Offer Letter is valid for acceptance for 10 days only from the date of issue.')
            {
            }
            column(For_COMPANYNAME; 'For ' + COMPANYNAME())
            {
            }
            column(Note_Please_acknowledge; 'Note: Please acknowledge the receipt of this letter.')
            {
            }
            column(TODAY; TODAY())
            {
            }
            column(Recruitment_Line_Address2; Address2)
            {
            }
            column(City_Post_Code_; City + ' ' + "Post Code")
            {
            }
            column(Recruitment_Line_State; State)
            {
            }
            column(Date_of_joininig_confirmed_by; ' (Date of joininig confirmed by the Candidate)')
            {
            }
            column(Recruitment_Line__Date_of_Join_; "Date of Join")
            {
            }
            column(First_Name_Middle_Name_SurnameCaption; First_Name_Middle_Name_SurnameCaptionLbl)
            {
            }
            column(Recruitment_Line_Address1Caption; Recruitment_Line_Address1CaptionLbl)
            {
            }
            column(Position_PositionNameCaption; Position_PositionNameCaptionLbl)
            {
            }
            column(First_Name_Caption; First_Name_CaptionLbl)
            {
            }
            column(This_has_reference_to_your_application_Caption; This_has_reference_to_your_applicationCaptionLbl)
            {
            }
            column(For_COMPANYNAMECaption; For_COMPANYNAMECaptionLbl)
            {
            }
            column(TODAYCaption; TODAYCaptionLbl)
            {
            }
            column(Recruitment_Header_No; "Recruitment Header No")
            {
            }
            column(Recruitment_Line_No_; "Recruitment Line No.")
            {
            }
            column(OfferLetterCaptionLbl; OfferLetterCaptionLbl)
            { }
            column(InfoName; InfoName)
            { }
            column(Date_of_Join;"Date of Join")
            {}


            trigger OnAfterGetRecord();
            begin
                Recruitment.RESET();
                Recruitment.SETRANGE("Recruitment Policy No.", "Recruitment Header No");
                if Recruitment.FINDFIRST() then
                    Position := Recruitment."Required Position";
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE("Lookup Type", 5);
                Lookup_B2B.SETRANGE("Lookup Name", Position);
                if Lookup_B2B.FINDFIRST() then
                    PositionName := Lookup_B2B.Description;
                //B2BMMOn07Sep2022>>
                CompanyInfo.Get();
                InfoName := CompanyInfo."Name";
                //<<B2BMMOn07Sep2022

            end;

        }
    }

    requestpage
    {
        Caption = 'Offer Letter';

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
        Recruitment: Record "Recruitment Header B2B";
        Lookup_B2B: Record Lookup_B2B;
        InfoName: Text[250];

        Position: Code[250];
        PositionName: Text[250];

        First_Name_Middle_Name_SurnameCaptionLbl: Label 'Mr./Ms';
        Recruitment_Line_Address1CaptionLbl: Label 'Address :';
        Position_PositionNameCaptionLbl: Label 'Sub : Offer Letter for the Position of   ';
        First_Name_CaptionLbl: Label 'Dear Mr./Ms';
        This_has_reference_to_your_applicationCaptionLbl: Label 'This has reference to your application and further discussions you had with us. We are Pleased to ';
        For_COMPANYNAMECaptionLbl: Label 'Regards ,';

        TODAYCaptionLbl: Label 'Date :';
        OfferLetterCaptionLbl: Label 'OFFER LETTER';
}

