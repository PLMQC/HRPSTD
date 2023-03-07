page 33001520 "LOP Adj. Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'LOP Adj. Subform';
    DelayedInsert = true;
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
                    ApplicationArea = all;
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

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := false;
    end;

    var
        ChkLopAdjLines: Record "Attendance Lines B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        Text001Lbl: Label 'Duplicate entry exists for the Employee : %1 on Date : %2 against Document No : %3', Comment = '%1 = Employe name ; %2 = StartDate;%3 = Document No';

    procedure ValidateLopAdjDate();
    begin
        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", "Employee Code");
        DailyAttendance.SETRANGE(Date, "Start Date");
        if DailyAttendance.FINDFIRST() then begin
            "End Date" := "Start Date";
            VALIDATE("Worked Shift", DailyAttendance."Revised Shift");
        end;

        ChkLopAdjLines.RESET();
        ChkLopAdjLines.SETRANGE("Document Type", "Document Type");
        ChkLopAdjLines.SETRANGE("Employee Code", "Employee Code");
        ChkLopAdjLines.SETRANGE("Start Date", "Start Date");
        if ChkLopAdjLines.FINDFIRST() then
            ERROR(Text001Lbl, ChkLopAdjLines."Employee Name",
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

