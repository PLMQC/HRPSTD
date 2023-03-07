report 33001227 "Monthly Salary Summary B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Monthly Salary Summary.rdlc';
    Caption = 'Monthly Salary Summary';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Monthly Attendance"; "Monthly Attendance B2B")
        {
            DataItemTableView = SORTING ("Employee Code", "Pay Slip Month", Year, "Line No.");
            RequestFilterFields = "Employee Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            /*
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }*/
            column(USERID; USERID())
            {
            }
            column(Monthly_Attendance__Employee_Code_; "Employee Code")
            {
            }
            column(Monthly_Attendance_Attendance; Attendance)
            {
            }
            column(Monthly_Attendance_Days; Days)
            {
            }
            column(Monthly_Attendance__Pay_Slip_Month_; "Pay Slip Month")
            {
            }
            column(Monthly_Attendance__Over_Time_Hrs_; "Over Time Hrs")
            {
            }
            column(Monthly_Attendance__Loss_Of_Pay_; "Loss Of Pay")
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
            column(Monthly_Attendance_Leaves; Leaves)
            {
            }
            column(SlNo; SlNo)
            {
            }
            column(Monthly_AttendanceCaption; Monthly_AttendanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Monthly_Attendance__Employee_Code_Caption; FIELDCAPTION("Employee Code"))
            {
            }
            column(Monthly_Attendance_AttendanceCaption; FIELDCAPTION(Attendance))
            {
            }
            column(Monthly_Attendance_DaysCaption; FIELDCAPTION(Days))
            {
            }
            column(MonthCaption; MonthCaptionLbl)
            {
            }
            column(Monthly_Attendance__Over_Time_Hrs_Caption; FIELDCAPTION("Over Time Hrs"))
            {
            }
            column(Monthly_Attendance__Loss_Of_Pay_Caption; FIELDCAPTION("Loss Of Pay"))
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
            column(Monthly_Attendance_LeavesCaption; FIELDCAPTION(Leaves))
            {
            }
            column(SlNoCaption; SlNoCaptionLbl)
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
                SlNo += 1;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                LastFieldNo := FIELDNO("Employee Code");
            end;
        }
    }

    requestpage
    {
        Caption = 'Monthly Salary Summary';

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
        LastFieldNo: Integer;
        SlNo: Integer;
        Monthly_AttendanceCaptionLbl: Label 'Monthly Attendance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MonthCaptionLbl: Label 'Month';
        SlNoCaptionLbl: Label 'Sl No.';
}

