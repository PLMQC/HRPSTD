report 33001216 "Pay Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PayRegisterB2B.rdl';
    Caption = 'Pay Register';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Monthly Attendance"; 33001218)
        {
            column(COMPANYNAME; CompanyInfo.Name)
            {
            }

            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo__Post_Code_; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(INDIACaption; INDIACaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Pay_RegisterCaption; Pay_RegisterCaptionLbl)
            {
            }
            column(Gross_PayCaption; Gross_PayCaptionLbl)
            {
            }
            column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
            {
            }
            column(Net_PayCaption; Net_PayCaptionLbl)
            {
            }
            column(Emp_NoCaption; Emp_NoCaptionLbl)
            {
            }
            column(Emp__NameCaption; Emp__NameCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "Monthly Attendance"."Employee Code")
            {
            }
            column(FirstName_EmployeeB2B; "Monthly Attendance"."Employee Name")
            {
            }
            column(Attendance_MonthlyAttendance; "Monthly Attendance".Attendance)
            {
            }

            dataitem("Processed Salary"; 33001227)
            {
                DataItemLink = "Employee Code" = FIELD("Employee Code"),
                               "Pay Slip Month" = FIELD("Pay Slip Month"),
                               Year = FIELD(Year);
                DataItemTableView = SORTING("Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.")
                                    ORDER(Ascending);
                RequestFilterFields = "Pay Slip Month", Year;
                column(AddDeduct_ProcessedSalary; "Processed Salary"."Add/Deduct")
                {
                }
                column(AddDeductCode_ProcessedSalary; "Processed Salary"."Add/Deduct Code")
                {
                }
                column(EarnedAmount_ProcessedSalary; "Processed Salary"."Earned Amount")
                {
                }
                column(Processed_Salary__Employee_Name_; "Employee Name")
                {
                }
                column(PaySlipMonth_ProcessedSalary; "Processed Salary"."Pay Slip Month")
                {
                }
                column(Year_ProcessedSalary; "Processed Salary".Year)
                {
                }
                column(Processed_Salary__Employee_Code_; "Employee Code")
                {
                }
                column(Processed_Salary_Document_Type; "Document Type")
                {
                }
                column(Processed_Salary_Pay_Slip_Month; "Pay Slip Month")
                {
                }
                column(Processed_Salary_Year; Year)
                {
                }
                column(Processed_Salary_Line_No_; "Line No.")
                {
                }
                column(GrossPay; GrossPay)
                {
                }
                column(NetDedu; NetDedu)
                {
                }
                column(NetSalary; NetSalary)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SerialNo += 1;
                    Lookup.RESET;
                    Lookup.SETRANGE("Lookup Type", 16);
                    Lookup.SETRANGE("Lookup Name", "Processed Salary"."Add/Deduct Code");
                    Lookup.SETRANGE("Print in Payregister", TRUE);
                    IF NOT Lookup.FINDFIRST THEN
                        CurrReport.SKIP;

                    IF "Processed Salary"."Add/Deduct" = "Processed Salary"."Add/Deduct"::Addition THEN
                        GrossPay += "Processed Salary"."Earned Amount";
                    IF "Processed Salary"."Add/Deduct" = "Processed Salary"."Add/Deduct"::Deduction THEN
                        NetDedu += "Processed Salary"."Earned Amount";

                    NetSalary := GrossPay - NetDedu;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(GrossPay);
                CLEAR(NetDedu);
                CLEAR(NetSalary);
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPreReport()
    begin
        Lookup.RESET;
        Lookup.SETRANGE("Lookup Type", 16);
        Lookup.SETRANGE("Print in Payregister", TRUE);
        IF NOT Lookup.FINDFIRST THEN
            ERROR('Mark atleast 1 payelement as print in payregister in lookup')
    end;

    var
        Employee: Record Employee;
        Month: Text[30];
        Year: Integer;
        DaysPresent: Decimal;
        PayMonth: Integer;
        INDIACaptionLbl: Label 'INDIA';
        EmptyStringCaptionLbl: Label '.';
        Pay_RegisterCaptionLbl: Label 'Pay Register';
        Gross_PayCaptionLbl: Label 'Gross Pay';
        Total_DeductionsCaptionLbl: Label 'Total Deductions';
        Net_PayCaptionLbl: Label 'Net Pay';
        Emp_NoCaptionLbl: Label 'Emp.No';
        Emp__NameCaptionLbl: Label 'Emp. Name';
        GrossPay: Decimal;
        NetDedu: Decimal;
        NetSalary: Decimal;
        CompanyInfo: Record "Company Information";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        SerialNo: Integer;
        Lookup: Record Lookup_B2B;
}

