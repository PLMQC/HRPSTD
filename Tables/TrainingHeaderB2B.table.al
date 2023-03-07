table 33001199 "Training Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Header';
    LookupPageID = "Closed Recruitment Headers B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(2; "Course Name"; Text[80])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(3; "Need  for Training"; Text[30])
        {
            Caption = 'Need  for Training';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('NEED FOR TRAINING'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(4; "Initiating Dept"; Code[30])
        {
            Caption = 'Initiating Dept';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(5; "Date of Creation"; Date)
        {
            Caption = 'Date of Creation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(6; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(7; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(8; "Training Faculty"; Option)
        {
            Caption = 'Training Faculty';
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(9; "Training Premises"; Option)
        {
            Caption = 'Training Premises';
            OptionCaption = 'Outside Office,Within Office';
            OptionMembers = "Outside Office","Within Office";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(10; "Training Type"; Text[30])
        {
            Caption = 'Training Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('TYPE OF TRAINING'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(11; Agency; Text[30])
        {
            Caption = 'Agency';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(13; "No. of Employees"; Integer)
        {
            CalcFormula = Count("Training Line B2B" WHERE("Training Header No." = FIELD("No.")));
            Caption = 'No. of Employees';
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(16; "Training Subject"; Text[30])
        {
            Caption = 'Training Subject';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(17; Department; Code[10])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(18; LDM; Date)
        {
            Caption = 'LDM';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(19; Faculty; Text[30])
        {
            Caption = 'Faculty';
            TableRelation = IF ("Training Faculty" = FILTER(Internal)) "Employee B2B"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(20; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = CustomerContent;
        }
        field(21; Location; Option)
        {
            Caption = 'Location';
            OptionCaption = ' ,Towers,Telecom,IBO';
            OptionMembers = " ",Towers,Telecom,IBO;
            DataClassification = CustomerContent;
        }
        field(22; "Training interval"; Option)
        {
            Caption = 'Training interval';
            OptionCaption = ' ,Yearly,Half-Yearly,Quarterly,Monthly,Weekly,Daily';
            OptionMembers = " ",Yearly,"Half-Yearly",Quarterly,Monthly,Weekly,Daily;
            DataClassification = CustomerContent;
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
            DataClassification = CustomerContent;
        }
        field(24; "Global Dimension 1"; Code[20])
        {
            Caption = 'Global Dimension 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(25; "Training Code"; Code[20])
        {
            Caption = 'Training Code';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(27; "Work Group Code"; Code[20])
        {
            Caption = 'Work Group Code';
            TableRelation = "Training Calendar Schedule B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(28; "Work Group Code 2"; Code[20])
        {
            Caption = 'Work Group Code 2';
            TableRelation = "Training Calendar Schedule B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(29; "Work Group Code 3"; Code[20])
        {
            Caption = 'Work Group Code 3';
            TableRelation = "Training Calendar Schedule B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(30; "Work Group Code 4"; Code[20])
        {
            Caption = 'Work Group Code 4';
            TableRelation = "Training Calendar Schedule B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(31; "Work Group Code 5"; Code[20])
        {
            Caption = 'Work Group Code 5';
            TableRelation = "Training Calendar Schedule B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(32; "Training Schedule No."; Code[20])
        {
            Caption = 'Training Schedule No.';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(33; Duration; Decimal)
        {
            BlankZero = true;
            Caption = 'Duration';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(34; "Duration UOM"; Option)
        {
            Caption = 'Duration UOM';
            OptionCaption = 'Hours,Days';
            OptionMembers = Hours,Days;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(35; "Actual Starting Date"; Date)
        {
            Caption = 'Actual Starting Date';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Starting Date" := "Actual Starting Date";
            end;
        }
        field(36; "Actual Ending Date"; Date)
        {
            Caption = 'Actual Ending Date';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Ending Date" := "Actual Ending Date";
            end;
        }
        field(37; "Global Dimension 2"; Code[20])
        {
            Caption = 'Global Dimension 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(38; "Physical Location"; Code[20])
        {
            Caption = 'Physical Location';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(23));
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
        TestStatus();
        TrainingLine.SETRANGE("Training Header No.", "No.");
        if TrainingLine.FINDFIRST() then
            TrainingLine.DELETEALL();
    end;

    trigger OnInsert();
    begin
        if "No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Training Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Training Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Date of Creation" := TODAY();
    end;

    trigger OnModify();
    begin
        TestStatus();
    end;

    trigger OnRename();
    begin
        TestStatus();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        EmpTrNeedHeaderGRec: Record "Emp. Tr. Need Identi. Head B2B";
        TrainingLine: Record "Training Line B2B";
        TrainingLineGRec: Record "Training Line B2B";
        NoSeriesMgt: Codeunit 396;
        Text010Lbl: Label 'Do you want to Release?';
        Text011Lbl: Label 'Do you want to Reopen?';

    procedure AssistEdit(OldTraining: Record "Training Header B2B"): Boolean;
    var
        Training: Record "Training Header B2B";
    begin
        with Training do begin
            Training := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Training Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Training Nos.", OldTraining."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Training Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Training;
                exit(true);
            end;
        end;
    end;
    /*
    procedure Attachments();
    var
        Attachment: Record "HR Attachment-B2B";
    begin
        Attachment.RESET();
        Attachment.SETRANGE("Table ID", DATABASE::"Training Header");
        Attachment.SETRANGE("Document No.", "No.");
        PAGE.RUNMODAL(PAGE::HRAttachments_B2B, Attachment);
    end;*/

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;

    procedure Release();
    begin
        if not CONFIRM(Text010Lbl, false) then
            exit;
        TESTFIELD(Status, Status::Open);
        LOCKTABLE();
        Status := Status::Release;
        MODIFY();

        TrainingLineGRec.RESET();
        TrainingLineGRec.SETRANGE("Training Header No.", "No.");
        if TrainingLineGRec.FINDFIRST() then
            repeat
                EmpTrNeedHeaderGRec.RESET();
                EmpTrNeedHeaderGRec.SETRANGE("No.", TrainingLineGRec."Emp. Training Need Doc. No.");
                if EmpTrNeedHeaderGRec.FINDFIRST() then begin
                    EmpTrNeedHeaderGRec.Status := EmpTrNeedHeaderGRec.Status::Closed;
                    EmpTrNeedHeaderGRec.MODIFY();
                end;
            until TrainingLineGRec.NEXT() = 0;

    end;

    procedure Reopen();
    begin
        if not CONFIRM(Text011Lbl, false) then
            exit;
        TESTFIELD(Status, Status::Release);
        LOCKTABLE();
        Status := Status::Open;
        MODIFY();
    end;
}

