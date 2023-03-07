table 33001223 "Pay Deductions B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Deductions';
    DrillDownPageID = "Pay Deductions B2B";
    LookupPageID = "Pay Deductions B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Pay Element code"; Code[30])
        {
            Caption = 'Pay Element code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                Lookup_B2B.SETRANGE("LookupType Name", ADDITIONSANDDEDUCTIONSTxt);
                Lookup_B2B.SETRANGE("Lookup Name", "Pay Element code");
                if Lookup_B2B.FINDFIRST() then begin
                    Description := Lookup_B2B.Description;
                    "Add/Deduct" := Lookup_B2B."Add/Deduct";
                    Priority := Lookup_B2B.Priority;
                end;
            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(4; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Canteen,Holiday Compensation,OT,Late Coming,Others';
            OptionMembers = " ",Canteen,"Holiday Compensation",OT,"Late Coming",Others;
            DataClassification = CustomerContent;
        }
        field(11; "Calculate Arrears"; Boolean)
        {
            Caption = 'Calculate Arrears';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Pay Element code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Lookup_B2B: Record Lookup_B2B;
        ADDITIONSANDDEDUCTIONSTxt: Label 'ADDITIONS AND DEDUCTIONS';
}

