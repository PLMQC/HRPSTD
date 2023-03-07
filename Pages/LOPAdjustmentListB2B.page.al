page 33001540 "LOP Adjustment List B2B"
{
    // version B2BHR1.00.00

    Caption = 'LOP Adjustment List';
    CardPageID = "LOP Adj. Application B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE("Document Type" = CONST("Lop Adj"),
                            Status = CONST(Open));
    UsageCategory = Tasks;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("No."; "No.")
                {
                    ToolTip = 'Choose the No. series Defined for LOP.';
                    ApplicationArea = all;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Choose date of Creation.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Choose the month of LOP Adjustment.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Choose the year of Lop Adjustment.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Choose the Start date of the Lop.';
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ToolTip = 'Choose the End date of the Lop.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Choose the Dimension Values.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Choose the Physical Location of the Employee.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Type';
                }
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies code';
                }
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Choose the Shift code.';
                    ApplicationArea = all;
                }
                field("Permission Type"; "Permission Type")
                {
                    ToolTip = 'Choose the Permission type of LOP.';
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ToolTip = 'Shows the User Id of the Document Created.';
                    ApplicationArea = all;
                }
                field("Approved By"; "Approved By")
                {
                    ToolTip = 'Shows the person name who has approved LOP.';
                    ApplicationArea = all;
                }
                field("Mode Of Travel"; "Mode Of Travel")
                {
                    ToolTip = 'Choose the Mode of Travel.';
                    ApplicationArea = all;
                }
                field("Mode of Booking"; "Mode of Booking")
                {
                    ToolTip = 'Enter the mode of Booking.';
                    ApplicationArea = all;
                }
                field("Assignment No."; "Assignment No.")
                {
                    ToolTip = 'Enter the Assignment No.';
                    ApplicationArea = all;
                }
                field("Assignment Name"; "Assignment Name")
                {
                    ToolTip = 'Enter the Assignment Name.';
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Enter the Dimension Value.';
                    ApplicationArea = all;
                }
                field("Places To Visit"; "Places To Visit")
                {
                    ToolTip = 'Enter the Place of Visit.';
                    ApplicationArea = all;
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
                action("&Aprrove")
                {
                    ToolTip = 'Specifies the document to approve.';
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

    var
        LopAdjLines: Record "Attendance Lines B2B";
        Text001Lbl: Label 'Do you want to approve the entries';

    procedure ApproveLopAdjustment();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        TestStatus();
        CheckValidEntries();
        if CONFIRM(Text001Lbl) then
            AttApprovals.ApproveLopAdjustment(Rec);

    end;

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
}

