page 33001224 "Employee Shift B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Shift';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Employee Shift B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Specifies the Shift start time applicable to all employee''s';
                    ApplicationArea = all;
                }
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Specifies the Shift code applicable to an employee or employee''s';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        TextErr: Label 'Please select shift based on location';
                    begin
                        IF Employee.GET("Employee Code") THEN
                            IF NOT ShiftMaster.GET("Shift Code", Employee."Location Code") THEN
                                ERROR(TextErr);

                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Modify &Attendance")
                {
                    Caption = 'Modify &Attendance';
                    Image = ImplementRegAbsence;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the modify attendance details.';

                    trigger OnAction();
                    begin
                        UpdateShiftTimings();
                    end;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        UpdateShiftTimings();
    end;

    var
        Employee: Record "Employee B2B";
        ShiftMaster: Record "Shift Master B2B";

}

