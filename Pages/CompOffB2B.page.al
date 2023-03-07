page 33001506 "Comp Off B2B"
{
    // version B2BHR1.00.00

    Caption = 'Comp Off';
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE("Document Type" = CONST("Comp Off"),
                            Status = CONST(Open));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The No.';
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Creation Date';
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Type';
                }
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The code';
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Month';
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The year';
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Status';
                }
            }
            part(Control1102154011; "Comp Off Subform B2B")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Post';
                    trigger OnAction();
                    begin
                        ApproveCompOff();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ValidateType();
    end;

    trigger OnInit();
    begin
        "Department CodeEditable" := true;
    end;

    var
        [InDataSet]
        "Department CodeEditable": Boolean;
        Text001Lbl: Label 'Do you want to approve the entries?';

    procedure ValidateType();
    begin
    end;

    procedure ApproveCompOff();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        CheckValidEntries();
        if CONFIRM(Text001Lbl) then
            AttApprovals.ApproveCompOff(Rec);
    end;

    local procedure TypeOnAfterValidate();
    begin
        ValidateType();
    end;
}

