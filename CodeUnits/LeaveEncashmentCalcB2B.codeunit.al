codeunit 33001201 "Leave Encashment Calc B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
        LeavesToEncash(LeaveEntitle, EncashAmt);
    end;

    var
        LeaveEntitle: Record "Leave Entitlement B2B";
        PayElement: Record "Pay Elements B2B";
        VAD2: Record "Pay Elements B2B";
        EncashAmt: Decimal;
        Text000Txt: Label 'BASIC';
        Text0001Txt: Label 'ON ATTENDANCE';
        Text0002Txt: Label 'NON ATTENDANCE';
        Text0003Txt: Label 'AFTER BASIC';
        Text0004Txt: Label 'AFTER BASIC AND DA';

    procedure LeavesToEncash(LeaveEntitle: Record "Leave Entitlement B2B"; var EncashAmt: Decimal);
    var
        LeaveEncash: Record "Leave Encashed B2B";
    begin
        LeaveEncash.INIT();
        LeaveEncash."Leave Code" := LeaveEntitle."Leave Code";
        LeaveEncash."Employee Code" := LeaveEntitle."Employee No.";
        LeaveEncash.Year := LeaveEntitle.Year;
        LeaveEncash.Month := LeaveEntitle.Month;
        LeaveEncash."Leaves Encashed" := LeaveEntitle."Leave to Encash";
        LeaveEncash."Leaves to Encash" := LeaveEntitle."Leave to Encash";
        LeaveEncash."Encash Amount" := EncashAmt;
        LeaveEncash.INSERT();
        UpdateLeaveBalance(LeaveEncash);
    end;

    procedure CalcofLeaveEncashment(MonAttendance: Record "Monthly Attendance B2B"; LeaveEncashed: Decimal): Decimal;
    var

        Basic: Decimal;
        DA: Decimal;
        Total: Decimal;
        "Sum": Decimal;
        Sum2: Decimal;
        NetCash: Decimal;
        NoofDays: Decimal;
        StartDate: Date;
        EndDate: Date;
        CheckDate: Date;
    begin
        PayElement.SETRANGE(Processed, false);
        PayElement.SETRANGE("Employee Code", MonAttendance."Employee Code");
        if PayElement.FINDFIRST() then begin
            repeat
                MonAttendance.CALCFIELDS(MonAttendance.Days);
                Total := 0;
                Sum := 0;
                NetCash := 0;
                StartDate := MonAttendance."Period Start Date";
                EndDate := MonAttendance."Period End Date";
                NoofDays := EndDate - StartDate + 1;
                VAD2.RESET();
                VAD2.SETRANGE("Employee Code", PayElement."Employee Code");
                VAD2.SETRANGE("Pay Element Code", PayElement."Pay Element Code");
                if VAD2.FINDFIRST() then begin
                    CheckDate := VAD2."Effective Start Date";
                    repeat
                        VAD2.Processed := true;
                        VAD2.MODIFY();
                        if (VAD2."Effective Start Date" >= CheckDate) and (VAD2."Effective Start Date" <= EndDate) then
                            if VAD2."Pay Element Code" = Text000Txt then
                                if (VAD2."Computation Type" = Text0001Txt) then begin
                                    Total := VAD2."Amount / Percent";
                                    Basic := Total;
                                    NetCash := (Basic / MonAttendance.Days) * LeaveEncashed;
                                end else
                                    if (VAD2."Computation Type" = Text0002Txt) then begin
                                        Total := VAD2."Amount / Percent";
                                        Basic := Total;
                                        NetCash := (Basic / MonAttendance.Days) * LeaveEncashed;
                                    end
                                    else
                                        if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) then begin
                                            if (VAD2."Computation Type" = Text0001Txt) then begin
                                                Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                                NetCash := (Total / MonAttendance.Days) * LeaveEncashed;
                                            end else begin
                                                Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                                NetCash := (Total / MonAttendance.Days) * LeaveEncashed;
                                            end;
                                        end else
                                            if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                               (VAD2."Computation Type" = Text0003Txt)
                                   then begin
                                                Total := (VAD2."Amount / Percent" * Basic) / 100;
                                                NetCash := (Total / MonAttendance.Days) * LeaveEncashed;
                                            end else
                                                if (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) and
                                                   (VAD2."Computation Type" = Text0004Txt)
                                       then begin
                                                    Total := (VAD2."Amount / Percent" * (Basic)) / 100;
                                                    NetCash := (Total / MonAttendance.Days) * LeaveEncashed;
                                                end;
                        if VAD2."Pay Element Code" = 'DA' then
                            DA := Total;


                    until VAD2.NEXT() = 0;
                    Sum := Sum + NetCash;
                end;
                Sum2 := Sum2 + Sum;
            until PayElement.NEXT() = 0;
            exit(Sum2);
        end;
    end;

    procedure UpdateLeaveBalance(LeaveEncash: Record "Leave Encashed B2B");
    begin
        LeaveEntitle.SETRANGE("Employee No.", LeaveEncash."Employee Code");
        LeaveEntitle.SETRANGE("Leave Code", LeaveEncash."Leave Code");
        LeaveEntitle.SETRANGE(Year, LeaveEncash.Year);
        LeaveEntitle.SETRANGE(Month, LeaveEncash.Month);
        if LeaveEntitle.FINDFIRST() then begin
            LeaveEntitle."Total Leaves" := LeaveEntitle."Total Leaves" - LeaveEncash."Leaves Encashed";
            LeaveEntitle."Leave to Encash" := 0;
            LeaveEntitle.MODIFY();
        end;
    end;
}

