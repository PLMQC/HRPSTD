report 33001280 "Appointment Letter B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\RecruitmentAppointmentLetter.rdl';
    Caption = 'Appointment Letter-';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Recruitment Line"; "Recruitment Line B2B")
        {
            //DataItemTableView = ORDER(Ascending);
            RequestFilterFields = "Resume Reference No.";
            DataItemTableView = where(selected = const(true));



            column(First_Name_Middle_Name_Surname;
            "First Name" + ' ' + "Middle Name" + ' ' + Surname)
            {
            }
            column(Recruitment_Line_Address1; Address1)
            {
            }
            column(GpayelementCode; GpayelementCode)
            {

            }
            column(Recruitment_Line_Surname; Surname)
            {
            }
            column(Appointecap; Appointecap)
            {

            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(DateGVar; DateGVar)
            {

            }
            column(Recruitment_Line_Address2; Address2)
            {
            }
            column(City_Post_Code; City + ' ' + "Post Code")
            {
            }
            column(Recruitment_Line_State; State)
            {
            }
            column(GTotalvalue; GTotalvalue)
            {

            }
            column(Sub_Appointment_as; 'Sub. : Appointment as a "' + Recruitment."Required Position" + ' " on probation')
            {
            }
            column(Required_Position_; Recruitment."Required Position")
            {
            }
            column(Date_of_Join; "Recruitment Line"."Date of Join")
            {
            }
            column(Salary_Range_; Recruitment."Salary Range")
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(DA; DA)
            {
            }
            column(HRA; HRA)
            {
            }
            column(CA; CA)
            {
            }
            column(MA; MA)
            {
            }
            column(LTA; LTA)
            {
            }
            column(Total; Total)
            {
            }
            column(Grade; "Recruitment Line".Grade)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(EmpDesignation; EmpDesignation)
            {
            }
            column(ReferenceNo; ReferenceNoGVar)
            {
            }
            column(Ms_Mrs_Mr_Caption; Ms_Mrs_Mr_CaptionLbl)
            {
            }
            column(During_your_probation_Caption; During_your_probation_CaptionLbl)
            {
            }
            column(With_reference_to_your_application_Caption; With_reference_to_your_application_CaptionLbl)
            {
            }
            column(on_probation_with_effect_from_Caption; on_probation_with_effect_from_CaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(Basic_PayCaption; Basic_PayCaptionLbl)
            {
            }
            column(b__D_A_Caption; b__D_A_CaptionLbl)
            {
            }
            column(c__House_Rent_Allowance_Caption; c__House_Rent_Allowance_CaptionLbl)
            {
            }
            column(d__Conveyance_AllowanceCaption; d__Conveyance_AllowanceCaptionLbl)
            {
            }
            column(f__Leave_Travel_AllowaneCaption; f__Leave_Travel_AllowaneCaptionLbl)
            {
            }
            column(e__Medical_AllowanceCaption; e__Medical_AllowanceCaptionLbl)
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
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(Rs_Caption; Rs_CaptionLbl)
            {
            }
            column(On_the_following_terms_and_Conditions_Caption; On_the_following_terms_and_Conditions_CaptionLbl)
            {
            }
            column(You_should_be_reporting_to__Mr_Caption; You_should_be_reporting_to__Mr_CaptionLbl)
            {
            }
            column(Power_Division___or_to_a_person_sCaption; Power_Division___or_to_a_person_sCaptionLbl)
            {
            }
            column(nominated_by_the_Managing_Director_Caption; nominated_by_the_Managing_Director_CaptionLbl)
            {
            }
            column(On_joining_the_services_Caption; On_joining_the_services_CaptionLbl)
            {
            }
            column(AuthCap; AuthCap)
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
            column(V4_Caption; V4_CaptionLbl)
            {
            }
            column(your_confirmation_will_beCaption; your_confirmation_will_beCaptionLbl)
            {
            }
            column(terminate_your_services__fothwithCaption; terminate_your_services__fothwithCaptionLbl)
            {
            }
            column(physically_and_mentally_fitCaption; physically_and_mentally_fitCaptionLbl)
            {
            }
            column(You_will_be_probation_in_the_firstCaption; You_will_be_probation_in_the_firstCaptionLbl)
            {
            }
            column(Recruitment_Line_Recruitment_Header_No; "Recruitment Header No")
            {
            }
            column(Recruitment_Line_Recruitment_Line_No_; "Recruitment Line No.")
            {
            }
            column(AuthSignGVar; AuthSignGVar)
            {

            }
            column(Resume_Reference_No_; "Resume Reference No.")
            {

            }
            dataitem("Pay Elements Temp B2B"; "Pay Elements Temp B2B")
            {
                DataItemLink = "Resume Referance No." = field("Resume Reference No.");

                column(Pay_Element_Code; "Pay Element Code")
                {

                }
                column(Amount___Percent; "Amount / Percent")
                {

                }
            }



            trigger OnAfterGetRecord();
            begin

                CLEAR(BasicPay);
                CLEAR(DA);
                CLEAR(HRA);
                CLEAR(CA);
                CLEAR(MA);
                CLEAR(Total);
                PayElementsTemp.RESET();
                PayElementsTemp.SETRANGE("Resume Referance No.", "Resume Reference No.");
                if PayElementsTemp.FINDFIRST() then
                    repeat
                        GTotalvalue := GTotalvalue + PayElementsTemp."Amount / Percent";

                    /*case PayElementsTemp."Pay Element Code" of
                        Text000Txt:
                            BasicPay := PayElementsTemp."Amount / Percent";
                        Text0001Txt:

                            if PayElementsTemp."Fixed/Percent" = PayElementsTemp."Fixed/Percent"::Fixed then
                                DA := PayElementsTemp."Amount / Percent"
                            else
                                if PayElementsTemp."Computation Type" = Text0002Txt then
                                    DA := ((PayElementsTemp."Amount / Percent") * BasicPay) / 100;


                        Text0003Txt:

                            if PayElementsTemp."Fixed/Percent" = PayElementsTemp."Fixed/Percent"::Fixed then
                                HRA := PayElementsTemp."Amount / Percent"
                            else
                                if PayElementsTemp."Computation Type" = Text0002Txt then
                                    HRA := ((PayElementsTemp."Amount / Percent") * BasicPay) / 100
                                else
                                    if PayElementsTemp."Computation Type" = Text0004Txt then
                                        HRA := ((PayElementsTemp."Amount / Percent") * (BasicPay + DA)) / 100;

                        Text0005Txt:
                            CA := PayElementsTemp."Amount / Percent";
                        Text0006Txt:
                            MA := PayElementsTemp."Amount / Percent";*/
                    //end;
                    //Total := BasicPay + DA + HRA + CA + MA;
                    until PayElementsTemp.NEXT() = 0;

                Recruitment.RESET();
                Recruitment.SETRANGE("Recruitment Policy No.", "Recruitment Header No");
                if Recruitment.FINDFIRST() then
                    Position := Recruitment."Required Position";
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE("Lookup Type", 5);
                Lookup_B2B.SETRANGE("Lookup Name", Position);
                if Lookup_B2B.FINDFIRST() then
                    PositionName := Lookup_B2B.Description;

                Employee.RESET();
                Employee.SETRANGE("No.", Recruitment."Reporting To");

                if Employee.FINDFIRST() then begin
                    EmpName := Employee."First Name";
                    EmpDesignation := Employee.Designation;
                end;
            end;

            trigger OnPreDataItem();
            begin
                GTotalvalue := 0;
                Recruitment.RESET();
                Recruitment.SETRANGE("Recruitment Policy No.", "Recruitment Header No");
                if Recruitment.FINDFIRST() then;
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
                    ToolTip = 'Enter the Name of Authorised Signatory.';
                    Caption = 'Authorised Signatory';
                    ApplicationArea = all;
                }
                field(Date; DateGVar)
                {
                    ToolTip = 'Choose the Date.';
                    Caption = 'Date';
                    ApplicationArea = all;
                }
                field(ReferenceNo; ReferenceNoGVar)
                {
                    ToolTip = 'Enter the Reference No. for Appointment Letter.';
                    Caption = 'Reference No.';
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
        Recruitment: Record "Recruitment Header B2B";
        Lookup_B2B: Record Lookup_B2B;
        PayElementsTemp: Record "Pay Elements Temp B2B";
        Employee: Record "Employee B2B";
        Position: Code[250];
        PositionName: Text[250];

        BasicPay: Decimal;
        DA: Decimal;
        HRA: Decimal;
        CA: Decimal;
        MA: Decimal;
        LTA: Decimal;
        Total: Decimal;

        AuthSignGVar: Text[50];
        DateGVar: Date;

        EmpName: Text[30];
        EmpDesignation: Code[50];
        ReferenceNoGVar: Code[30];
        Ms_Mrs_Mr_CaptionLbl: Label 'Ms/Mrs./Mr.';
        During_your_probation_CaptionLbl: Label 'During your probation you will be paid salary as detailed below:';
        With_reference_to_your_application_CaptionLbl: Label 'With reference to your application and subsequent discussions, we have pleasure in appointing you as a ';
        on_probation_with_effect_from_CaptionLbl: Label ' on probation with effect from';
        GradeCaptionLbl: Label 'Grade';
        Basic_PayCaptionLbl: Label '(a) Basic Pay';
        b__D_A_CaptionLbl: Label '(b) D.A.';
        c__House_Rent_Allowance_CaptionLbl: Label '(c) House Rent Allowance ';
        d__Conveyance_AllowanceCaptionLbl: Label '(d) Conveyance Allowance';
        f__Leave_Travel_AllowaneCaptionLbl: Label '(f) Leave Travel Allowane';
        e__Medical_AllowanceCaptionLbl: Label '(e) Medical Allowance';
        Total_Rs_CaptionLbl: Label 'Total Rs.';
        ScaleCaptionLbl: Label 'Scale';
        EmptyStringCaptionLbl: Label ':';
        DesignationCaptionLbl: Label 'Designation';
        Rs_CaptionLbl: Label 'Rs.';
        On_the_following_terms_and_Conditions_CaptionLbl: Label 'On the following terms and Conditions.';
        You_should_be_reporting_to__Mr_CaptionLbl: Label 'You should be reporting to  Mr.';
        Power_Division___or_to_a_person_sCaptionLbl: Label 'Power Division / or to a person/s';
        nominated_by_the_Managing_Director_CaptionLbl: Label 'nominated by the Managing Director.';
        On_joining_the_services_CaptionLbl: Label 'On  joining the services you are required to give a Declaration Concerning "Secrecy" in the prescribed format.';
        V1_CaptionLbl: Label '1.';
        V2_CaptionLbl: Label '2.';
        V3_CaptionLbl: Label '3.';
        V4_CaptionLbl: Label '4.';
        your_confirmation_will_beCaptionLbl: Label 'your confirmation will be subject to on your satisfactory conduct and performance during probation and a written communication by the management to that effect. If found unsatisfactory, the company may ';
        terminate_your_services__fothwithCaptionLbl: Label 'terminate your services  fothwith, without giving you any notice or compensation in lieu thereof. Further your probation and contiuntion thereof or on confirmation will be subject to you remaining medically,';
        physically_and_mentally_fitCaptionLbl: Label 'physically and mentally fit, and till you discharge your duties and availability  of work assigned and responsibilities entrusted upon you.';
        You_will_be_probation_in_the_firstCaptionLbl: Label 'You will be probation in the first instance for a period of six months  your confirmation will be subject to on your satisfactory conduct and You will be probation in the first instance for a period of six months';
        Text000Txt: Label 'BASIC';
        Text0001Txt: Label 'DA';
        Text0002Txt: Label 'AFTER BASIC';
        Text0003Txt: Label 'HRA';
        Text0004Txt: Label 'AFTER BASIC AND DA';
        Text0005Txt: Label 'CA';
        Text0006Txt: Label 'MA';
        GpayelementCode: code[30];
        GTotalvalue: Decimal;
        Appointecap: label 'Appointment Letter';
        AuthCap: label 'Authorized By';
}

