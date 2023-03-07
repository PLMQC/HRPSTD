page 33001307 "Resource Indent Appr Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resource Indent Approval Setup';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "HR Approval setup B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Document Type as Resource Indent';
                }
                field(Department; Department)
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the department towards Approval Process from the List shown';

                }
                field(User; User)
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the user from the user List';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        User := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
                field(HOD; HOD)
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Approver from the User List Shown';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        HOD := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
                field("Addtional  Approver"; "Addtional  Approver")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Addition Approver from the list';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "Addtional  Approver" := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
                field("HR Approval"; "HR Approval")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the User ID from the list shown';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "HR Approval" := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        UserRec: Record User;
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";

}

