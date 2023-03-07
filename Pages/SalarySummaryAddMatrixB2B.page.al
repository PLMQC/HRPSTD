page 33001527 "Salary Summary Add Matrix B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Summary Addition Matrix';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Lookup_B2B;
    SourceTableView = SORTING("Lookup Name")
                      ORDER(Ascending)
                      WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'),
                            "Add/Deduct" = CONST(Addition));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field("Lookup Id"; "Lookup Id")
            {
                ToolTip = 'Choose the Lookup ID.';
                ApplicationArea = all;
            }
            field("Lookup Name"; "Lookup Name")
            {
                ToolTip = 'Enter the Lookup name.';
                ApplicationArea = all;
            }
            field("Lookup Type B2B"; "Lookup Type")
            {
                ToolTip = 'Enter the Lookup type.';
                ApplicationArea = all;
            }
            field(Control1102152001; '')
            {
                Caption = 'Control1102152001';
                ApplicationArea = all;
                ToolTip = 'Specifies the';
            }
        }
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

