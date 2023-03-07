table 33001214 "Pay Elements B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Elements';
    DataClassification = CustomerContent;
    fields
    {
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            NotBlank = true;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                AfterBasixLbl: Label 'AFTER BASIC and Fixed is not acceptable';
            begin
                if "Pay Element Code" = BASICTxt then
                    if "Fixed/Percent" = "Fixed/Percent"::Percent then
                        ERROR(Text001Lbl);
                if (("Computation Type" = AFTERBASICTxt) or ("Computation Type" = AFTERBASICANDDATxt)) and ("Fixed/Percent" = "Fixed/Percent"::"Fixed") then
                    Error(AfterBasixLbl);
            end;
        }
        field(4; "Computation Type"; Code[50])
        {
            Caption = 'Computation Type';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('COMPUTATION TYPE'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                AfterBasixLbl: Label 'AFTER BASIC and Fixed is not acceptable';
            begin
                if "Fixed/Percent" = "Fixed/Percent"::Percent then
                    if ("Computation Type" = NONATTENDANCETxt) or ("Computation Type" = ONATTENDANCETxt) then
                        ERROR(Text002Lbl);
                if "Pay Element Code" = DATxt then
                    if "Computation Type" = AFTERBASICANDDATxt then
                        ERROR(Text003Lbl);
                if "Pay Element Code" = BASICTxt then
                    if ("Computation Type" = AFTERBASICTxt) or ("Computation Type" = AFTERBASICANDDATxt) or
                       ("Computation Type" = NONATTENDANCETxt)
                    then
                        ERROR(Text004Lbl);
                if (("Computation Type" = AFTERBASICTxt) or ("Computation Type" = AFTERBASICANDDATxt)) and ("Fixed/Percent" = "Fixed/Percent"::"Fixed") then
                    Error(AfterBasixLbl);
            end;
        }
        field(5; "Pay Element Code"; Code[30])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Pay Element Code" = TDSTxt) or ("Pay Element Code" = PFTxt) or
                  ("Pay Element Code" = PTTxt) or ("Pay Element Code" = ESITxt) or ("Pay Element Code" = LOANTxt) or
                  ("Pay Element Code" = OTTxt) or ("Pay Element Code" = LEAVEENCASHMENTTxt)
                then
                    ERROR(Text005Lbl);

                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE("Lookup Name", "Pay Element Code");
                Lookup_B2B.SETRANGE("Lookup Type", 16);
                if Lookup_B2B.FINDSET() then begin
                    "Add/Deduct" := Lookup_B2B."Add/Deduct";
                    "Applicable for OT" := Lookup_B2B."Applicable for OT";
                    ESI := Lookup_B2B.ESI;
                    PF := Lookup_B2B.PF;
                    PT := Lookup_B2B.PT;
                    "Leave Encashment" := Lookup_B2B."Leave Encashment";
                    "Bonus/Exgratia" := Lookup_B2B."Bonus/Exgratia";
                    Gratuity := Lookup_B2B.Gratuity;
                    if "Pay Element Code" = BASICTxt then
                        "Computation Type" := ONATTENDANCETxt;
                end;
                if Employee.GET("Employee Code") then
                    "Pay Cadre" := Employee."Pay Cadre";
            end;
        }
        field(6; "Loan Priority No"; Integer)
        {
            Caption = 'Loan Priority No';
            DataClassification = CustomerContent;
        }
        field(11; "Amount / Percent"; Decimal)
        {
            Caption = 'Amount / Percent';
            MinValue = 0;
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(12; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            NotBlank = true;
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(13; "Effective Start Date"; Date)
        {
            Caption = 'Effective Start Date';
            DataClassification = CustomerContent;
        }
        field(14; "Applicable for OT"; Boolean)
        {
            Caption = 'Applicable for OT';
            DataClassification = CustomerContent;
        }
        field(15; Processed; Boolean)
        {
            Caption = 'Processed';
            DataClassification = CustomerContent;
        }
        field(16; ESI; Option)
        {
            Caption = 'ESI';
            OptionCaption = ' ,Regular Element,Irregular Element';
            OptionMembers = " ","Regular Element","Irregular Element";
            DataClassification = CustomerContent;

        }
        field(17; PF; Boolean)
        {
            Caption = 'PF';
            DataClassification = CustomerContent;
        }
        field(18; "Leave Encashment"; Boolean)
        {
            Caption = 'Leave Encashment';
            DataClassification = CustomerContent;
        }
        field(19; "Pay Cadre"; Code[30])
        {
            Caption = 'Pay Cadre';
            DataClassification = CustomerContent;
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            DataClassification = CustomerContent;
        }
        field(21; "Bonus/Exgratia"; Option)
        {
            Caption = 'Bonus/Exgratia';
            OptionCaption = ' ,Bonus,Ex-gratia,Both';
            OptionMembers = " ",Bonus,"Ex-gratia",Both;
            DataClassification = CustomerContent;
        }
        field(22; Gratuity; Boolean)
        {
            Caption = 'Gratuity';
            DataClassification = CustomerContent;
        }
        field(23; PT; Boolean)
        {
            Caption = 'PT';
            DataClassification = CustomerContent;
        }
        field(24; "Active Pay Elements"; Boolean)
        {
            Caption = 'Active Pay Elements';
            DataClassification = CustomerContent;
        }
        field(30; "Applicable for C Off"; Boolean)
        {
            Caption = 'Applicable for C Off';
            DataClassification = CustomerContent;
        }
        field(95; Location; Text[30])
        {
            Caption = 'Location';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Effective Start Date", "Pay Element Code")
        {
        }
        key(Key2; "Computation Type")
        {
        }
        key(Key3; "Effective Start Date")
        {
        }
        key(Key4; "Employee Code", "Pay Element Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
        Lookup_B2B: Record Lookup_B2B;
        Text001Lbl: Label 'Basic Should be  Fixed Amount';
        Text002Lbl: Label 'Computation Type must be After Basic OR After Basic and DA';
        Text003Lbl: Label 'Computation Type must not be After Basic and DA';
        Text004Lbl: Label 'Computation Type must be ON Attendance';
        Text005Lbl: Label 'system defined pay element should not be selected.';
        BASICTxt: Label 'BASIC';
        NONATTENDANCETxt: Label 'NON ATTENDANCE';
        ONATTENDANCETxt: Label 'ON ATTENDANCE';
        DATxt: Label 'DA';
        AFTERBASICANDDATxt: Label 'AFTER BASIC AND DA';
        AFTERBASICTxt: Label 'AFTER BASIC';
        TDSTxt: Label 'TDS';
        PFTxt: Label 'PF';
        PTTxt: Label 'PT';
        ESITxt: Label 'ESI';
        LOANTxt: Label 'LOAN';
        OTTxt: Label 'OT';
        LEAVEENCASHMENTTxt: Label 'LEAVE ENCASHMENT';
}

