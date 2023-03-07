report 50003 EmployeeESIReport
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    caption = 'EmployeeESIReport';
    dataset
    {
        dataitem("MonthlyAttendanceB2B"; "Monthly Attendance B2B")
        {

            //RequestFilterFields = "Pay Slip Month", Year;

            trigger OnAfterGetRecord()
            begin


                Clear(MonthGvar);
                clear(YearGvar);
                clear(TerminatedDateGvar);
                EmployeeB2bGRec.Reset();
                EmployeeB2bGRec.SetRange("No.", "Employee Code");
                if EmployeeB2bGRec.FindSet() then
                    MonthlyAttendanceB2B.CalcFields("Gross Salary");
                MonthlyAttendanceB2B.CalcFields(Attendance);
                MonthlyAttendanceB2B.CalcFields("Loss Of Pay");
                NoofDaysPr := MonthlyAttendanceB2B.Attendance - MonthlyAttendanceB2B."Loss Of Pay";
                if not EmployeeB2bGRec.Blocked then
                    CurrReport.Skip();
                case EmployeeB2bGRec.Status of
                    EmployeeB2bGRec.status::Terminated:
                        begin
                            TerminatedDateGvar := EmployeeB2bGRec."Termination Date";

                            MonthGvar := Date2DMY(TerminatedDateGvar, 2);
                            YearGvar := Date2DMY(TerminatedDateGvar, 3);

                        end;
                    EmployeeB2bGRec.status::Inactive:
                        begin
                            TerminatedDateGvar := EmployeeB2bGRec."Inactive Date";

                            MonthGvar := Date2DMY(TerminatedDateGvar, 2);
                            YearGvar := Date2DMY(TerminatedDateGvar, 3);

                        end;
                end;
                if (MonthGvar <> MonthlyAttendanceB2B."Pay Slip Month") or (YearGvar <> MonthlyAttendanceB2B.Year) then
                    CurrReport.Skip();

                GrossSalaryGvar := format(MonthlyAttendanceB2B."Gross Salary");
                if StrPos(GrossSalaryGvar, '.') <> 0 then
                    GrossSalaryGvar := CopyStr(GrossSalaryGvar, 1, StrPos(GrossSalaryGvar, '.') - 1);
                GrossSalaryGvar := DelChr(GrossSalaryGvar, '=', ',');

                ExcelBuffer1.NewRow();
                ExcelBuffer1.AddColumn(EmployeeB2bGRec."ESI No", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                ExcelBuffer1.AddColumn(EmployeeB2bGRec."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                ExcelBuffer1.AddColumn(NoofDaysPr, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::number);
                ExcelBuffer1.AddColumn(GrossSalaryGvar, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                ExcelBuffer1.AddColumn(EmployeeB2bGRec."Exit ReasonCode For ESI", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);

                case EmployeeB2bGRec.Status of
                    EmployeeB2bGRec.status::Terminated:
                        ExcelBuffer1.AddColumn(EmployeeB2bGRec."Termination Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                    EmployeeB2bGRec.status::Inactive:
                        ExcelBuffer1.AddColumn(EmployeeB2bGRec."Inactive Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                end;
            end;

            trigger OnPreDataItem()
            begin

                MakeESIheader();

            end;


        }




    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    /* field(YearGvar1; YearGvar1)
                     {
                         Caption = 'Year';
                         ApplicationArea = All;

                     }*/
                }

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
        ExcelBuffer1: Record "Excel Buffer" temporary;
        MonthlyAttendGRec: Record "Monthly Attendance B2B";
        EmployeeB2bGRec: Record "Employee B2B";
        GrossSalaryGvar: Text;
        //CHB2BJAN302023<<
        MonthGvar: Integer;
        YearGvar: Integer;
        TerminatedDateGvar: Date;
        DayGvar: Integer;
        NoofDaysPr: Decimal;

    //CHB2BJAN302023<<


    procedure MakeESIheader()
    begin
        ExcelBuffer1.AddColumn('IP Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('IP Name ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('No of Days for which wages paid/payable during the month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Total Monthly Wages', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Reason Code for Zero workings days', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Last Working Day', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);

    end;

    procedure CreateExcelbook()
    begin
        ExcelBuffer1.CreateBookAndOpenExcel('', 'ESIReport', '', COMPANYNAME, USERID);
    end;

}