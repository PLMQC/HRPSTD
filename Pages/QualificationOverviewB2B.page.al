page 33001486 "Qualification Overview B2B"
{
    // version B2BHR1.00.00

    Caption = 'Qualification Overview_B2B';
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
                    ToolTip = 'Column Set';
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
                Caption = '&Show Matrix';
                Image = ShowMatrix;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Show matrix';

                trigger OnAction();
                var
                    MatrixForm: Page "Qualif. Overview Matrix B2B";
                begin
                    MatrixForm.Load(MATRIX_CaptionSet, MatrixRecords);
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
                    MATRIX_GenerateColumnCaptions(SetWanted::Next);
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
                    MATRIX_GenerateColumnCaptions(SetWanted::Previous);
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        MATRIX_GenerateColumnCaptions(SetWanted::Initial);
    end;

    var
        MatrixRecord: Record Lookup_B2B;
        MatrixRecords: array[32] of Record Lookup_B2B;
        MATRIX_CaptionSet: array[32] of Text[1024];
        PKFirstRecInCurrSet: Text;
        MATRIX_CaptionRange: Text;
        MatrixCaptions: Integer;
        SetWanted: Option Initial,Previous,Same,Next;
        Text33001Lbl: Label 'QUALIFICATION';

    procedure MATRIX_GenerateColumnCaptions(SetWanted: Option First,Previous,Same,Next);
    var
        MatrixMgt: Codeunit "Matrix Management";
        RecRef: RecordRef;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        CLEAR(MATRIX_CaptionSet);
        CLEAR(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecord.RESET();
        MatrixRecord.SETFILTER(MatrixRecord."LookupType Name", Text33001Lbl);
        if MatrixRecord.FINDFIRST() then;

        RecRef.GETTABLE(MatrixRecord);
        RecRef.SETTABLE(MatrixRecord);

        MatrixMgt.GenerateMatrixData(RecRef, SetWanted, ARRAYLEN(MatrixRecords), 2, PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MatrixCaptions);
        if MatrixCaptions > 0 then begin
            MatrixRecord.SETPOSITION(PKFirstRecInCurrSet);
            MatrixRecord.FIND();
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MatrixRecord);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MatrixCaptions) or (MatrixRecord.NEXT() <> 1);
        end;
    end;
}

