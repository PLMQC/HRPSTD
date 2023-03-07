report 33001256 "Update TDS Register B2B"
{
    // version B2BHR1.00.00

    Caption = 'Update TDS Register';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {

                group(Control1102152001)
                {
                    field(TDSPaymentJnlNo; TDSPaymentJnlNoGVar)
                    {
                        ToolTip = 'Choose the Document No.';
                        Caption = 'Document No.';
                        ApplicationArea = all;

                        trigger OnLookup(Var Text: Text): Boolean;
                        begin
                            SalTDSDet.RESET();
                            SalTDSDet.SETFILTER("TDS Payment Doc. No.", '<>%1', '');
                            if SalTDSDet.FINDFIRST() then
                                if PAGE.RUNMODAL(33001362, SalTDSDet) = ACTION::LookupOK then
                                    TDSPaymentJnlNoGVar := SalTDSDet."TDS Payment Doc. No.";
                        end;
                    }
                    field(ChallanNo; ChallanNoGVar)
                    {
                        ToolTip = 'Enter the Challan No. of TDS.';
                        Caption = 'Challan No.';
                        ApplicationArea = all;
                    }
                    field(ChallanDate; ChallanDateGVar)
                    {
                        ToolTip = 'Enter the Challan Date of TDs.';
                        Caption = 'Challan Date';
                        ApplicationArea = all;
                    }
                    field(BankName; BankNameGVar)
                    {
                        ToolTip = 'Choose the Bank name from which TDs is paid.';
                        Caption = 'Bank Name';
                        ApplicationArea = all;
                    }
                    field(BankBranch; BankBranchGVar)
                    {
                        ToolTip = 'Enter the Bank Branch which you have selected.';
                        Caption = 'Branch';
                        ApplicationArea = all;
                    }
                    field(ChequeNo; ChequeNoGVar)
                    {
                        ToolTip = 'Enter the Cheque no. which is mentioned on cheque.';
                        Caption = 'Cheque No.';
                        ApplicationArea = all;
                    }
                    field(ChequeDate; ChequeDateGVar)
                    {
                        ToolTip = 'Enter the Cheque Date which is mentioned on cheque.';
                        Caption = 'Cheque Date';
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

    trigger OnPostReport();
    begin
        if not CONFIRM(Text001Txt, false) then
            exit;
        if TDSPaymentJnlNoGVar <> '' then begin
            SalTDSDet.RESET();
            SalTDSDet.SETRANGE(SalTDSDet."TDS Payment Doc. No.", TDSPaymentJnlNoGVar);
            if SalTDSDet.FINDFIRST() then
                repeat
                    SalTDSDet."Challan No." := ChallanNoGVar;
                    SalTDSDet."Challan Date" := ChallanDateGVar;
                    SalTDSDet."Bank Name" := BankNameGVar;
                    SalTDSDet."BSR Code" := BankBranchGVar;
                    SalTDSDet."Cheque No." := ChequeNoGVar;
                    SalTDSDet."Cheque Date" := ChequeDateGVar;
                    SalTDSDet.MODIFY();
                until SalTDSDet.NEXT() = 0;
        end;
    end;

    var
        SalTDSDet: Record "TDS Salary Details B2B";
        TDSPaymentJnlNoGVar: Code[20];
        ChallanNoGVar: Code[20];
        ChallanDateGVar: Date;
        BankNameGVar: Text[50];
        BankBranchGVar: Text[20];
        ChequeNoGVar: Code[20];
        ChequeDateGVar: Date;
        Text001Txt: Label 'Do you want to update the TDS register';
}

