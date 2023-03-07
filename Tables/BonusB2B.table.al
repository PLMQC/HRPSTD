table 33001241 Bonus_B2B
{
    // version B2BHR1.00.00

    Caption = 'Bonus';
    DrillDownPageID = "Bonus List B2B";
    LookupPageID = "Bonus List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            DataClassification = CustomerContent;
        }
        field(2; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Bonus.RESET();
                Bonus.SETRANGE("Effective Date", "Effective Date");
                if Bonus.FINDFIRST() then
                    ERROR(Text001Lbl, "Effective Date");
            end;
        }
        field(3; "Bonus%"; Decimal)
        {
            Caption = 'Bonus%';
            DataClassification = CustomerContent;
        }
        field(4; "Ex-gratia%"; Decimal)
        {
            Caption = 'Ex-gratia%';
            DataClassification = CustomerContent;
        }
        field(5; "Min.Bonusable Salary"; Decimal)
        {
            Caption = 'Min.Bonusable Salary';
            DataClassification = CustomerContent;
        }
        field(6; "Bonus Amount"; Decimal)
        {
            Caption = 'Bonus Amount';
            DataClassification = CustomerContent;
        }
        field(7; "Bouns Amount 8.33%"; Decimal)
        {
            Caption = 'Bouns Amount 8.33%';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if Bonus.FINDLAST() then
            Id := Bonus.Id + 1
        else
            Id := 1;
    end;

    var
        Bonus: Record Bonus_B2B;
        Text001Lbl: Label 'Record exists with Effective Date%1', Comment = '%1 = Effective Date';
}

