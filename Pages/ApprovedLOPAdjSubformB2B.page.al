page 33001524 "Approved LOP Adj. Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'Appr. LOP Adjustment Subform';
    DelayedInsert = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Attendance Lines B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Document Type"; "Document Type")
                {
                    ToolTip = 'Select the Document Type.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Select the Document No.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Shows the Employee No.';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    var
                        TempCount: Integer;
                    begin
                        TempCount := 1;
                    end;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Shows the Employee Name.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Enter the Loss of Pay Adjustment Start date.';
                    Caption = 'LOP Adj Date';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        ValidateLopAdjDate();
                    end;
                }
                field("Worked Shift"; "Worked Shift")
                {
                    ToolTip = 'Shows the Employee Worked Shift for loss of Pay Adjustment.';
                    ApplicationArea = all;
                }
                field("Start Time"; "Start Time")
                {
                    ToolTip = 'Shows the work Start Time of the Employee.';
                    ApplicationArea = all;
                }
                field("End Time"; "End Time")
                {
                    ToolTip = 'Shows the End time of Work done by employee.';
                    ApplicationArea = all;
                }
                field("Leave Type"; "Leave Type")
                {
                    ToolTip = 'Shows the Leave type against which loss of pay to be adjusted.';
                    ApplicationArea = all;
                }
                field("LOP Period"; "LOP Period")
                {
                    ToolTip = 'Shows the Loss of pay Period.';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        ValidateLopPeriod();
                    end;
                }
                field("LOP Adj."; "LOP Adj.")
                {
                    ToolTip = 'Shows the no. of days Loss pay adjusted.';
                    Visible = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        if LopAdjHeader.GET("Document Type", "Document No.") then begin
            "Employee Code" := LopAdjHeader."Employee Code";
            if EmployeeRec.GET("Employee Code") then
                "Employee Name" := EmployeeRec."First Name";
        end;
    end;

    var
        LopAdjHeader: Record "Attendance Lines B2B";
        ChkLopAdjLines: Record "Attendance Lines B2B";
        EmployeeRec: Record "Employee B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        Text001Lbl: Label 'Please select a working day';
        Text002Lbl: Label 'Duplicate entry exists for the Employee : %1 on Date : %2 against Document No : %3', Comment = '%1 =EmployeeName ; %2 =StartDate ; %3 = DocumentNo';

    procedure ValidateLopAdjDate();
    begin
        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", "Employee Code");
        DailyAttendance.SETRANGE(Date, "Start Date");
        if DailyAttendance.FINDFIRST() then begin
            "End Date" := "Start Date";
            if not DailyAttendance."Non-Working" then
                VALIDATE("Worked Shift", DailyAttendance."Revised Shift")
            else
                ERROR(Text001Lbl);
        end;

        ChkLopAdjLines.RESET();
        ChkLopAdjLines.SETRANGE("Document Type", "Document Type");
        ChkLopAdjLines.SETRANGE("Employee Code", "Employee Code");
        ChkLopAdjLines.SETRANGE("Start Date", "Start Date");
        if ChkLopAdjLines.FINDFIRST() then
            ERROR(Text002Lbl, ChkLopAdjLines."Employee Name",
                   ChkLopAdjLines."Start Date", ChkLopAdjLines."Document No.");
    end;

    procedure ValidateLopPeriod();
    begin
        case "LOP Period" of
            "LOP Period"::" ":
                "LOP Adj." := 0;
            "LOP Period"::"Half Day":
                "LOP Adj." := 0.5;
            "LOP Period"::"Full Day":
                "LOP Adj." := 1;
        end;
    end;

    local procedure OnDeactivateForm();
    begin
        CurrPage.UPDATE(false);
    end;
}

