page 33001528 "Salary Summary Ded Matrix B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Summary DeductionMatrix';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Lookup_B2B;
    SourceTableView = SORTING("Lookup Name")
                      ORDER(Ascending)
                      WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'),
                            "Add/Deduct" = CONST(Deduction));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
    }

    actions
    {
    }

    var

    procedure ApplyFilters();
    begin
    end;

    procedure ShowValues();
    var
    begin
    end;

    procedure MatrixValueDrillDown();
    var
    begin
    end;

    procedure ExportReportToExcel();
    begin
    end;

    procedure BuildHeadings();
    begin
    end;

    procedure BuildExcelData();
    var
    begin
    end;

    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Code[50]; Bold: Boolean);
    begin
    end;

    procedure GetUnitWisePayEltTotal(CurrPayElementCode: Code[20]; CurrUnitsCode: Code[20]): Decimal;
    var
    begin
    end;

    procedure GetUnitWiseTotalAmount(CurrUnitsCode: Code[20]): Decimal;
    var
    begin
    end;

    procedure GetGrandTotalAmount(): Decimal;
    var
    begin
    end;
}

