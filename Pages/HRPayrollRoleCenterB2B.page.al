// page 33001534 "HR & Payroll Role Center B2B"
// {
//     // version B2BHR1.00.00

//     Caption = 'HR & Payroll Role Center';
//     PageType = RoleCenter;
//     PromotedActionCategories = 'New,Creation,Reports,Payment Journals';




//     layout
//     {
//         area(rolecenter)
//         {
//             group(Control1102152005)
//             {
//                 part(Activities; "HR & Payroll Activities B2B")
//                 {
//                     Caption = 'Activities';
//                     ApplicationArea = all;
//                 }
//                 systempart(Outlook; Outlook)
//                 {
//                     Caption = 'Outlook';
//                     Visible = false;
//                     ApplicationArea = all;
//                 }
//             }
//             group(Control1102152002)
//             {
//                 part("Employee List RC"; "Employee List RC B2B")
//                 {
//                     Caption = 'Employees';
//                     ApplicationArea = all;
//                 }
//                 /*
//                 chart("Employee Experience")
//                 {
//                     Caption = 'Employee Experience';
//                     ChartPartID = 'EXPERIENCE';
//                     ToolTip = 'Employee Experience';
//                 }
//                 chart("Attendance For Processing Month")
//                 {
//                     Caption = 'Attendance For Processing Month';
//                     ChartPartID = 'ATTENDANCE';
//                 }
//                 chart("PROCESSED SALARY")
//                 {
//                     Caption = 'PROCESSED SALARY';
//                     ChartPartID = 'PROCESSED SALARY';
//                 }
//                 */
//                 systempart(MyNotes; MyNotes)
//                 {
//                     Caption = 'MyNotes';
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(reporting)
//         {
//             action("Employee Addresses")
//             {
//                 Caption = 'Employee Addresses';
//                 Image = "Report";
//                 RunObject = Report "Employee - Address B2B";
//                 ApplicationArea = all;
//                 ToolTip = 'Specifies Employee adderess';
//             }
//             action("Employee Credentials")
//             {
//                 Caption = 'Employee Credentials';
//                 Image = SelectReport;
//                 RunObject = Report "Employee -Credentials B2B";
//                 ApplicationArea = all;
//                 ToolTip = 'Specifies Employee Credentials';

//             }
//             action("Employee Pay Elements")
//             {
//                 Caption = 'Employee Pay Elements';
//                 Image = PrintChecklistReport;
//                 RunObject = Report "Employee Pay Elements B2B";
//                 ApplicationArea = all;
//                 ToolTip = 'Specifies Employee pay elements';

//             }
//             action("Pay Slip")
//             {
//                 Caption = 'Pay Slip';
//                 Image = PayrollStatistics;
//                 RunObject = Report "Pay Slip B2B";
//                 ApplicationArea = all;
//                 ToolTip = 'Prints Pay slip';
//             }
//             action("Monthly Attendance for Period")
//             {
//                 Caption = 'Monthly Attendance for Period';
//                 Image = PaymentPeriod;
//                 RunObject = Report "Month wise Pay Element B2B";
//                 ToolTip = 'Prints Monthly attendance for period';
//                 ApplicationArea = all;
//             }
//             /*
//             action("Monthly Salary Summary")
//             {
//                 Caption = 'Monthly Salary Summary';
//                 Image = SelectReport;
//                 RunObject = Report "Monthly Salary Summary";
//             }
//             */
//             action("Employee Count Report")
//             {
//                 Caption = 'Employee Count Report';
//                 Image = SelectReport;
//                 RunObject = Report "Employee Count Report B2B";
//                 ApplicationArea = all;
//                 ToolTip = 'Prints Employee count';
//             }
//             action("Employee Complete Information")
//             {
//                 Caption = 'Employee Complete Information';
//                 Image = SelectReport;
//                 RunObject = Report "Employee Complete Info B2B";
//                 ApplicationArea = all;
//                 ToolTip = 'Prints Employee complete information';
//             }
//             action(Action12)
//             {
//                 Caption = 'Employee Pay Elements';
//                 Image = SelectReport;
//                 RunObject = Report "Employee Pay Elements B2B";
//                 ApplicationArea = all;
//                 ToolTip = 'Prints employee pay elements';
//             }
//         }
//         area(embedding)
//         {

