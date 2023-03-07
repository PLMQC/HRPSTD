report 33001204 "Monthly Attendance Details B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Monthly Attendance Details.rdl';
    Caption = 'Monthly Attendance Details';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Monthly Attendance"; "Monthly Attendance B2B")
        {
            RequestFilterFields = "Pay Slip Month";
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(Monthly_Attendance_Details_for_the_month_of_____MonthName; 'Monthly Attendance Details for the month of  ' + MonthName)
            {
            }
            column(Monthly_Attendance__Employee_Code_; "Employee Code")
            {
            }
            column(Monthly_Attendance__Employee_Name_; "Employee Name")
            {
            }
            column(Monthly_Attendance_Leaves; Leaves)
            {
            }
            column(Monthly_Attendance_Attendance; Attendance)
            {
            }
            column(Monthly_Attendance_Holidays; Holidays)
            {
            }
            column(Monthly_Attendance__Monthly_Attendance___Loss_Of_Pay_; "Monthly Attendance"."Loss Of Pay")
            {
            }
            column(Monthly_Attendance__Monthly_Attendance___Over_Time_Hrs_; "Monthly Attendance"."Over Time Hrs")
            {
            }
            column(Monthly_Attendance__Gross_Salary_; "Gross Salary")
            {
            }
            column(Monthly_Attendance_Deductions; Deductions)
            {
            }
            column(Monthly_Attendance__Net_Salary_; "Net Salary")
            {
            }
            column(Emp_CodeCaption; Emp_CodeCaptionLbl)
            {
            }
            column(Emp_NameCaption; Emp_NameCaptionLbl)
            {
            }
            column(Monthly_Attendance_LeavesCaption; FIELDCAPTION(Leaves))
            {
            }
            column(Monthly_Attendance_AttendanceCaption; FIELDCAPTION(Attendance))
            {
            }
            column(Monthly_Attendance_HolidaysCaption; FIELDCAPTION(Holidays))
            {
            }
            column(LOPCaption; LOPCaptionLbl)
            {
            }
            column(OTCaption; OTCaptionLbl)
            {
            }
            column(Monthly_Attendance__Gross_Salary_Caption; FIELDCAPTION("Gross Salary"))
            {
            }
            column(Monthly_Attendance_DeductionsCaption; FIELDCAPTION(Deductions))
            {
            }
            column(Monthly_Attendance__Net_Salary_Caption; FIELDCAPTION("Net Salary"))
            {
            }
            column(Monthly_Attendance_Pay_Slip_Month; "Pay Slip Month")
            {
            }
            column(Monthly_Attendance_Year; Year)
            {
            }
            column(Monthly_Attendance_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                case "Pay Slip Month" of
                    1:
                        MonthName := JanuaryTextTxt;
                    2:
                        MonthName := FebruaryTextTxt;
                    3:
                        MonthName := MarchTextTxt;
                    4:
                        MonthName := AprilTextTxt;
                    5:
                        MonthName := MayTextTxt;
                    6:
                        MonthName := JuneTextTxt;
                    7:
                        MonthName := JulyTextTxt;
                    8:
                        MonthName := AugustTextTxt;
                    9:
                        MonthName := SeptemberTextTxt;
                    10:
                        MonthName := OctoberTextTxt;
                    11:
                        MonthName := NovemberTextTxt;
                    12:
                        MonthName := DecemberTextTxt;
                end;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Monthly Attendance Details';

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

    var
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        MonthName: Text[50];

        Emp_CodeCaptionLbl: Label 'Emp Code';
        Emp_NameCaptionLbl: Label 'Emp Name';
        LOPCaptionLbl: Label 'LOP';
        OTCaptionLbl: Label 'OT';
        JanuaryTextTxt: Label 'January';
        FebruaryTextTxt: Label 'February';
        MarchTextTxt: Label 'March';
        AprilTextTxt: Label 'April';
        MayTextTxt: Label 'May';
        JuneTextTxt: Label 'June';
        JulyTextTxt: Label 'July';
        AugustTextTxt: Label 'August';
        SeptemberTextTxt: Label 'September';
        OctoberTextTxt: Label 'October';
        NovemberTextTxt: Label 'November';
        DecemberTextTxt: Label 'December';
}

