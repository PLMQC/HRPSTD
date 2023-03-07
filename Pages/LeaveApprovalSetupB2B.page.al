page 33001511 "Leave Approval Setup B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Leave Approval Setup';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Leave  Approval Setup B2B";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(CurrDocType1; CurrDocType)
            {
                Caption = 'Document Type';
                OptionCaption = ' ,LeaveApplication,LeaveCancelation';
                ApplicationArea = all;
                ToolTip = 'Specifies The Document type';
                trigger OnValidate();
                begin
                    SETRANGE("Document Type", CurrDocType);
                    CurrDocTypeOnAfterValidate();
                end;
            }
            repeater(Control1102152000)
            {
                field(Department; Department)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Department';
                }
                field(User; User)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The user';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        User := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
                field(HOD; HOD)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The HOD';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        HOD := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
                field("Additional Approver"; "Additional Approver")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The additional approver';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "Additional Approver" := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
                field("HR Approver"; "HR Approver")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The HR Approver';
                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "HR Approver" := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Document Type" := CurrDocType;
    end;

    trigger OnOpenPage();
    begin
        RESET();
        SETRANGE("Document Type", CurrDocType);
    end;

    var
        UserRec: Record User;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        CurrDocType: Option " ",LeaveApplication,LeaveCancelation;


    local procedure CurrDocTypeOnAfterValidate();
    begin
        CurrPage.UPDATE(false);
    end;
}

