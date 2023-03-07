table 33001270 "Emp. Train Need Iden. Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Training Need Iden. Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Training Topic"; Code[30])
        {
            Caption = 'Training Topic';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('NEED FOR TRAINING'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD("Type of Training");
                CheckforDuplicates();
                if EmpTrNeedIdentHeadGRec.GET("Document Type", "Document No.") then
                    "Employee Code" := EmpTrNeedIdentHeadGRec."Employee No.";
            end;
        }
        field(2; "Employee Code"; Code[30])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(3; "Type of Training"; Code[30])
        {
            Caption = 'Type of Training';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('TYPE OF TRAINING'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(4; "Training Document No"; Code[20])
        {
            Caption = 'Training Document No';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                CheckforMadatoryValues();
                CheckforDuplicates();
            end;
        }
        field(7; Period; Code[20])
        {
            Caption = 'Period';
            DataClassification = CustomerContent;

            trigger OnLookup();

            begin
            end;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(10; Impact; Text[100])
        {
            Caption = 'Impact';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if "Document Type" = "Document Type"::"Training Need Identification" then begin
                    TESTFIELD("Type of Training");
                    TESTFIELD("Training Topic");
                end;
            end;
        }
        field(11; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if "Document Type" = "Document Type"::"Training Need Identification" then begin
                    TESTFIELD("Type of Training");
                    TESTFIELD("Training Topic");
                end;
            end;
        }
        field(20; "Training Created"; Boolean)
        {
            Caption = 'Training Created';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(29; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Training Need Identification';
            OptionMembers = "Training Need Identification";
            DataClassification = CustomerContent;
        }
        field(30; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Emp. Tr. Need Identi. Head B2B"."No.";
            DataClassification = CustomerContent;
        }
        field(31; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
        }
        key(Key2; "Employee Code", "Type of Training")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatus();
    end;

    trigger OnModify();
    begin
        TestStatus();
        if "Document Type" = "Document Type"::"Training Need Identification" then begin
            TESTFIELD("Type of Training");
            TESTFIELD("Training Topic");
        end;
    end;

    trigger OnRename();
    begin
        TestStatus();
    end;

    var
        EmpTrNeedIdentHeadGRec: Record "Emp. Tr. Need Identi. Head B2B";
        EmpTrNeedIdentLineGRec: Record "Emp. Train Need Iden. Line B2B";
        Text0001Lbl: Label '%1 %2 %3 %4 already exists in Line No. %5', Comment = '%1 = Type of Training ; %2 = Type of Training; %3 = Training Topics; %4 = Training Topics; %5 = Line No';

    procedure TestStatus();
    begin
        EmpTrNeedIdentHeadGRec.GET("Document Type", "Document No.");
        EmpTrNeedIdentHeadGRec.TESTFIELD(Status, EmpTrNeedIdentHeadGRec.Status::Open);
    end;

    procedure CheckforMadatoryValues();
    begin
        EmpTrNeedIdentHeadGRec.GET("Document Type", "Document No.");
        EmpTrNeedIdentHeadGRec.TESTFIELD("Employee No.");
        if EmpTrNeedIdentHeadGRec."Period Type" = EmpTrNeedIdentHeadGRec."Period Type"::Yearly then begin
            EmpTrNeedIdentHeadGRec.TESTFIELD(Period);
            EmpTrNeedIdentHeadGRec.TESTFIELD("From Date");
            EmpTrNeedIdentHeadGRec.TESTFIELD("To Date");
            EmpTrNeedIdentHeadGRec.TESTFIELD("Date of Receipt");
        end;
    end;

    procedure CheckforDuplicates();
    begin
        EmpTrNeedIdentLineGRec.RESET();
        EmpTrNeedIdentLineGRec.SETRANGE("Document Type", "Document Type");
        EmpTrNeedIdentLineGRec.SETRANGE("Document No.", "Document No.");
        EmpTrNeedIdentLineGRec.SETRANGE("Type of Training", "Type of Training");
        EmpTrNeedIdentLineGRec.SETRANGE("Training Topic", "Training Topic");
        EmpTrNeedIdentLineGRec.SETFILTER("Line No.", '<>%1', "Line No.");
        if EmpTrNeedIdentLineGRec.FINDFIRST() then
            ERROR(Text0001Lbl, FIELDCAPTION("Type of Training"), "Type of Training", FIELDCAPTION("Training Topic"), "Training Topic",
                           EmpTrNeedIdentLineGRec."Line No.");
    end;
}

