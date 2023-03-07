report 33001205 "PF Challan B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PF Challan.rdl';
    Caption = 'PF Challan';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Processed Salary"; "Processed Salary B2B")
        {
            DataItemTableView = SORTING("Employee Code", Year, "Pay Slip Month", "Add/Deduct") ORDER(Ascending);

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET();
                "Processed Salary".SETRANGE("Pay Slip Month", PFMonthGVar);
                "Processed Salary".SETRANGE(Year, PFYearGVar);
                "Processed Salary".SETRANGE("Add/Deduct Code", PFTextTxt);

                NoOFEmp := 0;
                TempBasicAmt := 0;
                Employee.RESET();
                Employee.SETRANGE(Blocked, false);
                Employee.SETRANGE("PF Applicable", true);
                if Employee.FINDFIRST() then
                    repeat
                        NoOFEmp := NoOFEmp + 1;
                        TempBasicAmt := 0;
                        ProcessedSalary.SETRANGE("Employee Code", Employee."No.");
                        ProcessedSalary.SETRANGE("Pay Slip Month", PFMonthGVar);
                        ProcessedSalary.SETRANGE(Year, PFYearGVar);
                        if ProcessedSalary.FINDFIRST() then
                            repeat
                                case ProcessedSalary."Add/Deduct Code" of
                                    BASICTextTxt:
                                        TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                                    FDATextTxt:
                                        TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                                    DATextTxt:
                                        TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                                    VDATextTxt:
                                        TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                                    stipendTextTxt:
                                        TempBasicAmt := TempBasicAmt + ProcessedSalary."Earned Amount";
                                end;
                            until ProcessedSalary.NEXT() = 0;
                        PayRevisionLine.SETRANGE("No.", Employee."No.");
                        PayRevisionLine.SETRANGE(Month, PFMonthGVar);
                        PayRevisionLine.SETRANGE(Year, PFYearGVar);
                        if PayRevisionLine.FINDFIRST() then
                            repeat
                                case PayRevisionLine."Pay Element" of
                                    BASICTextTxt:
                                        TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                                    FDATextTxt:
                                        TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                                    DATextTxt:
                                        TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                                    VDATextTxt:
                                        TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                                    stipendTextTxt:
                                        TempBasicAmt := TempBasicAmt + PayRevisionLine."Arrear Amount";
                                end;
                            until PayRevisionLine.NEXT() = 0;
                        Pf.GET(1);
                        if TempBasicAmt <= Pf."PF Amount" then begin
                            EPS := EPS + (TempBasicAmt * Pf."EPS %") / 100;
                            EPF := EPF + (TempBasicAmt * Pf."Employer Contribution") / 100;
                        end else begin
                            EPS := EPS + Pf."PF Amount" * Pf."EPS %" / 100;
                            EPF := EPF + (TempBasicAmt * Pf."EPS %") / 100 + (TempBasicAmt * Pf."Employer Contribution") / 100 - Pf."PF Amount" * Pf."EPS %" / 100;
                        end;
                        BasicAmt := BasicAmt + TempBasicAmt;
                    until Employee.NEXT() = 0;

                TempBasicAmt := BasicAmt;
                EmpShare := (TempBasicAmt * Pf."Employee Contribution") / 100;
                Admincharges := (TempBasicAmt * Pf."Admin Charges %") / 100;
                EdliCharges := (TempBasicAmt * Pf."EDLI %") / 100;
                RIFACharges := (TempBasicAmt * Pf."RIFA %") / 100;

                if Pf.FINDFIRST() then
                    case pf."Rounding Amount" of
                        Pf."Rounding Method"::Nearest:
                            begin
                                EdliCharges := ROUND(EdliCharges, Pf."Rounding Amount", '=');
                                RIFACharges := ROUND(RIFACharges, Pf."Rounding Amount", '=');
                                EPS := ROUND(EPS, Pf."Rounding Amount", '=');
                                EPF := ROUND(EPF, Pf."Rounding Amount", '=');
                                Admincharges := ROUND(Admincharges, Pf."Rounding Amount", '=');
                                EmpShare := ROUND(EmpShare, Pf."Rounding Amount", '=');
                            end;
                        Pf."Rounding Method"::Up:
                            begin
                                EdliCharges := ROUND(EdliCharges, Pf."Rounding Amount", '>');
                                RIFACharges := ROUND(RIFACharges, Pf."Rounding Amount", '>');
                                EPS := ROUND(EPS, Pf."Rounding Amount", '>');
                                EPF := ROUND(EPF, Pf."Rounding Amount", '>');
                                Admincharges := ROUND(Admincharges, Pf."Rounding Amount", '>');
                                EmpShare := ROUND(EmpShare, Pf."Rounding Amount", '>');
                            end;
                        else begin
                                EdliCharges := ROUND(EdliCharges, Pf."Rounding Amount", '<');
                                RIFACharges := ROUND(RIFACharges, Pf."Rounding Amount", '<');
                                EPS := ROUND(EPS, Pf."Rounding Amount", '<');
                                EPF := ROUND(EPF, Pf."Rounding Amount", '<');
                                Admincharges := ROUND(Admincharges, Pf."Rounding Amount", '<');
                                EmpShare := ROUND(EmpShare, Pf."Rounding Amount", '<');
                            end;

                    end;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));
            column(EPF; EPF)
            {
            }
            column(EmpShare; EmpShare)
            {
            }
            column(PFMonthNo__; PFMonthNo)
            {
            }
            column(PFYearGVar; PFYearGVar)
            {
            }
            column(PFMonthNo___Control1102154081; PFMonthNo)
            {
            }
            column(PFYear_Control1102154082; PFYearGVar)
            {
            }
            column(PD; PD)
            {
            }
            column(PM; PM)
            {
            }
            column(PY; PY)
            {
            }
            column(Admincharges; Admincharges)
            {
            }
            column(EdliCharges; EdliCharges)
            {
            }
            column(Total3; Total3)
            {
            }
            column(Admincharges_Control1102154089; Admincharges)
            {
            }
            column(EdliCharges_Control1102154090; EdliCharges)
            {
            }
            column(TotEmpPF; TotEmpPF)
            {
            }
            column(EmpShare_Control1102154092; EmpShare)
            {
            }
            column(Total2; Total2)
            {
            }
            column(Total; Total)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(EPS_Contribution; EPS)
            {
            }
            column(EPS; EPS)
            {
            }
            column(RIFACharges; RIFACharges)
            {
            }
            column(RIFACharges_Control1102154107; RIFACharges)
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(NoOFEmp; NoOFEmp)
            {
            }
            column(TempBasicAmt; TempBasicAmt)
            {
            }
            column(NoOFEmp_Control1102154114; NoOFEmp)
            {
            }
            column(NoOFEmp_Control1102154115; NoOFEmp)
            {
            }
            column(TempBasicAmt_Control1102154116; TempBasicAmt)
            {
            }
            column(TempBasicAmt_Control1102154117; TempBasicAmt)
            {
            }
            column(EMPLOYEES_PROVIDENT_FUND_ORGANISATIONCaption; EMPLOYEES_PROVIDENT_FUND_ORGANISATIONCaptionLbl)
            {
            }
            column(COMBINED_CHALLAN__A_C__NO___1__2__10__21_AND_22Caption; COMBINED_CHALLAN__A_C__NO___1__2__10__21_AND_22CaptionLbl)
            {
            }
            column(USE_SEPARATE_CHALLAN_FOR_EACH_MONTH_Caption; USE_SEPARATE_CHALLAN_FOR_EACH_MONTH_CaptionLbl)
            {
            }
            column(ESTABLISHMENT_CODE_NO___A_P_Caption; ESTABLISHMENT_CODE_NO___A_P_CaptionLbl)
            {
            }
            column(DUES_FOR_THE_MONTH_OF__Caption; DUES_FOR_THE_MONTH_OF__CaptionLbl)
            {
            }
            column(Employer_ShareCaption; Employer_ShareCaptionLbl)
            {
            }
            column(Employees_ShareCaption; Employees_ShareCaptionLbl)
            {
            }
            column(ACCOUNT_GROUP_NO___Caption; ACCOUNT_GROUP_NO___CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(DATE_OF_PAYMENTCaption; DATE_OF_PAYMENTCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154015; EmptyStringCaption_Control1102154015Lbl)
            {
            }
            column(A_C_1Caption; A_C_1CaptionLbl)
            {
            }
            column(Total_Wages_DueCaption; Total_Wages_DueCaptionLbl)
            {
            }
            column(Total_No__of_SubscribersCaption; Total_No__of_SubscribersCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154021; EmptyStringCaption_Control1102154021Lbl)
            {
            }
            column(A_C_10Caption; A_C_10CaptionLbl)
            {
            }
            column(PAID_BY_CHEQUE_CASHCaption; PAID_BY_CHEQUE_CASHCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154024; EmptyStringCaption_Control1102154024Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154026; EmptyStringCaption_Control1102154026Lbl)
            {
            }
            column(A_C_21Caption; A_C_21CaptionLbl)
            {
            }
            column(S_No_Caption; S_No_CaptionLbl)
            {
            }
            column(PARTICULARSCaption; PARTICULARSCaptionLbl)
            {
            }
            column(A_C__NO__1Caption; A_C__NO__1CaptionLbl)
            {
            }
            column(A_C__NO__2Caption; A_C__NO__2CaptionLbl)
            {
            }
            column(A_C__NO__10Caption; A_C__NO__10CaptionLbl)
            {
            }
            column(A_C__NO__21Caption; A_C__NO__21CaptionLbl)
            {
            }
            column(A_C__NO__22Caption; A_C__NO__22CaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(AMOUNT__In_Rupees_______Caption; AMOUNT__In_Rupees_______CaptionLbl)
            {
            }
            column(PART_01Caption; PART_01CaptionLbl)
            {
            }
            column(V1___________EMPLOYER_S_SHARE_OF_CONT_Caption; V1___________EMPLOYER_S_SHARE_OF_CONT_CaptionLbl)
            {
            }
            column(V2___________EMPLOYEES_SHARE_OF_CONT_Caption; V2___________EMPLOYEES_SHARE_OF_CONT_CaptionLbl)
            {
            }
            column(V3___________ADMIN_CHARGESCaption; V3___________ADMIN_CHARGESCaptionLbl)
            {
            }
            column(V4___________INSP__CHARGESCaption; V4___________INSP__CHARGESCaptionLbl)
            {
            }
            column(V5___________PENAL_DAMAGESCaption; V5___________PENAL_DAMAGESCaptionLbl)
            {
            }
            column(V6___________MISC__PAYMENTCaption; V6___________MISC__PAYMENTCaptionLbl)
            {
            }
            column(TOTALCaption_Control1102154056; TOTALCaption_Control1102154056Lbl)
            {
            }
            column(DataItem1102154057; Amount_in_words_Lbl)
            {
            }
            column(For_Banks_use_only_Caption; For_Banks_use_only_CaptionLbl)
            {
            }
            column(DataItem1102154059; NAME_OF_ESTABLISHMENT_CaptioLbl)
            {
            }
            column(ADDRESS__________________________________________________________________________________________________Caption; ADDRESS__________________________________________________________________________________________________CaptionLbl)
            {
            }
            column(NAME_OF_THE_DEPOSITOR_CaptionLbl; NAME_OF_THE_DEPOSITOR_CaptionLbl)
            {
            }
            column(DataItem1102154062; SIGNATURE_OF_THE_DEPOSITOR_CaptionLbl)
            {
            }
            column(Amount_Received_Rs_______________________________________Caption; Amount_Received_Rs_______________________________________CaptionLbl)
            {
            }
            column(For_Cheques_only______________________________________Caption; For_Cheques_only______________________________________CaptionLbl)
            {
            }
            column(Date_of_Presentation_______________________________________Caption; Date_of_Presentation_______________________________________CaptionLbl)
            {
            }
            column(Date_of_Realisation_______________________________________Caption; Date_of_Realisation_______________________________________CaptionLbl)
            {
            }
            column(Branch_Name______________________________________Caption; Branch_Name______________________________________CaptionLbl)
            {
            }
            column(Branch_Code_No______________________________________Caption; Branch_Code_No______________________________________CaptionLbl)
            {
            }
            column(TO_BE_FILLED__IN_BY_EMPLOYERCaption; TO_BE_FILLED__IN_BY_EMPLOYERCaptionLbl)
            {
            }
            column(NAME_OF_THE_BANK________________________________________________________________________________________Caption; NAME_OF_THE_BANK________________________________________________________________________________________CaptionLbl)
            {
            }
            column(CHEQUE_NO_____________________________________________________Caption; CHEQUE_NO_____________________________________________________CaptionLbl)
            {
            }
            column(DATE_____________________________________________________Caption; DATE_____________________________________________________CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154099; EmptyStringCaption_Control1102154099Lbl)
            {
            }
            column(YYYYCaption; YYYYCaptionLbl)
            {
            }
            column(MMCaption; MMCaptionLbl)
            {
            }
            column(DDCaption; DDCaptionLbl)
            {
            }
            column(MMCaption_Control1102154104; MMCaption_Control1102154104Lbl)
            {
            }
            column(YYYYCaption_Control1102154105; YYYYCaption_Control1102154105Lbl)
            {
            }
            column(Integer_Number; Number)
            {
            }

            trigger OnAfterGetRecord();
            begin
                DateOfPayment := 0D;
                EmpShare := EPS + EPF;
                Total3 := EPF + EmpShare;
                TotEmpPF := EPF + EPS;
                Total2 := Admincharges + EdliCharges + RIFACharges;
                Total := TotEmpPF + Total2 + EmpShare;
                Checkreport.InitTextVariable();
                Checkreport.FormatNoText(NumberText, ABS(Total), ' ');
                if DateOfPayment <> 0D then begin
                    PD := DATE2DMY(DateOfPayment, 1);
                    PM := DATE2DMY(DateOfPayment, 2);
                    PY := DATE2DMY(DateOfPayment, 3);
                end else begin
                    PD := 0;
                    PM := 0;
                    PY := 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PFMonth; PFMonthGVar)
                    {
                        ToolTip = 'Select the month for which PF Challan to be generated.';
                        Caption = 'Month';
                        OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
                        ApplicationArea = all;
                    }
                    field(PFYear; PFYearGVar)
                    {
                        ToolTip = 'Select the year for which PF challan to be generated.';
                        Caption = 'Year';
                        ApplicationArea = all;
                    }
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
        case PFMonthGVar of
            1:
                PFMonthNo := 1;
            2:
                PFMonthNo := 2;
            3:
                PFMonthNo := 3;
            4:
                PFMonthNo := 4;
            5:
                PFMonthNo := 5;
            6:
                PFMonthNo := 6;
            7:
                PFMonthNo := 7;
            8:
                PFMonthNo := 8;
            9:
                PFMonthNo := 9;
            10:
                PFMonthNo := 10;
            11:
                PFMonthNo := 11;
            12:
                PFMonthNo := 12;
        end;
    end;

    var
        CompanyInfo: Record "Company Information";
        ProcessedSalary: Record "Processed Salary B2B";
        PayRevisionLine: Record "Pay Revision Line B2B";
        Pf: Record PF_B2B;
        Employee: Record "Employee B2B";
        Checkreport: Report "Check Report B2B";
        DateOfPayment: Date;
        PFMonthGVar: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        NumberText: array[2] of Text[200];
        PFYearGVar: Integer;
        PFMonthNo: Integer;
        Admincharges: Decimal;
        EdliCharges: Decimal;
        Total3: Decimal;
        Total2: Decimal;
        Total: Decimal;
        TotEmpPF: Decimal;
        RIFACharges: Decimal;
        TempBasicAmt: Decimal;
        EPS: Decimal;
        EPF: Decimal;
        BasicAmt: Decimal;
        NoOFEmp: Integer;
        EmpShare: Decimal;
        PD: Integer;
        PM: Integer;
        PY: Integer;
        EMPLOYEES_PROVIDENT_FUND_ORGANISATIONCaptionLbl: Label 'EMPLOYEES PROVIDENT FUND ORGANISATION';
        COMBINED_CHALLAN__A_C__NO___1__2__10__21_AND_22CaptionLbl: Label 'COMBINED CHALLAN -A/C. NO.- 1, 2, 10, 21 AND 22';
        USE_SEPARATE_CHALLAN_FOR_EACH_MONTH_CaptionLbl: Label '(USE SEPARATE CHALLAN FOR EACH MONTH)';
        ESTABLISHMENT_CODE_NO___A_P_CaptionLbl: Label 'ESTABLISHMENT CODE NO : A.P.';
        DUES_FOR_THE_MONTH_OF__CaptionLbl: Label 'DUES FOR THE MONTH OF :';
        Employer_ShareCaptionLbl: Label 'Employer Share';
        Employees_ShareCaptionLbl: Label 'Employees Share';
        ACCOUNT_GROUP_NO___CaptionLbl: Label 'ACCOUNT GROUP NO. :';
        EmptyStringCaptionLbl: Label '.....................................';
        DATE_OF_PAYMENTCaptionLbl: Label 'DATE OF PAYMENT';
        EmptyStringCaption_Control1102154015Lbl: Label '{';
        A_C_1CaptionLbl: Label 'A/C 1';
        Total_Wages_DueCaptionLbl: Label 'Total Wages Due';
        Total_No__of_SubscribersCaptionLbl: Label 'Total No. of Subscribers';
        EmptyStringCaption_Control1102154021Lbl: Label '{';
        A_C_10CaptionLbl: Label 'A/C 10';
        PAID_BY_CHEQUE_CASHCaptionLbl: Label 'PAID BY CHEQUE/CASH';
        EmptyStringCaption_Control1102154024Lbl: Label '.....................................';
        EmptyStringCaption_Control1102154026Lbl: Label '{';
        A_C_21CaptionLbl: Label 'A/C 21';
        S_No_CaptionLbl: Label 'S.No.';
        PARTICULARSCaptionLbl: Label 'PARTICULARS';
        A_C__NO__1CaptionLbl: Label 'A/C. NO. 1';
        A_C__NO__2CaptionLbl: Label 'A/C. NO. 2';
        A_C__NO__10CaptionLbl: Label 'A/C. NO. 10';
        A_C__NO__21CaptionLbl: Label 'A/C. NO. 21';
        A_C__NO__22CaptionLbl: Label 'A/C. NO. 22';
        TOTALCaptionLbl: Label 'TOTAL';
        AMOUNT__In_Rupees_______CaptionLbl: Label '......AMOUNT (In Rupees)......';
        PART_01CaptionLbl: Label 'PART-01';
        V1___________EMPLOYER_S_SHARE_OF_CONT_CaptionLbl: Label '1.          EMPLOYER''S SHARE OF CONT.';
        V2___________EMPLOYEES_SHARE_OF_CONT_CaptionLbl: Label '2.          EMPLOYEES SHARE OF CONT.';
        V3___________ADMIN_CHARGESCaptionLbl: Label '3.          ADMIN CHARGES';
        V4___________INSP__CHARGESCaptionLbl: Label '4.          INSP. CHARGES';
        V5___________PENAL_DAMAGESCaptionLbl: Label '5.          PENAL DAMAGES';
        V6___________MISC__PAYMENTCaptionLbl: Label '6.          MISC. PAYMENT';
        TOTALCaption_Control1102154056Lbl: Label 'TOTAL';
        Amount_in_words_Lbl: Label '(Amount in words.....................................................................................................................................................only)';
        For_Banks_use_only_CaptionLbl: Label '(For Banks use only)';
        NAME_OF_ESTABLISHMENT_CaptioLbl: Label 'NAME OF ESTABLISHMENT..................................................................................................';
        ADDRESS__________________________________________________________________________________________________CaptionLbl: Label 'ADDRESS..................................................................................................';
        NAME_OF_THE_DEPOSITOR_CaptionLbl: Label 'NAME OF THE DEPOSITOR........................................................................................';
        SIGNATURE_OF_THE_DEPOSITOR_CaptionLbl: Label 'SIGNATURE OF THE DEPOSITOR........................................................................................';
        Amount_Received_Rs_______________________________________CaptionLbl: Label 'Amount Received Rs :.....................................';
        For_Cheques_only______________________________________CaptionLbl: Label 'For Cheques only :....................................';
        Date_of_Presentation_______________________________________CaptionLbl: Label 'Date of Presentation :.....................................';
        Date_of_Realisation_______________________________________CaptionLbl: Label 'Date of Realisation :.....................................';
        Branch_Name______________________________________CaptionLbl: Label 'Branch Name:.....................................';
        Branch_Code_No______________________________________CaptionLbl: Label 'Branch Code No:.....................................';
        TO_BE_FILLED__IN_BY_EMPLOYERCaptionLbl: Label 'TO BE FILLED  IN BY EMPLOYER';
        NAME_OF_THE_BANK________________________________________________________________________________________CaptionLbl: Label 'NAME OF THE BANK........................................................................................';
        CHEQUE_NO_____________________________________________________CaptionLbl: Label 'CHEQUE NO.....................................................';
        DATE_____________________________________________________CaptionLbl: Label 'DATE.....................................................';
        EmptyStringCaption_Control1102154099Lbl: Label ')';
        YYYYCaptionLbl: Label 'YYYY';
        MMCaptionLbl: Label 'MM';
        DDCaptionLbl: Label 'DD';
        MMCaption_Control1102154104Lbl: Label 'MM';
        YYYYCaption_Control1102154105Lbl: Label 'YYYY';
        PFTextTxt: Label 'PF';
        BASICTextTxt: Label 'BASIC';
        FDATextTxt: Label 'FDA';
        DATextTxt: Label 'DA';
        VDATextTxt: Label 'VDA';
        stipendTextTxt: Label 'stipend';
}