//             action("Loan List")
//             {
//                 Caption = 'Loan List';
//                 Image = List;
//                 RunObject = Page "Loan List B2B";
//                 ApplicationArea = all;
//                 ToolTip = 'Specifies Loan list';
//             }

//         }
//         area(sections)
//         {
//             group("<Action1102152019>")
//             {
//                 Caption = 'Payroll';
//                 Image = HumanResources;
//                 action("Employee List")
//                 {
//                     Caption = 'Employee List';
//                     Image = ListPage;
//                     RunObject = Page "Employee List B2B";
//                     ApplicationArea = all;
//                     ToolTip = 'Opens Employee list';
//                 }
//         
//                 action("Leave List")
//                 {
//                     Caption = 'Leave List';
//                     Image = ListPage;
//                     RunObject = Page "Leave List B2B";
//                     ApplicationArea = all;
//                     ToolTip = 'Opens Leave list';
//                 }
//                 action("Employee Seperations")
//                 {
//                     Caption = 'Employee Seperations';
//                     Image = ListPage;
//                     RunObject = Page "Employee Seperation List B2B";
//                     ApplicationArea = all;
                
//                 }
//                 action("Employee Training Need")
//                 {
//                     Caption = 'Employee Training Need';
//                     Image = ListPage;
//                                     RunObject = Page "Employee Training Need B2B";
//                     ApplicationArea = all;
//                 }

//                 action("Comp Offs")
//                 {
//                     Caption = 'Comp Offs';
//                     Image = ListPage;
//                                     RunObject = Page "Comp Off List B2B";
//                     ApplicationArea = all;
//                 }
//                 action("LOP Adjustments")
//                 {
//                     Caption = 'LOP Adjustments';
//                     Image = ListPage;
//                                     RunObject = Page "LOP Adjustment List B2B";
//                     ApplicationArea = all;
//                 }
//                 action("Tour Intimations")
//                 {
//                     Caption = 'Tour Intimations';
//                     Image = ListPage;
//                                     RunObject = Page "Tour Intimation List B2B";
//                     ApplicationArea = all;
//                 }
//                 action("Permission Applications")
//                 {
//                     Caption = 'Permission Applications';
//                     Image = ListPage;
//                                     RunObject = Page "Permission Appli. List B2B";
//                     ApplicationArea = all;
//                 }
//                 action("Shift Schedules")
//                 {
//                     Caption = 'Shift Schedules';
//                     Image = ListPage;
//                                     RunObject = Page "Shift Schedule List B2B";
//                     ApplicationArea = all;
//                 }

//                 action(Action1102152022)
//                 {
//                     Caption = 'Loans';
//                     Image = ListPage;
//                                     RunObject = Page "Loan List B2B";
//                     ApplicationArea = all;
//                 }
//                 action("Loan Repayments")
//                 {
//                     Caption = 'Loan Repayments';
//                     Image = ListPage;
//                                     RunObject = Page "Loan Repayment List B2B";
//                     ApplicationArea = all;
//                 }

