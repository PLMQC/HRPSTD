table 33001360 "Change in Cadre B2B"
{
    // version B2BHR1.00.00

    Caption = 'Change in Cadre';
    DrillDownPageID = "Employee Promotions B2B";
    LookupPageID = "Employee Promotions B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Emp No."; Code[20])
        {
            Caption = 'Emp No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();

                if "Emp No." <> xRec."Emp No." then
                    if "Emp No." <> '' then begin
                        Emp.GET("Emp No.");
                        "Department Code" := Emp."Department Code";
                        Designation := Emp.Designation;
                        "Physical Location Code" := Emp."Physical Location";
                        CLEAR("Effective Date");
                        CLEAR("New Department Code");
                        CLEAR("New Designation");
                        CLEAR("New Physical Location");
                    end else begin
                        CLEAR("Department Code");
                        CLEAR(Designation);
                        CLEAR("Physical Location Code");
                        CLEAR("Effective Date");
                        CLEAR("New Department Code");
                        CLEAR("New Designation");
                        CLEAR("New Physical Location");
                    end;

            end;
        }
        field(2; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(3; Designation; Code[50])
        {
            Caption = 'Designation';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(4; "New Department Code"; Code[20])
        {
            Caption = 'New Department Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(5; "New Designation"; Code[20])
        {
            Caption = 'New Designation';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(6; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
                TESTFIELD("Emp No.");

                if "Effective Date" <> 0D then
                    if "Effective Date" <> xRec."Effective Date" then
                        if "Effective Date" <= ReturnLastEffectiveDate() then
                            ERROR(Text00004Lbl, "Emp No.", ReturnLastEffectiveDate(), "Effective Date", ReturnLastEffectiveDate());

            end;
        }
        field(7; "Physical Location Code"; Code[20])
        {
            Caption = 'Physical Location Code';
            Editable = false;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(23));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(8; "New Physical Location"; Code[20])
        {
            Caption = 'New Physical Location';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(23));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(25; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(26; "Document Status"; Option)
        {
            Caption = 'Document Status';
            Editable = false;
            OptionCaption = ' ,Posted';
            OptionMembers = " ",Posted;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(27; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
    }

    keys
    {
        key(Key1; "Emp No.", "Effective Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if ("Emp No." = '') then
            ERROR(Text00005Lbl, FIELDCAPTION("Emp No."));
    end;

    var
        Emp: Record "Employee B2B";
        ChangeCadreGRec: Record "Change in Cadre B2B";
        Text00005Lbl: Label '%1 must not be empty.', Comment = '%1 = Emp No';
        Text00001Lbl: Label 'Do you want to release the document?';
        Text00002Lbl: Label 'Do you want to reopen the document?';
        Text00003Lbl: Label 'Employee %1 has been already posted.', Comment = '%1 = Employee No';
        Text00004Lbl: Label 'Employee %1 last promotion effective date is %2. New effective date %3 cannot be less than or equal to %4.', Comment = '%1 =  Emp No; %2 =Last Effective date; %3 = Effective date; %4 = Last Effective Date';

    procedure TestStatusOpen();
    begin
        TESTFIELD(Status, Status::Open);
    end;

    procedure Release();
    begin
        TESTFIELD(Status, Status::Open);
        TESTFIELD("Emp No.");
        TESTFIELD("Effective Date");
        TESTFIELD("New Department Code");
        TESTFIELD("New Physical Location");
        TESTFIELD("New Designation");
        if not CONFIRM(Text00001Lbl, false) then
            exit;

        ChangeCadreGRec.GET("Emp No.", "Effective Date");
        ChangeCadreGRec.Status := ChangeCadreGRec.Status::Released;
        ChangeCadreGRec.MODIFY();
    end;

    procedure Reopen();
    begin
        if DocumentPosted() then
            ERROR(Text00003Lbl, "Emp No.");


        TESTFIELD(Status, Status::Released);

        if not CONFIRM(Text00002Lbl, false) then
            exit;

        ChangeCadreGRec.GET("Emp No.", "Effective Date");
        ChangeCadreGRec.Status := ChangeCadreGRec.Status::Open;
        ChangeCadreGRec.MODIFY();
    end;

    procedure DocumentPosted(): Boolean;
    begin
        if "Document Status" = "Document Status"::Posted then
            exit(true)
        else
            exit(false);
    end;

    procedure ReturnLastEffectiveDate() LastEffectiveDate: Date;
    var
        ChngCadreLRec: Record "Change in Cadre B2B";
        EmpLRec: Record "Employee B2B";
    begin
        ChngCadreLRec.RESET();
        ChngCadreLRec.SETCURRENTKEY("Emp No.", "Effective Date");
        ChngCadreLRec.SETRANGE("Emp No.", "Emp No.");
        if ChngCadreLRec.FINDLAST() then
            LastEffectiveDate := ChngCadreLRec."Effective Date"
        else begin
            EmpLRec.RESET();
            EmpLRec.GET("Emp No.");
            LastEffectiveDate := EmpLRec."Employment Date";
        end;
    end;
}

