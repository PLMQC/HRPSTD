page 33001239 "Leave Encashment B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Encashment';
    PageType = Card;
    SourceTable = "Leave Encashment Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Encashment Code"; "Encashment Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The encashemnt code';
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The month';
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The year';
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The type';
                    trigger OnValidate();
                    begin
                        TypeOnAfterValidate();
                    end;
                }
                field("Employee Code"; "Employee Code")
                {
                    Editable = "Employee CodeEditable";
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee code';

                    trigger OnValidate();
                    begin
                        EmployeeCodeOnAfterValidate();
                    end;
                }
                field("Leave Pay Cadre"; "Leave Pay Cadre")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave pay cadre';
                }
            }

            part(LeaveEncashmentSubform; "LeaveEncashmentSubform B2B")
            {
                Caption = 'LeaveEncashmentSubform';
                SubPageLink = "Encashment Code" = FIELD("Encashment Code");
                ApplicationArea = all;
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Product Posting Group"; "Product Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The posting group';
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Journal batch name';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        JournalTemplate.RESET();
                        JournalTemplate.SETRANGE("Form ID", 33001239);
                        if JournalTemplate.FINDFIRST() then
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                        if PAGE.RUNMODAL(33001274, JournalBatch) = ACTION::LookupOK then begin
                            "Journal Batch Name" := JournalBatch.Name;
                            "Journal Template Name" := JournalBatch."Journal Template Name";
                            "Posting Date" := TODAY();
                        end;
                        JournalBatch.FILTERGROUP(0);
                        JournalBatch.RESET();
                        JournalBatch.SETRANGE(Name, "Journal Batch Name");
                        if JournalBatch.FINDFIRST() then
                            NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                        if NoSeries.FINDFIRST() then
                            "Document No." := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series", WORKDATE());
                    end;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The document no';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The posting date';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Update Amount")
                {
                    Caption = 'Update Amount';
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The amount updation';
                    trigger OnAction();
                    begin
                        LELine.RESET();
                        LELine.SETRANGE("Encashment Code", "Encashment Code");
                        LELine.SETFILTER("Leaves To Encash", '<>%1', 0);
                        if LELine.FINDFIRST() then
                            repeat
                                PostLeavEncaDet.RESET();
                                PostLeavEncaDet.SETRANGE("Employee Code", LELine."Employee Code");
                                PostLeavEncaDet.SETRANGE(Month, LELine.Month);
                                PostLeavEncaDet.SETRANGE(Year, LELine.Year);
                                if not PostLeavEncaDet.FINDFIRST() then
                                    UpdateAmount(LELine);

                            until LELine.NEXT() = 0;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    Caption = 'Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Post';
                    trigger OnAction();
                    begin
                        PostEncashment();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if Type = Type::All then begin
            "Employee CodeEditable" := false;
            PayCadreEditable := false;
        end;
        if Type = Type::Employee then begin
            "Employee CodeEditable" := true;
            PayCadreEditable := false;
        end;
        if Type = Type::Grade then begin
            "Employee CodeEditable" := false;
            PayCadreEditable := true;
        end;
    end;

    trigger OnInit();
    begin
        PayCadreEditable := true;
        "Employee CodeEditable" := true;
    end;

    var
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        LELine: Record "Leave Encashment Line B2B";
        PostLeavEncaDet: Record "Posted Leave Encash Det B2B";

        NoSeries: Record "No. Series";
        NoSeriesMgt: Codeunit 396;
        [InDataSet]
        "Employee CodeEditable": Boolean;
        [InDataSet]
        PayCadreEditable: Boolean;

    local procedure PayCadreOnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    local procedure TypeOnAfterValidate();
    begin
        if Type = Type::All then begin
            "Employee CodeEditable" := false;
            PayCadreEditable := false;
        end;
        if Type = Type::Employee then begin
            "Employee CodeEditable" := true;
            PayCadreEditable := false;
        end;
        if Type = Type::Grade then begin
            "Employee CodeEditable" := false;
            PayCadreEditable := true;
        end;

        CurrPage.UPDATE();
    end;

    local procedure EmployeeCodeOnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;
}

