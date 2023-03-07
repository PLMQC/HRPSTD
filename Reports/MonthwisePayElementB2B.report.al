report 33001202 "Month wise Pay Element B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Month wise Pay Element.rdlc';
    Caption = 'Month wise Pay Element';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Processed Salary"; "Processed Salary B2B")
        {
            DataItemTableView = SORTING("Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.") ORDER(Ascending);
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
            column(MonthName; MonthName)
            {
            }
            column(CurrYear; CurrYear)
            {
            }
            column(Selection; Selection)
            {
            }
            column(Processed_Salary__Employee_Code_; "Employee Code")
            {
            }
            column(Processed_Salary__Earned_Amount_; "Earned Amount")
            {
            }
            column(Name; Name)
            {
            }
            column(Processed_Salary__Add_Deduct_Code_; "Add/Deduct Code")
            {
            }
            column(Processed_Salary__Pay_Cadre_; "Pay Cadre")
            {
            }
            column(Processed_Salary__Earned_Amount__Control1102152065; "Earned Amount")
            {
            }
            column(Statement_ofCaption; Statement_ofCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(for_the_Month_of_Caption; for_the_Month_of_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(Pay_ElementCaption; Pay_ElementCaptionLbl)
            {
            }
            column(Emp_No_Caption; Emp_No_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(L__CodeCaption; L__CodeCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Processed_Salary_Document_Type; "Document Type")
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
                if Emp.GET("Employee Code") then
                    Name := Emp."First Name" + ' ' + Emp."Last Name";
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                SETRANGE("Pay Slip Month", MonthNo);
                SETRANGE(Year, CurrYear);
                SETFILTER("Processed Salary"."Add/Deduct Code", Selection);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102152000)
                {
                    field(Month; MonthName)
                    {
                        ToolTip = 'Select the month for which you want run the report.';
                        Caption = 'Month';
                        OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
                        ApplicationArea = all;
                    }
                    field(Year; CurrYear)
                    {
                        ToolTip = 'Select the year for which you want to run the report.';
                        Caption = 'Year';
                        ApplicationArea = all;
                    }
                    field("PayElement Code"; Selection)
                    {
                        ToolTip = 'Select the pay element code for which you want see.';
                        Caption = 'PayElement Code';
                        ApplicationArea = all;

                        trigger OnLookup(var Text: Text): Boolean;
                        begin
                            Lookup_rec.SETRANGE(Lookup_rec."Lookup Id", 16);
                            if PAGE.RUNMODAL(0, Lookup_rec) = ACTION::LookupOK then
                                Selection := Lookup_rec."Lookup Name";
                        end;
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

    trigger OnPreReport();
    begin
        if (MonthName = 0) then
            ERROR(Text0001Txt);
        if CurrYear = 0 then
            ERROR(Text0002Txt);

        case MonthName of
            1:
                MonthNo := 1;
            2:
                MonthNo := 2;
            3:
                MonthNo := 3;
            4:
                MonthNo := 4;
            5:
                MonthNo := 5;
            6:
                MonthNo := 6;
            7:
                MonthNo := 7;
            8:
                MonthNo := 8;
            9:
                MonthNo := 9;
            10:
                MonthNo := 10;
            11:
                MonthNo := 11;
            12:
                MonthNo := 12;
        end;
    end;

    var

        Emp: Record "Employee B2B";
        Lookup_rec: Record Lookup_B2B;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Name: Text[100];
        Selection: Code[20];
        Text0001Txt: Label 'The month value cannot be left blank please choose a month.';
        Text0002Txt: Label 'The year value cannot be left blank please choose a year.';
        MonthName: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        CurrYear: Integer;
        MonthNo: Integer;
        Statement_ofCaptionLbl: Label 'Statement of';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        for_the_Month_of_CaptionLbl: Label '"for the Month of "';
        NameCaptionLbl: Label 'Name';
        GradeCaptionLbl: Label 'Grade';
        Pay_ElementCaptionLbl: Label 'Pay Element';
        Emp_No_CaptionLbl: Label 'Emp No.';
        AmountCaptionLbl: Label 'Amount';
        L__CodeCaptionLbl: Label 'L. Code';
        TotalCaptionLbl: Label 'Total';
}

