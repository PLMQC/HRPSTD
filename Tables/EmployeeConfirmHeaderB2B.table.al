table 33001319 "Employee Confirm. Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Confirmation Header_B2B';
    DrillDownPageID = "Employee Confirmation List B2B";
    LookupPageID = "Employee Confirmation List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Confirmation ID"; Code[20])
        {
            Caption = 'Confirmation ID';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(2; "Employee ID"; Code[20])
        {
            Caption = 'Employee ID';
            TableRelation = "Employee B2B"
            WHERE(Probation = CONST(true),
                                                Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var

            begin
                TestStatus();

                Employee.RESET();
                Employee.SETRANGE("No.", "Employee ID");
                if Employee.FINDFIRST() then
                    Scale := Employee.Scale;

                if "Employee ID" <> '' then begin
                    if Employee.GET("Employee ID") then
                        "Employee Name" := copystr(Employee.FullName(), 1, 50);
                end else
                    CLEAR("Employee Name");
            end;
        }
        field(3; "Date of Confirmation"; Date)
        {
            Caption = 'Date of Confirmation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
            DataClassification = CustomerContent;
        }
        field(5; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(6; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee';
            OptionMembers = Employee;
            DataClassification = CustomerContent;
        }
        field(15; Confirmed; Boolean)
        {
            Caption = 'Confirmed';
            DataClassification = CustomerContent;
        }
        field(16; "Report Reference No."; Code[20])
        {
            Caption = 'Report Reference No.';
            DataClassification = CustomerContent;
        }
        field(17; Scale; Code[100])
        {
            Caption = 'Scale';
            DataClassification = CustomerContent;
        }
        field(18; "Leave Pay Cadre"; Code[50])
        {
            Caption = 'Leave Pay Cadre';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(22));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Confirmation ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        ConformLine: Record "Employee Confirmation Line B2B";
    begin
        ConformLine.SETRANGE("Header No.", "Confirmation ID");
        ConformLine.SETRANGE("No.", "Employee ID");
        if ConformLine.FINDSET() then
            ConformLine.DELETEALL();
    end;

    trigger OnInsert();
    begin
        if "Confirmation ID" = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD("Confirmation Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Confirmation Nos.", xRec."No.Series", 0D, "Confirmation ID", "No.Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup B2B";
        EmpConfirmation: Record "Employee Confirm. Header B2B";
        Employee: Record "Employee B2B";

        NoSeriesMgt: Codeunit 396;

    procedure AssistEdit(OldConfirmation: Record "Employee Confirm. Header B2B"): Boolean;
    begin
        with EmpConfirmation do begin
            EmpConfirmation := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD("Confirmation Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Confirmation Nos.", OldConfirmation."No.Series", "No.Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Confirmation Nos.");
                NoSeriesMgt.SetSeries("Confirmation ID");
                Rec := EmpConfirmation;
                exit(true);
            end;
        end;
    end;

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;
}

