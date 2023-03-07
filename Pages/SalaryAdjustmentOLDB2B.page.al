page 33001346 "Salary Adjustment - OLD B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Adjustament - OLD';
    PageType = Worksheet;
    SourceTable = "Salary Adjustments B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ToolTip = '"Specifies the Current month "';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentMonthOnAfterValidate();
                    end;
                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ToolTip = 'Specifies the cureent year';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrentYearOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102152001)
            {
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = '"Specifies the Employee or Department code "';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = '"Specifies the employee Name "';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specifies the Month of the Appplication';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Specifies the year of the Application';
                    ApplicationArea = all;
                }
                field(Conveyance; Conveyance)
                {
                    ToolTip = 'Specifies the Conveyance expencess during the period';
                    Visible = ConveyanceVisible;
                    ApplicationArea = all;
                }
                field("EnterTainment All."; "EnterTainment All.")
                {
                    ToolTip = 'Specifies the Entertainment expenses during the period';
                    ApplicationArea = all;
                }
                field(Medical; Medical)
                {
                    ToolTip = 'Specifies the Medical expenses during the period';
                    Visible = MedicalVisible;
                    ApplicationArea = all;
                }
                field(Subscription; Subscription)
                {
                    ToolTip = 'Specifies the Subscriptions during the period';
                    ApplicationArea = all;
                }
                field("Night Shift All."; "Night Shift All.")
                {
                    ToolTip = 'Specifies the Night shiftes all during the period';
                    Visible = "Night Shift All.Visible";
                    ApplicationArea = all;
                }
                field(Others; Others)
                {
                    ToolTip = 'Specifies the other expenses during the period';
                    ApplicationArea = all;
                }
                field(Food; Food)
                {
                    ToolTip = 'speficies the Food expenses during the period';
                    Visible = FoodVisible;
                    ApplicationArea = all;
                }
                field("Total Amount"; "Total Amount")
                {
                    ToolTip = 'Specifies the Total Amount of the the avtivity';
                    ApplicationArea = all;
                }
                field(Deductions; Deductions)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the deductions';
                }
                field("Net Payable"; "Net Payable")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the net payable';
                }
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the template';
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Batch';
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the document no';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the posting date';
                }
                field("No Series"; "No Series")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the no series';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the status';
                }

            }
            field("COUNT"; COUNT())
            {
                Caption = 'Count';
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the count';
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
                action("Get &Employees")
                {
                    Caption = 'Get &Employees';
                    Image = GetLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Get employees';

                    trigger OnAction();
                    begin
                        Employee.RESET();
                        Employee.SETRANGE(Blocked, false);
                        if Employee.FINDFIRST() then
                            repeat
                                SalaryAdjust.INIT();
                                SalaryAdjust."Employee Code" := Employee."No.";
                                SalaryAdjust.Month := CurrentMonth;
                                SalaryAdjust.Year := CurrentYear;
                                SalaryAdjust."Employee Name" := Employee."First Name";
                                SalaryAdjust2.SETRANGE("Employee Code", Employee."No.");
                                SalaryAdjust2.SETRANGE(Month, CurrentMonth);
                                SalaryAdjust2.SETRANGE(Year, CurrentYear);
                                if not SalaryAdjust2.FINDFIRST() then
                                    SalaryAdjust.INSERT();
                            until Employee.NEXT() = 0;
                    end;
                }
                action("Update &Salary Payments")
                {
                    Caption = 'Update &Salary Payments';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Update Salary Payments';
                    trigger OnAction();
                    begin
                        if not CurrentTrainee then begin
                            SalaryAdjust.RESET();
                            SalaryAdjust.SETRANGE(Month, CurrentMonth);
                            SalaryAdjust.SETRANGE(Year, CurrentYear);
                            SalaryAdjust.SETRANGE(Trainee, false);
                            if SalaryAdjust.FINDFIRST() then
                                repeat
                                    UpdateAdjustments(SalaryAdjust);
                                until SalaryAdjust.NEXT() = 0;
                        end else begin
                            SalaryAdjust.RESET();
                            SalaryAdjust.SETRANGE(Month, CurrentMonth);
                            SalaryAdjust.SETRANGE(Year, CurrentYear);
                            SalaryAdjust.SETRANGE(Trainee, true);
                            if SalaryAdjust.FINDFIRST() then
                                repeat
                                    UpdateAdjustments(SalaryAdjust);
                                until SalaryAdjust.NEXT() = 0;
                        end;
                    end;
                }
                separator(Separator1102152067)
                {
                }
            }
        }
    }

    trigger OnInit();
    begin
        "Night Shift All.Visible" := true;
        MedicalVisible := true;
        FoodVisible := true;
        ConveyanceVisible := true;
    end;

    trigger OnOpenPage();
    begin
        CurrentTrainee := false;
        if HRSetup.FINDFIRST() then begin
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        end;
        SelectYear();
        SelectMonth();
        SelectTrainee();
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        SalaryAdjust: Record "Salary Adjustments B2B";
        SalaryAdjust2: Record "Salary Adjustments B2B";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        CurrentTrainee: Boolean;
        [InDataSet]
        ConveyanceVisible: Boolean;
        [InDataSet]
        FoodVisible: Boolean;
        [InDataSet]
        MedicalVisible: Boolean;
        [InDataSet]
        "Night Shift All.Visible": Boolean;
        Text005Lbl: Label 'Jan';
        Text006Lbl: Label 'Febuary';
        Text007Lbl: Label 'March';
        Text008Lbl: Label 'April';
        Text009Lbl: Label 'May';
        Text010Lbl: Label 'June';
        Text011Lbl: Label 'July';
        Text012Lbl: Label 'August';
        Text013Lbl: Label 'September';
        Text014Lbl: Label 'October';
        Text015Lbl: Label 'November';
        Text016Lbl: Label 'December';

    procedure SelectYear();
    begin
        SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(false);
    end;

    procedure SelectMonth();
    begin
        SETRANGE(Month, CurrentMonth);
        CurrPage.UPDATE(false);
    end;

    procedure SelectTrainee();
    begin
        SETRANGE(Trainee, CurrentTrainee);
        CurrPage.UPDATE(false);
        if CurrentTrainee then begin
            ConveyanceVisible := false;
            FoodVisible := false;
            MedicalVisible := false;
            "Night Shift All.Visible" := false;
        end else begin
            ConveyanceVisible := true;
            FoodVisible := true;
            MedicalVisible := true;
            "Night Shift All.Visible" := true;
        end;
    end;

    procedure UpdateAdjustments(SalaryAdjust: Record "Salary Adjustments B2B");
    var
        MonthlyAttendance: Record "Monthly Attendance B2B";
    begin
        MonthlyAttendance.SETRANGE("Employee Code", SalaryAdjust."Employee Code");
        MonthlyAttendance.SETRANGE("Pay Slip Month", SalaryAdjust.Month);
        MonthlyAttendance.SETRANGE(Year, SalaryAdjust.Year);
        if MonthlyAttendance.FINDFIRST() then begin
            MonthlyAttendance."Monthly Exp" := SalaryAdjust."Net Payable";
            MonthlyAttendance."Net Payable" := MonthlyAttendance."Net Salary" + MonthlyAttendance."Monthly Exp";
            MonthlyAttendance.MODIFY();
        end;
    end;

    procedure ReturnMonth(Month: Integer): Code[20];
    begin
        case Month of
            1:
                exit(Text005Lbl);
            2:
                exit(Text006Lbl);
            3:
                exit(Text007Lbl);
            4:
                exit(Text008Lbl);
            5:
                exit(Text009Lbl);
            6:
                exit(Text010Lbl);
            7:
                exit(Text011Lbl);
            8:
                exit(Text012Lbl);
            9:
                exit(Text013Lbl);
            10:
                exit(Text014Lbl);
            11:
                exit(Text015Lbl);
            12:
                exit(Text016Lbl);
        end;

    end;

    // procedure SalaryAdjPayment(SalaryAdjustment2: Record "Salary Adjustments B2B");
    // var

    //     SalaryAdjustment: Record "Salary Adjustments B2B";
    //     "Account No.": Code[20];
    //     ConveyanceAmt: Decimal;
    //     PSDAmt: Decimal;
    //     MedicalAmt: Decimal;
    //     FoodAmt: Decimal;
    //     FoundryAllAmt: Decimal;
    //     NightShiftAllAmt: Decimal;
    //     OthersAmt: Decimal;
    //     PostDate: Date;
    // begin
    //     PostDate := 0D;
    //     SalaryAdjustment.RESET();
    //     SalaryAdjustment.SETRANGE(Month, SalaryAdjustment2.Month);
    //     SalaryAdjustment.SETRANGE(Year, SalaryAdjustment2.Year);
    //     SalaryAdjustment.SETRANGE("Employee Code", SalaryAdjustment2."Employee Code");
    //     if SalaryAdjustment.FINDFIRST() then begin
    //         ConveyanceAmt := 0;
    //         PSDAmt := 0;
    //         MedicalAmt := 0;
    //         FoundryAllAmt := 0;
    //         NightShiftAllAmt := 0;
    //         FoodAmt := 0;
    //         HrSetup.GET();
    //         if SalaryAdjustment.Conveyance <> 0 then begin
    //             HrSetup.TESTFIELD("Conveyance Acc.");
    //             "Account No." := HrSetup."Conveyance Acc.";
    //             ConveyanceAmt := SalaryAdjustment.Conveyance;
    //             SalaryAdjGenJnlLine(SalaryAdjustment, TempJournal, TempBatch, "DocNo.", PostDate, "Account No.", ConveyanceAmt);
    //         end;

    //         if SalaryAdjustment."EnterTainment All." <> 0 then begin
    //             HrSetup.TESTFIELD("Entertainment Acc.");
    //             "Account No." := HrSetup."Entertainment Acc.";
    //             PSDAmt := SalaryAdjustment."EnterTainment All.";
    //             SalaryAdjGenJnlLine(SalaryAdjustment, TempJournal, TempBatch, "DocNo.", PostDate, "Account No.", PSDAmt);
    //         end;

    //         if SalaryAdjustment.Medical <> 0 then begin
    //             HrSetup.TESTFIELD("Medical Acc.");
    //             "Account No." := HrSetup."Medical Acc.";
    //             MedicalAmt := SalaryAdjustment.Medical;
    //             SalaryAdjGenJnlLine(SalaryAdjustment, TempJournal, TempBatch, "DocNo.", PostDate, "Account No.", MedicalAmt);
    //         end;

    //         if SalaryAdjustment."Night Shift All." <> 0 then begin
    //             HrSetup.TESTFIELD("Night Shift All. Acc.");
    //             "Account No." := HrSetup."Night Shift All. Acc.";
    //             NightShiftAllAmt := SalaryAdjustment."Night Shift All.";
    //             SalaryAdjGenJnlLine(SalaryAdjustment, TempJournal, TempBatch, "DocNo.", PostDate, "Account No."
    //                                , NightShiftAllAmt);
    //         end;

    //         if SalaryAdjustment.Others <> 0 then begin
    //             HrSetup.TESTFIELD("Others Acc.");
    //             "Account No." := HrSetup."Others Acc.";
    //             OthersAmt := SalaryAdjustment.Others;
    //             SalaryAdjGenJnlLine(SalaryAdjustment, TempJournal, TempBatch, "DocNo.", PostDate, "Account No."
    //                                , OthersAmt);
    //         end;

    //         if SalaryAdjustment.Food <> 0 then begin
    //             HrSetup.TESTFIELD("Food Acc.");
    //             "Account No." := HrSetup."Food Acc.";
    //             FoodAmt := SalaryAdjustment.Food;
    //             SalaryAdjGenJnlLine(SalaryAdjustment, TempJournal, TempBatch, "DocNo.", PostDate, "Account No.", FoodAmt);
    //         end;
    //     end;
    // end;

    // procedure SalaryAdjGenJnlLine(SalAdjustment: Record "Salary Adjustments B2B"; JournalTemplate: Code[20]; JournalBatch: Code[20]; "Doc No.": Code[20]; PostDate: Date; "AccountNo.": Code[20]; Amount: Decimal);
    // var
    //     GenJournalLine: Record "Gen. Journal Line";
    //     EmpPostingGroup: Record "Employee Posting Group B2B";
    //     GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    //     TableID: array[10] of Integer;
    //     No: array[10] of Code[20];
    // begin
    //     if Employee.GET(SalAdjustment."Employee Code") then
    //         GenJournalLine.INIT();
    //     GenJournalLine."Journal Template Name" := TempJournal;
    //     GenJournalLine."Journal Batch Name" := TempBatch;
    //     GenJournalLine."Document No." := SalAdjustment."Document No";
    //     GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;
    //     GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
    //     GenJournalLine."Account No." := "AccountNo.";
    //     GenJournalLine.VALIDATE("Account No.");
    //     GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
    //     Employee.SETRANGE("No.", SalAdjustment."Employee Code");
    //     if Employee.FINDFIRST() then begin
    //         EmpPostingGroup.GET(Employee."Emp Posting Group");
    //         GenJournalLine."Bal. Account No." := EmpPostingGroup."Salary Payable Acc.";
    //     end;
    //     GenJournalLine.VALIDATE("Bal. Account No.");
    //     GenJournalLine."Posting Date" := TODAY();
    //     GenJournalLine.Description := CopyStr(
    //         SalAdjustment."Employee Code" + ' ' + GenJournalLine.Description + ' ' +
    //         ReturnMonth(SalAdjustment.Month) + ' ' +
    //         FORMAT(SalAdjustment.Year), 1, 100);
    //     GenJournalLine.VALIDATE(Amount, Amount);
    //     GenJournalLine."Source Code" := Text017Lbl;
    //     TableID[1] := DATABASE::"Employee B2B";
    //     No[1] := SalAdjustment."Employee Code";
    //     GenJournalLine."Dimension Set ID" := DimMgt.GetDefaultDimID(TableID, No, '',
    //                                          GenJournalLine."Shortcut Dimension 1 Code", GenJournalLine."Shortcut Dimension 1 Code", 0, 0);
    //     GenJnlPostLine.RunWithCheck(GenJournalLine);
    // end;

    local procedure CurrentYearOnAfterValidate();
    begin
        SelectMonth();
    end;

    local procedure CurrentMonthOnAfterValidate();
    begin
        SelectMonth();
    end;
}

