table 33001224 "Other PayElements B2B"
{
    // version B2BHR1.00.00

    Caption = 'Other PayElements';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Employee No.") then
                    "Employee Name" := Employee."First Name";
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
            DataClassification = CustomerContent;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(5; "Pay Element Code"; Code[30])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Deductions B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if PayDeduct.GET("Pay Element Code") then begin
                    Description := PayDeduct.Description;
                    "Add/Deduct" := PayDeduct."Add/Deduct";
                    Type := PayDeduct.Type;
                end;
            end;
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(8; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(9; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(11; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Canteen,Holiday Compensation,OT,LED,Others';
            OptionMembers = " ",Canteen,"Holiday Compensation",OT,LED,Others;
            DataClassification = CustomerContent;
        }
        field(12; Exception; Boolean)
        {
            Caption = 'Exception';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Month, Year, "Pay Element Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
        PayDeduct: Record "Pay Deductions B2B";
        Text001Lbl: Label 'Hrs per Day %1', Comment = '%1 = ';
        Text002Lbl: Label 'Ot rate %1', Comment = '%1 = ';
        Text003Lbl: Label 'OTAmount %1', Comment = '%1 = ';
        PAYCADRETxt: Label 'PAY CADRE';
        AddDedTxt: Label 'ADDITIONS AND DEDUCTIONS';
        BASICTxt: Label 'BASIC';
        AFTERBASICTxt: Label 'AFTER BASIC';
        AFTERBASICANDDATxt: Label 'AFTER BASIC AND DA';
        DATxt: Label 'DA';

    procedure UpdateProcSalary(OtherDeduct: Record "Other PayElements B2B");
    var
        PostedOtherDeductions: Record "Posted Other PayElements B2B";
    begin
        PostedOtherDeductions.INIT();
        PostedOtherDeductions.TRANSFERFIELDS(OtherDeduct);
        PostedOtherDeductions.INSERT();
    end;

    procedure CanteenAmount(OtherPayElement: Record "Other PayElements B2B");
    var
        Lookup_B2B: Record Lookup_B2B;
        Rate: Decimal;
    begin
        Employee.SETRANGE("No.", OtherPayElement."Employee No.");
        if Employee.FINDFIRST() then begin
            Lookup_B2B.SETRANGE("LookupType Name", PAYCADRETxt);
            Lookup_B2B.SETRANGE("Lookup Name", Employee."Pay Cadre");
            if Lookup_B2B.FINDFIRST() then
                Rate := Lookup_B2B."Per Meal Rate";
        end;
        OtherPayElement.Amount := Rate * OtherPayElement.Quantity;
        OtherPayElement.MODIFY();
    end;

    procedure MonthDays(MonthNum: Integer): Integer;
    begin
        if (MonthNum = 1) or (MonthNum = 3) or (MonthNum = 5) or (MonthNum = 7) or (MonthNum = 8) or (MonthNum = 10) or (MonthNum = 12)
        then
            exit(31)
        else
            if MonthNum = 2 then
                exit(28)
            else
                exit(30);
    end;

    procedure OTcalc(OtherPayElements: Record "Other PayElements B2B");
    var
        Lookup_B2B: Record Lookup_B2B;
        PayElements: Record "Pay Elements B2B";
        EmpShift: Record "Employee Shift B2B";
        CheckDate: Date;
        TotalAmount: Decimal;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        Days: Decimal;
        HoursPerDay: Decimal;
        Otrate: Decimal;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        CheckTime: Time;
    begin
        DA := 0;
        CheckDate := DMY2DATE(1, OtherPayElements.Month, OtherPayElements.Year);
        EmpShift.SETRANGE("Employee Code", OtherPayElements."Employee No.");
        EmpShift.SETFILTER("Start Date", '<=%1', CheckDate);
        if EmpShift.FINDLAST() then
            CheckTime := 130000T;
        if EmpShift."Shift End Time" <> 000000T then
            if (EmpShift."Shift Start Time" > CheckTime) and (EmpShift."Shift End Time" < CheckTime) then begin
                StartDateTime := CREATEDATETIME(EmpShift."Start Date", EmpShift."Shift Start Time");
                EndDateTime := CREATEDATETIME((EmpShift."Start Date" + 1), EmpShift."Shift End Time");
                HoursPerDay := ABS(((StartDateTime - EndDateTime) / 3600000)) - EmpShift."Break Duration";
            end else
                HoursPerDay := ABS(((EmpShift."Shift Start Time" - EmpShift."Shift End Time") / 3600000)) - EmpShift."Break Duration";
        MESSAGE(Text001Lbl, HoursPerDay);
        Employee.RESET();
        Employee.SETRANGE("No.", OtherPayElements."Employee No.");
        Employee.SETRANGE("OT Applicable", true);

        if Employee.FINDFIRST() then
            Otrate := Employee."OT Calculation Rate";
        MESSAGE(Text002Lbl, Otrate);
        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETRANGE("Applicable for OT", true);

        if Lookup_B2B.FINDFIRST() then
            repeat
                PayElements.SETRANGE("Employee Code", OtherPayElements."Employee No.");
                PayElements.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                PayElements.SETFILTER("Effective Start Date", '<%1', CheckDate);
                if PayElements.FINDLAST() then
                    if PayElements."Pay Element Code" = BASICTxt then begin
                        Total := PayElements."Amount / Percent";
                        Basic := Total;
                    end else
                        if (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Fixed) then
                            Total := PayElements."Amount / Percent"
                        else
                            if (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) and
                               (PayElements."Computation Type" = AFTERBASICTxt)
                   then
                                Total := (PayElements."Amount / Percent" * Basic) / 100
                            else
                                if (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) and
                                   (PayElements."Computation Type" = AFTERBASICANDDATxt)
                           then
                                    Total := (PayElements."Amount / Percent" * (Basic + DA)) / 100;

                if PayElements."Pay Element Code" = DATxt then
                    DA := Total;
                if PayElements."Add/Deduct" = PayElements."Add/Deduct"::Addition then
                    TotalAmount := TotalAmount + Total
                else
                    TotalAmount := TotalAmount - Total;

            until Lookup_B2B.NEXT() = 0;
        MESSAGE('%1', TotalAmount);
        Days := MonthDays(OtherPayElements.Month);
        OtherPayElements.Amount := (TotalAmount * OtherPayElements.Quantity * Otrate) / (Days * HoursPerDay);
        MESSAGE(Text003Lbl, OtherPayElements.Amount);
        OtherPayElements.MODIFY();
    end;
}

