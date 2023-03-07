page 33001324 "Qualif. Overview Matrix B2B"
{
    // version B2BHR1.00.00

    Caption = 'Qualif. Overview Matrix B2B';
    DataCaptionExpression = '';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
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
                    ApplicationArea = all;
                    ToolTip = 'Specify the Qualification Required / Qualification Creation';
                }
                field("Full Name"; FullName())
                {
                    Caption = 'Full Name';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Qualification Required / Qualification Creation';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    Visible = Field1Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    Visible = Field2Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    Visible = Field3Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    Visible = Field4Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    Visible = Field5Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    Visible = Field6Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    Visible = Field7Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    Visible = Field8Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    Visible = Field9Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    Visible = Field10Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    Visible = Field11Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    Visible = Field12Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];
                    Visible = Field13Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    Visible = Field14Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    Visible = Field15Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    Visible = Field16Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    Visible = Field17Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    Visible = Field18Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    Visible = Field19Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    Visible = Field20Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    Visible = Field21Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    Visible = Field22Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    Visible = Field23Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    Visible = Field24Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    Visible = Field25Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    Visible = Field26Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    Visible = Field27Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    Visible = Field28Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    Visible = Field29Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[30];
                    Visible = Field30Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    Visible = Field31Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    Visible = Field32Visible;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Matrix Detail In Leave Applicapibility';
                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(32);
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
        MATRIX_NoOfColumns: Integer;
    begin
        MATRIX_CurrentColumnOrdinal := 1;
        MATRIX_NoOfColumns := ARRAYLEN(MATRIX_CellData);

        while MATRIX_CurrentColumnOrdinal <= MATRIX_NoOfColumns do begin
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
            MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
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
        SetVisible();
    end;

    var
        EmployeeQualification: Record "Employee Qualification B2B";
        MatrixRecords: array[32] of Record Lookup_B2B;
        MATRIX_CellData: array[32] of Boolean;
        MATRIX_ColumnCaption: array[32] of Text[1024];
        Qualified: Boolean;
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

    procedure Load(MatrixColumns1: array[32] of Text[1024]; var MatrixRecords1: array[32] of Record Lookup_B2B);
    begin
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);
        COPYARRAY(MatrixRecords, MatrixRecords1, 1);
    end;

    local procedure MatrixOnDrillDown(ColumnID: Integer);
    begin
        EmployeeQualification.SETRANGE("Employee No.", "No.");
        EmployeeQualification.SETRANGE("Qualification Code", MatrixRecords[ColumnID]."Lookup Name");
        PAGE.RUN(PAGE::"Employee Qualifications B2B", EmployeeQualification);
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer);
    begin
        EmployeeQualification.SETRANGE("Employee No.", "No.");
        EmployeeQualification.SETRANGE("Qualification Code", MatrixRecords[ColumnID]."Lookup Name");
        Qualified := EmployeeQualification.FINDFIRST();
        EmployeeQualification.SETRANGE("Employee No.");
        EmployeeQualification.SETRANGE("Qualification Code");
        MATRIX_CellData[ColumnID] := Qualified;
        SetVisible();
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
}

