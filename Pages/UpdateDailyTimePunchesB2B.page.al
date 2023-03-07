page 33001578 "Update Daily Time Punches B2B"
{
    // version B2BHR1.00.00

    Caption = 'Update Daily Time Punches';
    PageType = Worksheet;
    SourceTable = "Daily Time Punches B2B";
    SourceTableView = SORTING("Employee No.", Date)
                      ORDER(Ascending)
                      WHERE("Updated to Daily Attendance" = CONST(false));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DateFilter1; DateFilter)
                {
                    ToolTip = 'Enter the Date for Filter.';
                    Caption = 'Date Filter';
                    ApplicationArea = all;

                    trigger OnValidate();
                    var
                    //AppManagement : Codeunit ApplicationManagement;
                    begin
                        //if AppManagement.MakeDateFilter(DateFilter) = 0 then;
                        //TimePunches.SETFILTER("Date filter",DateFilter);
                        //DateFilter := TimePunches.GETFILTER("Date filter");

                        //ApplyFilters;
                    end;
                }
            }
            repeater(Group)
            {
                Caption = 'Group';
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee No. for Update Daily Time punches.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ToolTip = 'Show the date of update daily time punches.';
                    ApplicationArea = all;
                }
                field("Time IN"; "Time IN")
                {
                    ToolTip = 'In time of Employee.';
                    ApplicationArea = all;
                }
                field("Time Out"; "Time Out")
                {
                    ToolTip = 'Out time of employee.';
                    ApplicationArea = all;
                }
                field("Shift Worked"; "Shift Worked")
                {
                    ToolTip = 'Shift Worked by the Employee.';
                    ApplicationArea = all;
                }
                field("Updated to Daily Attendance"; "Updated to Daily Attendance")
                {
                    ToolTip = 'Check Mark when Daily attendance updated.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            //Caption = 'Major';
            group("&Functions")
            {
                Caption = '&Functions';
                action("Import From Excel")
                {
                    ToolTip = 'Specifes the document to import from excel.';
                    Caption = 'Import From Excel';
                    Image = ImportExcel;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        CLEAR(ImportReport);
                        ImportReport.RUNMODAL();
                        CurrPage.UPDATE();
                    end;
                }
                action("&Update to Daily Attendance")
                {
                    ToolTip = ' Specifies the update of Daily attendance.';
                    Caption = '&Update to Daily Attendance';
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        TimePunches.RESET();
                        TimePunches.SETRANGE("Updated to Daily Attendance", false);
                        TotalLines := TimePunches.COUNT();
                        LineNo := 0;
                        Window.OPEN(Text005Lbl);

                        TimePunches.RESET();
                        TimePunches.SETRANGE("Updated to Daily Attendance", false);
                        if TimePunches.FINDFIRST() then begin
                            repeat
                                if DailyAtt.GET(TimePunches."Employee No.", TimePunches.Date) then begin
                                    if (TimePunches."Time IN" <> 000000T) and (TimePunches."Time Out" <> 000000T) then begin
                                        DailyAtt.VALIDATE(DailyAtt."Time In", TimePunches."Time IN");
                                        DailyAtt.VALIDATE(DailyAtt."Time Out", TimePunches."Time Out");
                                        DailyAtt.VALIDATE("Shift Code", TimePunches."Shift Worked");
                                        DailyAtt."Attendance Type" := DailyAtt."Attendance Type"::Present;
                                        DailyAtt.Absent := 0;
                                        DailyAtt.Present := 1;
                                    end;
                                    DailyAtt.MODIFY();
                                    TimePunches."Updated to Daily Attendance" := true;
                                    TimePunches.MODIFY();
                                    Window.UPDATE(1, TimePunches."Employee No.");
                                    Window.UPDATE(2, ROUND(LineNo / TotalLines * 10000, 1));
                                    SLEEP(2);
                                end else
                                    ERROR(Text002Lbl, TimePunches."Employee No.");
                            until TimePunches.NEXT() = 0;
                            Window.CLOSE();
                            MESSAGE(Text003Lbl);
                        end else begin
                            Window.CLOSE();
                            ERROR(Text004Lbl);
                        end;
                    end;
                }
            }
        }
    }

    var
        TimePunches: Record "Daily Time Punches B2B";
        DailyAtt: Record "Daily Attendance B2B";
        ImportReport: Report "Import Time Punches B2B";
        TotalLines: Integer;
        Window: Dialog;
        LineNo: Integer;
        DateFilter: Text[30];
        Text002Lbl: Label 'Daily Attendance not found for the employee %1', Comment = '%1 = Employee no';
        Text003Lbl: Label 'Updated Successfully';
        Text004Lbl: Label 'There is nothing to Update';
        Text005Lbl: Label 'Employee No.  #1####### \ Progress @2@@@@@@@@', Comment = '%1 = No ; %2 = Progress';

    procedure ApplyFilters();
    begin
        SETFILTER(Date, DateFilter);
        CurrPage.UPDATE();
    end;
}

