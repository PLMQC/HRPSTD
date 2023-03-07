table 33001370 "Hr & Payroll Cue B2B"
{
    // version B2BHR1.00.00

    Caption = 'Hr & Payroll Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;

        }
        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(20; Blocked; Integer)
        {
            CalcFormula = Count ("Employee B2B" WHERE(Blocked = CONST(true)));
            Caption = 'Blocked';
            Editable = false;
            FieldClass = FlowField;

        }
        field(30; Probation; Integer)
        {
            CalcFormula = Count ("Employee B2B" WHERE(Probation = CONST(true)));
            Caption = 'Probation';
            Editable = false;
            FieldClass = FlowField;

        }
        field(40; "Total Employees"; Integer)
        {
            CalcFormula = Count ("Employee B2B" WHERE(Blocked = CONST(false)));
            Caption = 'Total Employees';
            Editable = false;
            FieldClass = FlowField;

        }
        field(50; "Payroll Month"; Integer)
        {
            CalcFormula = Lookup ("HR Setup B2B"."Salary Processing month");
            Caption = 'Payroll Month';
            Editable = false;
            FieldClass = FlowField;

        }
        field(60; "Payroll Year"; Integer)
        {
            CalcFormula = Lookup ("HR Setup B2B"."Salary Processing Year");
            Caption = 'Payroll Year';
            Editable = false;
            FieldClass = FlowField;


        }
        field(61; "Current Date"; Date)
        {
            Caption = 'Current Date';
            DataClassification = CustomerContent;
        }
        field(63; "BirthDay's TODAY()"; Integer)
        {
            Caption = 'BirthDay''s TODAY()';
            DataClassification = CustomerContent;
        }
        field(64; "Employees On Leave"; Integer)
        {
            CalcFormula = Count ("Daily Attendance B2B" WHERE("Attendance Type" = FILTER(Absent | Leave),
                                                          Date = FIELD("Current Date"),
                                                          "Not Joined" = CONST(0)));
            Caption = 'Employees On Leave';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Leave Application Not Approved"; Integer)
        {
            Caption = 'Leave Application Not Approved';
            DataClassification = CustomerContent;
        }
        field(67; "Leave Cancellled Not Approved"; Integer)
        {
            Caption = 'Leave Cancellled Not Approved';
            DataClassification = CustomerContent;
        }
        field(70; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(80; "Date Filter2"; Date)
        {
            Caption = 'Date Filter2';
            FieldClass = FlowFilter;
        }
        field(90; "Trainings Scheduled TODAY()"; Integer)
        {
            Caption = 'Trainings Scheduled TODAY()';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(92; "Attendees For Trainings"; Integer)
        {
            CalcFormula = Count ("Training Line B2B" WHERE("Training Start Date" = FIELD("Current Date")));
            Caption = 'Attendees For Trainings';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Resumes In Hand"; Integer)
        {
            CalcFormula = Count ("Resume Database B2B" WHERE(Selected = CONST(false),
                                                         Blocked = CONST(false)));
            Caption = 'Resumes In Hand';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "Res. Indent Pending"; Integer)
        {
            CalcFormula = Count ("Recruitment Header B2B" WHERE("Indent Closed" = CONST(false),
                                                            Approved = CONST(true)));
            Caption = 'Res. Indent Pending';
            Description = 'Resumes Indent Pending';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "Res. Indent Pending  Approval"; Integer)
        {
            CalcFormula = Count ("Recruitment Header B2B" WHERE(Status = FILTER(<> Release)));
            Caption = 'Res. Indent Pending  Approval';
            Description = 'Resumes Indent Pending  Approval';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

