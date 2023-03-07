report 33001285 "Training FeedBack B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Training FeedBack.rdl';
    Caption = 'Training FeedBack';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Training Feedback Header"; "Training Feedback Header B2B")
        {
            RequestFilterFields = "Document No.", "Employee No.";

            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(Training_Feedback_HEader__Subject_of_Training_; "Subject of Training")
            {
            }
            column(Training_Feedback_HEader_Date; Date)
            {
            }
            column(Training_Feedback_HEader__Employee_Name_; "Employee Name")
            {
            }
            column(Training_Feedback_HEader__Employee_No__; "Employee No.")
            {
            }
            column(Training_Feedback_HEader_Department; Department)
            {
            }
            column(Training_Feedback_HEader_Designation; Designation)
            {
            }
            column(TRAINING_FEEDBACK_FORMCaption; TRAINING_FEEDBACK_FORMCaptionLbl)
            {
            }
            column(Training_Feedback_HEader__Subject_of_Training_Caption; FIELDCAPTION("Subject of Training"))
            {
            }
            column(Training_Feedback_HEader_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Name_of_the_ParticipantCaption; Name_of_the_ParticipantCaptionLbl)
            {
            }
            column(Training_Feedback_HEader__Employee_No__Caption; FIELDCAPTION("Employee No."))
            {
            }
            column(Training_Feedback_HEader_DepartmentCaption; FIELDCAPTION(Department))
            {
            }
            column(Training_Feedback_HEader_DesignationCaption; FIELDCAPTION(Designation))
            {
            }
            column(We_are_intrested_in_your_assessment; We_are_intrested_in_your_assessmentLbl)
            {
            }
            column(Training_Feedback_HEader_Document_No_; "Document No.")
            {
            }
            column(CategoriesCaption; CategoriesCaptionLbl)
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
            column(RatingCaption; RatingCaptionLbl)
            {
            }
            dataitem("Tranining Feedback Line"; "Tranining Feedback Line B2B")
            {

                DataItemLink = "Document No." = FIELD("Document No."), "Employee No." = FIELD("Employee No.");
                DataItemTableView = SORTING("Document No.", "Employee No.", "Line No.") ORDER(Ascending);
                column(Tranining_Feedback_Line_Categories; Categories)
                {
                }
                column(Tranining_Feedback_Line__1_; "1")
                {
                }
                column(Tranining_Feedback_Line__2_; "2")
                {
                }
                column(Tranining_Feedback_Line__3_; "3")
                {
                }
                column(Tranining_Feedback_Line__4_; "4")
                {
                }
                column(Tranining_Feedback_Line_Document_No_; "Document No.")
                {
                }
                column(Tranining_Feedback_Line_Employee_No_; "Employee No.")
                {
                }
                column(Tranining_Feedback_Line_Line_No_; "Line No.")
                {
                }
            }

            trigger OnPreDataItem();
            begin
                CompInfo.get();
                CompInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {
        Caption = 'Training FeedBack';

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
        CompInfo: Record "Company Information";
        TRAINING_FEEDBACK_FORMCaptionLbl: Label 'TRAINING FEEDBACK FORM';
        Name_of_the_ParticipantCaptionLbl: Label 'Name of the Participant';
        We_are_intrested_in_your_assessmentLbl: Label 'We are intrested in your assessment of the training provided and would like you to complete the form. For each statement,please check if you agree or disagree usig a ratings from " 1" to "4."For e.g. 1- Not at all satisfactory,2- Average,3 - Good or met expectation,4 - Excellent or Exceedd expectation';
        CategoriesCaptionLbl: Label 'Categories';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        V4CaptionLbl: Label '4';
        RatingCaptionLbl: Label 'Rating';
}

