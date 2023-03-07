report 33001198 "Employee Pay Elements B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Employee Pay Elements.rdl';
    Caption = 'Employee Pay Elements';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            RequestFilterFields = "No.", "Job Title", "Department Code";
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
            column(USERID; USERID())
            {
            }
            column(Employee_B2B__No__; "No.")
            {
            }
            column(Employee_B2B_FullName; "Employee B2B".FullName())
            {
            }
            column(Employee_B2B__Job_Title_; "Job Title")
            {
            }
            column(Employee_B2B__Pay_Cadre_; "Pay Cadre")
            {
            }
            column(Employee_B2B__Department_Code_; "Department Code")
            {
            }
            column(SlNo; SlNo)
            {
            }
            column(Employee___Pay_ElementsCaption; Employee___Pay_ElementsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(NoCaption; NoCaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Job_TitleCaption; Job_TitleCaptionLbl)
            {
            }
            column(Pay_CadreCaption; Pay_CadreCaptionLbl)
            {
            }
            column(Department_CodeCaption; Department_CodeCaptionLbl)
            {
            }
            column(Sl__No_Caption; Sl__No_CaptionLbl)
            {
            }

            dataitem("Pay Elements"; "Pay Elements B2B")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = SORTING("Employee Code", "Effective Start Date", "Pay Element Code");
                RequestFilterFields = "Pay Element Code";
                column(Pay_Elements__Effective_Start_Date_; "Effective Start Date")
                {
                }
                column(Pay_Elements__Pay_Element_Code_; "Pay Element Code")
                {
                }
                column(Pay_Elements__Computation_Type_; "Computation Type")
                {
                }
                column(Pay_Elements__Fixed_Percent_; "Fixed/Percent")
                {
                }
                column(Pay_Elements__Amount___Percent_; "Amount / Percent")
                {
                }
                column(Pay_Element_CodeCaption; Pay_Element_CodeCaptionLbl)
                {
                }
                column(Computation_TypeCaption; Computation_TypeCaptionLbl)
                {
                }
                column(Fixed___PercentCaption; Fixed___PercentCaptionLbl)
                {
                }
                column(Amount___PercentCaption; Amount___PercentCaptionLbl)
                {
                }
                column(Starting_DateCaption; Starting_DateCaptionLbl)
                {
                }
                column(Pay_Elements_Employee_Code; "Employee Code")
                {
                }
                column(Amount___Percent; "Amount / Percent")
                { }
                

                trigger OnAfterGetRecord();
                begin
                    SlNo := SlNo + 1;
                end;

                trigger OnPreDataItem();
                begin
                    PayEmpElementsFilter := "Pay Elements".GETFILTERS();
                end;
            }

            trigger OnPreDataItem();
            begin
                EmployeesFilter := "Employee B2B".GETFILTERS();
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Employee Pay Elements';

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

    trigger OnPreReport();
    begin
        SlNo := 0;
    end;

    var

        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        SlNo: Integer;
        PayEmpElementsFilter: Text;
        EmployeesFilter: Text;

        Employee___Pay_ElementsCaptionLbl: Label 'Employee - Pay Elements';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NoCaptionLbl: Label 'No';
        Employee_NameCaptionLbl: Label 'Employee Name';
        Job_TitleCaptionLbl: Label 'Job Title';
        Pay_CadreCaptionLbl: Label 'Pay Cadre';
        Department_CodeCaptionLbl: Label 'Department Code';
        Sl__No_CaptionLbl: Label 'Sl. No.';
        Pay_Element_CodeCaptionLbl: Label 'Pay Element Code';
        Computation_TypeCaptionLbl: Label 'Computation Type';
        Fixed___PercentCaptionLbl: Label 'Fixed / Percent';
        Amount___PercentCaptionLbl: Label 'Amount / Percent';
        Starting_DateCaptionLbl: Label 'Starting Date';
}

