report 33001301 "PF Form 10C B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PF Form 10C.rdlc';
    Caption = 'PF Form 10C';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(PayrollLoc__PF_Logo_; PayrollLoc."PF Logo")
            {
            }
            column(Text001; Text001Txt)
            {
            }
            column(Text002; Text002Txt)
            {
            }
            column(Text003; Text003Txt)
            {
            }
            column(Text004; Text004Txt)
            {
            }
            column(Last_Name_______First_Name_______Middle_Name_; "Last Name" + ' ' + "First Name" + ' ' + "Middle Name")
            {
            }
            column(DATE2DMY__Birth_Date__1_; DATE2DMY("Birth Date", 1))
            {
            }
            column(DATE2DMY__Birth_Date__2_; DATE2DMY("Birth Date", 2))
            {
            }
            column(DATE2DMY__Birth_Date__3_; DATE2DMY("Birth Date", 3))
            {
            }
            column(Employee_B2B__Father_Husband_; "Father/Husband")
            {
            }
            column(Employee_B2B__Spouse_Name_; "Spouse Name")
            {
            }
            column(Text012; Text012Txt)
            {
            }
            column(Text013; Text013Txt)
            {
            }
            column(Employee_B2B__Post_Code_; "Post Code")
            {
            }
            column(Employee_B2B_Country; Country)
            {
            }
            column(Employee_B2B_Address; Address)
            {
            }
            column(Employee_B2B__Address_2_; "Address 2")
            {
            }
            column(Employee_B2B_City; City)
            {
            }
            column(For_Office_Use_Only________In_Words_No_Caption; For_Office_Use_Only________In_Words_No_CaptionLbl)
            {
            }
            column(Serial_No_Caption; Serial_No_CaptionLbl)
            {
            }
            column(Form_No__10_C__E_P_S_Caption; Form_No__10_C__E_P_S_CaptionLbl)
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
            column(V5_Caption; V5_CaptionLbl)
            {
            }
            column(V6_Caption; V6_CaptionLbl)
            {
            }
            column(V7_Caption; V7_CaptionLbl)
            {
            }
            column(a__Name_of_the_member____Caption; a__Name_of_the_member____CaptionLbl)
            {
            }
            column(In_Block_Letters_Caption; In_Block_Letters_CaptionLbl)
            {
            }
            column(b__Name_of_the_Claimant__s__Caption; b__Name_of_the_Claimant__s__CaptionLbl)
            {
            }
            column(Date_Of_BirthCaption; Date_Of_BirthCaptionLbl)
            {
            }
            column(DDCaption; DDCaptionLbl)
            {
            }
            column(MMCaption; MMCaptionLbl)
            {
            }
            column(YYYYCaption; YYYYCaptionLbl)
            {
            }
            column(a__Father_s_Name____Caption; a__Father_s_Name____CaptionLbl)
            {
            }
            column(If_Applicable_Caption; If_Applicable_CaptionLbl)
            {
            }
            column(b__Husband_s_NameCaption; b__Husband_s_NameCaptionLbl)
            {
            }
            column(Name___Address_of_the_Establishment_in_which__the_member_was_last_employedCaption; Name___Address_of_the_Establishment_in_which__the_member_was_last_employedCaptionLbl)
            {
            }
            column(Code_No____Account_No_Caption; Code_No____Account_No_CaptionLbl)
            {
            }
            column(Region_SRO_CodeCaption; Region_SRO_CodeCaptionLbl)
            {
            }
            column(Estt__Code_No_Caption; Estt__Code_No_CaptionLbl)
            {
            }
            column(A_c_No_Caption; A_c_No_CaptionLbl)
            {
            }
            column(Full_Postal_Address___Caption; Full_Postal_Address___CaptionLbl)
            {
            }
            column(In_Block_Letters_Caption_Control1102152065; In_Block_Letters_Caption_Control1102152065Lbl)
            {
            }
            column(Sh_Smt__KmCaption; Sh_Smt__KmCaptionLbl)
            {
            }
            column(S_o__W_o__D_oCaption; S_o__W_o__D_oCaptionLbl)
            {
            }
            column(PINCaption; PINCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
        }
    }

    requestpage
    {
        Caption = 'PF Form 10C';

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

    trigger OnInitReport();
    begin
        if PayrollLoc.GET() then;
    end;

    var
        PayrollLoc: Record "Payroll Locations B2B";
        Text001Txt: Label 'Employees'' Pension Scheme, 1995';
        Text002Txt: Label 'FORM TO BE USED BY A MEMBER OF THE EMPLOYEES'' PENSION SCHEME,';
        Text003Txt: Label '"           1995 FOR CLAMING WITHDRAWAL BENEFIT/SHCEME CERTIFICATE"';
        Text004Txt: Label '( Read the instructions before filling up this form )';
        Text012Txt: Label 'Reason for leaving service';
        Text013Txt: Label '& Date of Leaving';
        For_Office_Use_Only________In_Words_No_CaptionLbl: Label 'For Office Use Only        In Words No.';
        Serial_No_CaptionLbl: Label 'Serial No.';
        Form_No__10_C__E_P_S_CaptionLbl: Label 'Form No. 10 C (E.P.S)';
        V1_CaptionLbl: Label '1.';
        V2_CaptionLbl: Label '2.';
        V3_CaptionLbl: Label '3.';
        V4_CaptionLbl: Label '4.';
        V5_CaptionLbl: Label '5.';
        V6_CaptionLbl: Label '6.';
        V7_CaptionLbl: Label '7.';
        a__Name_of_the_member____CaptionLbl: Label '"a) Name of the member :- "';
        In_Block_Letters_CaptionLbl: Label '"       ( In Block Letters)"';
        b__Name_of_the_Claimant__s__CaptionLbl: Label '"b) Name of the Claimant (s) "';
        Date_Of_BirthCaptionLbl: Label 'Date Of Birth';
        DDCaptionLbl: Label 'DD';
        MMCaptionLbl: Label 'MM';
        YYYYCaptionLbl: Label 'YYYY';
        a__Father_s_Name____CaptionLbl: Label '"a) Father''s Name :- "';
        If_Applicable_CaptionLbl: Label '( If Applicable)';
        b__Husband_s_NameCaptionLbl: Label 'b) Husband''s Name';
        Name___Address_of_the_Establishment_in_which__the_member_was_last_employedCaptionLbl: Label 'Name & Address of the Establishment in which, the member was last employed';
        Code_No____Account_No_CaptionLbl: Label 'Code No. & Account No.';
        Region_SRO_CodeCaptionLbl: Label 'Region/SRO Code';
        Estt__Code_No_CaptionLbl: Label 'Estt. Code No.';
        A_c_No_CaptionLbl: Label 'A/c No.';
        Full_Postal_Address___CaptionLbl: Label 'Full Postal Address :-';
        In_Block_Letters_Caption_Control1102152065Lbl: Label '" ( In Block Letters)"';
        Sh_Smt__KmCaptionLbl: Label 'Sh/Smt./Km';
        S_o__W_o__D_oCaptionLbl: Label 'S/o, W/o, D/o';
        PINCaptionLbl: Label 'PIN';
}

