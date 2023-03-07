codeunit 33001207 "Attendance Approvals B2B"
{
    // version B2BHR1.00.00
    //HRP1.22


    trigger OnRun();
    begin
    end;

    var
        DailyAttendance: Record "Daily Attendance B2B";
        OTLines: Record "Attendance Lines B2B";
        LopAdjLines: Record "Attendance Lines B2B";
        CompOffLines: Record "Attendance Lines B2B";
        OnDutyLines: Record "Attendance Lines B2B";
        Text001Txt: Label 'Entries updated successfully....';
        Text002Txt: Label 'Adjustment Entries updated successfully....';
        Text003Txt: Label 'Entries posted successfully....';


    procedure ReleaseOvertime(OTHeader: Record "Attendance Header B2B");
    begin
        if OTHeader."Document Type" = OTHeader."Document Type"::Overtime then begin
            OTHeader.Status := OTHeader.Status::"Pending for Approval HOD";
            OTHeader.MODIFY();
        end;
        if OTHeader."Document Type" = OTHeader."Document Type"::Permission then begin
            OTHeader.Status := OTHeader.Status::Approved;
            OTHeader.MODIFY();
        end;
    end;

    procedure ApproveOvertime(OTHeader: Record "Attendance Header B2B");
    var

    begin
        if OTHeader."Document Type" = OTHeader."Document Type"::Overtime then begin
            OTLines.RESET();
            OTLines.SETRANGE("Document Type", OTHeader."Document Type");
            OTLines.SETRANGE("Document No.", OTHeader."No.");
            if OTLines.FINDFIRST() then
                repeat
                    DailyAttendance.RESET();
                    DailyAttendance.SETRANGE("Employee No.", OTLines."Employee Code");
                    DailyAttendance.SETRANGE(Date, OTLines."Start Date");
                    if DailyAttendance.FINDFIRST() then
                        if DailyAttendance."Attendance Type" <> DailyAttendance."Attendance Type"::Leave then begin
                            DailyAttendance."OT Hrs" := OTLines."Applied Hours";
                            DailyAttendance."OT Approved Hrs" := OTLines."Approved Hours";
                            DailyAttendance.MODIFY();
                        end;

                until OTLines.NEXT() = 0;
            OTHeader.Status := OTHeader.Status::"Pending for Additional Approval";
            Evaluate(OTHeader."Approved By", USERID());
            OTHeader.MODIFY();

        end;
    end;

    procedure ReleaseOnDuty(OnDutyHeader: Record "Attendance Header B2B");
    begin
    end;

    procedure ApproveOnDuty(OnDutyHeader: Record "Attendance Header B2B");
    var

    begin
        OnDutyLines.RESET();
        OnDutyLines.SETRANGE("Document Type", OnDutyHeader."Document Type");
        OnDutyLines.SETRANGE("Document No.", OnDutyHeader."No.");
        if OnDutyLines.FINDFIRST() then
            repeat
                DailyAttendance.RESET();
                DailyAttendance.SETRANGE("Employee No.", OnDutyLines."Employee Code");
                DailyAttendance.SETRANGE(Date, OnDutyLines."Start Date");
                if DailyAttendance.FINDFIRST() then begin
                    DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Present;
                    DailyAttendance.Present := 1;
                    DailyAttendance.Absent := 0;
                    DailyAttendance."Revised Shift" := OnDutyHeader."Shift Code";
                    DailyAttendance.VALIDATE("Time Out", OnDutyLines."End Time");
                    DailyAttendance.VALIDATE("Time In", OnDutyLines."Start Time");
                    DailyAttendance."Outdoor Duty" := true;//HRP1.22
                    DailyAttendance.MODIFY();
                end;
            until OnDutyLines.NEXT() = 0;

        OnDutyHeader.Status := OnDutyHeader.Status::Approved;
        Evaluate(OnDutyHeader."Approved By", USERID());
        OnDutyHeader.MODIFY();
        MESSAGE(Text001Txt);
    end;

    procedure ApproveLopAdjustment(LopAdjHeader: Record "Attendance Header B2B");
    var

    begin
        if LopAdjHeader."Document Type" = LopAdjHeader."Document Type"::"Lop Adj" then begin
            LopAdjLines.RESET();
            LopAdjLines.SETRANGE("Document Type", LopAdjHeader."Document Type");
            LopAdjLines.SETRANGE("Document No.", LopAdjHeader."No.");
            if LopAdjLines.FINDFIRST() then
                repeat
                    Evaluate(LopAdjLines."Approved By", USERID());
                    LopAdjLines.Status := LopAdjLines.Status::Approved;
                    LopAdjLines.MODIFY();
                until LopAdjLines.NEXT() = 0;
            Evaluate(LopAdjHeader."Approved By", USERID());
            LopAdjHeader.Status := LopAdjHeader.Status::Approved;
            LopAdjHeader.MODIFY();
            MESSAGE(Text002Txt);

        end;
    end;

    procedure ApproveCompOff(CompOffHeader: Record "Attendance Header B2B");
    var

    begin
        if CompOffHeader."Document Type" = CompOffHeader."Document Type"::"Comp Off" then begin
            CompOffLines.RESET();
            CompOffLines.SETRANGE("Document Type", CompOffHeader."Document Type");
            CompOffLines.SETRANGE("Document No.", CompOffHeader."No.");
            if CompOffLines.FINDFIRST() then
                repeat
                    DailyAttendance.RESET();
                    DailyAttendance.SETRANGE("Employee No.", CompOffLines."Employee Code");
                    DailyAttendance.SETRANGE(Date, CompOffLines."Comp Off Date");
                    if DailyAttendance.FINDFIRST() then begin
                        DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Present;
                        DailyAttendance.Present := 1;
                        DailyAttendance.Absent := 0;
                        DailyAttendance."Revised Shift" := CompOffHeader."Shift Code";
                        DailyAttendance.VALIDATE("Time Out", CompOffLines."End Time");
                        DailyAttendance.VALIDATE("Time In", CompOffLines."Start Time");
                        DailyAttendance."Comp Off" := true;
                        DailyAttendance."C Off Hours" := CompOffLines."C Off Hours";
                        DailyAttendance.Validate("Comp Off Hrs.", CompOffLines."C Off Hours");
                        DailyAttendance.MODIFY();
                    end;
                until CompOffLines.NEXT() = 0;

            CompOffHeader.Status := CompOffHeader.Status::Approved;
            Evaluate(CompOffHeader."Approved By", USERID());
            CompOffHeader.MODIFY();
            MESSAGE(Text003Txt);
        end;
    end;
}

