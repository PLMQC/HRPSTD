report 50002 EmployeeEXitReport
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    caption = 'EmployeeEXitReport';

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            trigger OnAfterGetRecord()
            begin
                ExcelBuffer1.NewRow();
                ExcelBuffer1.AddColumn("Employee B2B"."UAN No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                ExcelBuffer1.AddColumn("Employee B2B"."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                ExcelBuffer1.AddColumn("Employee B2B"."Last Working Day", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);
                ExcelBuffer1.AddColumn("Employee B2B"."Exit ReasonCode For Pf", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer1."Cell Type"::Text);

            end;

            trigger OnPreDataItem()
            begin
                MakeESIHeader();
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
                    /*field(Name; SourceExpression)
                    {
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

    procedure MakeESIHeader()
    begin
        ExcelBuffer1.NewRow;
        ExcelBuffer1.AddColumn('UAN', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Member Name ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Exit Date ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Exit Reason code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
    END;


    procedure CreateExcelbook()
    begin
        ExcelBuffer1.CreateBookAndOpenExcel('', 'EmployeeESIReport', '', COMPANYNAME, USERID);
    end;
}