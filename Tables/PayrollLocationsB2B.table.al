table 33001362 "Payroll Locations B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Locations';
    DrillDownPageID = "Payroll Locations List B2B";
    LookupPageID = "Payroll Locations List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(2; "Location Name"; Text[50])
        {
            Caption = 'Location Name';
            DataClassification = CustomerContent;
        }
        field(3; "Location Type"; Option)
        {
            Caption = 'Location Type';
            OptionCaption = ' ,Metro,Non Metro';
            OptionMembers = " ",Metro,"Non Metro";
            DataClassification = CustomerContent;
        }
        field(4; "Location Incharge"; Code[50])
        {
            Caption = 'Location Incharge';
            Editable = true;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                User: Record User;

            begin
                if "Location Incharge" <> '' then
                    ERROR(Text002Lbl);

                "Location Incharge" := LoginMgt.OpenUserPageForSelectedUser(User);
            end;

            trigger OnValidate();
            begin
                if "Location Incharge" = '' then
                    ERROR(Text001Lbl);
            end;
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(7; TeleFax; Text[30])
        {
            Caption = 'TeleFax';
            DataClassification = CustomerContent;
        }
        field(8; State; Code[10])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(9; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region".Code;
            DataClassification = CustomerContent;
        }
        field(10; "PTO Circle No."; Code[10])
        {
            Caption = 'PTO Circle No.';
            DataClassification = CustomerContent;
        }
        field(11; "PF No."; Code[20])
        {
            Caption = 'PF No.';
            DataClassification = CustomerContent;
        }
        field(12; "PT Certificate No."; Code[10])
        {
            Caption = 'PT Certificate No.';
            DataClassification = CustomerContent;
        }
        field(13; "ESI No."; Code[20])
        {
            Caption = 'ESI No.';
            DataClassification = CustomerContent;
        }
        field(14; "PF Logo"; MediaSet)
        {
            Caption = 'PF Logo';
            DataClassification = CustomerContent;
        }
        field(15; "ESIC Logo"; MediaSet)
        {
            Caption = 'ESIC Logo';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LoginMgt: Codeunit "Payroll Branch wise Misc B2B";
        Text001Lbl: Label 'Location Incharge must have a value';
        Text002Lbl: Label 'Location Incharge cannot be changed';
}

