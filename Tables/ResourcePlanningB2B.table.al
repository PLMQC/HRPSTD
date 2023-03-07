table 33001409 "Resource Planning B2B"
{
    Caption = 'Resource Planning';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Document No." <> xRec."Document No." then begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."Resource Nos.");
                    "No. Series" := '';
                end;
                Testfield("Indent Created", false);
            end;


        }
        field(2; "Location Code"; code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
            trigger Onvalidate()
            begin
                Testfield("Indent Created", false);
            end;

        }
        field(3; "Department  code"; Code[30])
        {
            Caption = 'Department Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = filter('4'));
            DataClassification = CustomerContent;
            trigger Onvalidate()
            begin
                Testfield("Indent Created", false);
            end;

        }
        field(4; Position; Code[20])
        {
            Caption = 'Position';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = filter('5'));
            DataClassification = CustomerContent;
            trigger Onvalidate()
            begin
                Testfield("Indent Created", false);
            end;

        }

        field(5; "Total No.s"; Integer)
        {
            Caption = 'Total No.s';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalcFields("Avaiable Resource Count");
                if "Total No.s" < ("Avaiable Resource Count" + "Required  Resources") then
                    Error(Text001Lbl);

            end;
        }
        field(6; "Avaiable Resource No.s"; Code[20])
        {
            Caption = 'Avaiable Resource No.s-Remove';
            DataClassification = CustomerContent;


        }
        field(7; "Required  Nos."; code[20])
        {
            Caption = 'Required  Nos.-Remove';
            DataClassification = CustomerContent;
        }
        field(8; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(12; "Avaiable Resource Count"; Integer)
        {
            Caption = 'Avaiable Resource No.s';
            FieldClass = FlowField;
            CalcFormula = count("Employee B2B" WHERE("Department Code" = field("Department  code"), "Location Code" = field("Location Code"), Designation = field(Position), Blocked = const(false)));//B2BMMOn23Feb2023
            Editable = false;
        }
        field(13; "Required  Resources"; Integer)
        {
            Caption = 'Required  Resources';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Testfield("Indent Created", false);
                CalcFields("Avaiable Resource Count");
                if "Total No.s" < ("Avaiable Resource Count" + "Required  Resources") then
                    Error(Text001Lbl);
            end;
        }
        field(16; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(302; "Job Description No."; Code[20])
        {
            Caption = 'Job Description No.';
            TableRelation = "Job Description Header(RO) B2B" where(Department = field("Department  code"), "Job Designation" = field(Position));//B2BMMOnJan2023
            DataClassification = CustomerContent;

            trigger Onvalidate()
            begin
                Testfield("Indent Created", false);

            end;

        }
        field(303; "Indent Created"; Boolean)
        {
            Caption = 'Indent created';
            Editable = false;
            DataClassification = CustomerContent;

        }
        field(305; "Effective date"; Date)
        {
            Caption = 'Effective date';
            DataClassification = CustomerContent;
        }

        field(306; Status; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }



    }

    keys
    {
        key(key1; "Document No.")
        {
            Clustered = true;
        }
    }

    var

        HRSetup: Record "HR Setup B2B";
        ResourcePlaanning: record "Resource Planning B2B";
        NoSeriesMgt: Codeunit 396;
        Text001Lbl: label 'You cannot enter more than Required Number';


    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Resource Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Resource Nos.", xRec."No. Series", 0D, "Document No.", "No. Series");
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        TestField("Indent Created", false);
    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEdit(OldResourcePlaning: Record "Resource Planning B2B"): Boolean
    begin
        with ResourcePlaanning do begin
            ResourcePlaanning := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD("Resource Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Resource Nos.", OldResourcePlaning."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Resource Nos.");
                NoSeriesMgt.SetSeries("Document No.");
                Rec := ResourcePlaanning;
                exit(true);
            end;
        end;
    end;

    procedure Release();
    var
        Text002Lbl: Label 'Do You Want to Release?';
    begin
        TESTFIELD(Status, Status::Open);
        if not CONFIRM(Text002Lbl, false) then
            exit;

        LOCKTABLE();
        Status := Status::Released;
        MODIFY();
    end;

    procedure TestStatusOpen();
    begin
        TESTFIELD(Status, Status::Open);
    end;

    procedure Reopen();
    var
        Text003Lbl: Label 'Do you want to Reopen?';
    begin
        TESTFIELD(Status, Status::Released);
        if not CONFIRM(Text003Lbl, false) then
            exit;

        LOCKTABLE();
        Status := Status::Open;
        MODIFY();
    end;

}