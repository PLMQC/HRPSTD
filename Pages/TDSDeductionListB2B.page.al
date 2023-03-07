page 33001257 "TDS Deduction List B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Deduction List';
    CardPageID = "TDS Deductions B2B";
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Emp TDS Deduction B2B";
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(PayrollYearType1; PayrollYearType)
                {
                    Caption = 'Financial Year';
                    ToolTip = 'Specifies the payroll year type in TDS decuction list';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PayrollYear.RESET();
                        PayrollYear.SETRANGE("Year Type", Text003Lbl);
                        if PAGE.RUNMODAL(0, PayrollYear) = ACTION::LookupOK then begin
                            PayrollYearType := PayrollYear."Year Type";
                            PayrollYearStDate := PayrollYear."Year Start Date";
                            PayrollYearEndDate := PayrollYear."Year End Date";
                        end;
                        UpdateYear();
                    end;
                }
                field(PayrollYearStDate1; PayrollYearStDate)
                {
                    Caption = 'Start Date';
                    Editable = false;
                    ToolTip = 'Specifies the payroll year starting date in the TDS dedcution list';
                    ApplicationArea = all;
                }
                field(PayrollYearEndDate1; PayrollYearEndDate)
                {
                    Caption = 'End Date';
                    Editable = false;
                    ToolTip = 'Specifies the payroll end year in the TDS deduction list';
                    ApplicationArea = all;
                }
            }
            repeater(Control1102152000)
            {
                field("Employee No."; "Employee No.")
                {
                    Editable = true;
                    ToolTip = 'Specifies the employee no in the line level';
                    ApplicationArea = all;
                }
                field("Year Starting Date"; "Year Starting Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the year starting date of the TDS dedcution list';
                    ApplicationArea = all;
                }
                field("Year Ending Date"; "Year Ending Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the year ending date of the TDS dedcution list';
                    ApplicationArea = all;
                }
                field("Gross Salary"; "Gross Salary")
                {
                    Editable = false;
                    ToolTip = 'Specifies the gross salary of the emloyee in the TDS dedcution list';
                    ApplicationArea = all;
                }
                field("Gross Total Income"; "Gross Total Income")
                {
                    ToolTip = 'specifies the gross total income of the employee in the TDS deduction list';
                    ApplicationArea = all;
                }
                field("Tax Liability"; "Tax Liability")
                {
                    ToolTip = 'specifies the tax liability of the employee in th eTDS dedcution list';
                    ApplicationArea = all;
                }
                field("Planned Savings"; "Planned Savings")
                {
                    ToolTip = 'Specifies if any planned savings of the employee avilable like NSC certificates, School fees, LIC etc';
                    ApplicationArea = all;
                }
                field("Tax Liability after savings"; "Tax Liability after savings")
                {
                    ToolTip = 'Specifies the tax labilites after the saving of the exployees need to menthion';
                    ApplicationArea = all;
                }
                field("Tax Already Deducted"; "Tax Already Deducted")
                {
                    Editable = false;
                    ToolTip = 'specifies if any tax laerady decuted against the employee';
                    ApplicationArea = all;
                }
                field("Remaining Months"; "Remaining Months")
                {
                    Editable = false;
                    ToolTip = 'Specifies the remaining months in the TDS dedcution list';
                    ApplicationArea = all;
                }
                field("Planned Deduction"; "Planned Deduction")
                {
                    ToolTip = '"Specaifies planned dedcutions decided by the employee "';
                    ApplicationArea = all;
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
                Image = Line;
                action("TDS &Schedule")
                {
                    Caption = 'TDS &Schedule';
                    Image = Calendar;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies  tds schedule';
                    trigger OnAction();
                    begin
                        TDSSchedule.SETRANGE("Employee No.", "Employee No.");
                        TDSSchedule.SETRANGE("Year Starting Date", "Year Starting Date");
                        TDSSchedule.SETRANGE("Year Ending Date", "Year Ending Date");
                        if TDSSchedule.FINDFIRST() then
                            PAGE.RUN(33001256, TDSSchedule)
                        else
                            MESSAGE(Text000Lbl);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Update &Gross Salary")
                {
                    Caption = 'Update &Gross Salary';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Update Gross Salary';
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                    begin
                        TDSCalculations.UpdateTDSRecordsNew(PayrollYearStDate, PayrollYearEndDate);
                    end;
                }
                group("Compute &TDS Schedule")
                {
                    Caption = 'Compute &TDS Schedule';
                    Image = CalendarWorkcenter;
                    action("Current &Employee")
                    {
                        Caption = 'Current &Employee';
                        Image = CalculateRemainingUsage;
                        ToolTip = 'Compute TDS Schedule Current Employee';
                        ApplicationArea = all;

                        trigger OnAction();
                        begin
                            Rec.TESTFIELD("Tax Liability after savings");
                            TDSCalculations.TDSScheduleCalc(Rec);
                        end;
                    }
                    action("&All Employees")
                    {
                        Caption = '&All Employees';
                        Image = CalculateRemainingUsage;
                        ToolTip = 'Compute TDS Schedule All Employee';
                        ApplicationArea = all;

                        trigger OnAction();
                        begin
                            if TDSDeduction.FINDFIRST() then
                                repeat
                                    TDSDeduction.TESTFIELD("Tax Liability after savings");
                                    TDSCalculations.TDSScheduleCalc(TDSDeduction);
                                until TDSDeduction.NEXT() = 0;
                        end;
                    }
                }
                action("Transfer to &History")
                {
                    Caption = 'Transfer to &History';
                    Image = TransferToLines;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Transfer History';
                    trigger OnAction();
                    begin
                        TransferTDSRecords();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        SETRANGE("Year Starting Date", DMY2DATE(1, 1, 2001));
    end;

    var
        TDSDeduction: Record "Emp TDS Deduction B2B";
        TDSSchedule: Record "Emp TDS Schedule B2B";
        PayrollYear: Record "Payroll Year B2B";
        TDSCalculations: Codeunit "TDS Calculations B2B";
        TDSPosting: Codeunit "TDS Posting B2B";
        Text000Lbl: Label 'Compute TDS Schedule';
        Window: Dialog;
        PayrollYearStDate: Date;
        PayrollYearEndDate: Date;
        PayrollYearType: Code[50];
        Text001Lbl: Label 'Records succesfully moved to history';
        Text002Lbl: Label 'Employee No #1##########', Comment = '%1 = No';
        Text003Lbl: Label 'FINANCIAL YEAR';

    procedure TransferTDSRecords();
    var
        EmpTDSDeduction: Record "Emp TDS Deduction B2B";
    begin
        Window.OPEN(Text002Lbl);
        SLEEP(2000);
        EmpTDSDeduction.RESET();
        EmpTDSDeduction.SETFILTER("Tax Liability after savings", '<>%1', 0);
        if EmpTDSDeduction.FINDFIRST() then
            repeat
                Window.UPDATE(1, EmpTDSDeduction."Employee No.");
                TDSPosting.InsertPostedTDS(EmpTDSDeduction);
            until EmpTDSDeduction.NEXT() = 0;
        Window.CLOSE();
        MESSAGE(Text001Lbl);
    end;

    procedure UpdateYear();
    begin
        RESET();
        if PayrollYearStDate <> 0D then begin
            SETRANGE("Year Starting Date", PayrollYearStDate);
            SETRANGE("Year Ending Date", PayrollYearEndDate);
        end;
        CurrPage.UPDATE(false);
    end;
}

