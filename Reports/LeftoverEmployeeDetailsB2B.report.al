report 33001290 "Leftover Employee Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leftover Employee Details';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") WHERE(Blocked = CONST(true));
            RequestFilterFields = "Last Working Day";

            trigger OnAfterGetRecord();
            begin
                RowNo += 1;
                Entercel(RowNo, 1, FORMAT("Employee B2B"."No."), false);
                Entercel(RowNo, 2, FORMAT("Employee B2B"."Last Name" + '' + "Employee B2B"."First Name" + '' + "Employee B2B"."Middle Name"), false);
                Entercel(RowNo, 3, FORMAT("Employee B2B".Address + "Employee B2B"."Address 2"), false);
                Entercel(RowNo, 4, FORMAT("Employee B2B"."Department Code"), false);
                Entercel(RowNo, 5, FORMAT("Employee B2B".Designation), false);
                Entercel(RowNo, 6, FORMAT("Employee B2B"."Employee Status"), false);
                Entercel(RowNo, 7, FORMAT("Employee B2B"."Resource No."), false);
                Entercel(RowNo, 8, FORMAT("Employee B2B"."Pay Cadre"), false);
                Entercel(RowNo, 9, FORMAT("Employee B2B"."MSR Card Number"), false);
                Entercel(RowNo, 10, FORMAT("Employee B2B"."Birth Date"), false);
                Entercel(RowNo, 11, FORMAT("Employee B2B"."Last Working Day"), false);
                Entercel(RowNo, 12, FORMAT("Employee B2B"."Employment Date"), false);
                Entercel(RowNo, 13, FORMAT("Employee B2B"."Blood Group"), false);
                Entercel(RowNo, 14, FORMAT("Employee B2B".Gender), false);
            end;

            trigger OnPostDataItem();
            begin
                TempExcelBuffer.CreateNewBook(Text0015Txt);
                TempExcelBuffer.WriteSheet(Text0015Txt, COMPANYNAME(), USERID());
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.OpenExcel();
            end;

            trigger OnPreDataItem();
            begin
                RowNo += 1;
                Entercel(RowNo, 1, FORMAT(CompanyInfo.Name), true);
                Entercel(RowNo, 2, (FORMAT(CompanyInfo.Address) + ' ' + FORMAT(CompanyInfo."Address 2")), true);
                RowNo += 1;
                Entercel(RowNo, 2, Text00Txt, true);
                Entercel(RowNo, 3, FORMAT("Employee B2B".GETFILTERS()), true);
                RowNo += 1;
                Entercel(RowNo, 1, Text001Txt, true);
                Entercel(RowNo, 2, Text002Txt, true);
                Entercel(RowNo, 3, Text003Txt, true);
                Entercel(RowNo, 4, Text004Txt, true);
                Entercel(RowNo, 5, Text005Txt, true);
                Entercel(RowNo, 6, Text006Txt, true);
                Entercel(RowNo, 7, Text007Txt, true);
                Entercel(RowNo, 8, Text008Txt, true);
                Entercel(RowNo, 9, Text009Txt, true);
                Entercel(RowNo, 10, Text0010Txt, true);
                Entercel(RowNo, 11, Text0011Txt, true);
                Entercel(RowNo, 12, Text0012Txt, true);
                Entercel(RowNo, 13, Text0013Txt, true);
                Entercel(RowNo, 14, Text0014Txt, true);
            end;
        }
    }

    requestpage
    {
        Caption = 'Leftover Employee Details';

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
        CompanyInfo.GET();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        CompanyInfo: Record "Company Information";
        RowNo: Integer;
        Text00Txt: Label 'Leaving Date Between';
        Text001Txt: Label 'Emp No';
        Text002Txt: Label 'Emp Name';
        Text003Txt: Label 'Address';
        Text004Txt: Label 'Department';
        Text005Txt: Label 'Designation';
        Text006Txt: Label 'Status';
        Text007Txt: Label 'Agency';
        Text008Txt: Label 'Grade';
        Text009Txt: Label 'Card 1No.';
        Text0010Txt: Label 'Birth Date';
        Text0011Txt: Label 'Leaving Date';
        Text0012Txt: Label 'Joining Date';
        Text0013Txt: Label 'Blood Group';
        Text0014Txt: Label 'Gender';
        Text0015Txt: Label 'Employee blocked list';

    procedure Entercel(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean);
    begin
        TempExcelBuffer.INIT();
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.INSERT();
    end;
}

