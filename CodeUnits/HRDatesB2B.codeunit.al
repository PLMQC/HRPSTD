codeunit 33001202 "HR Dates B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        dayOfWeek: Integer;
        NextDay: Date;
        Text001Txt: Label 'The wrong date category!';
        Text002Txt: Label 'For Date Calculation Enter All Applicable Dates!';
        Text003Txt: Label 'Not valid date. The month must be between 1 and 12';
        Text004Txt: Label '%1  Years, %2  Months and #3## Days', Comment = '%1=Year;%2=Month;%3=Days';
        Text005Txt: Label '%1  Months %2 Days', Comment = '%1=Year;%2=Days';
        Text006Txt: Label '#1## Years', Comment = '%1 = Year';
        Text007Txt: Label '%1  Years, %2 Months and #3## Days', Comment = '%1=Year;%2=Month;%3=Days';
        Text008Txt: Label '%1  Years and #2## Months', Comment = '%1=Year;%2=Month';
        Text009Txt: Label '1st';
        Text0010Txt: Label '2nd';
        Text0011Txt: Label '3rd';
        Text0012Txt: Label '4th';
        Text0013Txt: Label '5th';
        Text0014Txt: Label '6th';
        Text0015Txt: Label '7th';
        Text0016Txt: Label '8th';
        Text0017Txt: Label '9th';
        Text0018Txt: Label '10th';
        Text0019Txt: Label '11th';
        Text00120Txt: Label '12th';
        Text00121Txt: Label '13th';
        Text00122Txt: Label '14th';
        Text00123Txt: Label '15th';
        Text00124Txt: Label '16th';
        Text00125Txt: Label '17th';
        Text00126Txt: Label '18th';
        Text00127Txt: Label '19th';
        Text00128Txt: Label '20th';
        Text00129Txt: Label '21th';
        Text00130Txt: Label '22th';
        Text001221Txt: Label '23th';
        Text001222Txt: Label '24th';
        Text001223Txt: Label '25th';
        Text001224Txt: Label '26th';
        Text001225Txt: Label '27th';
        Text001226Txt: Label '28th';
        Text001227Txt: Label '29th';
        Text001228Txt: Label '30th';
        Text001229Txt: Label '31th';
        Text001230Txt: Label 'January';
        Text001231Txt: Label 'February';
        Text001232Txt: Label 'March';
        Text001233Txt: Label 'April';
        Text001234Txt: Label 'May';
        Text001235Txt: Label 'June';
        Text001236Txt: Label '"July "';
        Text001237Txt: Label 'August';
        Text001238Txt: Label '"September "';
        Text001239Txt: Label '"October "';
        Text001240Txt: Label 'November';
        Text001241Txt: Label 'December';

    procedure DetermineAge(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45];
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        DateCat: Integer;
    begin
        if ((DateOfBirth <> 0D) and (DateOfJoin <> 0D)) then begin
            dayB := DATE2DMY(DateOfBirth, 1);
            monthB := DATE2DMY(DateOfBirth, 2);
            yearB := DATE2DMY(DateOfBirth, 3);
            dayJ := DATE2DMY(DateOfJoin, 1);
            monthJ := DATE2DMY(DateOfJoin, 2);
            yearJ := DATE2DMY(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            case (DateCat) of
                1:
                    begin
                        Year := yearJ - yearB;
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        end;

                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;

                        AgeString := STRSUBSTNO(Text004Txt, Year, Month, Day);
                    end;

                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then
                            if monthJ >= monthB then
                                Month := monthJ - monthB
                            else
                                ERROR(Text001Txt);


                        if (dayJ <> dayB) then
                            if (dayJ >= dayB) then
                                Day := dayJ - dayB
                            else
                                if (dayJ < dayB) then begin
                                    Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                    Month := Month - 1;
                                end;

                        //AgeString := Text005Txt;
                        AgeString := STRSUBSTNO(Text005Txt, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        //AgeString := Text006Txt;
                        AgeString := STRSUBSTNO(Text006Txt, Year);
                    end;
                5:
                    begin
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                monthJ := monthJ - 1;
                                Month := (monthJ + 12) - monthB;
                                yearJ := yearJ - 1;
                            end;
                        Year := yearJ - yearB;
                        //AgeString := Text007Txt;
                        AgeString := STRSUBSTNO(Text007Txt, Year, Month, Day);
                    end;
                6:
                    begin
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        // AgeString := Text008Txt;
                        AgeString := STRSUBSTNO(Text008Txt, Year, Month);
                    end;
                else
                    AgeString := '';
            end;
        end else
            MESSAGE(Text002Txt);
        exit;
    end;

    procedure DetermineDaysInMonth(Month: Integer; Year: Integer) DaysInMonth: Integer;
    begin
        case (Month) of
            1:
                DaysInMonth := 31;
            2:
                if (LeapYear(Year)) then
                    DaysInMonth := 29
                else
                    DaysInMonth := 28;
            3:
                DaysInMonth := 31;
            4:
                DaysInMonth := 30;
            5:
                DaysInMonth := 31;
            6:
                DaysInMonth := 30;
            7:
                DaysInMonth := 31;
            8:
                DaysInMonth := 31;
            9:
                DaysInMonth := 30;
            10:
                DaysInMonth := 31;
            11:
                DaysInMonth := 30;
            12:
                DaysInMonth := 31;
            else
                MESSAGE(Text003Txt);
        end;
        exit;
    end;

    procedure DateCategory(BDay: Integer; EDay: Integer; BMonth: Integer; EMonth: Integer; BYear: Integer; EYear: Integer) Category: Integer;
    begin
        if ((EYear > BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
            Category := 1
        else
            if ((EYear = BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
                Category := 2
            else
                if ((EYear = BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
                    Category := 3
                else
                    if ((EYear > BYear) and (EMonth = BMonth) and (EDay = BDay)) then
                        Category := 4
                    else
                        if ((EYear > BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
                            Category := 5
                        else
                            if ((EYear > BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
                                Category := 6
                            else
                                if ((EYear = BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
                                    Category := 7
                                else
                                    if ((EYear = BYear) and (EMonth = BMonth) and (EDay = BDay)) then
                                        Category := 3
                                    else
                                        Category := 0;

        exit;
    end;

    procedure LeapYear(Year: Integer) LY: Boolean;
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
        CenturyYear := Year mod 100 = 0;
        DivByFour := Year mod 4 = 0;
        if ((not CenturyYear and DivByFour) or (Year mod 400 = 0)) then
            LY := true
        else
            LY := false;
    end;

    procedure DetermineWeekends(DateStart: Date; DateEnd: Date) Weekends: Integer;
    begin
        Weekends := 0;
        while (DateStart <= DateEnd) do begin
            dayOfWeek := DATE2DWY(DateStart, 1);
            if (dayOfWeek = 6) or (dayOfWeek = 7) then
                Weekends := Weekends + 1;
            NextDay := CalculateNextDay(DateStart);
            DateStart := NextDay;
        end;
    end;

    procedure CalculateNextDay(Date: Date) NextDate: Date;
    var
        TODAY: Integer;
        month: Integer;
        year: Integer;
        nextDayLVar: Integer;
        daysInMonth: Integer;
    begin
        TODAY := DATE2DMY(Date, 1);
        month := DATE2DMY(Date, 2);
        year := DATE2DMY(Date, 3);
        daysInMonth := DetermineDaysInMonth(month, year);
        nextDayLVar := TODAY + 1;
        if (nextDayLVar > daysInMonth) then begin
            nextDayLVar := 1;
            month := month + 1;
            if (month > 12) then begin
                month := 1;
                year := year + 1;
            end;
        end;
        NextDate := DMY2DATE(nextDayLVar, month, year);
    end;

    procedure ConvertDate(nDate: Date) strDate: Text[30];
    var
        lDay: Integer;
        lMonth: Integer;
        lYear: Integer;
        strDay: Text[4];
        StrMonth: Text[20];
        strYear: Text[6];
    begin
        lDay := DATE2DMY(nDate, 1);
        lMonth := DATE2DMY(nDate, 2);
        lYear := DATE2DMY(nDate, 3);

        if lDay = 1 then
            strDay := Text009Txt;
        if lDay = 2 then
            strDay := Text0010Txt;
        if lDay = 3 then
            strDay := Text0011Txt;
        if lDay = 4 then
            strDay := Text0012Txt;
        if lDay = 5 then
            strDay := Text0013Txt;
        if lDay = 6 then
            strDay := Text0014Txt;
        if lDay = 7 then
            strDay := Text0015Txt;
        if lDay = 8 then
            strDay := Text0016Txt;
        if lDay = 9 then
            strDay := Text0017Txt;
        if lDay = 10 then
            strDay := Text0018Txt;
        if lDay = 11 then
            strDay := Text0019Txt;
        if lDay = 12 then
            strDay := Text00120Txt;
        if lDay = 13 then
            strDay := Text00121Txt;
        if lDay = 14 then
            strDay := Text00122Txt;
        if lDay = 15 then
            strDay := Text00123Txt;
        if lDay = 16 then
            strDay := Text00124Txt;
        if lDay = 17 then
            strDay := Text00125Txt;
        if lDay = 18 then
            strDay := Text00126Txt;
        if lDay = 19 then
            strDay := Text00127Txt;
        if lDay = 20 then
            strDay := Text00128Txt;
        if lDay = 21 then
            strDay := Text00129Txt;
        if lDay = 22 then
            strDay := Text00130Txt;
        if lDay = 23 then
            strDay := Text001221Txt;
        if lDay = 24 then
            strDay := Text001222Txt;
        if lDay = 25 then
            strDay := Text001223Txt;
        if lDay = 26 then
            strDay := Text001224Txt;
        if lDay = 27 then
            strDay := Text001225Txt;
        if lDay = 28 then
            strDay := Text001226Txt;
        if lDay = 29 then
            strDay := Text001227Txt;
        if lDay = 30 then
            strDay := Text001228Txt;
        if lDay = 31 then
            strDay := Text001229Txt;

        if lMonth = 1 then
            StrMonth := Text001230Txt;
        if lMonth = 2 then
            StrMonth := Text001231Txt;
        if lMonth = 3 then
            StrMonth := Text001232Txt;
        if lMonth = 4 then
            StrMonth := Text001233Txt;
        if lMonth = 5 then
            StrMonth := Text001234Txt;
        if lMonth = 6 then
            StrMonth := Text001235Txt;
        if lMonth = 7 then
            StrMonth := Text001236Txt;
        if lMonth = 8 then
            StrMonth := Text001237Txt;
        if lMonth = 9 then
            StrMonth := Text001238Txt;
        if lMonth = 10 then
            StrMonth := Text001239Txt;
        if lMonth = 11 then
            StrMonth := Text001240Txt;
        if lMonth = 12 then
            StrMonth := Text001241Txt;

        strYear := FORMAT(lYear);
        strDate := strDay + StrMonth + strYear;
    end;
}

