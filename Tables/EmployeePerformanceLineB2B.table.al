table 33001203 "Employee Performance Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Performance Line';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "VDA Line B2B".Month;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Employee No.") then
                    "Employee Name" := Employee.FullName();
            end;
        }
        field(2; Period; Code[20])
        {
            Caption = 'Period';
            DataClassification = CustomerContent;

        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Serial No."; Integer)
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if AppraisalHeader.GET("Appraisal No.") then begin
                    "Employee No." := AppraisalHeader."Employee No.";
                    Period := AppraisalHeader.Period;
                end;
            end;
        }
        field(11; "Goal Description"; Text[250])
        {
            Caption = 'Goal Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                UpdateLog(ActionType::Updated);
            end;
        }
        field(12; "Unit of Measure"; Text[250])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::Updated);
            end;
        }
        field(13; Weightage; Decimal)
        {
            BlankZero = true;
            Caption = 'Weightage';
            DecimalPlaces = 0 : 2;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::Updated);
            end;
        }
        field(14; "Goal Type"; Option)
        {
            Caption = 'Goal Type';
            OptionCaption = 'Standard,Begin,End';
            OptionMembers = Standard,"Begin","End";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                UpdateLog(ActionType::Updated);
            end;
        }
        field(15; Priority; Option)
        {
            Caption = 'Priority';
            OptionCaption = 'Priority,Secondary';
            OptionMembers = Priority,Secondary;
            DataClassification = CustomerContent;
        }
        field(16; Target; Text[120])
        {
            Caption = 'Target';
            DataClassification = CustomerContent;
        }
        field(19; Indentation; Integer)
        {
            Caption = 'Indentation';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; "Self Review Definition 1"; Text[30])
        {
            Caption = '1';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::Updated);
            end;
        }
        field(21; "Self Review Definition 2"; Text[30])
        {
            Caption = '2';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::Updated);
            end;
        }
        field(22; "Self Review Definition 3"; Text[30])
        {
            Caption = '3';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::Updated);
            end;
        }
        field(23; "Self Review Definition 4"; Text[30])
        {
            Caption = '4';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::Updated);
            end;
        }
        field(24; "Self Review Definition 5"; Text[30])
        {
            Caption = '5';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::Updated);
            end;
        }
        field(25; "Self Review Definition 6"; Text[30])
        {
            Caption = '6';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::Updated);
            end;
        }
        field(30; "Self Review Rating"; Integer)
        {
            BlankZero = true;
            Caption = 'Self Review Rating';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusReleased();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::"Self Review");
            end;
        }
        field(31; "Self Review Comments"; Text[250])
        {
            Caption = 'Self Review Comments';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusReleased();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::"Self Review");
            end;
        }
        field(35; "Joint Review Rating"; Integer)
        {
            BlankZero = true;
            Caption = 'Joint Review Rating';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusReleased();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::"Joint Review");
            end;
        }
        field(36; "Joint Review Comments"; Text[250])
        {
            Caption = 'Joint Review Comments';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusReleased();
                TESTFIELD("Goal Type", "Goal Type"::Standard);
                UpdateLog(ActionType::"Joint Review");
            end;
        }
        field(40; "Total Target Achived"; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Target Achived';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Goal Type", "Goal Type"::Standard);
            end;
        }
        field(41; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
            DataClassification = CustomerContent;
        }
        field(50; "KRA Type"; Option)
        {
            Caption = 'KRA Type';
            OptionCaption = 'Begin,Question,Answer,End';
            OptionMembers = "Begin",Question,Answer,"End";
            DataClassification = CustomerContent;
        }
        field(55; "KRA Points"; Text[250])
        {
            Caption = 'KRA Points';
            DataClassification = CustomerContent;
        }
        field(60; "Self Rating"; Decimal)
        {
            Caption = 'Self Rating';
            DataClassification = CustomerContent;
        }
        field(65; "HOD Rating"; Decimal)
        {
            Caption = 'HOD Rating';
            DataClassification = CustomerContent;
        }
        field(70; "Total Self Rating"; Decimal)
        {
            Caption = 'Total Self Rating';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(75; "Total HOD Rating"; Decimal)
        {
            Caption = 'Total HOD Rating';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80; "Total Target"; Decimal)
        {
            Caption = 'Total Target';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Appraisal No.", "Line No.")
        {
        }
        key(Key2; "Employee No.", Period, "KRA Type")
        {
            SumIndexFields = Weightage, "Total Target Achived";
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
    end;

    trigger OnRename();
    begin
        TestStatus();
    end;

    var
        Employee: Record "Employee B2B";
        AppraisalHeader: Record "Employee PerformanceHeader B2B";
        ActionType: Option Created,Updated,Review,Released,"Self Review","Joint Review",Reopen;



    procedure TestStatus();
    begin
        AppraisalHeader.GET("Appraisal No.");
        AppraisalHeader.TESTFIELD(Status, AppraisalHeader.Status::Open);
    end;

    procedure TestStatusReleased();
    begin
        AppraisalHeader.GET("Appraisal No.");
        AppraisalHeader.TESTFIELD(Status, AppraisalHeader.Status::Released);
    end;

    procedure UpdateLog(ActionTypePar: Option Created,Updated,Review,Released,"Self Review","Joint Review",Reopen);
    var
        PerformanceLog: Record "Emp Performance Log B2B";
        PerformanceLog2: Record "Emp Performance Log B2B";
    begin
        PerformanceLog2.RESET();
        PerformanceLog2.SETRANGE("Employee Code", "Employee No.");
        PerformanceLog2.SETRANGE(Period, Period);
        PerformanceLog2.SETRANGE("Action By", USERID());
        PerformanceLog2.SETRANGE("Action Date", WORKDATE());
        if not (PerformanceLog2.FINDLAST() and (PerformanceLog2.Action = ActionTypePar)) then begin
            PerformanceLog.INIT();
            PerformanceLog.VALIDATE("Employee Code", "Employee No.");
            PerformanceLog.VALIDATE(Period, Period);
            PerformanceLog.VALIDATE(Action, ActionTypePar);
            PerformanceLog.VALIDATE("Action By", USERID());
            PerformanceLog.VALIDATE("Action Date", WORKDATE());
            PerformanceLog.VALIDATE("Action Time", TIME());
            PerformanceLog.INSERT();
        end;
    end;
}

