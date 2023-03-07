table 33001202 "Appraisal Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Appraisal Line';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document No."; Integer)
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Designation; Code[50])
        {
            Caption = 'Designation';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            DataClassification = CustomerContent;
        }
        field(4; "Performance Appraisals"; Code[50])
        {
            Caption = 'Performance Appraisals';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PERFORMANCE APPRAISAL'));
            DataClassification = CustomerContent;
        }
        field(5; Weightage; Decimal)
        {
            Caption = 'Weightage';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                WeightageActual();

                if Weightage = 0 then
                    "Total Weightage" := 0;
            end;
        }
        field(6; "Appraisal Points"; Integer)
        {
            Caption = 'Appraisal Points';
            DataClassification = CustomerContent;
        }
        field(7; "Appraisal Starting Date"; Date)
        {
            Caption = 'Appraisal Starting Date';
            DataClassification = CustomerContent;
        }
        field(8; "Appraisal Ending Date"; Date)
        {
            Caption = 'Appraisal Ending Date';
            DataClassification = CustomerContent;
        }
        field(9; "Total Weightage"; Decimal)
        {
            Caption = 'Total Weightage';
            DataClassification = CustomerContent;
        }
        field(15; "S No."; Integer)
        {
            Caption = 'S No.';
            DataClassification = CustomerContent;
        }
        field(16; "Perf App. Description"; Text[80])
        {
            Caption = 'Perf App. Description';
            DataClassification = CustomerContent;
        }
        field(20; "Pay Cadre"; Code[20])
        {
            Caption = 'Pay Cadre';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(21; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Question,Answer,Heading';
            OptionMembers = Question,Answer,Heading;
            DataClassification = CustomerContent;
        }
        field(22; Question; Text[250])
        {
            Caption = 'Question';
            DataClassification = CustomerContent;
        }
        field(23; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(24; Answer; Text[150])
        {
            Caption = 'Answer';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure WeightageActual();
    var
        Appraisal: Record "Appraisal Line B2B";
        TotalQuantity: Decimal;
        TotalPercent: Decimal;
        TotalPercentRound: Decimal;
    begin
        TotalPercentRound := 0;
        TotalQuantity := 0;
        MODIFY();

        Appraisal.RESET();
        Appraisal.SETRANGE("Document No.", "Document No.");
        Appraisal.SETFILTER(Weightage, '<>0');
        Appraisal.SETRANGE(Designation, Designation);
        Appraisal.SETRANGE("Appraisal Starting Date", "Appraisal Starting Date");
        Appraisal.SETRANGE("Appraisal Ending Date", "Appraisal Ending Date");
        if Appraisal.FINDFIRST() then begin
            repeat
                TotalQuantity := TotalQuantity + Appraisal.Weightage;
            until Appraisal.NEXT() = 0;

            if TotalQuantity = 0 then
                TotalQuantity := 1;
            if Appraisal.FINDFIRST() then
                repeat
                    TotalPercent := TotalPercent + Appraisal.Weightage / TotalQuantity * 100;
                    Appraisal."Total Weightage" := ROUND(TotalPercent, 0.01) - TotalPercentRound;
                    TotalPercentRound := TotalPercentRound + Appraisal."Total Weightage";
                    Appraisal.MODIFY();
                until Appraisal.NEXT() = 0;
        end;
        FIND();
    end;
}

