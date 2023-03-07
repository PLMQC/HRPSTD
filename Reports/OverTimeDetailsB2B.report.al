report 33001244 "Over Time Details B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Over Time Details.rdlc';
    Caption = 'Over Time Details';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Monthly Attendance"; "Monthly Attendance B2B")
        {
            DataItemTableView = SORTING("Employee Code", "Pay Slip Month", Year, "Line No.") WHERE("Over Time Hrs" = FILTER(<> 0));
            column(Monthly_Attendance__Employee_Code_; "Employee Code")
            {
            }
            column(Monthly_Attendance__Employee_Name_; "Employee Name")
            {
            }
            column(AmountVar; AmountVar)
            {
            }
            column(Monthly_Attendance__Over_Time_Hrs_; "Over Time Hrs")
            {
            }
            column(EmployeeGRec_Designation; EmployeeGRec.Designation)
            {
            }
            column(EmployeeGRec__OT_Calculation_Rate_; EmployeeGRec."OT Calculation Rate")
            {
            }
            column(Monthly_Attendance__Loss_Of_Pay_; "Loss Of Pay")
            {
            }
            column(ActualPaidDays__Monthly_Attendance___LOP_Adj_Days_; ActualPaidDays + "Monthly Attendance"."LOP Adj Days")
            {
            }
            column(AmountVar_Control1102154016; AmountVar)
            {
            }
            column(Monthly_Attendance__Over_Time_Hrs__Control1102154017; "Over Time Hrs")
            {
            }
            column(Monthly_Attendance__Employee_Code_Caption; Monthly_Attendance__Employee_Code_CaptionLbl)
            {
            }
            column(Monthly_Attendance__Employee_Name_Caption; FIELDCAPTION("Employee Name"))
            {
            }
            column(AmountVarCaption; AmountVarCaptionLbl)
            {
            }
            column(OT_HoursCaption; OT_HoursCaptionLbl)
            {
            }
            column(EmployeeGRec_DesignationCaption; EmployeeGRec_DesignationCaptionLbl)
            {
            }
            column(EmployeeGRec__OT_Calculation_Rate_Caption; EmployeeGRec__OT_Calculation_Rate_CaptionLbl)
            {
            }
            column(Monthly_Attendance__Loss_Of_Pay_Caption; Monthly_Attendance__Loss_Of_Pay_CaptionLbl)
            {
            }
            column(Paid_DaysCaption; Paid_DaysCaptionLbl)
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
                HRsetup.GET();
                EmployeeGRec.RESET();
                if EmployeeGRec.GET("Monthly Attendance"."Employee Code") then;
                AmountVar := "Over Time Hrs" * EmployeeGRec."OT Calculation Rate";
                ActualPaidDays := HRsetup."Paid Days Per Month" - "Loss Of Pay";
            end;

            trigger OnPreDataItem();
            begin
                if ((MonthVar = 0) or (YearVar = 0)) then
                    ERROR(Text001Txt);

                "Monthly Attendance".SETRANGE("Pay Slip Month", MonthVar);
                "Monthly Attendance".SETRANGE(Year, YearVar);

            end;

        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreReport()
    begin
        HRsetup.Get();
        MonthVar := HRsetup."Salary Processing month";
        YearVar := HRsetup."Salary Processing Year";
    end;

    var
        EmployeeGRec: Record "Employee B2B";
        HRsetup: Record "HR Setup B2B";
        MonthVar: Integer;
        YearVar: Integer;
        AmountVar: Decimal;
        ActualPaidDays: Decimal;
        Monthly_Attendance__Employee_Code_CaptionLbl: Label 'Employee Code';
        AmountVarCaptionLbl: Label 'Amount';
        OT_HoursCaptionLbl: Label 'OT Hours';
        EmployeeGRec_DesignationCaptionLbl: Label 'Designation';
        EmployeeGRec__OT_Calculation_Rate_CaptionLbl: Label 'Per Unit Amount';
        Monthly_Attendance__Loss_Of_Pay_CaptionLbl: Label 'Absent Days';
        Paid_DaysCaptionLbl: Label 'Paid Days';
        Text001Txt: Label 'Month & Year Must be filled in';
}

