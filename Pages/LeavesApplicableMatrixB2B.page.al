page 33001400 "Leaves Applicable Matrix B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leaves Applicability Matrix';
    DataCaptionExpression = '';
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Leave Master B2B";
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Leave Code"; "Leave Code")
                {
                    Caption = 'Leave Code';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave code';
                }
                field(Description; Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave description';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Visible = Field1Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        MATRIXCellData1OnAfterValidate();
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Visible = Field2Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        MATRIXCellData2OnAfterValidate();
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Visible = Field3Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        MATRIXCellData3OnAfterValidate();
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Visible = Field4Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Visible = Field5Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    Visible = Field6Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    Visible = Field7Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[8];
                    Visible = Field8Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[9];
                    Visible = Field9Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[10];
                    Visible = Field10Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[11];
                    Visible = Field11Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[12];
                    Visible = Field12Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[13];
                    Visible = Field13Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[14];
                    Visible = Field14Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[15];
                    Visible = Field15Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[16];
                    Visible = Field16Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[17];
                    Visible = Field17Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[18];
                    Visible = Field18Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[19];
                    Visible = Field19Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[20];
                    Visible = Field20Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[21];
                    Visible = Field21Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[22];
                    Visible = Field22Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[23];
                    Visible = Field23Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[24];
                    Visible = Field24Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[25];
                    Visible = Field25Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[26];
                    Visible = Field26Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[27];
                    Visible = Field27Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[28];
                    Visible = Field28Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[29];
                    Visible = Field29Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[30];
                    Visible = Field30Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[31];
                    Visible = Field31Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    CaptionClass = '3,' + MATRIX_CaptionSet[32];
                    Visible = Field32Visible;
                    ApplicationArea = all;
                    ToolTip = 'specify the leave matrix details';
                    trigger OnValidate();
                    begin
                        Matrix_Onvalidate(32);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        MATRIX_CurrentColumnOrdinal := 0;
        while MATRIX_CurrentColumnOrdinal < MATRIX_CurrentNoOfMatrixColumn do begin
            MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;

            Available := LeavesApplicability.GET("Leave Code", MatrixRecords[MATRIX_CurrentColumnOrdinal]."Leave Code") or
                     LeavesApplicability.GET(MatrixRecords[MATRIX_CurrentColumnOrdinal]."Leave Code", "Leave Code");
            MATRIX_CellData[MATRIX_CurrentColumnOrdinal] := Available;
        end;
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
        SetColumnVisibility();
    end;

    var
        LeavesApplicability: Record "Leaves Applicability B2B";
        MatrixRecords: array[32] of Record "Leave Master B2B";
        Show: Option "In-Transit Code","Shipping Agent Code","Shipping Agent Service Code";
        
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        MATRIX_CellData: array[32] of Boolean;
        MATRIX_CaptionSet: array[32] of Text[1024];
        Available: Boolean;
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

    procedure Load(var NewMatrixColumns: array[32] of Text[1024]; var NewMatrixRecords: array[32] of Record "Leave Master B2B"; NewCurrentNoOfMatrixColumns: Integer; NewShow: Option "In-Transit Code","Shipping Agent Code","Shipping Agent Service Code");
    begin
        COPYARRAY(MATRIX_CaptionSet, NewMatrixColumns, 1);
        COPYARRAY(MatrixRecords, NewMatrixRecords, 1);
        MATRIX_CurrentNoOfMatrixColumn := NewCurrentNoOfMatrixColumns;
        Show := NewShow;
    end;

    procedure SetColumnVisibility();
    begin
        Field1Visible := MATRIX_CurrentNoOfMatrixColumn >= 1;
        Field2Visible := MATRIX_CurrentNoOfMatrixColumn >= 2;
        Field3Visible := MATRIX_CurrentNoOfMatrixColumn >= 3;
        Field4Visible := MATRIX_CurrentNoOfMatrixColumn >= 4;
        Field5Visible := MATRIX_CurrentNoOfMatrixColumn >= 5;
        Field6Visible := MATRIX_CurrentNoOfMatrixColumn >= 6;
        Field7Visible := MATRIX_CurrentNoOfMatrixColumn >= 7;
        Field8Visible := MATRIX_CurrentNoOfMatrixColumn >= 8;
        Field9Visible := MATRIX_CurrentNoOfMatrixColumn >= 9;
        Field10Visible := MATRIX_CurrentNoOfMatrixColumn >= 10;
        Field11Visible := MATRIX_CurrentNoOfMatrixColumn >= 11;
        Field12Visible := MATRIX_CurrentNoOfMatrixColumn >= 12;
        Field13Visible := MATRIX_CurrentNoOfMatrixColumn >= 13;
        Field14Visible := MATRIX_CurrentNoOfMatrixColumn >= 14;
        Field15Visible := MATRIX_CurrentNoOfMatrixColumn >= 15;
        Field16Visible := MATRIX_CurrentNoOfMatrixColumn >= 16;
        Field17Visible := MATRIX_CurrentNoOfMatrixColumn >= 17;
        Field18Visible := MATRIX_CurrentNoOfMatrixColumn >= 18;
        Field19Visible := MATRIX_CurrentNoOfMatrixColumn >= 19;
        Field20Visible := MATRIX_CurrentNoOfMatrixColumn >= 20;
        Field21Visible := MATRIX_CurrentNoOfMatrixColumn >= 21;
        Field22Visible := MATRIX_CurrentNoOfMatrixColumn >= 22;
        Field23Visible := MATRIX_CurrentNoOfMatrixColumn >= 23;
        Field24Visible := MATRIX_CurrentNoOfMatrixColumn >= 24;
        Field25Visible := MATRIX_CurrentNoOfMatrixColumn >= 25;
        Field26Visible := MATRIX_CurrentNoOfMatrixColumn >= 26;
        Field27Visible := MATRIX_CurrentNoOfMatrixColumn >= 27;
        Field28Visible := MATRIX_CurrentNoOfMatrixColumn >= 28;
        Field29Visible := MATRIX_CurrentNoOfMatrixColumn >= 29;
        Field30Visible := MATRIX_CurrentNoOfMatrixColumn >= 30;
        Field31Visible := MATRIX_CurrentNoOfMatrixColumn >= 31;
        Field32Visible := MATRIX_CurrentNoOfMatrixColumn >= 32;
    end;

    procedure UpdateValues(MATRIX_CurrentColumnOrdinal: Integer);
    begin
        if MATRIX_CellData[MATRIX_CurrentColumnOrdinal] then begin
            LeavesApplicability.INIT();
            LeavesApplicability."From Leave Code" := "Leave Code";
            LeavesApplicability."To Leave Code" := MatrixRecords[MATRIX_CurrentColumnOrdinal]."Leave Code";
            LeavesApplicability.INSERT();
        end else begin
            if LeavesApplicability.GET("Leave Code", MatrixRecords[MATRIX_CurrentColumnOrdinal]."Leave Code") then
                LeavesApplicability.Delete();
            if LeavesApplicability.GET(MatrixRecords[MATRIX_CurrentColumnOrdinal]."Leave Code", "Leave Code") then
                LeavesApplicability.Delete();
        end;
        CurrPage.UPDATE(false);
    end;

    procedure Matrix_Onvalidate(CellNum: Integer);
    begin
        if MatrixRecords[CellNum]."Leave Code" <> "Leave Code" then 
            UpdateValues(CellNum);

        
    end;

    local procedure MATRIXCellData1OnAfterValidate();
    begin
        Matrix_Onvalidate(1);
    end;

    local procedure MATRIXCellData2OnAfterValidate();
    begin
        Matrix_Onvalidate(2);
    end;

    local procedure MATRIXCellData3OnAfterValidate();
    begin
        Matrix_Onvalidate(3);
    end;
}

