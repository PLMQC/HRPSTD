page 33001452 "Salary Adjustment Matrix B2B"
{
    // version B2BHR1.00.00

    Caption = 'S Adjustment Matrix';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Dimensions';
    SourceTable = "Employee B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    Tooltip = 'Spcefies the Employee No.';
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ToolTip = 'Specifies the First name of the Employee.';
                    ApplicationArea = all;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ToolTip = 'specifies the Field';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    Caption = 'Field1';
                    DecimalPlaces = 0 : 5;
                    Visible = Field1Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ToolTip = 'Specifies the Field 2.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    Caption = 'Field2';
                    DecimalPlaces = 0 : 5;
                    Visible = Field2Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ToolTip = 'Specifies the Field 3.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    Caption = 'Field3';
                    DecimalPlaces = 0 : 5;
                    Visible = Field3Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ToolTip = 'Specifies the Field 4.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    Caption = 'Field4';
                    DecimalPlaces = 0 : 5;
                    Visible = Field4Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ToolTip = 'Specifies the Field 4.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    Caption = 'Field5';
                    DecimalPlaces = 0 : 5;
                    Visible = Field5Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ToolTip = 'Specifies the Field 4.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    Caption = 'Field6';
                    DecimalPlaces = 0 : 5;
                    Visible = Field6Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ToolTip = 'Specifies the Field 4.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    Caption = 'Field7';
                    DecimalPlaces = 0 : 5;
                    Visible = Field7Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ToolTip = 'Specifies the Field 8.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    Caption = 'Field8';
                    DecimalPlaces = 0 : 5;
                    Visible = Field8Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ToolTip = 'Specifies the Field 9.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    Caption = 'Field9';
                    DecimalPlaces = 0 : 5;
                    Visible = Field9Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ToolTip = 'Specifies the Field 10.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    Caption = 'Field10';
                    DecimalPlaces = 0 : 5;
                    Visible = Field10Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ToolTip = 'Specifies the Field 11.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    Caption = 'Field11';
                    DecimalPlaces = 0 : 5;
                    Visible = Field11Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ToolTip = 'Specifies the Field 12.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    Caption = 'Field12';
                    DecimalPlaces = 0 : 5;
                    Visible = Field12Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ToolTip = 'Specifies the Field 13.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];
                    Caption = 'Field13';
                    DecimalPlaces = 0 : 5;
                    Visible = Field13Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ToolTip = 'Specifies the Field 14.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    Caption = 'Field14';
                    DecimalPlaces = 0 : 5;
                    Visible = Field14Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ToolTip = 'Specifies the Field 15.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    Caption = 'Field15';
                    DecimalPlaces = 0 : 5;
                    Visible = Field15Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ToolTip = 'Specifies the Field 16.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    Caption = 'Field16';
                    DecimalPlaces = 0 : 5;
                    Visible = Field16Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ToolTip = 'Specifies the Field 17.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    Caption = 'Field17';
                    DecimalPlaces = 0 : 5;
                    Visible = Field17Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ToolTip = 'Specifies the Field 18.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    Caption = 'Field18';
                    DecimalPlaces = 0 : 5;
                    Visible = Field18Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ToolTip = 'Specifies the Field 19.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    Caption = 'Field19';
                    DecimalPlaces = 0 : 5;
                    Visible = Field19Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ToolTip = 'Specifies the Field 20.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    Caption = 'Field20';
                    DecimalPlaces = 0 : 5;
                    Visible = Field20Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ToolTip = 'Specifies the Field 21.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    Caption = 'Field21';
                    DecimalPlaces = 0 : 5;
                    Visible = Field21Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ToolTip = 'Specifies the Field 22.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    Caption = 'Field22';
                    DecimalPlaces = 0 : 5;
                    Visible = Field22Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ToolTip = 'Specifies the Field 23.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    Caption = 'Field23';
                    DecimalPlaces = 0 : 5;
                    Visible = Field23Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ToolTip = 'Specifies the Field 24.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    Caption = 'Field24';
                    DecimalPlaces = 0 : 5;
                    Visible = Field24Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ToolTip = 'Specifies the Field 25.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    Caption = 'Field25';
                    DecimalPlaces = 0 : 5;
                    Visible = Field25Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ToolTip = 'Specifies the Field 26.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    Caption = 'Field26';
                    DecimalPlaces = 0 : 5;
                    Visible = Field26Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ToolTip = 'Specifies the Field 27.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    Caption = 'Field27';
                    DecimalPlaces = 0 : 5;
                    Visible = Field27Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ToolTip = 'Specifies the Field 28.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    Caption = 'Field28';
                    DecimalPlaces = 0 : 5;
                    Visible = Field28Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ToolTip = 'Specifies the Field 29.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    Caption = 'Field29';
                    DecimalPlaces = 0 : 5;
                    Visible = Field29Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ToolTip = 'Specifies the Field 30.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[30];
                    Caption = 'Field30';
                    DecimalPlaces = 0 : 5;
                    Visible = Field30Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ToolTip = 'Specifies the Field 31.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    Caption = 'Field31';
                    DecimalPlaces = 0 : 5;
                    Visible = Field31Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ToolTip = 'Specifies the Field 32.';
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    Caption = 'Field32';
                    DecimalPlaces = 0 : 5;
                    Visible = Field32Visible;
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateValues(32);
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ActionGroup1102152001)
            {
                action(Dimensions)
                {
                    ToolTip = 'specifies the Dimensions.';
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(33001193),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    var
    begin
        for I := 1 to 32 do
            ShowValues(I);

    end;

    trigger OnInit();
    begin
        Field32Visible := true;
        Field31Visible := true;
        Field30Visible := true;
        Field29Visible := true;
        Field28Visible := true;
        Field27Visible := true;
        Field26Visible := true;
        Field25Visible := true;
        Field24Visible := true;
        Field23Visible := true;
        Field22Visible := true;
        Field21Visible := true;
        Field20Visible := true;
        Field19Visible := true;
        Field18Visible := true;
        Field17Visible := true;
        Field16Visible := true;
        Field15Visible := true;
        Field14Visible := true;
        Field13Visible := true;
        Field12Visible := true;
        Field11Visible := true;
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;
    end;

    trigger OnOpenPage();
    begin
        MATRIX_NoOfMatrixColumns := ARRAYLEN(MATRIX_CellData);
        rec.SetRange(Blocked,false);
    end;

    var
        MatrixRecords: array[32] of Record "Salary Adjustment Setup B2B";
        MatrixRecord: Record "Salary Adjustment Setup B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        MATRIX_NoOfMatrixColumns: Integer;
        MATRIX_CellData: array[32] of Decimal;
        MATRIX_ColumnCaption: array[32] of Text[1024];
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        [InDataSet]
        Field11Visible: Boolean;
        [InDataSet]
        Field12Visible: Boolean;
        [InDataSet]
        Field13Visible: Boolean;
        [InDataSet]
        Field14Visible: Boolean;
        [InDataSet]
        Field15Visible: Boolean;
        [InDataSet]
        Field16Visible: Boolean;
        [InDataSet]
        Field17Visible: Boolean;
        [InDataSet]
        Field18Visible: Boolean;
        [InDataSet]
        Field19Visible: Boolean;
        [InDataSet]
        Field20Visible: Boolean;
        [InDataSet]
        Field21Visible: Boolean;
        [InDataSet]
        Field22Visible: Boolean;
        [InDataSet]
        Field23Visible: Boolean;
        [InDataSet]
        Field24Visible: Boolean;
        [InDataSet]
        Field25Visible: Boolean;
        [InDataSet]
        Field26Visible: Boolean;
        [InDataSet]
        Field27Visible: Boolean;
        [InDataSet]
        Field28Visible: Boolean;
        [InDataSet]
        Field29Visible: Boolean;
        [InDataSet]
        Field30Visible: Boolean;
        [InDataSet]
        Field31Visible: Boolean;
        [InDataSet]
        Field32Visible: Boolean;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        CurLocation: Code[20];
        I: Integer;

    procedure Load(MatrixColumns1: array[32] of Text[1024]; var MatrixRecords1: array[32] of Record "Salary Adjustment Setup B2B"; var MatrixRecord1: Record "Salary Adjustment Setup B2B"; Currmonth: Integer; CurrYear: Integer; LocationCod: Code[20]);
    begin
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);
        COPYARRAY(MatrixRecords, MatrixRecords1, 1);
        MatrixRecord.COPY(MatrixRecord1);
        CurrentMonth := Currmonth;
        CurrentYear := CurrYear;
        CurLocation := LocationCod;
    end;

    procedure SetVisible();
    begin
        Field1Visible := MATRIX_ColumnCaption[1] <> '';
        Field2Visible := MATRIX_ColumnCaption[2] <> '';
        Field3Visible := MATRIX_ColumnCaption[3] <> '';
        Field4Visible := MATRIX_ColumnCaption[4] <> '';
        Field5Visible := MATRIX_ColumnCaption[5] <> '';
        Field6Visible := MATRIX_ColumnCaption[6] <> '';
        Field7Visible := MATRIX_ColumnCaption[7] <> '';
        Field8Visible := MATRIX_ColumnCaption[8] <> '';
        Field9Visible := MATRIX_ColumnCaption[9] <> '';
        Field10Visible := MATRIX_ColumnCaption[10] <> '';
        Field11Visible := MATRIX_ColumnCaption[11] <> '';
        Field12Visible := MATRIX_ColumnCaption[12] <> '';
        Field13Visible := MATRIX_ColumnCaption[13] <> '';
        Field14Visible := MATRIX_ColumnCaption[14] <> '';
        Field15Visible := MATRIX_ColumnCaption[15] <> '';
        Field16Visible := MATRIX_ColumnCaption[16] <> '';
        Field17Visible := MATRIX_ColumnCaption[17] <> '';
        Field18Visible := MATRIX_ColumnCaption[18] <> '';
        Field19Visible := MATRIX_ColumnCaption[19] <> '';
        Field20Visible := MATRIX_ColumnCaption[20] <> '';
        Field21Visible := MATRIX_ColumnCaption[21] <> '';
        Field22Visible := MATRIX_ColumnCaption[22] <> '';
        Field23Visible := MATRIX_ColumnCaption[23] <> '';
        Field24Visible := MATRIX_ColumnCaption[24] <> '';
        Field25Visible := MATRIX_ColumnCaption[25] <> '';
        Field26Visible := MATRIX_ColumnCaption[26] <> '';
        Field27Visible := MATRIX_ColumnCaption[27] <> '';
        Field28Visible := MATRIX_ColumnCaption[28] <> '';
        Field29Visible := MATRIX_ColumnCaption[29] <> '';
        Field30Visible := MATRIX_ColumnCaption[30] <> '';
        Field31Visible := MATRIX_ColumnCaption[31] <> '';
        Field32Visible := MATRIX_ColumnCaption[32] <> '';
    end;

    procedure CheckEmployees();
    var
        CheckDate: Date;
    begin
        CurrentMonth := DATE2DMY(TODAY(), 2);
        CurrentYear := DATE2DMY(TODAY(), 3);
        CheckDate := DMY2DATE(1, CurrentMonth, CurrentYear);
        CheckDate := CALCDATE('<1M-1D>', CheckDate);
        FILTERGROUP(2);
        SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        SETFILTER("Employment Date", '<%1', CheckDate);
        SETRANGE(Blocked, false);
        CurrPage.UPDATE(false);
    end;

    procedure UpdateValues(ColumnID: Integer);
    var
        SalaryAdjustment: Record "Salary Adjustment B2B";
    begin
        SalaryAdjustment.RESET();
        SalaryAdjustment.SETRANGE("Employee No", "No.");
        SalaryAdjustment.SETRANGE(Month, CurrentMonth);
        SalaryAdjustment.SETRANGE(Year, CurrentYear);
        SalaryAdjustment.SETRANGE("Location Code", CurLocation);
        SalaryAdjustment.SETRANGE("Salary Adj. Code", MatrixRecords[ColumnID].Code);
        if SalaryAdjustment.FINDFIRST() then begin
            SalaryAdjustment.Amount := MATRIX_CellData[ColumnID];
            if MATRIX_CellData[ColumnID] <> 0 then
                SalaryAdjustment.MODIFY()
            else
                SalaryAdjustment.Delete();
        end else begin
            SalaryAdjustment.INIT();
            SalaryAdjustment."Employee No" := "No.";
            SalaryAdjustment."Employee Name" := "First Name";
            SalaryAdjustment.Month := CurrentMonth;
            SalaryAdjustment.Year := CurrentYear;
            SalaryAdjustment."Location Code" := CurLocation;
            SalaryAdjustment.VALIDATE("Salary Adj. Code", MatrixRecords[ColumnID].Code);
            SalaryAdjustment.Amount := MATRIX_CellData[ColumnID];
            if MATRIX_CellData[ColumnID] <> 0 then
                SalaryAdjustment.INSERT();
        end;
    end;

    procedure ShowValues(ColumnID: Integer);
    var
        SalaryAdjustment: Record "Salary Adjustment B2B";
    begin
        CLEAR(MATRIX_CellData[ColumnID]);
        SalaryAdjustment.RESET();
        SalaryAdjustment.SETRANGE("Employee No", "No.");
        SalaryAdjustment.SETRANGE(Month, CurrentMonth);
        SalaryAdjustment.SETRANGE(Year, CurrentYear);
        SalaryAdjustment.SETRANGE("Location Code", CurLocation);
        SalaryAdjustment.SETRANGE("Salary Adj. Code", MatrixRecords[ColumnID].Code);
        if SalaryAdjustment.FINDFIRST() then
            MATRIX_CellData[ColumnID] := SalaryAdjustment.Amount;
    end;
}

