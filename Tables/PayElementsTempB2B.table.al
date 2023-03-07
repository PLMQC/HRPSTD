table 33001316 "Pay Elements Temp B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Elements Temp_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            NotBlank = true;
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
                    if ("Computation Type" = NonAttTxt) or ("Computation Type" = OnAttTxt) then
                        ERROR(Text002Lbl);
                if "Pay Element Code" = DATxt then
                    if "Computation Type" = AFTERBASICANDDATxt then
                        ERROR(Text003Lbl);
                if "Pay Element Code" = BASICTxt then
                    if ("Computation Type" = AFTERBASICTxt) or ("Computation Type" = AFTERBASICANDDATxt) or
                       ("Computation Type" = NonAttTxt)
                    then
                        ERROR(Text004Lbl);
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

                Lookup_B2B.SETRANGE("Lookup Name", "Pay Element Code");
                if Lookup_B2B.FINDFIRST() then begin
                    "Add/Deduct" := Lookup_B2B."Add/Deduct";
                    "Applicable for OT" := Lookup_B2B."Applicable for OT";
                    ESI := Lookup_B2B.ESI;
                    PF := Lookup_B2B.PF;
                    PT := Lookup_B2B.PT;
                    "Leave Encashment" := Lookup_B2B."Leave Encashment";
                    "Bonus/Exgratia" := Lookup_B2B."Bonus/Exgratia";
                    Gratuity := Lookup_B2B.Gratuity;
                    if "Pay Element Code" = BASICTxt then
                        "Computation Type" := OnAttTxt;
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
            Caption = 'Processed';
            DataClassification = CustomerContent;
        }
        field(16; ESI; Option)
        {
            OptionMembers = " ","Regular Element","Irregular Element";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var

            begin
            end;
        }
        field(17; PF; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Leave Encashment"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Pay Cadre"; Code[20])
        {
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(20; "Date Filter"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Bonus/Exgratia"; Option)
        {
            OptionMembers = " ",Bonus,"Ex-gratia",Both;
            DataClassification = CustomerContent;
        }
        field(22; Gratuity; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(23; PT; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Active Pay Elements"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(95; Location; Text[30])
        {
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = FILTER(22));
            DataClassification = CustomerContent;
        }
        field(96; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(97; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(98; "Resume Referance No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", "Pay Element Code", "Resume Referance No.")
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
        NonAttTxt: Label 'NON ATTENDANCE';
        OnAttTxt: Label 'ON ATTENDANCE';
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

