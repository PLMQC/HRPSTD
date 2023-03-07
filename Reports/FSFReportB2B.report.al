report 33001264 "FSF Report B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\FSF Report.rdl';
    Caption = 'Final Settlement Report';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Final Settlement Header"; "Final Settlement Header B2B")
        {
            DataItemTableView = SORTING("Employee No.");
            RequestFilterFields = "Employee No.";
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City__________CompanyInfo__Post_Code_; CompanyInfo.City + ' - ' + CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_Address_________CompanyInfo__Address_2__; CompanyInfo.Address + ' ' + CompanyInfo."Address 2")
            {
            }
            column(DeducationCaptionLbl; DeducationCaptionLbl)
            {

            }
            column(Deduction_AmountCaptionLbl; Deduction_AmountCaptionLbl)
            {

            }
            column(DGM___HRCaption; DGM___HRCaptionLbl)
            {
            }
            column(Net_AmountCaption; Net_AmountCaptionLbl)
            {
            }
            column(AGM_FINANCECaption; AGM_FINANCECaptionLbl)
            {
            }
            column(CFOCaption; CFOCaptionLbl)
            {
            }
            column(DIRECTORCaption; DIRECTORCaptionLbl)
            {
            }
            column(Prepared_ByCaption; Prepared_ByCaptionLbl)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Final_Settlement_Header__Employee_Name_; "Employee Name")
            {
            }
            column(Month; Month)
            {

            }
            column(EmpRec_Designation; EmpRec.Designation)
            {
            }
            column(EmpRec__Employment_Date_; EmpRec."Employment Date")
            {
            }
            column(EmpRec__PF_No_; EmpRec."PF No")
            {
            }
            column(EmpRec__Department_Code_; EmpRec."Department Code")
            {
            }
            column(Final_Settlement_Header__Final_Settlement_Header___Date_of_Leaving_; "Final Settlement Header"."Date of Leaving")
            {
            }
            column(Final_Settlement_Header__Final_Settlement_Header___Attended_Days_; "Final Settlement Header"."Attended Days")
            {
            }
            column(EmpRec__No__; EmpRec."No.")
            {
            }
            column(Month2; Month2)
            {
            }
            column(FULL___FINAL_SETTLEMENTCaption; FULL___FINAL_SETTLEMENTCaptionLbl)
            {
            }
            column(Final_Settlement_Header__Employee_Name_Caption; FIELDCAPTION("Employee Name"))
            {
            }
            column(EmpRec_DesignationCaption; EmpRec_DesignationCaptionLbl)
            {
            }
            column(EmpRec__Employment_Date_Caption; EmpRec__Employment_Date_CaptionLbl)
            {
            }
            column(EmpRec__PF_No_Caption; EmpRec__PF_No_CaptionLbl)
            {
            }
            column(EmpRec__Department_Code_Caption; EmpRec__Department_Code_CaptionLbl)
            {
            }
            column(Final_Settlement_Header__Final_Settlement_Header___Date_of_Leaving_Caption; Final_Settlement_Header__Final_Settlement_Header___Date_of_Leaving_CaptionLbl)
            {
            }
            column(NSSN_No_Caption; NSSN_No_CaptionLbl)
            {
            }
            column(Final_Settlement_Header__Final_Settlement_Header___Attended_Days_Caption; Final_Settlement_Header__Final_Settlement_Header___Attended_Days_CaptionLbl)
            {
            }
            column(Emp_CodeCaption; Emp_CodeCaptionLbl)
            {
            }
            column(Salary_for_The_Month_ofCaption; Salary_for_The_Month_ofCaptionLbl)
            {
            }
            column(AdditionsCaption; AdditionsCaptionLbl)
            {
            }
            column(EarningsCaption; EarningsCaptionLbl)
            {
            }
            column(Actual_PayableCaption; Actual_PayableCaptionLbl)
            {
            }
            column(Final_Settlement_Header_Employee_No_; "Employee No.")
            {
            }
            dataitem("Final Settlement Line"; "Final Settlement Line B2B")
            {
                DataItemLink = "Employee No." = FIELD("Employee No.");
                DataItemTableView = SORTING("Employee No.", "Line No.") WHERE("Addition/Deduction" = CONST(Addition));
                column(Final_Settlement_Line__Pay_Element_Code_; "Pay Element Code")
                {
                }
                column(Final_Settlement_Line_Amount; Amount)
                {
                }
                column(PayElementAmt; PayElementAmt)
                {
                }
                column(FORMAT__From_date____to__FORMAT__To_date__; FORMAT("From date") + 'to' + FORMAT("To date"))
                {
                }
                column(Final_Settlement_Line__Pay_Element_Code__Control1102152004; "Pay Element Code")
                {
                }
                column(FORMAT__Final_Settlement_Line___Bonus_Days____Days_; FORMAT("Final Settlement Line"."Bonus Days") + 'Days')
                {
                }
                column(Final_Settlement_Line_Amount_Control1102152015; Amount)
                {
                }
                column(FORMAT__From_date; FORMAT("From date"))
                {
                }
                column(Final_Settlement_Line_Amount_Control1102152032; Amount)
                {
                }
                column(Total_AmountCaptionLbl; Total_AmountCaptionLbl)
                {
                }
                column(Final_Settlement_Line_Employee_No_; "Employee No.")
                {
                }
                column(Final_Settlement_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    EmpRec.Get("Employee No.");
                    CompanyInfo.Get();
                    CompanyInfo.CalcFields(Picture);
                    CLEAR(PayElementAmt);
                    PayElements.RESET();
                    PayElements.SETRANGE("Employee Code", "Final Settlement Line"."Employee No.");
                    PayElements.SETRANGE("Pay Element Code", "Final Settlement Line"."Pay Element Code");
                    if PayElements.FINDLAST() then
                        PayElementAmt := PayElements."Amount / Percent";
                end;
            }
        }
        dataitem("Final Settlement HeaderD"; "Final Settlement Header B2B")
        {
            DataItemTableView = SORTING("Employee No.");
            // column(DeducationCaption; DeducationCaptionLbl)
            // {
            // }
            column(Final_Settlement_HeaderD_Employee_No_; "Employee No.")
            {
            }
            dataitem("Final Settlement LineD"; "Final Settlement Line B2B")
            {
                DataItemLink = "Employee No." = FIELD("Employee No.");
                DataItemTableView = SORTING("Employee No.", "Line No.") WHERE("Addition/Deduction" = CONST(Deduction));
                column(Final_Settlement_LineD_Amount; Amount)
                {
                }
                column(Final_Settlement_LineD__Pay_Element_Code_; "Pay Element Code")
                {
                }
                column(Final_Settlement_LineD_Amount_Total; Amount)
                {
                }
                column(TotalAdd_TotalDed; '')
                {
                }
                //column(Net_AmountCaption; Net_AmountCaptionLbl)
                //{
                //}
                //column(Deduction_AmountCaption; Deduction_AmountCaptionLbl)
                // {
                //}
                //column(DGM___HRCaption; DGM___HRCaptionLbl)
                // {
                //}
                //column(AGM_FINANCECaption; AGM_FINANCECaptionLbl)
                //{
                // }
                //column(CFOCaption; CFOCaptionLbl)
                //{
                //}
                //column(DIRECTORCaption; DIRECTORCaptionLbl)
                // {
                //}
                //column(Prepared_ByCaption; Prepared_ByCaptionLbl)
                //{
                //}
                column(Final_Settlement_LineD_Employee_No_; "Employee No.")
                {
                }
                column(Final_Settlement_LineD_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(PayElementAmt);
                    PayElements.RESET();
                    PayElements.SETRANGE("Employee Code", "Final Settlement Line"."Employee No.");
                    PayElements.SETRANGE("Pay Element Code", "Final Settlement Line"."Pay Element Code");
                    if PayElements.FINDLAST() then
                        PayElementAmt := PayElements."Amount / Percent";
                end;
            }

            trigger OnPreDataItem();
            begin
                SETRANGE("Employee No.", "Final Settlement Header"."Employee No.");
            end;
        }
    }

    requestpage
    {
        Caption = 'FSF Report';

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
        EmpRec: Record "Employee B2B";
        PayElements: Record "Pay Elements B2B";
        CompanyInfo: Record "Company Information";
        PayElementAmt: Decimal;
        Month2: Text[30];
        FULL___FINAL_SETTLEMENTCaptionLbl: Label 'FULL & FINAL SETTLEMENT';
        EmpRec_DesignationCaptionLbl: Label 'Designation';
        EmpRec__Employment_Date_CaptionLbl: Label 'Date of Joining';
        EmpRec__PF_No_CaptionLbl: Label 'PF No.';
        EmpRec__Department_Code_CaptionLbl: Label 'Department';
        Final_Settlement_Header__Final_Settlement_Header___Date_of_Leaving_CaptionLbl: Label 'Date of Leaving';
        NSSN_No_CaptionLbl: Label 'NSSN No.';
        Final_Settlement_Header__Final_Settlement_Header___Attended_Days_CaptionLbl: Label 'No. of Days Present';
        Emp_CodeCaptionLbl: Label 'Emp Code';
        Salary_for_The_Month_ofCaptionLbl: Label 'Salary for The Month of';
        AdditionsCaptionLbl: Label 'Additions';
        EarningsCaptionLbl: Label 'Earnings';
        Actual_PayableCaptionLbl: Label 'Actual Payable';
        Total_AmountCaptionLbl: Label 'Total Amount';
        DeducationCaptionLbl: Label 'Deducation';
        Net_AmountCaptionLbl: Label 'Net Amount';
        Deduction_AmountCaptionLbl: Label 'Deduction Amount';
        DGM___HRCaptionLbl: Label 'DGM - HR';
        AGM_FINANCECaptionLbl: Label 'AGM FINANCE';
        CFOCaptionLbl: Label 'CFO';
        DIRECTORCaptionLbl: Label 'DIRECTOR';
        Prepared_ByCaptionLbl: Label 'Prepared By';
}

