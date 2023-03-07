report 33001289 "Update Names All employees B2B"
{
    // version B2BHR1.00.00

    Caption = 'Update Names All employesss';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {

            trigger OnAfterGetRecord();
            begin
                DailyAttendanceGRec.RESET();
                DailyAttendanceGRec.SETRANGE("Employee No.", "Employee B2B"."No.");
                DLines := DailyAttendanceGRec.COUNT();

                LineNo := 0;
                Window.OPEN(Text002Txt);
                if DailyAttendanceGRec.FINDFIRST() then
                    repeat
                        LineNo := LineNo + 1;
                        DailyAttendanceGRec."Employee Name" := CopyStr("Employee B2B"."First Name" + ' ' + "Employee B2B"."Middle Name" + ' ' +
                                                                     "Employee B2B"."Last Name", 1, 50);
                        DailyAttendanceGRec.MODIFY();
                        Window.UPDATE(1, "Employee B2B"."No.");
                        Window.UPDATE(2, ROUND(LineNo / DLines * 10000, 1));
                        SLEEP(2);
                    until DailyAttendanceGRec.NEXT() = 0;

                MonthlyAttendanceGRec.RESET();
                MonthlyAttendanceGRec.SETRANGE("Employee Code", "Employee B2B"."No.");
                MLines := MonthlyAttendanceGRec.COUNT();
                LineNo := 0;
                Window.OPEN(Text003Txt);
                if MonthlyAttendanceGRec.FINDFIRST() then
                    repeat
                        LineNo := LineNo + 1;
                        MonthlyAttendanceGRec."Employee Name" := "Employee B2B"."First Name" + ' ' + "Employee B2B"."Middle Name" + ' ' +
                                                                   "Employee B2B"."Last Name";
                        MonthlyAttendanceGRec.MODIFY();
                        Window.UPDATE(1, "Employee B2B"."No.");
                        Window.UPDATE(2, ROUND(LineNo / MLines * 10000, 1));
                        SLEEP(50);
                    until MonthlyAttendanceGRec.NEXT() = 0;


                ProcessedSalaryGRec.RESET();
                ProcessedSalaryGRec.SETRANGE("Employee Code", "Employee B2B"."No.");
                PLines := ProcessedSalaryGRec.COUNT();
                LineNo := 0;
                Window.OPEN(Text004Txt);
                if ProcessedSalaryGRec.FINDFIRST() then
                    repeat
                        LineNo := LineNo + 1;
                        ProcessedSalaryGRec."Employee Name" := Copystr("Employee B2B"."First Name" + ' ' + "Employee B2B"."Middle Name" + ' ' +
                                                                   "Employee B2B"."Last Name", 1, 30);
                        ProcessedSalaryGRec.MODIFY();
                        Window.UPDATE(1, "Employee B2B"."No.");
                        Window.UPDATE(2, ROUND(LineNo / PLines * 10000, 1));
                        SLEEP(50);
                    until ProcessedSalaryGRec.NEXT() = 0;
            end;

            trigger OnPostDataItem();
            begin
                MESSAGE(Text001Txt);
            end;
        }
    }

    requestpage
    {
        Caption = 'Update Names All employesss';

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
        DailyAttendanceGRec: Record "Daily Attendance B2B";
        MonthlyAttendanceGRec: Record "Monthly Attendance B2B";
        ProcessedSalaryGRec: Record "Processed Salary B2B";
        DLines: Integer;
        MLines: Integer;
        PLines: Integer;
        Window: Dialog;
        LineNo: Integer;
        Text001Txt: Label 'All The Records Are Modified';
        Text002Txt: Label 'Employee No. #1####### \ Progress @2@@@@@@@@ \ Updating Daily Attendance', Comment = '%1 = No ; %2 = Processs';
        Text003Txt: Label 'Employee No. #1####### \ Progress @2@@@@@@@@ \ Updating Monthly Attendance', Comment = '%1 =  NO; %2 = Process';
        Text004Txt: Label 'Employee No. #1####### \ Progress @2@@@@@@@@ \ Updating Processed Salary', Comment = '%1 = No ; %2 = Process';
}

