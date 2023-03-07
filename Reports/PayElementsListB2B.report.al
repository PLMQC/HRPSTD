report 33001201 "Pay Elements List B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Pay Elements List.rdlc';
    Caption = 'Pay Elements List';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Lookup_B2B; Lookup_B2B)
        {

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
            column(Lookup__Lookup_Name_; "Lookup Name")
            {
            }
            column(Lookup_Description; Description)
            {
            }
            column(Srno; Srno)
            {
            }
            column(Lookup__Add_Deduct_; "Add/Deduct")
            {
            }
            column(Lookup__Applicable_for_OT_; "Applicable for OT")
            {
            }
            column(Lookup_ESI; ESI)
            {
            }
            column(Lookup_PF; PF)
            {
            }
            column(Lookup__Leave_Encashment_; "Leave Encashment")
            {
            }
            column(Lookup__Payroll_Prod__Posting_Group_; "Payroll Prod. Posting Group")
            {
            }
            column(Lookup_Remarks; Remarks)
            {
            }
            column(List_of_Pay_ElementsCaption; List_of_Pay_ElementsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Sl__No_Caption; Sl__No_CaptionLbl)
            {
            }
            column(Pay_Element_CodeCaption; Pay_Element_CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Add_DeductCaption; Add_DeductCaptionLbl)
            {
            }
            column(App__For_OTCaption; App__For_OTCaptionLbl)
            {
            }
            column(ESICaption; ESICaptionLbl)
            {
            }
            column(PFCaption; PFCaptionLbl)
            {
            }
            column(Leave_EncashmentCaption; Leave_EncashmentCaptionLbl)
            {
            }
            column(Payroll_Prod__Posting_GroupCaption; Payroll_Prod__Posting_GroupCaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(Lookup_Lookup_Id; "Lookup Id")
            {
            }
            column(Lookup_Lookup_Type; "Lookup Type")
            {
            }

            trigger OnAfterGetRecord();
            begin
                Srno := Srno + 1;
            end;

            trigger OnPreDataItem();
            begin
                Lookup_B2B.SETRANGE("LookupType Name", AddAndDedTextTxt);
            end;
        }
    }

    requestpage
    {
        Caption = 'Pay Elements List';

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

    trigger OnInitReport();
    begin
        Srno := 0;
    end;

    trigger OnPreReport();
    begin
        EmpFilter := Lookup_B2B.GETFILTERS();
    end;

    var
        Srno: Integer;
        EmpFilter: Text;
        List_of_Pay_ElementsCaptionLbl: Label 'Pay Elements';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Sl__No_CaptionLbl: Label 'Sr no.';
        Pay_Element_CodeCaptionLbl: Label 'Pay Element Code';
        DescriptionCaptionLbl: Label 'Description';
        Add_DeductCaptionLbl: Label 'Add/Deduct';
        App__For_OTCaptionLbl: Label 'App. For OT';
        ESICaptionLbl: Label 'ESI';
        PFCaptionLbl: Label 'PF';
        Leave_EncashmentCaptionLbl: Label 'Leave Encashment';
        Payroll_Prod__Posting_GroupCaptionLbl: Label 'Payroll Prod. Posting Group';
        RemarksCaptionLbl: Label 'Remarks';
        AddAndDedTextTxt: Label 'ADDITIONS AND DEDUCTIONS';
}

