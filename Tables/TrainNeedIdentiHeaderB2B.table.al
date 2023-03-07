table 33001264 "Train. Need Identi. Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Train. Need Identi. Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(2; "Name of HOD"; Text[50])
        {
            Caption = 'Name of HOD';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(3; "Assessment Period"; Date)
        {
            Caption = 'Assessment Period';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(4; "Staff Type"; Option)
        {
            Caption = 'Staff Type';
            OptionCaption = ' ,Managerial & Supervisory Staff,Operator';
            OptionMembers = " ","Managerial & Supervisory Staff",Operator;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
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

    trigger OnInsert();
    begin
        if "No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Training Need Identi.Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Training Need Identi.Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup B2B";
        TrainNeedIdentiHeader: Record "Train. Need Identi. Header B2B";
        NoSeriesMgt: Codeunit 396;

    procedure AssistEdit(OldTrainNeedIdentiHeader: Record "Train. Need Identi. Header B2B"): Boolean;
    begin
        with TrainNeedIdentiHeader do begin
            TrainNeedIdentiHeader := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Training Need Identi.Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Training Need Identi.Nos.", OldTrainNeedIdentiHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := TrainNeedIdentiHeader;
                exit(true);
            end;
        end;
    end;

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;
}

