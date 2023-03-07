page 33001485 "Confidential Info. Over B2B"
{
    // version B2BHR1.00.00

    Caption = 'Confidential Info. Overview';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Employee B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
                field(MATRIX_CaptionRange1; MATRIX_CaptionRange)
                {
                    Caption = 'Column Set';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Column Set';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Show Matrix")
            {
                Caption = '&Show Matrix';
                Image = ShowMatrix;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Display Matrix';

                trigger OnAction();
                var
                    MatrixForm: Page "Conf. Info Overview Matrix B2B";
                begin
                    CLEAR(MatrixForm);
                    MatrixForm.Load(MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength);
                    MatrixForm.RUNMODAL();
                end;
            }
            action("Next Set")
            {
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Set';
                ApplicationArea = all;

                trigger OnAction();
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Next);
                end;
            }
            action("Previous Set")
            {
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Set';
                ApplicationArea = all;

                trigger OnAction();
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Previous);
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Initial);
    end;

    var
        MATRIX_MatrixRecord: Record Lookup_B2B;
        MatrixRecords: array[32] of Record Lookup_B2B;

        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        MATRIX_PKFirstRecInCurrSet: Text;
        MATRIX_CurrSetLength: Integer;
        Text33001Lbl: Label 'CONFIDENTIAL';

    procedure MATRIX_GenerateColumnCaptions(SetWanted: Option Initial,Previous,Same,Next);
    var
        MatrixMgt: Codeunit "Matrix Management";
        RecRef: RecordRef;
        CurrentMatrixRecordOrdinal: Integer;


    begin
        CLEAR(MATRIX_CaptionSet);
        CLEAR(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;


        MATRIX_MatrixRecord.RESET();
        MATRIX_MatrixRecord.SETFILTER(MATRIX_MatrixRecord."LookupType Name", Text33001Lbl);
        if MATRIX_MatrixRecord.FINDFIRST() then;

        RecRef.GETTABLE(MATRIX_MatrixRecord);
        RecRef.SETTABLE(MATRIX_MatrixRecord);

        MatrixMgt.GenerateMatrixData(RecRef, SetWanted, ARRAYLEN(MatrixRecords), 2, MATRIX_PKFirstRecInCurrSet, MATRIX_CaptionSet,
          MATRIX_CaptionRange, MATRIX_CurrSetLength);

        MATRIX_MatrixRecord.SETPOSITION(MATRIX_PKFirstRecInCurrSet);

        repeat
            MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MATRIX_MatrixRecord);
            CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
        until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (MATRIX_MatrixRecord.NEXT() <> 1);
    end;
}

