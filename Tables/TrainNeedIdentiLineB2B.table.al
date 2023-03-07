table 33001265 "Train. Need Identi. Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Train. Need Identi. Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(3; "Name of Person"; Code[20])
        {
            Caption = 'Name of Person';
            TableRelation = "Employee B2B"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if EmployeeB2BGRec.GET("Name of Person") then
                    Designation := EmployeeB2BGRec.Designation;
            end;
        }
        field(4; Designation; Code[50])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(5; Responsibilities; Text[100])
        {
            Caption = 'Responsibilities';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(6; "Behavioural Training Needed"; Code[20])
        {
            Caption = 'Behavioural Training Needed';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(7; "Technical Training Needed"; Code[20])
        {
            Caption = 'Technical Training Needed';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(8; "Years of Experience"; Integer)
        {
            Caption = 'Years of Experience';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(9; "Area of Working"; Option)
        {
            Caption = 'Area of Working';
            OptionCaption = ' ,Welding,Fabrication,CNC Machining,Other Machining,Heat Treatment,Plating';
            OptionMembers = " ",Welding,Fabrication,"CNC Machining","Other Machining","Heat Treatment",Plating;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(10; "Training Needs"; Text[100])
        {
            Caption = 'Training Needs';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(11; Priority; Text[100])
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(12; Status; Option)
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
        EmployeeB2BGRec: Record "Employee B2B";

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;
}

