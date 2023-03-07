report 33001226 "Leave Application B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Leave Application.rdl';
    Caption = 'Leave Application';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Leave Application Header"; "Leave Application Header B2B")
        {
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Leave_Application_Header__Application_Date_; "Application Date")
            {
            }
            column(Leave_Application_Header__Leave_Application_Header___Employee_Name_; "Leave Application Header"."Employee Name")
            {
            }
            column(Leave_Application_Header__Leave_Application_Header___Employee_No__; "Leave Application Header"."Employee No.")
            {
            }
            column(Leave_Application_Header__Leave_Application_Header___Department_Code_; "Leave Application Header"."Department Code")
            {
            }
            column(Employee__Physical_Location_; Employee."Physical Location")
            {
            }
            column(Employee__Global_Dimension_1_Code_; Employee."Global Dimension 1 Code")
            {
            }
            column(Leave_Application_Header__Leave_Application_Header___Employee_Name__Control1102152099; "Leave Application Header"."Employee Name")
            {
            }
            column(Leave_Application_Header__Leave_Application_Header___Department_Code__Control1102152100; "Leave Application Header"."Department Code")
            {
            }
            column(Leave_Application_Line___No_of_Days_; "Leave Application Line"."No.of Days")
            {
            }
            column(Leave_Application_Line___From_Date_; "Leave Application Line"."From Date")
            {
            }
            column(Leave_Application_Line___Reason_for_Leave_; "Leave Application Line"."Reason for Leave")
            {
            }
            column(Employee__Physical_Location__Control1102152002; Employee."Physical Location")
            {
            }
            column(Employee__Global_Dimension_1_Code__Control1102152004; Employee."Global Dimension 1 Code")
            {
            }
            column(Leave_Application_Line___To_Date_; "Leave Application Line"."To Date")
            {
            }
            column(Leave_Application_Header__Leave_Application_Header___Employee_No___Control1102152059; "Leave Application Header"."Employee No.")
            {
            }
            column(LEAVE_APPLICATIONCaption; LEAVE_APPLICATIONCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(LocationCaption; LocationCaptionLbl)
            {
            }
            column(DivisionCaption; DivisionCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152019; EmptyStringCaption_Control1102152019Lbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152021; EmptyStringCaption_Control1102152021Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152022; EmptyStringCaption_Control1102152022Lbl)
            {
            }
            column(Employee_NumberCaption; Employee_NumberCaptionLbl)
            {
            }
            column(Name_of_ApplicantCaption; Name_of_ApplicantCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152025; EmptyStringCaption_Control1102152025Lbl)
            {
            }
            column(To_Administration_Department_Caption; To_Administration_Department_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152029; EmptyStringCaption_Control1102152029Lbl)
            {
            }
            column(For_My_Self_DateCaption; For_My_Self_DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152053; EmptyStringCaption_Control1102152053Lbl)
            {
            }
            column(Name_of_ApplicantCaption_Control1102152054; Name_of_ApplicantCaption_Control1102152054Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152055; EmptyStringCaption_Control1102152055Lbl)
            {
            }
            column(DepartmentCaption_Control1102152056; DepartmentCaption_Control1102152056Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152057; EmptyStringCaption_Control1102152057Lbl)
            {
            }
            column(Kindly_grant_me_earned_leaves_for_Caption; Kindly_grant_me_earned_leaves_for_CaptionLbl)
            {
            }
            column(day_days_w_e_f_Caption; day_days_w_e_f_CaptionLbl)
            {
            }
            column(toCaption; toCaptionLbl)
            {
            }
            column(The_reason_for_leave_is_Caption; The_reason_for_leave_is_CaptionLbl)
            {
            }
            column(Signature_of_ApplicantCaption; Signature_of_ApplicantCaptionLbl)
            {
            }
            column(Signature_of_HODCaption; Signature_of_HODCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152005; EmptyStringCaption_Control1102152005Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152006; EmptyStringCaption_Control1102152006Lbl)
            {
            }
            column(LocationCaption_Control1102152007; LocationCaption_Control1102152007Lbl)
            {
            }
            column(DivisionCaption_Control1102152008; DivisionCaption_Control1102152008Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152011; EmptyStringCaption_Control1102152011Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152060; EmptyStringCaption_Control1102152060Lbl)
            {
            }
            column(Employee_NumberCaption_Control1102152062; Employee_NumberCaption_Control1102152062Lbl)
            {
            }
            column(Leave_Application_Header_Document_No_; "Document No.")
            {
            }
            dataitem("Leave Application Line"; "Leave Application Line B2B")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
                column(Leave_Application_Line__Leave_Application_Line___No_of_Days_; "Leave Application Line"."No.of Days")
                {
                }
                column(Leave_Application_Line__Leave_Application_Line___From_Date_; "Leave Application Line"."From Date")
                {
                }
                column(Leave_Application_Line__Leave_Application_Line___To_Date_; "Leave Application Line"."To Date")
                {
                }
                column(Leave_Application_Line__Leave_Application_Line___Reason_for_Leave_; "Leave Application Line"."Reason for Leave")
                {
                }
                column(Leave_Application_Header___Work_Assigned_To_Name_; "Leave Application Header"."Work Assigned To Name")
                {
                }
                column(Approved_by_MDCaption; Approved_by_MDCaptionLbl)
                {
                }
                column(My_addressing_during_the_leave_period_is_as_under_Caption; My_addressing_during_the_leave_period_is_as_under_CaptionLbl)
                {
                }
                column(Signature_of_ApplicantCaption_Control1102152015; Signature_of_ApplicantCaption_Control1102152015Lbl)
                {
                }
                column(Recommended_by_HODCaption; Recommended_by_HODCaptionLbl)
                {
                }
                column(will_look_after_my_work_during_my_absence_Caption; will_look_after_my_work_during_my_absence_CaptionLbl)
                {
                }
                column(Mr__Mrs_Caption; Mr__Mrs_CaptionLbl)
                {
                }
                column(The_reason_for_leave_is_Caption_Control1102152036; The_reason_for_leave_is_Caption_Control1102152036Lbl)
                {
                }
                column(Kindly_grant_me_earned_leaves_forCaption; Kindly_grant_me_earned_leaves_forCaptionLbl)
                {
                }
                column(day_days_w_e_f_Caption_Control1102152041; day_days_w_e_f_Caption_Control1102152041Lbl)
                {
                }
                column(toCaption_Control1102152042; toCaption_Control1102152042Lbl)
                {
                }
                column(Leave_Application_Line_Document_No_; "Document No.")
                {
                }
                column(Leave_Application_Line_Line_No_; "Line No.")
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                Employee.RESET();
                Employee.SETRANGE("No.", "Employee No.");
                if Employee.FINDFIRST() then;
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
        Caption = 'Leave Application';

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
        Employee: Record "Employee B2B";
        LEAVE_APPLICATIONCaptionLbl: Label 'LEAVE APPLICATION';
        EmptyStringCaptionLbl: Label ':';
        LocationCaptionLbl: Label 'Location';
        DivisionCaptionLbl: Label 'Division';
        EmptyStringCaption_Control1102152019Lbl: Label ':';
        DepartmentCaptionLbl: Label 'Department';
        EmptyStringCaption_Control1102152021Lbl: Label ':';
        EmptyStringCaption_Control1102152022Lbl: Label ':';
        Employee_NumberCaptionLbl: Label 'Employee Number';
        Name_of_ApplicantCaptionLbl: Label 'Name of Applicant';
        EmptyStringCaption_Control1102152025Lbl: Label ':';
        To_Administration_Department_CaptionLbl: Label '"To Administration Department "';
        DateCaptionLbl: Label 'Date';
        EmptyStringCaption_Control1102152029Lbl: Label ':';
        For_My_Self_DateCaptionLbl: Label 'For My Self Date';
        EmptyStringCaption_Control1102152053Lbl: Label ':';
        Name_of_ApplicantCaption_Control1102152054Lbl: Label 'Name of Applicant';
        EmptyStringCaption_Control1102152055Lbl: Label ':';
        DepartmentCaption_Control1102152056Lbl: Label 'Department';
        EmptyStringCaption_Control1102152057Lbl: Label ':';
        Kindly_grant_me_earned_leaves_for_CaptionLbl: Label '"Kindly grant me earned leaves for "';
        day_days_w_e_f_CaptionLbl: Label '" day/days w.e.f "';
        toCaptionLbl: Label 'to';
        The_reason_for_leave_is_CaptionLbl: Label '"The reason for leave is "';
        Signature_of_ApplicantCaptionLbl: Label 'Signature of Applicant';
        Signature_of_HODCaptionLbl: Label 'Signature of HOD';
        EmptyStringCaption_Control1102152005Lbl: Label ':';
        EmptyStringCaption_Control1102152006Lbl: Label ':';
        LocationCaption_Control1102152007Lbl: Label 'Location';
        DivisionCaption_Control1102152008Lbl: Label 'Division';
        EmptyStringCaption_Control1102152011Lbl: Label '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
        EmptyStringCaption_Control1102152060Lbl: Label ':';
        Employee_NumberCaption_Control1102152062Lbl: Label 'Employee Number';
        Approved_by_MDCaptionLbl: Label 'Approved by MD';
        My_addressing_during_the_leave_period_is_as_under_CaptionLbl: Label 'My addressing during the leave period is as under:';
        Signature_of_ApplicantCaption_Control1102152015Lbl: Label 'Signature of Applicant';
        Recommended_by_HODCaptionLbl: Label 'Recommended by HOD';
        will_look_after_my_work_during_my_absence_CaptionLbl: Label 'will look after my work during my absence.';
        Mr__Mrs_CaptionLbl: Label 'Mr./Mrs.';
        The_reason_for_leave_is_Caption_Control1102152036Lbl: Label '"The reason for leave is "';
        Kindly_grant_me_earned_leaves_forCaptionLbl: Label 'Kindly grant me earned leaves for';
        day_days_w_e_f_Caption_Control1102152041Lbl: Label '" day/days w.e.f "';
        toCaption_Control1102152042Lbl: Label 'to';
}

