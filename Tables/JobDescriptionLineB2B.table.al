table 33001356 "Job Description Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Job Description Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Job Code"; Code[20])
        {
            Caption = 'Job Code';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(10; Responsibilities; Text[250])
        {
            Caption = 'Responsibilities';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(15; Requirements; Text[250])
        {
            Caption = 'Requirements';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(20; Competences; Text[250])
        {
            Caption = 'Competences';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(86; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Responsibilities,Requirements,Competences';
            OptionMembers = Responsibilities,Requirements,Competences;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
    }

    keys
    {
        key(Key1; "Job Code", "Line No.")
        {
        }
        key(Key2; "Job Code", Type)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "Job Code" <> '' then
            JobDescLineIncrement();
    end;

    trigger OnDelete();
    begin
        TestStatus();
    end;

    trigger OnModify();
    begin
        TestStatus();
    end;

    procedure TestStatus();
    var
        JobDesHeadLRec: Record "Job Description Header(RO) B2B";
    begin
        JobDesHeadLRec.GET("Job Code");
        JobDesHeadLRec.TESTFIELD("Release Status", JobDesHeadLRec."Release Status"::Open);
    end;

    procedure JobDescLineIncrement();
    var
        JobDescLine: Record "Job Description Line B2B";
    begin
        JobDescLine.RESET();
        JobDescLine.SETRANGE("Job Code", "Job Code");
        if JobDescLine.FINDLAST() then
            "Line No." := JobDescLine."Line No." + 10000
        else
            "Line No." := 10000;
    end;
}