//                 action("Final Settlements")
//                 {
//                     Caption = 'Final Settlements';
//                     Image = ListPage;
//                                     RunObject = Page "Final Settlement List B2B";
//                     ApplicationArea = all;
//                 }
//             }
//             group(ActionGroup3)
//             {
//                 Caption = 'Attendance';
//                 action("Leave Application")
//                 {
//                     Caption = 'Leave Application';
//                     Image = ListPage;
//                                     RunObject = Page "Leave Application List B2B";
//                     ApplicationArea = all;
//                 }
//             }
//         }
//         area(creation)
//         {
//             action("Create &Employee")
//             {
//                 Caption = 'Create &Employee';
//                 Image = NewCustomer;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                                 RunObject = Page "Employee Card B2B";
//                                 RunPageMode = Create;
//                 ApplicationArea = all;
//             }
//             action("Create &Resume")
//             {
//                 Caption = 'Create &Resume';
//                 Image = NewOpportunity;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                                 RunObject = Page "Resume Database Card B2B";
//                                 RunPageMode = Create;
//                                 ApplicationArea = all;
//                 ToolTip = 'Create Resume';
//             }
//             action("Create &Loan")
//             {
//                 Caption = 'Create &Loan';
//                 Image = NewSparkle;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 ToolTip = 'Create Loan';
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                                 RunObject = Page "Loan Card B2B";
//                                 RunPageMode = Create;
//                 ApplicationArea = all;
//             }
//             action("Apply Leave")
//             {
//                 Caption = 'Apply Leave';
//                 Image = Absence;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 ToolTip = 'Apply Leave';
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                                 RunObject = Page "Leave Application B2B";
//                                 RunPageMode = Create;
//                 ApplicationArea = all;
//             }
//         }
//         area(processing)
//         {
//             separator(Journals)
//             {
//                 Caption = 'Journals';
//                 IsHeader = true;
//             }
//             action("Leave Journal")
//             {
//                 Caption = 'Leave Journal';
//                 Image = CapacityJournal;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                                 RunObject = Page "Leave Journal B2B";
//                 ApplicationArea = all;
//             }
//             action("Hr Setup")
//             {
//                 Caption = 'Hr Setup';
//                 Image = Setup;
//                                 RunObject = Page "HR Setup B2B";
//                 ApplicationArea = all;
//             }
//             action("TDS Payment Journal")
//             {
//                 Caption = 'TDS Payment Journal';
//                 Image = SocialSecurityTax;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                                 RunObject = Page "TDS Payment Journal B2B";
//                 ApplicationArea = all;
//             }
//             action("Leave Encashment Pay Journal")
//             {
//                 Caption = 'Leave Encashment Pay Journal';
//                 Image = CashReceiptJournal;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                                 RunObject = Page "Leave Encashment Pay Jou B2B";
//                 ApplicationArea = all;
//             }
//             action("Pay Salary")
//             {
//                 Caption = 'Pay Salary';
//                 Image = VendorPaymentJournal;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                                 RunObject = Page "Pay Salary B2B";
//                 ApplicationArea = all;
//             }
//             action("Pay Arrear Salary")
//             {
//                 Caption = 'Pay Arrear Salary';
//                 Image = AmountByPeriod;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                                 RunObject = Page "Pay Arrear Salary B2B";
//                 ApplicationArea = all;
//             }
//             action("Final Settlement Payable")
//             {
//                 Caption = 'Final Settlement Payable';
//                 Image = SettleOpenTransactions;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                                 RunObject = Page "Final Settlement Payable B2B";
//                 ApplicationArea = all;
//             }
//             action("Daily Attendance")
//             {
//                 Caption = 'Daily Attendance';
//                 Image = DataEntry;
//                                 RunObject = Page "Daily Attendance B2B";
//                 ApplicationArea = all;
//             }
//             action("Monthly Attendance")
//             {
//                 Caption = 'Monthly Attendance';
//                 Image = AnalysisView;
//                                 RunObject = Page "Monthly Attendance B2B";
//                 ApplicationArea = all;
//             }
//             action("Comp Off List")
//             {
//                 Image = ListPage;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category10;
//                                 RunObject = Page "Comp Off List B2B";
//                 ApplicationArea = all;
//             }
//             action("Tour Intimation List")
//             {
//                 Image = Info;
//                                 RunObject = Page "Tour Intimation List B2B";
//                 ApplicationArea = all;
//             }
//             action("Shift Schedule List")
//             {
//                 Image = ListPage;
//                                 RunObject = Page "Shift Rotation B2B";
//                 ApplicationArea = all;
//             }
//             action("Loan Repayment List")
//             {
//                 Caption = 'Loan Repayment List';
//                 Image = Loaner;
//                                 RunObject = Page "Loan Repayment List B2B";
//                 ApplicationArea = all;
//             }
//             action("Final Settlement List")
//             {
//                 Image = List;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category10;
//                                 RunObject = Page "Final Settlement List B2B";
//                 ApplicationArea = all;
//             }
//         }
//     }
// }

