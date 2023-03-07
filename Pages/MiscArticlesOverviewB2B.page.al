page 33001480 "Misc. Articles Overview-B2B"
{
    // version B2BHR1.00.00

    Caption = 'Misc. Articles Overview';
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
                    ToolTip = 'Specifies The Column';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowMatrix)
            {
                ToolTip = 'SPecifies the Matric.';
                Caption = '&Show Matrix';
                Image = ShowMatrix;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction();
                var
                    MatrixForm: Page "Misc. Articles Overview MX B2B";
                begin
                    CLEAR(MatrixForm);
                    MatrixForm.Load(MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrentNoOfColumns, "No.");
                    MatrixForm.RUNMODAL();
                end;
            }
            action("Next Set")
            {
                ToolTip = 'Specifies the Next set.';
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Next);
                end;
            }
            action("Previous Set")
            {
                ToolTip = 'Specifies the Prvious set.';
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
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
        MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::First);
    end;

    var
        MatrixRecords: array[32] of Record Lookup_B2B;
        MATRIX_MatrixRecord: Record Lookup_B2B;
        MatrixMgt: Codeunit "Matrix Management";
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text;
        MATRIX_PKFirstRecInCurrSet: Text;
        MATRIX_CurrentNoOfColumns: Integer;

        MATRIX_SetWanted: Option First,Previous,Same,Next;
        Text33001Lbl: Label 'ARTICLE INFO';

    procedure MATRIX_GenerateColumnCaptions(SetWanted: Option First,Previous,Same,Next);
    var
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
        MatrixMgt.GenerateMatrixData(RecRef, SetWanted, ARRAYLEN(MatrixRecords), 2, MATRIX_PKFirstRecInCurrSet, MATRIX_CaptionSet
          , MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns);

        if MATRIX_CurrentNoOfColumns > 0 then begin
            MATRIX_MatrixRecord.SETPOSITION(MATRIX_PKFirstRecInCurrSet);
            MATRIX_MatrixRecord.FIND();
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MATRIX_MatrixRecord);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MATRIX_CurrentNoOfColumns) or (MATRIX_MatrixRecord.NEXT() <> 1);
        end;
    end;
}

