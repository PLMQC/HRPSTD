page 33001190 "HR Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'HR Setup';
    PageType = Card;
    SourceTable = "HR Setup B2B";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Processing Month"; "Processing Month")
                {
                    Caption = 'Salary Processing Month';
                    Editable = "Processing MonthEditable";
                    ToolTip = 'Specifies the which month we are processing the Payroll';
                    ApplicationArea = all;
                }
                field("Salary Processing Year"; "Salary Processing Year")
                {
                    Editable = "Salary Processing YearEditable";
                    ToolTip = 'Specifies the which year we are processing the Payroll';
                    ApplicationArea = all;
                }
                field("Default Attendance Type"; "Default Attendance Type")
                {
                    ToolTip = 'Specified the default attendance can be setup either as "Present" or "Absent".';
                    ApplicationArea = all;
                }
                field("Rounding Type"; "Rounding Type")
                {
                    ToolTip = 'Specifies the size of the interval to be used when rounding amounts in LCY. Amounts will be rounded to the nearest digit.';
                    ApplicationArea = all;
                }
                field("Rounding Precision"; "Rounding Precision")
                {
                    ToolTip = 'Specifies the number of decimal places the program will display (for example, on invoices and in reports) for amounts in LCY. The default setting, 2:2, specifies that amounts in LCY will be shown with two decimal places.';
                    ApplicationArea = all;
                }
                field("Activate Leave Approvals"; "Activate Leave Approvals")
                {
                    ToolTip = 'Specifies whether the Leave Application process needs approval.';
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Activate Res. Indent Approvals"; "Activate Res. Indent Approvals")
                {
                    ToolTip = 'Specifies whether the Resource Indent / Manpower Requisition process needs approval.';
                    ApplicationArea = all;
                }
                field("Attachment Storage Type"; "Attachment Storage Type")
                {
                    ToolTip = 'Specifies the attachment storage location by using the following options. 1. Embedded 2. Disk File';
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Attmt. Storage Location"; "Attmt. Storage Location")
                {
                    ToolTip = 'Specify the attendance (Attendance Machine Attendance) Storing location to upload into Attendance management in HRMS.';
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Attendance Storage Location"; "Attendance Storage Location")
                {
                    ToolTip = 'Specify the Attendance Storing Location, once the attendance is uploaded in Attendance management in HRMS.';
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Archive Att. Storage Location"; "Archive Att. Storage Location")
                {
                    ToolTip = 'Specify the Archive (Modification / Change) of  attendance (Attendance Machine Attendance) Storing location to upload into Attendance management in HRMS.';
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Database; Database)
                {
                    ToolTip = 'Specifies the applicability of Indian version of payroll / worldwide.';
                    ApplicationArea = all;
                }
                field("Notice Period"; "Notice Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Notice Period towards Resignation Process';
                }
                field("Compensatory Leave Code"; "Compensatory Leave Code")
                {

                    Caption = ' Compensatory Leave Code';
                    ApplicationArea = All;
                    ToolTip = 'Define the Compensatory Leave Code as Created in Leave master';


                }
            }

            group(Posting)
            {
                Caption = 'Posting';
                Visible = false;
                field("Employer PF"; "Employer PF")
                {
                    Caption = 'Employer PF';
                    ApplicationArea = all;
                    ToolTip = 'Specify the General Ledger Account defined in COA and map the same tp Employer PF Account';

                }
                field("Employer EPS"; "Employer EPS")
                {
                    Caption = 'Employer EPS';
                    ApplicationArea = all;
                    ToolTip = 'Specify the General Ledger Account defined in COA and map the same to Employer EPS ';
                }
                field("PF Admin. Charges"; "PF Admin. Charges")
                {
                    Caption = 'PF Admin. Charges';
                    ApplicationArea = all;
                    ToolTip = 'Specify the General Ledger Account defined in COA and map the same to PF admin.Charges ';
                }
                field("EDLI Charges"; "EDLI Charges")
                {
                    Caption = 'EDLI Charges';
                    ApplicationArea = all;
                    ToolTip = 'Specify the General Ledger Account defined in COA and map the same to EDLI Charges ';
                }
                field("Employer ESI"; "Employer ESI")
                {
                    Caption = 'Employer ESI';
                    ApplicationArea = all;
                    ToolTip = 'Specify the General Ledger Account defined in COA and map the same to Employer ESI ';
                }
                field("RIFA Charges"; "RIFA Charges")
                {
                    Caption = 'RIFA Charges';
                    ApplicationArea = all;
                    ToolTip = 'Specify the General Ledger Account defined in COA and map the same to RIFA Charges';
                }
                field("Cash Account"; "Cash Account")
                {
                    Caption = 'Cash Account';
                    ApplicationArea = all;
                    ToolTip = 'Specify the General Ledger Account defined in COA and map the same to Cash Account';
                }
                field("Bank Account"; "Bank Account")
                {
                    Caption = 'Bank Account';
                    ApplicationArea = all;
                    ToolTip = 'Specify the General Ledger Account defined in COA and map the same to Bank Account';
                }
            }


            group(Numbering)
            {
                Caption = 'Numbering';
                field("Employee Nos."; "Employee Nos.")
                {
                    ToolTip = 'Specifies the number of the Employee. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Resume DB Nos."; "Resume DB Nos.")
                {
                    ToolTip = 'Specifies the number of the Resume Database. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Recruitment Nos."; "Recruitment Nos.")
                {
                    ToolTip = 'Specifies the number of the Recruitment. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Loan Nos."; "Loan Nos.")
                {
                    ToolTip = 'Specifies the number of the Loan. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Training Nos."; "Training Nos.")
                {
                    ToolTip = 'Specifies the number of the Training . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Leave Application Nos."; "Leave Application Nos.")
                {
                    ToolTip = 'Specifies the number of the Leave Application . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Pay Revision Nos."; "Pay Revision Nos.")
                {
                    ToolTip = 'Specifies the number of the Pay Revision . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Appraisal Nos."; "Appraisal Nos.")
                {
                    ToolTip = 'Specifies the number of the Appraisal . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Shift Nos."; "Shift Nos.")
                {
                    ToolTip = 'Specifies the number of the Shift . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Over Time Nos."; "Over Time Nos.")
                {
                    ToolTip = 'Specifies the number of the Overtime . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("On Duty Nos."; "On Duty Nos.")
                {
                    ToolTip = 'Specifies the number of the On Duty . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Tour intimation Nos."; "Tour intimation Nos.")
                {
                    ToolTip = 'Specifies the number of the Tour Intimation . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Permission Nos."; "Permission Nos.")
                {
                    ToolTip = 'Specifies the number of the Permission . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("LOP Adj. Nos."; "LOP Adj. Nos.")
                {
                    ToolTip = 'Specifies the number of the LOP Adjustment. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Comp Off Nos."; "Comp Off Nos.")
                {
                    ToolTip = 'Specifies the number of the Comp.Off . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Training Need Identi.Nos."; "Training Need Identi.Nos.")
                {
                    ToolTip = 'Specifies the number of the Training Need Indent . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Ind. Training Nos."; "Ind. Training Nos.")
                {
                    ToolTip = 'Specifies the number of the Induction Training . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Confirmation Nos."; "Confirmation Nos.")
                {
                    ToolTip = 'Specifies the number of the Confirmation . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Seperation Nos."; "Seperation Nos.")
                {
                    ToolTip = 'Specifies the number of the Seperation . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Training Schedule Nos."; "Training Schedule Nos.")
                {
                    ToolTip = 'Specifies the number of the Training Schedule . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Prob Id"; "Prob Id")
                {
                    ToolTip = 'Specifies the number of the Probation . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Job Description Nos."; "Job Description Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the number of the Job Description No. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
                field("TrainingPlan Nos."; "TrainingPlan Nos.")
                {
                    ToolTip = 'Specifies the number of the Training Plan . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Travel Requisition Nos."; "Travel Requisition Nos.")
                {
                    ToolTip = 'Specifies the number of the Travel Requisition . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Travel Expenses Nos."; "Travel Expenses Nos.")
                {
                    ToolTip = 'Specifies the number of the Travel Expenses . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field("Resource Nos."; "Resource Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Resource number. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';

                }
                field("Leave Encashment Nos."; "Leave Encashment Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the leave encashment No.';
                }

            }
            group(Gratuity)
            {
                Caption = 'Gratuity';
                field("Min. No.of Years"; "Min. No.of Years")
                {
                    ToolTip = '"Specify the Minimum number of continuous years of service for Gratuity computation in Min. No. of Years field. "';
                    ApplicationArea = all;
                }
                field("No.of Days Salary"; "No.of Days Salary")
                {
                    ToolTip = 'specify the No. of days in a month for considered for computation of Gratuity';
                    ApplicationArea = all;
                }
                field("No.of Days in Month"; "No.of Days in Month")
                {
                    ToolTip = 'Specify No. of Days Salary in a month to be considered for computation of Gratuity.';
                    ApplicationArea = all;
                }
            }
            group("VDA FDA")
            {
                Caption = 'VDA FDA';
                field("Linking Factor1"; "Linking Factor1")
                {
                    ToolTip = 'Specifies the Linking Factor Condition 1 for VDA and FDA Calculation';
                    ApplicationArea = all;
                }
                field("Linking Factor2"; "Linking Factor2")
                {
                    ToolTip = 'Specifies the Linking Factor Condition 2 for VDA and FDA Calculation';
                    ApplicationArea = all;
                }
                field("Neutralisation Points"; "Neutralisation Points")
                {
                    ToolTip = 'Specifies the Neutralisation points criteria for VDA and FDA Calculation';
                    ApplicationArea = all;
                }
                field("VDA Rate"; "VDA Rate")
                {
                    ToolTip = 'Specifies the VDA (Variable Dearness Allowance) rate applicable.';
                    ApplicationArea = all;
                }
                field("FDA Amount"; "FDA Amount")
                {
                    ToolTip = 'Specifies the VDA (Foode Dearness Allowance) amount applicable.';
                    ApplicationArea = all;
                }
            }
            group(Allowance)
            {
                Caption = 'Allowance';
                field("Paid Days Per Month"; "Paid Days Per Month")
                {
                    ToolTip = 'Specifies the paid days per month for calculating Salary, i.e., As per Calendar days or as per fixed.';
                    ApplicationArea = all;
                }
                field(Surcharge; Surcharge)
                {
                    ToolTip = 'Specifies the Surcharge percentage applicable for computing Income tax under Salaries.';
                    ApplicationArea = all;
                }
                field("Educational Cess"; "Educational Cess")
                {
                    ToolTip = 'Specifies the Educaction cess applicable for computing Income tax under Salaries.';
                    ApplicationArea = all;
                }
                field("Employer National Pension %"; "Employer National Pension %")
                {
                    ToolTip = 'Specifies the Employer National Pension scheme percentage applicable.';
                    ApplicationArea = all;
                }
                //TDSOP2 >>
                field("Opt 2 Educational Cess"; "Opt 2 Educational Cess")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Educaction cess applicable for computing Income tax under Salaries.';
                }
                //TDSOP2 <<
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
                action("&Lock Processing Period")
                {
                    Caption = '&Lock Processing Period';
                    Image = Lock;
                    ApplicationArea = all;
                    ToolTip = 'Specify Payroll Processing Period';

                    trigger OnAction();
                    begin
                        TESTFIELD("Salary Processing Year");
                        Locked := true;
                        MODIFY();
                        "Processing MonthEditable" := false;
                        "Salary Processing YearEditable" := false;
                    end;
                }
                action("&Unlock Processing Period")
                {
                    Caption = '&Unlock Processing Period';
                    Image = Lock;
                    ApplicationArea = all;
                    ToolTip = 'Unlock the Payroll Processing Period';

                    trigger OnAction();
                    begin
                        Locked := false;
                        MODIFY();
                        "Processing MonthEditable" := true;
                        "Salary Processing YearEditable" := true;
                    end;
                }
                action("Insert &TDS Masters")
                {
                    Caption = 'Insert &TDS Masters';
                    Image = TaxSetup;
                    ApplicationArea = all;
                    ToolTip = 'Automatically Inserts the TDS Master';

                    trigger OnAction();
                    begin
                        TDSSetups();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if Locked then begin
            "Processing MonthEditable" := false;
            "Salary Processing YearEditable" := false;
        end;
    end;

    trigger OnInit();
    begin
        "Salary Processing YearEditable" := true;
        "Processing MonthEditable" := true;
    end;

    trigger OnOpenPage();
    begin
        if Locked then begin
            "Processing MonthEditable" := false;
            "Salary Processing YearEditable" := false;
        end;
    end;

    var
        [InDataSet]
        "Processing MonthEditable": Boolean;
        [InDataSet]
        "Salary Processing YearEditable": Boolean;
}

