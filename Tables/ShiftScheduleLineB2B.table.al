table 33001372 "Shift Schedule Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shift Schedule Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(5; "Token No."; Code[20])
        {
            Caption = 'Token No.';
            DataClassification = CustomerContent;
        }
        field(6; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                GetEmployees();
            end;
        }
        field(9; "Current Shift"; Code[20])
        {
            Caption = 'Current Shift';
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;
        }
        field(10; "Revised Shift"; Code[20])
        {
            Caption = 'Revised Shift';
            TableRelation = "Shift Master B2B";
            DataClassification = CustomerContent;
        }
        field(20; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetEmployees();
    var
        ShiftSchHeader: Record "Shift Schedule Header B2B";
        Employee: Record "Employee B2B";
        DailyAttendance: Record "Daily Attendance B2B";
    begin
        Employee.RESET();
        ShiftSchHeader.RESET();
        ShiftSchHeader.SETRANGE("No.", "Document No.");
        if ShiftSchHeader.FINDFIRST() then begin
            if ShiftSchHeader."Global Dimesion 1 Code" <> '' then
                Employee.SETRANGE("Global Dimension 1 Code", ShiftSchHeader."Global Dimesion 1 Code");
            if ShiftSchHeader."Physical Location" <> '' then
                Employee.SETRANGE("Physical Location", ShiftSchHeader."Physical Location");
            if ShiftSchHeader.Department <> '' then
                Employee.SETRANGE("Department Code", ShiftSchHeader.Department);
            if Employee.FINDFIRST() then begin
                repeat
                    DailyAttendance.RESET();
                    DailyAttendance.SETRANGE(Date, ShiftSchHeader."Effective Date");
                    DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                    DailyAttendance.SETRANGE("Revised Shift", ShiftSchHeader."Current Shift");
                    if not DailyAttendance.IsEmpty() then
                        Employee.MARK(true);
                until Employee.NEXT() = 0;
                Employee.MARKEDONLY(true);
                if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                    "Employee No." := Employee."No.";
                    "Current Shift" := ShiftSchHeader."Current Shift";
                    "Revised Shift" := ShiftSchHeader."Revised Shift";
                end;
            end;
        end;
    end;
}

