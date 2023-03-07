report 33001245 "Employee CTC-1 B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee CTC-1';
    //Permissions = TableData TableData33001282 = rimd; //Sravan
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                BasicAmt := 0;
                HRAAmt := 0;
                ESiAmt := 0;
                CAAmt := 0;
                CCAAmt := 0;
                SpelAlAmt := 0;
                FDAAmt := 0;
                VDAAmt := 0;
                WAAmt := 0;
                MEDAmt := 0;
                STIPENDAmt := 0;
                CONREIMAmt := 0;
                PFAmt := 0;
                TotalAmt := 0;
                ProcessedSalary.SETRANGE(ProcessedSalary."Employee Code", "Employee B2B"."No.");
                ProcessedSalary.SETRANGE(ProcessedSalary."Pay Slip Month", MonthGVar);
                ProcessedSalary.SETRANGE(ProcessedSalary.Year, YrGVar);
                if ProcessedSalary.FINDFIRST() then
                    repeat
                        case ProcessedSalary."Add/Deduct Code" of
                            BASICTxt:
                                begin
                                    BasicAmt := ProcessedSalary."Earned Amount";
                                    if not "Employee B2B"."ESI Applicable" then
                                        MEDAmt := (ProcessedSalary."Earned Amount" / 12);
                                end;
                            HRATxt:
                                HRAAmt := ProcessedSalary."Earned Amount";
                            CATxt:
                                CAAmt := ProcessedSalary."Earned Amount";
                            CCATxt:
                                CCAAmt := ProcessedSalary."Earned Amount";
                            SPELALLTxt:
                                SpelAlAmt := ProcessedSalary."Earned Amount";
                            FDATxt:
                                FDAAmt := ProcessedSalary."Earned Amount";
                            VDATxt:
                                VDAAmt := ProcessedSalary."Earned Amount";
                            WATxt:
                                WAAmt := ProcessedSalary."Earned Amount";
                            STIPENDTxt:
                                STIPENDAmt := ProcessedSalary."Earned Amount";
                            CONREIMTxt:
                                CONREIMAmt := ProcessedSalary."Earned Amount";
                            PFTxt:
                                PFAmt := ProcessedSalary."Earned Amount";
                            ESITxt:
                                ESiAmt := ProcessedSalary."Co. Contributions" + ProcessedSalary."Co. Contribution2";
                        end;
                    until ProcessedSalary.NEXT() = 0;

                TotalAmt := BasicAmt + HRAAmt + ESiAmt + CAAmt + CCAAmt + PFAmt + SpelAlAmt + FDAAmt +
                            VDAAmt + WAAmt + MEDAmt + STIPENDAmt + CONREIMAmt;

                DialogBox.UPDATE(1, "Employee B2B"."No.");
                EmployeeCTC.Init();

                EmployeeCTC."Emp Code" := "No.";

                EmployeeCTC."First Name" := "First Name";
                EmployeeCTC."Middle Name" := "Middle Name";
                EmployeeCTC."Last Name" := "Last Name";
                EmployeeCTC.Month := MonthGVar;
                EmployeeCTC.year := YrGVar;
                EmployeeCTC.Basic := BasicAmt;
                EmployeeCTC.HRA := HRAAmt;
                EmployeeCTC.CA := CAAmt;
                EmployeeCTC.CCA := CCAAmt;
                EmployeeCTC.WA := WAAmt;
                EmployeeCTC.FDA := FDAAmt;
                EmployeeCTC.VDA := VDAAmt;
                EmployeeCTC."SPEL ALL" := SpelAlAmt;
                EmployeeCTC.PF := PFAmt;
                EmployeeCTC.ESI := ESiAmt;
                EmployeeCTC.Medical := MEDAmt;
                EmployeeCTC.Stipend := STIPENDAmt;
                EmployeeCTC.Conreim := CONREIMAmt;
                EmployeeCTC.Total := TotalAmt;
                EmployeeCTC.INSERT();
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                SETRANGE("Employee B2B".Blocked, false);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Month; MonthGVar)
                {
                    ToolTip = 'Choose the for which month Employee CTC report need to generate.';
                    Caption = 'Month';
                    ApplicationArea = all;
                }
                field(Yr; YrGVar)
                {
                    ToolTip = 'Choose the for which year Employee CTC report need to generate.';
                    Caption = 'Year';
                    ApplicationArea = all;
                }
            }
        }

        actions
        {
        }
    }



    trigger OnPostReport();
    begin
        DialogBox.CLOSE();
        MESSAGE(Text002Txt);
    end;

    trigger OnPreReport();
    begin
        if EmployeeCTC.FINDFIRST() then
            EmployeeCTC.DELETEALL();
        if (MonthGVar = 0) or (YrGVar = 0) then
            ERROR(Text001Txt);
        DialogBox.OPEN(Text003Txt);
    end;

    var
        ProcessedSalary: Record "Processed Salary B2B";
        EmployeeCTC: Record "Employee CTC B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        BasicAmt: Decimal;
        HRAAmt: Decimal;
        PFAmt: Decimal;
        ESiAmt: Decimal;
        CAAmt: Decimal;
        CCAAmt: Decimal;
        SpelAlAmt: Decimal;
        FDAAmt: Decimal;
        VDAAmt: Decimal;
        WAAmt: Decimal;
        MEDAmt: Decimal;
        STIPENDAmt: Decimal;
        CONREIMAmt: Decimal;
        TotalAmt: Decimal;

        MonthGVar: Integer;
        YrGVar: Integer;

        Text001Txt: Label 'Please specify Month and Year';
        Text002Txt: Label 'Employee CTC updated successfully';
        DialogBox: Dialog;
        Text003Txt: Label 'Updating Employee #1#########', Comment = '%1 = No';
        BASICTxt: Label 'BASIC';
        HRATxt: Label 'HRA';
        CATxt: Label 'CA';
        CCATxt: Label 'CCA';
        SPELALLTxt: Label 'SPELALL';
        FDATxt: Label 'FDA';
        VDATxt: Label 'VDA';
        WATxt: Label 'WA';
        STIPENDTxt: Label 'STIPEND';
        CONREIMTxt: Label 'CONREIM';
        PFTxt: Label 'PF';
        ESITxt: Label 'ESI';
}

