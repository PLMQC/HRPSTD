report 50001 EmployeePFReport
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    caption = 'Employee PFReport';

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            RequestFilterFields = "No.";


            dataitem("Monthly Attendance B2B"; "Monthly Attendance B2B")
            {
                RequestFilterFields = "Pay Slip Month", Year;
                DataItemLink = "Employee Code" = field("No.");
                trigger OnAfterGetRecord()
                begin
                    clear(EPFContriremitt);
                    clear(EPSContriremitt);
                    clear(EPFEPSDiff);
                    clear(PfAmount);
                    clear(GrossSalary1);
                    clear(Lossofpay1);
                    "Monthly Attendance B2B".CalcFields("Gross Salary");
                    GrossSalary1 := "Monthly Attendance B2B"."Gross Salary";
                    "Monthly Attendance B2B".CalcFields("Loss Of Pay");
                    Lossofpay1 := "Monthly Attendance B2B"."Loss Of Pay";

                    ProcessedSalary.Reset();
                    ProcessedSalary.SetRange("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
                    ProcessedSalary.SetRange("Employee Code", "Employee Code");
                    if ProcessedSalary.FindFirst() then begin
                        EPFContriremitt := ProcessedSalary."Earned Amount" + ProcessedSalary."Arrear Amount";
                        EPSContriremitt := ProcessedSalary."Co. Contributions" + ProcessedSalary."Arrear Co. Contribution";
                        EPFEPSDiff := ProcessedSalary."Co. Contribution2" + ProcessedSalary."Arrear Co. Contribution2";
                    end;
                    Payelements.Reset();
                    Payelements.SetRange("Employee Code", "Employee B2B"."No.");
                    Payelements.SetRange(PF, true);
                    if payelements.FindFirst() then begin
                        repeat
                            ProcessedSalary.Reset();
                            ProcessedSalary.SetRange("Add/Deduct Code", Payelements."Pay Element Code");
                            ProcessedSalary.SetRange("Employee Code", Payelements."Employee Code");
                            if ProcessedSalary.FindFirst() then begin
                                ProcessedSalary.CalcSums("Earned Amount");
                                PfAmount += ProcessedSalary."Earned Amount";
                            end;
                        until Payelements.Next = 0;
                    end;
                    ExcelBuffer1.NewRow();
                    ExcelBuffer1.AddColumn("Employee B2B"."UAN No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn("Employee B2B"."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn(GrossSalary1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Number);
                    ExcelBuffer1.AddColumn(PfAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn(PfAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn(PfAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn(EPFContriremitt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn(EPSContriremitt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn(EPFEPSDiff, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn(Lossofpay1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Number);
                    ExcelBuffer1.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text)

                end;


            }
            trigger OnPreDataItem()
            begin
                MakePfHeader();
            end;




        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                /*group(GroupName)
                {
                    field(Name; SourceExpression)
                    {
                        ApplicationArea = All;
                        
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
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPostReport()
    begin
        CreateExcelbook();
    end;



    var
        myInt: Integer;
        ProcessedSalary: record "Processed Salary B2B";
        EPFContriremitt: Decimal;
        EPSContriremitt: Decimal;
        EPFEPSDiff: Decimal;

        ExcelBuffer1: record "Excel Buffer" temporary;
        Payelements: record "Pay Elements B2B";
        PfAmount: Decimal;
        GrossSalary1: Decimal;
        Lossofpay1: Decimal;


    procedure MakePfHeader()
    begin
        ExcelBuffer1.NewRow;
        ExcelBuffer1.AddColumn('UAN', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Member Name ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Gross Wages ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('EPF Wages', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('EPS Wages', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('EDLI Wages', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('EPF Contribution remitted', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('EPS Contribution remitted ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('EPF and EPS Diff remitted', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('NCP Days', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Refund of Advances ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    begin
        ExcelBuffer1.CreateBookAndOpenExcel('', 'PFReport', '', COMPANYNAME, USERID);
    end;
}