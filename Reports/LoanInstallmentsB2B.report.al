report 33001213 "Loan Installments B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Loan Installments.rdl';
    Caption = 'Loan Installments';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Loan; Loan_B2B)
        {
            DataItemTableView = SORTING(Id) ORDER(Ascending);
            RequestFilterFields = Id;


            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(Loan__Employee_Code_; "Employee Code")
            {
            }
            column(Loan_Loan__Loan_Amount_; Loan."Loan Amount")
            {
            }
            column(Loan_Id; Id)
            {
            }
            column(Loan__Employee_Code_Caption; FIELDCAPTION("Employee Code"))
            {
            }
            column(Employee_LoanCaption; Employee_LoanCaption)
            {

            }
            column(Loan_AmountCaption; Loan_AmountCaptionLbl)
            {
            }
            column(Loan_IDCaption; Loan_IDCaptionLbl)
            {
            }
            dataitem("Loan Details"; "Loan Details B2B")
            {
                DataItemLink = "Employee No." = FIELD("Employee Code");
                DataItemTableView = SORTING("Loan Id") ORDER(Ascending);
                column(Loan_Details__EMI_Amount_; "EMI Amount")
                {
                }
                column(Loan_Details__EMI_Deducted_; "EMI Deducted")
                {
                }
                column(Loan_Details__Lump_Sum_Payment_; "Lump Sum Payment")
                {
                }
                column(Loan_Details_Balance; Balance)
                {
                }
                column(opbal; opbal)
                {
                }
                column(Loan_Details__Pay_Date_; "Pay Date")
                {
                }
                column(show; show)
                {
                }
                column(Loan_Details__EMI_Amount_Caption; FIELDCAPTION("EMI Amount"))
                {
                }
                column(Loan_Details__EMI_Deducted_Caption; FIELDCAPTION("EMI Deducted"))
                {
                }
                column(Loan_Details__Lump_Sum_Payment_Caption; FIELDCAPTION("Lump Sum Payment"))
                {
                }
                column(Balance_for_the_monthCaption; Balance_for_the_monthCaptionLbl)
                {
                }
                column(Op_BalanceCaption; Op_BalanceCaptionLbl)
                {
                }
                column(Loan_Details__Pay_Date_Caption; FIELDCAPTION("Pay Date"))
                {
                }
                column(Loan_Details_Employee_No_; "Employee No.")
                {
                }
                column(Loan_Details_Loan_Id; "Loan Id")
                {
                }
                column(Loan_Details_Line_No; "Line No")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    SETRANGE("Loan Id", Loan.Id);
                    if ("Pay Date" >= fromdateGVar) and ("Pay Date" <= todateGVar) then
                        show := true
                    else
                        show := false;

                    opbal := temp;
                    Balance := "Loan Details"."EMI Amount" - "Loan Details"."EMI Deducted" - "Loan Details"."Lump Sum Payment";
                    if Balance < 0 then
                        Balance := 0;
                    temp := Balance;
                end;

                trigger OnPreDataItem();
                begin
                    temp := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                B2BEmpGRec.RESET();
                B2BEmpGRec.SETRANGE("No.", Loan."Employee Code");
                B2BEmpGRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                if not B2BEmpGRec.FINDFIRST() then
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem();
            begin
                balance := 0;
                opbal := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(fromdate; fromdateGVar)
                    {
                        ToolTip = 'Enter the start date for loan installment';
                        Caption = 'starting date';
                        ApplicationArea = all;
                    }
                    field(todate; todateGVar)
                    {
                        ToolTip = 'Enter the installment End date.';
                        Caption = 'ending date';
                        ApplicationArea = all;
                    }
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
        B2BEmpGRec: Record "Employee B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        opbal: Decimal;
        balance: Decimal;
        todateGVar: Date;
        fromdateGVar: Date;
        show: Boolean;
        temp: Decimal;

        Loan_AmountCaptionLbl: Label 'Loan Amount';
        Loan_IDCaptionLbl: Label 'Loan ID';
        Balance_for_the_monthCaptionLbl: Label 'Balance for the month';
        Op_BalanceCaptionLbl: Label 'Op Balance';
        Employee_LoanCaption: Label 'Employee Loan Installments';
}

