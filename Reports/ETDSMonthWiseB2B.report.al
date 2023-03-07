report 33001267 "E TDS Month Wise B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\E TDS Month Wise.rdl';
    Caption = 'E TDS Month Wise';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("EMP TDS Monthly Schedule"; "EMP TDS Monthly Schedule B2B")
        {
            // DataItemTableView = SORTING("Emp ID", "Payslip Month", "Payslip Year", "Financial Year Start Date") WHERE("TDS Amount" = FILTER(<> 0));
            RequestFilterFields = "Emp ID", "Payslip Month", "Payslip Year";
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(DataItem1102152019; FORMAT('E-TDS for the') + ' ' + FORMAT(FilterTypeGVar) + ' ' + FORMAT('of') + ' ' + FORMAT(Month) + '-' + FORMAT("Payslip Year"))
            {
            }
            column(EMP_TDS_Monthly_Schedule__Emp_ID_; "Emp ID")
            {
            }
            column(EMP_TDS_Monthly_Schedule__EMP_TDS_Monthly_Schedule___Financial_Year_Start_Date_; "EMP TDS Monthly Schedule"."Financial Year Start Date")
            {
            }
            column(EMP_TDS_Monthly_Schedule__TDS_Amount_; "TDS Amount")
            {
            }
            column(Sno; Sno)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(EmpPan; EmpPan)
            {
            }
            column(EmpGross; EmpGross)
            {
            }
            column(EmpTds; EmpTds)
            {
            }
            column(EmpEcess; EmpEcess)
            {
            }
            column(EMP_TDS_Monthly_Schedule__TDS_Amount__Control1102152023; "TDS Amount")
            {
            }
            column(EmpGross_Control1102152027; EmpGross)
            {
            }
            column(EmpTds_Control1102152028; EmpTds)
            {
            }
            column(EmpEcess_Control1102152029; EmpEcess)
            {
            }
            column(S_NoCaption; S_NoCaptionLbl)
            {
            }
            column(EMP_TDS_Monthly_Schedule__Emp_ID_Caption; FIELDCAPTION("Emp ID"))
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(PAN_No_Caption; PAN_No_CaptionLbl)
            {
            }
            column(Paid_DateCaption; Paid_DateCaptionLbl)
            {
            }
            column(SalaryCaption; SalaryCaptionLbl)
            {
            }
            column(TDSCaption; TDSCaptionLbl)
            {
            }
            column(Edu_CessCaption; Edu_CessCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(EMP_TDS_Monthly_Schedule_Payslip_Month; "Payslip Month")
            {
            }
            column(EMP_TDS_Monthly_Schedule_Payslip_Year; "Payslip Year")
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(EmpName);
                CLEAR(EmpPan);
                CLEAR(EmpGross);
                CLEAR(EmpTds);
                CLEAR(EmpEcess);

                EmpGrec.GET("Emp ID");
                EmpName := EmpGrec."First Name" + ' ' + EmpGrec."Last Name";
                EmpPan := EmpGrec."PAN No";

                ProcSalGRec.RESET();
                ProcSalGRec.SETRANGE("Employee Code", "Emp ID");
                ProcSalGRec.SETRANGE("Pay Slip Month", "Payslip Month");
                ProcSalGRec.SETRANGE(Year, "Payslip Year");
                ProcSalGRec.SETRANGE("Add/Deduct", ProcSalGRec."Add/Deduct"::Addition);
                if ProcSalGRec.FINDFIRST() then
                    repeat
                        EmpGross += ProcSalGRec."Earned Amount";
                    until ProcSalGRec.NEXT() = 0;

                EmpTds := ("TDS Amount" * 100) / 103;
                EmpTds := ROUND(EmpTds, 1, '=');
                EmpEcess := "TDS Amount" - EmpTds;

                if "TDS Amount" = 0 then
                    CurrReport.SKIP();
                Sno += 1;
            end;

            trigger OnPreDataItem();
            begin
                CompInfo.get();
                CompInfo.CALCFIELDS(Picture);

                if FilterTypeGVar = FilterTypeGVar::Month then
                    if (FliterValueGVar <> 0) and not (FliterValueGVar > 12) then begin
                        SETRANGE("Payslip Month", FliterValueGVar);
                        SETRANGE("Payslip Year", YearGvar);
                        case FliterValueGVar of
                            1:
                                Month := JanuaryTxt;
                            2:
                                Month := FebruaryTxt;
                            3:
                                Month := MarchTxt;
                            4:
                                Month := AprilTxt;
                            5:
                                Month := MayTxt;
                            6:
                                Month := JuneTxt;
                            7:
                                Month := JulyTxt;
                            8:
                                Month := AugustTxt;
                            9:
                                Month := SeptemberTxt;
                            10:
                                Month := OctoberTxt;
                            11:
                                Month := NovemberTxt;
                            12:
                                Month := DecemberTxt;
                            else
                                ERROR(Text001Txt);
                        end;
                    end
                    else
                        if FilterTypeGVar = FilterTypeGVar::Quarter then begin
                            if (FliterValueGVar <> 0) and (FliterValueGVar = 1) then begin
                                SETFILTER("Payslip Month", Text0013Txt);
                                SETRANGE("Payslip Year", DATE2DMY(WORKDATE(), 3));
                            end else
                                if (FliterValueGVar <> 0) and (FliterValueGVar = 2) then begin
                                    SETFILTER("Payslip Month", Text0014Txt);
                                    SETRANGE("Payslip Year", YearGvar);
                                end else
                                    if (FliterValueGVar <> 0) and (FliterValueGVar = 3) then begin
                                        SETFILTER("Payslip Month", Text0015Txt);
                                        SETRANGE("Payslip Year", YearGvar);
                                    end else
                                        if (FliterValueGVar <> 0) and (FliterValueGVar = 4) then begin
                                            TDSSalaryDetailsRec.SETFILTER(Month, Text0016Txt);
                                            TDSSalaryDetailsRec.SETRANGE(Year, YearGvar);
                                        end else
                                            ERROR(Text002Txt);
                        end else
                            if FilterTypeGVar = FilterTypeGVar::Year then
                                if FliterValueGVar <> 0 then
                                    SETRANGE("Payslip Year", YearGvar)
                                else
                                    ERROR(Text003Txt);



            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control2)
                {
                    field(FilterType; FilterTypeGVar)
                    {
                        ToolTip = 'Choose Filter Type as Month,quarter,year.';
                        Caption = 'FilterType';
                        OptionCaption = 'Month,Quarter,Year';
                        ApplicationArea = all;
                    }
                    field(FliterValue; FliterValueGVar)
                    {
                        ToolTip = 'Enter the Month in filter value.';
                        Caption = 'FliterValue';
                        ApplicationArea = all;
                    }
                    field(YearGvar; YearGvar)
                    {
                        ToolTip = 'Enter the year in filter value.';
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

    var
        CompInfo: Record "Company Information";
        TDSSalaryDetailsRec: Record "TDS Salary Details B2B";
        ProcSalGRec: Record "Processed Salary B2B";
        EmpGrec: Record "Employee B2B";
        Sno: Integer;
        EmpName: Text;
        EmpPan: Code[20];
        EmpGross: Decimal;
        EmpTds: Decimal;
        EmpEcess: Decimal;
        FilterTypeGVar: Option Month,Quarter,Year;
        FliterValueGVar: Integer;
        YearGvar: Integer;
        Month: Text[30];
        S_NoCaptionLbl: Label 'S.No';
        Employee_NameCaptionLbl: Label 'Employee Name';
        PAN_No_CaptionLbl: Label 'PAN No.';
        Paid_DateCaptionLbl: Label 'Paid Date';
        SalaryCaptionLbl: Label 'Salary';
        TDSCaptionLbl: Label 'TDS';
        Edu_CessCaptionLbl: Label 'Edu.Cess';
        TotalCaptionLbl: Label 'Total';
        Text001Txt: Label 'Filter Value Should Not be Zero or Grater than 12';
        Text002Txt: Label 'Filter Value Should Not be Zero or Grater than 4';
        Text003Txt: Label 'Filter Value Should Not Be 0';
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
        Text0013Txt: Label '4|5|6';
        Text0014Txt: Label '7|8|9';
        Text0015Txt: Label '10|11|12';
        Text0016Txt: Label '1|2|3';
}

