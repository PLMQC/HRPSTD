page 33001532 "Tour Intimation Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'Tour Intimation Setup';
    PageType = Worksheet;
    SourceTable = "TourIntimation Setup B2B";
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
                    ToolTip = 'Choose the Document Type for Tour.';
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ToolTip = 'Choose the Department from the drop down.';
                    ApplicationArea = all;
                }
                field("Department User"; "Department User")
                {
                    ToolTip = 'Choose the Dpartment user for Tour intimation.';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "Department User" := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
                field(HOD; HOD)
                {
                    ToolTip = 'Choose the Head of the Department for Tour intimation.';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        hod := LocWiseMiscGCU.OpenUserPageForSelectedUser(UserRec);
                    end;
                }
                field(Authoriser; Authoriser)
                {
                    ToolTip = 'Select the Authorise person for Tour intimation.';
                    ApplicationArea = all;
                }
                field(Approver; Approver)
                {
                    ToolTip = 'Select the Approver for the Tour Intimation.';
                    ApplicationArea = all;
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

