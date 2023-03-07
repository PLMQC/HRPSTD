page 33001367 "Salary Adjustment B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Adjustment';
    PageType = Card;
    SourceTable = "Employee B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentMonth1; CurrentMonth)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    ToolTip = 'Month';
                }
                field(CurrentYear1; CurrentYear)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    ToolTip = 'Year';
                }
                field(CurrLocation1; CurrLocation)
                {
                    Caption = 'Location';
                    ApplicationArea = all;
                    ToolTip = 'Locations';
                }
                field(ShowColumnName1; ShowColumnName)
                {
                    Caption = 'ShowColumnName';
                    ApplicationArea = all;
                    ToolTip = 'Show column name';
                }
            }
            group(Options)
            {
                Caption = 'Options';
                field(TempBatch1; TempBatch)
                {
                    Caption = 'TempBatch';
                    ApplicationArea = all;
                    ToolTip = 'Temp batch';
                }
                field(PostDate1; PostDate)
                {
                    Caption = 'PostDate';
                    ApplicationArea = all;
                    ToolTip = 'Posting date';
                }
                field("DocNo.1"; "DocNo.")
                {
                    Caption = 'DocNo.';
                    ApplicationArea = all;
                    ToolTip = 'Doc no.';
                }
                group("Matrix Options")
                {
                    Caption = 'Matrix Options';
                    field(MatrixRec; MatrixRec_Caption)
                    {
                        Caption = 'Column Set';
                        ApplicationArea = all;
                        ToolTip = 'Column set';
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // action("<Action13>")
            // {
            //     Caption = 'Show Matrix';
            //     Image = ShowMatrix;
            //     Promoted = true;

            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ApplicationArea = all;
            // }
            // action("<Action31>")
            // {
            //     Caption = 'Previous Set';
            //     Image = PreviousSet;
            //     Promoted = true;

            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Previous Set';
            //     ApplicationArea = all;
            // }
            // action("<Action32>")
            // {
            //     Caption = 'Next Set';
            //     Image = NextSet;
            //     Promoted = true;            
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Next Set';
            //     ApplicationArea = all;
            // }
        }
    }

    var

        CurrentMonth: Integer;
        CurrentYear: Integer;
        ShowColumnName: Boolean;
        TempBatch: Code[20];
        "DocNo.": Code[20];
        PostDate: Date;
        CurrLocation: Code[30];
        MatrixRec_Caption: Text[100];
}

