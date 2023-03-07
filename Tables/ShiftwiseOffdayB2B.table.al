table 33001317 "Shiftwise Offday B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shiftwise Offday_B2B';
    DrillDownPageID = "Shiftwise Offdays B2B";
    LookupPageID = "Shiftwise Offdays B2B";
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
                OffDay.SETRANGE("Shift Code", "Shift Code");
                OffDay.SETRANGE(OffDay."Week No.", OffDay."Week No."::All);
                OffDay.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                if OffDay.FINDFIRST() then
                    ERROR(Text0001Lbl, Day);

                case Day of
                    Day::Sunday:
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
                    else
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
        field(10; "Shift Code"; Code[20])
        {
            Caption = 'Shift Code';
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;
        }
        field(11; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Shift Code", Day, "Week No.", "Location Code")
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
    end;

    var
        OffDay: Record "Shiftwise Offday B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Num: Integer;
        Text0001Lbl: Label 'All %1s are offdays, So you cannot select another.', Comment = '%1 = Day';

}

