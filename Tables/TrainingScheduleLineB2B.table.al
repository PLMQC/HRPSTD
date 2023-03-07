table 33001267 "Training Schedule Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Schedule Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if Employee.GET("Employee Code") then
                    "Employee Name" := Employee.FullName();
            end;
        }
        field(6; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(7; "Department Code"; Code[20])
        {
            CalcFormula = Lookup ("Employee B2B"."Department Code" WHERE("No." = FIELD("Employee Code")));
            Caption = 'Department Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Division Code"; Code[20])
        {
            CalcFormula = Lookup ("Employee B2B"."Global Dimension 1 Code" WHERE("No." = FIELD("Employee Code")));
            Caption = 'Division Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Period; Code[20])
        {
            Caption = 'Period';
            DataClassification = CustomerContent;
        }
        field(11; "Employee Training Need No."; Code[20])
        {
            Caption = 'Employee Training Need No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
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

    var
        Employee: Record "Employee B2B";
        TrainingHeader: Record "Training Schedule Header B2B";

    procedure TestStatus();
    begin
        TrainingHeader.GET("Document No.");
        TrainingHeader.TESTFIELD(Status, TrainingHeader.Status::Open);
    end;
}

