table 33001321 "Probation Extended B2B"
{
    // version B2BHR1.00.00

    Caption = 'Probation Extended_B2B';
    DrillDownPageID = "Probation Extended List B2B";
    LookupPageID = "Probation Extended List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Id."; Code[20])
        {
            Caption = 'Id.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(2; "Employee  Id"; Code[20])
        {
            Caption = 'Employee  Id';
            TableRelation = "Employee B2B"
            WHERE(Probation = CONST(true),
                                                Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
                Employee.RESET();
                Employee.SETRANGE("No.", "Employee  Id");
                if Employee.FINDFIRST() then begin
                    "Employee Name" := copystr(Employee."First Name" + Employee."Middle Name" + Employee."Last Name", 1, 50);
                    "Joining Date" := Employee."Employment Date";
                    "Appointment Date" := Employee."Appointment Date";
                    Department := Employee."Department Code";
                    Designation := Employee.Designation;
                    "Probation Period" := Employee."Probation Period";
                end;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(4; "Joining Date"; Date)
        {
            Caption = 'Joining Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(5; "Appointment Date"; Date)
        {
            Caption = 'Appointment Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(6; Department; Code[30])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(7; Designation; Code[50])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(8; "Probation Period"; DateFormula)
        {
            Caption = 'Probation Period';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(9; "Extended Probation Period"; DateFormula)
        {
            Caption = 'Extended Probation Period';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
                if FORMAT("Extended Probation Period") <> '' then
                    "Probation End Date" := CALCDATE("Extended Probation Period", "Effective Date")
                else
                    "Probation End Date" := 0D;
            end;
        }
        field(10; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(11; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(12; "Probation End Date"; Date)
        {
            Caption = 'Probation End Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
        field(13; "Probation Extended"; Boolean)
        {
            Caption = 'Probation Extended';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckProbUpdate();
            end;
        }
    }

    keys
    {
        key(Key1; "Id.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        CheckProbUpdate();
    end;

    trigger OnInsert();
    begin
        if "Id." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD("Prob Id");
            NoSeriesMgt.InitSeries(HRSetup."Prob Id", xRec."No.Series", 0D, "Id.", "No.Series");
        end;
    end;

    trigger OnModify();
    begin
        CheckProbUpdate();
    end;

    trigger OnRename();
    begin
        CheckProbUpdate();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Probation: Record "Probation Extended B2B";
        Employee: Record "Employee B2B";
        NoSeriesMgt: Codeunit 396;

        Text001Lbl: Label 'Already posted the employee probation extend %1', Comment = '%1 = Id';

    procedure AssistEdit(OldProbation: Record "Probation Extended B2B"): Boolean;
    begin
        with Probation do begin
            Probation := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD("Prob Id");
            if NoSeriesMgt.SelectSeries(HRSetup."Prob Id", OldProbation."No.Series", "No.Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Prob Id");
                NoSeriesMgt.SetSeries("Id.");
                Rec := Probation;
                exit(true);
            end;
        end;
    end;

    procedure CheckProbUpdate();
    begin
        if "Probation Extended" then
            ERROR(Text001Lbl, "Id.");
    end;
}

