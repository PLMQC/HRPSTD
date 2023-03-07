page 33001519 "LOP Adj. Application B2B"
{
    // version B2BHR1.00.00

    Caption = 'LOP Adj. Application';
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE("Document Type" = CONST("Lop Adj"),
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
                    ToolTip = 'Choose the No. sereis defined from drop down.';
                    ApplicationArea = all;
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Choose the Date of Creation.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Select the Physical location of the Employee.';
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ToolTip = 'Choose the Employee No.';
                    Caption = 'Employee Code';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Select the Month for lop Adjustment.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Select the Year for lop Adjustment.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Shows the Status of Document.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Choose the Loss pay start Date.';
                    ApplicationArea = all;
                }
            }

            part(LopAdjSubForm; "LOP Adj. Subform B2B")
            {
                Caption = 'LopAdjSubForm';
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = all;
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
                action("&Aprrove")
                {
                    ToolTip = 'on clicking approves the LOP document.';
                    Caption = '&Aprrove';
                    Image = Approve;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        ApproveLopAdjustment();
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Type := Type::Employee;
    end;

    var
        LopAdjLines: Record "Attendance Lines B2B";
        Text001Lbl: Label 'Do you want to approve the entries';

    procedure TestStatus();
    begin
        LopAdjLines.RESET();
        LopAdjLines.SETRANGE("Document Type", "Document Type");
        LopAdjLines.SETRANGE("Document No.", "No.");
        if LopAdjLines.FINDFIRST() then
            repeat
                LopAdjLines.TESTFIELD("LOP Period");
            until LopAdjLines.NEXT() = 0;

    end;

    procedure ReleaseOnDuty();
    begin
    end;

    procedure ApproveLopAdjustment();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        TestStatus();
        CheckValidEntries();
        if CONFIRM(Text001Lbl) then
            AttApprovals.ApproveLopAdjustment(Rec);

    end;
}

