report 33001265 "FSF Att Report B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\FSF Att Report.rdlc';
    Caption = 'FSF Att Report';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Monthly Attendance"; "Monthly Attendance B2B")
        {
            DataItemTableView = SORTING ("Employee Code", "Pay Slip Month", Year, "Line No.");
            RequestFilterFields = "Employee Code";
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City__________CompanyInfo__Post_Code_; CompanyInfo.City + ' - ' + CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_Address_________CompanyInfo__Address_2__; CompanyInfo.Address + ' ' + CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Monthly_Attendance__Employee_Code_; "Employee Code")
            {
            }
            column(Monthly_Attendance__Loss_Of_Pay_; "Loss Of Pay")
            {
            }
            column(Monthly_Attendance_Leaves; Leaves)
            {
            }
            column(Monthly_Attendance_Holidays; Holidays)
            {
            }
            column(PhyPresentDays; PhyPresentDays)
            {
            }
            column(month2_______FORMAT_Year_; month2 + ' - ' + FORMAT(Year))
            {
            }
            column(PhyPresentDays2; PhyPresentDays2)
            {
            }
            column(Holidays2; Holidays2)
            {
            }
            column(LOP2; LOP2)
            {
            }
            column(Leaves2; Leaves2)
            {
            }
            column(Monthly_Attendance__Employee_Code_Caption; FIELDCAPTION("Employee Code"))
            {
            }
            column(Physical_DaysCaption; Physical_DaysCaptionLbl)
            {
            }
            column(Month_YearCaption; Month_YearCaptionLbl)
            {
            }
            column(HolidaysCaption; HolidaysCaptionLbl)
            {
            }
            column(LeavesCaption; LeavesCaptionLbl)
            {
            }
            column(AbsentsCaption; AbsentsCaptionLbl)
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
                CLEAR(PhyPresentDays);
                "Monthly Attendance".CALCFIELDS("Loss Of Pay", Holidays, Leaves);
                PhyPresentDays := 26 - "Loss Of Pay" - Leaves - Holidays;
                PhyPresentDays2 += PhyPresentDays;
                Holidays2 += Holidays;
                Leaves2 += Leaves;
                LOP2 += "Loss Of Pay";

                case "Pay Slip Month" of
                    1:
                        month2 := JanuaryTxt;
                    2:
                        month2 := FebruaryTxt;
                    3:
                        month2 := MarchTxt;
                    4:
                        month2 := AprilTxt;
                    5:
                        month2 := MayTxt;
                    6:
                        month2 := JuneTxt;
                    7:
                        month2 := JulyTxt;
                    8:
                        month2 := AugustTxt;
                    9:
                        month2 := SeptemberTxt;
                    10:
                        month2 := OctoberTxt;
                    11:
                        month2 := NovemberTxt;
                    12:
                        month2 := DecemberTxt;
                end;
            end;



            trigger OnPreDataItem();
            begin
                SETRANGE(Year, NewYear - 1);
                CompanyInfo.get();
                CompanyInfo.CALCFIELDS(Picture);
            end;
        }
        dataitem("Monthly AttendanceN"; "Monthly Attendance B2B")
        {
            DataItemTableView = SORTING ("Employee Code", "Pay Slip Month", Year);
            column(Monthly_AttendanceN__Loss_Of_Pay_; "Loss Of Pay")
            {
            }
            column(Monthly_AttendanceN_Leaves; Leaves)
            {
            }
            column(Monthly_AttendanceN_Holidays; Holidays)
            {
            }
            column(PhyPresentDays_Control1000000008; PhyPresentDays)
            {
            }
            column(month2_______FORMAT_Year__Control1000000009; month2 + ' - ' + FORMAT(Year))
            {
            }
            column(PhyPresentDays2_Control1000000015; PhyPresentDays2)
            {
            }
            column(Holidays2_Control1000000016; Holidays2)
            {
            }
            column(LOP2_Control1000000017; LOP2)
            {
            }
            column(Leaves2_Control1000000018; Leaves2)
            {
            }
            column(Physical_DaysCaption_Control1000000027; Physical_DaysCaption_Control1000000027Lbl)
            {
            }
            column(Month_YearCaption_Control1000000028; Month_YearCaption_Control1000000028Lbl)
            {
            }
            column(HolidaysCaption_Control1000000029; HolidaysCaption_Control1000000029Lbl)
            {
            }
            column(LeavesCaption_Control1000000030; LeavesCaption_Control1000000030Lbl)
            {
            }
            column(AbsentsCaption_Control1000000031; AbsentsCaption_Control1000000031Lbl)
            {
            }
            column(Monthly_AttendanceN_Employee_Code; "Employee Code")
            {
            }
            column(Monthly_AttendanceN_Pay_Slip_Month; "Pay Slip Month")
            {
            }
            column(Monthly_AttendanceN_Year; Year)
            {
            }
            column(Monthly_AttendanceN_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                if NewMonth < "Monthly AttendanceN"."Pay Slip Month" then
                    CurrReport.SKIP();
                CLEAR(PhyPresentDays);
                "Monthly Attendance".CALCFIELDS("Loss Of Pay", Holidays, Leaves);
                PhyPresentDays := 26 - "Loss Of Pay" - Leaves - Holidays;
                PhyPresentDays2 += PhyPresentDays;
                Holidays2 += Holidays;
                Leaves2 += Leaves;
                LOP2 += "Loss Of Pay";

                case "Pay Slip Month" of
                    1:
                        month2 := JanuaryTxt;
                    2:
                        month2 := FebruaryTxt;
                    3:
                        month2 := MarchTxt;
                    4:
                        month2 := AprilTxt;
                    5:
                        month2 := MayTxt;
                    6:
                        month2 := JuneTxt;
                    7:
                        month2 := JulyTxt;
                    8:
                        month2 := AugustTxt;
                    9:
                        month2 := SeptemberTxt;
                    10:
                        month2 := OctoberTxt;
                    11:
                        month2 := NovemberTxt;
                    12:
                        month2 := DecemberTxt;
                end;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Employee Code", "Monthly Attendance"."Employee Code");
                SETRANGE(Year, NewYear);
                CLEAR(PhyPresentDays);
                CLEAR(PhyPresentDays2);
                CLEAR(Holidays2);
                CLEAR(Leaves2);
                CLEAR(LOP2);
            end;
        }
    }

    requestpage
    {
        Caption = 'FSF Att Report';

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
        CompanyInfo: Record "Company Information";
        NewYear: Integer;
        NewMonth: Integer;
        PhyPresentDays: Decimal;
        PhyPresentDays2: Decimal;
        Holidays2: Decimal;
        Leaves2: Decimal;
        LOP2: Decimal;
        month2: Text[30];
        Physical_DaysCaptionLbl: Label 'Physical Days';
        Month_YearCaptionLbl: Label 'Month-Year';
        HolidaysCaptionLbl: Label 'Holidays';
        LeavesCaptionLbl: Label 'Leaves';
        AbsentsCaptionLbl: Label 'Absents';
        Physical_DaysCaption_Control1000000027Lbl: Label 'Physical Days';
        Month_YearCaption_Control1000000028Lbl: Label 'Month-Year';
        HolidaysCaption_Control1000000029Lbl: Label 'Holidays';
        LeavesCaption_Control1000000030Lbl: Label 'Leaves';
        AbsentsCaption_Control1000000031Lbl: Label 'Absents';
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

    procedure SetValues(FSYear: Integer; FSMonth: Integer);
    begin
        NewYear := FSYear;
        NewMonth := FSMonth;
    end;
}

