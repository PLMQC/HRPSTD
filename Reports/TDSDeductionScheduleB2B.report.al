report 33001229 "TDS Deduction Schedule B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\TDS Deduction Schedule.rdlc';
    Caption = 'TDS Deduction Schedule';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Employee_B2B__No__; "No.")
            {
            }
            column(Employee_B2B__First_Name__Employee_B2B__Middle_Name__Employee_B2B__Last_Name_;
                "Employee B2B"."First Name" + "Employee B2B"."Middle Name" + "Employee B2B"."Last Name")
            {
            }
            column(Employee_B2B_Employee_B2B__PAN_No_;
                "Employee B2B"."PAN No")
            {
            }
            dataitem("EMP TDS Monthly Schedule"; "EMP TDS Monthly Schedule B2B")
            {
                DataItemLink = "Emp ID" = FIELD("No.");
                DataItemTableView = SORTING("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month") ORDER(Ascending);
                column(EMP_TDS_Monthly_Schedule__Payslip_Month_; "Payslip Month")
                {
                }
                column(EMP_TDS_Monthly_Schedule__Payslip_Year_; "Payslip Year")
                {
                }
                column(EMP_TDS_Monthly_Schedule__Financial_Year_Start_Date_; "Financial Year Start Date")
                {
                }
                column(EMP_TDS_Monthly_Schedule__Financial_Year_End_Date_; "Financial Year End Date")
                {
                }
                column(EMP_TDS_Monthly_Schedule__TDS_Amount_; "TDS Amount")
                {
                }
                column(EMP_TDS_Monthly_Schedule__TDS_Amount_Deducted_; "TDS Amount Deducted")
                {
                }
                column(EMP_TDS_Monthly_Schedule__TDS_Remaining_Amount_; "TDS Remaining Amount")
                {
                }
                column(EMP_TDS_Monthly_Schedule__TDS_Remaining_Amount_Caption; FIELDCAPTION("TDS Remaining Amount"))
                {
                }
                column(EMP_TDS_Monthly_Schedule__TDS_Amount_Deducted_Caption; FIELDCAPTION("TDS Amount Deducted"))
                {
                }
                column(EMP_TDS_Monthly_Schedule__TDS_Amount_Caption; FIELDCAPTION("TDS Amount"))
                {
                }
                column(EMP_TDS_Monthly_Schedule__Financial_Year_End_Date_Caption; FIELDCAPTION("Financial Year End Date"))
                {
                }
                column(EMP_TDS_Monthly_Schedule__Financial_Year_Start_Date_Caption; FIELDCAPTION("Financial Year Start Date"))
                {
                }
                column(EMP_TDS_Monthly_Schedule__Payslip_Year_Caption; FIELDCAPTION("Payslip Year"))
                {
                }
                column(EMP_TDS_Monthly_Schedule__Payslip_Month_Caption; FIELDCAPTION("Payslip Month"))
                {
                }
                column(EMP_TDS_Monthly_Schedule_Emp_ID; "Emp ID")
                {
                }

                trigger OnPreDataItem();
                begin
                    PayRollYears.RESET();
                    PayRollYears.SETRANGE("Year Type", FINANCIALYEARTxt);
                    PayRollYears.SETRANGE(Closed, false);
                    if PayRollYears.FINDFIRST() then;
                    SETRANGE("Financial Year Start Date", PayRollYears."Year Start Date");
                end;
            }
        }
    }

    requestpage
    {
        Caption = 'TDS Deduction Schedule';

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PayRollYears: Record "Payroll Year B2B";
        FINANCIALYEARTxt: Label 'FINANCIAL YEAR';
}

