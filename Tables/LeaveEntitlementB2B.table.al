table 33001220 "Leave Entitlement B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Entitlement';
    DrillDownPageID = "Leave Entitlement List B2B";
    LookupPageID = "Leave Entitlement List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(3; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Leave Master B2B";
            DataClassification = CustomerContent;
        }
        field(4; "No.of Leaves"; Decimal)
        {
            Caption = 'No.of Leaves';
            DataClassification = CustomerContent;
        }
        field(5; "Leave Year Closing Period"; Date)
        {
            Caption = 'Leave Year Closing Period';
            DataClassification = CustomerContent;
        }
        field(6; "Leaves Carried"; Decimal)
        {
            Caption = 'Leaves Carried';
            DataClassification = CustomerContent;
        }
        field(7; "Total Leaves"; Decimal)
        {
            Caption = 'Total Leaves';
            DataClassification = CustomerContent;
        }
        field(8; "Leaves taken during Month"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance B2B".Leave WHERE("Employee No." = FIELD("Employee No."),
                                                              "Leave Code" = FIELD("Leave Code"),
                                                              Year = FIELD(Year),
                                                              Month = FIELD(Month)));
            Caption = 'Leaves taken during Month';
            FieldClass = FlowField;
        }
        field(9; "Leave Bal. at the Month End"; Decimal)
        {
            Caption = 'Leave Bal. at the Month End';
            DataClassification = CustomerContent;
        }
        field(10; "Leaves Carried next Month"; Decimal)
        {
            Caption = 'Leaves Carried next Month';
            DataClassification = CustomerContent;
        }
        field(11; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(12; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(13; "Leaves Expired"; Decimal)
        {
            Caption = 'Leaves Expired';
            DataClassification = CustomerContent;
        }
        field(14; Probation; Boolean)
        {
            Caption = 'Probation';
            DataClassification = CustomerContent;
        }
        field(15; "Leave Encashed"; Decimal)
        {
            CalcFormula = Sum ("Leave Encashed B2B"."Leaves to Encash" WHERE("Employee Code" = FIELD("Employee No."),
                                                                         "Leave Code" = FIELD("Leave Code")));
            Caption = 'Leave Encashed';
            FieldClass = FlowField;
        }
        field(16; "Leave to Encash"; Decimal)
        {
            Caption = 'Leave to Encash';
            DataClassification = CustomerContent;
        }
        field(17; "Encashed Amount"; Decimal)
        {
            CalcFormula = Sum ("Leave Encashed B2B"."Encash Amount" WHERE("Employee Code" = FIELD("Employee No."),
                                                                      Year = FIELD(Year),
                                                                      Month = FIELD(Month),
                                                                      "Leave Code" = FIELD("Leave Code")));
            Caption = 'Encashed Amount';
            FieldClass = FlowField;
        }
        field(18; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(19; "Opening Balance"; Decimal)
        {
            Caption = 'Opening Balance';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                MonAttendance.SETRANGE("Employee Code", "Employee No.");
                MonAttendance.SETRANGE(Processed, true);
                if MonAttendance.FINDSET() then
                    ERROR(Text000Lbl);

                "Total Leaves" := "Total Leaves" + "Opening Balance";
            end;
        }
        field(25; "Leave Period Starting Month"; Integer)
        {
            Caption = 'Leave Period Starting Month';
            DataClassification = CustomerContent;
        }
        field(26; "Leave Period Starting Year"; Integer)
        {
            Caption = 'Leave Period Starting Year';
            DataClassification = CustomerContent;
        }
        field(30; "Leaves Taken during the Year"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance B2B".Leave WHERE("Employee No." = FIELD("Employee No."),
                                                              "Leave Code" = FIELD("Leave Code"),
                                                              Year = FIELD(Year)));
            Caption = 'Leaves Taken during the Year';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Employee No.", "Leave Code", Year, Month)
        {
            SumIndexFields = "Leave Bal. at the Month End";
        }
    }

    fieldgroups
    {
    }

    var
        MonAttendance: Record "Monthly Attendance B2B";
        Text000Lbl: Label 'You can''t modify the opening balance.';

}

