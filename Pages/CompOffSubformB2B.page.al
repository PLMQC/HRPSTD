page 33001507 "Comp Off Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'Comp Off Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Attendance Lines B2B";


    layout
    {
        area(content)
        {
            repeater("<Control1900000001>")
            {

                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Employee code';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee name';
                }
                field("Start Date"; "Start Date")
                {
                    Caption = 'Date Worked';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Start Date';

                    trigger OnDrillDown();
                    begin
                        if AttHeader2.GET("Document Type", "Document No.") then begin
                            DailyAttendanceGRec.RESET();
                            DailyAttendanceGRec.SETRANGE("Employee No.", "Employee Code");
                            DailyAttendanceGRec.SETRANGE(Year, AttHeader2.Year);
                            DailyAttendanceGRec.SETRANGE(Month, AttHeader2.Month);
                            DailyAttendanceGRec.SETRANGE("Non-Working", true);
                            DailyAttendanceGRec.SetRange("Comp Off", false);
                            if PAGE.RUNMODAL(PAGE::"Daily Attendance List B2B", DailyAttendanceGRec) = ACTION::LookupOK then
                                if not DailyAttendanceGRec."Comp Off" then begin
                                    "Start Date" := DailyAttendanceGRec.Date;
                                    "Comp Off Date" := DailyAttendanceGRec.Date;
                                    "Worked Shift" := DailyAttendanceGRec."Shift Code";
                                    "Start Time" := DailyAttendanceGRec."Time In";
                                    "End Time" := DailyAttendanceGRec."Time Out";
                                    "C Off Hours" := DailyAttendanceGRec."Hours Worked";
                                    VALIDATE("C Off Hours");
                                end else
                                    ERROR(Text001Lbl);
                        end;

                    end;
                }
                field("Comp Off Date"; "Comp Off Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The comp off date';
                }
                field("Worked Shift"; "Worked Shift")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Worked shift';
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Start time';
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The end time';
                }
                field("C Off Hours"; "C Off Hours")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The compoff hr';
                }
            }
        }
    }

    actions
    {
    }

    var
        AttHeader2: Record "Attendance Header B2B";
        DailyAttendanceGRec: Record "Daily Attendance B2B";
        Text001Lbl: Label 'Comp off is already approved for this Date';

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
}

