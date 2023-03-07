table 33001210 "Off Day B2B"
{
    // version B2BHR1.00.00

    Caption = 'Off Day';
    DataClassification = CustomerContent;
    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; Day; Option)
        {
            Caption = 'Day';
            OptionCaption = ' ,Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday';
            OptionMembers = " ",Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                OffDay.RESET();
                OffDay.SETRANGE(OffDay.Day, Day);
                OffDay.SETRANGE(OffDay."Week No.", OffDay."Week No."::All);
                OffDay.SETRANGE("Location Code", "Location Code");
                if OffDay.FINDFIRST() then begin
                    PayrollUsers.GET(USERID());
                    if PayrollUsers."Multiple Locations" = '' then
                        ERROR(Text0001Lbl, Day);
                end;

                case Day of
                    day::Sunday:
                        "Day No." := 7;
                    Day::Saturday:
                        "Day No." := 6;
                    Day::Friday:
                        "Day No." := 5;
                    Day::Thursday:
                        "Day No." := 4;
                    Day::Wednesday:
                        "Day No." := 3;
                    Day::Tuesday:
                        "Day No." := 2;
                    Day::Monday:
                        "Day No." := 1;
                    Day::" ":
                        "Day No." := 0;
                end;


            end;
        }
        field(3; "Weekly Off"; Option)
        {
            Caption = 'Weekly Off';
            OptionCaption = ' ,Half Day,Full Day';
            OptionMembers = " ","Half Day","Full Day";
            DataClassification = CustomerContent;
        }
        field(4; "Day No."; Integer)
        {
            Caption = 'Day No.';
            DataClassification = CustomerContent;
        }
        field(5; NonWorking; Boolean)
        {
            Caption = 'NonWorking';
            DataClassification = CustomerContent;
        }
        field(6; "Week No."; Option)
        {
            Caption = 'Week No.';
            OptionCaption = 'All,1,2,3,4,5';
            OptionMembers = All,"1","2","3","4","5";
            DataClassification = CustomerContent;
        }
        field(8; "Applicable Date"; Date)
        {
            Caption = 'Applicable Date';
            DataClassification = CustomerContent;
        }
        field(9; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = true;
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Location: Record "Payroll Locations B2B";
                ExitLoop: Boolean;
                InvalidLocationErr: Label 'You do not have permissions to location %1.', Comment = '%1 = Location Code';
            begin
                if "Location Code" <> '' then begin
                    PayrollUsers.GET(USERID());
                    IF PayrollUsers."Multiple Locations" <> '' THEN BEGIN
                        Location.RESET();
                        Location.SETFILTER("Location Code", PayrollUsers."Multiple Locations");
                        Location.FINDSET();
                        REPEAT
                            ExitLoop := Location."Location Code" = "Location Code";
                        UNTIL (Location.NEXT() = 0) OR ExitLoop;

                        IF NOT ExitLoop THEN
                            ERROR(InvalidLocationErr, "Location Code");
                    END ELSE
                        IF "Location Code" <> LocWiseMiscGCU.ReturnUserLocationCode() THEN
                            ERROR(InvalidLocationErr, "Location Code");

                    OffDay.RESET();
                    OffDay.SETRANGE(OffDay.Day, Day);
                    OffDay.SETRANGE(OffDay."Week No.", OffDay."Week No."::All);
                    OffDay.SETRANGE("Location Code", "Location Code");
                    if OffDay.FINDFIRST() then
                        ERROR(Text0001Lbl, Day);
                end;
            end;
        }
    }

    keys
    {
        key(Key1; ID, "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if OffDay.FINDLAST() then
            Num := OffDay.ID
        else
            Num := 0;

        ID := Num + 1;

        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then begin
            if "Location Code" = '' then
                ERROR(Text0002Lbl);
        end else begin
            "Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();
            if "Location Code" = '' then
                ERROR('');
        end;
    end;

    var
        OffDay: Record "Off Day B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Num: Integer;
        Text0001Lbl: Label 'All %1s are offdays, So you cannot select another.', Comment = '%1 = Day';
        Text0002Lbl: Label 'Enter a Valid Location';
}

