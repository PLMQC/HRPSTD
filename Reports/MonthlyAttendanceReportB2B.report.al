report 33001268 "Monthly Attendance Report B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Monthly Attendance Report.rdl';
    Caption = 'Monthly Attendance Report';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Monthly Attendance"; "Monthly Attendance B2B")
        {
            CalcFields = Days, Holidays, "Loss Of Pay", "Weekly Off", Leaves;
            DataItemTableView = SORTING("Employee Code", "Pay Slip Month", Year, "Line No.") ORDER(Ascending);
            RequestFilterFields = "Pay Slip Month", Year, "Physical Location", "Department Code", "Location Code";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Attendance_for_the_Month_of____MonthVar_____FORMAT__Monthly_Attendance__Year_; 'Attendance for the Month of  ' + MonthVar + ' ' + FORMAT("Monthly Attendance".Year))
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Monthly_Attendance__GETFILTERS; "Monthly Attendance".GETFILTERS())
            {
            }
            column(Monthly_Attendance__Employee_Code_; "Employee Code")
            {
            }
            column(SNo; SNo)
            {
            }
            column(Employee__First_Name______Employee__Middle_Name______Employee__Last_Name_; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
            {
            }
            column(Monthly_Attendance__Employee_Name_; "Employee Name")
            {
            }
            column(Monthly_Attendance__Loss_Of_Pay_; "Loss Of Pay")
            {
            }
            column(Monthly_Attendance__Weekly_Off_; "Weekly Off")
            {
            }
            column(Monthly_Attendance__Outdoor_Days_; "Outdoor Days")
            {
            }
            column(Monthly_Attendance_Leaves; Leaves)
            {
            }
            column(PayDays; PayDays)
            {
            }
            column(Monthly_Attendance_Holidays; Holidays)
            {
            }
            column(PresentDays; PresentDays)
            {
            }
            column(Present_Present_DaysCaption; Present_Present_DaysCaptionLbl)
            {
            }
            column(AB___Leave_Without_PayCaption; AB___Leave_Without_PayCaptionLbl)
            {
            }
            column(W_o___Weekly_OffCaption; W_o___Weekly_OffCaptionLbl)
            {
            }
            column(TourCaption; TourCaptionLbl)
            {
            }
            column(H_Day___HolidayCaption; H_Day___HolidayCaptionLbl)
            {
            }
            column(Leave___Leave_With_PayCaption; Leave___Leave_With_PayCaptionLbl)
            {
            }
            column(S_No_Caption; S_No_CaptionLbl)
            {
            }
            column(Emp__No_Caption; Emp__No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(PRESENTCaption; PRESENTCaptionLbl)
            {
            }
            column(ABCaption; ABCaptionLbl)
            {
            }
            column(W_OCaption; W_OCaptionLbl)
            {
            }
            column(TOURCaption_Control1102152009; TOURCaption_Control1102152009Lbl)
            {
            }
            column(H_DAYCaption; H_DAYCaptionLbl)
            {
            }
            column(LEAVECaption; LEAVECaptionLbl)
            {
            }
            column(PAY_DAYSCaption; PAY_DAYSCaptionLbl)
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
            column(NewJoinee; NewJoinee)
            {
            }
            column(BlockEmp; BlockEmp)
            {
            }
            column(BlockDate; BlockDate)
            {
            }
            column(Physical_Location; "Physical Location")
            { }

            trigger OnAfterGetRecord();
            begin
                CLEAR(PresentDays);
                CLEAR(PayDays);
                SNo += 1;
                PresentDays := Days - Leaves - Holidays - "Outdoor Days" - "Weekly Off" - "Loss Of Pay";
                PayDays := Days - "Loss Of Pay";
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.get();
                CompanyInfo.CALCFIELDS(Picture);
                MonthVar := "Monthly Attendance".GETFILTER("Pay Slip Month");
                EVALUATE(MonthVar2, MonthVar);
                YearVar := "Monthly Attendance".GETFILTER(Year);
                EVALUATE(YearVar2, YearVar);
                CLEAR(Dept);
                CLEAR(Loc);
                CLEAR(PhysicalLoc);
                Dept := "Monthly Attendance".GETFILTER("Department Code");
                Loc := "Monthly Attendance".GETFILTER("Location Code");
                PhysicalLoc := "Monthly Attendance".GETFILTER("Physical Location");
                TempExcelBuffer.DELETEALL();
            end;
        }
        dataitem("Monthly Attendance2"; "Monthly Attendance B2B")
        {
            DataItemTableView = SORTING("Employee Code", "Pay Slip Month", Year, "Line No.") ORDER(Ascending);
            column(NewJoinee_____Joining_date_is___FORMAT_Employee__Employment_Date__; '***  ' + NewJoinee + ' - Joining date is ' + FORMAT(Employee."Employment Date"))
            {
            }
            column(New_JoiningCaption; New_JoiningCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Monthly_Attendance2_Employee_Code; "Employee Code")
            {
            }
            column(Monthly_Attendance2_Pay_Slip_Month; "Pay Slip Month")
            {
            }
            column(Monthly_Attendance2_Year; Year)
            {
            }
            column(Monthly_Attendance2_Line_No_; "Line No.")
            {
            }
            column(Department_Code; "Department Code")
            { }


            trigger OnAfterGetRecord();
            begin
                CLEAR(NewJoinee);
                Employee.RESET();
                Employee.SETRANGE("No.", "Employee Code");
                if PhysicalLoc <> '' then
                    Employee.SETRANGE("Physical Location", PhysicalLoc);
                if Loc <> '' then
                    Employee.SETRANGE("Location Code", Loc);
                if Dept <> '' then
                    Employee.SETRANGE("Department Code", Dept);
                StartDate2 := DMY2DATE(1, MonthVar2, YearVar2);
                EndDate2 := CALCDATE(Text000Txt, StartDate2);
                Employee.SETRANGE("Employment Date", StartDate2, EndDate2);
                if Employee.FINDFIRST() then
                    if ((DATE2DMY(Employee."Employment Date", 2) = "Pay Slip Month") and (DATE2DMY(Employee."Employment Date", 3) = Year)) then
                        NewJoinee := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

            end;
        }
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.");


            column(BlockEmp_____Resigned___last_working_day_is___FORMAT_BlockDate_; '***  ' + BlockEmp + ' - Resigned & last working day is ' + FORMAT(BlockDate))
            {
            }
            column(Resigned_EmployeesCaption; Resigned_EmployeesCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152063; EmptyStringCaption_Control1102152063Lbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }


            trigger OnAfterGetRecord();
            begin
                CLEAR(BlockEmp);
                CLEAR(BlockDate);
                Employee2.RESET();
                Employee2.SETRANGE("No.", "No.");
                Employee2.SETRANGE(Blocked, true);
                StartDate := DMY2DATE(1, MonthVar2, YearVar2);
                EndDate := CALCDATE(Text000Txt, StartDate);
                Employee2.SETRANGE("Blocked Date", StartDate, EndDate);
                if PhysicalLoc <> '' then
                    Employee2.SETRANGE("Physical Location", PhysicalLoc);
                if Loc <> '' then
                    Employee2.SETRANGE("Location Code", Loc);
                if Dept <> '' then
                    Employee2.SETRANGE("Department Code", Dept);
                if Employee2.FINDFIRST() then begin
                    BlockEmp := Employee2."First Name" + ' ' + Employee2."Middle Name" + Employee2."Last Name";
                    BlockDate := Employee2."Blocked Date";
                end;
            end;
        }
    }

    requestpage
    {
        Caption = 'Monthly Attendance Report';

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
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Employee2: Record "Employee B2B";
        Employee: Record "Employee B2B";
        SNo: Integer;
        PayDays: Decimal;
        PresentDays: Decimal;
        MonthVar: Text;
        MonthVar2: Integer;
        YearVar: Text;
        NewJoinee: Text;
        BlockEmp: Text;
        BlockDate: Date;
        StartDate: Date;
        EndDate: Date;
        EndDate2: Date;
        YearVar2: Integer;
        Dept: Text;
        Loc: Text;
        PhysicalLoc: Text;
        StartDate2: Date;
        Present_Present_DaysCaptionLbl: Label 'Present-Present Days';
        AB___Leave_Without_PayCaptionLbl: Label 'AB - Leave Without Pay';
        W_o___Weekly_OffCaptionLbl: Label 'W/o - Weekly Off';
        TourCaptionLbl: Label 'Tour';
        H_Day___HolidayCaptionLbl: Label 'H.Day - Holiday';
        Leave___Leave_With_PayCaptionLbl: Label 'Leave - Leave With Pay';
        S_No_CaptionLbl: Label 'S.No.';
        Emp__No_CaptionLbl: Label 'Emp. No.';
        NameCaptionLbl: Label 'Name';
        PRESENTCaptionLbl: Label 'PRESENT';
        ABCaptionLbl: Label 'AB';
        W_OCaptionLbl: Label 'W/O';
        TOURCaption_Control1102152009Lbl: Label 'TOUR';
        H_DAYCaptionLbl: Label 'H.DAY';
        LEAVECaptionLbl: Label 'LEAVE';
        PAY_DAYSCaptionLbl: Label 'PAY DAYS';
        New_JoiningCaptionLbl: Label 'New Joining';
        EmptyStringCaptionLbl: Label ':';
        Resigned_EmployeesCaptionLbl: Label 'Resigned Employees';
        EmptyStringCaption_Control1102152063Lbl: Label ':';
        Text000Txt: Label '<1M-1D>';
}

