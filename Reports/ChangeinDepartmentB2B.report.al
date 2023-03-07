report 33001261 "Change in Department B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Change in Department.rdl';
    Caption = 'Change in Department';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Change in Cadre"; "Change in Cadre B2B")
        {
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(Empname; Empname)
            {
            }
            column(Empname_Control1102152015; Empname)
            {
            }
            column(ReferanceNo; ReferanceNoGVar)
            {
            }
            column(DataItem1102152018; 'With immediate effect,The Management is pleased to revise Your designation as ' + FORMAT("Change in Cadre"."New Designation") + ' ' + 'Your salary & Grade will remain same as per your increment letter dated ' + FORMAT("Effective Date", 0, 4))
            {
            }
            column(PersonName; PersonName)
            {
            }
            column(Ref_No__Caption; Ref_No__CaptionLbl)
            {
            }
            column(To_Caption; To_CaptionLbl)
            {
            }
            column(SubjectCaption; SubjectCaptionLbl)
            {
            }
            column(DearCaption; DearCaptionLbl)
            {
            }
            column(Change_in_DesignationCaption; Change_in_DesignationCaptionLbl)
            {
            }
            column(Mr__Ms__Mrs_Caption; Mr__Ms__Mrs_CaptionLbl)
            {
            }
            column(Yours_faithfully_Caption; Yours_faithfully_CaptionLbl)
            {
            }
            column(Thanking_you_Caption; Thanking_you_CaptionLbl)
            {
            }
            column(I_accept_the_above_terms_and_conditions_Caption; I_accept_the_above_terms_and_conditions_CaptionLbl)
            {
            }
            column(Name_of_the_employee_Caption; Name_of_the_employee_CaptionLbl)
            {
            }
            column(Change_in_Cadre_Emp_No_; "Emp No.")
            {
            }
            column(Change_in_Cadre_Effective_Date; "Effective Date")
            {
            }
            column(withcaptionlbl; withcaptionlbl)
            { }
            column(yoursalarylb1; yoursalarylb1)
            { }
            //B2BMMOn30Aug2022>>
            column(AuthorisedPersonGVar; AuthorisedPersonGVar)
            { }
            column(EffectedDateGVar; EffectedDateGVar)
            { }
            column(New_Designation; "New Designation")
            { }
            trigger OnAfterGetRecord()
            begin
                if EmployeeB2B.Get("Emp No.") then
                    Empname := EmployeeB2B."First Name";

            end;
            //B2BMMOn30Aug2022<<
        }

    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AuthorisedPerson; AuthorisedPersonGVar)
                {
                    ToolTip = 'Choose the Authorised person to change the department of employee.';
                    Caption = 'Authorised Person';
                    //TableRelation = "Employee B2B;//B2BMMOnAug2022
                    ApplicationArea = all;
                }
                field(EffectedDate; EffectedDateGVar)
                {
                    ToolTip = 'Choose the date from which employee department changes effects.';
                    Caption = 'Effected Date';
                    ApplicationArea = all;
                }
                field(ReferanceNo; ReferanceNoGVar)
                {
                    ToolTip = 'Enter the refernce no for change in employee department.';
                    Caption = 'Referance No.';
                    ApplicationArea = all;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var

        AuthorisedPersonGVar: Code[20];
        EmployeeB2B: Record "Employee B2B";
        PersonName: Text[30];
        Empname: Text[500];
        EffectedDateGVar: Date;
        ReferanceNoGVar: Code[50];
        Ref_No__CaptionLbl: Label 'Ref.No.:';
        To_CaptionLbl: Label 'To,';
        SubjectCaptionLbl: Label 'Subject :';
        DearCaptionLbl: Label 'Dear';
        Change_in_DesignationCaptionLbl: Label 'Change in Designation';
        Mr__Ms__Mrs_CaptionLbl: Label 'Mr./Ms./Mrs.';
        Yours_faithfully_CaptionLbl: Label 'Yours faithfully,';
        Thanking_you_CaptionLbl: Label 'Thanking you,';
        I_accept_the_above_terms_and_conditions_CaptionLbl: Label 'I accept the above terms and conditions';
        Name_of_the_employee_CaptionLbl: Label '(Name of the employee)';
        withcaptionlbl: Label 'With immediate effect,The Management is pleased to revise Your designation as ';
        yoursalarylb1: Label 'Your salary & Grade will remain same as per your increment letter dated';
        "Effective Date": Date;


}

