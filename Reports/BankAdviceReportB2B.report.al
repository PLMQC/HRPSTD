report 33001234 "Bank Advice Report B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Bank Advice Report.rdl';
    Caption = 'Bank Advice Report';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("Bank Name", "Payment Method") ORDER(Ascending);
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(Statement_of_Credit_To_Savings_Bank_Accounts_for_the_month_of___MonthName; 'Statement of Credit To Savings Bank Accounts for the month of ' + MonthName)
            {
            }
            column(Year; YearGVar)
            {
            }
            column(Employee_B2B__Bank_Name_; "Bank Name")
            {
            }
            column(Employee_B2B__Payment_Method__Control1102152024; "Payment Method")
            {
            }
            column(Employee_B2B__No__; "Employee B2B"."No.")
            {
            }
            column(Employee_B2B__First_Name__Employee_B2B__Middle_Name__Employee_B2B__Last_Name_; "Employee B2B"."First Name" + "Employee B2B"."Middle Name" + "Employee B2B"."Last Name")
            {
            }
            column(Employee_B2B__Account_No_; "Account No")
            {
            }
            column(Netamt; Netamt)
            {
            }
            column(MonthExp; MonthExp)
            {
            }
            column(CreditedAMt; CreditedAMt)
            {
            }
            column(SerialNo; SerialNo)
            {
            }
            column(Employee_B2B__Payment_Method_; "Payment Method")
            {
            }
            column(TotalNetAmt; TotalNetAmt)
            {
            }
            column(TotalMonthExp; TotalMonthExp)
            {
            }
            column(TotalCreditedAmt; TotalCreditedAmt)
            {
            }
            column(Emp_No_Caption; Emp_No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Acc_No_Caption; Acc_No_CaptionLbl)
            {
            }
            column(Net_amt_Payable_for_bank_advice_reportCaption; Net_amt_Payable_for_bank_advice_reportCaptionLbl)
            {
            }
            column(Monthly_ExpCaption; Monthly_ExpCaptionLbl)
            {
            }
            column(Accounts_to_be_CreditedCaption; Accounts_to_be_CreditedCaptionLbl)
            {
            }
            column(Sl_No_Caption; Sl_No_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(ComName; ComName)
            { }

            trigger OnAfterGetRecord();
            begin
                Clear(MonthExp);
                SerialNo := SerialNo + 1;
                MonAtt.RESET();
                MonAtt.SETRANGE("Employee Code", "Employee B2B"."No.");
                MonAtt.SETRANGE(MonAtt."Pay Slip Month", MonthGVar);
                MonAtt.SETRANGE(Year, YearGVar);
                if MonAtt.FINDFIRST() then
                    Netamt := MonAtt."Net Salary";

                PayRevisionLine.SETRANGE("No.", "Employee B2B"."No.");
                PayRevisionLine.SETRANGE(Month, MonthGVar);
                PayRevisionLine.SETRANGE(Year, YearGVar);
                if PayRevisionLine.FINDFIRST() then
                    repeat
                        Netamt += PayRevisionLine."Arrear Amount";
                    until PayRevisionLine.NEXT() = 0;

                commInfo.Get();
                ComName := commInfo.Name;

                salAdj.Reset();
                salAdj.SetRange("Employee No", "No.");
                salAdj.SetRange(Month, MonthGVar);
                salAdj.SetRange(Year, YearGVar);
                if salAdj.FindSet() then begin
                    salAdj.CalcSums(Amount);
                    MonthExp := salAdj.Amount;

                end;

                CreditedAMt := Netamt + MonthExp;
                TotalCreditedAmt := CreditedAMt;
                TotalMonthExp := MonthExp;
                TotalNetAmt += Netamt;

            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                SETRANGE(Blocked, false);
                TotalNetAmt := 0;
                TotalMonthExp := 0;
                TotalCreditedAmt := 0;
                case MonthGVar of
                    1:
                        MonthName := JanuaryTxt;
                    2:
                        MonthName := FebruaryTxt;
                    3:
                        MonthName := MarchTxt;
                    4:
                        MonthName := AprilTxt;
                    5:
                        MonthName := MayTxt;
                    6:
                        MonthName := JuneTxt;
                    7:
                        MonthName := JulyTxt;
                    8:
                        MonthName := AugustTxt;
                    9:
                        MonthName := SeptemberTxt;
                    10:
                        MonthName := OctoberTxt;
                    11:
                        MonthName := NovemberTxt;
                    12:
                        MonthName := DecemberTxt;
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
                field(Month; MonthGVar)
                {
                    ToolTip = 'Enter the month for which you want generate.';
                    Caption = 'Month';
                    ApplicationArea = all;
                }
                field(Year; YearGVar)
                {
                    ToolTip = 'Enter the year for which you want to generate.';
                    Caption = 'Year';
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
    trigger OnInitReport()
    begin
        MonthExp := 0;
    end;

    var
        salAdj: Record "Salary Adjustment B2B";
        commInfo: Record "Company Information";
        ComName: text[100];
        MonAtt: Record "Monthly Attendance B2B";
        PayRevisionLine: Record "Pay Revision Line B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Netamt: Decimal;
        MonthGVar: Integer;
        YearGVar: Integer;
        MonthExp: Decimal;
        CreditedAMt: Decimal;
        MonthName: Text[30];
        SerialNo: Integer;
        TotalNetAmt: Decimal;
        TotalMonthExp: Decimal;
        TotalCreditedAmt: Decimal;


        Emp_No_CaptionLbl: Label 'Emp No.';
        NameCaptionLbl: Label 'Name';
        Acc_No_CaptionLbl: Label 'Acc No.';
        Net_amt_Payable_for_bank_advice_reportCaptionLbl: Label 'Net amt Payable for bank advice report';
        Monthly_ExpCaptionLbl: Label 'Monthly Exp';
        Accounts_to_be_CreditedCaptionLbl: Label 'Accounts to be Credited';
        Sl_No_CaptionLbl: Label 'Sl No.';
        TotalCaptionLbl: Label 'Total';
        JanuaryTxt: Label 'January';
        FebruaryTxt: Label 'February';
        MarchTxt: Label 'March';
        AprilTxt: Label 'April';
        MayTxt: Label 'May';
        JuneTxt: Label 'June';
        JulyTxt: Label 'July';
        AugustTxt: Label 'August';
        SeptemberTxt: Label 'September';
        OctoberTxt: Label 'October';
        NovemberTxt: Label 'November';
        DecemberTxt: Label 'December';
}

