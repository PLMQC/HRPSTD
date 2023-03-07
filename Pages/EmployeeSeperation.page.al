page 33001483 "Employee Seperation B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Seperation';
    PageType = Document;
    SourceTable = "Employee Seperation B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Seperation ID"; "Seperation ID")
                {
                    ToolTip = 'Choose unquie seperation id for number sereis.';
                    ApplicationArea = all;
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Employee ID"; "Employee ID")
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Displays Employee Name Selected by Employee no.';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Choose the date From which Employee is seperated.';
                    ApplicationArea = all;
                }
                field("Seperation Type"; "Seperation Type")
                {
                    ToolTip = 'Choose the Seperation Type From the Drop down.';
                    OptionCaption = 'Termination,,Resignation';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        if "Seperation Type" <> "Seperation Type"::Termination then begin
                            "Question IDEditable" := true;
                            GroudsofTerminationGroupEditab := false;
                            "Grouds of Termination Group" := '';
                            Cause := true;
                        end else begin
                            "Question IDEditable" := false;
                            "Question ID" := '';
                            GroudsofTerminationGroupEditab := true;
                            Cause := false;
                        end;
                        MakeItBlankValue();
                    end;
                }

                field("Cause of Inactivity"; "Cause of Inactivity")
                {
                    ToolTip = 'Select the Cause of inactivity.';
                    Editable = Cause;
                    ApplicationArea = all;
                }
                field("Grouds of Termination Group"; "Grouds of Termination Group")
                {
                    ToolTip = 'Select cause of Grounds of Termination.';
                    Editable = GroudsofTerminationGroupEditab;
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Shows the Status of Document open/Release.';
                    ApplicationArea = all;
                }
                field("Question ID"; "Question ID")
                {
                    ToolTip = 'Select the Question id.';
                    Editable = "Question IDEditable";
                    ApplicationArea = all;
                }
                field("Last working Date"; "Last working Date")
                {
                    ToolTip = 'Select the LAst Working Date of the Employee.';
                    ApplicationArea = all;

                }
                field("Notice Period Last Date"; "Notice Period Last Date")
                {
                    ToolTip = 'Select the Notice Period LAst Date.';
                    ApplicationArea = all;

                }
                //CHB2B21OCT2022<<
                field("Exit ReasonCode For Pf"; rec."Exit ReasonCode For Pf")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the EXIT REASONCODE FOR PF field.';
                }
                //CHB2B21OCT2022>>
                //CHB2BJAN52023<<
                field("Exit ReasonCode For ESI"; Rec."Exit ReasonCode For ESI")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the EXIT REASONCODE FOR ESI field.';
                }
                //CHB2BJAN52023>>
            }
            part(Control1102152006; "Employee Seperation Sub B2B")
            {

                SubPageLink = "Seperation ID" = FIELD("Seperation ID");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("&Termination Letter")
                {
                    ToolTip = 'Prints the Termination letter.';
                    Caption = '&Termination Letter';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        if "Seperation Type" = "Seperation Type"::Termination then begin
                            Employee.RESET();
                            Employee.SETRANGE("No.", "Employee ID");
                            REPORT.RUN(33001269, true, false, Employee);
                        end else
                            MESSAGE(Text001Lbl);
                    end;
                }
                action("&Relieving Cum Experience Letter")
                {
                    ToolTip = 'Prints the Relieving Cum Experience letter.';
                    Caption = '&Relieving Cum Experience Letter';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        if "Seperation Type" <> "Seperation Type"::Termination then begin
                            Employee.RESET();
                            Employee.SETRANGE("No.", "Employee ID");
                            REPORT.RUN(33001291, true, false, Employee);
                        end else
                            MESSAGE(Text002Lbl);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&untions")
            {
                Caption = 'F&untions';
                Image = "Action";
                action("Re&lease")
                {
                    ToolTip = 'Specifies the Document in Release.';
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Release(Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Re&open")
                {
                    ToolTip = 'Specifies the Document in Re-open.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Reopen();
                    end;
                }
                action("&Terminate the Employee")
                {
                    ToolTip = 'Specifies the Termination of the Employee.';
                    Caption = '&Terminate the Employee';
                    Image = Cancel;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        TerminateEmployee();
                    end;
                }
                action("&Update Resignation")
                {
                    ToolTip = 'specifies the update of Resignation.';
                    Caption = '&Update Resignation';
                    Image = UpdateUnitCost;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        UpdateRetirementandResignation();
                    end;
                }
                action("&Conduct Exit Interview")
                {
                    ToolTip = 'Specifies conduct Exit interview of employee.';
                    Caption = '&Conduct Exit Interview';
                    Image = TerminationDescription;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        ExitInterview();
                    end;
                }
                action("Print Exit Interview")
                {
                    ToolTip = 'Print Exit interview of the Employee.';
                    Caption = 'Print Exit Interview';
                    Image = Print;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        EmpSeperation.RESET();
                        //EmpSeperation.SETRANGE("Employee ID", "Employee ID");
                        EmpSeperation.SETRANGE("Seperation ID", "Seperation ID");
                        REPORT.RUN(33001286, true, false, EmpSeperation);
                    end;
                }

                action("&Post")
                {
                    ToolTip = 'post the Document of Employee seperation.';
                    Caption = '&Post';
                    Image = Post;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        UpdateEMPLastWorkingDate();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if "Seperation Type" <> "Seperation Type"::Termination then begin
            "Question IDEditable" := true;
            GroudsofTerminationGroupEditab := false;
            Cause := true;
        end else begin
            "Question IDEditable" := false;
            GroudsofTerminationGroupEditab := true;
            Cause := false;
        end;
    end;

    trigger OnOpenPage();
    begin
        if "Seperation Type" <> "Seperation Type"::Termination then begin
            "Question IDEditable" := true;
            GroudsofTerminationGroupEditab := false;
            Cause := true;
        end else begin
            "Question IDEditable" := false;
            GroudsofTerminationGroupEditab := true;
            Cause := false;
        end;
    end;

    var
        EmpSeperation: Record "Employee Seperation B2B";
        Employee: Record "Employee B2B";
        [InDataSet]
        "Question IDEditable": Boolean;
        [InDataSet]
        GroudsofTerminationGroupEditab: Boolean;
        [InDataSet]
        Cause: Boolean;
        Text001Lbl: Label 'You can''t generate Termination Letter for a Resigned/Retired employee';
        Text002Lbl: Label 'You can''t generate Relieving Letter for a terminated employee';
        Text33001Lbl: Label '<CM>';

    procedure DeleteDailyAttendance1();
    var
        DailyAttendance: Record "Daily Attendance B2B";
        MonthlyAtt: Record "Monthly Attendance B2B";
        CLoseProvisionalLeaves: Record "Provisional Leaves B2B";
        Currmonth: Integer;
        CurrYear: Integer;
        LastDate: Date;

    begin
        Currmonth := DATE2DMY("Effective Date", 2);
        CurrYear := DATE2DMY("Effective Date", 3);
        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", "Employee ID");
        DailyAttendance.SETRANGE(Month, Currmonth);
        DailyAttendance.SETRANGE(Year, CurrYear);
        if DailyAttendance.FINDFIRST() then
            repeat
                if DailyAttendance.Date > "Effective Date" then begin
                    DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Absent;
                    DailyAttendance.Absent := 1;
                    DailyAttendance.MODIFY();
                end;
            until DailyAttendance.NEXT() = 0;
        LastDate := CALCDATE(Text33001Lbl, "Effective Date");

        DailyAttendance.RESET();
        DailyAttendance.SETRANGE("Employee No.", "Employee ID");
        DailyAttendance.SETFILTER(Date, '>%1', LastDate);
        if DailyAttendance.FINDFIRST() then
            DailyAttendance.DELETEALL();
        MonthlyAtt.RESET();
        MonthlyAtt.SETRANGE("Employee Code", "Employee ID");
        if Currmonth = 12 then begin
            Currmonth := 1;
            CurrYear := CurrYear + 1;
        end else
            Currmonth += 1;
        MonthlyAtt.SETFILTER("Pay Slip Month", '>=%1', Currmonth);
        MonthlyAtt.SETRANGE(Year, CurrYear);
        if MonthlyAtt.FINDFIRST() then
            repeat
                MonthlyAtt.Blocked := true;
                MonthlyAtt.MODIFY();
            until MonthlyAtt.NEXT() = 0;

        CLoseProvisionalLeaves.RESET();
        CLoseProvisionalLeaves.SETRANGE(CLoseProvisionalLeaves."Employee No.", "Employee ID");
        if CLoseProvisionalLeaves.FINDFIRST() then
            repeat
                CLoseProvisionalLeaves.Status := CLoseProvisionalLeaves.Status::Closed;
                CLoseProvisionalLeaves.MODIFY();
            until CLoseProvisionalLeaves.NEXT() = 0;
    end;

    procedure MakeItBlankValue();
    begin
        if "Seperation Type" = "Seperation Type"::Termination then
            "Question ID" := ''
        else
            if "Seperation Type" <> "Seperation Type"::Termination then begin
                "Cause of Inactivity" := '';
                "Grouds of Termination Group" := '';
            end;
    end;

    procedure UpdateEMPLastWorkingDate()
    var
        EmployeeB2B: Record "Employee B2B";
        EmpSepHeadGRec: Record "Employee Seperation B2B";
        Text005Lbl: Label 'Do you want update Employee %1 last working date', Comment = '%1 = Id';
        Text006Lbl: Label 'Document posted successfully';

    begin
        if not confirm(strsubstno(Text005Lbl, "Employee ID"), false) then
            exit;
        EmployeeB2B.RESET();
        EmployeeB2B.SETRANGE("No.", "Employee ID");
        if EmployeeB2B.FINDFIRST() then begin
            EmployeeB2B."Last Working Day" := "Last working Date";
            Employeeb2b.blocked := true;
            Employeeb2b."Inactive Date" := "Last working Date";
            EmployeeB2B.Status := EmployeeB2B.Status::Inactive;
            EmployeeB2B.MODIFY();
            EmpSepHeadGRec.GET("Seperation ID");
            EmpSepHeadGRec."Seperation Status" := EmpSepHeadGRec."Seperation Status"::Posted;
            EmpSepHeadGRec.MODIFY();
            MESSAGE(Text006Lbl);
        end;

        DeleteDailyAttendance2();



    end;
}

