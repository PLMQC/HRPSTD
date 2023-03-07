table 33001260 "Emp. Tr. Need Identi. Head B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Tr. Need Identi. Header';
    LookupPageID = "Employee Training Needs B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if "No." <> xRec."No." then
                    if "Document Type" = "Document Type"::"Training Need Identification" then begin
                        HRSetup.GET();
                        NoSeriesMgt.TestManual(HRSetup."Training Need Identi.Nos.");
                        "No. Series" := '';
                    end;

            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "Employee B2B"
            WHERE(Blocked = CONST(false),
                                                Resigned = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if (xRec."Employee No." <> "Employee No.") then begin
                    if TrNeedIdentificationLineExists() then
                        ERROR(Text008Lbl, FIELDCAPTION("Employee No."));
                    if "Employee No." <> '' then begin
                        if Employee.GET("Employee No.") then begin
                            "Employee Name" := Employee.FullName();
                            "Physical Location" := Employee."Physical Location";
                            "Department Code" := Employee."Department Code";
                            "Division Code" := FORMAT(Employee.Division);
                            "Date of Joining" := Employee."Employment Date";
                        end;
                        evaluate("Apprisar ID", USERID());
                    end else begin
                        CLEAR("Employee Name");
                        CLEAR("Physical Location");
                        CLEAR("Department Code");
                        CLEAR("Division Code");
                        CLEAR("Date of Joining");
                    end;
                end;
            end;

        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = 'Training Need Identification';
            OptionMembers = "Training Need Identification";
            DataClassification = CustomerContent;
        }
        field(6; "Period Type"; Option)
        {
            Caption = 'Period Type';
            OptionCaption = 'Quarterly,Half Yearly,Yearly';
            OptionMembers = Quarterly,"Half Yearly",Yearly;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if TrNeedIdentificationLineExists() then
                    ERROR(Text008Lbl, FIELDCAPTION("Period Type"));

                if ("Period Type" = "Period Type"::Quarterly) or ("Period Type" = "Period Type"::"Half Yearly") then begin
                    "From Date" := 0D;
                    "To Date" := 0D;
                    Period := '';
                end
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
                TestStatus();
                if TrNeedIdentificationLineExists() then
                    ERROR(Text008Lbl, FIELDCAPTION(Period));

                TESTFIELD("Period Type", "Period Type"::Yearly);
                if "Period Type" = "Period Type"::Yearly then begin
                    PayrollYear.RESET();
                    PayrollYear.SETRANGE("Year Type", FYTxt);
                    PayrollYear.SETRANGE(Closed, false);
                    if PAGE.RUNMODAL(0, PayrollYear) = ACTION::LookupOK then begin
                        Period := FORMAT(DATE2DMY(PayrollYear."Year Start Date", 3)) + ' - ' + FORMAT(DATE2DMY(PayrollYear."Year End Date", 3));
                        "From Date" := PayrollYear."Year Start Date";
                        "To Date" := PayrollYear."Year End Date";
                    end;
                end;

                if "To Date" <> 0D then begin
                    Employee.RESET();
                    Employee.GET("Employee No.");
                    if DATE2DMY("To Date", 3) < DATE2DMY(Employee."Employment Date", 3) then
                        ERROR(Text006Lbl);
                end;
            end;

            trigger OnValidate();
            begin
                TestStatus();
                if TrNeedIdentificationLineExists() then
                    ERROR(Text008Lbl, FIELDCAPTION(Period));
            end;
        }
        field(8; "From Date"; Date)
        {
            Caption = 'From Date';
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if TrNeedIdentificationLineExists() then
                    ERROR(Text008Lbl, FIELDCAPTION("From Date"));
                if ("Period Type" = "Period Type"::Quarterly) or ("Period Type" = "Period Type"::"Half Yearly") then begin
                    if ("From Date" <> 0D) and ("To Date" <> 0D) then
                        Period := FORMAT("From Date") + ' - ' + FORMAT("To Date");

                    Employee.RESET();
                    Employee.GET("Employee No.");
                    if "From Date" < Employee."Employment Date" then
                        ERROR(Text006Lbl);
                end;
            end;
        }
        field(9; "To Date"; Date)
        {
            Caption = 'To Date';
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if TrNeedIdentificationLineExists() then
                    ERROR(Text008Lbl, FIELDCAPTION("To Date"));

                if ("Period Type" = "Period Type"::Quarterly) or ("Period Type" = "Period Type"::"Half Yearly") then begin
                    if ("From Date" <> 0D) and ("To Date" <> 0D) then
                        Period := FORMAT("From Date") + ' - ' + FORMAT("To Date");

                    Employee.RESET();
                    Employee.GET("Employee No.");
                    if "To Date" < Employee."Employment Date" then
                        ERROR(Text006Lbl);
                end;
            end;
        }
        field(10; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; "Department Code"; Code[30])
        {
            CalcFormula = Lookup ("Employee B2B"."Department Code" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Department Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Division Code"; Code[20])
        {
            CalcFormula = Lookup ("Employee B2B"."Global Dimension 1 Code" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Division Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Date of Joining"; Date)
        {
            CalcFormula = Lookup ("Employee B2B"."Employment Date" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Date of Joining';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,In Process,Closed';
            OptionMembers = Open,Released,"In Process",Closed;
            DataClassification = CustomerContent;
        }
        field(19; "Date of Receipt"; Date)
        {
            Caption = 'Date of Receipt';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(20; "Released By"; Code[50])
        {
            Caption = 'Released By';
            DataClassification = CustomerContent;
        }
        field(21; "Released Date"; Date)
        {
            Caption = 'Released Date';
            DataClassification = CustomerContent;
        }
        field(25; "Total Defined Weightage"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum ("Employee Performance Line B2B".Weightage WHERE("Employee No." = FIELD("Employee No."),
                                                                           Period = FIELD(Period),
                                                                           "KRA Type" = CONST(Question)));
            Caption = 'Total Defined Weightage';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Total Achivements"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum ("Employee Performance Line B2B"."Total Target Achived" WHERE("Employee No." = FIELD("Employee No."),
                                                                                        Period = FIELD(Period),
                                                                                        "KRA Type" = CONST(Question)));
            Caption = 'Total Achivements';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(35; "Physical Location"; Code[20])
        {
            Caption = 'Physical Location';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(40; "Total Self Rating"; Decimal)
        {
            Caption = 'Total Self Rating';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(45; "Total HOD Rating"; Decimal)
        {
            Caption = 'Total HOD Rating';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50; "Apprisar ID"; Code[50])
        {
            Caption = 'Apprisar ID';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(51; "Question ID"; Code[20])
        {
            Caption = 'Question ID';
            TableRelation = "Questionnaire Header B2B" WHERE("Questionnaire Type" = CONST(Appraisals));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
        }
        key(Key2; Period, "Document Type", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatus();

        EmpTrIdentLineGRec.RESET();
        EmpTrIdentLineGRec.SETRANGE("Document Type", "Document Type");
        EmpTrIdentLineGRec.SETRANGE("Document No.", "No.");
        EmpTrIdentLineGRec.DELETEALL();
    end;

    trigger OnInsert();
    begin
        if "No." = '' then
            if "Document Type" = "Document Type"::"Training Need Identification" then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Training Need Identi.Nos.");
                NoSeriesMgt.InitSeries(HRSetup."Training Need Identi.Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            end;

    end;

    var
        Employee: Record "Employee B2B";
        EmpTrIdentHeadGRec: Record "Emp. Tr. Need Identi. Head B2B";
        HRSetup: Record "HR Setup B2B";
        EmpTrIdentLineGRec: Record "Emp. Train Need Iden. Line B2B";
        NoSeriesMgt: Codeunit 396;
        Text006Lbl: Label 'Period must not be below the employment date';
        Text007Lbl: Label 'Der Verkauf %1 ist bereits vorhanden.', Comment = '%1 = No';
        Text008Lbl: Label '%1 cannot be changed. Training need identification lines already exists.', Comment = '%1 = ToDate';
        Text009Lbl: Label 'Do you want to re open the document?';
        Text010Lbl: Label 'Do you want to release the document?';
        Text011Lbl: Label 'There is nothing to release.';
        FYTxt: Label 'FINANCIAL YEAR';

    procedure AssistEdit(OldEmpTrIdentHeadRecPar: Record "Emp. Tr. Need Identi. Head B2B"): Boolean;
    var
        EmpTrIdentHeadLRec: Record "Emp. Tr. Need Identi. Head B2B";
    begin
        with EmpTrIdentHeadGRec do begin
            COPY(Rec);
            HRSetup.GET();
            TestNoSeries();
            if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldEmpTrIdentHeadRecPar."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                if EmpTrIdentHeadLRec.GET("Document Type", "No.") then
                    ERROR(Text007Lbl, "No.");
                Rec := EmpTrIdentHeadGRec;
                exit(true);
            end;
        end;
    end;

    local procedure TestNoSeries(): Boolean;
    begin
        case "Document Type" of
            "Document Type"::"Training Need Identification":
                HRSetup.TESTFIELD("Training Need Identi.Nos.");
        end;
    end;

    local procedure GetNoSeriesCode(): Code[20];
    begin
        case "Document Type" of
            "Document Type"::"Training Need Identification":
                exit(HRSetup."Training Need Identi.Nos.");
        end;
    end;

    procedure TrNeedIdentificationLineExists(): Boolean;
    var
        TrNeedIdentLineLRec: Record "Emp. Train Need Iden. Line B2B";
    begin
        TrNeedIdentLineLRec.RESET();
        TrNeedIdentLineLRec.SETRANGE("Document Type", "Document Type");
        TrNeedIdentLineLRec.SETRANGE("Document No.", "No.");
        if not TrNeedIdentLineLRec.IsEmpty() then
            exit(true)
        else
            exit(false);
    end;

    procedure ReleaseDocument();
    begin
        TESTFIELD(Status, Status::Open);
        TESTFIELD("Date of Receipt");

        if not CONFIRM(Text010Lbl, false) then
            exit;

        if not TrNeedIdentificationLineExists() then
            ERROR(Text011Lbl);

        Status := Status::Released;
        Evaluate("Released By", USERID());
        "Released Date" := workdate();
        MODIFY();
    end;

    procedure ReopenDocument();
    begin
        TESTFIELD(Status, Status::Released);

        if not CONFIRM(Text009Lbl, false) then
            exit;

        Status := Status::Open;
        MODIFY();
    end;

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;
}

