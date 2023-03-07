table 33001191 "Lookup Type B2B"
{
    // version B2BHR1.00.00

    Caption = 'Lookup Type';
    DrillDownPageID = "Lookup Types B2B";
    LookupPageID = "Lookup Types B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No';
            DataClassification = CustomerContent;
        }
        field(2; Name; Code[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "System Defined"; Boolean)
        {
            Caption = 'System Defined';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if "System Defined" then
            ERROR(Text000Lbl);
    end;

    trigger OnModify();
    begin
        if "System Defined" then
            ERROR(Text000Lbl);
    end;

    trigger OnRename();
    begin
        if "System Defined" then
            ERROR(Text000Lbl);
    end;

    var
        Text000Lbl: Label 'You cannot modify or delete the system defined records.';
}

