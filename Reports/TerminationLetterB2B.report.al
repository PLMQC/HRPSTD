report 33001269 "Termination Letter B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Termination Letter.rdl';
    Caption = 'Termination Letter';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(AuthName____; AuthName + ',')
            {
            }
            column(DesignationVar; DesignationVar)
            {
            }
            column(CctoDiv; CctoDiv)
            {
            }
            column(CctoDept; CctoDept)
            {
            }
            column(Employee_B2B_Employee_B2B__Last_Working_Day_; "Employee B2B"."Last Working Day")
            {
            }
            column(Employee_B2B_Employee_B2B__First_Name_; "Employee B2B"."First Name")
            {
            }
            column(Last_Name; "Last Name")
            {

            }
            column(Employee_B2B_Employee_B2B_Address; "Employee B2B".Address + ',')
            {
            }
            column(Employee_B2B_Employee_B2B__Address_2_; "Employee B2B"."Address 2")
            {
            }
            column(Employee_B2B_Employee_B2B_City; "Employee B2B".City)
            {
            }
            column(Sub____Termination_of_your_AppointmentCaption; Sub____Termination_of_your_AppointmentCaptionLbl)
            {
            }
            column(Ref___Our_letter_dated___Date_of_appointment_letter_Caption; Ref___Our_letter_dated___Date_of_appointment_letter_CaptionLbl)
            {
            }
            column(Your_services_stand_terminated_with_immediate_effect_as_per_clause_no_10_of_above_referred_letter_Caption; Your_services_stand_terminated_with_immediate_effect_as_per_clause_no_10_of_above_referred_letter_CaptionLbl)
            {
            }
            column(For_final_settlement_of_your_dues_as_per_rules__you_are_requested_to_see_the_Caption; For_final_settlement_of_your_dues_as_per_rules__you_are_requested_to_see_the_CaptionLbl)
            {
            }
            column(undersigned_personally_during_office_hours_on_any_working_day_with_prior_intimation_Caption; undersigned_personally_during_office_hours_on_any_working_day_with_prior_intimation_CaptionLbl)
            {
            }
            column(Thanking_you_Caption; Thanking_you_CaptionLbl)
            {
            }
            column(ForCaption; ForCaptionLbl)
            {
            }
            column(Cc_toCaption; Cc_toCaptionLbl)
            {
            }
            column(Cc_toCaption_Control1102152018; Cc_toCaption_Control1102152018Lbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152020; EmptyStringCaption_Control1102152020Lbl)
            {
            }
            column(Employee_B2B_No_; "No.")
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
        Caption = 'Termination Letter';

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
        CctoDiv: Text[30];
        CctoDept: Text[30];
        Sub____Termination_of_your_AppointmentCaptionLbl: Label 'Sub. : Termination of your Appointment';
        Ref___Our_letter_dated___Date_of_appointment_letter_CaptionLbl: Label 'Ref : Our letter dated & Date of appointment letter ';
        Your_services_stand_terminated_with_immediate_effect_as_per_clause_no_10_of_above_referred_letter_CaptionLbl: Label 'Your services stand terminated with immediate effect as per clause no.10 of above referred letter.';
        For_final_settlement_of_your_dues_as_per_rules__you_are_requested_to_see_the_CaptionLbl: Label 'For final settlement of your dues as per rules, you are requested to see the ';
        undersigned_personally_during_office_hours_on_any_working_day_with_prior_intimation_CaptionLbl: Label 'undersigned personally during office hours on any working day with prior intimation.';
        Thanking_you_CaptionLbl: Label 'Thanking you,';
        ForCaptionLbl: Label 'For';
        Cc_toCaptionLbl: Label 'Cc to';
        Cc_toCaption_Control1102152018Lbl: Label 'Cc to';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102152020Lbl: Label ':';
}

