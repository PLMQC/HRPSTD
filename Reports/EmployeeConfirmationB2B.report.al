report 33001270 "Employee Confirmation B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Employee Confirmation.rdl';
    Caption = 'Employee Confirmation';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee Confirmation Header"; "Employee Confirm. Header B2B")
        {
            RequestFilterFields = "Employee ID";
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompanyAddress; CompInfo.Address + CompInfo."Address 2")
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(Employee__Last_Name_; Employee."Last Name")
            {
            }
            column(Employee_Address; Employee.Address)
            {
            }
            column(Sub____Confirmation_to_the_Post_of_________Employee_Designation____; 'Sub. : Confirmation to the Post of' + '  "' + DesignationDescription + '"')
            {
            }
            column(Employee_Designation; Employee.Designation)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(DA; DA)
            {
            }
            column(Total; Total)
            {
            }
            column(Employee__Pay_Cadre_; Employee."Pay Cadre")
            {
            }
            column(This_has_reference_to_your_appointment_dated______FORMAT_Employee__Employment_Date__0_4_; 'This has reference to your appointment dated' + ' ' + FORMAT(Employee."Employment Date", 0, 4))
            {
            }
            column(DataItem1102152006; 'We are pleased to confirm your services w.e.f ' + FORMAT("Date of Confirmation", 0, 4) + '   ' + 'The  details of your monthly salary ')
            {
            }
            column(Employee__First_Name________Employee__Middle_Name________Employee__Last_Name_; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
            {
            }
            column(Employee__Address_2_; Employee."Address 2")
            {
            }
            column(Employee_City_______Employee__Post_Code_; Employee.City + ' ' + Employee."Post Code")
            {
            }
            column(ReferanceNo; ReferanceNoGVar)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(Employee_Confirmation_Header_Scale; Scale)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(Total_Rs_Caption; Total_Rs_CaptionLbl)
            {
            }
            column(ScaleCaption; ScaleCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152021; EmptyStringCaption_Control1102152021Lbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152025; EmptyStringCaption_Control1102152025Lbl)
            {
            }
            column(Rs_Caption; Rs_CaptionLbl)
            {
            }
            column(To_Caption; To_CaptionLbl)
            {
            }
            column(Dear__Ms_Mrs__Mr_Caption; Dear__Ms_Mrs__Mr_CaptionLbl)
            {
            }
            column(Ms_Mrs_MrCaption; Ms_Mrs_MrCaptionLbl)
            {
            }
            column(are_as_followsCaption; are_as_followsCaptionLbl)
            {
            }
            column(Your_employment_association_; Your_employment_association_confirmation_and_the_continuance_thereof_mLbl)
            {
            }
            column(During_emp_1; During_your_employment_association_thereof__you_will_be_paidLbl)
            {
            }
            column(During_emp_2; During_your_employment_association_thereof__2Lbl)
            {
            }
            column(V1_Caption; V1_CaptionLbl)
            {
            }
            column(V2_Caption; V2_CaptionLbl)
            {
            }
            column(V3_Caption; V3_CaptionLbl)
            {
            }
            column(Employee_Confirmation_Header_Confirmation_ID; "Confirmation ID")
            {
            }
            column(DateofConfirmation_EmployeeConfirmationHeader; "Employee Confirmation Header"."Date of Confirmation")
            {
            }
            column(DesignationDescription; DesignationDescription)
            {
            }
            column(MrOrMrs; MrOrMrs)
            {
            }
            column(Date_of_Confirmation; "Date of Confirmation")
            { }
            dataitem("Employee Confirmation Line"; "Employee Confirmation Line B2B")
            {
                DataItemLink = "Header No." = FIELD("Confirmation ID");
                DataItemTableView = SORTING("Header No.", "No.", "Pay Element", "Revised Date", "Line No.");
                column(LineNo_EmployeeConfirmationLine; "Employee Confirmation Line"."Line No.")
                {
                }
                column(PayElement_EmployeeConfirmationLine; "Employee Confirmation Line"."Pay Element")
                {
                }
                column(FixedPercent_EmployeeConfirmationLine; "Employee Confirmation Line"."Fixed / Percent")
                {
                }
                column(AmountPercent_EmployeeConfirmationLine; "Employee Confirmation Line"."Amount / Percent")
                {
                }
                column(RevisedAmountPercent_EmployeeConfirmationLine; "Employee Confirmation Line"."Revised Amount / Percent")
                {
                }
                column(RevisedDate_EmployeeConfirmationLine; "Employee Confirmation Line"."Revised Date")
                {
                }
                column(ComputationType_EmployeeConfirmationLine; "Employee Confirmation Line"."Computation Type")
                {
                }
                column(RevisedAmountPercent; RevisedAmountPercent)
                {
                }
                column(PayElementAmount; PayElementAmount)
                {
                }
                column(AuthSignGVar; AuthSignGVar)
                { }
                column(DateGvar; DateGvar)
                { }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(PayElementAmount);
                    EmployeeConfrmationLine.RESET();
                    EmployeeConfrmationLine.SETRANGE("Header No.", "Employee Confirmation Line"."Header No.");
                    if EmployeeConfrmationLine.FINDFIRST() then
                        repeat
                            if EmployeeConfrmationLine."Pay Element" = Text0003Txt then
                                BasicPay := EmployeeConfrmationLine."Revised Amount / Percent";

                            if EmployeeConfrmationLine."Pay Element" = Text0004Txt then
                                if EmployeeConfrmationLine."Fixed / Percent" = EmployeeConfrmationLine."Fixed / Percent"::Percent then begin
                                    if EmployeeConfrmationLine."Computation Type" = Text0005Txt then
                                        DA := BasicPay * EmployeeConfrmationLine."Revised Amount / Percent" / 100
                                end else
                                    DA := EmployeeConfrmationLine."Revised Amount / Percent";

                        until EmployeeConfrmationLine.NEXT() = 0;
                    if "Employee Confirmation Line"."Fixed / Percent" = "Employee Confirmation Line"."Fixed / Percent"::Percent then
                        RevisedAmountPercent := FORMAT("Employee Confirmation Line"."Revised Amount / Percent") + '%'
                    else
                        RevisedAmountPercent := FORMAT("Employee Confirmation Line"."Revised Amount / Percent");

                    if "Employee Confirmation Line"."Fixed / Percent" = "Employee Confirmation Line"."Fixed / Percent"::Percent then begin
                        if "Employee Confirmation Line"."Computation Type" = Text0005Txt then
                            PayElementAmount := BasicPay * "Employee Confirmation Line"."Revised Amount / Percent" / 100
                        else
                            if "Employee Confirmation Line"."Computation Type" = Text0006Txt then
                                PayElementAmount := ((BasicPay + DA) * "Employee Confirmation Line"."Revised Amount / Percent" / 100)
                    end else
                        PayElementAmount := "Employee Confirmation Line"."Revised Amount / Percent";

                    Total += PayElementAmount;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(DesignationDescription);

                Employee.GET("Employee Confirmation Header"."Employee ID");
                ReferanceNoGVar := "Employee Confirmation Header"."Confirmation ID";
                if Employee.Gender = Employee.Gender::Male then
                    MrOrMrs := Text000Txt
                else
                    if Employee.Gender = Employee.Gender::Female then
                        if Employee."Martial status" = Employee."Martial status"::Married then
                            MrOrMrs := Text0001Txt
                        else
                            MrOrMrs := Text0002Txt;
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE("Lookup Type", 5);
                Lookup_B2B.SETRANGE("Lookup Name", Employee.Designation);
                if Lookup_B2B.FINDFIRST() then
                    DesignationDescription := Lookup_B2B.Description;
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
                    ToolTip = 'Signature of Authorised person.';
                    Caption = 'Authorised Signatory';
                    ApplicationArea = all;
                }
                field(ReferanceNo; ReferanceNoGVar)
                {
                    ToolTip = 'Enter the Reference No.';
                    Caption = 'Referance No.';
                    ApplicationArea = all;
                }
                field(Date; DateGvar)
                {
                    ToolTip = 'Choose the date to be printed.';
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

    trigger OnPreReport();
    begin
        CompInfo.get();
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        Employee: Record "Employee B2B";
        EmployeeConfrmationLine: Record "Employee Confirmation Line B2B";
        Lookup_B2B: Record Lookup_B2B;
        Total: Decimal;
        AuthSignGVar: Text[50];
        DateGvar: Date;
        ReferanceNoGVar: Code[30];
        GradeCaptionLbl: Label 'Grade';
        Total_Rs_CaptionLbl: Label 'Total Rs.';
        ScaleCaptionLbl: Label 'Scale';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102152021Lbl: Label ':';
        DesignationCaptionLbl: Label '"Designation "';
        EmptyStringCaption_Control1102152025Lbl: Label '" : "';
        Rs_CaptionLbl: Label 'Rs.';
        To_CaptionLbl: Label 'To,';
        Dear__Ms_Mrs__Mr_CaptionLbl: Label 'Dear ';
        Ms_Mrs_MrCaptionLbl: Label 'Ms/Mrs/Mr';
        are_as_followsCaptionLbl: Label 'are as follows';
        Your_employment_association_confirmation_and_the_continuance_thereof_mLbl: Label '"Your employment,association,confirmation and the continuance thereof will be subject to you remain medically, physically and mentally fit, "';
        During_your_employment_association_thereof__you_will_be_paidLbl: Label 'During your employment association,confirmation and the continuance thereof, you will be paid salary as above subject to changes directed by the Management.';
        During_your_employment_association_thereof__2Lbl: Label 'During your employment ,association,confirmation and the continuance thereof you will subscribe every month to the provident fund etc. as and when applicable as per the relevent statutes governing provident fund.';
        V1_CaptionLbl: Label '1.';
        V2_CaptionLbl: Label '2.';
        V3_CaptionLbl: Label '3.';
        DesignationDescription: Text[250];
        PayElementAmount: Decimal;
        BasicPay: Decimal;
        DA: Decimal;
        MrOrMrs: Text;
        RevisedAmountPercent: Text;
        Text000Txt: Label 'Mr.';
        Text0001Txt: Label 'Mrs.';
        Text0002Txt: Label 'Ms.';
        Text0003Txt: Label 'BASIC';
        Text0004Txt: Label 'DA';
        Text0005Txt: Label 'AFTER BASIC';
        Text0006Txt: Label 'AFTER BASIC AND DA';
}

