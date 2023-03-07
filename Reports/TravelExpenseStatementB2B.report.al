report 33001358 "Travel Expense Statement B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Travel Expense Statement.rdlc';
    Caption = 'Travel Expense Statement';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Expense Header"; "Expense Header B2B")
        {
            RequestFilterFields = "No.";
            column(TravelExpensesStatement_Caption; TravelExpensesStatement_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Dept_Location_Caption; Dept_Location_CaptionLbl)
            {
            }
            column(TravelFrom_Caption; TravelFrom_CaptionLbl)
            {
            }
            column(To_Caption; To_CaptionLbl)
            {
            }
            column(ReturnedtoHQon_Caption; ReturnedtoHQon_CaptionLbl)
            {
            }
            column(LeftHQon_Caption; LeftHQon_CaptionLbl)
            {
            }
            column(ForAccountsuseonly_Caption; ForAccountsuseonly_CaptionLbl)
            {
            }
            column(BillRecdOn_Caption; BillRecdOn_CaptionLbl)
            {
            }
            column(Reimbursedon_Caption; Reimbursedon_CaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Component_Caption; Component_CaptionLbl)
            {
            }
            column(Description_Caption; Description_CaptionLbl)
            {
            }
            column(Quantity_Caption; Quantity_CaptionLbl)
            {
            }
            column(Amount_Caption; Amount_CaptionLbl)
            {
            }
            column(CurrencyCode_Caption; CurrencyCode_CaptionLbl)
            {
            }
            column(ScrutinisedBy_Caption; ScrutinisedBy_CaptionLbl)
            {
            }
            column(ApprovedBy_Caption; ApprovedBy_CaptionLbl)
            {
            }
            column(AdvancedRecdon_Caption; AdvancedRecdon_CaptionLbl)
            {
            }
            column(PayabletoComp_Emp_Caption; PayabletoComp_Emp_CaptionLbl)
            {
            }
            column(SignatureofEmployee_Caption; SignatureofEmployee_CaptionLbl)
            {
            }
            column(No_ExpenseHeader; "No.")
            {
            }
            column(CompanyInfoGRec_Picture; CompanyInfoGRec.Picture)
            {
            }
            column(CompanyInfoGRec_Name; CompanyInfoGRec.Name)
            {
            }
            column(EmployeeName_ExpenseHeader; "Employee Name")
            {
            }
            column(ShortcutDimension1Code_ExpenseHeader; "Shortcut Dimension 1 Code")
            {
            }
            column(Rs_Caption; Rs_CaptionLbl)
            {
            }
            column(TravelRequisitionGRec_TravelFrom; TravelRequisitionGRec."Travel From")
            {
            }
            column(TravelRequisitionGRec_TravelTo; TravelRequisitionGRec."Travel To")
            {
            }
            column(BDate_Caption; BDate_CaptionLbl)
            {
            }
            dataitem("Expense Line"; "Expense Line B2B")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                DataItemTableView = SORTING ("Document No.", "Line No.");
                column(ExpenseDate_ExpenseLine; FORMAT("Expense Date"))
                {
                }
                column(ComponentType_ExpenseLine; "Component Type")
                {
                }
                column(Description_ExpenseLine; Description)
                {
                }
                column(Quantity_ExpenseLine; Quantity)
                {
                }
                column(Amount_ExpenseLine; Amount)
                {
                }
                column(AmountLCY_ExpenseLine; "Amount (LCY)")
                {
                }
                column(CurrencyCode_ExpenseLine; "Currency Code")
                {
                }
                column(LineNo_ExpenseLine; "Line No.")
                {
                }
                column(DocumentNo_ExpenseLine; "Document No.")
                {
                }
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING (Number) ORDER(Ascending);
                column(Number_Integer; Integer.Number)
                {
                }

                trigger OnPreDataItem();
                begin
                    RemBlankRows := "Expense Line".COUNT() mod 12;
                    if RemBlankRows = 0 then
                        CurrReport.BREAK();
                    SETRANGE(Number, 1, 12 - RemBlankRows);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                TravelRequisitionGRec.RESET();
                TravelRequisitionGRec.SETRANGE("No.", "Travel Req. No.");
                if TravelRequisitionGRec.FINDFIRST() then;
            end;
        }
    }

    requestpage
    {

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
        CompanyInfoGRec.GET();
        CompanyInfoGRec.CALCFIELDS(Picture);
    end;

    var
        CompanyInfoGRec: Record "Company Information";
        TravelRequisitionGRec: Record "Travel Requisition B2B";
        RemBlankRows: Integer;
        TravelExpensesStatement_CaptionLbl: Label 'Travel Expenses Statement';
        Name_CaptionLbl: Label 'Name :';
        Dept_Location_CaptionLbl: Label 'Dept/Location :';
        TravelFrom_CaptionLbl: Label 'Travel From';
        To_CaptionLbl: Label 'To';
        LeftHQon_CaptionLbl: Label 'Left HQ on';
        ReturnedtoHQon_CaptionLbl: Label 'Returned to HQ on.';
        ForAccountsuseonly_CaptionLbl: Label '"For Accounts use only "';
        BillRecdOn_CaptionLbl: Label 'Bill Recd On';
        Reimbursedon_CaptionLbl: Label 'Reimbursed on';
        Signature_CaptionLbl: Label 'Signature';
        Date_CaptionLbl: Label 'Date';
        Component_CaptionLbl: Label 'Component';
        Description_CaptionLbl: Label 'Description';
        Quantity_CaptionLbl: Label 'Quantity';
        Amount_CaptionLbl: Label 'Amount';
        CurrencyCode_CaptionLbl: Label 'Currency Code';
        ScrutinisedBy_CaptionLbl: Label 'Scrutinised By :';
        ApprovedBy_CaptionLbl: Label 'Approved By   :';
        AdvancedRecdon_CaptionLbl: Label 'Advanced Recd on';
        PayabletoComp_Emp_CaptionLbl: Label 'Payable to Comp/Emp.';
        SignatureofEmployee_CaptionLbl: Label 'Signature of Employee';

        Rs_CaptionLbl: Label 'Rs.';

        BDate_CaptionLbl: Label 'Date :';
}

