table 33001209 Holiday_B2B
{
    // version B2BHR1.00.00

    Caption = 'Holiday';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Month: Integer;
                year: Integer;
            begin
                Payrollyear.RESET();
                Payrollyear.SETFILTER("Year Type", LEAVEYEARTxt);
                Payrollyear.SETRANGE(Closed, false);
                if Payrollyear.FINDFIRST() then begin
                    Enddate := DATE2DMY(Payrollyear."Year End Date", 3);
                    Month := DATE2DMY(Date, 2);
                    year := DATE2DMY(Date, 3);
                    if HrSetup.FINDFIRST() then
                        if year < HrSetup."Salary Processing Year" then
                            ERROR(Text000Lbl)
                        else
                            if year = HrSetup."Salary Processing Year" then
                                if Month < HrSetup."Salary Processing month" then
                                    ERROR(Text000Lbl)

                end else
                    ERROR(Text003Lbl);
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(5; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = true;
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", Date, "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if Updated = true then
            ERROR(Text002Lbl);
    end;

    trigger OnInsert();
    begin
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then begin
            if "Location Code" = '' then
                ERROR(Text006Lbl);
        end else begin
            "Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();
            if "Location Code" = '' then
                ERROR('');
        end;
    end;

    var
        HrSetup: Record "HR Setup B2B";
        Payrollyear: Record "Payroll Year B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text000Lbl: Label 'Holiday date should not be earlier than salary processing month and year';

        Text002Lbl: Label 'Can''t delete updated records';
        Text003Lbl: Label 'Leave year is  closed or Leave year is not created';
        Text004Lbl: Label 'Attendance updated successfully.';
        Text005Lbl: Label 'Please generate attendance.';
        Enddate: Integer;
        Text006Lbl: Label 'Enter a Valid Location';
        LEAVEYEARTxt: Label 'LEAVE YEAR';

    procedure UpdateAttendance();
    var
        DailyAttendance: Record "Daily Attendance B2B";
        Holiday: Record Holiday_B2B;
    begin
        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Location Code", "Location Code");
        if DailyAttendance.FINDFIRST() then begin
            repeat
                Holiday.RESET();
                Holiday.SETRANGE("Location Code", "Location Code");
                if Holiday.FINDFIRST() then
                    repeat
                        if DailyAttendance.Date = Holiday.Date then begin
                            DailyAttendance."Non-Working" := true;
                            DailyAttendance."Non-Working Type" := DailyAttendance."Non-Working Type"::Holiday;
                            DailyAttendance.Holiday := 1;
                            DailyAttendance."Attendance Type" := 0;
                            DailyAttendance.Present := 0;
                            DailyAttendance.Absent := 0;
                            DailyAttendance.Leave := 0;
                            Holiday.Updated := true;
                        end;
                        DailyAttendance.MODIFY();
                        Holiday.MODIFY();
                    until Holiday.NEXT() = 0;
            until DailyAttendance.NEXT() = 0;
            MESSAGE(Text004Lbl)
        end else
            ERROR(Text005Lbl);
    end;
}

