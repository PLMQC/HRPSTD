report 33001241 "Bonus Register B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Bonus Register.rdl';
    Caption = 'Bonus Register';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Bonus Adjust"; "Bonus Adjust B2B")
        {
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            /*
             column(CurrReport_PAGENO; CurrReport.PAGENO)
             {
             }*/
            column(USERID; USERID())
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(Bonus_Adjust__Employee_Code_; "Employee Code")
            {
            }
            column(Bonus_Adjust__Employee_Name_; "Employee Name")
            {
            }
            column(Bonus_Adjust__Pay_Element_Code_; "Pay Element Code")
            {
            }
            column(Bonus_Adjust__Bonus_Adjust___Bonus_Exgratia_Amt_; "Bonus Adjust"."Bonus/Exgratia Amt")
            {
            }
            column(Bonus_Adjust__Additional_Bonus_; "Additional Bonus")
            {
            }
            column(Bonus_Adjust_Adjustments; Adjustments)
            {
            }
            column(Bonus_Adjust__Net_Payable_; "Net Payable")
            {
            }
            column(Slno; Slno)
            {
            }
            column(Bonus_Adjust__Bonus_Adjust___Exgratia_Amt_; "Bonus Adjust"."Exgratia Amt")
            {
            }
            column(Bonus_Adjust__Additional_Bonus__Control1102154029; "Additional Bonus")
            {
            }
            column(Bonus_Adjust__Bonus_Adjust___Exgratia_Amt__Control1102154030; "Bonus Adjust"."Exgratia Amt")
            {
            }
            column(Bonus_Adjust_Adjustments_Control1102154032; Adjustments)
            {
            }
            column(Bonus_Adjust__Bonus_Adjust___Bonus_Exgratia_Amt__Control1102154034; "Bonus Adjust"."Bonus/Exgratia Amt")
            {
            }
            column(Bonus_Adjust__Bonus_Adjust___Exgratia_Amt__Control1102154035; "Bonus Adjust"."Exgratia Amt")
            {
            }
            column(Bonus_Adjust__Additional_Bonus__Control1102154036; "Additional Bonus")
            {
            }
            column(Bonus_Adjust_Adjustments_Control1102154037; Adjustments)
            {
            }
            column(Bonus_Adjust__Net_Payable__Control1102154042; "Net Payable")
            {
            }
            column(Bonus_Adjust__Bonus_Adjust___Exgratia_Amt__Control1102154002; "Bonus Adjust"."Exgratia Amt")
            {
            }
            column(Bonus_Adjust__Additional_Bonus__Control1102154015; "Additional Bonus")
            {
            }
            column(Bonus_Adjust_Adjustments_Control1102154027; Adjustments)
            {
            }
            column(Bonus_RegisterCaption; Bonus_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Emp_No_Caption; Emp_No_CaptionLbl)
            {
            }
            column(Emp_NameCaption; Emp_NameCaptionLbl)
            {
            }
            column(Pay_Element_CodeCaption; Pay_Element_CodeCaptionLbl)
            {
            }
            column(Bonus_AmtCaption; Bonus_AmtCaptionLbl)
            {
            }
            column(Aditional_BonusCaption; Aditional_BonusCaptionLbl)
            {
            }
            column(AdjustmentsCaption; AdjustmentsCaptionLbl)
            {
            }
            column(Arr_BonusCaption; Arr_BonusCaptionLbl)
            {
            }
            column(Arr_ExgtCaption; Arr_ExgtCaptionLbl)
            {
            }
            column(Adv_BonusCaption; Adv_BonusCaptionLbl)
            {
            }
            column(Net_PayableCaption; Net_PayableCaptionLbl)
            {
            }
            column(Ex_Gratia_AmtCaption; Ex_Gratia_AmtCaptionLbl)
            {
            }
            column(Sl_No_Caption; Sl_No_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Bonus_Adjust_Month; Month)
            {
            }
            column(Bonus_Adjust_Year; Year)
            {
            }
            column(Bonus_Adjust_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                B2BEmpGRec.RESET();
                B2BEmpGRec.SETRANGE("No.", "Bonus Adjust"."Employee Code");
                B2BEmpGRec.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                if not B2BEmpGRec.FINDFIRST() then
                    CurrReport.SKIP();
                Slno += 1;
            end;
        }
    }

    requestpage
    {
        Caption = 'Bonus Register';

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
        CLEAR(Slno);
    end;

    var
        B2BEmpGRec: Record "Employee B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Slno: Integer;
        Bonus_RegisterCaptionLbl: Label 'Bonus Register';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Emp_No_CaptionLbl: Label 'Emp No.';
        Emp_NameCaptionLbl: Label 'Emp Name';
        Pay_Element_CodeCaptionLbl: Label 'Pay Element Code';
        Bonus_AmtCaptionLbl: Label 'Bonus Amt';
        Aditional_BonusCaptionLbl: Label 'Aditional Bonus';
        AdjustmentsCaptionLbl: Label 'Adjustments';
        Arr_BonusCaptionLbl: Label 'Arr Bonus';
        Arr_ExgtCaptionLbl: Label 'Arr Exgt';
        Adv_BonusCaptionLbl: Label 'Adv Bonus';
        Net_PayableCaptionLbl: Label 'Net Payable';
        Ex_Gratia_AmtCaptionLbl: Label 'Ex-Gratia Amt';
        Sl_No_CaptionLbl: Label 'Sl No.';
        TotalCaptionLbl: Label 'Total';

    procedure GetMonthandYear(Month1: Integer; Year1: Integer);
    begin
        "Bonus Adjust".SETRANGE(Month, Month1);
        "Bonus Adjust".SETRANGE(Year, Year1);
    end;
}

