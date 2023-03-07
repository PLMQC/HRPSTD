report 33001303 "E TDS Salary B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\E TDS Salary.rdl';
    Caption = 'E TDS Salary';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("TDS Salary Details"; "TDS Salary Details B2B")
        {
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(TDS_Salary_Details__Employee_Code_; "Employee Code")
            {
            }
            column(TDS_Salary_Details__TDS_Payment_Date_; "TDS Payment Date")
            {
            }
            column(TDS_Salary_Details__TDS_Amount_Paid_; "TDS Amount Paid")
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
            column(E_TDSCaption; E_TDSCaptionLbl)
            {
            }
            column(S_NoCaption; S_NoCaptionLbl)
            {
            }
            column(TDS_Salary_Details__Employee_Code_Caption; FIELDCAPTION("Employee Code"))
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
            column(TDS_Salary_Details_Month; Month)
            {
            }
            column(TDS_Salary_Details_Year; Year)
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(EmpName);
                CLEAR(EmpPan);
                CLEAR(EmpGross);
                CLEAR(EmpTds);
                CLEAR(EmpEcess);

                EmpGrec.GET("TDS Salary Details"."Employee Code");
                EmpName := EmpGrec."First Name" + ' ' + EmpGrec."Last Name";
                EmpPan := EmpGrec."PAN No";

                ProcSalGRec.RESET();
                ProcSalGRec.SETRANGE("Employee Code", "TDS Salary Details"."Employee Code");
                ProcSalGRec.SETRANGE("Pay Slip Month", "TDS Salary Details".Month);
                ProcSalGRec.SETRANGE(Year, "TDS Salary Details".Year);
                ProcSalGRec.SETRANGE("Add/Deduct", ProcSalGRec."Add/Deduct"::Addition);
                if ProcSalGRec.FINDFIRST() then
                    repeat
                        EmpGross += ProcSalGRec."Earned Amount";
                    until ProcSalGRec.NEXT() = 0;

                EmpTds := ("TDS Salary Details"."TDS Amount Paid" * 100) / 103;
                EmpEcess := "TDS Salary Details"."TDS Amount Paid" - EmpTds;
            end;

            trigger OnPreDataItem();
            begin
                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);
                case FilterType of
                    FilterType::Month:
                        if (FliterValue <> 0) and not (FliterValue > 12) then begin
                            "TDS Salary Details".SETRANGE(Month, FliterValue);
                            "TDS Salary Details".SETRANGE(Year, YearGvar);
                        end else
                            ERROR(Text001Txt);
                    FilterType::Quarter:
                        if (FliterValue <> 0) and (FliterValue = 1) then begin
                            "TDS Salary Details".SETFILTER(Month, Text004Txt);
                            "TDS Salary Details".SETRANGE(Year, YearGvar);
                        end else
                            if (FliterValue <> 0) and (FliterValue = 2) then begin
                                "TDS Salary Details".SETFILTER(Month, Text005Txt);
                                "TDS Salary Details".SETRANGE(Year, YearGvar);
                            end else
                                if (FliterValue <> 0) and (FliterValue = 3) then begin
                                    "TDS Salary Details".SETFILTER(Month, Text006Txt);
                                    "TDS Salary Details".SETRANGE(Year, YearGvar);
                                end else
                                    if (FliterValue <> 0) and (FliterValue = 4) then begin
                                        "TDS Salary Details".SETFILTER(Month, Text007Txt);
                                        "TDS Salary Details".SETRANGE(Year, YearGvar);
                                    end else
                                        ERROR(Text002Txt);
                    FilterType::Year:
                        if FliterValue <> 0 then
                            "TDS Salary Details".SETRANGE(Year, YearGvar)
                        else
                            ERROR(Text003Txt);

                end;
            end;
        }

    }

    requestpage
    {
        Caption = 'E TDS Salary';

        layout
        {
            area(content)
            {
                group(General)
                {
                    field(FilterType; FilterType)
                    {
                        ToolTip = 'Choose Filter Type as Month,quarter,year.';
                        Caption = 'FilterType';
                        OptionCaption = 'Month,Quarter,Year';
                        ApplicationArea = all;
                    }
                    field(FliterValue; FliterValue)
                    {
                        ToolTip = 'Enter the Month in filter value.';
                        Caption = 'FliterValue';
                        ApplicationArea = all;
                    }
                    field(YearGvar; YearGvar)
                    {
                        ToolTip = 'Enter the Year in filter value.';
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
    trigger OnInitReport()
    begin
        FliterValue := 0;
        YearGvar := 0;
    end;

    var
        CompInfo: Record "Company Information";
        ProcSalGRec: Record "Processed Salary B2B";
        EmpGrec: Record "Employee B2B";
        Sno: Integer;
        EmpName: Text;
        EmpPan: Code[20];
        EmpGross: Decimal;
        EmpTds: Decimal;
        EmpEcess: Decimal;
        FilterType: Option Month,Quarter,Year;
        FliterValue: Integer;
        YearGvar: Integer;
        E_TDSCaptionLbl: Label 'E-TDS';
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
        Text004Txt: Label '4|5|6';
        Text005Txt: Label '7|8|9';
        Text006Txt: Label '10|11|12';
        Text007Txt: Label '1|2|3';
}

