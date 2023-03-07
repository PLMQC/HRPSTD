report 33001237 "PF Monthly Statement B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\PF Monthly Statement.rdlc';
    Caption = 'PF Monthly Statement';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.");
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(MonthName; MonthName)
            {
            }
            column(YearValue; YearValueGVar)
            {
            }
            column(TotalBasicAmt; TotalBasicAmt)
            {
            }
            column(TotalEmpShare; TotalEmpShare)
            {
            }
            column(TotalEPF; TotalEPF)
            {
            }
            column(TotalEPS; TotalEPS)
            {
            }
            column(Provident_Fund_Monthly_Statement_for_the_month_of_Caption; Provident_Fund_Monthly_Statement_for_the_month_of_CaptionLbl)
            {
            }
            column(Emp_No_Caption; Emp_No_CaptionLbl)
            {
            }
            column(SL_No_Caption; SL_No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Control1102152007Caption; Control1102152007CaptionLbl)
            {
            }
            column(Basic__VDA_FDACaption; Basic__VDA_FDACaptionLbl)
            {
            }
            column(Emp__ShareCaption; Emp__ShareCaptionLbl)
            {
            }
            column(Control1102152010Caption; Control1102152010CaptionLbl)
            {
            }
            column(Control1102152011Caption; Control1102152011CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
            dataitem("Processed Salary"; "Processed Salary B2B")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.");
                column(Employee_B2B__No__; "Employee B2B"."No.")
                {
                }
                column(SlNo; SlNo)
                {
                }
                column(Employee_B2B__First_Name__Employee_B2B__Middle_Name__Employee_B2B__Last_Name_; "Employee B2B"."First Name" + "Employee B2B"."Middle Name" + "Employee B2B"."Last Name")
                {
                }
                column(Processed_Salary_Attendance; Attendance)
                {
                }
                column(BasicAmt; BasicAmt)
                {
                }
                column(PFAmt; PFAmt)
                {
                }
                column(EPF; EPF)
                {
                }
                column(EPS; EPS)
                {
                }
                column(Processed_Salary_Document_Type; "Document Type")
                {
                }
                column(Processed_Salary_Employee_Code; "Employee Code")
                {
                }
                column(Processed_Salary_Pay_Slip_Month; "Pay Slip Month")
                {
                }
                column(Processed_Salary_Year; Year)
                {
                }
                column(Processed_Salary_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    case "Add/Deduct Code" of
                        BASICTxt:
                            BasicAmt := BasicAmt + "Earned Amount";
                        FDATxt:
                            BasicAmt := BasicAmt + "Earned Amount";
                        DATxt:
                            BasicAmt := BasicAmt + "Earned Amount";
                        VDATxt:
                            BasicAmt := BasicAmt + "Earned Amount";
                        stipendTxt:
                            BasicAmt := BasicAmt + "Earned Amount";
                    end;
                end;

                trigger OnPostDataItem();
                begin
                    PayRevisionLine.SETRANGE("No.", "Employee B2B"."No.");
                    PayRevisionLine.SETRANGE(Month, "Processed Salary"."Pay Slip Month");
                    PayRevisionLine.SETRANGE(Year, "Processed Salary".Year);
                    if PayRevisionLine.FINDFIRST() then
                        repeat
                            case PayRevisionLine."Pay Element" of
                                BASICTxt:
                                    BasicAmt := BasicAmt + PayRevisionLine."Arrear Amount";
                                FDATxt:
                                    BasicAmt := BasicAmt + PayRevisionLine."Arrear Amount";
                                DATxt:
                                    BasicAmt := BasicAmt + PayRevisionLine."Arrear Amount";
                                VDATxt:
                                    BasicAmt := BasicAmt + PayRevisionLine."Arrear Amount";
                                stipendTxt:
                                    BasicAmt := BasicAmt + PayRevisionLine."Arrear Amount";
                                PFTxt:
                                    PFAmt += PayRevisionLine."Arrear Amount";
                            end;
                        until PayRevisionLine.NEXT() = 0;

                    if PF.FINDFIRST() then;
                    EmpShare := (BasicAmt * PF."Employee Contribution") / 100;
                    if BasicAmt < PF."PF Amount" then begin
                        EPS := (BasicAmt * PF."EPS %") / 100;
                        EPF := (BasicAmt * PF."Employer Contribution") / 100;
                    end else begin
                        EPS := PF."PF Amount" * PF."EPS %" / 100;
                        EPF := (BasicAmt * PF."EPS %") / 100 + (BasicAmt * PF."Employer Contribution") / 100 - 542;
                    end;

                    PF.RESET();
                    if PF.FINDFIRST() then
                        case PF."Rounding Method" of
                            PF."Rounding Method"::Nearest:
                                begin
                                    EPS := ROUND(EPS, PF."Rounding Amount", '=');
                                    EPF := ROUND(EPF, PF."Rounding Amount", '=');
                                    EmpShare := ROUND(EmpShare, PF."Rounding Amount", '=');
                                end;
                            PF."Rounding Method"::Up:
                                begin
                                    EPS := ROUND(EPS, PF."Rounding Amount", '>');
                                    EPF := ROUND(EPF, PF."Rounding Amount", '>');
                                    EmpShare := ROUND(EmpShare, PF."Rounding Amount", '>');
                                end;
                            else begin
                                    EPS := ROUND(EPS, PF."Rounding Amount", '<');
                                    EPF := ROUND(EPF, PF."Rounding Amount", '<');
                                    EmpShare := ROUND(EmpShare, PF."Rounding Amount", '<');
                                end;
                        end;
                    SlNo := SlNo + 1;
                    PFAmt := EPS + EPF;
                    TotalEmpShare := TotalEmpShare + PFAmt;
                    TotalEPF := TotalEPF + EPF;
                    TotalEPS := TotalEPS + EPS;
                    TotalBasicAmt := TotalBasicAmt + BasicAmt;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Pay Slip Month", MonthValueGVar);
                    SETRANGE(Year, YearValueGVar);
                    BasicAmt := 0;
                end;
            }

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                SETRANGE("PF Applicable", true);
                SETRANGE(Blocked, false);
                SlNo := 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(MonthValue; MonthValueGVar)
                {
                    ToolTip = 'Choose the month for which PF Monthly statement to be generated.';
                    Caption = 'Month';
                    ApplicationArea = all;
                }
                field(YearValue; YearValueGVar)
                {
                    ToolTip = 'Choose the year for which PF Monthly statement to be generated.';
                    Caption = 'Year';
                    ApplicationArea = all;
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
        PayRevisionLine: Record "Pay Revision Line B2B";
        PF: Record PF_B2B;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        MonthValueGVar: Integer;
        YearValueGVar: Integer;
        SlNo: Integer;
        BasicAmt: Decimal;
        EmpShare: Decimal;
        EPF: Decimal;
        EPS: Decimal;
        TotalEmpShare: Decimal;
        TotalEPF: Decimal;
        TotalEPS: Decimal;
        TotalBasicAmt: Decimal;
        MonthName: Text[30];
        PFAmt: Decimal;
        Provident_Fund_Monthly_Statement_for_the_month_of_CaptionLbl: Label '"Provident Fund Monthly Statement for the month of "';
        Emp_No_CaptionLbl: Label 'Emp No.';
        SL_No_CaptionLbl: Label 'SL No.';
        NameCaptionLbl: Label 'Name';
        Control1102152007CaptionLbl: Label 'Attendane';
        Basic__VDA_FDACaptionLbl: Label 'Basic +VDA+FDA';
        Emp__ShareCaptionLbl: Label 'Emp. Share';
        Control1102152010CaptionLbl: Label 'EPF';
        Control1102152011CaptionLbl: Label 'EPS';
        TotalCaptionLbl: Label 'Total';
        BASICTxt: Label 'BASIC';
        FDATxt: Label 'FDA';
        DATxt: Label 'DA';
        VDATxt: Label 'VDA';
        stipendTxt: Label 'stipend';
        PFTxt: Label 'PF';
}

