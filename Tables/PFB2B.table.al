table 33001231 PF_B2B
{
    // version B2BHR1.00.00

    Caption = 'PF';
    DataCaptionFields = "Effective Date";
    LookupPageID = "PF List B2B";
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
                PF.RESET();
                PF.SETRANGE("Effective Date", "Effective Date");
                if PF.FINDFIRST() then
                    ERROR(Text001Lbl, "Effective Date");
            end;
        }
        field(3; "Employer Contribution"; Decimal)
        {
            Caption = 'Employer Contribution';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(4; "Employee Contribution"; Decimal)
        {
            Caption = 'Employee Contribution';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5; "Rounding Amount"; Decimal)
        {
            Caption = 'Rounding Amount';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(6; "Rounding Method"; Option)
        {
            Caption = 'Rounding Method';
            OptionMembers = Nearest,Up,Down;
            DataClassification = CustomerContent;
        }
        field(7; "EPS %"; Decimal)
        {
            Caption = 'EPS %';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(8; "Admin Charges %"; Decimal)
        {
            Caption = 'Admin Charges %';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(9; "EDLI %"; Decimal)
        {
            Caption = 'EDLI %';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(10; "RIFA %"; Decimal)
        {
            Caption = 'RIFA %';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(11; "PF Amount"; Decimal)
        {
            Caption = 'PF Amount';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(12; "Employer EPS Max.Amt Lmt"; Decimal)
        {
            Caption = 'Employer EPS Max.Amt Lmt';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(14; "PF Applicable On"; Integer)
        {
            Caption = 'PF Applicable On';
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
        if PF.FINDLAST() then
            Id := PF.Id + 1
        else
            Id := 1;
    end;

    var
        PF: Record PF_B2B;
        Text001Lbl: Label 'Record exists with Effective Date%1', Comment = '%1 = Effective Date';
}

