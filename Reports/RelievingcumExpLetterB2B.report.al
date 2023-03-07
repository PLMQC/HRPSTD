report 33001291 "Relieving cum Exp Letter B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Relieving cum Exp Letter.rdl';
    Caption = 'Relieving cum Exp Letter';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            RequestFilterFields = "No.";
            //DataItemTableView = where(Resigned = const(true));
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(AuthName; AuthName)
            {
            }
            column(DesignationVar; DesignationVar)
            {
            }
            column(Date; Date)
            {
            }
            column(Employee_B2B__First_Name____was_employed_with_us_since__; "Employee B2B"."First Name")
            {
            }
            column(Last_Name; "Last Name" + ' was employed with us since ')
            {

            }
            column(Employee_B2B_Employee_B2B__Employment_Date_; "Employee B2B"."Employment Date")
            {
            }
            column(Employee_B2B_Designation___in_; "Employee B2B".Designation + ' in')
            {
            }
            column(Employee_B2B_Employee_B2B_Division; "Employee B2B".Division)
            {
            }
            column(Employee_B2B_Employee_B2B__Last_Working_Day_; "Employee B2B"."Last Working Day")
            {
            }
            column(TO_WHOMSOEVER_IT_MAY_CONCERNCaption; TO_WHOMSOEVER_IT_MAY_CONCERNCaptionLbl)
            {
            }
            column(This_is_to_certify_that_Caption; This_is_to_certify_that_CaptionLbl)
            {
            }
            column(Department_Code; "Department Code")
            {

            }
            column(as_aCaption; as_aCaptionLbl)
            {
            }
            column(He_She_has_submitted_his_her_resignation_on_his_her_own_accord_Caption; He_She_has_submitted_his_her_resignation_on_his_her_own_accord_CaptionLbl)
            {
            }
            column(He_She_stands_relieved_with_effect_from_Caption; He_She_stands_relieved_with_effect_from_CaptionLbl)
            {
            }
            column(after_office_hours__Caption; after_office_hours__CaptionLbl)
            {
            }
            column(During_his_her_service_with_us__we_found_him_her_very_sincere__punctual_and_painstaking_Caption; During_his_her_service_with_us__we_found_him_her_very_sincere__punctual_and_painstaking_CaptionLbl)
            {
            }
            column(We_wish_him_her_all_the_success_in_his_her_future_assignments_Caption; We_wish_him_her_all_the_success_in_his_her_future_assignments_CaptionLbl)
            {
            }
            column(ForCaption; ForCaptionLbl)
            {
            }
            column(Date___Caption; Date___CaptionLbl)
            {
            }
            column(division_Caption; division_CaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
            column(Mr_MrsCaptionLbl; Mr_MrsCaptionLbl)
            {

            }

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {
        Caption = 'Relieving cum Exp Letter';

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
        AuthName: Text[50];
        DesignationVar: Text[30];
        Date: Date;
        TO_WHOMSOEVER_IT_MAY_CONCERNCaptionLbl: Label 'TO WHOMSOEVER IT MAY CONCERN';
        This_is_to_certify_that_CaptionLbl: Label 'This is to certify that ';
        as_aCaptionLbl: Label ' as a';
        He_She_has_submitted_his_her_resignation_on_his_her_own_accord_CaptionLbl: Label 'He/She has submitted his/her resignation on his/her own accord.';
        He_She_stands_relieved_with_effect_from_CaptionLbl: Label 'He/She stands relieved with effect from ';
        after_office_hours__CaptionLbl: Label ' after office hours.';
        During_his_her_service_with_us__we_found_him_her_very_sincere__punctual_and_painstaking_CaptionLbl: Label 'During his/her service with us, we found him/her very sincere, punctual and painstaking.';
        We_wish_him_her_all_the_success_in_his_her_future_assignments_CaptionLbl: Label 'We wish him/her all the success in his/her future assignments.';
        ForCaptionLbl: Label 'For';
        Mr_MrsCaptionLbl: Label 'Mr/Mrs';
        Date___CaptionLbl: Label 'Date - ';
        division_CaptionLbl: Label ' department.';
}

