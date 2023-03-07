report 33001275 "Employee Count Report B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Employee Count Report.rdlc';
    Caption = 'Employee Count Report';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Lookup_B2B; Lookup_B2B)
        {
            DataItemTableView = SORTING("Lookup Id", "Lookup Name", "Lookup Type") WHERE("Lookup Type" = CONST(4));
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Data_showing_no__of_employees_joined___left_between___FORMAT_FromDate_0_4____to___FORMAT_ToDate_0_4_; 'Data showing no. of employees joined & left between ' + FORMAT(FromDate, 0, 4) + ' to ' + FORMAT(ToDate, 0, 4))
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(USERID; USERID())
            {
            }
            column(Strengths_as_on___FORMAT_ToDate_0_4_; 'Strengths as on ' + FORMAT(ToDate, 0, 4))
            {
            }
            column(Emp__Joined_between___FORMAT_FromDate_0_4____to___FORMAT_ToDate_0_4_; 'Emp. Joined between ' + FORMAT(FromDate, 0, 4) + ' to ' + FORMAT(ToDate, 0, 4))
            {
            }
            column(Employess_Left_between___FORMAT_FromDate_0_4____to___FORMAT_ToDate_0_4_; 'Employess Left between ' + FORMAT(FromDate, 0, 4) + ' to ' + FORMAT(ToDate, 0, 4))
            {
            }
            column(Emp__Joined___Left_before_completing_1_year_; 'Emp. Joined & Left before completing 1 year')
            {
            }
            column(Lookup__Lookup_Name_; "Lookup Name")
            {
            }
            column(SNo; SNo)
            {
            }
            column(EmpStrength; EmpStrength)
            {
            }
            column(EmpJoined; EmpJoined)
            {
            }
            column(EmpLeft; EmpLeft)
            {
            }
            column(EmpJoinedLeft; EmpJoinedLeft)
            {
            }
            column(EmpStrengthTotal; EmpStrengthTotal)
            {
            }
            column(EmpJoinedTotal; EmpJoinedTotal)
            {
            }
            column(EmpLeftTotal; EmpLeftTotal)
            {
            }
            column(EmpJoinedLefttotal; EmpJoinedLefttotal)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(S_No_Caption; S_No_CaptionLbl)
            {
            }
            column(DivisionsCaption; DivisionsCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Lookup_Lookup_Id; "Lookup Id")
            {
            }
            column(Lookup_Lookup_Type; "Lookup Type")
            {
            }

            trigger OnAfterGetRecord();
            begin
                SNo += 1;
                CLEAR(EmpStrength);
                CLEAR(EmpJoined);
                CLEAR(EmpLeft);
                CLEAR(EmpJoinedLeft);
                Employee.RESET();
                Employee.SETRANGE("Department Code", "Lookup Name");
                Employee.SETRANGE(Blocked, false);
                if Employee.FINDSET() then begin
                    EmpStrength := Employee.COUNT();
                    EmpStrengthTotal += Employee.COUNT();
                end;

                Employee.RESET();
                Employee.SETRANGE("Department Code", "Lookup Name");
                Employee.SETRANGE("Employment Date", FromDate, ToDate);
                if Employee.FINDSET() then begin
                    EmpJoined := Employee.COUNT();
                    EmpJoinedTotal += Employee.COUNT();
                end;

                Employee.RESET();
                Employee.SETRANGE("Department Code", "Lookup Name");
                Employee.SETRANGE("Resignation Date", FromDate, ToDate);
                Employee.SETRANGE(Blocked, true);
                if Employee.FINDSET() then begin
                    EmpLeft := Employee.COUNT();
                    EmpLeftTotal += Employee.COUNT();
                end;

                Employee.RESET();
                Employee.SETRANGE("Department Code", "Lookup Name");
                Employee.SETRANGE("Employment Date", FromDate, ToDate);
                Employee.SETRANGE("Resignation Date", FromDate, ToDate);
                Employee.SETRANGE(Blocked, true);
                if Employee.FINDSET() then begin
                    EmpJoinedLeft := Employee.COUNT();
                    EmpJoinedLefttotal += Employee.COUNT();
                end;
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

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("From Date"; FromDate)
                    {
                        ToolTip = 'Choose the From date.';
                        Caption = 'From Date';
                        ApplicationArea = all;
                    }
                    field("To Date"; ToDate)
                    {
                        ToolTip = 'Choose To Date.';
                        Caption = 'To Date';
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
        SNo := 0;
    end;

    var
        Employee: Record "Employee B2B";
        CompanyInfo: Record "Company Information";
        FromDate: Date;
        ToDate: Date;
        SNo: Integer;
        EmpStrength: Integer;
        EmpJoined: Integer;
        EmpLeft: Integer;
        EmpJoinedLeft: Integer;
        EmpStrengthTotal: Integer;
        EmpJoinedTotal: Integer;
        EmpLeftTotal: Integer;
        EmpJoinedLefttotal: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        S_No_CaptionLbl: Label 'S.No.';
        DivisionsCaptionLbl: Label 'Divisions';
        TotalCaptionLbl: Label 'Total';
}

