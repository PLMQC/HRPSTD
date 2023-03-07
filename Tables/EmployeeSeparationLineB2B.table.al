table 33001272 "Employee Separation Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Separation Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Seperation ID"; Code[20])
        {
            Caption = 'Seperation ID';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Employee ID"; Code[20])
        {
            Caption = 'Employee ID';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Question,Answer,Heading';
            OptionMembers = Question,Answer,Heading;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(7; Question; Text[250])
        {
            Caption = 'Question';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(8; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(9; Answer; Text[150])
        {
            Caption = 'Answer';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(10; "Multiple Answers"; Boolean)
        {
            Caption = 'Multiple Answers';
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(11; Set; Boolean)
        {
            Caption = 'Set';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
        field(12; "Hierarchy No."; Integer)
        {
            Caption = 'Hierarchy No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen();
            end;
        }
    }

    keys
    {
        key(Key1; "Seperation ID", "Line No.")
        {
        }
        key(Key2; "Hierarchy No.", Type)
        {
        }
    }

    fieldgroups
    {
    }

    var
        EmpSepHeadGRec: Record "Employee Seperation B2B";

    procedure TestStatusOpen();
    begin
        EmpSepHeadGRec.GET("Seperation ID");
        EmpSepHeadGRec.TESTFIELD(Status, EmpSepHeadGRec.Status::Open);
    end;
}

