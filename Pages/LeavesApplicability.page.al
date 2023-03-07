page 33001399 "_Leaves Applicability B2B"
{
    // version B2BHR1.00.00

    Caption = '_Leaves Applicability';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Leave Master B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(ShowTransferToName1; ShowTransferToName)
                {
                    Caption = 'Show Column Name';
                    ApplicationArea = all;
                    ToolTip = 'Specify the show colum name for options';
                    trigger OnValidate();
                    begin
                        ShowTransferToNameOnAfterValid();
                    end;
                }
            }
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
                field(MATRIX_CaptionRange1; MATRIX_CaptionRange)
                {
                    Caption = 'Column Set';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the colum set details';
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
                ToolTip = 'Specify the leave show matrix details';
                trigger OnAction();
                var
                    MatrixForm: Page "Leaves Applicable Matrix B2B";
                begin
                    CLEAR(MatrixForm);
                    MatrixForm.Load(MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrentNoOfColumns, Show);
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
                ApplicationArea = all;
                ToolTip = 'Specify the next set details';
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
                ApplicationArea = all;
                ToolTip = 'specify the Previous Set';
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

        MATRIX_MatrixRecord: Record "Leave Master B2B";
        MatrixRecords: array[32] of Record "Leave Master B2B";
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text;
        MATRIX_PKFirstRecInCurrSet: Text;
        MATRIX_CurrentNoOfColumns: Integer;
        ShowTransferToName: Boolean;
        Show: Option "In-Transit Code","Shipping Agent Code","Shipping Agent Service Code";
        MATRIX_SetWanted: Option First,Previous,Same,Next;

    procedure MATRIX_GenerateColumnCaptions(SetWanted: Option First,Previous,Same,Next);
    var
        MatrixMgt: Codeunit "Matrix Management";
        RecRef: RecordRef;
        CurrentMatrixRecordOrdinal: Integer;
        CaptionField: Integer;
    begin
        CLEAR(MATRIX_CaptionSet);
        CLEAR(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        RecRef.GETTABLE(MATRIX_MatrixRecord);
        RecRef.SETTABLE(MATRIX_MatrixRecord);

        if ShowTransferToName then
            CaptionField := 2
        else
            CaptionField := 1;

        MatrixMgt.GenerateMatrixData(RecRef, SetWanted, ARRAYLEN(MatrixRecords), CaptionField, MATRIX_PKFirstRecInCurrSet, MATRIX_CaptionSet
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

    local procedure ShowTransferToNameOnAfterValid();
    begin
        MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Same);
    end;
}

