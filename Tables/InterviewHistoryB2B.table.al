table 33001206 "Interview History B2B"
{
    // version B2BHR1.00.00

    Caption = 'Interview History';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Recruitment Header No"; Code[20])
        {
            Caption = 'Recruitment Header No';
            DataClassification = CustomerContent;
        }
        field(2; "Recruitment Line No."; Integer)
        {
            Caption = 'Recruitment Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Resume Reference No."; Code[20])
        {
            Caption = 'Resume Reference No.';
            TableRelation = "Resume Database B2B"."No.";
            DataClassification = CustomerContent;
        }
        field(4; "Interview Type"; Code[20])
        {
            Caption = 'Interview Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('INTERVIEW TYPES'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Lookup_B2B.SETRANGE("Lookup Name", "Interview Type");
                if Lookup_B2B.FINDFIRST() then
                    Description := Lookup_B2B.Description;
            end;
        }
        field(5; "Date of Interview"; Date)
        {
            Caption = 'Date of Interview';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Last Date Modified" := WORKDATE();
            end;
        }
        field(6; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Last Date Modified" := WORKDATE();
            end;
        }
        field(7; "Interview Call Date"; Date)
        {
            Caption = 'Interview Call Date';
            DataClassification = CustomerContent;
        }
        field(8; "Informed By"; Code[50])
        {
            Caption = 'Informed By';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then
                    "Informed By" := Employee."User Id";
            end;

            trigger OnValidate();
            begin
                "Last Date Modified" := WORKDATE();
            end;
        }
        field(9; "Interviewed Date"; Date)
        {
            Caption = 'Interviewed Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Last Date Modified" := WORKDATE();
            end;
        }
        field(10; "Interviewed By"; Code[50])
        {
            Caption = 'Interviewed By';
            TableRelation = "Employee B2B"."No.";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then
                    "Interviewed By" := Employee."User Id";
            end;

            trigger OnValidate();
            begin
                "Last Date Modified" := WORKDATE();
            end;
        }
        field(11; "Interview Status"; Code[20])
        {
            Caption = 'Interview Status';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('INTERVIEW STATUS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Last Date Modified" := WORKDATE();
            end;
        }
        field(12; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(13; "User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
        }
        field(15; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(16; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = CustomerContent;
        }
        field(17; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Recruitment Header No", "Recruitment Line No.", "Resume Reference No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        Evaluate("User Id", USERID());
    end;

    var
        Lookup_B2B: Record Lookup_B2B;
        Employee: Record "Employee B2B";
}

