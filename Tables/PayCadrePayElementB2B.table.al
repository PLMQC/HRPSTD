table 33001215 "Pay Cadre Pay Element B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Cadre Pay Element';
    DataClassification = CustomerContent;
    fields
    {
        field(2; "Pay Cadre Code"; Code[20])
        {
            Caption = 'Pay Cadre Code';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(20));
            DataClassification = CustomerContent;
        }
        field(3; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Pay Element Code" = BASICTxt then
                    if "Fixed/Percent" = "Fixed/Percent"::Percent then
                        ERROR(Text001Lbl);
            end;
        }
        field(4; "Computation Type"; Code[50])
        {
            Caption = 'Computation Type';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('COMPUTATION TYPE'));
            DataClassification = CustomerContent;

            trigger OnValidate();
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
                        ERROR(Text005Lbl);
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
                    ERROR(Text006Lbl);

                Lookup_B2B.RESET();
                Lookup_B2B.SetRange("Lookup Type", 16);
                Lookup_B2B.SETRANGE("Lookup Name", "Pay Element Code");
                if Lookup_B2B.FINDFIRST() then begin
                    "Add/Deduct" := Lookup_B2B."Add/Deduct";
                    "Applicable for OT" := Lookup_B2B."Applicable for OT";
                    ESI := Lookup_B2B.ESI;
                    PF := Lookup_B2B.PF;
                    "Leave Encashment" := Lookup_B2B."Leave Encashment";
                    "Bonus/Exgratia" := Lookup_B2B."Bonus/Exgratia";
                    Gratuity := Lookup_B2B.Gratuity;
                    PT := Lookup_B2B.PT;
                    if "Pay Element Code" = BASICTxt then
                        "Computation Type" := ONATTENDANCETxt;
                end;
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
            DataClassification = CustomerContent;
        }
        field(12; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
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
            DataClassification = CustomerContent;
            Caption = 'Processed';
        }
        field(16; ESI; Option)
        {
            Caption = 'ESI';
            OptionCaption = ',Regular Element,Irregular Element';
            OptionMembers = " ","Regular Element","Irregular Element";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                PayElement: Record "Pay Elements B2B";
            begin
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE("Lookup Name", "Pay Element Code");
                if Lookup_B2B.FINDFIRST() then
                    repeat
                        ESI := Lookup_B2B.ESI;
                        PayElement.MODIFY();
                    until Lookup_B2B.NEXT() = 0;
            end;
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
        field(19; "Bonus/Exgratia"; Option)
        {
            Caption = 'Bonus/Exgratia';
            OptionCaption = ' ,Bonus,Ex-gratia,Both';
            OptionMembers = " ",Bonus,"Ex-gratia",Both;
            DataClassification = CustomerContent;
        }
        field(20; Gratuity; Boolean)
        {
            Caption = 'Gratuity';
            DataClassification = CustomerContent;
        }
        field(21; PT; Boolean)
        {
            Caption = 'PT';
            DataClassification = CustomerContent;
        }
        field(30; "Applicable for C Off"; Boolean)
        {
            Caption = 'Applicable for C Off';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Pay Cadre Code", "Effective Start Date", "Pay Element Code")
        {
        }
        key(Key2; "Computation Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Lookup_B2B: Record Lookup_B2B;
        Text001Lbl: Label 'Basic Should be  Fixed Amount';
        Text002Lbl: Label 'Computation Type must be After Basic OR After Basic and DA';
        Text003Lbl: Label 'Computation Type must not be After Basic and DA';
        Text005Lbl: Label 'Computation Type must be ON Attendance';
        Text006Lbl: Label 'System defined pay element should not be selected.';
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

