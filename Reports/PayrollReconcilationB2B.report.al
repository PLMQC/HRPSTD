report 33001217 "Payroll Reconcilation B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Payroll Reconcilation.rdl';
    Caption = 'Payroll Reconcilation';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Monthly Attendance"; "Monthly Attendance B2B")
        {
            DataItemTableView = SORTING("Employee Code", "Pay Slip Month", Year) ORDER(Ascending);
            RequestFilterFields = "Pay Slip Month", Year;
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(FORMAT__PAYROLL_RECONCILATION_________MonthNamePresent_____FORMAT_Year__; FORMAT('PAYROLL RECONCILATION -' + '  ' + MonthNamePresent + ' ' + FORMAT(Year)))
            {
            }
            column(GrossPayPrevious; GrossPayPrevious)
            {
            }
            column(AttendRegDeduPrevious; AttendRegDeduPrevious)
            {
            }
            column(TotalVDAPresent; TotalVDAPresent)
            {
            }
            column(FORMAT__Gross_Pay_________MonthNamePrevious_____FORMAT_ExactYear__; FORMAT('Gross Pay -' + '  ' + MonthNamePrevious + ' ' + FORMAT(ExactYear)))
            {
            }
            column(FORMAT__Attendance_Regular_dedu_________MonthNamePrevious_____FORMAT_ExactYear__; FORMAT('Attendance Regular dedu -' + '  ' + MonthNamePrevious + ' ' + FORMAT(ExactYear)))
            {
            }
            column(FORMAT__Loss_Of_Pay_________MonthNamePrevious_____FORMAT_ExactYear__; FORMAT('Loss Of Pay -' + '  ' + MonthNamePrevious + ' ' + FORMAT(ExactYear)))
            {
            }
            column(FORMAT__VDA_Of_________MonthNamePresent_____FORMAT_Year__; FORMAT('VDA Of -' + '  ' + MonthNamePresent + ' ' + FORMAT(Year)))
            {
            }
            column(FORMAT__OverTime_Of_________MonthNamePresent_____FORMAT_Year__; FORMAT('OverTime Of -' + '  ' + MonthNamePresent + ' ' + FORMAT(Year)))
            {
            }
            column(TotalOTPresent; TotalOTPresent)
            {
            }
            column(New_Appointments____Gross_Excluding_OT_VDA_LOP___ATT_Regu__Caption; New_Appointments____Gross_Excluding_OT_VDA_LOP___ATT_Regu__CaptionLbl)
            {
            }
            column(Additions_Caption; Additions_CaptionLbl)
            {
            }
            column(Monthly_Attendance_Employee_Code; "Employee Code")
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
                ExactYear := Year;
                Monthvalue := "Pay Slip Month" - 1;
                if Monthvalue = 0 then begin
                    Monthvalue := 12;
                    ExactYear := ExactYear - 1;
                end;
                TotalVDAPresent := 0;
                TotalOTPresent := 0;
                TotalVDAPrevious := 0;
                TotalOTPrevious := 0;
                GrossPayPrevious := 0;
                GrossPayPresent := 0;
                TotalOTPresent := calcOT("Pay Slip Month", ExactYear);
                TotalVDAPresent := CalcVDA("Pay Slip Month", ExactYear);
                AttendRegDeduPresent := TotalAttendREguDeducal("Pay Slip Month", ExactYear);
                AttendRegDeduPrevious := TotalAttendREguDeducal(Monthvalue, ExactYear);
                TotalVDAPrevious := CalcVDA(Monthvalue, ExactYear);
                TotalOTPrevious := calcOT(Monthvalue, ExactYear);
                "Monthly Attendance".CALCFIELDS("Gross Salary");
                "Monthly Attendance".CALCFIELDS(Deductions);
                MonthNamePresent := GetMonth("Pay Slip Month");
                MonthNamePrevious := GetMonth(Monthvalue);
                GrossPayPrevious := CalcGrossPay(Monthvalue, ExactYear);
                GrossPayPresent := CalcGrossPay("Pay Slip Month", ExactYear);
                TotalForPrevious := AttendRegDeduPrevious + TotalOTPresent + TotalVDAPresent;
                TotalForPresent := AttendRegDeduPresent + TotalOTPrevious + TotalVDAPrevious;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                TotalDiff := 0;
            end;
        }
        dataitem("Processed Salary2"; "Processed Salary B2B")
        {
            DataItemTableView = SORTING("Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.") ORDER(Ascending);
            column(Processed_Salary2__Employee_Code_; "Employee Code")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(GrossForEach; GrossForEach)
            {
            }
            column(NewEmployeeTextboxControl; NewEmployee)
            {
            }
            column(FORMAT_MonthNamePrevious_____FORMAT_Year__; FORMAT(MonthNamePrevious + ' ' + FORMAT(Year)))
            {
            }
            column(FORMAT_MonthNamePresent_____FORMAT_Year__; FORMAT(MonthNamePresent + ' ' + FORMAT(Year)))
            {
            }
            column(TotalForNewEmp; TotalForNewEmp)
            {
            }
            column(Difference_in_Gross_Earnings_____Gross_Excluding_OT_VDA_LOP___ATT_Regu__Caption; Difference_in_Gross_Earnings_____Gross_Excluding_OT_VDA_LOP___ATT_Regu__CaptionLbl)
            {
            }
            column(DifferenceCaption; DifferenceCaptionLbl)
            {
            }
            column(Processed_Salary2_Document_Type; "Document Type")
            {
            }
            column(Processed_Salary2_Pay_Slip_Month; "Pay Slip Month")
            {
            }
            column(Processed_Salary2_Year; Year)
            {
            }
            column(Processed_Salary2_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(EmployeeName);
                Monthlyattendance2.RESET();
                Monthlyattendance2.SETRANGE("Employee Code", "Processed Salary2"."Employee Code");
                Monthlyattendance2.SETRANGE("Pay Slip Month", "Processed Salary2"."Pay Slip Month");
                if Monthlyattendance2.FINDFIRST() then
                    EmployeeName := Monthlyattendance2."Employee Name";

                Employee2.RESET();
                Employee2.SETRANGE("No.", "Processed Salary2"."Employee Code");
                if Employee2.FINDFIRST() then
                    if (DATE2DMY(Employee2."Employment Date", 2) = "Processed Salary2"."Pay Slip Month") and
                       (DATE2DMY(Employee2."Employment Date", 3) = "Processed Salary2".Year) then begin
                        NewEmployee := true;
                        GrossForEach := CalcGross("Pay Slip Month", "Processed Salary2".Year, "Employee Code");
                        TotalForNewEmp := TotalForNewEmp + GrossForEach;
                    end else
                        NewEmployee := false;

            end;

            trigger OnPostDataItem();
            begin
                TotalForPrevious := TotalForPrevious + TotalForNewEmp;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                SETRANGE("Pay Slip Month", "Monthly Attendance"."Pay Slip Month");
                SETRANGE(Year, "Monthly Attendance".Year);
                SETRANGE("Add/Deduct Code", BASICTxt);
                NewEmployee := false;
            end;
        }
        dataitem("Processed Salary"; "Processed Salary B2B")
        {
            DataItemTableView = SORTING("Employee Code", "Add/Deduct Code", "Pay Slip Month", Year, "Add/Deduct");
            column(Difference; Difference)
            {
            }
            column(PreGrossValue; PreGrossValue)
            {
            }
            column(GrossValue; GrossValue)
            {
            }
            column(Processed_Salary__Processed_Salary___Employee_Code_; "Processed Salary"."Employee Code")
            {
            }
            column(showthisTextboxControl; showthis)
            {
            }
            column(TotalDiff; TotalDiff)
            {
            }
            column(TotalForPrevious; TotalForPrevious)
            {
            }
            column(NetPrevious; NetPrevious)
            {
            }
            column(Deletions___RESIGNATIONS___Caption; Deletions___RESIGNATIONS___CaptionLbl)
            {
            }
            column(Processed_Salary_Document_Type; "Document Type")
            {
            }
            column(Processed_Salary_Pay_Slip_Month; "Pay Slip Month")
            {
            }
            column(Processed_Salary_Year; Year)
            {
            }
            column(Processed_Salary_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                PreGrossValue := 0;
                GrossValue := 0;
                Monthvalue := "Monthly Attendance"."Pay Slip Month" - 1;
                Employee2.RESET();
                Employee2.SETRANGE("No.", "Processed Salary"."Employee Code");
                if Employee2.FINDFIRST() then
                    if ((DATE2DMY(Employee2."Employment Date", 2) <> "Processed Salary"."Pay Slip Month") and
                       (DATE2DMY(Employee2."Employment Date", 3) <> "Processed Salary".Year)) then begin
                        PreGrossValue := CalcGross(Monthvalue, "Processed Salary".Year, "Processed Salary"."Employee Code");
                        GrossValue := CalcGross("Processed Salary"."Pay Slip Month", "Processed Salary".Year, "Processed Salary"."Employee Code");
                        Difference := GrossValue - PreGrossValue;
                        TotalDiff := TotalDiff + Difference;
                        if Difference <> 0 then
                            showthis := true
                        else
                            showthis := false;


                    end;

            end;

            trigger OnPostDataItem();
            begin
                TotalDiff := TotalDiff + Difference;
                TotalForPrevious := TotalForPrevious + TotalDiff;
                NetPrevious := GrossPayPrevious + TotalForPrevious;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                SETRANGE("Pay Slip Month", "Monthly Attendance"."Pay Slip Month");
                SETRANGE(Year, "Monthly Attendance".Year);
                SETRANGE("Add/Deduct Code", BASICTxt);
                showthis := false;
            end;
        }
        dataitem("Processed Salary3"; "Processed Salary B2B")
        {
            DataItemTableView = SORTING("Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.") ORDER(Ascending);
            column(Processed_Salary3__Employee_Code_; "Employee Code")
            {
            }
            column(Processed_Salary3__Employee_Name_; "Employee Name")
            {
            }
            column(GrossForEach_Control1102152006; GrossForEach)
            {
            }
            column(ResignedTextboxControl; Resigned)
            {
            }
            column(TotalForResigned; TotalForResigned)
            {
            }
            column(TotalVDAPrevious; TotalVDAPrevious)
            {
            }
            column(TotalOTPrevious; TotalOTPrevious)
            {
            }
            column(AttendRegDeduPresent; AttendRegDeduPresent)
            {
            }
            column(FORMAT__Attendance_Regular_dedu_________MonthNamePresent_____FORMAT_Year__; FORMAT('Attendance Regular dedu -' + '  ' + MonthNamePresent + ' ' + FORMAT(Year)))
            {
            }
            column(FORMAT__Loss_Of_Pay_________MonthNamePresent_____FORMAT_Year__; FORMAT('Loss Of Pay -' + '  ' + MonthNamePresent + ' ' + FORMAT(Year)))
            {
            }
            column(FORMAT__VDA_Of_________MonthNamePrevious_____FORMAT_ExactYear__; FORMAT('VDA Of -' + '  ' + MonthNamePrevious + ' ' + FORMAT(ExactYear)))
            {
            }
            column(FORMAT__OverTime_Of_________MonthNamePrevious_____FORMAT_ExactYear__; FORMAT('OverTime Of -' + '  ' + MonthNamePrevious + ' ' + FORMAT(ExactYear)))
            {
            }
            column(TotalForPresent; TotalForPresent)
            {
            }
            column(GrossPayPresent; GrossPayPresent)
            {
            }
            column(FORMAT__Gross_Pay_________MonthNamePresent_____FORMAT_Year__; FORMAT('Gross Pay -' + '  ' + MonthNamePresent + ' ' + FORMAT(Year)))
            {
            }
            column(Processed_Salary3_Document_Type; "Document Type")
            {
            }
            column(Processed_Salary3_Pay_Slip_Month; "Pay Slip Month")
            {
            }
            column(Processed_Salary3_Year; Year)
            {
            }
            column(Processed_Salary3_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                Employee2.RESET();
                Employee2.SETRANGE("No.", "Processed Salary3"."Employee Code");
                Employee2.SETRANGE(Blocked, true);
                if Employee2.FINDFIRST() then
                    if Employee2."Resignation Date" <> 0D then
                        if (DATE2DMY(Employee2."Resignation Date", 2) = "Processed Salary3"."Pay Slip Month") and
                           (DATE2DMY(Employee2."Resignation Date", 3) = "Processed Salary3".Year) then begin
                            Resigned := true;
                            GrossForEach := CalcGross("Pay Slip Month", "Processed Salary2".Year, "Employee Code");
                            TotalForResigned := TotalForResigned + GrossForEach;
                        end else
                            Resigned := false;
            end;

            trigger OnPostDataItem();
            begin
                TotalForPresent := TotalForPresent + TotalForResigned;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                SETRANGE("Pay Slip Month", "Monthly Attendance"."Pay Slip Month");
                SETRANGE(Year, "Monthly Attendance".Year);
                SETRANGE("Add/Deduct Code", BASICTxt);
                Resigned := false;
                GrossForEach := 0;
                TotalForResigned := 100;
            end;
        }
    }

    requestpage
    {
        Caption = 'Payroll Reconcilation';

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

    trigger OnPreReport();
    begin
        Year := "Processed Salary".Year;
    end;

    var

        Monthlyattendance2: Record "Monthly Attendance B2B";
        ProcessedSalary2: Record "Processed Salary B2B";
        Employee2: Record "Employee B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Year: Integer;
        Basic: Decimal;
        DA: Decimal;
        HRA: Decimal;
        CCA: Decimal;
        CA: Decimal;
        WA: Decimal;
        "Spl.All.": Decimal;
        Others: Decimal;
        Monthvalue: Integer;
        PreGrossValue: Decimal;
        GrossValue: Decimal;
        AttendRegDeduPrevious: Decimal;

        TotalVDAPrevious: Decimal;
        TotalOTPrevious: Decimal;
        showthis: Boolean;
        NewEmployee: Boolean;
        TempVal: Decimal;
        Difference: Decimal;
        TotalDiff: Decimal;
        TotalVDAPresent: Decimal;
        TotalOTPresent: Decimal;
        AttendRegDeduPresent: Decimal;
        MonthName: Text[30];
        MonthNamePresent: Text[30];
        MonthNamePrevious: Text[30];
        GrossPayPrevious: Decimal;
        GrossPayPresent: Decimal;
        GrossForEach: Decimal;
        Resigned: Boolean;
        EmployeeName: Text[120];
        TotalForPresent: Decimal;
        TotalForPrevious: Decimal;
        TotalForNewEmp: Decimal;
        TotalForResigned: Decimal;
        ExactYear: Integer;
        NetPrevious: Decimal;

        New_Appointments____Gross_Excluding_OT_VDA_LOP___ATT_Regu__CaptionLbl: Label 'New Appointments : (Gross Excluding OT,VDA,LOP & ATT Regu.)';
        Additions_CaptionLbl: Label 'Additions:';
        Difference_in_Gross_Earnings_____Gross_Excluding_OT_VDA_LOP___ATT_Regu__CaptionLbl: Label 'Difference in Gross Earnings :  (Gross Excluding OT,VDA,LOP & ATT Regu.)';
        DifferenceCaptionLbl: Label 'Difference';
        Deletions___RESIGNATIONS___CaptionLbl: Label '"Deletions : RESIGNATIONS : "';
        BASICTxt: Label 'BASIC';
        LCDTxt: Label 'LCD';
        VDATxt: Label 'VDA';
        OTTxt: Label 'OT';
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
        FDATxt: Label 'FDA';
        HRATxt: Label 'HRA';
        CATxt: Label 'CA';
        CCATxt: Label 'CCA';
        WATxt: Label 'WA';
        SPELALLTxt: Label 'SPELALL';
        LeaveEncashmentTxt: Label 'Leave Encashment';

    procedure TotalAttendREguDeducal(month: Integer; Year1: Integer) Total: Decimal;
    begin
        TempVal := 0;
        ProcessedSalary2.RESET();
        ProcessedSalary2.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        ProcessedSalary2.SETRANGE("Pay Slip Month", month);
        ProcessedSalary2.SETRANGE(Year, Year1);
        ProcessedSalary2.SETRANGE("Add/Deduct Code", LCDTxt);
        if ProcessedSalary2.FINDFIRST() then
            repeat
                TempVal := TempVal + ProcessedSalary2."Earned Amount";
            until ProcessedSalary2.NEXT() = 0;
        exit(TempVal);
    end;

    procedure CalcVDA(month: Integer; Year1: Integer) value: Decimal;
    begin
        TempVal := 0;
        ProcessedSalary2.RESET();
        ProcessedSalary2.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        ProcessedSalary2.SETRANGE("Pay Slip Month", month);
        ProcessedSalary2.SETRANGE(Year, Year1);
        ProcessedSalary2.SETRANGE("Add/Deduct Code", VDATxt);
        if ProcessedSalary2.FINDFIRST() then
            repeat
                TempVal := TempVal + ProcessedSalary2."Earned Amount";
            until ProcessedSalary2.NEXT() = 0;
        exit(TempVal);
    end;

    procedure calcOT(month: Integer; Year1: Integer) value: Decimal;
    begin
        TempVal := 0;
        ProcessedSalary2.RESET();
        ProcessedSalary2.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        ProcessedSalary2.SETRANGE("Pay Slip Month", month);
        ProcessedSalary2.SETRANGE(Year, Year1);
        ProcessedSalary2.SETRANGE("Add/Deduct Code", OTTxt);
        if ProcessedSalary2.FINDFIRST() then
            repeat
                TempVal := TempVal + ProcessedSalary2."Earned Amount";
            until ProcessedSalary2.NEXT() = 0;
        exit(TempVal);
    end;

    procedure GetMonth(month1: Integer) MonthNam: Text[30];
    begin
        case month1 of
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

        exit(MonthName);
    end;

    procedure CalcGrossPay(Month1: Integer; Year1: Integer) Value: Decimal;
    begin
        TempVal := 0;
        ProcessedSalary2.RESET();
        ProcessedSalary2.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        ProcessedSalary2.SETRANGE("Pay Slip Month", Month1);
        ProcessedSalary2.SETRANGE(Year, Year1);
        if ProcessedSalary2.FINDFIRST() then
            repeat
                case ProcessedSalary2."Add/Deduct Code" of
                    BASICTxt, FDATxt, VDATxt, HRATxt, CATxt, CCATxt, WATxt, SPELALLTxt, LeaveEncashmentTxt, OTTxt:
                        TempVal := TempVal + ProcessedSalary2."Earned Amount";
                end;
            until ProcessedSalary2.NEXT() = 0;
        exit(TempVal);
    end;

    procedure CalcGross(Month: Integer; YearValue: Integer; EmpCode: Code[20]) Value: Decimal;
    begin
        GrossValue := 0;
        TempVal := 0;
        Basic := 0;
        DA := 0;
        HRA := 0;
        CCA := 0;
        CA := 0;
        WA := 0;
        "Spl.All." := 0;
        Others := 0;
        ProcessedSalary2.RESET();
        ProcessedSalary2.SETRANGE("Employee Code", EmpCode);
        ProcessedSalary2.SETRANGE("Pay Slip Month", Month);
        ProcessedSalary2.SETRANGE(Year, YearValue);
        if ProcessedSalary2.FINDFIRST() then
            repeat
                case ProcessedSalary2."Add/Deduct Code" of
                    BASICTxt:
                        Basic := ProcessedSalary2."Earned Amount";
                    FDATxt:
                        DA := ProcessedSalary2."Earned Amount";
                    HRATxt:
                        HRA := ProcessedSalary2."Earned Amount";
                    CATxt:
                        CA := ProcessedSalary2."Earned Amount";
                    CCATxt:
                        CCA := ProcessedSalary2."Earned Amount";
                    WATxt:
                        WA := ProcessedSalary2."Earned Amount";
                    SPELALLTxt:
                        "Spl.All." := ProcessedSalary2."Earned Amount";
                    LeaveEncashmentTxt:
                        Others := ProcessedSalary2."Earned Amount";
                end;
                TempVal := Basic + DA + HRA + CCA + CA + WA + "Spl.All." + Others;
            until ProcessedSalary2.NEXT() = 0;
        exit(TempVal);
    end;
}

