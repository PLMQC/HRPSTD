report 33001214 "Loan Details B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Loan Details.rdl';
    Caption = 'Loan Details';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            PrintOnlyIfDetail = true;
            // RequestFilterFields ="No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }

            /*
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }*/
            column(USERID; USERID())
            {
            }
            column(UPPERCASE_Employee_B2B__First_Name__________Employee_B2B__Last_Name___;
            UPPERCASE("Employee B2B"."First Name" + '  ' + "Employee B2B"."Last Name"))
            {
            }
            column(Employee_B2B__No__; "No.")
            {
            }
            column(Employee___Loan_ScheduleCaption; Employee___Loan_ScheduleCaptionLbl)
            {
            }
            column(Employee_Loan_Cap; Employee_Loan_Cap)
            {

            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Loan_AmountCaption; Loan_AmountCaptionLbl)
            {
            }
            column(Loan_BalanceCaption; Loan_BalanceCaptionLbl)
            {
            }
            column(Start_DateCaption; Start_DateCaptionLbl)
            {
            }
            column(Loan_FromCaption; Loan_FromCaptionLbl)
            {
            }
            column(Loan_Ref__No_Caption; Loan_Ref__No_CaptionLbl)
            {
            }
            column(Effective_AmountCaption; Effective_AmountCaptionLbl)
            {
            }
            column(InstallmentCaption; InstallmentCaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            dataitem(Loan; Loan_B2B)
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = SORTING(Id) ORDER(Ascending);
                RequestFilterFields = Id;
                column(Loan__Loan_Type_; "Loan Type")
                {
                }
                column(Loan__Loan_Amount_; "Loan Amount")
                {
                }
                column(Loan__Loan_Balance_; "Loan Balance")
                {
                }
                column(Loan__Loan_Start_Date_; "Loan Start Date")
                {
                }
                column(Loan__Loan_From_; "Loan From")
                {
                }
                column(Loan__Loan_Ref_No__; "Loan Ref No.")
                {
                }
                column(Loan__Effective_Amount_; "Effective Amount")
                {
                }
                column(Loan__Installment_Amount_; "Installment Amount")
                {
                }
                column(Loan_Type; Type)
                {
                }
                column(Loan_Id; Id)
                {
                }
                column(Loan_Employee_Code; "Employee Code")
                {
                }
            }

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Loan Details';

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
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Employee___Loan_ScheduleCaptionLbl: Label 'Employee - Loan Schedule';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_No_CaptionLbl: Label 'Employee No.';
        NameCaptionLbl: Label 'Employee Name';
        Loan_TypeCaptionLbl: Label 'Loan Type';
        Loan_AmountCaptionLbl: Label 'Loan Amount';
        Loan_BalanceCaptionLbl: Label 'Loan Balance';
        Start_DateCaptionLbl: Label 'Start Date';
        Loan_FromCaptionLbl: Label 'Loan From';
        Loan_Ref__No_CaptionLbl: Label 'Loan Ref. No.';
        Effective_AmountCaptionLbl: Label 'Effective Amount';
        InstallmentCaptionLbl: Label 'Installment';
        TypeCaptionLbl: Label 'Type';
        Employee_Loan_Cap: Label 'Employee Loan Details';
}

