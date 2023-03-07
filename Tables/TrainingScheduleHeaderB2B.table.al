table 33001266 "Training Schedule Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Schedule Header';
    LookupPageID = "Training Schedule List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.GET();
                    NoSeriesMgt.TestManual(HRSetup."Training Schedule Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(6; Frequency; DateFormula)
        {
            Caption = 'Frequency';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                CheckforPlannedDates();
            end;
        }
        field(7; Period; Code[20])
        {
            Caption = 'Period';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                PayrollYear: Record "Payroll Year B2B";
            begin
                PayrollYear.RESET();
                PayrollYear.SETRANGE("Year Type", FYTxt);
                PayrollYear.SETRANGE(Closed, false);
                if PAGE.RUNMODAL(0, PayrollYear) = ACTION::LookupOK then begin
                    TestStatus();
                    Period := FORMAT(DATE2DMY(PayrollYear."Year Start Date", 3)) + ' - ' + FORMAT(DATE2DMY(PayrollYear."Year End Date", 3));
                    CheckforPlannedDates();
                    CheckDates();
                    "From Date" := PayrollYear."Year Start Date";
                    "To Date" := PayrollYear."Year End Date";
                end;
            end;

            trigger OnValidate();
            begin
                TestStatus();
                CheckDates();
                if Period <> '' then
                    ERROR('');
            end;
        }
        field(8; "From Date"; Date)
        {
            Caption = 'From Date';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(9; "To Date"; Date)
        {
            Caption = 'To Date';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(10; "Type of Training"; Code[50])
        {
            Caption = 'Type of Training';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('TYPE OF TRAINING'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                Lookup_B2B.RESET();
                Lookup_B2B.SETFILTER("LookupType Name", '=%1', TYPEOFTRAININGTxt);
                Lookup_B2B.SETRANGE("Lookup Name", "Type of Training");
                if Lookup_B2B.FINDFIRST() then
                    "Type of Training Description" := copystr(Lookup_B2B.Description, 1, 50)
                else
                    "Type of Training Description" := '';
            end;
        }
        field(11; "Type of Training Description"; Text[50])
        {
            Caption = 'Type of Training Description';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(12; "Training Topic"; Code[20])
        {
            Caption = 'Training Topic';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('NEED FOR TRAINING'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                Lookup_B2B.RESET();
                Lookup_B2B.SETFILTER("LookupType Name", '=%1', NEEDFORTRAININGTxt);
                Lookup_B2B.SETRANGE("Lookup Name", "Training Topic");
                if Lookup_B2B.FINDFIRST() then begin
                    "Training Topic Description" := copystr(Lookup_B2B.Description, 1, 50);
                    VALIDATE("Type of Training", Lookup_B2B."Training Type");
                end else
                    "Training Topic Description" := '';

            end;
        }
        field(13; "Training Topic Description"; Text[50])
        {
            Caption = 'Training Topic Description';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(15; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(19; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(20; "Training Starting Date"; Date)
        {
            Caption = 'Training Starting Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                TestStatus();
                CheckDates();
                CheckforPlannedDates();
            end;
        }
        field(21; "Training Created"; Boolean)
        {
            Caption = 'Training Created';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(35; "Released By"; Code[50])
        {
            Caption = 'Released By';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(36; "Released Date"; Date)
        {
            Caption = 'Released Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(38; "Training Duration"; Decimal)
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
        field(39; "Duration UOM"; Option)
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
        field(40; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;
        }
        field(41; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(42; "Physical Location"; Code[20])
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
        TrainingLine.RESET();
        TrainingLine.SETRANGE("Document No.", "No.");
        TrainingLine.DELETEALL(true);
    end;

    trigger OnInsert();
    begin
        if "No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD("Training Schedule Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Training Schedule Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
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
        TrainingLine: Record "Training Schedule Line B2B";
        Lookup_B2B: Record Lookup_B2B;
        TrainingPlan: Record "Training Schedule Plan B2B";
        HRSetup: Record "HR Setup B2B";
        NoSeriesMgt: Codeunit 396;
        Text001Lbl: Label 'Training Start date should be in the selected Period.';
        FYTxt: Label 'FINANCIAL YEAR';
        TYPEOFTRAININGTxt: Label 'TYPE OF TRAINING';
        NEEDFORTRAININGTxt: Label 'NEED FOR TRAINING';

    procedure CheckforPlannedDates();
    begin
        TrainingPlan.RESET();
        TrainingPlan.SETRANGE("Document No.", "No.");
        TrainingPlan.DELETEALL(true);
    end;

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;

    procedure AssistEdit(): Boolean;
    begin
        HRSetup.GET();
        HRSetup.TESTFIELD("Training Schedule Nos.");
        if NoSeriesMgt.SelectSeries(HRSetup."Training Schedule Nos.", xRec."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;

    procedure CheckDates();
    begin
        if ("Training Starting Date" < "From Date") or ("To Date" < "Training Starting Date") then
            ERROR(Text001Lbl);
    end;
}

