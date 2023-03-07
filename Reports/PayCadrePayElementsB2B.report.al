report 33001203 "Pay Cadre-Pay Elements B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Pay Cadre-Pay Elements.rdl';
    Caption = 'Pay Cadre-Pay Elements';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Pay Cadre Pay Element"; "Pay Cadre Pay Element B2B")
        {
            DataItemTableView = SORTING("Pay Cadre Code", "Effective Start Date", "Pay Element Code");
            RequestFilterFields = "Pay Cadre Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(USERID; USERID())
            {
            }
            column(Pay_Cadre_Pay_Element__Pay_Cadre_Code_; "Pay Cadre Code")
            {
            }
            column(Pay_Cadre_Pay_Element__Pay_Element_Code_; "Pay Element Code")
            {
            }
            column(Pay_Cadre_Pay_Element__Fixed_Percent_; "Fixed/Percent")
            {
            }
            column(Pay_Cadre_Pay_Element__Computation_Type_; "Computation Type")
            {
            }
            column(Pay_Cadre_Pay_Element__Effective_Start_Date_; "Effective Start Date")
            {
            }
            column(Pay_Cadre_Pay_Element__Amount___Percent_; "Amount / Percent")
            {
            }
            column(Pay_Cadre_Pay_Element__Add_Deduct_; "Add/Deduct")
            {
            }
            column(Pay_Cadre__Pay_ElementsCaption; Pay_Cadre__Pay_ElementsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Pay_Cadre_Caption; Pay_Cadre_CaptionLbl)
            {
            }
            column(Pay_Cadre_Pay_Element__Pay_Element_Code_Caption; FIELDCAPTION("Pay Element Code"))
            {
            }
            column(Pay_Cadre_Pay_Element__Fixed_Percent_Caption; FIELDCAPTION("Fixed/Percent"))
            {
            }
            column(Pay_Cadre_Pay_Element__Computation_Type_Caption; FIELDCAPTION("Computation Type"))
            {
            }
            column(Pay_Cadre_Pay_Element__Effective_Start_Date_Caption; FIELDCAPTION("Effective Start Date"))
            {
            }
            column(Pay_Cadre_Pay_Element__Amount___Percent_Caption; FIELDCAPTION("Amount / Percent"))
            {
            }
            column(Pay_Cadre_Pay_Element__Add_Deduct_Caption; FIELDCAPTION("Add/Deduct"))
            {
            }
            column(Amount___Percent; "Amount / Percent")
            { }
            column(Amount_Percent_Cap; Amount_Percent_Cap)
            { }

        }
    }

    requestpage
    {
        Caption = 'Pay Cadre-Pay Elements';

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
        Pay_Cadre__Pay_ElementsCaptionLbl: Label 'Pay Elements';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Pay_Cadre_CaptionLbl: Label 'Pay Cadre';
        Amount_Percent_Cap: Label 'Amount / Percent';

}

