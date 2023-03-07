table 33001300 "Grade Wise Leaves B2B"
{
    // version B2BHR1.00.00

    Caption = 'Grade Wise Leaves_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            NotBlank = true;
            TableRelation = "Leave Master B2B"."Leave Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Leave Description" = '' then
                    if LeaveMaster.GET("Leave Code") then
                        "Leave Description" := LeaveMaster.Description;


                if "Leaves in Crediting Interval" = 0 then
                    if LeaveMaster.GET("Leave Code") then
                        VALIDATE("Leaves in Crediting Interval", LeaveMaster."Leaves in Crediting Interval");


                if FORMAT("Crediting Interval") = '' then
                    if LeaveMaster.GET("Leave Code") then
                        VALIDATE("Crediting Interval", LeaveMaster."Crediting Interval");

            end;
        }
        field(3; "Leave Description"; Text[50])
        {
            Caption = 'Leave Description';
            DataClassification = CustomerContent;
        }
        field(4; "Leave Pay Cadre"; Code[50])
        {
            Caption = 'Leave Pay Cadre';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(22));
            DataClassification = CustomerContent;
        }
        field(8; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                PayrollYearRec.RESET();
                PayrollYearRec.SETRANGE("Year Type", LEAVEYEARTxt);
                PayrollYearRec.SETRANGE(Closed, false);
                if PAGE.RUNMODAL(0, PayrollYearRec) = ACTION::LookupOK then begin
                    "Start Date" := PayrollYearRec."Year Start Date";
                    "End Date" := PayrollYearRec."Year End Date";
                end;
            end;
        }
        field(10; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(12; "Applicable Date"; Date)
        {
            Caption = 'Applicable Date';
            DataClassification = CustomerContent;
        }
        field(14; "No. of Leaves in Year"; Decimal)
        {
            Caption = 'No. of Leaves in Year';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(16; "Crediting Interval"; DateFormula)
        {
            Caption = 'Crediting Interval';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CreditInterval := COPYSTR(FORMAT("Crediting Interval"), 1, 1);
                if CreditInterval = '-' then
                    ERROR(Text001Lbl);

                UpdateTotalLeaves();
            end;
        }
        field(18; "Crediting Type"; Option)
        {
            Caption = 'Crediting Type';
            OptionCaption = 'Before the Period,After the Period';
            OptionMembers = "Before the Period","After the Period";
            DataClassification = CustomerContent;
        }
        field(20; "Minimum Allowed"; Decimal)
        {
            Caption = 'Minimum Allowed';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(22; "Maximum Allowed"; Decimal)
        {
            Caption = 'Maximum Allowed';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(24; "Carry Forward"; Boolean)
        {
            Caption = 'Carry Forward';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin


                TESTFIELD("Max.Leaves to Carry Forward", 0);
            end;
        }
        field(26; "Max.Leaves to Carry Forward"; Decimal)
        {
            Caption = 'Max.Leaves to Carry Forward';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Carry Forward", true);
            end;
        }
        field(28; "Applicable During Probation"; Boolean)
        {
            Caption = 'Applicable During Probation';
            DataClassification = CustomerContent;
        }
        field(30; "No.of Leaves During Probation"; Decimal)
        {
            Caption = 'No.of Leaves During Probation';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(32; Encashable; Boolean)
        {
            Caption = 'Encashable';
            DataClassification = CustomerContent;
        }
        field(34; "Min. Encashable"; Decimal)
        {
            Caption = 'Min. Encashable';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(35; "Off Days b/w Leaves"; Boolean)
        {
            Caption = 'Off Days b/w Leaves';
            DataClassification = CustomerContent;
        }
        field(36; "Max. Encashable"; Decimal)
        {
            Caption = 'Max. Encashable';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(38; "Encashment in excess of."; Decimal)
        {
            Caption = 'Encashment in excess of.';
            DataClassification = CustomerContent;
        }
        field(40; "Leaves in Crediting Interval"; Decimal)
        {
            Caption = 'Leaves in Crediting Interval';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                CreditingInterval: Text[30];
                Position: Integer;
                CheckString: Text[30];
            begin
                CreditingInterval := FORMAT("Leaves in Crediting Interval");
                Position := STRPOS(CreditingInterval, '.');
                if Position <> 0 then begin
                    CheckString := COPYSTR(CreditingInterval, Position, 30);
                    if CheckString <> '.5' then
                        ERROR(Text002Lbl);
                end;

                UpdateTotalLeaves();
            end;
        }
        field(41; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(50; "Final Settlement Encashable"; Boolean)
        {
            Caption = 'Final Settlement Encashable';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Leave Code", "Leave Pay Cadre", "Applicable Date", "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        EmpLeave.SETRANGE("Leave Pay Cadre", "Leave Pay Cadre");
        EmpLeave.SETRANGE("Leave Code", "Leave Code");
        if EmpLeave.FINDFIRST() then
            ERROR(Text000Lbl);
    end;

    trigger OnInsert();
    begin
        if "Leave Description" = '' then
            if LeaveMaster.GET("Leave Code") then
                "Leave Description" := LeaveMaster.Description;


        if "Leaves in Crediting Interval" = 0 then
            if LeaveMaster.GET("Leave Code") then
                VALIDATE("Leaves in Crediting Interval", LeaveMaster."Leaves in Crediting Interval");


        if FORMAT("Crediting Interval") = '' then
            if LeaveMaster.GET("Leave Code") then
                VALIDATE("Crediting Interval", LeaveMaster."Crediting Interval");

    end;

    var
        PayrollYearRec: Record "Payroll Year B2B";
        EmpLeave: Record "Employee Leaves B2B";
        LeaveMaster: Record "Leave Master B2B";
        Text000Lbl: Label 'Employee leave records exist. So you can not delete.';
        CreditInterval: Text[30];
        Text001Lbl: Label 'Negative values is not allowed.';
        Text002Lbl: Label 'Must be half day';
        LEAVEYEARTxt: Label 'LEAVE YEAR';
        OneMonthExprLbl: Label '<+1M>';

    procedure UpdateTotalLeaves();
    var
        TempDate: Date;
        TempDate1: Date;
        NoofMonths: Integer;
    begin
        if FORMAT("Crediting Interval") <> '' then begin
            NoofMonths := 0;
            TempDate := WORKDATE();
            TempDate1 := WORKDATE();
            TempDate := CALCDATE("Crediting Interval", TempDate);
            repeat
                TempDate1 := CALCDATE(OneMonthExprLbl, TempDate1);
                NoofMonths += 1;
            until TempDate1 >= TempDate;
            "No. of Leaves in Year" := "Leaves in Crediting Interval" * 12 / NoofMonths;
        end;
    end;
}

