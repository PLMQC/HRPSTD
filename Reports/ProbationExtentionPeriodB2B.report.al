report 33001271 "Probation Extention Period B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Probation Extention Period.rdl';
    Caption = 'Probation Extention Period';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Probation Extended"; "Probation Extended B2B")
        {
            RequestFilterFields = "Id.";
            column(Employee__First_Name_______Employee__Middle_Name_________Employee__Last_Name_; Employee."First Name" + '  ' + Employee."Middle Name" + '   ' + Employee."Last Name")
            {
            }
            column(Employee_Address; Employee.Address)
            {
            }
            column(Employee__Address_2_; Employee."Address 2")
            {
            }
            column(Employee_City_______Employee__Post_Code_; Employee.City + ' ' + Employee."Post Code")
            {
            }
            column(Sub____Extension_of_Probation__; 'Sub. : Extension of Probation.')
            {
            }
            column(Dear_______Employee__First_Name_______Employee__Middle_Name________Employee__Last_Name_____; 'Dear' + '  ' + Employee."First Name" + '  ' + Employee."Middle Name" + '' + Employee."Last Name" + ',')
            {
            }
            column(This_is_to_inform_that_with__reference_to_the_letter_No_____Employee__Appointment_Letter_No__; 'This  is  to  inform  that  with  reference  to  the  letter  No.    ' + Employee."Appointment Letter No.")
            {
            }
            column(DataItem1102152008; 'Dated  ' + FORMAT("Effective Date", 0, 4) + ' ' + 'Your probation has been extended Up to ' + '  ' + FORMAT("Probation End Date", 0, 4))
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(AuthSign; AuthSignGVar)
            {
            }
            column(To_Caption; To_CaptionLbl)
            {
            }
            column(Your_Employment_with_this_organization_shall_be_as_per_the_letter_as_mentioned_above___Caption; Your_Employment_with_this_organization_shall_be_as_per_the_letter_as_mentioned_above___CaptionLbl)
            {
            }
            column(Your_are_requested_to_sign_and_return_the_duplicate_copy_of_this_letter_Caption; Your_are_requested_to_sign_and_return_the_duplicate_copy_of_this_letter_CaptionLbl)
            {
            }
            column(Thanking_you_Caption; Thanking_you_CaptionLbl)
            {
            }
            column(Signature_with_dateCaption; Signature_with_dateCaptionLbl)
            {
            }
            column(Name___AddressCaption; Name___AddressCaptionLbl)
            {
            }
            column(CompanyInfo_NameCaption; CompanyInfo_NameCaptionLbl)
            {
            }
            column(Probation_Extended_Id_; "Id.")
            {
            }
            column(Id_; "Id.")
            { }
            column(DateGVar;DateGVar)
            { }

            trigger OnAfterGetRecord();
            begin
                Employee.RESET();
                Employee.SETRANGE("No.", "Employee  Id");
                if Employee.FINDFIRST() then begin
                    Date2 := Employee."Appointment Date";
                    J := CALCDATE("Extended Probation Period", "Effective Date");
                end;
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AuthSign; AuthSignGVar)
                {
                    ToolTip = 'Enter the Autorised Signatory Name.';
                    Caption = 'Authorised Signatory';
                    ApplicationArea = all;
                }
                field(Date; DateGVar)
                {
                    ToolTip = 'Choose the Date.';
                    Caption = 'Date';
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
        Employee: Record "Employee B2B";
        CompanyInfo: Record "Company Information";
        AuthSignGVar: Text[30];
        DateGVar: Date;
        Date2: Date;
        J: Date;
        To_CaptionLbl: Label 'To,';
        Your_Employment_with_this_organization_shall_be_as_per_the_letter_as_mentioned_above___CaptionLbl: Label 'Your Employment with this organization shall be as per the letter as mentioned above . ';
        Your_are_requested_to_sign_and_return_the_duplicate_copy_of_this_letter_CaptionLbl: Label 'Your are requested to sign and return the duplicate copy of this letter.';
        Thanking_you_CaptionLbl: Label 'Thanking you,';
        Signature_with_dateCaptionLbl: Label 'Signature with date';
        Name___AddressCaptionLbl: Label 'Name & Address';
        CompanyInfo_NameCaptionLbl: Label '"For "';
}

