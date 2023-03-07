table 33001211 "Shift Master B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shift Master';
    LookupPageID = "Shift List B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Shift Code"; Code[20])
        {
            Caption = 'Shift Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Decription; Text[50])
        {
            Caption = 'Decription';
            DataClassification = CustomerContent;
        }
        field(3; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            DataClassification = CustomerContent;
        }
        field(4; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            DataClassification = CustomerContent;
        }
        field(5; "Break Start Time"; Time)
        {
            Caption = 'Break Start Time';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Starting Time" > "Break Start Time") or ("Ending Time" < "Break Start Time") then
                    if "Starting Time" < "Ending Time" then
                        ERROR(Text001Lbl);

                if ("Break Start Time" <> 0T) and ("Break End time" <> 0T) then begin
                    if "Break End time" < "Break Start Time" then
                        ERROR(Text004Lbl);

                    CheckTime := 130000T;
                    Day := WORKDATE();

                    if ("Break Start Time" > CheckTime) and ("Break End time" < CheckTime) then begin
                        StartDateTime := CREATEDATETIME(Day, "Break Start Time");
                        EndDateTime := CREATEDATETIME((Day + 1), "Break End time");
                        "Break Duration" := ABS((StartDateTime - EndDateTime) / 3600000);
                    end else
                        "Break Duration" := ABS(("Break Start Time" - "Break End time") / 3600000);
                end;
            end;
        }
        field(6; "Break End time"; Time)
        {
            Caption = 'Break End time';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Starting Time" > "Break End time") or ("Ending Time" < "Break End time") then
                    if "Starting Time" < "Ending Time" then
                        ERROR(Text003Lbl);
                if ("Break Start Time" <> 0T) and ("Break End time" <> 0T) then begin
                    if "Starting Time" < "Ending Time" then
                        if "Break End time" < "Break Start Time" then
                            ERROR(Text002Lbl);
                    CheckTime := 130000T;
                    Day := WORKDATE();
                    if ("Break Start Time" > CheckTime) and ("Break End time" < CheckTime) then begin
                        StartDateTime := CREATEDATETIME(Day, "Break Start Time");
                        EndDateTime := CREATEDATETIME((Day + 1), "Break End time");
                        "Break Duration" := ABS((StartDateTime - EndDateTime) / 3600000);
                    end else
                        "Break Duration" := ABS(("Break Start Time" - "Break End time") / 3600000);
                end;
            end;
        }
        field(7; "Break Duration"; Decimal)
        {
            Caption = 'Break Duration';
            DataClassification = CustomerContent;
        }
        field(8; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(21; "Cut Off Min Start Time"; Time)
        {
            Caption = 'Cut Off Min Start Time';
            DataClassification = CustomerContent;
        }
        field(22; "Cut Off End Time"; Time)
        {
            Caption = 'Cut Off End Time';
            DataClassification = CustomerContent;
        }
        field(25; "Cut Off Max Start Time"; Time)
        {
            Caption = 'Cut Off Max Start Time';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Shift Code", "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then begin
            if "Location Code" = '' then
                ERROR(Text005Lbl);
            InsertOffdays();
        end else begin
            "Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();
            if "Location Code" = '' then
                ERROR('');
            InsertOffdays();
        end;
    end;

    trigger OnDelete();
    begin
        ShiftWeeklyOff.RESET();
        ShiftWeeklyOff.SETRANGE("Shift Code", "Shift Code");
        ShiftWeeklyOff.SETRANGE("Location Code", "Location Code");
        if ShiftWeeklyOff.FINDSET() then
            ShiftWeeklyOff.DELETEALL();
    end;

    trigger OnRename();
    begin
        ShiftWeeklyOff.RESET();
        ShiftWeeklyOff.SETRANGE("Shift Code", "Shift Code");
        ShiftWeeklyOff.SETRANGE("Location Code", "Location Code");
        if ShiftWeeklyOff.FINDSET() then
            ShiftWeeklyOff.DELETEALL();
    end;

    var
        ShiftWeeklyOff: Record "Shiftwise Offday B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Day: Date;
        CheckTime: Time;
        Text001Lbl: Label 'Break Start Time should be Greater than StartTime And Less than End Time';
        Text002Lbl: Label 'Break End Time Should not be less than the Break Start Time.';
        Text003Lbl: Label 'Break End Time should beGreater than StartTime and  Less than EndTime';
        Text004Lbl: Label 'Break Start Time Should not Exceed Break End Time.';
        Text005Lbl: Label 'Enter a Valid Location';

    procedure InsertOffdays();
    var
        WeeklyOff: Record "Off Day B2B";
        ShiftOff: Record "Shiftwise Offday B2B";
    begin
        WeeklyOff.RESET();
        WeeklyOff.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if WeeklyOff.FINDSET() then
            repeat
                ShiftOff.INIT();
                ShiftOff.TRANSFERFIELDS(WeeklyOff);
                ShiftOff."Shift Code" := "Shift Code";
                ShiftOff."Location Code" := WeeklyOff."Location Code";
                ShiftOff.INSERT();
            until WeeklyOff.NEXT() = 0;
    end;

    procedure InsertOffdaysML();
    var
        WeeklyOff: Record "Off Day B2B";
        ShiftOff: Record "Shiftwise Offday B2B";
    begin
        WeeklyOff.RESET();
        WeeklyOff.SETRANGE("Location Code", "Location Code");
        if WeeklyOff.FINDSET() then
            repeat
                ShiftOff.INIT();
                ShiftOff.TRANSFERFIELDS(WeeklyOff);
                ShiftOff."Shift Code" := "Shift Code";
                ShiftOff."Location Code" := WeeklyOff."Location Code";
                ShiftOff.INSERT();
            until WeeklyOff.NEXT() = 0;
    end;
}

