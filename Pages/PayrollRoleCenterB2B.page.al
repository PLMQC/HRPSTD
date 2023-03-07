page 33001581 "Payroll Role Center B2B"
{
    // version B2BHR1.0

    Caption = 'HR & Payroll Role Center';
    PageType = RoleCenter;
    PromotedActionCategories = 'New,Creation,Reports,Payment Journals';


    layout
    {
        area(rolecenter)
        {
            group(Role)
            {
                part(Activities; 33001533)
                {
                    Caption = 'Activities';
                    ApplicationArea = all;
                }

            }
            group(General)
            {
                part(Employees; 33001535)
                {
                    Caption = 'Employees';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
        }
        area(embedding)
        {

            action("Loan List")
            {
                Caption = 'Loan List';
                RunObject = Page 33001246;
                ApplicationArea = all;
                ToolTip = 'Open The loan';
            }



            action("Emp List")
            {
                Caption = 'Emp List';
                RunObject = Page 33001195;
                ApplicationArea = all;
                ToolTip = 'Open The Employee';
            }
            action("Leave List")
            {
                Caption = 'Leave List';
                RunObject = Page 33001234;
                ApplicationArea = all;
                ToolTip = 'Open The leave';
            }

            action(Recruitments)
            {
                Caption = 'Recruitments';
                RunObject = Page 33001203;
                ApplicationArea = all;
                ToolTip = 'Open The recruitment';
            }
            action("Emp Seperations")
            {
                Caption = 'Emp Seperations';
                RunObject = Page 33001463;
                ApplicationArea = all;
                ToolTip = 'Open The emp separation';
            }

            action("Comp Offs")
            {
                Caption = 'Comp Offs';
                RunObject = Page 33001539;
                ApplicationArea = all;
                ToolTip = 'Open The comp off';
            }
            action("LOP Adjustment Lists")
            {
                Caption = 'LOP Adjustments';
                RunObject = Page 33001540;
                ApplicationArea = all;
                ToolTip = 'Open The lop adjustment';
            }

            action("Tour Intimations")
            {
                Caption = 'Tour Intimations';
                RunObject = Page 33001538;
                ApplicationArea = all;
                ToolTip = 'Open The Tour intimation';
            }
            action("Extend Probation")
            {
                Caption = 'Extend Probation';
                RunObject = Page 33001340;
                ApplicationArea = all;
                ToolTip = 'Open The Extended Probation';
            }
            action("Employee Promotion")
            {
                Caption = 'Employee Promotion';
                RunObject = Page 33001490;
                ApplicationArea = all;
                ToolTip = 'Open The employee promotions';
            }
            action("Employee Confirmation")
            {
                Caption = 'Employee Confirmation';
                RunObject = Page 33001212;
                ApplicationArea = all;
                ToolTip = 'Open The employee confirmation';
            }
            action("Permission Applications")
            {
                Caption = 'Permission Applications';
                RunObject = Page 33001541;
                ApplicationArea = all;
                ToolTip = 'Open The permission application';
            }
            action("Shift Schedules")
            {
                Caption = 'Shift Schedules';
                RunObject = Page "Shift Rotation B2B";
                ToolTip = 'Open The shift rotation';
                ApplicationArea = all;
            }

            action(Loans_B2B)
            {
                Caption = 'Loans';
                RunObject = Page 33001246;
                ApplicationArea = all;
                ToolTip = 'Open The loan';
            }
            action("Loan Repayments")
            {
                Caption = 'Loan Repayments';
                RunObject = Page 33001281;
                ApplicationArea = all;
                ToolTip = 'Open The loan repayment';
            }

            action("Final Settlements")
            {
                Caption = 'Final Settlements';
                RunObject = Page 33001502;
                ApplicationArea = all;
                ToolTip = 'Open The final settlement';
            }
            action("Posted Final Settlements")
            {
                Caption = 'Posted Final Settlements';
                RunObject = Page 33001406;
                ApplicationArea = all;
                ToolTip = 'Posted final settlement';
            }

        }
        area(creation)
        {
            action("Create &Emp.")
            {
                Caption = 'Create &Emp.';
                Image = NewCustomer;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 33001194;
                RunPageMode = Create;
                ApplicationArea = all;
                ToolTip = 'Create Employee';
            }
            action("Create &Resume")
            {
                Caption = 'Create &Resume';
                Image = NewOpportunity;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 33001199;
                RunPageMode = Create;
                ApplicationArea = all;
                ToolTip = 'Open The create resume';
            }
            action("Create &Loan")
            {
                Caption = 'Create &Loan';
                Image = NewSparkle;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 33001245;
                RunPageMode = Create;
                ApplicationArea = all;
                ToolTip = 'Open The create loan';
            }
            action("Apply Leave")
            {
                Caption = 'Apply Leave';
                Image = Absence;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 33001378;
                RunPageMode = Create;
                ApplicationArea = all;
                ToolTip = 'Open The apply leave';
            }

            action("Resource Planning")
            {
                RunObject = page "Resource Planning List B2B";
                ApplicationArea = all;
                ToolTip = 'Open The resource planning';
            }


        }
        area(processing)
        {
            group("Recruitment ")
            {
                Caption = 'Recruitment';
                group(Tasks)
                {
                    Caption = 'Tasks';
                    Image = Task;
                    action("Man Power Requisition  List")
                    {
                        Caption = 'Man Power Requisition  List';
                        Image = ServiceMan;
                        RunObject = page "Man Power Requis. List B2B";
                        ApplicationArea = all;
                        ToolTip = 'Open The man power requistion list';
                    }
                    action("Resource Indent Approval")
                    {
                        Caption = 'Resource Indent Approval';
                        Image = Resource;
                        RunObject = page "Resource Indent Approval B2B";
                        ApplicationArea = all;
                        ToolTip = 'Open The resource indent approval';
                    }
                    action("Interview History")
                    {
                        Caption = 'Interview History';
                        Image = History;
                        RunObject = page "Interview History B2B";
                        ApplicationArea = all;
                        ToolTip = 'Open The Interview history';
                    }
                }
                group(Documents)
                {
                    Caption = 'Documents';
                    Image = Documents;
                    action("Resume Database List")
                    {
                        Caption = 'Resume Database List';
                        Image = List;
                        RunObject = page "Resume Database List B2B";
                        ApplicationArea = all;
                        ToolTip = 'Open The Resume database list';
                    }
                    action("Recruitment  ")
                    {
                        Caption = 'Recruitment List';
                        Image = List;
                        RunObject = page "Recruitment Header List B2B";
                        ApplicationArea = all;
                        ToolTip = 'Open The recruitment';
                    }
                    action("Closed Recruitment Headers")
                    {
                        Caption = 'Closed Recruitment Headers';
                        Image = CloseDocument;
                        RunObject = page "Closed Recruitment Headers B2B";
                        ApplicationArea = all;
                        ToolTip = 'Open The closed recruitment list';
                    }
                }
            }
            group(Training)
            {
                Caption = 'Training';
                group(Lists)
                {
                    Caption = 'Lists';
                    Image = List;
                    action("Training Schedule List")
                    {
                        Caption = 'Training Schedule List';
                        Image = List;
                        RunObject = page "Training Schedule List B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Training Schedule';
                    }
                }
                group("Training Tasks")
                {
                    Caption = 'Tasks';
                    Image = Task;
                    action("Employee Training Need List")
                    {
                        Caption = 'Employee Training Need List';
                        Image = Task;
                        RunObject = page "Employee Training Needs B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Training Need list';

                    }
                    action("Training List")
                    {
                        Caption = 'Training List';
                        Image = List;
                        RunObject = page "Training List B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens List';
                    }
                    action("Training Dash Board")
                    {
                        Caption = 'Training Dash Board';
                        Image = Card;
                        RunObject = page "Training Dash Board B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Training Dashboard';
                    }
                    action("Posted Training List")
                    {
                        Caption = 'Posted Training List';
                        Image = Card;
                        RunObject = page "Posted Training List B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Posted Training';
                    }
                }
                group("Training Documents")
                {
                    Caption = 'Documents';
                    Image = Documents;
                    action("Training Feedback Form")
                    {
                        Caption = 'Training Feedback Form';
                        Image = Document;
                        RunObject = page "Training Feedback Form B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Training Feedback';
                    }
                }
            }
            group("Job Description")
            {
                Caption = 'Job Description';
                group("Job Description Lists")
                {
                    Image = List;
                    action("Job Description List")
                    {
                        Caption = 'Job Description List';
                        Image = List;
                        RunObject = page "Job Description List B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Job Description List';
                    }
                }
            }
            group(Appraisal)
            {
                Caption = 'Appraisal';
                group("Appraisal Documents")
                {
                    Caption = 'Documents';
                    Image = Documents;
                    action("Employee Performance List")
                    {
                        Caption = 'Employee Performance List';
                        Image = List;
                        RunObject = page "Employee Performance List B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Employee Performance List';
                    }
                    action("Performance Apprisal Document")
                    {
                        Caption = 'Performance Apprisal Document';
                        RunObject = Report 33001362;
                        ApplicationArea = all;
                        Image = CalculateCrossDock;
                        ToolTip = 'Opens Performance Appraisal document';
                    }
                }
            }
            group("Over Time")
            {
                Caption = 'Over Time';
                group("Task")
                {
                    Caption = 'Tasks';
                    Image = Task;
                    action("Employee OT Approval")
                    {
                        Caption = 'Employee OT Approval';
                        Image = Card;
                        RunObject = page "Employee OT Approval B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Employee OT Approval';
                    }
                    action("OT Approval Date Wise old")
                    {
                        Caption = 'OT Approval Day Wise';
                        Image = Card;
                        RunObject = page "OT Approval Date Wise old B2B";
                        ApplicationArea = all;
                        ToolTip = 'Ot Approval';
                    }
                }
            }
            group("Salary Processing")
            {
                Caption = 'Salary Processing';
                group("Document")
                {
                    Caption = 'Documents';
                    Image = Documents;
                    action("Processed Salary")
                    {
                        Caption = 'Processed Salary';
                        Image = Worksheet;
                        RunObject = page "Processed Salary B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Processed salary';
                    }
                }
                group("Salary Process Task")
                {
                    Caption = 'Tasks';
                    Image = Task;
                    action("Pay Revision Document")
                    {
                        Caption = 'Pay Revision Document';
                        Image = List;
                        RunObject = page "Pay Revision Header List B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Pay revision';
                    }
                    action("Posted Pay Rev Document")
                    {
                        Caption = 'Posted Pay Rev Document';
                        Image = List;
                        RunObject = page "Posted Pay Rev. Headers B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Posted pay revision document';

                    }
                    action("Other PayElements")
                    {
                        Caption = 'Other PayElements';
                        Image = Document;
                        RunObject = page "Other PayElements B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Other Pay elements';
                    }
                    action("LOP Adjustments")
                    {
                        Caption = 'LOP Adjustments';
                        RunObject = Page 33001298;
                        ApplicationArea = all;
                        Image = AdjustEntries;
                        ToolTip = 'Opens Lop adjustment';
                    }
                }
                group("Salary Process History")
                {
                    Caption = 'History';
                    Image = History;
                    action("Posted Other PayElements")
                    {
                        Caption = 'Posted Other PayElements';
                        Image = Document;
                        RunObject = page "Posted Other PayElements B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Posted Other Pay elements';
                    }
                }
            }
            group("TDS ")
            {
                Caption = 'TDS';
                group("Archieve TDS History")
                {
                    Caption = 'History';
                    Image = History;
                    action("Archived TDS Deductions")
                    {
                        Caption = 'Archived TDS Deductions';
                        Image = Worksheet;
                        RunObject = page "Archived TDS Deductions B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Archived TDS Deductions';
                    }
                }
                group("Archieve TDS Documents")
                {
                    Caption = 'Documents';
                    Image = Documents;
                    action("TDS Deductions")
                    {
                        Caption = 'TDS Deductions';
                        Image = Card;
                        RunObject = page "TDS Deductions B2B";
                        ApplicationArea = all;
                        ToolTip = 'TDS Deduction';
                    }
                    action("TDS Register")
                    {
                        Caption = 'TDS Register';
                        Image = Card;
                        RunObject = page "TDS Register B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens TDS Register';
                    }
                }
                group(Archive)
                {
                    Caption = 'Archive';
                    Image = Archive;
                    action("EMP TDS Monthly Schedule")
                    {
                        Caption = 'EMP TDS Monthly Schedule';
                        Image = List;
                        RunObject = page "EMP TDS Monthly Schedule B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens EMP TDS Monthly schedule';
                    }
                }
            }
            group(Leaves)
            {
                Caption = 'Leaves';
                group("Leave Documents")
                {
                    Caption = 'Documents';
                    Image = Documents;
                    action("Leave Opening Balance")
                    {
                        Caption = 'Leave Opening Journal';
                        Image = List;
                        RunObject = page "Leave Opening Balance B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Leave Opening Journal';
                    }
                    action("Leave Approvals")
                    {
                        Caption = 'Leave Approvals';
                        Image = List;
                        RunObject = page "Leave Approvals All B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Leave Approval';
                    }
                    action("Leave Approval Setup")
                    {
                        Caption = 'Leave Approval Setup';
                        Image = List;
                        RunObject = page "Leave Approval Setup B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Leave Aproval setup';
                    }
                    action("Leave Cancellation")
                    {
                        RunObject = page "Leave Cancellation Request B2B";
                        ApplicationArea = all;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Opens Leave Cancellation';
                    }
                }
                group("Leave Application")
                {
                    Caption = 'Leave Application';
                    Image = List;
                    action("Leave Application List")
                    {
                        Caption = 'Leave Application List';
                        Image = List;
                        RunObject = page 33001379;
                        ApplicationArea = all;
                        ToolTip = 'Leave Application list';

                    }
                    action("Leave Applicability")
                    {
                        Caption = 'Leave Applicability';
                        Image = List;
                        RunObject = page 33001399;
                        ApplicationArea = all;
                        ToolTip = 'Opens Leave Applicability';
                    }

                }
                group("Leaves History")
                {
                    Caption = 'History';
                    Image = History;
                    action("Posted Leaves")
                    {
                        Caption = 'Posted Leaves';
                        Image = Document;
                        RunObject = page "Posted Leaves B2B";
                        ApplicationArea = all;
                        ToolTip = 'Opens Posted Leaves';
                    }
                }
            }
            group(Journals_B2B)
            {
                Caption = 'Journals';
                separator(Journals)
                {
                    Caption = 'Journals';
                    IsHeader = true;
                }
                action("Leave Journal")
                {
                    Caption = 'Leave Journal';
                    Image = CapacityJournal;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 33001374;
                    ApplicationArea = all;
                    ToolTip = 'Opens leave journal';
                }
                action("TDS Payment Journaly")
                {
                    Caption = 'TDS Payment Journaly';
                    Image = SocialSecurityTax;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 33001448;
                    ApplicationArea = all;
                    ToolTip = 'Opens TDS Payment journal';
                }
                action("Leave Encashment Pay Journal")
                {
                    Caption = 'Leave Encashment Pay Journal';
                    Image = CashReceiptJournal;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 33001525;
                    ApplicationArea = all;
                    ToolTip = 'Opens the Leave encashment pay journal';


                }
                action("Pay Salary")
                {
                    Caption = 'Pay Salary';
                    Image = VendorPaymentJournal;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 33001277;
                    ApplicationArea = all;
                    ToolTip = 'Opens the Pay salary';

                }
                action("Pay Arrear Salary")
                {
                    Caption = 'Pay Arrear Salary';
                    Image = AmountByPeriod;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 33001526;
                    ApplicationArea = all;
                    ToolTip = 'Opens the Pay arrear Salary';
                }
                action("Final Settlement Payable")
                {
                    Caption = 'Final Settlement Payable';
                    Image = SettleOpenTransactions;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 33001501;
                    ApplicationArea = all;
                    ToolTip = 'Opens the Final settlement Payable';
                }
                action("Other Pay Elements")
                {
                    Caption = 'Other Pay Elements';
                    RunObject = Page 33001242;
                    ApplicationArea = all;
                    Image = Payables;
                    ToolTip = 'Open Other pay elements';
                }
                action("Pay Revision Journal")
                {
                    Image = JobJournal;
                    Caption = 'Pay Revision Journal';
                    RunObject = Page "PayRevision Payment Jou B2B";
                    ApplicationArea = all;
                    ToolTip = 'Opens the Pay revision journal';
                }

            }
            group(Attendance_B2B)
            {
                Caption = 'Attendance';
                action("Daily Attendance")
                {
                    Image = DateRange;
                    RunObject = Page 33001229;
                    ApplicationArea = all;
                    ToolTip = 'Opens the Daily Attendance';
                }
                action("Monthly Attendance")
                {
                    Image = Accounts;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 33001231;
                    ApplicationArea = all;
                    ToolTip = 'Opens the Monthly attendance';
                }
                action("Update Daily Punches")
                {
                    Image = Timeline;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 33001578;
                    ApplicationArea = all;
                    ToolTip = 'Opens the Update Daily punches';
                }
                action("Shift Rotation")
                {
                    Image = ChangeBatch;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "Shift Rotation B2B";
                    ApplicationArea = all;
                    ToolTip = 'Opens the Shift roatation';
                }
            }
            group("LOP")
            {
                action("Lop Adjustment")
                {
                    ApplicationArea = All;
                    RunObject = page "LOP Adjustment B2B";
                    Image = AdjustEntries;
                    ToolTip = 'Opens the Lop adjustment';
                }
                action("Lop Adjustment-Deductions")
                {
                    ApplicationArea = All;
                    RunObject = page "LOP Adjustment - Deduction B2B";
                    Image = DecreaseIndent;
                    ToolTip = 'Opens the Lop Adjustment-Deductions';

                }
                action("Lop Adjustment List")
                {
                    ApplicationArea = All;
                    RunObject = page "LOP Adjustment Entries B2B";
                    Image = List;
                    ToolTip = 'Opens the Lop Adjustment';
                }
            }
            group("Statuatory Reports")
            {
                group("Employee")
                {
                    Caption = 'Employee';
                    action("Emp Address")
                    {
                        Caption = 'Emp Address';
                        Image = "Report";
                        RunObject = Report 33001196;
                        ApplicationArea = all;
                        ToolTip = 'Prints the Emp Address';
                    }
                    action("Emp Credentials")
                    {
                        Caption = 'Emp Credentials';
                        Image = Report;
                        RunObject = Report 33001197;
                        ApplicationArea = all;
                        ToolTip = 'Prints the Emp Credentials';
                    }
                    action("Emp Complete Info.")
                    {
                        Caption = 'Emp Complete Info.';
                        RunObject = Report 33001287;
                        ApplicationArea = all;
                        Image = Report;
                        ToolTip = 'Prints the Emp complete info';
                    }
                    action("Emp Pay Elements")
                    {
                        Caption = 'Emp Pay Elements';
                        Image = Report;
                        RunObject = Report 33001198;
                        ApplicationArea = all;
                        ToolTip = 'Prints theEmp pay elements';
                    }


                    action("Pay Cadre-Pay Elements")
                    {
                        Caption = 'Pay Cadre-Pay Elements';
                        RunObject = Report 33001203;
                        ApplicationArea = all;
                        Image = Report;
                        ToolTip = 'Prints the Pay cadre pay elements';
                    }

                    action("Month wise Pay Element")
                    {
                        Caption = 'Month wise Pay Element';
                        RunObject = Report 33001202;
                        ApplicationArea = all;
                        Image = Report;
                        ToolTip = 'Prints the Month wise pay elements';
                    }
                    action("Monthly Salary Summary")
                    {
                        Caption = 'Monthly Salary Summary';
                        RunObject = Report 33001227;
                        ApplicationArea = all;
                        Image = Report;
                        ToolTip = 'Prints the Monthly salary summary';
                    }
                }
                group(ESI)
                {
                    Caption = 'ESI';
                    action("Form-6")
                    {
                        Caption = 'ESI Form-6';
                        RunObject = Report 33001211;
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Prints the ESI Form-6';
                    }
                    action("Form-7")
                    {
                        Caption = 'ESI Form7';
                        RunObject = Report "ESI Form7 B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Prints the ESI Form 7';
                    }
                    action("Form-6A")
                    {
                        Caption = 'ESI Form 6A';
                        RunObject = Report "ESI Form 6A B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Prints the Form-6A';
                    }
                }
                group(PF)
                {
                    Caption = 'PF';
                    action("PF FORM 3-A ")
                    {
                        RunObject = Report "PF FORM 3-A B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Prints the PF';
                    }
                    action("PF-Annual Return Form 6A-I ")
                    {
                        RunObject = Report "PF-Annual Return Form 6A-I B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Prints the PF Annnual Return Form 6A-I';
                    }
                    action("PF Form No.10 ")
                    {
                        RunObject = report "PF Form No.10 B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Prints the PF Form No. 10';
                    }
                    action("PF Form No.5")
                    {
                        RunObject = Report "PF Form No.5 B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Prints the PF Form No.5';
                    }
                }

                group("Professional Tax & Gratuity")
                {
                    Caption = 'Professional Tax & Gratuity';
                    action("Professional Tax FORM 5")
                    {
                        RunObject = Report "Professional Tax FORM 5 B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Prints the Professional Tax FORM 5';
                    }
                    action("Gratuity Provision")
                    {
                        RunObject = Report "Gratuity Provision B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Prints the Gratuity Provision';
                    }
                }
            }
            group(Setup)
            {
                action("HR Setup ")
                {
                    Caption = 'HR Setup';
                    RunObject = Page 33001190;
                    ApplicationArea = all;
                    Image = Setup;
                    ToolTip = 'Open the HR setup';
                }
                action(Lookups)
                {
                    RunObject = Page 33001192;
                    ApplicationArea = all;
                    Image = Setup;
                    ToolTip = 'Open the Lookup';
                }
                action("Payroll Journal Template")
                {
                    RunObject = Page 33001272;
                    ApplicationArea = all;
                    Image = Setup;
                    ToolTip = 'Open the Payroll Journal template';
                }
                action("Salary Adj. Setup ")
                {
                    Caption = 'Salary Adj. Setup';
                    RunObject = Page 33001366;
                    Image = Setup;
                    ApplicationArea = all;
                    ToolTip = 'Open the Salary Adj. Setup';
                }

                action("Holidays ")
                {
                    RunObject = Page 33001220;
                    ApplicationArea = all;
                    Image = Holiday;
                    ToolTip = 'Open the Holiday';
                }
                action("Off days ")
                {
                    RunObject = Page 33001221;
                    ApplicationArea = all;
                    Image = Holiday;
                    ToolTip = 'Open the Off Day';
                }
                action("Shift List")
                {
                    RunObject = Page 33001223;
                    ApplicationArea = all;
                    Image = BreakRulesOff;
                    ToolTip = 'Open the Shift List';
                }
                action("Resource Indent Approval Setup ")
                {
                    Caption = 'Resource Ind. App Setup';
                    RunObject = Page 33001307;
                    ApplicationArea = all;
                    ToolTip = 'Open the REsurce indent approval setup';
                    Image = Indent;
                }
                action("Tour Inti. Setup ")
                {
                    Caption = 'Tour Inti. Setup';
                    RunObject = Page 33001532;
                    ApplicationArea = all;
                    Image = Turnover;
                    ToolTip = 'Open the Tour Inti. Setup';
                }
                action("PT List ")
                {
                    Caption = 'PT List';
                    RunObject = Page 33001255;
                    ApplicationArea = all;
                    Image = ChangeDates;
                    ToolTip = 'Open the PT List';
                }
                action("PF List ")
                {
                    RunObject = Page 33001250;
                    ApplicationArea = all;
                    Image = PaymentForecast;
                    ToolTip = 'Open the PF List';
                }
                action("ESI List ")
                {
                    RunObject = Page 33001252;
                    ApplicationArea = all;
                    Image = PaymentForecast;
                    ToolTip = 'Open the ESI List';
                }
                action("Bonus List ")
                {
                    RunObject = Page 33001264;
                    ApplicationArea = all;
                    Image = PaymentForecast;
                    ToolTip = 'Open the Bonus list';
                }
                action("Questionnaire Profile Setup")
                {
                    Caption = 'Questionnaire Profile Setup';
                    RunObject = Page 33001456;
                    ApplicationArea = all;
                    ToolTip = 'Open the Questionnaire profile setup';
                    Image = QuestionaireSetup;
                }
                action(Questionnaires)
                {
                    Caption = 'Questionnaires';
                    RunObject = Page 33001457;
                    ApplicationArea = all;
                    Image = Questionaire;
                    ToolTip = 'Open the Questionnaires';
                }
                group("Posting Group")
                {

                    action("Payroll Bus Post Group ")
                    {
                        Caption = 'Payroll Bus. Pos. Group';
                        RunObject = Page 33001267;
                        ApplicationArea = all;
                        Image = Administration;
                        ToolTip = 'Open the Payroll Bus. Posting group';
                    }
                    action("Payroll Prod Post Group ")
                    {
                        Caption = 'Payroll Prod. Pos. Group';
                        RunObject = Page 33001268;
                        ApplicationArea = all;
                        Image = Administration;
                        ToolTip = 'Open the Payroll prod. posting group';
                    }
                    action("Payroll Gen Post Group ")
                    {
                        Caption = 'Payroll Gen. Pos. Group';
                        RunObject = Page 33001269;
                        ApplicationArea = all;
                        Image = Administration;
                        ToolTip = 'Open the Payroll General posting group';
                    }
                    action("Employee Post. Group ")
                    {
                        Caption = 'Emp Pos. Group';
                        RunObject = Page 33001270;
                        ApplicationArea = all;
                        Image = Administration;
                        ToolTip = 'Open the Employee posting group';
                    }
                    action("Employer Stat. Post. Group")
                    {
                        Caption = 'Employer Stat. Post. Group';
                        RunObject = Page 33001531;
                        ApplicationArea = all;
                        Image = Administration;
                        ToolTip = 'Open the Employer Stat. Posting group';
                    }
                    action("Loan Posting Setup ")
                    {
                        Caption = 'Loan Posting Setup';
                        RunObject = Page 33001271;
                        ApplicationArea = all;
                        Image = Administration;
                        ToolTip = 'Open the Loan posting group';
                    }
                    action("Bonus Adjust")
                    {
                        Caption = 'Bonus Adjust';
                        RunObject = Report 33001220;
                        ApplicationArea = all;
                        Image = Administration;
                        ToolTip = 'Open the Bonus Adjust';
                    }

                }
                group(TDS)
                {

                    Caption = 'TDS';
                    action("Income Tax Chapters ")
                    {
                        Caption = 'IT Chapters';
                        RunObject = Page 33001351;
                        ApplicationArea = all;
                        Image = PaymentPeriod;
                        ToolTip = 'Open the IT Chhapters';
                    }
                    action("Excemption Sections ")
                    {
                        Caption = 'Excemption Sections';
                        RunObject = Page 33001352;
                        ApplicationArea = all;
                        Image = PaymentPeriod;
                        ToolTip = 'Open the Excemption sections';
                    }
                    action("Exemption/Deduction Groups")
                    {
                        Caption = 'Exemption/Deduction Groups';
                        RunObject = Page 33001353;
                        ApplicationArea = all;
                        Image = PaymentPeriod;
                        ToolTip = 'Open the Exxcemption/Deduction groups';
                    }
                    action("Surcharge")
                    {
                        Caption = 'Surcharge';
                        RunObject = page "Surcharge Tax List B2B";
                        ApplicationArea = all;
                        Image = AssessFinanceCharges;
                        ToolTip = 'Open the Surcharge';
                    }
                    action("Exemption/Deduction Limits ")
                    {
                        Caption = 'Exemption/Deduction Limits';
                        RunObject = Page 33001356;
                        ApplicationArea = all;
                        Image = PaymentPeriod;
                        ToolTip = 'Open the Excemption/Deduction limits';
                    }
                    action("IT Slab ")
                    {
                        Caption = 'IT Slab';
                        RunObject = Page 33001431;
                        ApplicationArea = all;
                        Image = PaymentPeriod;
                        ToolTip = 'Open the IT Slabs';
                    }
                    action("HRA Setup ")
                    {
                        Caption = 'HRA Setup';
                        RunObject = Page 33001357;
                        ApplicationArea = all;
                        Image = PaymentPeriod;
                        ToolTip = 'Open the HRA Setup';
                    }
                    action("E TDS Monthwise")
                    {
                        RunObject = Report "E TDS Month Wise B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'Open the E TDS Monthwise';
                    }
                    action("E TDS Salary")
                    {
                        RunObject = Report "E TDS Salary B2B";
                        Image = Report;
                        ApplicationArea = all;
                        ToolTip = 'E TDS salary';
                    }
                }
            }

            group("Periodic Activites")
            {

                action("Calendar Generation")
                {
                    Caption = 'Calendar Generation';
                    RunObject = Codeunit 33001192;
                    ApplicationArea = all;
                    Image = Calendar;
                    ToolTip = 'Execute the Calendar Generation';
                }
                action("Calendar Generation New Emp")
                {
                    Caption = 'Calendar Generation New Emp';
                    RunObject = Codeunit 33001193;
                    ApplicationArea = all;
                    Image = Calendar;
                    ToolTip = 'Execute the Calendar Generation new employee';
                }
                action("Update Lookups")
                {
                    Caption = 'Update Lookups';
                    RunObject = Codeunit 33001191;
                    ApplicationArea = all;
                    Image = UpdateDescription;
                    ToolTip = 'Execute the Update Lookup';
                }
                action("Generate provisional leaves")
                {
                    Caption = 'Generate provisional leaves';
                    RunObject = report 33001250;
                    ApplicationArea = all;
                    Image = GetActionMessages;
                    ToolTip = 'Execute the Generate provision leaves';
                }


                action("Update Experience")
                {
                    Caption = 'Update Exp.';
                    RunObject = Report 33001192;
                    ApplicationArea = all;
                    Image = Administration;
                    ToolTip = 'Execute the UpdateExperience';
                }

                action("Update VDA & FDA")
                {
                    Caption = 'Update VDA & FDA';
                    RunObject = Page 33001402;
                    ApplicationArea = all;
                    Image = Administration;
                    ToolTip = 'Execute the Update VDA & FDA';
                }
            }
            group("Locations Setup")
            {

                action("Payroll Locations List ")
                {
                    Caption = 'Payroll Loc. List';
                    RunObject = Page 33001285;
                    ApplicationArea = all;
                    Image = Administration;
                    ToolTip = 'Open the Payroll location list';
                }
                action("Payroll Location User List")
                {
                    Caption = 'Payroll Loc. User List';
                    RunObject = Page "Payroll Location User List B2B";
                    ApplicationArea = all;
                    Image = Administration;
                    ToolTip = 'Open the Payroll location user list';
                }

            }
            group(Travel)
            {
                caption = 'Travel';
                group(List)
                {
                    Caption = 'Lists';
                    image = ListPage;
                    action("Travel Requisitions")
                    {
                        Caption = 'Travel Requisitions';
                        Image = List;
                        RunObject = page "Travel Requisitions B2B";
                        ApplicationArea = all;
                        ToolTip = 'Open the Travel Requisitions';
                    }
                    action("Expense Statements ")
                    {
                        Caption = 'Expense Statements ';
                        Image = List;
                        RunObject = page "Expense Statements B2B";
                        ApplicationArea = all;
                        ToolTip = 'Open the Expense statement';

                    }
                    group(Archive1)
                    {
                        Caption = 'Archive';
                        image = Archive;
                        action("Posted Travel Requisitions ")
                        {
                            Caption = 'Posted Travel Requisitions';
                            Image = List;
                            RunObject = page "Posted Travel Requisitions B2B";
                            ApplicationArea = all;
                            ToolTip = 'Open the Posted Trave requisitions';
                        }
                        action("Posted Expense Statements")
                        {
                            Caption = 'Posted Expense Statements';
                            Image = List;
                            RunObject = page "Posted Expense Statements B2B";
                            ApplicationArea = all;
                            ToolTip = 'Open the Posted Expense statements';
                        }
                    }
                    group(Administartion)
                    {
                        Caption = 'Administration';
                        image = Administration;
                        action("Cities Types")
                        {
                            Caption = 'Cities Types';
                            Image = List;
                            RunObject = page "Cities Types B2B";
                            ApplicationArea = all;
                            ToolTip = 'Open the City Types';
                        }
                        action(Categories)
                        {
                            Caption = 'Categories';
                            image = List;
                            RunObject = page "Categories B2B";
                            ApplicationArea = all;
                            ToolTip = 'Open the Categories';
                        }
                        action(Components)
                        {
                            Caption = 'Components';
                            image = List;
                            RunObject = page "Components B2B";
                            ApplicationArea = all;
                            ToolTip = 'Open the Components';
                        }
                        action("Travel Groups")
                        {
                            Caption = 'Travel Groups';
                            image = List;
                            RunObject = page "Travel Groups B2B";
                            ApplicationArea = all;
                            ToolTip = 'Open the Travel groups';
                        }
                        action("Travel Posting Setup")
                        {
                            Caption = 'Travel Posting Setup';
                            image = List;
                            RunObject = page "Travel Posting Setup B2B";
                            ApplicationArea = all;
                            ToolTip = 'Open the Travel Posting Setup';
                        }

                    }


                }

                group(Organisation)
                {
                    caption = 'Organisation';
                    action("Organisation Tree")
                    {
                        Caption = 'Organisation Tree';
                        image = List;
                        RunObject = page "Organisation Tree B2B";
                        ApplicationArea = all;
                        ToolTip = 'Open the Organisation tree';
                    }

                }
            }
        }
    }
}