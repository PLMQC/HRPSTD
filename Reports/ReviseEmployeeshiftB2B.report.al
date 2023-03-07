report 33001223 "Revise Employee shift B2B"
{
    // version B2BHR1.00.00

    Caption = 'Revise Employee shift';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                //Caption = 'Filters';//Phani
                field("Revised Shift"; RevisedShiftGVar)
                {
                    ToolTip = 'Choose the Revised shift of the employee.';
                    Caption = 'Revised Shift';
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        ShiftMasterGRec.RESET();
                        ShiftMasterGRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                        if PAGE.RUNMODAL(0, ShiftMasterGRec) = ACTION::LookupOK then
                            RevisedShiftGVar := ShiftMasterGRec."Shift Code";
                    end;
                }
                field("Effective Date"; EffectiveDatesGVar)
                {
                    ToolTip = 'Choose the Effective date of the Revised shift.';
                    Caption = 'Effective Date';
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

    trigger OnPreReport();
    begin
        if EmployeeCodeGVar = '' then
            ERROR(Text001Txt);

        if MonthGVar = 0 then
            ERROR(Text002Txt);

        if YearGVar = 0 then
            ERROR(Text003Txt);

        if EffectiveDatesGVar = '' then
            ERROR(Text004Txt);

        if RevisedShiftGVar = '' then
            ERROR(Text005Txt);

        if not CONFIRM(Text010Txt) then
            exit;

        MonthAttendGRec.RESET();
        MonthAttendGRec.SETRANGE("Employee Code", EmployeeCodeGVar);
        MonthAttendGRec.SETRANGE("Pay Slip Month", MonthGVar);
        MonthAttendGRec.SETRANGE(Year, YearGVar);
        MonthAttendGRec.SETRANGE(Posted, true);
        if MonthAttendGRec.FINDFIRST() then
            ERROR(Text007Txt, EmployeeCodeGVar, MonthGVar, YearGVar);
        CheckTime := 130000T;
        EmployeeShift.GET(RevisedShiftGVar, LocWiseMiscGCU.ReturnUserLocationCode());
        StartTime := EmployeeShift."Starting Time";
        EndTime := EmployeeShift."Ending Time";
        DailyAttendanceGRec.RESET();
        DailyAttendanceGRec.SETRANGE("Employee No.", EmployeeCodeGVar);
        DailyAttendanceGRec.SETRANGE(Month, MonthGVar);
        DailyAttendanceGRec.SETRANGE(Year, YearGVar);
        DailyAttendanceGRec.SETFILTER(Date, EffectiveDatesGVar);
        if DailyAttendanceGRec.FINDFIRST() then
            repeat
                DailyAttendanceGRec."Time In" := StartTime;
                DailyAttendanceGRec."Time Out" := EndTime;
                DailyAttendanceGRec."Break Duration" := EmployeeShift."Break Duration";
                if (StartTime > CheckTime) and (EndTime < CheckTime) then begin
                    StartDateTime := CREATEDATETIME(DailyAttendanceGRec.Date, DailyAttendanceGRec."Time In");
                    EndDateTime := CREATEDATETIME((DailyAttendanceGRec.Date + 1), DailyAttendanceGRec."Time Out");
                    DailyAttendanceGRec."Hours Worked" := ABS((StartDateTime - EndDateTime) / 3600000) - EmployeeShift."Break Duration";
                end else
                    DailyAttendanceGRec."Hours Worked" := ABS((DailyAttendanceGRec."Time In" - DailyAttendanceGRec."Time Out") / 3600000) - EmployeeShift."Break Duration";
                DailyAttendanceGRec."Actual Time In" := StartTime;
                DailyAttendanceGRec."Actual Time Out" := EndTime;
                if (StartTime > CheckTime) and (EndTime < CheckTime) then begin
                    StartDateTime := CREATEDATETIME(DailyAttendanceGRec.Date, DailyAttendanceGRec."Actual Time In");
                    EndDateTime := CREATEDATETIME((DailyAttendanceGRec.Date + 1), DailyAttendanceGRec."Actual Time Out");
                    DailyAttendanceGRec."Actual Hrs" := ABS((StartDateTime - EndDateTime) / 3600000) - EmployeeShift."Break Duration";
                end else
                    DailyAttendanceGRec."Actual Hrs" :=
                      ABS((DailyAttendanceGRec."Actual Time In" - DailyAttendanceGRec."Actual Time Out") / 3600000) - EmployeeShift."Break Duration";
                DailyAttendanceGRec."Revised Shift Code" := EmployeeShift."Shift Code";
                if DailyAttendanceGRec.MODIFY() then
                    ShiftChanged := true;
            until DailyAttendanceGRec.NEXT() = 0;

        if ShiftChanged then begin
            MESSAGE(Text008Txt);
            MonthAttendGRec.RESET();
            MonthAttendGRec.SETRANGE("Employee Code", EmployeeCodeGVar);
            MonthAttendGRec.SETRANGE("Pay Slip Month", MonthGVar);
            MonthAttendGRec.SETRANGE(Year, YearGVar);
            MonthAttendGRec.SETRANGE(Processed, true);
            if MonthAttendGRec.FINDFIRST() then
                ERROR(Text009Txt, EmployeeCodeGVar, MonthGVar, YearGVar);
        end;
    end;

    var
        DailyAttendanceGRec: Record "Daily Attendance B2B";
        EmployeeShift: Record "Shift Master B2B";
        MonthAttendGRec: Record "Monthly Attendance B2B";
        ShiftMasterGRec: Record "Shift Master B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        EmployeeCodeGVar: Code[20];
        MonthGVar: Integer;
        YearGVar: Integer;
        EffectiveDatesGVar: Text[30];
        RevisedShiftGVar: Code[20];
        StartTime: Time;
        EndTime: Time;
        CheckTime: Time;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        ShiftChanged: Boolean;
        Text001Txt: Label 'Please Select the employee';
        Text002Txt: Label 'Please select the month';
        Text003Txt: Label 'Please select the Year';
        Text004Txt: Label 'Please select the Effective Dates';
        Text005Txt: Label 'Please select the Revised Shift';
        Text007Txt: Label 'Payroll already processed for the employee %1 in this month %2 and year %3', Comment = '%1 =  Code ; %2 = Month;%3= Year';
        Text008Txt: Label 'Shift revised Successfully';
        Text009Txt: Label 'Please reprocess the monthly attendace for this employee %1 in the month %2 and year %3', Comment = '%1 = Code ; %2 = month ;%3 = Year';
        Text010Txt: Label 'Do you want to revise the shift';

    procedure SetValues(EmployeeCodeLPar: Code[20]; MonthLVar: Integer; YearLPar: Integer);
    begin
        EmployeeCodeGVar := EmployeeCodeLPar;
        MonthGVar := MonthLVar;
        YearGVar := YearLPar;
    end;
}

