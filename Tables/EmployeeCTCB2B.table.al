table 33001287 "Employee CTC B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee CTC_B2B';
    DataCaptionFields = "Emp Code";

    fields
    {
        field(1; "Emp Code"; Code[20])
        {
            Caption = 'Emp Code';
            DataClassification = CustomerContent;
        }
        field(2; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(3; year; Integer)
        {
            Caption = 'year';
            DataClassification = CustomerContent;
        }
        field(4; Basic; Decimal)
        {
            Caption = 'Basic';
            DataClassification = CustomerContent;
        }
        field(5; HRA; Decimal)
        {
            Caption = 'HRA';
            DataClassification = CustomerContent;
        }
        field(6; CA; Decimal)
        {
            Caption = 'CA';
            DataClassification = CustomerContent;
        }
        field(7; CCA; Decimal)
        {
            Caption = 'CCA';
            DataClassification = CustomerContent;
        }
        field(8; WA; Decimal)
        {
            Caption = 'WA';
            DataClassification = CustomerContent;
        }
        field(9; FDA; Decimal)
        {
            Caption = 'FDA';
            DataClassification = CustomerContent;
        }
        field(10; VDA; Decimal)
        {
            Caption = 'VDA';
            DataClassification = CustomerContent;
        }
        field(11; "SPEL ALL"; Decimal)
        {
            Caption = 'SPEL ALL';
            DataClassification = CustomerContent;
        }
        field(12; PF; Decimal)
        {
            Caption = 'PF';
            DataClassification = CustomerContent;
        }
        field(13; ESI; Decimal)
        {
            Caption = 'ESI';
            DataClassification = CustomerContent;
        }
        field(14; Medical; Decimal)
        {
            Caption = 'Medical';
            DataClassification = CustomerContent;
        }
        field(15; Stipend; Decimal)
        {
            Caption = 'Stipend';
            DataClassification = CustomerContent;
        }
        field(16; Conreim; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Conreim';
        }
        field(17; Trainee; Boolean)
        {
            Caption = 'Trainee';
            DataClassification = CustomerContent;
        }
        field(18; Total; Decimal)
        {
            Caption = 'Total';
            DataClassification = CustomerContent;
        }
        field(19; "First Name"; Text[30])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(20; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }
        field(21; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(25; "Letter Code"; Code[10])
        {
            Caption = 'Letter Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Emp Code")
        {
        }
    }

    fieldgroups
    {
    }
}

