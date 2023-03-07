codeunit 33001209 "Emp Performance Release B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        PerformanceLine: Record "Employee Performance Line B2B";
        ActionType: Option Created,Updated,Review,Released,"Self Review","Joint Review",Reopen;
        Text001Txt: Label 'There is nothing to Release.';
        Text002Txt: Label 'Already Review entered, You cannot reopen now.';

    procedure ReleaseDocument(var EmpPerformanceHeader: Record "Employee PerformanceHeader B2B");
    begin
        if EmpPerformanceHeader.Status = EmpPerformanceHeader.Status::Open then begin
            PerformanceLine.RESET();
            PerformanceLine.SETRANGE(PerformanceLine."Appraisal No.", EmpPerformanceHeader."Apprisal No");
            PerformanceLine.SETRANGE("Employee No.", EmpPerformanceHeader."Employee No.");
            PerformanceLine.SETRANGE(Period, EmpPerformanceHeader.Period);
            PerformanceLine.SETRANGE("KRA Type", PerformanceLine."KRA Type"::Question);
            if not PerformanceLine.FINDFIRST() then
                ERROR(Text001Txt);

            EmpPerformanceHeader.Status := EmpPerformanceHeader.Status::Released;
            EmpPerformanceHeader.MODIFY();
            UpdateLog(ActionType::Released, EmpPerformanceHeader);
        end;
    end;

    procedure ReopenDocument(var EmpPerformanceHeader: Record "Employee PerformanceHeader B2B");
    begin
        if EmpPerformanceHeader.Status = EmpPerformanceHeader.Status::Released then begin
            PerformanceLine.RESET();
            PerformanceLine.SETRANGE(PerformanceLine."Appraisal No.", EmpPerformanceHeader."Apprisal No");
            PerformanceLine.SETRANGE("Employee No.", EmpPerformanceHeader."Employee No.");
            PerformanceLine.SETRANGE(Period, EmpPerformanceHeader.Period);
            PerformanceLine.SETRANGE("KRA Type", PerformanceLine."KRA Type"::Question);
            if PerformanceLine.FINDFIRST() then
                repeat
                    if (PerformanceLine."Self Rating" <> 0) or (PerformanceLine."HOD Rating" <> 0) then
                        ERROR(Text002Txt);
                until PerformanceLine.NEXT() = 0;

            EmpPerformanceHeader.Status := EmpPerformanceHeader.Status::Open;
            EmpPerformanceHeader.MODIFY();
            UpdateLog(ActionType::Reopen, EmpPerformanceHeader);
        end;
    end;

    procedure UpdateLog(ActionTypePar: Option Created,Updated,Review,Released,"Self Review","Joint Review",Reopen; var EmpPerformanceHeader: Record "Employee PerformanceHeader B2B");
    var
        PerformanceLog: Record "Emp Performance Log B2B";
    begin
        PerformanceLog.INIT();
        PerformanceLog.VALIDATE("Appraisal No.", EmpPerformanceHeader."Apprisal No");
        PerformanceLog.VALIDATE("Employee Code", EmpPerformanceHeader."Employee No.");
        PerformanceLog.VALIDATE(Period, EmpPerformanceHeader.Period);
        PerformanceLog.VALIDATE("Action By", USERID());
        PerformanceLog.VALIDATE("Action Date", WORKDATE());
        PerformanceLog.VALIDATE("Action Time", TIME());
        PerformanceLog.INSERT();
    end;
}

