table 33001232 ESI_B2B
{
    // version B2BHR1.00.00

    Caption = 'ESI';
    LookupPageID = "ESI List B2B";
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
                ESI.RESET();
                ESI.SETRANGE("Effective Date", "Effective Date");
                if ESI.FINDFIRST() then
                    ERROR(Text001Lbl, "Effective Date");
            end;
        }
        field(3; "Employer %"; Decimal)
        {
            Caption = 'Employer %';
            DataClassification = CustomerContent;
        }
        field(4; "Employee %"; Decimal)
        {
            Caption = 'Employee %';
            DataClassification = CustomerContent;
        }
        field(5; "Rounding Amount"; Decimal)
        {
            Caption = 'Rounding Amount';
            DataClassification = CustomerContent;
        }
        field(6; "Rounding Method"; Option)
        {
            Caption = 'Rounding Method';
            OptionMembers = Nearest,Up,Down;
            DataClassification = CustomerContent;
        }
        field(7; "ESI Salary Amount"; Decimal)
        {
            Caption = 'ESI Salary Amount';
            DataClassification = CustomerContent;
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
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
        if ESI.FINDLAST() then
            Id := ESI.Id + 1
        else
            Id := 1;
    end;

    var
        ESI: Record ESI_B2B;
        Text001Lbl: Label 'Record exists with Effective Date%1', Comment = '%1 = EffectiveDate';
}

