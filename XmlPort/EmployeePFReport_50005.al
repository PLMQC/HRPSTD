xmlport 50005 EmployeePFReport
{
    Caption = 'EmployeePFReport';

    Direction = Export;
    FieldSeparator = '#~#';
    TextEncoding = UTF8;
    //TextEncoding = MSDOS;
    UseRequestPage = false;
    Format = VariableText;
    RecordSeparator = '<NewLine>';
    TableSeparator = '';
    DefaultFieldsValidation = true;
    FieldDelimiter = '';
    PreserveWhiteSpace = false;
    schema
    {
        textelement(root)
        {
            tableelement("Employeeb2b"; "Employee B2B")
            {
                XmlName = 'Employeeb2b';
                RequestFilterFields = "No.";
                tableelement("MonthlyAttendanceB2B"; "Monthly Attendance B2B")
                {
                    XmlName = 'MonthlyAttendanceb2b';
                    RequestFilterFields = "Pay Slip Month", Year;
                    LinkTable = Employeeb2b;
                    LinkFields = "Employee Code" = field("No.");
                    fieldelement(UAN_No; Employeeb2b."UAN No.")
                    {

                    }
                    fieldelement(FirstName; Employeeb2b."First Name")
                    {

                    }
                    /*fieldelement(GrossSalary; MonthlyAttendanceB2B."Gross Salary")
                    {

                    }*/
                    textelement(GrossSalary)
                    {


                    }


                    textelement(PfAmount)
                    {


                    }
                    textelement(pfamount1)
                    {

                    }
                    textelement(pfamount2)
                    {

                    }


                    textelement(EPFContriremitt)
                    {

                    }

                    textelement(EPFEPSDiff)
                    {


                    }
                    textelement(EPSContriremitt)
                    {

                    }

                    textelement(LossOfpay)
                    {

                    }

                    textelement(Refundofadvance)
                    {


                    }



                    trigger OnAfterGetRecord()
                    var
                        LookupRec: Record Lookup_B2B;
                        ProcessSalary: Record "Processed Salary B2B";
                    begin
                        Clear(PfAmount);
                        clear(EPFContriremitt);
                        Clear(EPSContriremitt);
                        Clear(EPFEPSDiff);
                        clear(GrossSalary1);
                        clear(GrossSalary);
                        Clear(LossOfPay);
                        clear(PfAmount1);
                        clear(PfAmount2);

                        LookupRec.Reset();
                        LookupRec.SetRange("Lookup Type", 16);
                        LookupRec.SetRange(PF, true);
                        if LookupRec.FindSet() then
                            repeat
                                ProcessSalary.Reset();
                                ProcessSalary.SetRange("Employee Code", MonthlyAttendanceB2B."Employee Code");
                                ProcessSalary.SetRange(Year, MonthlyAttendanceB2B.Year);
                                ProcessSalary.SetRange("Pay Slip Month", MonthlyAttendanceB2B."Pay Slip Month");
                                ProcessSalary.SetRange("Add/Deduct Code", LookupRec."Lookup Name");
                                if ProcessSalary.FindFirst() then
                                    GrossSalary1 += ProcessSalary."Earned Amount";

                            until LookupRec.Next() = 0;


                        PFAmountt(MonthlyAttendanceB2B, GrossSalary1);
                        MonthlyAttendanceB2B.CalcFields("Gross Salary");
                        GrossSalary := format(MonthlyAttendanceB2B."Gross Salary");
                        if StrPos(GrossSalary, '.') <> 0 then
                            GrossSalary := CopyStr(GrossSalary, 1, StrPos(GrossSalary, '.') - 1);
                        GrossSalary := DelChr(GrossSalary, '=', ',');
                        Refundofadvance := '0';
                        MonthlyAttendanceB2B.CalcFields("Loss Of Pay");
                        LossOfPay := Format(MonthlyAttendanceB2B."Loss Of Pay");
                        if StrPos(LossOfPay, '.') <> 0 then
                            LossOfPay := CopyStr(LossOfPay, 1, StrPos(LossOfPay, '.') - 1);
                        LossOfPay := DelChr(LossOfPay, '=', ',');

                        if StrPos(EPFContriremitt, '.') <> 0 then
                            EPFContriremitt := CopyStr(EPFContriremitt, 1, StrPos(EPFContriremitt, '.') - 1);
                        EPFContriremitt := DelChr(EPFContriremitt, '=', ',');

                        if StrPos(EPSContriremitt, '.') <> 0 then
                            EPSContriremitt := CopyStr(EPSContriremitt, 1, StrPos(EPSContriremitt, '.') - 1);
                        EPSContriremitt := DelChr(EPSContriremitt, '=', ',');

                        if StrPos(EPFEPSDiff, '.') <> 0 then
                            EPFEPSDiff := CopyStr(EPFEPSDiff, 1, StrPos(EPFEPSDiff, '.') - 1);
                        EPFEPSDiff := DelChr(EPFEPSDiff, '=', ',');

                        PayElements.Reset();
                        PayElements.SetRange("Employee Code", Employeeb2b."No.");
                        PayElements.SetRange(PF, true);
                        if PayElements.FindSet() then begin
                            repeat
                                ProcessedSalary.Reset();
                                ProcessedSalary.SetRange("Add/Deduct Code", PayElements."Pay Element Code");
                                ProcessedSalary.SetRange("Employee Code", PayElements."Employee Code");
                                if ProcessedSalary.Findset() then begin
                                    ProcessedSalary.CalcSums("Earned Amount");

                                    PfAmount += Format(ProcessedSalary."Earned Amount");
                                    pfamount1 := PfAmount;
                                    pfamount2 := PfAmount;
                                end;
                            until PayElements.Next = 0;
                        end;

                        if StrPos(PfAmount, '.') <> 0 then
                            PfAmount := CopyStr(PfAmount, 1, StrPos(PfAmount, '.') - 1);
                        PfAmount := DelChr(PfAmount, '=', ',');
                        if StrPos(pfamount1, '.') <> 0 then
                            pfamount1 := CopyStr(pfamount1, 1, StrPos(pfamount1, '.') - 1);
                        pfamount1 := DelChr(pfamount1, '=', ',');
                        if StrPos(pfamount2, '.') <> 0 then
                            pfamount2 := CopyStr(pfamount2, 1, StrPos(pfamount2, '.') - 1);
                        pfamount2 := DelChr(pfamount2, '=', ',');



                    end;

                }

            }
        }
    }


    requestpage
    {
        layout
        {
            area(content)
            {
                /*group(GroupName)
                {
                    field(Name; SourceExpression)
                    {

                    }
                }*/
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }

    var
        myInt: Integer;
        PayElements: Record "Pay Elements B2B";
        ProcessedSalary: Record "Processed Salary B2B";
        VAD2: Record "Pay Elements B2B";

        EDLIGross: Decimal;
        MonAttendance: Record "Monthly Attendance B2B";
        GrossSalary1: decimal;
        GrossSalary2: Decimal;

    procedure PFAmountt(MonAttendance: Record "Monthly Attendance B2B";
     GrossAmount: Decimal);

    var
        PF: Record PF_B2B;
        EmployeeLocal: Record "Employee B2B";
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        EPSAmount: Decimal;
        PFAdminCharges: Decimal;
        EDLICharges: Decimal;
        // RIFACharges: Decimal;
        NewGrossAmount: Decimal;
        EPSMax: Decimal;
    begin
        if PF.FINDFIRST() then begin
            repeat
                if GrossAmount < PF."PF Amount" then
                    NewGrossAmount := GrossAmount
                else
                    NewGrossAmount := PF."PF Amount";
                if EmployeeLocal.GET(MonAttendance."Employee Code") then
                    if EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::"Actual Salary" then
                        if GrossAmount > PF."PF Amount" then
                            NewGrossAmount := GrossAmount;
                if PF."Effective Date" <= MonAttendance."Period End Date" then
                    case PF."Rounding Method" of
                        PF."Rounding Method"::Nearest:
                            begin
                                PF.TESTFIELD("Rounding Amount");
                                EPSAmount := ROUND((NewGrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                EPSMax := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                if EPSAmount > EPSMax then
                                    EPSAmount := EPSMax;
                                EPFEPSDiff := Format(ROUND((NewGrossAmount * (PF."EPS %")) / 100, PF."Rounding Amount", '='));
                                EPSContriremitt := format(ROUND((NewGrossAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '='));
                                EPFContriremitt := Format(ROUND((NewGrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '='));

                            end;
                        PF."Rounding Method"::Up:
                            begin
                                PF.TESTFIELD("Rounding Amount");
                                EPSAmount := ROUND((NewGrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                EPSMax := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                if EPSAmount > EPSMax then
                                    EPSAmount := EPSMax;
                                EPFEPSDiff := Format(ROUND((NewGrossAmount * (PF."EPS %")) / 100, PF."Rounding Amount", '>'));
                                EPSContriremitt := format(ROUND((NewGrossAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '>'));
                                EPFContriremitt := Format(ROUND((NewGrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>'));
                            end;
                        else begin
                                PF.TESTFIELD("Rounding Amount");
                                EPSAmount := ROUND((NewGrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                EPSMax := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                if EPSAmount > EPSMax then
                                    EPSAmount := EPSMax;
                                EPFEPSDiff := Format(ROUND((NewGrossAmount * (PF."EPS %")) / 100, PF."Rounding Amount", '<'));
                                EPSContriremitt := format(ROUND((NewGrossAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '<'));
                                EPFContriremitt := Format(ROUND((NewGrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<'));
                            end;
                    end;

                if EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::"Employee Specific" then
                    EmployeeContribution := EmployeeLocal."PF Amount";

            until PF.NEXT() = 0;


        end;
    end;








}