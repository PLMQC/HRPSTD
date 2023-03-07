table 33001373 "VDA Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'VDA Header';
    DataClassification = CustomerContent;

    fields
    {
        field(2; Quarter; Option)
        {
            Caption = 'Quarter';
            OptionMembers = " ",Q1,Q2,Q3,Q4;
            DataClassification = CustomerContent;
        }
        field(3; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Quarter, Year)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        VDALine.SETRANGE(Quarter, Quarter);
        VDALine.SETRANGE(Year, Year);
        if VDALine.FINDFIRST() then
            VDALine.DELETEALL();
    end;

    trigger OnInsert();
    begin
        case Quarter of
            1:
                TempVal := 4;
            2:
                TempVal := 7;
            3:
                TempVal := 10;
            4:
                TempVal := 1;
        end;


        Cont := 1;
        repeat
            VDALine.INIT();
            VDALine.Year := Year;
            VDALine.Month := TempVal;
            VDALine.Quarter := Quarter;
            VDALine.INSERT();
            TempVal += 1;
            Cont += 1;
        until Cont = 4;
    end;

    var
        PayElements: Record "Pay Elements B2B";
        Employee: Record "Employee B2B";
        VDALine: Record "VDA Line B2B";
        HRSetup: Record "HR Setup B2B";
        MonthValue: Integer;
        YearValue: Integer;
        TotalPoints: Decimal;
        Amount: Decimal;
        NoOfMonths: Decimal;
        TempVal: Integer;
        Cont: Integer;
        Text000Lbl: Label 'Do You want to update the Records';
        Text001Lbl: Label 'Records Updated';
        VDATextLbl: Label 'VDA';
        ONAttendanceTextLbl: Label 'ON Attendance';

    procedure UpdatePayElements();
    begin
        if not CONFIRM(Text000Lbl) then
            exit;
        VDALine.SETRANGE(Quarter, Quarter);
        VDALine.SETRANGE(Year, Year);
        if VDALine.FINDFIRST() then
            repeat
                TotalPoints += VDALine.Values;
                NoOfMonths += 1;
                MonthValue := VDALine.Month;
            until VDALine.NEXT() = 0;

        MonthValue := MonthValue + 4;
        if MonthValue > 12 then begin
            MonthValue := MonthValue - 12;
            YearValue := Year + 1;
        end else
            YearValue := Year;


        TotalPoints := TotalPoints / NoOfMonths;

        HRSetup.GET();
        TotalPoints := TotalPoints - HRSetup."Neutralisation Points";

        Amount := ROUND(TotalPoints * HRSetup."VDA Rate", 1, '=');

        Employee.RESET();
        Employee.SETRANGE("VDA Applicable", true);
        Employee.SETRANGE(Probation, false);
        Employee.SETRANGE(Blocked, false);
        if Employee.FINDFIRST() then
            repeat
                PayElements.SETRANGE("Employee Code", Employee."No.");
                PayElements.SETRANGE("Effective Start Date", DMY2DATE(1, MonthValue, YearValue));
                if not PayElements.FINDFIRST() then
                    repeat
                        PayElements.INIT();
                        PayElements."Employee Code" := Employee."No.";
                        PayElements."Effective Start Date" := DMY2DATE(1, MonthValue, YearValue);
                        PayElements."Pay Element Code" := VDATextLbl;
                        PayElements.VALIDATE("Pay Element Code");
                        PayElements."Amount / Percent" := Amount;
                        PayElements."Computation Type" := ONAttendanceTextLbl;
                        PayElements.INSERT(true);
                    until PayElements.NEXT() = 0;
            until Employee.NEXT() = 0;
        MESSAGE(Text001Lbl);
    end;
}

