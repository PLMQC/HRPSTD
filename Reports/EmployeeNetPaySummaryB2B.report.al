report 33001199 "Employee Net Pay Summary B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Employee Net Pay Summary.rdlc';
    Caption = 'Employee Net Pay Summary';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.");
            column(USERID; USERID())
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            /*
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }*///B2BBP
            column(MonthName; 'For the Month of  ' + MonthName)
            {
            }
            column(Employee_B2B__No__; "No.")
            {
            }
            column(UPPERCASE__Employee_B2B__First_Name__________Employee_B2B__Last_Name___;
            UPPERCASE(("Employee B2B"."First Name") + ' ' + ("Employee B2B"."Last Name")))
            {
            }
            column(Employee_B2B__Department_Code_; "Department Code")
            {
            }
            column(GrossAdditions; GrossAdditions)
            {
            }
            column(GrossDeductions; GrossDeductions)
            {
            }
            column(NetSal; NetSal)
            {
            }
            column(SlNo; SlNo)
            {
            }
            column(footnet; footnet)
            {
            }
            column(Employee___Net_Pay_SummaryCaption; Employee___Net_Pay_SummaryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_no_Caption; Employee_no_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Dept_CodeCaption; Dept_CodeCaptionLbl)
            {
            }
            column(Gross_AdditionsCaption; Gross_AdditionsCaptionLbl)
            {
            }
            column(Gross_DeductionsCaption; Gross_DeductionsCaptionLbl)
            {
            }
            column(Net_Salary_PayableCaption; Net_Salary_PayableCaptionLbl)
            {
            }
            column(Sl_No_Caption; Sl_No_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(GrossAdditions);
                CLEAR(GrossDeductions);
                CLEAR(NetSal);
                SlNo := SlNo + 1;

                ProcessedSalary.SETRANGE("Employee Code", "No.");
                if MonthGVar <> 0 then
                    ProcessedSalary.SETRANGE("Pay Slip Month", MonthGVar);
                if YearGVar <> 0 then
                    ProcessedSalary.SETRANGE(Year, YearGVar);
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        GrossAdditions += ProcessedSalary."Earned Amount";
                    until ProcessedSalary.NEXT() = 0;

                ProcessedSalary.RESET();
                ProcessedSalary.SETRANGE("Employee Code", "No.");
                if MonthGVar <> 0 then
                    ProcessedSalary.SETRANGE("Pay Slip Month", MonthGVar);
                if YearGVar <> 0 then
                    ProcessedSalary.SETRANGE(Year, YearGVar);
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        GrossDeductions += ProcessedSalary."Earned Amount";
                    until ProcessedSalary.NEXT() = 0;

                NetSal := GrossAdditions - GrossDeductions;
                footnet += NetSal;
            end;

            trigger OnPreDataItem();
            begin
                footnet := 0;
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
                //Caption = 'Filters'; //Sravan
                field(Month; MonthGVar)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Month';
                }
                field(Year; YearGVar)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The year';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ProcessedSalary: Record "Processed Salary B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        GrossAdditions: Decimal;
        GrossDeductions: Decimal;
        NetSal: Decimal;
        footnet: Decimal;
        MonthGVar: Integer;
        YearGVar: Integer;
        SlNo: Integer;
        MonthName: Text[30];

        Employee___Net_Pay_SummaryCaptionLbl: Label 'Employee - Net Pay Summary';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_no_CaptionLbl: Label 'Employee No.';
        NameCaptionLbl: Label 'Name';
        Dept_CodeCaptionLbl: Label 'Dept Code';
        Gross_AdditionsCaptionLbl: Label 'Gross Additions';
        Gross_DeductionsCaptionLbl: Label 'Gross Deductions';
        Net_Salary_PayableCaptionLbl: Label 'Net Salary Payable';
        Sl_No_CaptionLbl: Label 'Sl No.';
}

