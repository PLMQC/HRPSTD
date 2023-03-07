page 33001231 "Monthly Attendance B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Monthly Attendance';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Monthly Attendance B2B";
    ApplicationArea = all;
    UsageCategory = Tasks;



    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Physical Location"; "Physical Location")
                {
                    ApplicationArea = all;

                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Payroll Year in Monthly Attendance';

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Payroll Month in Monthly Attendance';

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field(CurrentCadre1; CurrentCadre)
                {
                    Caption = 'Pay Cadre';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Pay Cadre wise Employee"s in Monthly Attendance';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Lookup_B2B.SETRANGE("LookupType Name", Text330001Lbl);
                        if PAGE.RUNMODAL(0, Lookup_B2B) = ACTION::LookupOK then
                            CurrentCadre := Lookup_B2B."Lookup Name";

                        SelectPayCadre();
                    end;

                    trigger OnValidate();
                    begin
                        CurrentCadreOnAfterValidate();
                    end;
                }
                field(ShowAll1; ShowAll)
                {
                    Caption = 'Show All';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Option to choose show all Employee"s in Monthly Attendance';

                    trigger OnValidate();
                    begin
                        ShowAllOnAfterValidate();
                    end;
                }
                field(Status1; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Status for Document Pending Approval';
                }
            }
            repeater(Control1102152000)
            {
                FreezeColumn = "Employee Code";
                field("Employee Code"; "Employee Code")
                {
                    Caption = 'Employee No';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee No in Monthly Attendance';
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Name ';
                }
                field(Days; Days)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Monthly attendance days';
                }
                field("Weekly Off"; "Weekly Off")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Weekly Off in Monthly Attendance';
                }
                field(Holidays; Holidays)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Holiday"s in Monthly Attendance';
                }
                field("Over Time Hrs"; "Over Time Hrs")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Over Time Hrs in Monthly Attendance';
                }
                field("C Off Hours"; "C Off Hours")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the C Off Hours in Monthly Attendance';
                }
                field("Late Hours"; "Late Hours")
                {
                    Caption = 'Late Min';
                    Editable = false;
                    Visible = true;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Late Hrs details in Monthly Attendance';
                }
                field("Early Going Hours"; "Early Going Hours")
                {
                    Caption = 'Early Going Hours';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Early Going Hrs details in Monthly Attendance';

                }
                field(NoofWorkingDays1; NoofWorkingDays)
                {
                    Caption = 'No of Working Days';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the No Of working Days in Monthly Attendance';
                }
                field(Attendance; Attendance)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Attendance details for Every month';
                }
                field(Leaves; Leaves)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Leave Details in Monthly Attendance';
                }
                field("Loss Of Pay"; "Loss Of Pay")
                {
                    Caption = 'Loss Of Pay Days';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Loss Of Pay Days in Monthly Attendance';
                }
                field(Processed; Processed)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Processed salary details in Monthly Attendance';
                }
                field(Posted; Posted)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Posted Monthly Attendance details';
                }
                field("Gross Salary"; "Gross Salary")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Gross Salary in Monthly Attendance';
                }
                field("Computed Gross Salary"; "Computed Gross Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Computed Gross Salary in Monthly Attendance';
                }
                field(Deductions; Deductions)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Payelements Deduction details in Monthly Attendance';
                }
                field("Net Salary"; "Net Salary")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Employee Net Salary in Monthly Attendance';
                }
                field("Rounding Amount"; "Rounding Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Rounding Amount as per setup rounding Precision';
                }
                field("New Employment Days"; "New Employment Days")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the New Employee days in Monthly Attendance';
                }
                field("No G/L Posting"; "No G/L Posting")
                {
                    Caption = 'Outsourced Employee';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Outsourced Employee in Monthly Attendance';

                }

            }
            group(Postings)
            {
                Caption = 'Postings';
                field(TempBatch1; TempBatch)
                {
                    Caption = 'Journal Batch Name';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Journal Batch Name for posting purpose in Monthly Attendance';

                    trigger OnLookup(Var Text: Text): Boolean;
                    var
                        NoSeriesMgt: Codeunit 396;
                    begin
                        JournalTemplate.RESET();
                        JournalTemplate.SETRANGE("Form ID", 33001231);
                        if JournalTemplate.FINDFIRST() then
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                        if PAGE.RUNMODAL(33001274, JournalBatch) = ACTION::LookupOK then begin
                            TempBatch := JournalBatch.Name;
                            TempJournal := JournalBatch."Journal Template Name";
                            PostDate := TODAY();
                        end;
                        JournalBatch.FILTERGROUP(0);
                        JournalBatch.RESET();
                        JournalBatch.SETRANGE(Name, TempBatch);
                        if JournalBatch.FINDFIRST() then
                            NoSeries.SETRANGE("Code", JournalBatch."No. Series");
                        if not NoSeries.IsEmpty() then
                            "DocNo." := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WorkDate(), true);
                    end;
                }
                field(PostDate1; PostDate)
                {
                    Caption = 'PostDate';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Post Date Details in Monthly Attendance';
                }
                field("DocNo.1"; "DocNo.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Document No in Monthly Attendance';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Processed &Salary")
                {
                    Caption = 'Processed &Salary';
                    Image = AllocatedCapacity;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Processed Salary List B2B";
                    RunPageLink = "Employee Code" = FIELD("Employee Code"),
                                  Year = FIELD(Year),
                                  "Pay Slip Month" = FIELD("Pay Slip Month");
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Processed & Salary in Monthly Attendance';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Dimension while posting document in Monthly Attendance';

                    trigger OnAction();
                    begin
                        ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
                action("LOP Adjustment ")
                {
                    Caption = 'LOP Adjustment';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "LOP Adjustment Entries B2B";
                    RunPageLink = "Employee No." = FIELD("Employee Code"),
                                  "Adj. LOP Year" = FIELD(Year),
                                  "Adj. LOP Month" = FIELD("Pay Slip Month");
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the LOP Adjustment entries in Monthly Attendance';
                }
            }
        }
        area(processing)
        {
            group(Navigations)
            {
                Caption = 'Navigation';
                Image = Change;
            }
            action(Previous)
            {
                Caption = 'Previous';
                Image = PreviousSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                ApplicationArea = all;
                ToolTip = 'Specicfies the Previous Month details in Monthly Attendance';

                trigger OnAction();
                begin
                    if CurrentMonth = 1 then
                        Year := CurrentYear - 1
                    else
                        Year := CurrentYear;

                    if CurrentMonth = 1 then
                        Month := 12
                    else
                        Month := CurrentMonth - 1;

                    Navigate.SETRANGE(Year, Year);
                    Navigate.SETRANGE("Pay Slip Month", Month);
                    if Navigate.FINDFIRST() then begin
                        CurrentYear := Year;
                        CurrentMonth := Month;
                        SelectYear();
                        SelectMonth();
                    end else
                        ERROR(Text002Lbl);
                end;
            }
            action(Next)
            {
                Caption = 'Next';
                Image = NextSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specicfies the Next month in Monthly Attendance';

                trigger OnAction();
                begin
                    if CurrentMonth = 12 then
                        Year := CurrentYear + 1
                    else
                        Year := CurrentYear;

                    if CurrentMonth = 12 then
                        Month := 1
                    else
                        Month := CurrentMonth + 1;

                    Navigate.SETRANGE(Year, Year);
                    Navigate.SETRANGE("Pay Slip Month", Month);
                    if Navigate.FINDFIRST() then begin
                        CurrentYear := Year;
                        CurrentMonth := Month;
                        SelectYear();
                        SelectMonth();
                    end else
                        ERROR(Text002Lbl);
                end;
            }
            action("&Pay Slip")
            {
                Caption = '&Pay Slip';
                Image = UserCertificate;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                ToolTip = 'Specicfies the Employee Payslip in Monthly Attendance';

                trigger OnAction();
                begin
                    MonAttendance.RESET();
                    MonAttendance.SETRANGE("Employee Code", "Employee Code");
                    MonAttendance.SETRANGE("Pay Slip Month", "Pay Slip Month");
                    MonAttendance.SETRANGE(Year, Year);
                    REPORT.RUNMODAL(33001215, true, false, MonAttendance);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                group("Process &Salary")
                {
                    Caption = 'Process &Salary';
                    Image = CashFlow;
                    action("&Current Employee")
                    {
                        Caption = '&Current Employee';
                        Image = CalculateRemainingUsage;
                        ApplicationArea = all;
                        ToolTip = 'Specicfies the Process salary current Employee in Monthly Attendance';

                        trigger OnAction();
                        var
                            FFCheckEmployee: Record "Employee B2B";
                            FFValidationLbl: Label 'Employee %1 is under Full & Final Settlement', Comment = '%1 = Employee Code';
                        begin
                            if not Blocked then
                                if not Processed then begin
                                    FFCheckEmployee.Get("Employee Code");
                                    if CheckFF(FFCheckEmployee."Last Working Day", "Pay Slip Month", Year) then begin
                                        CreateDim(DATABASE::"Employee B2B", "Employee Code", Rec);
                                        MODIFY();
                                        ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                        ProcessedSalary.SETRANGE("Employee Code", "Employee Code");
                                        ProcessedSalary.SETRANGE("Pay Slip Month", "Pay Slip Month");
                                        ProcessedSalary.SETRANGE(Year, Year);
                                        if ProcessedSalary.FINDFIRST() then
                                            ProcessedSalary.DELETEALL();
                                        SalaryProcess.ProcessSalary(Rec);
                                        SalaryProcess.DeductionPriority(Rec);
                                        MESSAGE(Text001Lbl);
                                    end else
                                        Message(FFValidationLbl, "Employee Code");
                                end;
                            if PayElement.FINDFIRST() then
                                repeat
                                    PayElement.Processed := false;
                                    PayElement.MODIFY();
                                until PayElement.NEXT() = 0;
                        end;
                    }
                    action("&All Employees")
                    {
                        Caption = '&All Employees';
                        Image = CalculateRemainingUsage;

                        ApplicationArea = all;
                        ToolTip = 'Specicfies the Process Salary All Employee in Monthly Attendance';

                        trigger OnAction();
                        var
                            FFcheckEmployee: Record "Employee B2B";
                            FFValidationLbl: Label 'Employee %1 is under Full & Final Settlement', Comment = '%1 = Employee Code';
                        begin
                            Window.OPEN(Text007Lbl);
                            MonAttendance2.RESET();
                            MonAttendance2.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year);
                            MonAttendance2.SETRANGE("Pay Slip Month", CurrentMonth);
                            MonAttendance2.SETRANGE(Year, CurrentYear);
                            PayrollUsers.GET(USERID());
                            if PayrollUsers."Multiple Locations" <> '' then
                                MonAttendance2.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                            else
                                MonAttendance2.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                            MonAttendance2.SETRANGE(Blocked, false);
                            MonAttendance2.SETRANGE(Processed, false);
                            MonAttendance2.SetRange("No G/L Posting", false);
                            if MonAttendance2.FINDFIRST() then begin
                                repeat
                                    FFCheckEmployee.Get(MonAttendance2."Employee Code");
                                    if CheckFF(FFcheckEmployee."Last Working Day", MonAttendance2."Pay Slip Month", MonAttendance2.Year) then begin
                                        MonAttendance2.CreateDim(DATABASE::"Employee B2B", MonAttendance2."Employee Code", MonAttendance2);
                                        MonAttendance2.MODIFY();
                                        ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                        ProcessedSalary.SETRANGE("Employee Code", MonAttendance2."Employee Code");
                                        ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance2."Pay Slip Month");
                                        ProcessedSalary.SETRANGE(Year, MonAttendance2.Year);
                                        if ProcessedSalary.FINDFIRST() then
                                            ProcessedSalary.DELETEALL();
                                        Window.UPDATE(1, MonAttendance2."Employee Code");
                                        SalaryProcess.ProcessSalary(MonAttendance2);
                                        SalaryProcess.DeductionPriority(MonAttendance2);
                                    end else
                                        Message(FFValidationLbl, MonAttendance2."Employee Code");
                                until MonAttendance2.NEXT() = 0;
                                MESSAGE(Text001Lbl);
                            end;
                            if PayElement.FINDFIRST() then
                                repeat
                                    PayElement.Processed := false;
                                    PayElement.MODIFY();
                                until PayElement.NEXT() = 0;
                            Window.CLOSE();
                        end;
                    }
                }
                group(Reprocess)
                {
                    Caption = 'Reprocess';
                    Image = Recalculate;
                    action(Action1102152020)
                    {
                        Caption = '&Current Employee';
                        Image = DefaultFault;
                        ApplicationArea = all;
                        ToolTip = 'Specicfies the Re Process Salary current Employee in Monthly Attendance';

                        trigger OnAction();
                        var
                            FFcheckEmployee: Record "Employee B2B";
                            FFValidationLbl: Label 'Employee %1 is under Full & Final Settlement', Comment = '%1 = Employee Code';
                        begin
                            if not Blocked then
                                if not Posted then begin
                                    FFCheckEmployee.Get("Employee Code");
                                    if CheckFF(FFcheckEmployee."Last Working Day", "Pay Slip Month", Year) then begin
                                        CreateDim(DATABASE::"Employee B2B", "Employee Code", Rec);
                                        MODIFY();
                                        ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                        ProcessedSalary.SETRANGE("Employee Code", "Employee Code");
                                        ProcessedSalary.SETRANGE("Pay Slip Month", "Pay Slip Month");
                                        ProcessedSalary.SETRANGE(Year, Year);
                                        ProcessedSalary.SETFILTER("Computation Type", '<>%1', Text3300025Lbl);
                                        if ProcessedSalary.FindSet() then    //B2BDNROn24Feb2023
                                            ProcessedSalary.DELETEALL();     //B2BDNROn24Feb2023
                                        CheckLoans(Rec);
                                        SalaryProcess.ProcessSalary(Rec);
                                        SalaryProcess.DeductionPriority(Rec);
                                        MESSAGE(Text004Lbl);
                                    end else
                                        Message(FFValidationLbl, "Employee Code");
                                end else
                                    ERROR(Text006Lbl);
                            if PayElement.FINDFIRST() then
                                repeat
                                    PayElement.Processed := false;
                                    PayElement.MODIFY();
                                until PayElement.NEXT() = 0;
                        end;
                    }
                    action(Action1102152021)
                    {
                        Caption = '&All Employees';
                        Image = DefaultFault;
                        ApplicationArea = all;
                        ToolTip = 'Specicfies the Re Process Salary All Employee in Monthly Attendance';


                        trigger OnAction();
                        var
                            FFcheckEmployee: Record "Employee B2B";
                            FFValidationLbl: Label 'Employee %1 is under Full & Final Settlement', Comment = '%1 = Employee Code';
                        begin
                            Window.OPEN(Text007Lbl);
                            MonAttendance2.RESET();
                            MonAttendance2.SETRANGE("Pay Slip Month", CurrentMonth);
                            MonAttendance2.SETRANGE(Year, CurrentYear);
                            PayrollUsers.GET(USERID());
                            if PayrollUsers."Multiple Locations" <> '' then
                                MonAttendance2.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                            else
                                MonAttendance2.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                            MonAttendance2.SETRANGE(Posted, false);
                            MonAttendance2.SETRANGE(Blocked, false);
                            MonAttendance2.SetRange("No G/L Posting", false);
                            if MonAttendance2.FINDFIRST() then begin
                                repeat
                                    FFCheckEmployee.Get(MonAttendance2."Employee Code");
                                    if CheckFF(FFcheckEmployee."Last Working Day", MonAttendance2."Pay Slip Month", MonAttendance2.Year) then begin
                                        ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                        ProcessedSalary.SETRANGE("Employee Code", MonAttendance2."Employee Code");
                                        ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance2."Pay Slip Month");
                                        ProcessedSalary.SETRANGE(Year, MonAttendance2.Year);
                                        if ProcessedSalary.FindSet() then   //B2BDNROn24Feb2023
                                            ProcessedSalary.DELETEALL();   //B2BDNROn24Feb2023
                                        CheckLoans(MonAttendance2);
                                        Window.UPDATE(1, MonAttendance2."Employee Code");
                                        SalaryProcess.ProcessSalary(MonAttendance2);
                                        SalaryProcess.DeductionPriority(MonAttendance2);
                                    end else
                                        Message(FFValidationLbl, MonAttendance2."Employee Code");
                                until MonAttendance2.NEXT() = 0;
                                MESSAGE(Text004Lbl);
                            end;
                            if PayElement.FINDFIRST() then
                                repeat
                                    PayElement.Processed := false;
                                    PayElement.MODIFY();
                                until PayElement.NEXT() = 0;
                            Window.CLOSE();
                        end;
                    }
                }
                separator(Separator1102152066)
                {
                }
                action("&Post Salary")
                {
                    Caption = '&Post Salary';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Post Salary in Monthly Attendance';

                    trigger OnAction();
                    begin

                        if not Blocked then
                            SalaryPost();
                    end;
                }
                separator(Separator1102152016)
                {
                }
                action("Process &Attendance")
                {
                    Caption = 'Process &Attendance';
                    Image = ImplementRegAbsence;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Process Attendance  in Monthly Attendance';

                    trigger OnAction();
                    begin
                        if CONFIRM(Text010Lbl) then
                            if CONFIRM(Text011Lbl) then
                                UpdateAttendance();
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Document Status Release';

                    trigger OnAction();
                    begin
                        MonAtt.RESET();
                        MonAtt.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAtt.SETRANGE(Year, CurrentYear);
                        MonAtt.SETRANGE(Blocked, false);
                        MonAtt.MODIFYALL(Status, MonAtt.Status::Released);
                    end;
                }
                action("Re&Open")
                {
                    Caption = 'Re&Open';
                    Image = ReOpen;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Document Status Re-Open';

                    trigger OnAction();
                    begin
                        MonAtt.RESET();
                        MonAtt.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAtt.SETRANGE(Year, CurrentYear);
                        MonAtt.SETRANGE(Blocked, false);
                        MonAtt.MODIFYALL(Status, MonAtt.Status::Open);
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                action("Send To OutLook")
                {
                    Caption = 'Send To OutLook';
                    Image = SendMail;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Option to choose print details for Outlook';

                    trigger OnAction();
                    begin
                        SendToOutLook();
                    end;
                }
            }

            //CHB2B20Oct2022<<

            action(GetPFUploadFormat)
            {
                Caption = 'Get PF Upload Format';
                ApplicationArea = All;

                Promoted = true;
                PromotedCategory = Process;
                Image = Export;

                trigger OnAction()
                begin

                    Xmlport.Run(50005, true, false);
                    //Report.RunModal(REPORT::EmployeeESIReport, true, true, EmployeeB2bGVar);

                end;

            }
            //CHB2B20Oct2022>>

            //CHB2BJAN52023<<
            action(GetExitPfREPORT)
            {
                Caption = 'Get Exit Pf Report';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                //Image = Export;
                trigger OnAction()
                begin
                    MonthlyAttendenceGrec.Reset();
                    MonthlyAttendenceGrec.SetRange("Pay Slip Month", rec."Pay Slip Month");
                    MonthlyAttendenceGrec.SetRange(Year, rec.Year);
                    if MonthlyAttendenceGrec.FindLast() then
                        Xmlport.Run(50006, true, false, MonthlyAttendenceGrec);

                end;
            }
            //CHB2BJAN52023>>
            //CHB2BJAN92023<<
            action(MC_Template)
            {
                Caption = 'MC_Template';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = Excel;
                trigger OnAction()

                begin
                    MonthlyAttendenceGrec.Reset();
                    MonthlyAttendenceGrec.SetRange("Pay Slip Month", rec."Pay Slip Month");
                    MonthlyAttendenceGrec.SetRange(Year, rec.Year);
                    if MonthlyAttendenceGrec.FindSet() then
                        Report.Run(50003, true, false, MonthlyAttendenceGrec);
                end;
            }
            //CHB2BJAN92023<<

        }
    }

    trigger OnAfterGetRecord();
    begin
        CALCFIELDS(Days, "Loss Of Pay", Leaves, "C Off Hours");
        NoofWorkingDays := Days - "Loss Of Pay" - Leaves;
    end;

    trigger OnOpenPage();
    begin

        if HRSetup.FINDFIRST() then begin
            CurrentYear := HRSetup."Salary Processing Year";
            CurrentMonth := HRSetup."Salary Processing month";
        end;
        ShowAll := true;
        if ShowAll then begin
            Rec.RESET();
            SelectYear();
            SelectMonth();
        end else begin
            SelectYear();
            SelectMonth();
            SelectPayCadre();
        end;

    end;

    var
        Lookup_B2B: Record Lookup_B2B;
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";

        EmpPostingGroup: Record "Employee Posting Group B2B";
        PayElement: Record "Pay Elements B2B";
        ProcessedSalary: Record "Processed Salary B2B";

        NoSeries: Record "No. Series";
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        MonAttendance: Record "Monthly Attendance B2B";
        Navigate: Record "Monthly Attendance B2B";
        MonAttendance2: Record "Monthly Attendance B2B";

        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        EmployeeLeaves: Record "Employee Leaves B2B";
        PayYear: Record "Payroll Year B2B";
        EmpLeaveHistory: Record "Detailed Leave Records B2B";
        EmpLeaveHistoryNum: Record "Detailed Leave Records B2B";
        MonthlyAtt: Record "Monthly Attendance B2B";
        MonAtt: Record "Monthly Attendance B2B";
        GenJnlLine: Record "Gen. Journal Line";
        PayrollUsers: Record "Payroll Location Users B2B";
        ProvisionalLeaves: Report "Provisional Leaves B2B";
        MonthlyAttendanceb2b: Record "Monthly Attendance B2B";
        SMTP: Codeunit "Email Message";
        NoSeriesMgt: Codeunit 396;
        PayrollProcess: Codeunit "Payroll Process Posting B2B";
        SalaryProcess: Codeunit "Salary Process B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text001Lbl: Label 'Processing is completed.';
        Text002Lbl: Label 'There are no records with in these filters.';
        TempBatch: Code[10];
        TempJournal: Code[10];
        "DocNo.": Code[20];
        Text004Lbl: Label 'Re-processing is completed.';
        PostDate: Date;
        Text005Lbl: Label 'Salary posted.';
        Text006Lbl: Label 'Salary cannot be reprocessed for Posted salary records.';
        Text007Lbl: Label 'Employee No..... #1######################', Comment = '%1 = No';
        LastNoSeriseNo: Code[20];
        Answer: Boolean;
        Text008Lbl: Label 'Do you want to post?';
        Text009Lbl: Label 'All employees are not posted, still you want to update the processing month and year.';
        EndDate: Date;
        StartDate: Date;
        TempDate1: Date;
        TempDate2: Date;
        Num: Integer;
        Text010Lbl: Label 'Do you want to update leaves?';
        Text011Lbl: Label 'After this, you cannot alter/apply any leaves for this month. Do you want to continue?';
        currentlyDeductedAmount: Decimal;
        EmpPayslip: list of [Text];
        PersonalMail: Text[100];
        Name: Text[100];
        FileName: Text[100];

        MonthName: Text[31];
        RepWindow: Dialog;
        Text012Lbl: Label 'One or more Leave applications are pending for Approval';
        Text013Lbl: Label 'Mails sent successfully';
        Text014Lbl: Label 'Employee NO.#1###########', Comment = '%1 = No';
        Text015Lbl: Label 'Computing Gross Salary ..... \ Employee No   #1########################### \ Employee Name #2###########################', Comment = '%1 = No ; %2 = Name';
        NothingToPostErrLbl: Label 'There is nothing to post.';
        Text330001Lbl: Label 'PAY CADRE';
        Text330002Lbl: Label 'VDA';
        Text330003Lbl: Label 'LEAVE YEAR';
        Text330004Lbl: Label '<-1M>';
        Text330005Lbl: Label '<1M>';
        Text3300018Lbl: Label 'sairam@b2bsoftech.com';
        Text3300019Lbl: Label 'Pay Slip';
        Text3300020Lbl: Label 'Pay slip for the month of';
        Text3300021Lbl: Label 'for the year';
        Text3300024Lbl: Label 'ADDITIONS AND DEDUCTIONS';
        Text3300025Lbl: Label 'INSURANCE';
        CurrentCadre: Code[30];
        Month: Integer;

        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text003Lbl: Label 'Attendance processing is completed.';

        ShowAll: Boolean;
        Window: Dialog;
        NoofWorkingDays: Decimal;
        EmployeeB2bGVar: record "Employee B2B";
        //CHB2BJAN302023<<
        MonthGvar: Integer;
        YearGvar: Integer;
        MonthlyAttendenceGrec: record "Monthly Attendance B2B";
    //CHB2BJAN302023<<
    //ReportGvar: Report EmployeeESIReport;


    procedure SelectYear();
    begin
        SETRANGE(Year, CurrentYear);
        SETRANGE(Blocked, false);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        SETRANGE("Pay Slip Month", CurrentMonth);
        SETRANGE(Blocked, false);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        CurrPage.UPDATE(false);
    end;

    procedure SelectStartingDate();
    begin
    end;

    procedure SelectEndingDate();
    begin
    end;

    procedure SelectPayCadre();
    begin
        if CurrentCadre <> '' then
            SETRANGE(PayCadre, CurrentCadre);
        SETRANGE(Blocked, false);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        CurrPage.UPDATE(false);
    end;

    procedure CheckLoans(MonAttendance: Record "Monthly Attendance B2B");
    var
        LoanDetails: Record "Loan Details B2B";
        Loan: Record Loan_B2B;
    begin
        LoanDetails.SETRANGE("Paid Month", MonAttendance."Pay Slip Month");
        LoanDetails.SETRANGE("Paid Year", MonAttendance.Year);
        LoanDetails.SETRANGE("Employee No.", MonAttendance."Employee Code");
        if LoanDetails.FINDFIRST() then
            repeat
                LoanDetails."Paid Month" := 0;
                LoanDetails."Paid Year" := 0;
                CLEAR(currentlyDeductedAmount);
                currentlyDeductedAmount := LoanDetails."EMI Deducted";
                LoanDetails."EMI Deducted" := 0;
                if LoanDetails."Loan Closed" then
                    LoanDetails."Loan Closed" := false;
                LoanDetails.Balance := LoanDetails.Balance + currentlyDeductedAmount;
                LoanDetails.MODIFY();
                Loan.SETRANGE(Id, LoanDetails."Loan Id");
                Loan.SETRANGE("Employee Code", LoanDetails."Employee No.");
                Loan.SETRANGE("Loan Type", LoanDetails."Loan Code");
                if Loan.FINDFIRST() then begin
                    Loan."Loan Balance" := LoanDetails.Balance;
                    Loan."Effective Amount" := LoanDetails."EMI Amount";
                    if Loan.Closed then
                        Loan.Closed := false;
                    Loan.MODIFY();
                end;
            until LoanDetails.NEXT() = 0;

    end;

    procedure SalaryPost();
    var
        PostGenJnl: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post";
        Flag: Boolean;
        Update: Boolean;
    begin
        Answer := CONFIRM(Text008Lbl);
        if Answer then begin
            if CurrentCadre = '' then begin
                PayrollUsers.GET(USERID());
                MonAttendance.RESET();
                if PayrollUsers."Multiple Locations" <> '' then
                    MonAttendance.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                else
                    MonAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                MonAttendance.SetRange("No G/L Posting", false);
                if MonAttendance.FINDSET() then
                    repeat

                        Employee.SETRANGE("No.", MonAttendance."Employee Code");
                        if Employee.FINDFIRST() then begin
                            Employee.TESTFIELD(Employee."Emp Posting Group");
                            Employee.TESTFIELD(Employee."Payroll Bus. Posting Group");
                        end;
                        EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
                        if EmpPostingGroup.FINDFIRST() then begin
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Salary Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."PF Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."TDS Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."ESI Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."EPS Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."EDLI Charges Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."PF Admin Charge Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."PT Payable Account");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."RIFA Charges Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Arrear Salary Payable Acc.");
                        end;
                    until MonAttendance.NEXT() = 0;
            end else begin
                PayrollUsers.GET(USERID());
                if PayrollUsers."Multiple Locations" <> '' then
                    MonAttendance.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                else
                    MonAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                MonAttendance.SETRANGE(PayCadre, CurrentCadre);
                MonAttendance.SetRange("No G/L Posting", false);
                if MonAttendance.FINDFIRST() then
                    repeat
                        Employee.SETRANGE("No.", MonAttendance."Employee Code");
                        if Employee.FINDFIRST() then begin
                            Employee.TESTFIELD(Employee."Emp Posting Group");
                            Employee.TESTFIELD(Employee."Payroll Bus. Posting Group");
                        end;
                        EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
                        if EmpPostingGroup.FINDFIRST() then begin
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Salary Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."PF Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."TDS Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."ESI Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."EPS Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."EDLI Charges Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."PF Admin Charge Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."PT Payable Account");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."RIFA Charges Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Arrear Salary Payable Acc.");
                        end;
                    until MonAttendance.NEXT() = 0;
            end;
            if CurrentCadre = '' then begin
                Window.OPEN(Text007Lbl);
                MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                MonAttendance.SETRANGE(Year, CurrentYear);
                MonAttendance.SETRANGE(Processed, true);
                PayrollUsers.GET(USERID());
                if PayrollUsers."Multiple Locations" <> '' then
                    MonAttendance.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                else
                    MonAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                MonAttendance.SETRANGE(Posted, false);
                MonAttendance.SetRange("No G/L Posting", false);
                if MonAttendance.FINDSET() then begin
                    repeat
                        MonAttendance.TestField(Status, MonAttendance.Status::Released);
                        MonAttendance."Journal Batch Name" := TempBatch;
                        MonAttendance."Journal Template Name" := TempJournal;
                        MonAttendance."Document No." := "DocNo.";
                        MonAttendance."Posting Date" := PostDate;
                        MonAttendance.MODIFY();
                        PayrollProcess.ProcessPosting(MonAttendance);
                        Flag := true;
                        Window.UPDATE(1, MonAttendance."Employee Code");
                        MonAttendance.Posted := true;
                        MonAttendance.MODIFY();
                        ProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
                        ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
                        ProcessedSalary.SETRANGE(ProcessedSalary.Year, MonAttendance.Year);
                        if ProcessedSalary.FINDFIRST() then
                            repeat
                                ProcessedSalary.Posted := true;
                                ProcessedSalary."Posting Date" := PostDate;
                                ProcessedSalary.MODIFY();
                            until ProcessedSalary.NEXT() = 0;
                    until MonAttendance.NEXT() = 0;

                    PostGenJnl.Reset();
                    PostGenJnl.SetRange("Journal Template Name", TempJournal);
                    PostGenJnl.SetRange("Journal Batch Name", TempBatch);
                    if PostGenJnl.FindSet() then begin

                        GenJnlPostLine.Run(PostGenJnl);
                    end;
                    "DocNo." := '';

                end;
                Window.CLOSE();
                if Flag then
                    MESSAGE(Text005Lbl)
                else
                    MESSAGE(NothingToPostErrLbl);

                SelectYear();
                SelectMonth();
            end else begin
                Window.OPEN(Text007Lbl);
                MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                MonAttendance.SETRANGE(Year, CurrentYear);
                MonAttendance.SETRANGE(PayCadre, CurrentCadre);
                PayrollUsers.GET(USERID());
                if PayrollUsers."Multiple Locations" <> '' then
                    MonAttendance.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                else
                    MonAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                MonAttendance.SETRANGE(Processed, true);
                MonAttendance.SETRANGE(Posted, false);
                MonAttendance.SetRange("No G/L Posting", false);
                if MonAttendance.FINDSET() then begin
                    repeat
                        MonAttendance."Journal Batch Name" := TempBatch;
                        MonAttendance."Journal Template Name" := TempJournal;
                        MonAttendance."Document No." := "DocNo.";
                        MonAttendance."Posting Date" := PostDate;
                        MonAttendance.MODIFY();
                        PayrollProcess.ProcessPosting(MonAttendance);
                        Flag := true;
                        Window.UPDATE(1, MonAttendance."Employee Code");
                        MonAttendance.Posted := true;
                        MonAttendance.MODIFY();
                        ProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
                        ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
                        ProcessedSalary.SETRANGE(ProcessedSalary.Year, MonAttendance.Year);
                        if ProcessedSalary.FINDFIRST() then
                            repeat
                                ProcessedSalary.Posted := true;
                                ProcessedSalary."Posting Date" := PostDate;
                                ProcessedSalary.MODIFY();
                            until ProcessedSalary.NEXT() = 0;
                    until MonAttendance.NEXT() = 0;
                    "DocNo." := '';
                end;
                Window.CLOSE();
                if Flag then
                    MESSAGE(Text005Lbl)
                else
                    MESSAGE(NothingToPostErrLbl);

                SelectYear();
                SelectMonth();
                SelectPayCadre();
            end;
            LastNoSeriseNo := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE(), true);

            Update := true;
            MonAttendance.RESET();
            PayrollUsers.GET(USERID());
            if PayrollUsers."Multiple Locations" <> '' then
                MonAttendance.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
            else
                MonAttendance.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
            MonAttendance.SETRANGE(Year, CurrentYear);
            MonAttendance.SetRange("No G/L Posting", false);
            if MonAttendance.FINDSET() then
                repeat
                    if MonAttendance.Posted = false then
                        Update := false
                until MonAttendance.NEXT() = 0;
            if not Update then begin
                if CONFIRM(Text009Lbl) then
                    if HRSetup.FINDFIRST() then
                        if HRSetup."Salary Processing month" = 12 then begin
                            HRSetup.VALIDATE("Salary Processing month", 1);
                            HRSetup."Salary Processing Year" := HRSetup."Salary Processing Year" + 1;
                            HRSetup.MODIFY();
                        end else begin
                            HRSetup."Salary Processing month" := HRSetup."Salary Processing month" + 1;
                            HRSetup.VALIDATE(HRSetup."Salary Processing month");
                            HRSetup."Salary Processing Year" := HRSetup."Salary Processing Year";
                            HRSetup.MODIFY();
                        end;

            end else
                if HRSetup.FINDFIRST() then
                    if HRSetup."Salary Processing month" = 12 then begin
                        HRSetup.VALIDATE("Salary Processing month", 1);
                        HRSetup."Salary Processing Year" := HRSetup."Salary Processing Year" + 1;
                        HRSetup.MODIFY();
                    end else begin
                        HRSetup."Salary Processing month" := HRSetup."Salary Processing month" + 1;
                        HRSetup.VALIDATE(HRSetup."Salary Processing month");
                        HRSetup."Salary Processing Year" := HRSetup."Salary Processing Year";
                        HRSetup.MODIFY();
                    end;

        end;
    end;

    procedure UpdateAttendance();
    var
        DetailedLeaves: Record "Detailed Leave Records B2B";
        ProvLeaves: Record "Provisional Leaves B2B";
        LapseLeaves: Record "Detailed Leave Records B2B";
        PostedLeaveAppLine: Record "Posted Leave App Line B2B";
        ProLeaves: Decimal;
        NoofLapsed: Decimal;

    begin
        PayYear.RESET();
        PayYear.SETRANGE("Year Type", Text330003Lbl);
        PayYear.SETRANGE(Closed, false);
        if PayYear.FINDFIRST() then begin
            EndDate := PayYear."Year End Date";
            StartDate := PayYear."Year Start Date";
        end;

        HRSetup.GET();

        MonAttendance2.RESET();
        MonAttendance2.SETRANGE("Pay Slip Month", CurrentMonth);
        MonAttendance2.SETRANGE(Year, CurrentYear);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonAttendance2.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonAttendance2.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if MonAttendance2.FINDFIRST() then
            repeat
                CheckforProcessAttendance();
                PostedLeaveAppLine.RESET();
                PostedLeaveAppLine.SETFILTER("Employee No.", MonAttendance2."Employee Code");
                PostedLeaveAppLine.SETRANGE("Set For Approval", true);
                if PostedLeaveAppLine.FINDFIRST() then
                    repeat
                        if ((PostedLeaveAppLine."From Date" >= MonAttendance2."Period Start Date") and
                            (PostedLeaveAppLine."From Date" <= MonAttendance2."Period End Date")) or
                          ((PostedLeaveAppLine."To Date" >= MonAttendance2."Period Start Date") and
                           (PostedLeaveAppLine."To Date" <= MonAttendance2."Period End Date")) then
                            ERROR(Text012Lbl);
                    until PostedLeaveAppLine.NEXT() = 0;
                PostedLeaveAppLine.RESET();
                PostedLeaveAppLine.SETFILTER("Employee No.", MonAttendance2."Employee Code");
                PostedLeaveAppLine.SETRANGE("Pending For Cancellation", true);
                if PostedLeaveAppLine.FINDFIRST() then
                    repeat
                        if ((PostedLeaveAppLine."From Date" >= MonAttendance2."Period Start Date") and
                            (PostedLeaveAppLine."From Date" <= MonAttendance2."Period End Date")) or
                           ((PostedLeaveAppLine."To Date" >= MonAttendance2."Period Start Date") and
                            (PostedLeaveAppLine."To Date" <= MonAttendance2."Period End Date")) then
                            ERROR(Text012Lbl);
                    until PostedLeaveAppLine.NEXT() = 0;

                EmployeeLeaves.RESET();
                EmployeeLeaves.SETRANGE("No.", MonAttendance2."Employee Code");
                EmployeeLeaves.SETFILTER("Leave Code", '<>%1', HRSetup."Compensatory Leave Code");
                if EmployeeLeaves.FINDFIRST() then
                    repeat

                        GradeWiseLeaves.RESET();
                        GradeWiseLeaves.SETRANGE(GradeWiseLeaves."Leave Code", EmployeeLeaves."Leave Code");
                        GradeWiseLeaves.SETRANGE(GradeWiseLeaves."Leave Pay Cadre", EmployeeLeaves."Leave Pay Cadre");
                        GradeWiseLeaves.SETRANGE("Location Code", MonAttendance2."Location Code");
                        if GradeWiseLeaves.FINDFIRST() then;
                        TempDate1 := StartDate;
                        repeat
                            TempDate1 := CALCDATE(GradeWiseLeaves."Crediting Interval", TempDate1);
                            TempDate2 := CALCDATE(Text330004Lbl, TempDate1);
                        until (TempDate1 >= EndDate) or ((DATE2DMY(TempDate2, 2) = CurrentMonth) and (DATE2DMY(TempDate2, 3) = CurrentYear));
                        TempDate1 := CALCDATE(Text330004Lbl, TempDate1);
                        EmpLeaveHistoryNum.RESET();
                        if EmpLeaveHistoryNum.FINDLAST() then
                            Num := EmpLeaveHistoryNum."Entry No." + 1
                        else
                            Num := 1;
                        if (DATE2DMY(TempDate1, 2) = CurrentMonth) and (DATE2DMY(TempDate1, 3) = CurrentYear) then begin
                            if (DATE2DMY(TempDate1, 2) = DATE2DMY(EndDate, 2)) and (DATE2DMY(TempDate1, 3) = DATE2DMY(EndDate, 3)) then begin
                                NoofLapsed := 0;
                                LapseLeaves.RESET();
                                LapseLeaves.SETRANGE("Employee No.", EmployeeLeaves."No.");
                                LapseLeaves.SETRANGE("Leave Code", EmployeeLeaves."Leave Code");
                                LapseLeaves.SETRANGE(Year, DATE2DMY(EndDate, 3));
                                if LapseLeaves.FINDFIRST() then
                                    repeat
                                        NoofLapsed := NoofLapsed + LapseLeaves."No. of Leaves";
                                    until LapseLeaves.NEXT() = 0;

                                EmpLeaveHistory.INIT();
                                EmpLeaveHistory."Entry No." := Num;
                                EmpLeaveHistory."Employee No." := EmployeeLeaves."No.";
                                EmpLeaveHistory."Leave Code" := EmployeeLeaves."Leave Code";
                                EmpLeaveHistory."Leave Description" := EmployeeLeaves."Leave Description";
                                EmpLeaveHistory."Entry Type" := EmpLeaveHistory."Entry Type"::Lapse;
                                EmpLeaveHistory."Entry Date" := CALCDATE(Text330005Lbl, TempDate1);
                                EmpLeaveHistory."Posting Date" := workdate();
                                EmpLeaveHistory."Leave Pay Cadre" := EmployeeLeaves."Leave Pay Cadre";
                                if GradeWiseLeaves."Carry Forward" then
                                    if NoofLapsed > GradeWiseLeaves."Max.Leaves to Carry Forward" then
                                        EmpLeaveHistory.VALIDATE("No. of Leaves", -(NoofLapsed - GradeWiseLeaves."Max.Leaves to Carry Forward"))
                                    else
                                        EmpLeaveHistory.VALIDATE("No. of Leaves", -(NoofLapsed));
                                EmpLeaveHistory.Month := (DATE2DMY(CALCDATE(Text330005Lbl, TempDate1), 2));
                                EmpLeaveHistory.Year := (DATE2DMY(CALCDATE(Text330005Lbl, TempDate1), 3));
                                DetailedLeaves.RESET();
                                DetailedLeaves.SETRANGE("Employee No.", EmpLeaveHistory."Employee No.");
                                DetailedLeaves.SETRANGE("Entry Type", EmpLeaveHistory."Entry Type");
                                DetailedLeaves.SETRANGE("Leave Code", EmpLeaveHistory."Leave Code");
                                DetailedLeaves.SETRANGE(Month, EmpLeaveHistory.Month);
                                DetailedLeaves.SETRANGE(Year, EmpLeaveHistory.Year);
                                if not DetailedLeaves.FINDFIRST() then
                                    if EmpLeaveHistory."No. of Leaves" <> 0 then begin
                                        EmpLeaveHistory.INSERT();
                                        Num := Num + 1;
                                    end;

                                CLEAR(ProvisionalLeaves);
                                ProvisionalLeaves.SetPayrollYear(EndDate);
                                ProvisionalLeaves.SetRecord(MonAttendance2."Employee Code", EmployeeLeaves."Leave Code");
                                ProvisionalLeaves.RUN();
                                ProvLeaves.RESET();
                                ProvLeaves.SETRANGE("Employee No.", MonAttendance2."Employee Code");
                                ProvLeaves.SETRANGE("Leave Code", EmployeeLeaves."Leave Code");
                                ProvLeaves.SETRANGE("Period End Date", MonAttendance2."Period End Date");
                                ProvLeaves.SETRANGE(Status, ProvLeaves.Status::Open);
                                if ProvLeaves.FINDFIRST() then begin
                                    ProvLeaves.Status := ProvLeaves.Status::Closed;
                                    ProvLeaves."Remaining Leaves" := 0;
                                    ProvLeaves.MODIFY();
                                end;

                            end else begin
                                ProLeaves := 0;
                                ProvLeaves.RESET();
                                ProvLeaves.SETRANGE("Employee No.", MonAttendance2."Employee Code");
                                ProvLeaves.SETRANGE("Leave Code", EmployeeLeaves."Leave Code");
                                ProvLeaves.SETRANGE("Period End Date", MonAttendance2."Period End Date");
                                ProvLeaves.SETRANGE(Status, ProvLeaves.Status::Open);
                                if ProvLeaves.FINDFIRST() then begin
                                    ProLeaves := ProLeaves + ProvLeaves."Remaining Leaves";
                                    ProvLeaves.Status := ProvLeaves.Status::Closed;
                                    ProvLeaves."Remaining Leaves" := 0;
                                    ProvLeaves.MODIFY();
                                end;
                                ProvLeaves.RESET();
                                ProvLeaves.SETRANGE("Employee No.", MonAttendance2."Employee Code");
                                ProvLeaves.SETRANGE("Period Start Date", (MonAttendance2."Period End Date" + 1));
                                ProvLeaves.SETRANGE("Leave Code", EmployeeLeaves."Leave Code");
                                ProvLeaves.SETRANGE(Status, ProvLeaves.Status::Open);
                                if ProvLeaves.FINDFIRST() then
                                    if ProLeaves <> 0 then begin
                                        ProvLeaves."Prev. Month  Balance" := ProLeaves;
                                        ProvLeaves."Remaining Leaves" := ProvLeaves."Remaining Leaves" + ProvLeaves."Prev. Month  Balance";
                                        ProvLeaves.MODIFY();
                                    end;

                            end;

                            EmpLeaveHistory.INIT();
                            EmpLeaveHistory."Entry No." := Num;
                            EmpLeaveHistory."Employee No." := EmployeeLeaves."No.";
                            EmpLeaveHistory."Leave Code" := EmployeeLeaves."Leave Code";
                            EmpLeaveHistory."Leave Description" := EmployeeLeaves."Leave Description";
                            EmpLeaveHistory."Entry Type" := EmpLeaveHistory."Entry Type"::Entitlement;
                            EmpLeaveHistory."Entry Date" := CALCDATE(Text330005Lbl, TempDate1);
                            EmpLeaveHistory."Posting Date" := workdate();
                            EmpLeaveHistory."Leave Pay Cadre" := EmployeeLeaves."Leave Pay Cadre";
                            EmpLeaveHistory.VALIDATE("No. of Leaves", GradeWiseLeaves."Leaves in Crediting Interval");
                            EmpLeaveHistory.Month := (DATE2DMY(CALCDATE(Text330005Lbl, TempDate1), 2));
                            EmpLeaveHistory.Year := (DATE2DMY(CALCDATE(Text330005Lbl, TempDate1), 3));
                            DetailedLeaves.RESET();
                            DetailedLeaves.SETRANGE("Employee No.", EmpLeaveHistory."Employee No.");
                            DetailedLeaves.SETRANGE("Entry Type", EmpLeaveHistory."Entry Type");
                            DetailedLeaves.SETRANGE("Leave Code", EmpLeaveHistory."Leave Code");
                            DetailedLeaves.SETRANGE(Month, EmpLeaveHistory.Month);
                            DetailedLeaves.SETRANGE(Year, EmpLeaveHistory.Year);
                            if DetailedLeaves.IsEmpty() then
                                EmpLeaveHistory.INSERT();

                        end;
                    until EmployeeLeaves.NEXT() = 0;

            until MonAttendance2.NEXT() = 0;

        MESSAGE(Text003Lbl);
    end;

    procedure CheckforProcessAttendance();
    begin
    end;

    procedure PrintPDFPaySlip();
    begin
    end;

    procedure SendToOutLook();
    var
        DateRec: Record Date;
        MailCreated: Boolean;
    begin

        MonAttendance2.RESET();
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonAttendance2.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonAttendance2.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        MonAttendance2.SETRANGE("Pay Slip Month", CurrentMonth);
        MonAttendance2.SETRANGE(Year, CurrentYear);
        MonAttendance2.SETRANGE(Processed, true);
        MonAttendance2.SETRANGE(Blocked, false);
        if MonAttendance2.FINDSET() then
            repeat
                Window.OPEN(Text014Lbl);
                Window.UPDATE(1, MonAttendance2."Employee Code");
                DateRec.Reset();
                DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
                DateRec.SetRange("Period No.", CurrentMonth);
                if DateRec.FindFirst() then
                    MonthName := DateRec."Period Name";
                Name := MonAttendance2."Employee Code";
                FileName := Name;
                Employee.GET(MonAttendance2."Employee Code");
                CLEAR(EmpPayslip);
                CLEAR(PersonalMail);
                //EmpPayslip := Employee."Company E-Mail";
                EmpPayslip.Add(Employee."Company E-Mail");
                PersonalMail := Employee."E-Mail";
                if EmpPayslip.Count() <> 0 then begin
                    //SMTP.CreateMessage(Text3300018Lbl, Text3300018Lbl, EmpPayslip, Text3300019Lbl, Text3300020Lbl + '  ' + FORMAT(MonthName) + '  ' + Text3300021Lbl + '  ' + FORMAT(CurrentYear), false);

                    //SMTP.CreateMessage(Text3300018Lbl, Text3300018Lbl, EmpPayslip, Text3300019Lbl, Text3300020Lbl + '  ' + FORMAT(MonthName) + '  ' + Text3300021Lbl + '  ' + FORMAT(CurrentYear));
                    //SMTP.Send();
                    MailCreated := true;
                    Window.CLOSE();
                end;
            until MonAttendance2.NEXT() = 0;
        if MailCreated then
            MESSAGE(Text013Lbl);
        MonAttendance2.MODIFY();
    end;

    procedure ComputeEmpGrossSalary();
    begin
        RepWindow.OPEN(Text015Lbl);
        CalculateGrossSalary(Rec);
        RepWindow.CLOSE();
        MESSAGE(Text001Lbl);
    end;

    procedure ComputeAllEmpGrossSalary();
    begin
        RepWindow.OPEN(Text015Lbl);
        MonAttendance2.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonAttendance2.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonAttendance2.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        MonAttendance2.SETRANGE("Pay Slip Month", CurrentMonth);
        MonAttendance2.SETRANGE(Year, CurrentYear);
        if MonAttendance2.FINDSET() then
            repeat
                CalculateGrossSalary(MonAttendance2);
            until MonAttendance2.NEXT() = 0;

        RepWindow.CLOSE();
        MESSAGE(Text001Lbl);
    end;

    procedure CalculateGrossSalary(MonAttendance3: Record "Monthly Attendance B2B");
    var
        LookupRec: Record Lookup_B2B;
        LookupRec2: Record Lookup_B2B;
        EmpPayElements: Record "Pay Elements B2B";
        EmpPayElements2: Record "Pay Elements B2B";
        PostedOthPayElements: Record "Posted Other PayElements B2B";
        ComputedGrossSalary: Decimal;
    begin
        CLEAR(ComputedGrossSalary);
        RepWindow.UPDATE(1, MonAttendance3."Employee Code");
        RepWindow.UPDATE(2, MonAttendance3."Employee Name");
        EmpPayElements2.RESET();
        EmpPayElements2.SETRANGE("Employee Code", MonAttendance3."Employee Code");
        if EmpPayElements2.FINDFIRST() then begin
            repeat
                LookupRec2.RESET();
                LookupRec2.SETRANGE("LookupType Name", Text3300024Lbl);
                LookupRec2.SETRANGE("Lookup Name", EmpPayElements2."Pay Element Code");
                LookupRec2.SETRANGE("Add/Deduct", LookupRec2."Add/Deduct"::Addition);
                if LookupRec2.FINDFIRST() then begin
                    LookupRec.GET(LookupRec2."Lookup Id", LookupRec2."Lookup Name", LookupRec2."Lookup Type");
                    LookupRec.MARK(true);
                end;
            until EmpPayElements2.NEXT() = 0;
            LookupRec.MARKEDONLY(true);
            if LookupRec.FINDFIRST() then
                repeat
                    EmpPayElements.RESET();
                    EmpPayElements.SETRANGE("Employee Code", MonAttendance3."Employee Code");
                    EmpPayElements.SETRANGE("Pay Element Code", LookupRec."Lookup Name");
                    if EmpPayElements.FINDLAST() then
                        if EmpPayElements."Pay Element Code" <> Text330002Lbl then
                            ComputedGrossSalary += EmpPayElements."Amount / Percent";

                until LookupRec.NEXT() = 0;

        end;
        PostedOthPayElements.RESET();
        PostedOthPayElements.SETRANGE("Employee No.", MonAttendance3."Employee Code");
        PostedOthPayElements.SETRANGE(Month, MonAttendance3."Pay Slip Month");
        PostedOthPayElements.SETRANGE(Year, MonAttendance3.Year);
        PostedOthPayElements.SETRANGE("Pay Element Code", Text330002Lbl);
        if PostedOthPayElements.FINDFIRST() then
            ComputedGrossSalary += PostedOthPayElements.Amount;
        if ComputedGrossSalary > 0 then begin
            MonAttendance3."Computed Gross Salary" := ComputedGrossSalary;
            MonAttendance3.MODIFY();
        end;
    end;

    procedure UpdateDimension();
    begin
        MonthlyAtt.RESET();
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            MonthlyAtt.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            MonthlyAtt.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        MonthlyAtt.SETRANGE("Pay Slip Month", CurrentMonth);
        MonthlyAtt.SETRANGE(MonthlyAtt.Year, CurrentYear);
        MonthlyAtt.SETRANGE(Blocked, false);
        if MonthlyAtt.FINDFIRST() then begin
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", MonthlyAtt."Shortcut Dimension 1 Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", MonthlyAtt."Shortcut Dimension 2 Code");
            GenJnlLine."Dimension Set ID" := MonthlyAtt."Dimension Set ID";
            MonthlyAtt.MODIFY();
        end;
    end;

    local procedure CurrentYearOnAfterValidate();
    begin
        SelectYear();
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        SelectMonth();
    end;

    local procedure CurrentCadreOnAfterValidate();
    begin
        SelectPayCadre();
    end;

    local procedure ShowAllOnAfterValidate();
    begin
        if ShowAll then begin
            Rec.RESET();
            SelectYear();
            SelectMonth();
        end else begin
            SelectYear();
            SelectMonth();
            SelectPayCadre();
        end;
    end;

    procedure CheckFF(LastDate: Date; Month: Integer; YearVar: Integer): Boolean
    begin
        if (LastDate = 0D) then
            exit(true);
        if (Date2DMY(LastDate, 2) <> Month) then
            exit(true)
        else
            exit(false)
    end;
}

