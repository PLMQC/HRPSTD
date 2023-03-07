page 33001266 "Grade Transfer B2B"
{
    // version B2BHR1.00.00

    Caption = 'Grade Transfer';
    PageType = Card;
    SourceTable = "Grade Transfer B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Employee No."; "Employee No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee no in grade transfer';
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee name in grade transfer';
                }
                field(Grade; Grade)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee transfer grade in grade list';
                }
                field("New Grade"; "New Grade")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee newgrade  in grade list';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Image = Start;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specify the Process of an Document';
                trigger OnAction();
                begin
                    TESTFIELD("New Grade");
                    InsertGradePayElements(Rec);

                    PayCadrePayElements.RESET();
                    if PayCadrePayElements.FINDFIRST() then
                        repeat
                            PayCadrePayElements.Processed := false;
                            PayCadrePayElements.MODIFY();
                        until PayCadrePayElements.NEXT() = 0;

                    GradeTransfer.RESET();
                    if GradeTransfer.FINDFIRST() then
                        GradeTransfer.DELETEALL();
                    CurrPage.CLOSE();
                end;
            }
        }
    }

    var
        PayCadrePayElements: Record "Pay Cadre Pay Element B2B";
        GradeTransfer: Record "Grade Transfer B2B";
}

