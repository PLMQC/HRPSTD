table 33001303 "Leave Journal B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Journal_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Entitlement,Utilization,Lapse,Encashment,Correction,Opening Balance';
            OptionMembers = Entitlement,Utilization,Lapse,Encashment,Correction,"Opening Balance";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Employee Leaves B2B"."Leave Code" WHERE("No." = FIELD("Employee No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Employee No.") then;
                if LeaveMaster.GET("Leave Code", Employee."Location Code") then
                    "Leave Description" := LeaveMaster.Description
                else
                    "Leave Description" := '';
            end;
        }
        field(4; "Leave Description"; Text[50])
        {
            Caption = 'Leave Description';
            DataClassification = CustomerContent;
        }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B" WHERE(Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Employee No.") then begin
                    "Employee Name" := Employee."First Name";
                    "Pay Cadre" := Employee."Pay Cadre";
                    "Leave Pay Cadre" := Employee."Leave Pay Cadre";
                end else begin
                    "Employee Name" := '';
                    "Pay Cadre" := '';
                    "Leave Pay Cadre" := '';
                end;
            end;
        }
        field(6; "Employee Name"; Text[90])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(8; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var

            begin
            end;
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(12; "No.of Leaves"; Decimal)
        {
            Caption = 'No.of Leaves';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if not (ABS("No.of Leaves" - ROUND("No.of Leaves", 1, '=')) in [0, 0.5, 1]) then
                    ERROR(Text004Lbl);
            end;
        }
        field(14; "Pay Cadre"; Code[20])
        {
            Caption = 'Pay Cadre';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;
        }
        field(18; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;
        }
        field(19; "Reason for Leave"; Text[50])
        {
            Caption = 'Reason for Leave';
            DataClassification = CustomerContent;
        }
        field(20; "Leave Pay Cadre"; Code[50])
        {
            Caption = 'Leave Pay Cadre';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry Type", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
        LeaveMaster: Record "Leave Master B2B";
        Text001Lbl: Label 'Posted successfully';
        Text002Lbl: Label 'There is nothing to post';
        Text003Lbl: Label 'You can not post before the Employment Date';
        Text004Lbl: Label 'You can only apply for half days or full days.';
        LYTxt: Label 'LEAVE YEAR';
        OneDayLessExprLbl: Label '<-1D>';

    procedure PostOpeningBalance();
    var
        HRSetup: Record "HR Setup B2B";
        PayrollYear: Record "Payroll Year B2B";
        EmpLeaves: Record "Employee Leaves B2B";
        TempEmpLeaves: Record "Employee Leaves B2B";
        DetailLeaves: Record "Detailed Leave Records B2B";
        TempDetailLeaves: Record "Detailed Leave Records B2B";
        ProvLeaves: Record "Provisional Leaves B2B";
        TempProvLeaves: Record "Provisional Leaves B2B";
        LeaveJournal: Record "Leave Journal B2B";
        TempLeaveJournal: Record "Leave Journal B2B";
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        LineNum: Integer;
        DeletedLine: Integer;
    begin
        Employee.GET("Employee No.");
        if "Posting Date" >= Employee."Employment Date" then begin
            PayrollYear.RESET();
            PayrollYear.SETRANGE("Year Type", LYTxt);
            PayrollYear.SETRANGE(Closed, false);
            if PayrollYear.FINDFIRST() then;

            LeaveJournal.RESET();
            LeaveJournal.SETRANGE("Entry Type", LeaveJournal."Entry Type"::"Opening Balance");
            if LeaveJournal.FINDFIRST() then begin
                repeat
                    LeaveJournal.TESTFIELD("Leave Code");
                    LeaveJournal.TESTFIELD("Employee No.");
                    LeaveJournal.TESTFIELD("Posting Date");
                    LeaveJournal.TESTFIELD("No.of Leaves");
                    CLEAR(DeletedLine);
                    HRSetup.GET();
                    Employee.GET(LeaveJournal."Employee No.");

                    EmpLeaves.INIT();
                    EmpLeaves."No." := LeaveJournal."Employee No.";
                    EmpLeaves."Leave Pay Cadre" := Employee."Leave Pay Cadre";
                    EmpLeaves."Leave Code" := LeaveJournal."Leave Code";
                    EmpLeaves."Leave Description" := LeaveJournal."Leave Description";

                    TempEmpLeaves.RESET();
                    TempEmpLeaves.SETRANGE("No.", EmpLeaves."No.");
                    TempEmpLeaves.SETRANGE("Leave Code", EmpLeaves."Leave Code");
                    TempEmpLeaves.SETRANGE("Leave Pay Cadre", EmpLeaves."Leave Pay Cadre");
                    if TempEmpLeaves.IsEmpty() then
                        EmpLeaves.INSERT();

                    TempDetailLeaves.RESET();
                    if TempDetailLeaves.FINDLAST() then
                        LineNum := TempDetailLeaves."Entry No." + 1
                    else
                        LineNum := 1;

                    DetailLeaves.INIT();
                    DetailLeaves."Entry No." := LineNum;
                    DetailLeaves."Employee No." := LeaveJournal."Employee No.";
                    DetailLeaves."Leave Code" := LeaveJournal."Leave Code";
                    DetailLeaves."Leave Description" := LeaveJournal."Leave Description";
                    DetailLeaves."Entry Type" := LeaveJournal."Entry Type";
                    DetailLeaves."Entry Date" := LeaveJournal."Posting Date";
                    DetailLeaves."Leave Pay Cadre" := Employee."Leave Pay Cadre";
                    DetailLeaves."No. of Leaves" := LeaveJournal."No.of Leaves";
                    DetailLeaves."Posting Date" := LeaveJournal."Posting Date";
                    DetailLeaves.Month := HRSetup."Salary Processing month";
                    DetailLeaves.Year := HRSetup."Salary Processing Year";
                    DetailLeaves.INSERT();
                    LineNum := LineNum + 1;
                    DeletedLine := LeaveJournal."Line No.";
                    ProvLeaves.INIT();
                    ProvLeaves."Employee No." := LeaveJournal."Employee No.";
                    ProvLeaves."Employee Name" := LeaveJournal."Employee Name";
                    ProvLeaves."Leave Code" := LeaveJournal."Leave Code";
                    ProvLeaves."Leave Descriptioon" := LeaveJournal."Leave Description";
                    ProvLeaves."No.of Leaves" := LeaveJournal."No.of Leaves";
                    ProvLeaves."Remaining Leaves" := LeaveJournal."No.of Leaves";
                    ProvLeaves.Status := ProvLeaves.Status::Open;
                    ProvLeaves.Month := HRSetup."Salary Processing month";
                    ProvLeaves.Year := HRSetup."Salary Processing Year";
                    ProvLeaves."Leave Year Start Date" := PayrollYear."Year Start Date";
                    ProvLeaves."Leave Year End Date" := PayrollYear."Year End Date";
                    ProvLeaves."Prev. Month  Balance" := LeaveJournal."No.of Leaves";
                    ProvLeaves."Period Start Date" := PayrollYear."Year Start Date";
                    GradeWiseLeaves.RESET();
                    GradeWiseLeaves.SETRANGE("Leave Code", LeaveJournal."Leave Code");
                    GradeWiseLeaves.SETRANGE("Leave Pay Cadre", Employee."Leave Pay Cadre");
                    GradeWiseLeaves.SETRANGE("Location Code", Employee."Location Code");
                    GradeWiseLeaves.FINDFIRST();
                    ProvLeaves."Period End Date" := CALCDATE(OneDayLessExprLbl, CALCDATE(GradeWiseLeaves."Crediting Interval", ProvLeaves."Period Start Date"));

                    TempProvLeaves.RESET();
                    TempProvLeaves.SETRANGE("Employee No.", ProvLeaves."Employee No.");
                    TempProvLeaves.SETRANGE("Leave Code", ProvLeaves."Leave Code");
                    TempProvLeaves.SETRANGE(Month, ProvLeaves.Month);
                    TempProvLeaves.SETRANGE(Year, ProvLeaves.Year);
                    if TempProvLeaves.IsEmpty() then
                        ProvLeaves.INSERT()
                    else begin
                        TempProvLeaves."Prev. Month  Balance" += LeaveJournal."No.of Leaves";
                        TempProvLeaves."No.of Leaves" += LeaveJournal."No.of Leaves";
                        TempProvLeaves."Remaining Leaves" += LeaveJournal."No.of Leaves";
                        TempProvLeaves.MODIFY();
                    end;
                    Employee."Leaves Not Generated" := false;
                    Employee.MODIFY();

                    TempLeaveJournal.RESET();
                    TempLeaveJournal.SETRANGE("Entry Type", TempLeaveJournal."Entry Type"::"Opening Balance");
                    TempLeaveJournal.SETRANGE("Line No.", DeletedLine);
                    if TempLeaveJournal.FINDFIRST() then
                        TempLeaveJournal.DELETE();
                until LeaveJournal.NEXT() = 0;
                MESSAGE(Text001Lbl);
            end else
                ERROR(Text002Lbl);
        end else
            ERROR(Text003Lbl);
    end;
}

